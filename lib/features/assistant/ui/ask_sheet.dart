import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../../../app/providers.dart';
import '../../../app/theme.dart';
import '../../../core/util/format.dart';
import '../../../core/util/local_time.dart';
import '../../alarms/domain/user_alarm.dart';
import '../../calendar/domain/calendar_rule.dart';
import '../../events/domain/sun_times.dart';
import '../domain/alarm_parser.dart';
import '../domain/alarm_plan.dart';
import '../domain/alarm_request.dart';

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

  @override
  void initState() {
    super.initState();
    if (widget.listenAtStart) WidgetsBinding.instance.addPostFrameCallback((_) => _listen());
  }

  @override
  void dispose() {
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
        if (l.localeId.toLowerCase().split(RegExp('[-_]')).first == (lang == 'he' ? 'he' : lang))
          return l.localeId;
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

  void _save(AlarmPlan plan) {
    final id = DateTime.now().microsecondsSinceEpoch.toRadixString(36);
    final zone = ref.read(homeZoneProvider);
    switch (plan) {
      case OneOffPlan(:final at, :final label):
        final local = inZone(at, zone);
        ref
            .read(userAlarmsProvider.notifier)
            .save(
              UserAlarm(id: id, hour: local.hour, minute: local.minute, label: label),
              at: at,
            );
      case RepeatPlan(:final hour, :final minute, :final days, :final label):
        ref
            .read(userAlarmsProvider.notifier)
            .save(UserAlarm(id: id, hour: hour, minute: minute, days: days, label: label));
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
              ),
            );
    }
    final messenger = ScaffoldMessenger.of(context);
    Navigator.pop(context);
    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(l10n.askSaved(describePlan(plan, zone)))));
  }

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final input = _text.text.trim();
    final request = input.isEmpty ? null : const AlarmParser().parse(input);
    final plan = _plan(request);
    final zone = ref.watch(homeZoneProvider);
    final shabbatOff =
        plan is RulePlan &&
        (plan.anchor == TimeAnchor.candleLighting || plan.anchor == TimeAnchor.havdalah) &&
        !ref.watch(shabbatInUseProvider);

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
                    onChanged: (_) => setState(() {}),
                    onSubmitted: (_) {
                      if (plan != null) _save(plan);
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
            const SizedBox(height: 16),
            if (plan != null)
              Card(
                margin: EdgeInsets.zero,
                child: ListTile(
                  leading: Icon(
                    plan is RulePlan ? Icons.wb_twilight : Icons.alarm,
                    color: QuandoColors.amber,
                  ),
                  title: Text(describePlan(plan, zone), style: text.titleMedium),
                  subtitle: plan.label.isEmpty ? null : Text(plan.label),
                ),
              )
            else if (input.isNotEmpty && !_listening)
              Text(l10n.askNotUnderstood, style: text.bodySmall),
            if (shabbatOff) ...[const SizedBox(height: 8), Text(l10n.askShabbatOff, style: text.bodySmall)],
            const SizedBox(height: 16),
            FilledButton(
              style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(56)),
              onPressed: plan == null ? null : () => _save(plan),
              child: Text(l10n.save),
            ),
          ],
        ),
      ),
    );
  }
}
