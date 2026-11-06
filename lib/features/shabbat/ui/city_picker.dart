import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

import '../../../app/providers.dart';
import '../../../l10n/l10n.dart';
import '../domain/place.dart';

Future<void> pickShabbatPlace(BuildContext context) =>
    Navigator.of(context).push<void>(MaterialPageRoute(builder: (_) => const CityPicker()));

/// One foreground fix, only after the user presses the location button.
class LocationLookup {
  Future<({double latitude, double longitude})> current() async {
    if (!await Geolocator.isLocationServiceEnabled()) throw StateError('Location services disabled');
    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
      throw StateError('Location permission denied');
    }
    final p = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.medium,
        timeLimit: Duration(seconds: 20),
      ),
    );
    return (latitude: p.latitude, longitude: p.longitude);
  }
}

final locationLookupProvider = Provider<LocationLookup>((ref) => LocationLookup());

class CityPicker extends ConsumerStatefulWidget {
  const CityPicker({super.key});
  @override
  ConsumerState<CityPicker> createState() => _CityPickerState();
}

class _CityPickerState extends ConsumerState<CityPicker> {
  String _query = '';
  bool _busy = false;
  String? _error;

  static String normalized(String s) {
    const accents = 'áàâãäéèêëíìîïóòôõöúùûüç';
    const plain = 'aaaaaeeeeiiiiooooouuuuc';
    var out = s.toLowerCase();
    for (var i = 0; i < accents.length; i++) {
      out = out.replaceAll(accents[i], plain[i]);
    }
    return out;
  }

  Future<void> _locate() async {
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      final zone = ref.read(deviceZoneProvider);
      if (zone == null) throw StateError('Device timezone unavailable');
      final point = await ref.read(locationLookupProvider).current();
      if (!mounted) return;
      var inIsrael = zone == 'Asia/Jerusalem';
      final confirmed = await showDialog<bool>(
        context: context,
        builder: (context) => StatefulBuilder(
          builder: (context, update) => AlertDialog(
            title: Text(l10n.locationReview),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    l10n.locationCoordinates(
                      point.latitude.toStringAsFixed(3),
                      point.longitude.toStringAsFixed(3),
                    ),
                  ),
                  Text(zone),
                  SwitchListTile(
                    title: Text(l10n.inIsraelOneDay),
                    value: inIsrael,
                    onChanged: (v) => update(() => inIsrael = v),
                  ),
                  Text(l10n.locationDeviceOnly),
                ],
              ),
            ),
            actions: [
              TextButton(onPressed: () => Navigator.pop(context, false), child: Text(l10n.cancel)),
              FilledButton(onPressed: () => Navigator.pop(context, true), child: Text(l10n.save)),
            ],
          ),
        ),
      );
      if (!mounted || confirmed != true) return;
      ref
          .read(placeProvider.notifier)
          .setLocal(
            Place(
              name: l10n.currentLocation,
              latitude: point.latitude,
              longitude: point.longitude,
              timeZone: zone,
              inIsrael: inIsrael,
              // Keep the chosen custom when already in this timezone; always editable.
              candleLightingMinutes: ref.read(placeProvider).timeZone == zone
                  ? ref.read(placeProvider).candleLightingMinutes
                  : 18,
            ),
          );
      Navigator.pop(context);
    } catch (_) {
      if (mounted) setState(() => _error = l10n.locationUnavailable);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cities =
        Places.all.where((p) => normalized('${p.name} ${p.timeZone}').contains(normalized(_query))).toList()
          ..sort((a, b) => a.name.compareTo(b.name));
    return Scaffold(
      appBar: AppBar(title: Text(l10n.changeCity)),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    labelText: l10n.searchCity,
                    prefixIcon: const Icon(Icons.search),
                  ),
                  onChanged: (v) => setState(() => _query = v),
                ),
                TextButton.icon(
                  onPressed: _busy ? null : _locate,
                  icon: const Icon(Icons.my_location),
                  label: Text(_busy ? l10n.loading : l10n.useMyLocation),
                ),
                if (_error != null)
                  Text(_error!, style: TextStyle(color: Theme.of(context).colorScheme.error)),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cities.length,
              itemBuilder: (context, i) {
                final place = cities[i];
                return ListTile(
                  title: Text(place.name),
                  subtitle: Text(place.timeZone),
                  onTap: () {
                    ref.read(placeProvider.notifier).set(place);
                    Navigator.pop(context);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
