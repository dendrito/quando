import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/providers.dart';
import '../../../app/theme.dart';
import '../../../core/util/format.dart';
import '../../../core/util/local_time.dart';
import '../domain/user_alarm.dart';
import '../../sounds/ui/sound_picker.dart';
import 'ring_length_picker.dart';

/// Add or edit one everyday alarm. [id] is 'new' for a new alarm.
class EditAlarmScreen extends ConsumerStatefulWidget {
  const EditAlarmScreen({super.key, required this.id});

  final String id;

  @override
  ConsumerState<EditAlarmScreen> createState() => _EditAlarmScreenState();
}

class _EditAlarmScreenState extends ConsumerState<EditAlarmScreen> {
  late UserAlarm _alarm;
  late final TextEditingController _label;
  late final bool _isNew;

  @override
  void initState() {
    super.initState();
    final existing = ref.read(userAlarmsProvider).where((a) => a.id == widget.id);
    _isNew = existing.isEmpty;
    _alarm = _isNew
        ? UserAlarm(id: DateTime.now().microsecondsSinceEpoch.toRadixString(36), hour: 7, minute: 0)
        : existing.first;
    _label = TextEditingController(text: _alarm.label);
  }

  @override
  void dispose() {
    _label.dispose();
    super.dispose();
  }

  Future<void> _pickTime() async {
    final t = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: _alarm.hour, minute: _alarm.minute),
      builder: (context, child) =>
          MediaQuery(data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true), child: child!),
    );
    if (t != null) setState(() => _alarm = _alarm.copyWith(hour: t.hour, minute: t.minute));
  }

  void _save() {
    ref.read(userAlarmsProvider.notifier).save(_alarm.copyWith(label: _label.text.trim(), enabled: true));
    final next = _alarm.repeats
        ? null
        : UserAlarm.nextAt(
            _alarm.hour,
            _alarm.minute,
            ref.read(clockProvider)(),
            ref.read(placeProvider).timeZone,
          );
    final messenger = ScaffoldMessenger.of(context);
    Navigator.of(context).pop();
    messenger.showSnackBar(
      SnackBar(content: Text(next == null ? 'Alarm saved.' : 'Alarm set for ${_until(next)} from now.')),
    );
  }

  String _until(DateTime at) {
    final d = at.difference(ref.read(clockProvider)());
    final h = d.inHours;
    final m = d.inMinutes % 60;
    return h == 0 ? '$m min' : '$h h $m min';
  }

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final defaultRing = ref.watch(alarmOptionsProvider).ringSeconds;
    final ring = _alarm.ringSeconds ?? defaultRing;
    const letters = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];

    return Scaffold(
      appBar: AppBar(
        title: Text(_isNew ? 'New alarm' : 'Edit alarm'),
        backgroundColor: Colors.transparent,
        actions: [
          if (!_isNew)
            IconButton(
              tooltip: 'Delete',
              icon: const Icon(Icons.delete_outline),
              onPressed: () {
                ref.read(userAlarmsProvider.notifier).delete(_alarm.id);
                Navigator.of(context).pop();
              },
            ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        children: [
          Center(
            child: TextButton(
              onPressed: _pickTime,
              child: Text(
                hhmm(DateTime(2000, 1, 1, _alarm.hour, _alarm.minute)),
                style: text.displayLarge?.copyWith(color: QuandoColors.amber),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text('REPEAT · ${_alarm.repeatLabel.toUpperCase()}', style: text.labelSmall),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              for (var d = 1; d <= 7; d++)
                _DayChip(
                  letter: letters[d - 1],
                  selected: _alarm.days.contains(d),
                  onTap: () => setState(() {
                    final days = {..._alarm.days};
                    days.contains(d) ? days.remove(d) : days.add(d);
                    _alarm = _alarm.copyWith(days: days);
                  }),
                ),
            ],
          ),
          const SizedBox(height: 24),
          TextField(
            controller: _label,
            textCapitalization: TextCapitalization.sentences,
            decoration: const InputDecoration(labelText: 'Label (read aloud if spoken alarms are on)'),
          ),
          const SizedBox(height: 16),
          SoundPickerTile(
            value: _alarm.soundId,
            onChanged: (id) => setState(
              () => _alarm = id == null ? _alarm.copyWith(defaultSound: true) : _alarm.copyWith(soundId: id),
            ),
          ),
          const SizedBox(height: 16),
          Text('RINGS FOR ${formatSpan(Duration(seconds: ring)).toUpperCase()}', style: text.labelSmall),
          const SizedBox(height: 8),
          RingLengthPicker(
            seconds: ring,
            onChanged: (s) => setState(() => _alarm = _alarm.copyWith(ringSeconds: s)),
          ),
          if (_alarm.ringSeconds != null)
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                onPressed: () => setState(() => _alarm = _alarm.copyWith(clearRingSeconds: true)),
                child: Text('Use the default (${formatSpan(Duration(seconds: defaultRing))})'),
              ),
            ),
          const SizedBox(height: 24),
          FilledButton(
            style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(56)),
            onPressed: _save,
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}

class _DayChip extends StatelessWidget {
  const _DayChip({required this.letter, required this.selected, required this.onTap});

  final String letter;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      customBorder: const CircleBorder(),
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: selected ? QuandoColors.amber : Colors.transparent,
          border: Border.all(color: selected ? QuandoColors.amber : QuandoColors.line),
        ),
        child: Text(
          letter,
          style: TextStyle(
            color: selected ? QuandoColors.ground : QuandoColors.text,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
