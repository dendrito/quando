import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../app/providers.dart';
import '../../../app/theme.dart';
import '../../../app/widgets/brand.dart';
import '../../../core/scheduler/scheduler.dart';
import '../../../core/util/format.dart';
import '../../../core/util/local_time.dart';
import '../../alarms/domain/user_alarm.dart';
import '../../calendar/domain/calendar_rule.dart';
import '../../rules/domain/alarm_rule.dart';
import '../../ready/ready_screen.dart';
import '../../shabbat/ui/shabbat_card.dart';
import '../../shabbat/ui/preparation_controls.dart';
import '../../../app/edition.dart';
import '../../shabbat/domain/hebrew_date.dart';
import '../../timezones/ui/world_clocks.dart';
import '../domain/sky.dart';
import '../../alarms/ui/group_picker.dart';
import '../domain/week.dart';
import '../../../app/widgets/tiles.dart';
import 'alarm_group_card.dart';
import '../data/home_layout_provider.dart';
import '../domain/home_layout.dart';
import 'clock_hero.dart';
import 'home_display_controls.dart';
import 'home_block_frame.dart';
import 'home_cards.dart';
import 'sky_panel.dart';
import 'learning_card.dart';
import 'place_sheet.dart';
import 'week_list.dart';
import 'week_ribbon.dart';

import '../../quotes/ui/quote_line.dart';

