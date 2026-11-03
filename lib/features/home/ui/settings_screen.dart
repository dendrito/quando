import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/providers.dart';
import '../../shabbat/domain/jewish_times.dart';
import '../../shabbat/domain/place.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final place = ref.watch(placeProvider);
    final havdalah = ref.watch(havdalahProvider);
    final text = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Settings'), backgroundColor: Colors.transparent),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        children: [
          Text('LOCATION', style: text.labelSmall),
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
          Text(
            'Times are calculated on your phone. For borderline cases, check with your rabbi or '
            'community calendar.',
            style: text.bodySmall,
          ),
        ],
      ),
    );
  }
}
