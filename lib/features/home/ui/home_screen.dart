import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../app/providers.dart';
import '../../../app/theme.dart';
import '../../../app/widgets/brand.dart';
import '../../../core/scheduler/scheduler.dart';
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
              const SizedBox(height: 12),
            ],
          ),
        );
      },
    );
    if (!mounted) return;
    if (choice == 'time') context.push('/alarm/new');
    if (choice == 'event') context.push('/calendar/rule/new');
  }

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

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        width: MediaQuery.sizeOf(context).width - 40,
        height: 60,
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
                const SizedBox(height: 18),
                Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(l10n.nextAlarmHeading, style: text.labelSmall),
                      const SizedBox(height: 6),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          next == null ? l10n.nothingSet : countdown(next.at.difference(now)),
                          style: text.displayMedium?.copyWith(fontSize: 60),
                        ),
                      ),
                      const SizedBox(height: 6),
                      if (next != null) ...[
                        Text(
                          '${next.title} · ${day(next.at)} · ${local(next.at)} · $home',
                          style: text.bodyLarge?.copyWith(color: const Color(0xFFF7DCD0)),
                        ),
                        const SizedBox(height: 8),
                      ],
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
                if (!jewishHome || !_showShabbat) ...[
                  // ---- One-tap "when" ----
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      for (final m in const [10, 20, 60])
                        _WhenChip(
                          label: m < 60 ? l10n.inMinutes(m) : l10n.inOneHour,
                          onTap: () => _quick(
                            DateTime.now().toUtc().add(Duration(minutes: m)),
                            m < 60 ? l10n.inMinutes(m) : l10n.inOneHour,
                          ),
                        ),
                      if (nextSunset != null)
                        _WhenChip(label: l10n.atSunset, onTap: () => _quick(nextSunset, l10n.sunset)),
                    ],
                  ),
                  const SizedBox(height: 16),

                  if (!jewishHome && ref.watch(shabbatInUseProvider)) ...shabbat,
                  // ---- Your alarms ----
                  const SizedBox(height: 8),
                  Text(l10n.yourAlarmsHeading, style: text.labelSmall),
                  const SizedBox(height: 10),
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
                        _undo(
                          l10n.deletedNamed(a.title),
                          () => ref.read(userAlarmsProvider.notifier).save(a),
                        );
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
                      onOpen: () => setState(
                        () => _openGroups.contains(g) ? _openGroups.remove(g) : _openGroups.add(g),
                      ),
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
                          _undo(
                            l10n.deletedNamed(r.title),
                            () => ref.read(calendarRulesProvider.notifier).save(r),
                          );
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
  Widget build(BuildContext context) => ActionChip(
    label: Text(label),
    onPressed: onTap,
    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
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
