import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../../../app/providers.dart';
import '../../../app/theme.dart';
import '../../../core/util/format.dart';
import '../../../core/util/local_time.dart';
import '../../alarms/domain/user_alarm.dart';
import '../../ringing/ring_style.dart';
import '../../../core/scheduler/scheduler.dart';
import '../../calendar/domain/calendar_rule.dart';
import '../../events/domain/sun_times.dart';
import '../../sounds/domain/sound.dart';
import '../data/learned_phrases.dart';
import '../data/voice_log.dart';
import '../domain/alarm_ai.dart';
import '../domain/alarm_parser.dart';
import '../domain/alarm_plan.dart';
import '../domain/phrasebook.dart';
import '../domain/alarm_request.dart';
import '../domain/time_question.dart';

import 'package:quando/l10n/l10n.dart';

/// "Say or type it": a sentence becomes an alarm, on the device, with no
/// account and no server. The phone's own speech recognition turns voice
/// into text; [AlarmParser] reads the text. Nothing is saved until Save.
Future<void> showAskSheet(BuildContext context, {bool listen = false}) => showModalBottomSheet<void>(
  context: context,
  showDragHandle: true,
  isScrollControlled: true,
  builder: (_) => _AskSheet(listenAtStart: listen),
);

String anchorName(TimeAnchor a) => switch (a) {
  TimeAnchor.sunrise => l10n.sunrise,
  TimeAnchor.sunset => l10n.sunset,
  TimeAnchor.candleLighting => l10n.candleLighting,
  TimeAnchor.havdalah => l10n.havdalah,
};

String _daysLabel(Set<int> days) => UserAlarm(id: '', hour: 0, minute: 0, days: days).repeatLabel;

/// "07:30 · Weekdays", "30 min before · Sunrise · Weekdays".
String describePlan(AlarmPlan plan, String zone) => switch (plan) {
  OneOffPlan(:final at) => '${hhmm(inZone(at, zone))} · ${dayLabel(inZone(at, zone))}',
  RepeatPlan(:final hour, :final minute, :final days) =>
    '${hhmm(DateTime(2000, 1, 1, hour, minute))} · ${_daysLabel(days)}',
  RulePlan(:final anchor, :final offset, :final days) => [
    offset == Duration.zero ? l10n.atTheMoment : describeOffset(offset),
    anchorName(anchor),
    if (days.isNotEmpty) _daysLabel(days),
  ].join(' · '),
  EventPlan(:final query, :final offset) => l10n.askEventPlan(
    offset == Duration.zero ? l10n.atTheMoment : describeOffset(offset),
    query,
  ),
};

/// The alarm sound "with the radio", "with a song", "with my voice" picks.
AlarmSound? soundOfKind(String? kind, List<AlarmSound> all) => switch (kind) {
  'radio' => all.where((s) => s.isRadio).firstOrNull,
  'song' => all.where((s) => s.isLink).firstOrNull,
  'voice' => all.where((s) => !s.builtIn && !s.isRadio && !s.isLink).firstOrNull,
  'chime' || 'beep' => all.where((s) => s.builtIn && s.name.toLowerCase().contains(kind!)).firstOrNull,
  _ => null,
};

class _AskSheet extends ConsumerStatefulWidget {
  const _AskSheet({required this.listenAtStart});

  final bool listenAtStart;

  @override
  ConsumerState<_AskSheet> createState() => _AskSheetState();
}

class _AskSheetState extends ConsumerState<_AskSheet> {
  final _text = TextEditingController();
  final _speech = SpeechToText();
  bool _listening = false;
  bool? _speechOk;

  /// Morning or evening, picked on the chips for a bare "at 7".
  bool? _evening;

  /// The on-device AI's reading of [_aiFor], when the parser wasn't sure.
  AlarmRequest? _ai;
  String? _aiFor;

  /// What was on screen last, for the optional "help improve" log.
  String _lastInput = '';
  String _lastUnderstood = '';
  String _lastLang = '';
  bool _logged = false;
  late final ProviderContainer _container = ProviderScope.containerOf(context, listen: false);

