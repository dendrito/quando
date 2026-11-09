import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/providers.dart';
import '../../../app/theme.dart';
import '../../../core/util/local_time.dart';
import '../../../l10n/l10n.dart';
import '../../shabbat/ui/city_picker.dart';
import 'home_display_controls.dart';

/// The city in the top bar: where the sky, sunrise and weather are for.
/// Tapping it opens [showPlaceSheet].
class PlacePill extends ConsumerWidget {
  const PlacePill({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final place = ref.watch(skyPlaceProvider);
    final name = place?.name ?? cityOf(ref.watch(homeZoneProvider));
    return Tooltip(
      message: l10n.homePlaceTitle,
      child: Material(
        color: QuandoColors.ground.withValues(alpha: .35),
        shape: const StadiumBorder(),
        child: InkWell(
          customBorder: const StadiumBorder(),
          onTap: () => showPlaceSheet(context),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.place_outlined, size: 16, color: QuandoColors.blush),
                const SizedBox(width: 4),
                Flexible(
                  child: Text(
                    name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(color: QuandoColors.blush),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Where the sky is for (your location, your timezone's city or the Shabbat
/// city), a city to choose, and what the sky card shows.
Future<void> showPlaceSheet(BuildContext context) => showModalBottomSheet<void>(
  context: context,
  showDragHandle: true,
  isScrollControlled: true,
  builder: (sheet) => Consumer(
    builder: (sheet, ref, _) {
      final text = Theme.of(sheet).textTheme;
      final options = ref.watch(homeDisplayProvider);
      final place = ref.watch(skyPlaceProvider);
      final located = ref.watch(skyLocationProvider) != null;
      Future<void> open(Widget page) async {
        Navigator.of(sheet).pop();
        await Navigator.of(context).push<void>(MaterialPageRoute(builder: (_) => page));
      }

      return SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(l10n.homePlaceTitle, style: text.headlineMedium),
              const SizedBox(height: 4),
              Text(
                place == null
                    ? l10n.skyChooseCity
                    : timesInLabel(place.name, place.timeZone) +
                          (!options.skyUseShabbat && !located ? ' · ${l10n.skyReferenceCity}' : ''),
                style: text.bodyMedium,
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children: [
                  ChoiceChip(
                    label: Text(located ? l10n.skyMyLocation : l10n.skyTimezone),
                    selected: !options.skyUseShabbat,
                    onSelected: (_) =>
                        ref.read(homeDisplayProvider.notifier).set(options.copyWith(skyUseShabbat: false)),
                  ),
                  // Shabbat stays out of sight until it is switched on.
                  if (ref.watch(shabbatInUseProvider))
                    ChoiceChip(
                      label: Text(l10n.skyShabbat),
                      selected: options.skyUseShabbat,
                      onSelected: (_) =>
                          ref.read(homeDisplayProvider.notifier).set(options.copyWith(skyUseShabbat: true)),
                    ),
                ],
              ),
              const SizedBox(height: 8),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.my_location, color: QuandoColors.amber),
                title: Text(l10n.useMyLocation),
                onTap: () => open(const CityPicker(forSky: true, locateOnOpen: true)),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.search, color: QuandoColors.amber),
                title: Text(l10n.skyChooseCity),
                onTap: () => open(CityPicker(forSky: !options.skyUseShabbat)),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.tune, color: QuandoColors.amber),
                title: Text(l10n.homeDisplay),
                onTap: () {
                  Navigator.of(sheet).pop();
                  showHomeDisplayControls(context);
                },
              ),
            ],
          ),
        ),
      );
    },
  ),
);
