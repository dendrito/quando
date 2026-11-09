import 'dart:async';
import 'dart:math' show min;

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
import 'clock_hero.dart';
import '../domain/home_display.dart';
import '../domain/home_grid.dart';
import '../data/home_grid_provider.dart';
import 'home_grid_view.dart';
import 'home_tool_cards.dart';
import 'sky_panel.dart';
import 'learning_card.dart';
import 'week_list.dart';

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
  bool _arranging = false;
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
              const SizedBox(height: 12),
            ],
          ),
        );
      },
    );
    if (!mounted) return;
    if (choice == 'time') context.push('/alarm/new');
    if (choice == 'event') context.push('/calendar/rule/new');
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
    final sources = <String, _Source>{for (final s in alarms.map(_sourceOf).nonNulls) s.key: s}.values.toList();
    final several = sources.length > 1;
    // One time out of a preset's several, e.g. "2 hours before".
    final p = one ? sources.firstOrNull?.preset : null;
    final canDropTime =
        p != null && !a.ruleId.startsWith('gentle.') && p.offsets().length > 1 && p.offsets().contains(a.offset);

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
                  if (canDropTime) item('drop', Icons.timer_off_outlined, l10n.removeTimeFrom(a.body, p.name)),
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
          _undo(l10n.duplicatedNamed(c.title), () => ref.read(calendarRulesProvider.notifier).delete(copy.id));
        }
      case 'group':
        final u = s!.user!;
        final g = await pickGroup(context, groups: ref.read(userAlarmsProvider.notifier).groups, current: u.group);
        if (g == null || g == u.group || !mounted) return;
        ref.read(userAlarmsProvider.notifier).save(u.copyWith(group: g));
        _undo(g.isEmpty ? l10n.noGroup : l10n.movedToGroup(g), () => ref.read(userAlarmsProvider.notifier).save(u));
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

  /// The cards you can add: the ones on home show a check, the others add on a tap.
  Future<void> _addCard(HomeGrid grid, Map<HomeCard, GridCardSpec> specs) => showModalBottomSheet<void>(
    context: context,
    showDragHandle: true,
    isScrollControlled: true,
    builder: (context) => Consumer(
      builder: (context, ref, _) {
        final text = Theme.of(context).textTheme;
        ref.watch(homeGridProvider);
        final now = ref.read(homeGridProvider.notifier).of(grid.cols);
        final shabbat = ref.watch(shabbatInUseProvider);
        return SafeArea(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: MediaQuery.sizeOf(context).height * .8),
            child: ListView(
              shrinkWrap: true,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 8),
                  child: Text(l10n.homeAddCard, style: text.headlineMedium),
                ),
                for (final c in HomeCard.values)
                  if (specs.containsKey(c) && (c != HomeCard.shabbat || shabbat))
                    ListTile(
                      key: ValueKey('add-${c.name}'),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 24),
                      leading: Icon(cardIcon(c), color: QuandoColors.amber),
                      title: Text(cardName(c)),
                      trailing: now.has(c)
                          ? Text(l10n.homeOnHome, style: text.bodySmall)
                          : const Icon(Icons.add_circle_outline, color: QuandoColors.coral),
                      onTap: now.has(c) ? null : () => ref.read(homeGridProvider.notifier).set(now.add(c)),
                    ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        );
      },
    ),
  );

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
            ShabbatTimeRow(label: l10n.candleLighting, day: cityDay(period.start), time: cityTime(period.start)),
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

    final clock = display.clock == ClockSize.off
        ? null
        : ClockHero(now: ref.watch(clockProvider), zone: home, size: display.clock);
    final nextAlarm = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // The countdown rides on the heading when the big line shows a clock time.
        Text(
          next != null && next.at.difference(now) > const Duration(hours: 12)
              ? '${l10n.nextAlarmHeading} · ${countdown(next.at.difference(now)).toUpperCase()}'
              : l10n.nextAlarmHeading,
          style: text.labelSmall,
        ),
        const SizedBox(height: 6),
        FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.centerLeft,
          child: Text(
            next == null
                ? l10n.nothingSet
                // Far away reads better as a clock time than as a long countdown.
                : next.at.difference(now) > const Duration(hours: 12)
                ? l10n.atClock(local(next.at))
                : countdown(next.at.difference(now)),
            style: text.displayMedium?.copyWith(fontSize: 60),
          ),
        ),
        const SizedBox(height: 6),
        if (next != null) ...[
          Text(
            // A reminder ahead of an event says so: "Candle lighting ·
            // 6 hours before · Fri 13 Nov · 12:09", never just the
            // event's name at the reminder's time.
            '${next.title}${next.offset == Duration.zero ? '' : ' · ${describeOffset(next.offset)}'} · ${day(next.at)} · ${local(next.at)} · ${cityOf(home)}',
            style: text.bodyLarge?.copyWith(color: const Color(0xFFF7DCD0)),
          ),
          const SizedBox(height: 8),
        ],
      ],
    );

    final quick = Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        for (final m in const [10, 20, 60])
          _WhenChip(
            label: m < 60 ? l10n.inMinutes(m) : l10n.inOneHour,
            onTap: () =>
                _quick(DateTime.now().toUtc().add(Duration(minutes: m)), m < 60 ? l10n.inMinutes(m) : l10n.inOneHour),
          ),
        if (nextSunset != null) _WhenChip(label: l10n.atSunset, onTap: () => _quick(nextSunset, l10n.sunset)),
      ],
    );

    final alarms = <Widget>[
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
          onOpen: () => setState(() => _openGroups.contains(g) ? _openGroups.remove(g) : _openGroups.add(g)),
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
    ];

    // ---- Cards (iPad and Mac by default; a choice in Settings) ----
    final width = MediaQuery.sizeOf(context).width;
    final cardsMode = !jewishHome && display.cardsOn(width);
    final cols = HomeGrid.colsFor(width);
    Widget titled(String title, List<Widget> children) => Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(title.toUpperCase(), style: text.labelSmall),
        const SizedBox(height: 10),
        ...children,
      ],
    );
    final marks = [
      for (final a in upcoming)
        if (sky.at(a.at) case final t? when t >= 0 && t <= 1) t,
    ];
    ref.watch(homeGridProvider);
    final grid = cardsMode ? ref.read(homeGridProvider.notifier).of(cols) : null;
    final cardClock = switch (grid?.of(HomeCard.clock)) {
      final p? => switch (HomeGrid.nearestSize(p, cols)) {
        CardSize.small => ClockSize.small,
        CardSize.medium => ClockSize.medium,
        CardSize.large => ClockSize.large,
      },
      null => ClockSize.medium,
    };
    final specs = !cardsMode
        ? const <HomeCard, GridCardSpec>{}
        : <HomeCard, GridCardSpec>{
            HomeCard.next: GridCardSpec(title: cardName(HomeCard.next), fill: sky.color, child: nextAlarm),
            HomeCard.clock: GridCardSpec(
              title: cardName(HomeCard.clock),
              child: ClockHero(now: ref.watch(clockProvider), zone: home, size: cardClock),
            ),
            HomeCard.sky: GridCardSpec(
              title: cardName(HomeCard.sky),
              fill: sky.color,
              child: SkyPanel(sky: sky, marks: marks),
            ),
            HomeCard.moon: GridCardSpec(
              title: cardName(HomeCard.moon),
              fill: sky.color,
              child: SkyPanel(sky: sky, only: SkyCard.moon),
            ),
            HomeCard.weather: GridCardSpec(
              title: cardName(HomeCard.weather),
              fill: sky.color,
              child: SkyPanel(sky: sky, only: SkyCard.weather),
            ),
            HomeCard.alarms: GridCardSpec(
              title: cardName(HomeCard.alarms),
              child: titled(l10n.yourAlarmsHeading, alarms),
            ),
            HomeCard.quick: GridCardSpec(title: cardName(HomeCard.quick), child: quick),
            HomeCard.tools: GridCardSpec(title: cardName(HomeCard.tools), child: const ToolsCard()),
            HomeCard.stopwatch: GridCardSpec(
              title: cardName(HomeCard.stopwatch),
              child: const ToolLine(tool: HomeTool.stopwatch),
            ),
            HomeCard.countdown: GridCardSpec(
              title: cardName(HomeCard.countdown),
              child: const ToolLine(tool: HomeTool.countdown),
            ),
            HomeCard.getSet: GridCardSpec(
              title: cardName(HomeCard.getSet),
              child: const ToolLine(tool: HomeTool.getSet),
            ),
            HomeCard.world: GridCardSpec(title: cardName(HomeCard.world), child: const WorldClocks()),
            HomeCard.week: GridCardSpec(
              title: cardName(HomeCard.week),
              child: titled(l10n.thisWeekHeading, [
                if (ref.watch(fullPlanProvider).isEmpty) Text(l10n.noAlarmsThisWeek, style: text.bodySmall),
                WeekList(
                  days: weekPlan(ref.watch(fullPlanProvider), home),
                  today: inZone(now, home),
                  zone: home,
                  skipped: ref.watch(skippedProvider),
                  onTap: _alarmActions,
                  onSeries: (s) => _actions(s.alarms),
                ),
              ]),
            ),
            HomeCard.shabbat: GridCardSpec(
              title: cardName(HomeCard.shabbat),
              child: Column(mainAxisSize: MainAxisSize.min, children: shabbat),
            ),
          };

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        // Full width on phones; on a Mac or iPad window a full-width bar
        // hid the alarm list, so it stops at a comfortable size.
        width: min(MediaQuery.sizeOf(context).width - 40, 420),
        height: 60,
        // A soft glow instead of a dark ring.
        decoration: ShapeDecoration(
          shape: const StadiumBorder(),
          shadows: [BoxShadow(color: QuandoColors.coral.withAlpha(70), blurRadius: 22, offset: const Offset(0, 8))],
        ),
        child: FloatingActionButton.extended(
          tooltip: l10n.newAlarm,
          onPressed: _newAlarm,
          icon: const Icon(Icons.add, size: 26),
          label: Text(l10n.when),
        ),
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
                    Expanded(child: Text(appTitle, style: text.titleLarge?.copyWith(fontSize: 23))),
                    if (cardsMode)
                      IconButton(
                        key: const ValueKey('arrange-home'),
                        tooltip: l10n.homeEdit,
                        isSelected: _arranging,
                        icon: const Icon(Icons.dashboard_customize_outlined),
                        onPressed: () => setState(() => _arranging = !_arranging),
                      ),
                    // The tools card has the timers; on a phone the header needs the room.
                    if (!cardsMode || width >= 700)
                      IconButton(
                        tooltip: l10n.timersTitle,
                        icon: const Icon(Icons.timer_outlined),
                        onPressed: () => context.push('/timers'),
                      ),
                    IconButton(
                      tooltip: l10n.lockMode,
                      icon: const Icon(Icons.lock_outline),
                      onPressed: () => context.push('/lock'),
                    ),
                    IconButton(
                      tooltip: l10n.calendars,
                      icon: const Icon(Icons.event_outlined),
                      onPressed: () => context.push('/calendar'),
                    ),
                    IconButton(
                      tooltip: l10n.settings,
                      icon: const Icon(Icons.tune),
                      onPressed: () => context.push('/settings'),
                    ),
                  ],
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
                            if (jewishHome) Text(date, style: text.bodyMedium?.copyWith(color: QuandoColors.blush)),
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
                                  child: Text(parasha.isNotEmpty ? l10n.weeklyParasha(parasha) : l10n.festivalReading),
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
                if (!cardsMode) ...[
                  const SizedBox(height: 14),
                  Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        LayoutBuilder(
                          builder: (context, box) {
                            // iPad and Mac: the next alarm leads at the top left and the
                            // clock with today's date sits at the right. Phones keep the
                            // clock above the next alarm.
                            if (box.maxWidth >= 700) {
                              return Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(child: nextAlarm),
                                  if (clock != null) ...[
                                    const SizedBox(width: 24),
                                    SizedBox(
                                      width: switch (display.clock) {
                                        ClockSize.large => 240,
                                        ClockSize.medium => 330,
                                        _ => null,
                                      },
                                      child: clock,
                                    ),
                                  ],
                                ],
                              );
                            }
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (clock != null) ...[clock, const SizedBox(height: 14)],
                                nextAlarm,
                              ],
                            );
                          },
                        ),
                        QuoteLine(now: now, idle: next == null),
                        const SizedBox(height: 10),
                        SkyPanel(
                          sky: sky,
                          marks: [
                            for (final a in upcoming)
                              if (sky.at(a.at) case final t? when t >= 0 && t <= 1) t,
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 120),
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
                if (jewishHome) const SizedBox(height: 4),
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
                if (cardsMode && grid != null) ...[
                  if (_arranging)
                    _ArrangeBar(
                      onAdd: () => _addCard(grid, specs),
                      onReset: () => ref.read(homeGridProvider.notifier).reset(cols),
                      onDone: () => setState(() => _arranging = false),
                    ),
                  HomeGridView(
                    grid: grid,
                    cards: specs,
                    editing: _arranging,
                    onChanged: ref.read(homeGridProvider.notifier).set,
                  ),
                ] else if (!jewishHome || !_showShabbat) ...[
                  // ---- Stopwatch, timer and "get set": one tap away ----
                  const _TimerTiles(),
                  const SizedBox(height: 16),
                  // ---- One-tap "when" ----
                  quick,
                  const SizedBox(height: 16),

                  if (!jewishHome && ref.watch(shabbatInUseProvider)) ...shabbat,
                  // ---- Your alarms ----
                  const SizedBox(height: 8),
                  Text(l10n.yourAlarmsHeading, style: text.labelSmall),
                  const SizedBox(height: 10),
                  ...alarms,

                  // ---- Event alarms ----
                  if (eventRules.isNotEmpty) ...[
                    const SizedBox(height: 18),
                    Text(l10n.aroundEventsHeading, style: text.labelSmall),
                    const SizedBox(height: 10),
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

                  // ---- This week ----
                  const SizedBox(height: 18),
                  Text(l10n.thisWeekHeading, style: text.labelSmall),
                  if (ref.watch(fullPlanProvider).isEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Text(l10n.noAlarmsThisWeek, style: text.bodySmall),
                    ),
                  WeekList(
                    days: weekPlan(ref.watch(fullPlanProvider), home),
                    today: inZone(now, home),
                    zone: home,
                    skipped: ref.watch(skippedProvider),
                    onTap: _alarmActions,
                    onSeries: (s) => _actions(s.alarms),
                  ),

                  // ---- World clocks ----
                  const SizedBox(height: 22),
                  const WorldClocks(),

                  const SizedBox(height: 16),
                  Text(l10n.alarmsSetThemselves, style: text.bodySmall),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _WhenChip extends StatelessWidget {
  const _WhenChip({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) =>
      ActionChip(label: Text(label), onPressed: onTap, padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8));
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

String cardName(HomeCard c) => switch (c) {
  HomeCard.next => l10n.cardNext,
  HomeCard.clock => l10n.cardClock,
  HomeCard.sky => l10n.cardSky,
  HomeCard.moon => l10n.cardMoon,
  HomeCard.weather => l10n.cardWeather,
  HomeCard.alarms => l10n.cardAlarms,
  HomeCard.quick => l10n.cardQuick,
  HomeCard.tools => l10n.cardTools,
  HomeCard.stopwatch => l10n.timerStopwatch,
  HomeCard.countdown => l10n.timerCountdown,
  HomeCard.getSet => l10n.timerSequence,
  HomeCard.world => l10n.cardWorld,
  HomeCard.week => l10n.cardWeek,
  HomeCard.shabbat => l10n.cardShabbat,
};

IconData cardIcon(HomeCard c) => switch (c) {
  HomeCard.next => Icons.alarm,
  HomeCard.clock => Icons.schedule,
  HomeCard.sky => Icons.wb_twilight,
  HomeCard.moon => Icons.nightlight_round,
  HomeCard.weather => Icons.cloud_outlined,
  HomeCard.alarms => Icons.list_alt,
  HomeCard.quick => Icons.bolt,
  HomeCard.tools => Icons.av_timer,
  HomeCard.stopwatch => Icons.timer_outlined,
  HomeCard.countdown => Icons.hourglass_bottom,
  HomeCard.getSet => Icons.flag_outlined,
  HomeCard.world => Icons.public,
  HomeCard.week => Icons.calendar_view_week,
  HomeCard.shabbat => Icons.local_fire_department_outlined,
};

/// While arranging the cards: what to do, Add card, Reset and Done.
class _ArrangeBar extends StatelessWidget {
  const _ArrangeBar({required this.onAdd, required this.onReset, required this.onDone});
  final VoidCallback onAdd, onReset, onDone;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 16),
    child: Wrap(
      spacing: 8,
      runSpacing: 8,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text(l10n.homeCardsHint, style: Theme.of(context).textTheme.bodySmall),
        FilledButton.icon(
          key: const ValueKey('add-card'),
          onPressed: onAdd,
          icon: const Icon(Icons.add),
          label: Text(l10n.homeAddCard),
        ),
        OutlinedButton(onPressed: onReset, child: Text(l10n.homeReset)),
        FilledButton.tonal(key: const ValueKey('arrange-done'), onPressed: onDone, child: Text(l10n.done)),
      ],
    ),
  );
}