  /// Sends the sentence once, only if the person turned the log on.
  void _log(String outcome) {
    if (_logged || !_container.read(voiceLogProvider)) return;
    final sample = voiceSample(
      sentence: _lastInput,
      lang: _lastLang,
      understood: _lastUnderstood,
      outcome: outcome,
    );
    if (sample == null) return;
    _logged = true;
    unawaited(_container.read(voiceLogSinkProvider).send(sample));
  }

  @override
  void initState() {
    super.initState();
    _container;
    if (widget.listenAtStart) WidgetsBinding.instance.addPostFrameCallback((_) => _listen());
  }

  @override
  void dispose() {
    _log(_lastUnderstood.isEmpty ? 'not_understood' : 'cancelled');
    unawaited(_speech.stop());
    _text.dispose();
    super.dispose();
  }

  Future<void> _listen() async {
    if (_listening) {
      await _speech.stop();
      setState(() => _listening = false);
      return;
    }
    try {
      _speechOk ??= await _speech.initialize(
        onStatus: (s) {
          if (mounted && (s == SpeechToText.doneStatus || s == SpeechToText.notListeningStatus)) {
            setState(() => _listening = false);
          }
        },
        onError: (_) {
          if (mounted) setState(() => _listening = false);
        },
      );
    } catch (_) {
      _speechOk = false;
    }
    if (!mounted) return;
    if (_speechOk != true) {
      setState(() {});
      return;
    }
    setState(() => _listening = true);
    await _speech.listen(
      onResult: (r) {
        if (!mounted) return;
        setState(() {
          _text.text = r.recognizedWords;
          _text.selection = TextSelection.collapsed(offset: _text.text.length);
        });
      },
      listenOptions: SpeechListenOptions(
        localeId: await _speechLocale(),
        listenMode: ListenMode.confirmation,
        partialResults: true,
        pauseFor: const Duration(seconds: 3),
        listenFor: const Duration(seconds: 20),
      ),
    );
  }

  /// The phone's recogniser in the app's language, if it has one.
  Future<String?> _speechLocale() async {
    final lang = ref.read(localeProvider).languageCode;
    try {
      final all = await _speech.locales();
      for (final l in all) {
        if (l.localeId.toLowerCase().split(RegExp('[-_]')).first == lang) {
          return l.localeId;
        }
        if (lang == 'he' && l.localeId.toLowerCase().startsWith('iw')) return l.localeId;
      }
    } catch (_) {}
    return null;
  }

  AlarmPlan? _plan(AlarmRequest? r) {
    if (r == null) return null;
    final place = ref.read(placeProvider);
    return planFor(
      r,
      now: ref.read(clockProvider)(),
      zone: ref.read(homeZoneProvider),
      eventsBetween: (from, to) => [
        ...SunTimes(place: place).events(from, to),
        ...ref.read(jewishTimesProvider).events(from, to),
      ],
    );
  }

  /// Answered from the user's calendars first, then Quando?'s own times.
  TimeAnswer? _answer(TimeQuestion q) {
    final now = ref.read(clockProvider)();
    final to = now.add(const Duration(days: 9));
    return answerTimeQuestion(
      q,
      now: now,
      zone: ref.read(homeZoneProvider),
      calendarEvents: ref.read(calendarProvider).events,
      builtIn: [
        ...SunTimes(place: ref.read(placeProvider)).events(now, to),
        ...ref.read(jewishTimesProvider).events(now, to),
      ],
    );
  }

