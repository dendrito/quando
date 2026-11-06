import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/providers.dart';
import '../../../app/theme.dart';
import '../../../core/util/format.dart';
import '../../../core/util/local_time.dart';
import '../domain/user_alarm.dart';
import '../../rules/ui/delivery_tile.dart';
import '../../sounds/ui/sound_picker.dart';
import '../../timezones/ui/zone_picker.dart';
import 'group_picker.dart';
import 'ring_length_picker.dart';
import '../../ringing/ui/alarm_extras.dart';
import '../../../core/scheduler/scheduler.dart';

import 'package:quando/l10n/l10n.dart';

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

  /// When an alarm set in another zone rings on your clock.
  DateTime _ringsLocally() {
    final home = ref.read(homeZoneProvider);
    final at = UserAlarm.nextAt(_alarm.hour, _alarm.minute, ref.read(clockProvider)(), _alarm.zone ?? home);
    return inZone(at, home);
  }

  Future<void> _pickZone() async {
    final home = ref.read(homeZoneProvider);
    final choice = await showModalBottomSheet<String>(
      context: context,
      showDragHandle: true,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.home_outlined),
              title: Text(l10n.yourTimeCity(cityOf(home))),
              onTap: () => Navigator.pop(context, 'home'),
            ),
            for (final z in ref.read(timeZonesProvider).clocks)
              ListTile(
                leading: const Icon(Icons.public),
                title: Text(l10n.cityTime(cityOf(z))),
                onTap: () => Navigator.pop(context, z),
              ),
            ListTile(
              leading: const Icon(Icons.search),
              title: Text(l10n.anotherCity),
              onTap: () => Navigator.pop(context, 'pick'),
            ),
          ],
        ),
      ),
    );
    if (choice == null || !mounted) return;
    if (choice == 'home') return setState(() => _alarm = _alarm.copyWith(homeZone: true));
    final z = choice == 'pick' ? await pickZone(context, home: home) : choice;
    if (z != null) setState(() => _alarm = _alarm.copyWith(zone: z));
  }

  /// Rings this alarm, exactly as set, in 5 seconds.
  Future<void> _preview() async {
    final a = _alarm.copyWith(label: _label.text.trim());
    final at = DateTime.now().toUtc().add(const Duration(seconds: 5));
    final payload = ref
        .read(payloadForProvider)(
          ScheduledAlarm(
            id: 0,
            at: at,
            title: a.title,
            body: a.repeatLabel,
            ringDuration: Duration(seconds: a.ringSeconds ?? ref.read(alarmOptionsProvider).ringSeconds),
            ruleId: 'user.${a.id}',
            eventId: 'user.${a.id}',
            offset: Duration.zero,
            soundId: a.delivery.resolveSound(a.soundId),
            delivery: a.delivery,
            style: a.style,
          ),
        )
        .asPreview();
    await ref.read(registrarProvider).set(stableId('preview|${at.millisecondsSinceEpoch}'), at, payload);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(l10n.ringingIn5)));
    }
  }

  void _save() {
    ref.read(userAlarmsProvider.notifier).save(_alarm.copyWith(label: _label.text.trim(), enabled: true));
    final next = _alarm.repeats
        ? null
        : UserAlarm.nextAt(
            _alarm.hour,
            _alarm.minute,
            ref.read(clockProvider)(),
            _alarm.zone ?? ref.read(homeZoneProvider),
          );
    final messenger = ScaffoldMessenger.of(context);
    Navigator.of(context).pop();
    messenger.showSnackBar(
      SnackBar(content: Text(next == null ? l10n.alarmSaved : l10n.alarmSetFor(_until(next)))),
    );
  }

  String _until(DateTime at) {
    final d = at.difference(ref.read(clockProvider)());
    final h = d.inHours;
    final m = d.inMinutes % 60;
    return h == 0 ? l10n.minutesShort(m) : l10n.hoursMinutesShort(h, m);
  }

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final defaultRing = ref.watch(alarmOptionsProvider).ringSeconds;
    final ring = _alarm.ringSeconds ?? defaultRing;
    final letters = [for (var d = 1; d <= 7; d++) weekdayNarrow(d)];

    return Scaffold(
      appBar: AppBar(
        title: Text(_isNew ? l10n.newAlarm : l10n.editAlarm),
        backgroundColor: Colors.transparent,
        actions: [
          TextButton(onPressed: _preview, child: Text(l10n.previewCaps)),
          TextButton(onPressed: _save, child: Text(l10n.saveCaps)),
          if (!_isNew)
            IconButton(
              tooltip: l10n.duplicate,
              icon: const Icon(Icons.copy),
              onPressed: () {
                // A copy of the alarm as it is on screen, opened for editing.
                final copy = UserAlarm.fromJson({
                  ..._alarm.toJson(),
                  'id': DateTime.now().microsecondsSinceEpoch.toRadixString(36),
                });
                ref.read(userAlarmsProvider.notifier).save(copy);
                context.pushReplacement('/alarm/${copy.id}');
              },
            ),
          if (!_isNew)
            IconButton(
              tooltip: l10n.delete,
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
          Center(
            child: TextButton.icon(
              icon: const Icon(Icons.public, size: 18),
              label: Text(
                _alarm.zone == null
                    ? l10n.yourTimeCity(cityOf(ref.watch(homeZoneProvider)))
                    : l10n.cityTimeForYou(cityOf(_alarm.zone!), hhmm(_ringsLocally())),
              ),
              onPressed: _pickZone,
            ),
          ),
          const SizedBox(height: 8),
          Text(l10n.repeatHeading(_alarm.repeatLabel.toUpperCase()), style: text.labelSmall),
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
            decoration: InputDecoration(labelText: l10n.labelField),
          ),
          const SizedBox(height: 12),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.folder_outlined),
            title: Text(l10n.group),
            subtitle: Text(_alarm.group.isEmpty ? l10n.noGroup : _alarm.group),
            trailing: const Icon(Icons.chevron_right),
            onTap: () async {
              final g = await pickGroup(
                context,
                groups: ref.read(userAlarmsProvider.notifier).groups,
                current: _alarm.group,
              );
              if (g != null) setState(() => _alarm = _alarm.copyWith(group: g));
            },
          ),
          const SizedBox(height: 4),
          SoundPickerTile(
            large: true,
            value: _alarm.delivery.resolveSound(_alarm.soundId),
            onChanged: (id) => setState(
              () => _alarm = _alarm.copyWith(
                delivery: _alarm.delivery.copyWith(
                  soundId: id,
                  clearSound: id == null,
                  useDefaultSound: id == null,
                ),
              ),
            ),
          ),
          DeliveryTile(
            title: 'Pushover',
            value: _alarm.delivery,
            ruleSound: _alarm.soundId,
            showSoundPicker: false,
            onChanged: (d) => setState(() => _alarm = _alarm.copyWith(delivery: d)),
          ),
          AlarmExtras(
            value: _alarm.style,
            onChanged: (s) => setState(() => _alarm = _alarm.copyWith(style: s)),
          ),
          const SizedBox(height: 16),
          Text(
            l10n.ringsForHeading(formatSpan(Duration(seconds: ring)).toUpperCase()),
            style: text.labelSmall,
          ),
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
                child: Text(l10n.useDefault(formatSpan(Duration(seconds: defaultRing)))),
              ),
            ),
          const SizedBox(height: 24),
          FilledButton(
            style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(56)),
            onPressed: _save,
            child: Text(l10n.save),
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
        width: 44,
        height: 44,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: selected ? QuandoColors.amber : QuandoColors.surface,
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