import 'package:quando/l10n/l10n.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  Timer? _tick;
  bool _showShabbat = true;

  /// The day picked on the week ribbon: the alarms list shows only that day.
  DateTime? _day;
  final _openGroups = <String>{};

  void _undo(String message, VoidCallback undo) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          action: SnackBarAction(label: l10n.undo, textColor: QuandoColors.ground, onPressed: undo),
        ),
      );
  }

  void _duplicate(UserAlarm a) {
    final copy = ref.read(userAlarmsProvider.notifier).duplicate(a.id);
    _undo(l10n.duplicatedNamed(a.title), () => ref.read(userAlarmsProvider.notifier).delete(copy.id));
  }

  void _delete(UserAlarm a) {
    ref.read(userAlarmsProvider.notifier).delete(a.id);
    _undo(l10n.deletedNamed(a.title), () => ref.read(userAlarmsProvider.notifier).save(a));
  }

  /// "When?": a time of day, or around events you search for.
  Future<void> _newAlarm() async {
    final choice = await showModalBottomSheet<String>(
      context: context,
      showDragHandle: true,
      builder: (context) {
        final text = Theme.of(context).textTheme;
        Widget option(String value, IconData icon, String title, String sub) => ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 6),
          leading: CircleAvatar(
            radius: 24,
            backgroundColor: QuandoColors.raised,
            child: Icon(icon, color: QuandoColors.amber),
          ),
          title: Text(title, style: text.titleLarge),
          subtitle: Text(sub, style: text.bodySmall),
          onTap: () => Navigator.pop(context, value),
        );
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 8),
                child: Text(l10n.when, style: text.headlineMedium),
              ),
              option('time', Icons.schedule, l10n.newAtTime, l10n.newAtTimeHint),
              option('event', Icons.manage_search, l10n.newAroundEvent, l10n.newAroundEventHint),
              option('ready', Icons.auto_awesome_outlined, l10n.newFromReadyMade, l10n.newFromReadyMadeHint),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
                child: Wrap(
                  spacing: 8,
                  children: [
                    TextButton.icon(
                      onPressed: () => Navigator.pop(context, 'lock'),
                      icon: const Icon(Icons.lock_outline, size: 18),
                      label: Text(l10n.lockMode),
                    ),
                    TextButton.icon(
                      onPressed: () => Navigator.pop(context, 'calendars'),
                      icon: const Icon(Icons.event_outlined, size: 18),
                      label: Text(l10n.calendars),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
    if (!mounted) return;
    if (choice == 'time') context.push('/alarm/new');
    if (choice == 'event') context.push('/calendar/rule/new');
    if (choice == 'lock') context.push('/lock');
    if (choice == 'calendars') context.push('/calendar');
    if (choice == 'ready') await _readyMade();
  }

  /// Ready-made alarms (sunrise, sunset and, once Shabbat is on, the Shabbat ones):
  /// turn one on, or tap it to change its times.
  Future<void> _readyMade() => showModalBottomSheet<void>(
    context: context,
    showDragHandle: true,
    isScrollControlled: true,
    builder: (context) => Consumer(
      builder: (context, ref, _) {
        final text = Theme.of(context).textTheme;
        final hidden = ref.read(rulesProvider.notifier).hidden;
        final shabbat = ref.watch(shabbatInUseProvider);
        final rules = [
          for (final r in ref.watch(rulesProvider))
            if (!hidden.contains(r.id) && (shabbat || r.id == 'preset.sunrise' || r.id == 'preset.sunset')) r,
        ];
        return SafeArea(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: MediaQuery.sizeOf(context).height * 0.8),
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
              children: [
                Text(l10n.newFromReadyMade, style: text.headlineMedium),
                const SizedBox(height: 4),
                const SizedBox(height: 12),
                for (final r in rules) ...[
                  RuleTile(
                    title: r.name,
                    subtitle: timesLabel(r.offsets()),
                    on: r.enabled,
                    onTap: () {
                      Navigator.pop(context);
                      this.context.push('/preset/${r.id}');
                    },
                    onToggle: (v) => ref.read(rulesProvider.notifier).toggle(r.id, v),
                  ),
                  const SizedBox(height: 8),
                ],
              ],
            ),
          ),
        );
      },
    ),
  );

  /// Tapping one alarm in the week: skip it once, or change what set it.
  Future<void> _alarmActions(ScheduledAlarm a) => _actions([a]);

  /// What set an alarm: one of your alarms, a preset, or a calendar rule.
  _Source? _sourceOf(ScheduledAlarm a) {
    final rid = a.ruleId.startsWith('gentle.') ? a.ruleId.substring(7) : a.ruleId;
    if (rid.startsWith('user.')) {
      final u = ref.read(userAlarmsProvider).where((u) => u.id == rid.substring(5)).firstOrNull;
      return u == null ? null : _Source(rid, u.title, u.enabled, user: u);
    }
    if (rid.startsWith('preset.')) {
      final p = ref.read(rulesProvider).where((r) => r.id == rid).firstOrNull;
      return p == null ? null : _Source(rid, p.name, p.enabled, preset: p);
    }
    if (rid.startsWith('cal.')) {
      final c = ref.read(calendarRulesProvider).where((r) => r.id == rid.split('.')[1]).firstOrNull;
      return c == null ? null : _Source('cal.${c.id}', c.title, c.enabled, cal: c);
    }
    return null;
  }

  /// Everything you can do from the week list, for one alarm or a whole
  /// row: skip, turn off, edit, duplicate, group, remove a time, delete.
  /// A row can hold alarms from several rules; each gets its own actions.
  Future<void> _actions(List<ScheduledAlarm> alarms) async {
    final a = alarms.first;
    final one = alarms.length == 1;
    final skippedNow = ref.read(skippedProvider);
    final allSkipped = alarms.every((x) => skippedNow.contains(x.id));
    final home = ref.read(homeZoneProvider);
    final at = inZone(a.at, home);
    final sources = <String, _Source>{for (final s in alarms.map(_sourceOf).nonNulls) s.key: s}.values
        .toList();
    final several = sources.length > 1;
    // One time out of a preset's several, e.g. "2 hours before".
    final p = one ? sources.firstOrNull?.preset : null;
    final canDropTime =
        p != null &&
        !a.ruleId.startsWith('gentle.') &&
        p.offsets().length > 1 &&
        p.offsets().contains(a.offset);

    final choice = await showModalBottomSheet<String>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (context) {
        final text = Theme.of(context).textTheme;
        Widget item(String value, IconData icon, String title, {bool danger = false}) => ListTile(
          leading: Icon(icon, color: danger ? QuandoColors.coral : null),
          title: Text(title, style: danger ? const TextStyle(color: QuandoColors.coral) : null),
          onTap: () => Navigator.pop(context, value),
        );
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          one
                              ? '${dayLabel(at)} · ${hhmm(at)}'
                              : '${dayLabel(at)} · ${l10n.alarmCount(alarms.length)} · '
                                    '${l10n.timeToTime(hhmm(at), hhmm(inZone(alarms.last.at, home)))}',
                          style: text.labelSmall,
                        ),
                        const SizedBox(height: 4),
                        Text(a.title, style: text.headlineSmall),
                        if (one) Text(a.body, style: text.bodyMedium?.copyWith(color: QuandoColors.muted)),
                      ],
                    ),
                  ),
                  item(
                    'skip',
                    allSkipped ? Icons.alarm_on : Icons.alarm_off,
                    one
                        ? (allSkipped ? l10n.ringThisOneAfterAll : l10n.skipJustThisOne)
                        : (allSkipped ? l10n.ringTheseAfterAll : l10n.skipTheseDay(alarms.length)),
                  ),
                  if (canDropTime)
                    item('drop', Icons.timer_off_outlined, l10n.removeTimeFrom(a.body, p.name)),
                  for (final (i, s) in sources.indexed) ...[
                    if (several) ...[
                      const Divider(indent: 16, endIndent: 16),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 4, 16, 0),
                        child: Text(s.name, style: text.labelSmall),
                      ),
                    ],
                    item(
                      'toggle:$i',
                      s.on ? Icons.toggle_off_outlined : Icons.toggle_on_outlined,
                      s.on ? l10n.turnOffNamed(s.name) : l10n.turnOnNamed(s.name),
                    ),
                    item(
                      'edit:$i',
                      Icons.edit_outlined,
                      s.user != null
                          ? l10n.editThisAlarm
                          : s.cal != null
                          ? l10n.editThisCalendarRule
                          : l10n.editNamed(s.name),
                    ),
                    if (s.user != null || s.cal != null) item('copy:$i', Icons.copy, l10n.duplicate),
                    if (s.user case final u?)
                      item(
                        'group:$i',
                        Icons.folder_outlined,
                        u.group.isEmpty ? l10n.moveToGroup : l10n.inGroupMove(u.group),
                      ),
                    item('delete:$i', Icons.delete_outline, l10n.deleteNamed(s.name), danger: true),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
    if (!mounted || choice == null) return;
    final [what, ...rest] = choice.split(':');
    final s = rest.isEmpty ? null : sources[int.parse(rest.single)];
    switch (what) {
      case 'skip':
        for (final x in alarms) {
          ref.read(skippedProvider.notifier).skip(x.id, !allSkipped);
        }
      case 'drop':
        final before = p!.offsets();
        ref.read(rulesProvider.notifier).edit(p.id, (r) => r.withOffsets(before.where((d) => d != a.offset)));
        _undo(
          l10n.removedTimeFrom(a.body, p.name),
          () => ref.read(rulesProvider.notifier).edit(p.id, (r) => r.withOffsets(before)),
        );
      case 'toggle':
        s!.set(ref, !s.on);
        if (s.on) _undo(l10n.turnedOffNamed(s.name), () => s.set(ref, true));
      case 'edit':
        context.push(s!.editPath);
      case 'copy':
        if (s!.user case final u?) _duplicate(u);
        if (s.cal case final c?) {
          final copy = CalendarRule.fromJson({
            ...c.toJson(),
            'id': DateTime.now().microsecondsSinceEpoch.toRadixString(36),
          });
          ref.read(calendarRulesProvider.notifier).save(copy);
          _undo(
            l10n.duplicatedNamed(c.title),
            () => ref.read(calendarRulesProvider.notifier).delete(copy.id),
          );
        }
      case 'group':
        final u = s!.user!;
        final g = await pickGroup(
          context,
          groups: ref.read(userAlarmsProvider.notifier).groups,
          current: u.group,
        );
        if (g == null || g == u.group || !mounted) return;
        ref.read(userAlarmsProvider.notifier).save(u.copyWith(group: g));
        _undo(
          g.isEmpty ? l10n.noGroup : l10n.movedToGroup(g),
          () => ref.read(userAlarmsProvider.notifier).save(u),
        );
      case 'delete':
        if (s!.user case final u?) _delete(u);
        if (s.cal case final c?) {
          ref.read(calendarRulesProvider.notifier).delete(c.id);
          _undo(l10n.deletedNamed(c.title), () => ref.read(calendarRulesProvider.notifier).save(c));
        }
        if (s.preset case final r?) {
          ref.read(rulesProvider.notifier).hide(r.id);
          _undo(l10n.deletedNamed(r.name), () {
            ref.read(rulesProvider.notifier).restore(r.id);
            if (!r.enabled) ref.read(rulesProvider.notifier).toggle(r.id, false);
          });
        }
    }
  }

  Future<void> _renameGroup(String from) async {
    final name = await askGroupName(context, title: l10n.renameGroup, initial: from);
    if (name == null || name == from) return;
    ref.read(userAlarmsProvider.notifier).renameGroup(from, name);
    setState(() => _openGroups.remove(from));
  }

  @override
  void initState() {
    super.initState();
    // Keep the countdown and the sky moving.
    _tick = Timer.periodic(const Duration(seconds: 30), (_) {
      final state = WidgetsBinding.instance.lifecycleState;
      if (mounted && (state == null || state == AppLifecycleState.resumed)) setState(() {});
    });
  }

  @override
  void dispose() {
    _tick?.cancel();
    super.dispose();
  }

  /// One tap alarms: "in 20 min", "at sunset".
  void _quick(DateTime at, String label) {
    final home = ref.read(homeZoneProvider);
    final local = inZone(at, home);
    ref
        .read(userAlarmsProvider.notifier)
        .save(
          UserAlarm(
            id: DateTime.now().microsecondsSinceEpoch.toRadixString(36),
            hour: local.hour,
            minute: local.minute,
            label: label,
          ),
        );
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(l10n.quickSet(label, hhmm(local)))));
  }

  /// Colour key of an alarm's dot on the week ribbon: its group, or 'e' for events and Shabbat.
  String _dotOf(ScheduledAlarm a) {
    if (!a.ruleId.startsWith('user.')) return 'e';
    final id = a.ruleId.substring(5);
    for (final u in ref.read(userAlarmsProvider)) {
      if (u.id == id) return 'g:${u.group}';
    }
    return 'g:';
  }

  /// The alarms of the day picked on the ribbon: yours, events and Shabbat alike.
  Widget _dayList(DateTime now, String home) {
    final text = Theme.of(context).textTheme;
    final day = _day!;
    bool onDay(ScheduledAlarm a) {
      final l = inZone(a.at, home);
      return l.year == day.year && l.month == day.month && l.day == day.day;
    }

    final plan = [
      for (final a in ref.watch(fullPlanProvider))
        if (a.ruleId != 'lock' && onDay(a)) a,
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Align(
          alignment: AlignmentDirectional.centerEnd,
          child: TextButton.icon(
            onPressed: () => setState(() => _day = null),
            icon: const Icon(Icons.close, size: 18),
            label: Text(l10n.showAllAlarms),
          ),
        ),
        if (plan.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Text(l10n.noAlarmsThatDay, style: text.bodySmall),
          )
        else
          WeekList(
            days: weekPlan(plan, home),
            today: inZone(now, home),
            zone: home,
            skipped: ref.watch(skippedProvider),
            onTap: _alarmActions,
            onSeries: (s) => _actions(s.alarms),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final place = ref.watch(placeProvider);
    final plan = ref.watch(planProvider);
    final period = ref.watch(nextPeriodProvider);
    final eventRules = ref.watch(calendarRulesProvider);
    final mine = ref.watch(userAlarmsProvider);
    final now = ref.watch(clockProvider)();
    final text = Theme.of(context).textTheme;
    final home = ref.watch(homeZoneProvider);
    final skyPlace = ref.watch(skyPlaceProvider);
    final sky = skyPlace == null ? SkyDay(now: now) : SkyDay.of(skyPlace, now);
    final display = ref.watch(homeDisplayProvider);
    // A day picked on the ribbon stops applying once it is over.
    if (_day != null) {
      final t = inZone(now, home);
      if (_day!.isBefore(DateTime(t.year, t.month, t.day))) _day = null;
    }

    // Shabbat times in the Shabbat city's clock; everything else in yours.
    String cityTime(DateTime utc) => hhmm(inZone(utc, place.timeZone));
    String cityDay(DateTime utc) => dayLabel(inZone(utc, place.timeZone));
    String local(DateTime utc) => hhmm(inZone(utc, home));
    String day(DateTime utc) => dayLabel(inZone(utc, home));

    final upcoming = plan.where((a) => a.at.isAfter(now) && a.ruleId != 'lock').toList();
    final next = upcoming.firstOrNull;
    final nextSunset = sky.nextSunset;

    // ---- Shabbat ---- (first thing on the screen in Quando? Shabbat)
    final shabbat = <Widget>[
      if (period != null) ...[
        ShabbatCard(
          onTap: () => context.push('/shabbat'),
          title: period.contains(now) ? l10n.shabbatModeIsOn : l10n.nextInCity(place.name.toUpperCase()),
          names: period.names.join(' · '),
          rows: [
            ShabbatTimeRow(
              label: l10n.candleLighting,
              day: cityDay(period.start),
              time: cityTime(period.start),
            ),
            ShabbatTimeRow(label: l10n.havdalah, day: cityDay(period.end), time: cityTime(period.end)),
          ],
        ),
        const SizedBox(height: 16),
      ] else ...[
        OutlinedButton.icon(
          onPressed: () => context.push('/shabbat'),
          icon: const Icon(Icons.local_fire_department_outlined),
          label: Text(l10n.shabbatAndFestivals),
        ),
        const SizedBox(height: 16),
      ],
    ];

    final layout = ref.watch(homeLayoutProvider);
    final inLists = !jewishHome || !_showShabbat;
    bool showing(HomeBlock b) => switch (b) {
      HomeBlock.clock || HomeBlock.next || HomeBlock.sky => true,
      HomeBlock.shabbatMode => jewishHome,
      HomeBlock.shabbat => !jewishHome && ref.watch(shabbatInUseProvider) && inLists,
      HomeBlock.events => inLists && eventRules.isNotEmpty,
      _ => inLists,
    };
    final visible = [
      for (final b in layout.order)
        if (showing(b) && !layout.of(b).hidden) b,
    ];
    final hiddenCards = [
      for (final b in layout.order)
        if (showing(b) && layout.of(b).hidden) b,
    ];
    String titleOf(HomeBlock b) => switch (b) {
      HomeBlock.clock => l10n.homeBlockClock,
      HomeBlock.next =>
        next == null ? l10n.nextAlarmHeading : l10n.nextAlarmLine(next.title, local(next.at)).toUpperCase(),
      HomeBlock.ribbon => l10n.thisWeekHeading,
      HomeBlock.sky => l10n.homeBlockSky,
      HomeBlock.shabbatMode || HomeBlock.shabbat => l10n.homeBlockShabbat,
      HomeBlock.timers => l10n.timersTitle.toUpperCase(),
      HomeBlock.alarms => l10n.yourAlarmsHeading,
      HomeBlock.events => l10n.aroundEventsHeading,
      HomeBlock.world => l10n.worldClocksHeading,
    };
    Widget contentOf(HomeBlock b) => switch (b) {
      HomeBlock.clock => ClockHero(now: ref.watch(clockProvider), zone: home),
      HomeBlock.next => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              next == null
                  ? l10n.nothingSet
                  // Far away reads better as a clock time than as a long countdown.
                  : next.at.difference(now) > const Duration(hours: 12)
                  ? l10n.atClock(local(next.at))
                  : countdown(next.at.difference(now)),
              style: text.displayMedium?.copyWith(fontSize: 72),
            ),
          ),
          // A reminder ahead of an event says so ("6 hours before"); the day is
          // only named when it is not today. The name and time are in the title.
          if (next != null && (next.offset != Duration.zero || day(next.at) != day(now)))
            Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Text(
                [
                  if (next.offset != Duration.zero) describeOffset(next.offset),
                  if (day(next.at) != day(now)) day(next.at),
                ].join(' · '),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: text.bodyMedium?.copyWith(color: const Color(0xFFF7DCD0)),
              ),
            ),
          const SizedBox(height: 6),
          QuoteLine(now: now, idle: next == null, oneLine: true),
        ],
      ),
      HomeBlock.sky => SkyPanel(
        sky: sky,
        marks: [
          for (final a in upcoming)
            if (sky.at(a.at) case final t? when t >= 0 && t <= 1) t,
        ],
      ),
      HomeBlock.shabbatMode => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (jewishHome) LearningCard(now: now),
          if (jewishHome) ...[
            SegmentedButton<bool>(
              segments: [
                ButtonSegment(value: true, label: Text(l10n.shabbat)),
                ButtonSegment(value: false, label: Text(l10n.allAlarms)),
              ],
              selected: {_showShabbat},
              onSelectionChanged: (v) => setState(() => _showShabbat = v.first),
            ),
            const SizedBox(height: 16),
            if (_showShabbat) ...[
              const PreparationActions(),
              ...shabbat,
              const PreparationControls(showActions: false),
            ],
          ],
        ],
      ),
      HomeBlock.shabbat => Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: shabbat),
      HomeBlock.timers => const _TimerTiles(),
      HomeBlock.ribbon => WeekRibbon(
        days: weekRibbon(
          plan: [
            for (final a in ref.watch(fullPlanProvider))
              if (a.ruleId != 'lock' && !ref.watch(skippedProvider).contains(a.id)) a,
          ],
          now: now,
          zone: home,
          dotOf: _dotOf,
          holyDays: ref.watch(shabbatInUseProvider)
              ? [for (final p in ref.watch(periodsProvider)) (p.start, p.end)]
              : const [],
        ),
        selected: _day,
        onSelect: (d) => setState(() => _day = d),
      ),
      HomeBlock.alarms when _day != null => _dayList(now, home),
      HomeBlock.alarms => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (mine.isEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(l10n.tapWhenToAdd, style: text.bodySmall),
            ),
          for (final a in mine.where((a) => a.group.isEmpty)) ...[
            SwipeToDelete(
              id: 'user.${a.id}',
              onDelete: () {
                ref.read(userAlarmsProvider.notifier).delete(a.id);
                _undo(l10n.deletedNamed(a.title), () => ref.read(userAlarmsProvider.notifier).save(a));
              },
              child: _AlarmCard(
                alarm: a,
                onTap: () => context.push('/alarm/${a.id}'),
                onToggle: (v) => ref.read(userAlarmsProvider.notifier).toggle(a.id, v),
                onDuplicate: () => _duplicate(a),
                onDelete: () => _delete(a),
              ),
            ),
            const SizedBox(height: 10),
          ],
          for (final g in ref.read(userAlarmsProvider.notifier).groups) ...[
            AlarmGroupCard(
              name: g,
              alarms: [
                for (final a in mine)
                  if (a.group == g) a,
              ],
              open: _openGroups.contains(g),
              onOpen: () =>
                  setState(() => _openGroups.contains(g) ? _openGroups.remove(g) : _openGroups.add(g)),
              onToggleAll: (v) => ref.read(userAlarmsProvider.notifier).toggleGroup(g, v),
              onRename: () => _renameGroup(g),
              alarmCard: (a) => _AlarmCard(
                alarm: a,
                flat: true,
                onTap: () => context.push('/alarm/${a.id}'),
                onToggle: (v) => ref.read(userAlarmsProvider.notifier).toggle(a.id, v),
                onDuplicate: () => _duplicate(a),
                onDelete: () => _delete(a),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ],
      ),
      HomeBlock.events => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (final r in eventRules) ...[
            SwipeToDelete(
              id: 'cal.${r.id}',
              onDelete: () {
                ref.read(calendarRulesProvider.notifier).delete(r.id);
                _undo(l10n.deletedNamed(r.title), () => ref.read(calendarRulesProvider.notifier).save(r));
              },
              child: RuleTile(
                title: r.title,
                subtitle: [
                  timesLabel(r.toAlarmRules().expand((a) => a.offsets()).toSet().toList()..sort()),
                  if (r.keyword.isNotEmpty && r.name.isNotEmpty) l10n.searchFor(r.keyword),
                ].join(' · '),
                on: r.enabled,
                onTap: () => context.push('/calendar/rule/${r.id}'),
                onToggle: (v) => ref.read(calendarRulesProvider.notifier).toggle(r.id, v),
              ),
            ),
            const SizedBox(height: 8),
          ],
        ],
      ),
      HomeBlock.world => const WorldClocks(),
    };
    final layoutNotifier = ref.read(homeLayoutProvider.notifier);
    Widget frameOf(HomeBlock b, {required bool canWiden}) => HomeBlockFrame(
      block: b,
      title: titleOf(b),
      state: layout.of(b),
      height: layout.heightOf(b),
      width: layout.widthOf(b),
      canWiden: canWiden,
      color: b == HomeBlock.clock
          ? Colors.transparent
          : const {HomeBlock.next, HomeBlock.sky}.contains(b)
          ? sky.color
          : null,
      onChanged: (s) => layoutNotifier.setBlock(b, s),
      onHeight: (v) => layoutNotifier.setBlock(b, ref.read(homeLayoutProvider).of(b).copyWith(height: v)),
      onWidth: (v) => layoutNotifier.setBlock(b, ref.read(homeLayoutProvider).of(b).copyWith(width: v)),
      // The alarms list is what the app is for, so it always stays.
      onHide: b == HomeBlock.alarms ? null : () => layoutNotifier.hide(b),
      child: contentOf(b),
    );
    final blocks = <Widget>[
      if (!ref.watch(homeLayoutHintSeenProvider))
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
          child: Material(
            color: QuandoColors.amber.withValues(alpha: .16),
            borderRadius: BorderRadius.circular(18),
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(16, 10, 8, 10),
              child: Row(
                children: [
                  const Icon(Icons.open_with, size: 20),
                  const SizedBox(width: 12),
                  Expanded(child: Text(l10n.homeLayoutHint, style: text.bodySmall)),
                  TextButton(
                    onPressed: ref.read(homeLayoutHintSeenProvider.notifier).dismiss,
                    child: Text(l10n.homeLayoutHintDismiss),
                  ),
                ],
              ),
            ),
          ),
        ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: HomeCards(
          blocks: visible,
          widthOf: layout.widthOf,
          titleOf: titleOf,
          builder: frameOf,
          onMove: (from, to) => layoutNotifier.move(visible, from, to),
        ),
      ),
      if (hiddenCards.isNotEmpty)
        Align(
          child: PopupMenuButton<HomeBlock>(
            onSelected: layoutNotifier.unhide,
            itemBuilder: (_) => [
              for (final b in hiddenCards) PopupMenuItem(value: b, child: Text(titleOf(b))),
            ],
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Text(l10n.homeHiddenCards(hiddenCards.length), style: text.labelLarge),
            ),
          ),
        ),
    ];

    return Scaffold(
      bottomNavigationBar: _WhenDock(
        onWhen: _newAlarm,
        chips: [
          for (final m in const [10, 60])
            (
              label: m < 60 ? l10n.inMinutes(m) : l10n.inOneHour,
              onTap: () => _quick(
                DateTime.now().toUtc().add(Duration(minutes: m)),
                m < 60 ? l10n.inMinutes(m) : l10n.inOneHour,
              ),
            ),
          if (nextSunset != null) (label: l10n.atSunset, onTap: () => _quick(nextSunset, l10n.sunset)),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          // ---- The living sky ----
          AnimatedContainer(
            duration: const Duration(seconds: 2),
            color: sky.color,
            padding: EdgeInsets.fromLTRB(24, MediaQuery.paddingOf(context).top + 12, 12, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const QMark(size: 30),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        appTitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: text.titleLarge?.copyWith(fontSize: 23),
                      ),
                    ),
                    IconButton(
                      tooltip: l10n.homeDisplay,
                      icon: const Icon(Icons.wb_twilight),
                      onPressed: () => showHomeDisplayControls(context),
                    ),
                    IconButton(
                      tooltip: l10n.timersTitle,
                      icon: const Icon(Icons.timer_outlined),
                      onPressed: () => context.push('/timers'),
                    ),
                    IconButton(
                      tooltip: l10n.settings,
                      icon: const Icon(Icons.tune),
                      onPressed: () => context.push('/settings'),
                    ),
                  ],
                ),
                // Where the sky and the times are for; tap to change.
                const Padding(
                  padding: EdgeInsets.only(left: 40, top: 2),
                  child: Align(alignment: AlignmentDirectional.centerStart, child: PlacePill()),
                ),
                // Quando? Shabbat: the Hebrew date and this week's parasha.
                if (jewishHome || display.parasha)
                  Builder(
                    builder: (context) {
                      final local = inZone(now, place.timeZone);
                      final jewishSun = SkyDay.of(place, now);
                      final afterSunset = jewishSun.sunset != null && now.isAfter(jewishSun.sunset!);
                      final (date, parasha) = hebrewDate(
                        local,
                        inIsrael: place.inIsrael,
                        afterSunset: afterSunset,
                        hebrew: l10n.localeName == 'he',
                        names: display.hebrewNames,
                      );
                      final link = parashaSefaria(local, inIsrael: place.inIsrael, afterSunset: afterSunset);
                      return Padding(
                        padding: const EdgeInsets.only(top: 4, left: 40),
                        child: Wrap(
                          spacing: 6,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            if (jewishHome)
                              Text(date, style: text.bodyMedium?.copyWith(color: QuandoColors.blush)),
                            if (display.parasha)
                              Tooltip(
                                message: l10n.openParashaSefaria,
                                child: TextButton(
                                  onPressed: link == null
                                      ? null
                                      : () => launchUrl(link, mode: LaunchMode.externalApplication),
                                  style: TextButton.styleFrom(
                                    foregroundColor: QuandoColors.blush,
                                    padding: EdgeInsets.zero,
                                    minimumSize: const Size(0, 32),
                                  ),
                                  child: Text(
                                    parasha.isNotEmpty ? l10n.weeklyParasha(parasha) : l10n.festivalReading,
                                  ),
                                ),
                              ),
                            if (kodesh)
                              Text(
                                l10n.poweredBy(l10n.appName),
                                style: text.bodyMedium?.copyWith(color: QuandoColors.blush),
                              ),
                          ],
                        ),
                      );
                    },
                  ),
                if (display.roshHodesh)
                  Builder(
                    builder: (context) {
                      final local = inZone(now, place.timeZone), jewishSun = SkyDay.of(place, now);
                      final date = RoshHodeshDate.next(
                        local,
                        afterSunset: jewishSun.sunset != null && now.isAfter(jewishSun.sunset!),
                        hebrew: l10n.localeName == 'he',
                        names: display.hebrewNames,
                      );
                      final days = date.first == date.last
                          ? dayLabel(date.first)
                          : '${dayLabel(date.first)} – ${dayLabel(date.last)}';
                      return Padding(
                        padding: const EdgeInsets.only(top: 8, left: 40),
                        child: Text(
                          '${l10n.roshHodeshNext} · ${date.month}\n$days · ${l10n.roshHodeshBegins} ${dayLabel(date.begins)}',
                          style: text.bodySmall?.copyWith(color: QuandoColors.blush),
                        ),
                      );
                    },
                  ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // ---- Something stops alarms from ringing ----
                if ((ref.watch(readinessProvider).value?.values.where((ok) => !ok).length ?? 0) > 0) ...[
                  Material(
                    color: QuandoColors.coral,
                    borderRadius: BorderRadius.circular(20),
                    child: ListTile(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      leading: const Icon(Icons.warning_amber_rounded, color: QuandoColors.ground),
                      title: Text(
                        l10n.alarmsMayNotRing,
                        style: TextStyle(color: QuandoColors.ground, fontWeight: FontWeight.w700),
                      ),
                      subtitle: Text(l10n.tapToFixIt, style: TextStyle(color: QuandoColors.ground)),
                      trailing: const Icon(Icons.chevron_right, color: QuandoColors.ground),
                      onTap: () => context.push('/ready'),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ],
            ),
          ),
          ...blocks,
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 4, 24, 24),
            child: Text(l10n.alarmsSetThemselves, style: text.bodySmall),
          ),
        ],
      ),
    );
  }
}