  void _save(AlarmPlan plan, AlarmRequest request) {
    _lastUnderstood = request.toString();
    _log('saved');
    final id = DateTime.now().microsecondsSinceEpoch.toRadixString(36);
    final zone = ref.read(homeZoneProvider);
    final soundId = soundOfKind(request.sound, ref.read(soundsProvider))?.id;
    // "Snooze 5 minutes" belongs to this alarm only; the others keep the
    // snooze set in Settings.
    final snooze = request.snoozeMinutes;
    final options = ref.read(alarmOptionsProvider);
    final style = snooze != null && snooze > 0 && snooze <= 60
        ? RingStyle(
            snooze: SnoozePlan(minutes: snooze, times: options.maxSnoozes == 0 ? 2 : options.maxSnoozes),
          )
        : RingStyle.none;
    final h = request.hour;
    if (_evening != null && h != null) ref.read(learnedProvider.notifier).halfDay(h % 12, evening: _evening!);
    switch (plan) {
      case OneOffPlan(:final at, :final label):
        final local = inZone(at, zone);
        ref
            .read(userAlarmsProvider.notifier)
            .save(
              UserAlarm(
                id: id,
                hour: local.hour,
                minute: local.minute,
                label: label,
                soundId: soundId,
                style: style,
              ),
              at: at,
            );
      case RepeatPlan(:final hour, :final minute, :final days, :final label):
        ref
            .read(userAlarmsProvider.notifier)
            .save(
              UserAlarm(
                id: id,
                hour: hour,
                minute: minute,
                days: days,
                label: label,
                soundId: soundId,
                style: style,
              ),
            );
      case EventPlan(:final query, :final offset, :final label):
        ref
            .read(calendarRulesProvider.notifier)
            .save(
              CalendarRule(
                id: id,
                name: label.isEmpty ? query : label,
                keyword: query,
                before: [if (offset.isNegative) -offset],
                atStart: offset == Duration.zero,
                after: [if (offset > Duration.zero) offset],
                soundId: soundId,
                style: style,
              ),
            );
      case RulePlan(:final anchor, :final offset, :final days, :final label):
        ref
            .read(calendarRulesProvider.notifier)
            .save(
              CalendarRule(
                id: id,
                name: label.isEmpty ? anchorName(anchor) : label,
                keyword: anchor.query,
                includeTimes: true,
                before: [if (offset.isNegative) -offset],
                atStart: offset == Duration.zero,
                after: [if (offset > Duration.zero) offset],
                days: days,
                soundId: soundId,
                style: style,
              ),
            );
    }
    final messenger = ScaffoldMessenger.of(context);
    Navigator.pop(context);
    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(l10n.askSaved(describePlan(plan, zone)))));
  }

  /// Asks the on-device AI (if the phone has one) about a sentence the
  /// parser wasn't sure of; the answer replaces the parser's.
  void _askAi(AlarmAi ai, String input, String lang) {
    if (_aiFor == input) return;
    _aiFor = input;
    _ai = null;
    Future<void>.delayed(const Duration(milliseconds: 600), () async {
      if (!mounted || _aiFor != input) return;
      final r = await ai.read(input, lang: lang);
      if (mounted && _aiFor == input) setState(() => _ai = r);
    });
  }

  /// Alarms "turn off the 7am alarm" points at.
  List<UserAlarm> _toTurnOff(AlarmRequest r) {
    final h = r.hour;
    if (h == null && r.label.isEmpty) return const [];
    return [
      for (final a in ref.read(userAlarmsProvider))
        if (a.enabled &&
            (h == null ||
                (a.minute == r.minute && (a.hour == h || (r.halfDayUnsure && a.hour % 12 == h % 12)))) &&
            (r.label.isEmpty || a.label.toLowerCase().contains(r.label.toLowerCase())))
          a,
    ];
  }

  /// Rings "skip tomorrow", "skip the 7am on Friday" points at.
  List<ScheduledAlarm> _toSkip(AlarmRequest r) {
    final now = ref.read(clockProvider)();
    final zone = ref.read(homeZoneProvider);
    final local = inZone(now, zone);
    final skipped = ref.read(skippedProvider);
    final day = dayAsked(r, local);
    final h = r.hour;
    final all = [
      for (final a in ref.read(fullPlanProvider))
        if (!skipped.contains(a.id) && a.at.isAfter(now)) a,
    ]..sort((a, b) => a.at.compareTo(b.at));
    bool fits(ScheduledAlarm a) {
      final t = inZone(a.at, zone);
      if (day != null) {
        final d = DateTime(
          t.year,
          t.month,
          t.day,
        ).difference(DateTime(local.year, local.month, local.day)).inDays;
        if (d != day) return false;
      }
      if (h != null &&
          !(t.minute == r.minute && (t.hour == h || (r.halfDayUnsure && t.hour % 12 == h % 12)))) {
        return false;
      }
      return true;
    }

    final hits = all.where(fits).toList();
    return day == null && h == null ? hits.take(1).toList() : hits;
  }

  void _turnOff(List<UserAlarm> alarms) {
    final n = ref.read(userAlarmsProvider.notifier);
    for (final a in alarms) {
      n.toggle(a.id, false);
    }
    final what = alarms.map((a) => '${hhmm(DateTime(2000, 1, 1, a.hour, a.minute))} ${a.title}').join(', ');
    _done(l10n.askTurnedOff(what), () {
      for (final a in alarms) {
        n.toggle(a.id, true);
      }
    });
  }

  void _skip(List<ScheduledAlarm> rings) {
    final n = ref.read(skippedProvider.notifier);
    for (final a in rings) {
      n.skip(a.id, true);
    }
    final zone = ref.read(homeZoneProvider);
    final what = rings.map((a) => '${dayLabel(inZone(a.at, zone))} ${hhmm(inZone(a.at, zone))}').join(', ');
    _done(l10n.askSkipped(what), () {
      for (final a in rings) {
        n.skip(a.id, false);
      }
    });
  }

  void _done(String message, VoidCallback undo) {
    final messenger = ScaffoldMessenger.of(context);
    Navigator.pop(context);
    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          action: SnackBarAction(label: l10n.undo, onPressed: undo),
        ),
      );
  }

  /// "Teach me this": the sentence becomes a phrase for a time of day.
  Future<void> _teach(String phrase) async {
    final t = await showTimePicker(context: context, initialTime: const TimeOfDay(hour: 7, minute: 0));
    if (t == null || !mounted) return;
    ref.read(learnedProvider.notifier).teach(phrase, t.hour, t.minute);
    setState(() {});
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text(l10n.askTaught(phrase, hhmm(DateTime(2000, 1, 1, t.hour, t.minute))))),
      );
  }

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final input = _text.text.trim();
    final zone = ref.watch(homeZoneProvider);
    final lang = ref.watch(localeProvider).languageCode;
    final learned = ref.watch(learnedProvider);
    final said = learned.apply(input);
    final question = input.isEmpty ? null : readTimeQuestion(said, lang: lang);
    final reading = input.isEmpty || question != null ? null : const AlarmParser().read(said, lang: lang);
    final unsure = reading != null && reading.confidence < AlarmReading.unsure;
    AlarmRequest? request = reading == null || reading.isEmpty ? null : reading.request;

    // Not sure: the phone's own AI, if it has one, reads it too.
    final ai = ref.watch(alarmAiProvider);
    if (ai != null && reading != null && (request == null || unsure)) {
      _askAi(ai, said, lang);
      if (_aiFor == said && _ai != null) request = _ai;
    }

    // "At 7": morning or evening, as picked on the chips or learned.
    final r0 = request;
    final askHalf = r0 != null && r0.halfDayUnsure && r0.hour != null && r0.action == AlarmAction.set;
    final evening = askHalf ? _evening ?? learned.halfDay[r0.hour! % 12] : null;
    if (askHalf && evening != null) request = r0.withHalfDay(evening: evening);

    _lastInput = input;
    _lastLang = lang;
    _lastUnderstood = request?.toString() ?? '';
    final action = request?.action ?? AlarmAction.set;
    final plan = action == AlarmAction.set ? _plan(request) : null;
    final turnOff = action == AlarmAction.remove && request != null
        ? _toTurnOff(request)
        : const <UserAlarm>[];
    final skip = action == AlarmAction.skip && request != null ? _toSkip(request) : const <ScheduledAlarm>[];
    final answer = question == null ? null : _answer(question);
    final shabbatOff =
        plan is RulePlan &&
        (plan.anchor == TimeAnchor.candleLighting || plan.anchor == TimeAnchor.havdalah) &&
        !ref.watch(shabbatInUseProvider);
    final sound = soundOfKind(request?.sound, ref.watch(soundsProvider));
    final noCalendar = plan is EventPlan && !ref.watch(calendarProvider.select((c) => c.access));
    final canTeach =
        input.isNotEmpty &&
        !_listening &&
        question == null &&
        (plan == null || unsure) &&
        action == AlarmAction.set &&
        !learned.phrases.containsKey(input.toLowerCase());

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(24, 0, 24, 16 + MediaQuery.viewInsetsOf(context).bottom),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(l10n.askOption, style: text.headlineMedium),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _text,
                    autofocus: !widget.listenAtStart,
                    minLines: 1,
                    maxLines: 3,
                    textCapitalization: TextCapitalization.sentences,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(hintText: _listening ? l10n.askListening : l10n.askHint),
                    onChanged: (_) => setState(() => _evening = null),
                    onSubmitted: (_) {
                      if (plan != null) _save(plan, request!);
                    },
                  ),
                ),
                const SizedBox(width: 8),
                IconButton.filled(
                  tooltip: l10n.askMic,
                  iconSize: 28,
                  style: IconButton.styleFrom(
                    backgroundColor: _listening ? QuandoColors.coral : QuandoColors.raised,
                    minimumSize: const Size(56, 56),
                  ),
                  onPressed: _listen,
                  icon: Icon(
                    _listening ? Icons.stop_rounded : Icons.mic_none_rounded,
                    color: QuandoColors.amber,
                  ),
                ),
              ],
            ),
            if (_speechOk == false) ...[
              const SizedBox(height: 8),
              Text(l10n.askNoSpeech, style: text.bodySmall),
            ],
            // Languages first rewritten into English by the phrasebook skip
            // this: the English it read would only confuse.
            if (reading != null && reading.understood.isNotEmpty && !hasPhrasebook(lang)) ...[
              const SizedBox(height: 8),
              UnderstoodText(reading: reading, typed: input),
            ],
            const SizedBox(height: 16),
            if (question != null)
              _AnswerCard(question: question, answer: answer, zone: zone)
            else if (plan != null)
              Card(
                margin: EdgeInsets.zero,
                child: ListTile(
                  leading: Icon(
                    plan is RulePlan
                        ? Icons.wb_twilight
                        : plan is EventPlan
                        ? Icons.event
                        : Icons.alarm,
                    color: QuandoColors.amber,
                  ),
                  title: Text(describePlan(plan, zone), style: text.titleMedium),
                  subtitle:
                      [
                        if (plan.label.isNotEmpty) plan.label,
                        if (sound != null) l10n.askWakeWith(sound.name),
                        if (request?.snoozeMinutes case final n? when n > 0 && n <= 60) l10n.askSnoozeAll(n),
                      ].isEmpty
                      ? null
                      : Text(
                          [
                            if (plan.label.isNotEmpty) plan.label,
                            if (sound != null) l10n.askWakeWith(sound.name),
                            if (request?.snoozeMinutes case final n? when n > 0 && n <= 60)
                              l10n.askSnoozeAll(n),
                          ].join('\n'),
                        ),
                ),
              )
            else if (action == AlarmAction.remove || action == AlarmAction.skip)
              _MatchesCard(
                lines: [
                  for (final a in turnOff)
                    '${hhmm(DateTime(2000, 1, 1, a.hour, a.minute))} · ${a.repeats ? a.repeatLabel : l10n.once}${a.label.isEmpty ? '' : ' · ${a.label}'}',
                  for (final a in skip)
                    '${dayLabel(inZone(a.at, zone))} ${hhmm(inZone(a.at, zone))} · ${a.title}',
                ],
                icon: action == AlarmAction.remove ? Icons.alarm_off : Icons.skip_next,
              )
            else if (input.isNotEmpty && !_listening)
              Text(l10n.askNotUnderstood, style: text.bodySmall),
            if (askHalf) ...[
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                children: [
                  for (final (label, value) in [(l10n.askMorning, false), (l10n.askEvening, true)])
                    ChoiceChip(
                      label: Text(label),
                      selected: evening == value,
                      onSelected: (_) => setState(() => _evening = value),
                    ),
                ],
              ),
            ],
            if (plan != null && unsure) ...[
              const SizedBox(height: 8),
              Text(l10n.askUnsure, style: text.bodySmall),
            ],
            if (noCalendar) ...[
              const SizedBox(height: 8),
              Text(l10n.askEventNoCalendar(plan.query), style: text.bodySmall),
            ],
            if (shabbatOff) ...[const SizedBox(height: 8), Text(l10n.askShabbatOff, style: text.bodySmall)],
            if (canTeach)
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: TextButton.icon(
                  icon: const Icon(Icons.school_outlined),
                  label: Text(l10n.askTeach),
                  onPressed: () => _teach(input.toLowerCase()),
                ),
              ),
            const SizedBox(height: 16),
            if (question != null)
              FilledButton(
                style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(56)),
                onPressed: () => Navigator.pop(context),
                child: Text(l10n.done),
              )
            else if (action == AlarmAction.remove)
              FilledButton(
                style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(56)),
                onPressed: turnOff.isEmpty ? null : () => _turnOff(turnOff),
                child: Text(turnOff.isEmpty ? l10n.askNoMatch : l10n.turnOff),
              )
            else if (action == AlarmAction.skip)
              FilledButton(
                style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(56)),
                onPressed: skip.isEmpty ? null : () => _skip(skip),
                child: Text(skip.isEmpty ? l10n.askNoMatch : l10n.askSkipAction),
              )
            else
              FilledButton(
                style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(56)),
                onPressed: plan == null || noCalendar ? null : () => _save(plan, request!),
                child: Text(l10n.save),
              ),
            SwitchListTile(
              dense: true,
              contentPadding: EdgeInsets.zero,
              title: Text(l10n.askHelpTitle),
              subtitle: Text(l10n.askHelpBody),
              value: ref.watch(voiceLogProvider),
              onChanged: (v) => ref.read(voiceLogProvider.notifier).set(v),
            ),
          ],
        ),
      ),
    );
  }
}

