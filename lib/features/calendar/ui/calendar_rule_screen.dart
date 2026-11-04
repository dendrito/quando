import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/providers.dart';
import '../../../app/theme.dart';
import '../../../core/util/format.dart';
import '../../../core/util/local_time.dart';
import '../../events/domain/event.dart';
import '../../sounds/ui/sound_picker.dart';
import '../domain/calendar_rule.dart';
import '../../ringing/ui/alarm_extras.dart';

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
  if (d.inDays >= 1 && d.inHours % 24 == 0) return d.inDays == 7 ? '1 week' : '${d.inDays} d';
  if (d.inHours >= 1 && d.inMinutes % 60 == 0) return '${d.inHours} h';
  return '${d.inMinutes} min';
}

class _CalendarRuleScreenState extends ConsumerState<CalendarRuleScreen> {
  late CalendarRule _rule;
  late final bool _isNew;
  late final TextEditingController _name;
  late final TextEditingController _keyword;
  var _shown = 6;

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
            Text('How to search', style: text.headlineSmall),
            const SizedBox(height: 12),
            row('dentist', 'The title contains "dentist", any case'),
            row('dent*', '* is any letters: dentist, dentures'),
            row('?oga', '? is one letter: yoga, toga'),
            row('"team sync"', 'This exact phrase'),
            row('gym yoga', 'Both words (AND)'),
            row('flight OR train', 'Either one. | works too'),
            row('meeting -cancelled', 'Leave out. NOT and ! work too'),
            row('(gym OR yoga) am', 'Brackets group words'),
            const SizedBox(height: 8),
            Text('Leave it empty to ring for every event.', style: text.bodySmall),
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
          title: const Text('Custom time'),
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
                items: const [
                  DropdownMenuItem(value: 1, child: Text('minutes')),
                  DropdownMenuItem(value: 60, child: Text('hours')),
                  DropdownMenuItem(value: 1440, child: Text('days')),
                ],
                onChanged: (v) => setLocal(() => unit = v!),
              ),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
            FilledButton(
              onPressed: () => Navigator.pop(context, (int.tryParse(c.text) ?? 0) * unit),
              child: const Text('Add'),
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
      label: const Text('Other'),
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
      'jewish' => 'Shabbat & festivals',
      'sun' => 'Sun',
      _ => cal.calendars.where((c) => c.id == e.source).firstOrNull?.name ?? 'Calendar',
    };

    final next = matches.firstOrNull;
    final nextTimes = next == null
        ? const <String>[]
        : [
            for (final o in (next.kind.isCalendar ? startRule : timesRule).offsets())
              if (next.at.add(o).isAfter(ref.read(clockProvider)())) hhmm(inZone(next.at.add(o), home)),
          ];

    return Scaffold(
      appBar: AppBar(
        title: Text(_isNew ? 'New event alarm' : 'Event alarm'),
        backgroundColor: Colors.transparent,
        actions: [
          if (!_isNew)
            IconButton(
              tooltip: 'Delete',
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
          Text('FIND THE EVENTS', style: text.labelSmall),
          const SizedBox(height: 8),
          TextField(
            controller: _keyword,
            autofocus: _isNew,
            textInputAction: TextInputAction.search,
            decoration: InputDecoration(
              hintText: 'Search: dentist, gym OR yoga, dent*…',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: IconButton(
                tooltip: 'How to search',
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
            title: const Text('Also Shabbat, festival and sun times'),
            subtitle: const Text('e.g. "candle*", "havdalah", "sunset"'),
            value: _rule.includeTimes,
            onChanged: (v) => setState(() => _rule = _rule.copyWith(includeTimes: v)),
          ),
          if (cal.calendars.isNotEmpty)
            Wrap(
              spacing: 8,
              runSpacing: 4,
              children: [
                FilterChip(
                  label: const Text('All my calendars'),
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
          else if (!cal.access)
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.event_outlined),
              title: const Text('Connect your calendars to search them'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => ref.read(calendarProvider.notifier).connect(),
            ),
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
                        ? 'Searching…'
                        : matches.isEmpty
                        ? 'Nothing matches in the next 60 days'
                        : matches.length == 1
                        ? '1 event in the next 60 days'
                        : '${matches.length} events in the next 60 days',
                    style: text.titleMedium?.copyWith(fontWeight: FontWeight.w800),
                  ),
                  if (nextTimes.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      'Next: rings at ${nextTimes.take(6).join(', ')}${nextTimes.length > 6 ? '…' : ''} for "${next!.title}"',
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
                      child: Text('Show more (${matches.length - _shown} left)'),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text('RING BEFORE IT STARTS', style: text.labelSmall),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 4,
            children: _chips(_beforeChoices, _rule.before, (l) => _rule = _rule.copyWith(before: l)),
          ),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Ring when it starts'),
            value: _rule.atStart,
            onChanged: (v) => setState(() => _rule = _rule.copyWith(atStart: v)),
          ),
          const SizedBox(height: 8),
          Text('AND REPEAT BEFORE IT', style: text.labelSmall),
          Row(
            children: [
              const Text('Every '),
              DropdownButton<Duration?>(
                value: _rule.repeatEvery,
                items: [
                  const DropdownMenuItem(value: null, child: Text('off')),
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
                const Text('  for '),
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
          Text('RING AFTER IT ENDS', style: text.labelSmall),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 4,
            children: _chips(_afterChoices, _rule.after, (l) => _rule = _rule.copyWith(after: l)),
          ),
          const SizedBox(height: 16),
          SoundPickerTile(
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
            decoration: const InputDecoration(labelText: 'Name (optional)'),
          ),
          const SizedBox(height: 24),
          FilledButton(
            style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(56)),
            onPressed: _save,
            child: const Text('Save'),
          ),
          const SizedBox(height: 12),
          Text(
            'Alarms are set for the next 7 days and topped up each time you open Quando.',
            style: text.bodySmall,
          ),
        ],
      ),
    );
  }
}
