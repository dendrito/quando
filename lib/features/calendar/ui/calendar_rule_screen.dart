import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/providers.dart';
import '../../../app/theme.dart';
import '../../../core/util/format.dart';
import '../../../core/util/local_time.dart';
import '../../events/domain/event.dart';
import '../../sounds/ui/sound_picker.dart';
import '../../rules/ui/delivery_tile.dart';
import '../../rules/domain/reminder_delivery.dart';
import '../domain/calendar_rule.dart';
import '../../ringing/ui/alarm_extras.dart';

import 'package:quando/l10n/l10n.dart';

/// Set up one calendar alarm: which events, and when to ring.
class CalendarRuleScreen extends ConsumerStatefulWidget {
  const CalendarRuleScreen({super.key, required this.id, this.timesQuery});

  final String id;

  /// Start a new rule on Shabbat, festival and sun times with this search,
  /// e.g. "candle*".
  final String? timesQuery;

  @override
  ConsumerState<CalendarRuleScreen> createState() => _CalendarRuleScreenState();
}

const _beforeChoices = [
  Duration(days: 7),
  Duration(days: 3),
  Duration(days: 1),
  Duration(hours: 3),
  Duration(hours: 2),
  Duration(hours: 1),
  Duration(minutes: 30),
  Duration(minutes: 15),
  Duration(minutes: 10),
  Duration(minutes: 5),
  Duration(minutes: 1),
];

const _afterChoices = [
  Duration(minutes: 1),
  Duration(minutes: 5),
  Duration(minutes: 15),
  Duration(minutes: 30),
  Duration(hours: 1),
  Duration(hours: 2),
  Duration(days: 1),
];

const _everyChoices = [Duration(minutes: 30), Duration(hours: 1), Duration(hours: 2), Duration(days: 1)];
const _forChoices = [
  Duration(hours: 3),
  Duration(hours: 6),
  Duration(hours: 12),
  Duration(days: 1),
  Duration(days: 3),
  Duration(days: 7),
  Duration(days: 30),
];

String _short(Duration d) {
  if (d.inDays >= 1 && d.inHours % 24 == 0) return d.inDays == 7 ? l10n.oneWeek : l10n.daysShort(d.inDays);
  if (d.inHours >= 1 && d.inMinutes % 60 == 0) return l10n.hoursShort(d.inHours);
  return l10n.minutesShort(d.inMinutes);
}

class _CalendarRuleScreenState extends ConsumerState<CalendarRuleScreen> {
  late CalendarRule _rule;
  late final bool _isNew;
  late final TextEditingController _name;
  late final TextEditingController _keyword;
  var _shown = 6;
  var _step = 0;

  static const _examples = [
    'dentist',
    'dent*',
    '"team sync"',
    'flight OR train',
    'meeting -cancelled',
    '(gym OR yoga) morning',
    'candle*',
  ];