/// The alarms or rings a "turn off" or "skip" points at.
class _MatchesCard extends StatelessWidget {
  const _MatchesCard({required this.lines, required this.icon});

  final List<String> lines;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    if (lines.isEmpty) return const SizedBox.shrink();
    return Card(
      margin: EdgeInsets.zero,
      child: Column(
        children: [
          for (final l in lines.take(4))
            ListTile(
              dense: true,
              leading: Icon(icon, color: QuandoColors.amber),
              title: Text(l),
            ),
        ],
      ),
    );
  }
}

/// The sentence with the parts that were understood lit up, so it's clear
/// what was read and what was left out. When the sentence was first
/// rewritten (another language, a taught phrase), it shows what was read.
class UnderstoodText extends StatelessWidget {
  const UnderstoodText({super.key, required this.reading, required this.typed});

  final AlarmReading reading;
  final String typed;

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.bodySmall;
    final t = reading.text;
    final spans = <TextSpan>[];
    var i = 0;
    for (final (a, b) in reading.understood) {
      if (a > i) spans.add(TextSpan(text: t.substring(i, a)));
      spans.add(
        TextSpan(
          text: t.substring(a, b),
          style: const TextStyle(color: QuandoColors.amber, fontWeight: FontWeight.w600),
        ),
      );
      i = b;
    }
    if (i < t.length) spans.add(TextSpan(text: t.substring(i)));
    final rewritten = t.trim().toLowerCase() != typed.trim().toLowerCase();
    return Text.rich(
      TextSpan(
        style: style,
        children: [
          if (rewritten) TextSpan(text: '${l10n.askReadAs}: '),
          ...spans,
        ],
      ),
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
    );
  }
}

/// "Candle lighting · Fri 13 Nov 17:52", and where the time came from.
class _AnswerCard extends ConsumerWidget {
  const _AnswerCard({required this.question, required this.answer, required this.zone});

  final TimeQuestion question;
  final TimeAnswer? answer;
  final String zone;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final text = Theme.of(context).textTheme;
    final a = answer;
    final calendarName = a?.calendarId == null
        ? null
        : ref
              .watch(calendarProvider.select((c) => c.calendars))
              .where((c) => c.id == a!.calendarId)
              .firstOrNull
              ?.name;
    return Card(
      margin: EdgeInsets.zero,
      child: ListTile(
        leading: const Icon(Icons.schedule, color: QuandoColors.amber),
        title: Text(
          a == null
              ? anchorName(question.anchor)
              : '${anchorName(question.anchor)} · ${dayLabel(inZone(a.at, zone))} ${hhmm(inZone(a.at, zone))}',
          style: text.titleMedium,
        ),
        subtitle: Text(
          a == null
              ? l10n.askNoAnswer
              : a.fromCalendar
              ? l10n.askAnswerFromCalendar(calendarName ?? a.title)
              : l10n.askAnswerBuiltIn,
        ),
      ),
    );
  }
}
