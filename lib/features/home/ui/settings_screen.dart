import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/providers.dart';
import '../../../core/util/format.dart';
import '../../alarms/data/permissions.dart';
import '../../alarms/ui/ring_length_picker.dart';
import '../../../app/theme.dart';
import '../../../core/util/local_time.dart';
import '../../sounds/ui/sound_picker.dart';
import '../../timezones/ui/zone_picker.dart';
import '../../ringing/ring_payload.dart';
import '../../shabbat/domain/jewish_times.dart';
import '../../settings/domain/alarm_options.dart';
import '../../shabbat/domain/place.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final place = ref.watch(placeProvider);
    final havdalah = ref.watch(havdalahProvider);
    final o = ref.watch(alarmOptionsProvider);
    final zones = ref.watch(timeZonesProvider);
    void setO(AlarmOptions Function(AlarmOptions) f) => ref.read(alarmOptionsProvider.notifier).update(f);
    final text = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Settings'), backgroundColor: Colors.transparent),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.hub_outlined, color: QuandoColors.amber),
            title: const Text('Connections'),
            subtitle: const Text('Pushover, Zapier, IFTTT'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.push('/connections'),
          ),
          const SizedBox(height: 16),
          Text('TIME ZONE', style: text.labelSmall),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.public, color: QuandoColors.amber),
            title: Text(zones.fixed == null ? 'Follow the phone' : cityOf(zones.fixed!)),
            subtitle: Text(
              zones.fixed == null
                  ? 'Now ${cityOf(ref.watch(homeZoneProvider))}. Changes by itself when you travel.'
                  : 'Fixed. Alarms keep this time even when you travel.',
            ),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _pickHomeZone(context, ref),
          ),
          const SizedBox(height: 16),
          Text('SHABBAT CITY', style: text.labelSmall),
          DropdownButton<String>(
            isExpanded: true,
            value: place.name,
            items: [for (final p in Places.all) DropdownMenuItem(value: p.name, child: Text(p.name))],
            onChanged: (name) =>
                ref.read(placeProvider.notifier).set(Places.all.firstWhere((p) => p.name == name)),
          ),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('In Israel (one festival day)'),
            value: place.inIsrael,
            onChanged: (v) => ref.read(placeProvider.notifier).setInIsrael(v),
          ),
          const SizedBox(height: 16),
          Text(
            'CANDLE LIGHTING: ${place.candleLightingMinutes} MINUTES BEFORE SUNSET',
            style: text.labelSmall,
          ),
          Slider(
            min: 10,
            max: 60,
            divisions: 50,
            value: place.candleLightingMinutes.toDouble(),
            label: '${place.candleLightingMinutes}',
            onChanged: (v) => ref.read(placeProvider.notifier).setCandleMinutes(v.round()),
          ),
          const SizedBox(height: 16),
          Text('END OF SHABBAT AND FESTIVALS', style: text.labelSmall),
          RadioGroup<HavdalahOpinion>(
            groupValue: havdalah,
            onChanged: (v) => ref.read(havdalahProvider.notifier).set(v!),
            child: const Column(
              children: [
                RadioListTile(
                  contentPadding: EdgeInsets.zero,
                  value: HavdalahOpinion.geonim,
                  title: Text('Nightfall (Geonim, 8.5°)'),
                ),
                RadioListTile(
                  contentPadding: EdgeInsets.zero,
                  value: HavdalahOpinion.rabbeinuTam,
                  title: Text('72 minutes after sunset (Rabbeinu Tam)'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Text('WHEN AN ALARM RINGS', style: text.labelSmall),
          SoundPickerTile(
            value: o.soundId,
            allowDefault: false,
            onChanged: (id) =>
                setO((x) => id == null ? x.copyWith(phoneSound: true) : x.copyWith(soundId: id)),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton.icon(
              onPressed: () => context.push('/sounds'),
              icon: const Icon(Icons.mic_none),
              label: const Text('Record or add sounds'),
            ),
          ),
          const Text('Rings for this long, then stops by itself'),
          const SizedBox(height: 8),
          RingLengthPicker(
            seconds: o.ringSeconds,
            onChanged: (s) => setO((x) => x.copyWith(ringSeconds: s)),
          ),
          const SizedBox(height: 8),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Say it out loud'),
            subtitle: const Text('Reads what the alarm is for, e.g. "Candle lighting, 15 minutes before"'),
            value: o.spoken,
            onChanged: (v) => setO((x) => x.copyWith(spoken: v)),
          ),
          Text(o.maxSnoozes == 0 ? 'No snooze' : 'Snooze up to ${o.maxSnoozes}× of ${o.snoozeMinutes} min'),
          Slider(
            min: 0,
            max: 5,
            divisions: 5,
            value: o.maxSnoozes.toDouble(),
            label: '${o.maxSnoozes}',
            onChanged: (v) => setO((x) => x.copyWith(maxSnoozes: v.round())),
          ),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Wake-up check'),
            subtitle: const Text('After you stop it, rings again in 3 minutes unless you tap "I\'m up"'),
            value: o.wakeCheck,
            onChanged: (v) => setO((x) => x.copyWith(wakeCheck: v)),
          ),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Solve a sum to stop'),
            subtitle: const Text('Proves you\'re awake'),
            value: o.mathTask,
            onChanged: (v) => setO((x) => x.copyWith(mathTask: v)),
          ),
          Text(
            'On Shabbat and festivals none of these apply: alarms stop by themselves and never ask '
            'you to touch the phone.',
            style: text.bodySmall,
          ),
          const SizedBox(height: 16),
          OutlinedButton(
            onPressed: () => _testAlarm(context, ref, o),
            child: const Text('Ring a test alarm in 1 minute'),
          ),
          const SizedBox(height: 24),
          Text(
            'Times are calculated on your phone. For borderline cases, check with your rabbi or '
            'community calendar.',
            style: text.bodySmall,
          ),
        ],
      ),
    );
  }

  Future<void> _pickHomeZone(BuildContext context, WidgetRef ref) async {
    final choice = await showModalBottomSheet<String>(
      context: context,
      showDragHandle: true,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.phone_android),
              title: const Text('Follow the phone'),
              subtitle: const Text('Recommended'),
              onTap: () => Navigator.pop(context, 'phone'),
            ),
            ListTile(
              leading: const Icon(Icons.search),
              title: const Text('Choose a city'),
              onTap: () => Navigator.pop(context, 'pick'),
            ),
          ],
        ),
      ),
    );
    if (choice == 'phone') ref.read(timeZonesProvider.notifier).followPhone();
    if (choice == 'pick' && context.mounted) {
      final z = await pickZone(context, home: ref.read(homeZoneProvider));
      if (z != null) ref.read(timeZonesProvider.notifier).setFixed(z);
    }
  }

  Future<void> _testAlarm(BuildContext context, WidgetRef ref, AlarmOptions o) async {
    final messenger = ScaffoldMessenger.of(context);
    final supported =
        !kIsWeb &&
        (defaultTargetPlatform == TargetPlatform.android || defaultTargetPlatform == TargetPlatform.iOS);
    if (!supported) {
      messenger.showSnackBar(const SnackBar(content: Text('Test alarms only work on a phone.')));
      return;
    }
    await ensureAlarmPermissions();
    final at = DateTime.now().add(const Duration(minutes: 1));
    final p = RingPayload.forAlarm(
      title: 'Test alarm',
      body: 'This is how your alarms will sound',
      options: o,
      shabbatSafe: false,
    );
    await ref
        .read(registrarProvider)
        .set(
          stableId('test|${at.millisecondsSinceEpoch}'),
          at,
          RingPayload(
            title: p.title,
            body: p.body,
            ringSeconds: p.ringSeconds,
            spoken: p.spoken,
            maxSnoozes: p.maxSnoozes,
            snoozeMinutes: 1,
            wakeCheck: p.wakeCheck,
            mathTask: p.mathTask,
            transient: true,
          ),
        );
    messenger.showSnackBar(const SnackBar(content: Text('Test alarm in 1 minute. You can lock the phone.')));
  }
}