/// The bar docked to the bottom: quick times as chips and the big "When?" button.
class _WhenDock extends StatelessWidget {
  const _WhenDock({required this.chips, required this.onWhen});

  final List<({String label, VoidCallback onTap})> chips;
  final VoidCallback onWhen;

  @override
  Widget build(BuildContext context) => Material(
    color: QuandoColors.surface,
    elevation: 8,
    shadowColor: Colors.black,
    borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
    child: SafeArea(
      top: false,
      child: Center(
        heightFactor: 1,
        child: ConstrainedBox(
          // On a Mac or iPad window the bar stops at a comfortable width.
          constraints: const BoxConstraints(maxWidth: 560),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
            child: Row(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        for (final c in chips)
                          Padding(
                            padding: const EdgeInsetsDirectional.only(end: 6),
                            child: ActionChip(
                              label: Text(c.label, style: const TextStyle(fontSize: 13)),
                              onPressed: c.onTap,
                              labelPadding: const EdgeInsets.symmetric(horizontal: 2),
                              visualDensity: VisualDensity.compact,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                FilledButton.icon(
                  onPressed: onWhen,
                  icon: const Icon(Icons.add, size: 24),
                  label: Text(l10n.when),
                  style: FilledButton.styleFrom(
                    minimumSize: const Size(0, 52),
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    shape: const StadiumBorder(),
                    shadowColor: QuandoColors.coral,
                    elevation: 6,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

class _AlarmCard extends StatelessWidget {
  const _AlarmCard({
    required this.alarm,
    required this.onTap,
    required this.onToggle,
    required this.onDuplicate,
    required this.onDelete,
    this.flat = false,
  });

  final UserAlarm alarm;

  /// Inside a group card: no card of its own.
  final bool flat;
  final VoidCallback onTap;
  final ValueChanged<bool> onToggle;
  final VoidCallback onDuplicate;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final on = alarm.enabled;
    return Material(
      color: flat ? Colors.transparent : QuandoColors.surface,
      borderRadius: const BorderRadius.all(Radius.circular(28)),
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(28)),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 14, 14, 14),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      hhmm(DateTime(2000, 1, 1, alarm.hour, alarm.minute)),
                      style: text.displaySmall?.copyWith(
                        fontSize: 42,
                        height: 1,
                        color: on ? QuandoColors.text : QuandoColors.faint,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${alarm.title} · ${alarm.repeatLabel}',
                      style: text.bodyMedium?.copyWith(color: on ? QuandoColors.muted : QuandoColors.faint),
                    ),
                    if (alarm.zone != null) ...[
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: const BoxDecoration(
                          color: QuandoColors.raised,
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                        child: Text(
                          l10n.cityTime(cityOf(alarm.zone!)),
                          style: text.bodySmall?.copyWith(color: QuandoColors.blush),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              Switch(value: on, onChanged: onToggle),
              PopupMenuButton<String>(
                tooltip: l10n.more,
                icon: const Icon(Icons.more_vert, color: QuandoColors.muted),
                onSelected: (v) => switch (v) {
                  'toggle' => onToggle(!on),
                  'copy' => onDuplicate(),
                  _ => onDelete(),
                },
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 'toggle',
                    child: ListTile(
                      leading: Icon(on ? Icons.alarm_off : Icons.alarm_on),
                      title: Text(on ? l10n.turnOff : l10n.turnOn),
                    ),
                  ),
                  PopupMenuItem(
                    value: 'copy',
                    child: ListTile(leading: const Icon(Icons.copy), title: Text(l10n.duplicate)),
                  ),
                  PopupMenuItem(
                    value: 'delete',
                    child: ListTile(leading: const Icon(Icons.delete_outline), title: Text(l10n.delete)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// One thing that sets alarms, as the week list's actions see it.
class _Source {
  const _Source(this.key, this.name, this.on, {this.user, this.preset, this.cal});

  final String key;
  final String name;
  final bool on;
  final UserAlarm? user;
  final AlarmRule? preset;
  final CalendarRule? cal;

  String get editPath => user != null
      ? '/alarm/${user!.id}'
      : cal != null
      ? '/calendar/rule/${cal!.id}'
      : '/preset/${preset!.id}';

  void set(WidgetRef ref, bool v) {
    if (user != null) ref.read(userAlarmsProvider.notifier).toggle(user!.id, v);
    if (preset != null) ref.read(rulesProvider.notifier).toggle(preset!.id, v);
    if (cal != null) ref.read(calendarRulesProvider.notifier).toggle(cal!.id, v);
  }
}

/// Three big buttons to the stopwatch, the timer and the start sequence.
class _TimerTiles extends StatelessWidget {
  const _TimerTiles();

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    Widget tile(int tab, IconData icon, String title, String subtitle) => Expanded(
      child: Material(
        color: QuandoColors.surface,
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () => context.push('/timers?tab=$tab'),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 14, 12, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(icon, color: QuandoColors.amber, size: 28),
                const SizedBox(height: 8),
                Text(title, maxLines: 1, overflow: TextOverflow.ellipsis, style: text.titleMedium),
                Text(subtitle, maxLines: 2, overflow: TextOverflow.ellipsis, style: text.bodySmall),
              ],
            ),
          ),
        ),
      ),
    );
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          tile(0, Icons.timer_outlined, l10n.timerStopwatch, l10n.timerStopwatchSub),
          const SizedBox(width: 10),
          tile(1, Icons.hourglass_bottom, l10n.timerCountdown, l10n.timerCountdownSub),
          const SizedBox(width: 10),
          tile(2, Icons.flag_outlined, l10n.timerSequence, l10n.timerSequenceSub),
        ],
      ),
    );
  }
}
