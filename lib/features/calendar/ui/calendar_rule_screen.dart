import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/providers.dart';
import '../../../core/util/format.dart';
import '../../events/domain/event.dart';
import '../../sounds/ui/sound_picker.dart';
import '../domain/calendar_rule.dart';

/// Set up one calendar alarm: which events, and when to ring.
class CalendarRuleScreen extends ConsumerStatefulWidget {
  const CalendarRuleScreen({super.key, required this.id});

  final String id;

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

  @override
  void initState() {
    super.initState();
    final existing = ref.read(calendarRulesProvider).where((r) => r.id == widget.id);
    _isNew = existing.isEmpty;
    _rule = _isNew
        ? CalendarRule(
            id: DateTime.now().microsecondsSinceEpoch.toRadixString(36),
            before: const [Duration(minutes: 15)],
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
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final cal = ref.watch(calendarProvider);
    final keyword = _keyword.text.trim().toLowerCase();
    final matching = cal.events
        .where(
          (e) =>
              e.kind == EventKind.calendar &&
              (_rule.calendarIds.isEmpty || _rule.calendarIds.contains(e.source)) &&
              (keyword.isEmpty || e.title.toLowerCase().contains(keyword)),
        )
        .length;

    return Scaffold(
      appBar: AppBar(
        title: Text(_isNew ? 'New calendar alarm' : 'Calendar alarm'),
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
          Text('WHICH EVENTS', style: text.labelSmall),
          TextField(
            controller: _keyword,
            decoration: const InputDecoration(
              labelText: 'Only events with this word (optional)',
              hintText: 'e.g. dentist, flight, class',
            ),
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
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
          ),
          const SizedBox(height: 4),
          Text('$matching upcoming events match', style: text.bodySmall),
          const SizedBox(height: 24),
          Text('BEFORE IT STARTS', style: text.labelSmall),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 4,
            children: _chips(_beforeChoices, _rule.before, (l) => _rule = _rule.copyWith(before: l)),
          ),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('When it starts'),
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
          Text('AFTER IT ENDS', style: text.labelSmall),
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