  void _searchHelp(BuildContext context) => showModalBottomSheet<void>(
    context: context,
    showDragHandle: true,
    builder: (context) {
      final text = Theme.of(context).textTheme;
      Widget row(String q, String means) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 170,
              child: Text(q, style: text.titleMedium?.copyWith(color: QuandoColors.amber)),
            ),
            Expanded(child: Text(means, style: text.bodyMedium)),
          ],
        ),
      );
      return SafeArea(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
          children: [
            Text(l10n.howToSearch, style: text.headlineSmall),
            const SizedBox(height: 12),
            row('dentist', l10n.searchHelpWord),
            row('dent*', l10n.searchHelpStar),
            row('?oga', l10n.searchHelpQuestion),
            row('"team sync"', l10n.searchHelpPhrase),
            row('gym yoga', l10n.searchHelpAnd),
            row('flight OR train', l10n.searchHelpOr),
            row('meeting -cancelled', l10n.searchHelpNot),
            row('(gym OR yoga) am', l10n.searchHelpBrackets),
            const SizedBox(height: 8),
            Text(l10n.searchHelpEmpty, style: text.bodySmall),
          ],
        ),
      );
    },
  );

  @override
  void initState() {
    super.initState();
    final existing = ref.read(calendarRulesProvider).where((r) => r.id == widget.id);
    _isNew = existing.isEmpty;
    _rule = _isNew
        ? CalendarRule(
            id: DateTime.now().microsecondsSinceEpoch.toRadixString(36),
            before: const [Duration(minutes: 15)],
            eventReminders: widget.timesQuery == null,
            keyword: widget.timesQuery ?? '',
            includeTimes: widget.timesQuery != null,
          )
        : existing.first;
    _name = TextEditingController(text: _rule.name);
    _keyword = TextEditingController(text: _rule.keyword);
  }

  @override
  void dispose() {
    _name.dispose();
    _keyword.dispose();
    super.dispose();
  }

  void _toggle(List<Duration> list, Duration d, void Function(List<Duration>) set) {
    final next = [...list];
    next.contains(d) ? next.remove(d) : next.add(d);
    setState(() => set(next..sort()));
  }

  Future<void> _custom(List<Duration> list, void Function(List<Duration>) set) async {
    final c = TextEditingController();
    var unit = 1; // minutes
    final minutes = await showDialog<int>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setLocal) => AlertDialog(
          title: Text(l10n.customTime),
          content: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: c,
                  autofocus: true,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                ),
              ),
              const SizedBox(width: 12),
              DropdownButton<int>(
                value: unit,
                items: [
                  DropdownMenuItem(value: 1, child: Text(l10n.unitMinutes)),
                  DropdownMenuItem(value: 60, child: Text(l10n.unitHours)),
                  DropdownMenuItem(value: 1440, child: Text(l10n.unitDays)),
                ],
                onChanged: (v) => setLocal(() => unit = v!),
              ),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: Text(l10n.cancel)),
            FilledButton(
              onPressed: () => Navigator.pop(context, (int.tryParse(c.text) ?? 0) * unit),
              child: Text(l10n.add),
            ),
          ],
        ),
      ),
    );
    if (minutes != null && minutes > 0) {
      final d = Duration(minutes: minutes);
      if (!list.contains(d)) setState(() => set([...list, d]..sort()));
    }
  }

  List<Widget> _chips(List<Duration> choices, List<Duration> chosen, void Function(List<Duration>) set) => [
    for (final d in {...choices, ...chosen}.toList()..sort((a, b) => b.compareTo(a)))
      FilterChip(
        label: Text(_short(d)),
        selected: chosen.contains(d),
        onSelected: (_) => _toggle(chosen, d, set),
      ),
    ActionChip(
      avatar: const Icon(Icons.add, size: 16),
      label: Text(l10n.other),
      onPressed: () => _custom(chosen, set),
    ),
  ];

  void _save() {
    ref
        .read(calendarRulesProvider.notifier)
        .save(_rule.copyWith(name: _name.text.trim(), keyword: _keyword.text.trim()));
    // The search may now reach further ahead: read the calendars again.
    ref.read(calendarProvider.notifier).refresh();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final cal = ref.watch(calendarProvider);
    final home = ref.watch(homeZoneProvider);
    final query = _keyword.text.trim();
    final rules = _rule.copyWith(keyword: query).toAlarmRules();
    final startRule = rules.first;
    final timesRule = rules.last;
    final searchable = ref.watch(searchableEventsProvider);
    final matches = (searchable.value ?? const <AnchorEvent>[])
        .where((e) => startRule.matches(e) || (timesRule.enabled && timesRule.matches(e)))
        .toList();
    String when(DateTime utc) {
      final l = inZone(utc, home);
      return '${dayLabel(l)} · ${hhmm(l)}';
    }

    String from(AnchorEvent e) => switch (e.source) {
      'jewish' => l10n.shabbatAndFestivals,
      'sun' => l10n.sun,
      _ => cal.calendars.where((c) => c.id == e.source).firstOrNull?.name ?? l10n.calendar,
    };

    final next = matches.firstOrNull;
    final nextTimes = next == null
        ? const <String>[]
        : [
            for (final o in next.kind.isCalendar ? startRule.offsetsFor(next) : timesRule.offsets())
              if (next.at.add(o).isAfter(ref.read(clockProvider)())) hhmm(inZone(next.at.add(o), home)),
          ];

    return Scaffold(
      appBar: AppBar(
        title: Text(_isNew ? l10n.newEventAlarm : l10n.eventAlarm),
        backgroundColor: Colors.transparent,
        actions: [
          if (!_isNew && _step < 2) TextButton(onPressed: _save, child: Text(l10n.saveCaps)),
          if (!_isNew)
            IconButton(
              tooltip: l10n.delete,
              icon: const Icon(Icons.delete_outline),
              onPressed: () {
                ref.read(calendarRulesProvider.notifier).delete(_rule.id);
                Navigator.of(context).pop();
              },
            ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        children: [
          _Steps(step: _step, onTap: (i) => setState(() => _step = i)),
          const SizedBox(height: 20),
          if (_step == 0) ...[
            Text(l10n.findEventsHeading, style: text.labelSmall),
            const SizedBox(height: 8),
            TextField(
              controller: _keyword,
              autofocus: _isNew,
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                hintText: l10n.searchEventsHint,
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  tooltip: l10n.howToSearch,
                  icon: const Icon(Icons.help_outline),
                  onPressed: () => _searchHelp(context),
                ),
              ),
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 44,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  for (final ex in _examples)
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ActionChip(
                        label: Text(ex),
                        onPressed: () => setState(() {
                          _keyword.text = ex;
                          _keyword.selection = TextSelection.collapsed(offset: ex.length);
                        }),
                      ),
                    ),
                ],
              ),
            ),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(l10n.alsoBuiltInTimes),
              subtitle: Text(l10n.alsoBuiltInTimesHint),
              value: _rule.includeTimes,
              onChanged: (v) => setState(() => _rule = _rule.copyWith(includeTimes: v)),
            ),
            // Only on some weekdays, e.g. sunrise on weekdays. None = every day.
            Text(
              l10n
                  .repeatHeading(
                    _rule.days.isEmpty || _rule.days.length == 7
                        ? l10n.everyDay
                        : [
                            for (var d = 1; d <= 7; d++)
                              if (_rule.days.contains(d)) weekdayShort(d),
                          ].join(', '),
                  )
                  .toUpperCase(),
              style: text.labelSmall,
            ),
            const SizedBox(height: 4),
            Wrap(
              spacing: 6,
              children: [
                for (var d = 1; d <= 7; d++)
                  FilterChip(
                    label: Text(weekdayNarrow(d)),
                    showCheckmark: false,
                    selected: _rule.days.contains(d),
                    onSelected: (on) => setState(() {
                      final days = {..._rule.days};
                      on ? days.add(d) : days.remove(d);
                      _rule = _rule.copyWith(days: days);
                    }),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            if (cal.calendars.isNotEmpty)
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children: [
                  FilterChip(
                    label: Text(l10n.allMyCalendars),
                    selected: _rule.calendarIds.isEmpty,
                    onSelected: (_) => setState(() => _rule = _rule.copyWith(calendarIds: {})),
                  ),
                  for (final c in cal.calendars.where((c) => cal.selected.contains(c.id)))
                    FilterChip(
                      label: Text(c.name),
                      selected: _rule.calendarIds.contains(c.id),
                      onSelected: (on) => setState(() {
                        final ids = {..._rule.calendarIds};
                        on ? ids.add(c.id) : ids.remove(c.id);
                        _rule = _rule.copyWith(calendarIds: ids);
                      }),
                    ),
                ],
              )
            else if (!cal.access) ...[
              const SizedBox(height: 4),
              Text(l10n.connectToSearch, style: text.bodySmall),
              const SizedBox(height: 8),
              FilledButton.icon(
                style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(56)),
                onPressed: () => ref.read(calendarProvider.notifier).connect(),
                icon: const Icon(Icons.event_outlined),
                label: Text(l10n.connectACalendar),
              ),
            ],
            const SizedBox(height: 12),
            Material(
              color: QuandoColors.surface,
              borderRadius: const BorderRadius.all(Radius.circular(24)),
              clipBehavior: Clip.antiAlias,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(18, 14, 18, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      searchable.isLoading
                          ? l10n.searching
                          : matches.isEmpty
                          ? l10n.nothingMatches60
                          : l10n.eventsIn60(matches.length),
                      style: text.titleMedium?.copyWith(fontWeight: FontWeight.w800),
                    ),
                    if (nextTimes.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        l10n.nextRingsAt(
                          '${nextTimes.take(6).join(', ')}${nextTimes.length > 6 ? '…' : ''}',
                          next!.title,
                        ),
                        style: text.bodySmall?.copyWith(color: QuandoColors.blush),
                      ),
                    ],
                    const SizedBox(height: 6),
                    for (final e in matches.take(_shown))
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(e.title, style: text.bodyLarge?.copyWith(fontWeight: FontWeight.w600)),
                                  Text(from(e), style: text.bodySmall),
                                ],
                              ),
                            ),
                            Text(when(e.at), style: text.bodyMedium?.copyWith(color: QuandoColors.amber)),
                          ],
                        ),
                      ),
                    if (matches.length > _shown)
                      TextButton(
                        onPressed: () => setState(() => _shown += 20),
                        child: Text(l10n.showMoreLeft(matches.length - _shown)),
                      ),
                  ],
                ),
              ),
            ),
          ] else if (_step == 1) ...[
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              secondary: const Icon(Icons.notifications_active_outlined, color: QuandoColors.amber),
              title: Text(l10n.ringAtEventReminders),
              subtitle: Text(l10n.ringAtEventRemindersHint),
              value: _rule.eventReminders,
              onChanged: (v) => setState(() => _rule = _rule.copyWith(eventReminders: v)),
            ),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              secondary: const Icon(Icons.do_not_disturb_on_outlined, color: QuandoColors.amber),
              title: Text(l10n.busyDuringEvents),
              subtitle: Text(l10n.busyDuringEventsHint),
              value: _rule.busy,
              onChanged: (v) => setState(() => _rule = _rule.copyWith(busy: v)),
            ),
            if (_rule.busy)
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: TextButton(onPressed: () => context.push('/busy'), child: Text(l10n.busySettings)),
              ),
            const SizedBox(height: 8),
            Text(l10n.ringBeforeStartsHeading, style: text.labelSmall),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 4,
              children: _chips(_beforeChoices, _rule.before, (l) => _rule = _rule.copyWith(before: l)),
            ),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(l10n.ringWhenStarts),
              value: _rule.atStart,
              onChanged: (v) => setState(() => _rule = _rule.copyWith(atStart: v)),
            ),
            const SizedBox(height: 8),
            Text(l10n.repeatBeforeHeading, style: text.labelSmall),
            Row(
              children: [
                Text(l10n.everyPrefix),
                DropdownButton<Duration?>(
                  value: _rule.repeatEvery,
                  items: [
                    DropdownMenuItem(value: null, child: Text(l10n.offLower)),
                    for (final d in _everyChoices) DropdownMenuItem(value: d, child: Text(formatSpan(d))),
                  ],
                  onChanged: (d) => setState(
                    () => _rule = d == null
                        ? _rule.copyWith(clearRepeat: true)
                        : _rule.copyWith(
                            repeatEvery: d,
                            repeatFor: _rule.repeatFor ?? const Duration(hours: 6),
                          ),
                  ),
                ),
                if (_rule.repeatEvery != null) ...[
                  Text(l10n.forInfix),
                  DropdownButton<Duration>(
                    value: _rule.repeatFor,
                    items: [
                      for (final d in _forChoices) DropdownMenuItem(value: d, child: Text(formatSpan(d))),
                    ],
                    onChanged: (d) => setState(() => _rule = _rule.copyWith(repeatFor: d)),
                  ),
                ],
              ],
            ),
            const SizedBox(height: 16),
            Text(l10n.ringAfterEndsHeading, style: text.labelSmall),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 4,
              children: _chips(_afterChoices, _rule.after, (l) => _rule = _rule.copyWith(after: l)),
            ),
            if (nextTimes.isNotEmpty) ...[
              const SizedBox(height: 16),
              Text(
                l10n.nextRingsAt(
                  '${nextTimes.take(6).join(', ')}${nextTimes.length > 6 ? '…' : ''}',
                  next!.title,
                ),
                style: text.bodyMedium?.copyWith(color: QuandoColors.blush),
              ),
            ],
          ] else ...[
            for (final offset in {..._rule.toAlarmRules().first.offsets(), ..._rule.after}.toList()..sort())
              DeliveryTile(
                key: ValueKey(offset.inMinutes),
                title: offset == Duration.zero ? l10n.atTheMomentItself : describeOffset(offset),
                value: _rule.deliveries[offset.inMinutes] ?? ReminderDelivery.inherit,
                ruleSound: _rule.soundId,
                onChanged: (choice) => setState(
                  () => _rule = _rule.copyWith(deliveries: {..._rule.deliveries, offset.inMinutes: choice}),
                ),
              ),
            const SizedBox(height: 16),
            Text(l10n.defaultLabel, style: text.labelSmall),
            SoundPickerTile(
              large: true,
              value: _rule.soundId,
              onChanged: (id) => setState(
                () => _rule = id == null ? _rule.copyWith(defaultSound: true) : _rule.copyWith(soundId: id),
              ),
            ),
            AlarmExtras(
              value: _rule.style,
              onChanged: (s) => setState(() => _rule = _rule.copyWith(style: s)),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _name,
              decoration: InputDecoration(labelText: l10n.nameOptional),
            ),
            const SizedBox(height: 16),
            Text(l10n.toppedUp, style: text.bodySmall),
          ],
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 12),
          child: Row(
            children: [
              if (_step > 0)
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(minimumSize: const Size.fromHeight(56)),
                    onPressed: () => setState(() => _step--),
                    child: Text(l10n.back),
                  ),
                ),
              if (_step > 0) const SizedBox(width: 12),
              Expanded(
                flex: 2,
                // With no calendar connected, "Connect a calendar" is the main button.
                child: (_step == 0 && cal.calendars.isEmpty && !cal.access)
                    ? OutlinedButton(
                        style: OutlinedButton.styleFrom(minimumSize: const Size.fromHeight(56)),
                        onPressed: () => setState(() => _step++),
                        child: Text(l10n.next),
                      )
                    : FilledButton(
                        style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(56)),
                        onPressed: _step < 2 ? () => setState(() => _step++) : _save,
                        child: Text(_step < 2 ? l10n.next : l10n.save),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// "1 Events · 2 When · 3 How": where you are, and a tap to jump.
class _Steps extends StatelessWidget {
  const _Steps({required this.step, required this.onTap});

  final int step;
  final ValueChanged<int> onTap;

  static List<String> get _names => [l10n.stepWhichEvents, l10n.stepWhenToRing, l10n.stepHowItRings];

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    return Row(
      children: [
        for (var i = 0; i < _names.length; i++)
          Expanded(
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () => onTap(i),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 16,
                      backgroundColor: i <= step ? QuandoColors.coral : QuandoColors.raised,
                      child: i < step
                          ? const Icon(Icons.check, size: 18, color: QuandoColors.ground)
                          : Text(
                              '${i + 1}',
                              style: TextStyle(
                                color: i == step ? QuandoColors.ground : QuandoColors.muted,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      _names[i],
                      style: text.bodySmall?.copyWith(
                        color: i == step ? QuandoColors.text : QuandoColors.muted,
                        fontWeight: i == step ? FontWeight.w700 : null,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}
