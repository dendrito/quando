import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

import '../../../app/providers.dart';
import '../../../l10n/l10n.dart';
import '../../../core/util/platform.dart';
import '../../../core/util/local_time.dart';
import '../../home/domain/zone_places.dart';
import '../domain/place.dart';

Future<void> pickShabbatPlace(BuildContext context) =>
    Navigator.of(context).push<void>(MaterialPageRoute(builder: (_) => const CityPicker()));

/// One foreground fix, only after the user presses the location button.
class LocationLookup {
  LocationLookup({GeolocatorPlatform? platform, bool? macOS, Duration? timeout})
    : _platform = platform ?? GeolocatorPlatform.instance,
      _timeout = timeout ?? Duration(seconds: (macOS ?? isMacOS) ? 90 : 20);
  final GeolocatorPlatform _platform;
  final Duration _timeout;

  Future<({double latitude, double longitude})> current() async {
    if (!await _platform.isLocationServiceEnabled()) throw const LocationFailure(LocationProblem.servicesOff);
    var permission = await _platform.checkPermission();
    if (permission == LocationPermission.denied) permission = await _platform.requestPermission();
    if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
      throw const LocationFailure(LocationProblem.denied);
    }
    try {
      // A Mac obtains its fix through Wi-Fi rather than a phone's GPS.
      // A bounded stream lets the first fix cancel updates, including on
      // timeout; getCurrentPosition's Future timeout leaves native work live.
      final p = await _platform
          .getPositionStream(locationSettings: const LocationSettings(accuracy: LocationAccuracy.medium))
          .where(
            (p) =>
                p.latitude.isFinite &&
                p.longitude.isFinite &&
                p.accuracy >= 0 &&
                p.latitude.abs() <= 90 &&
                p.longitude.abs() <= 180 &&
                DateTime.now().difference(p.timestamp).abs() < const Duration(minutes: 5),
          )
          .timeout(_timeout)
          .first;
      return (latitude: p.latitude, longitude: p.longitude);
    } on TimeoutException {
      throw const LocationFailure(LocationProblem.timeout);
    } on PermissionDeniedException {
      throw const LocationFailure(LocationProblem.denied);
    } on LocationServiceDisabledException {
      throw const LocationFailure(LocationProblem.servicesOff);
    }
  }
}

enum LocationProblem { servicesOff, denied, timeout, timezone }

class LocationFailure implements Exception {
  const LocationFailure(this.problem);
  final LocationProblem problem;
}

final locationLookupProvider = Provider<LocationLookup>((ref) => LocationLookup());

class CityPicker extends ConsumerStatefulWidget {
  const CityPicker({super.key, this.forSky = false, this.locateOnOpen = false});
  final bool forSky;
  final bool locateOnOpen;
  @override
  ConsumerState<CityPicker> createState() => _CityPickerState();
}

class _CityPickerState extends ConsumerState<CityPicker> {
  String _query = '';
  bool _busy = false;
  String? _error;
  bool _openSettings = false;

  @override
  void initState() {
    super.initState();
    if (widget.locateOnOpen) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _locate();
      });
    }
  }

  void _save(Place place, {bool local = false}) {
    if (widget.forSky) {
      ref.read(skyLocationProvider.notifier).set(place);
      unawaited(
        ref
            .read(homeDisplayProvider.notifier)
            .set(ref.read(homeDisplayProvider).copyWith(skyUseShabbat: false)),
      );
    } else if (local) {
      ref.read(placeProvider.notifier).setLocal(place);
    } else {
      ref.read(placeProvider.notifier).set(place);
    }
  }

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
      _openSettings = false;
    });
    try {
      final zone = ref.read(deviceZoneProvider);
      if (zone == null) {
        throw const LocationFailure(LocationProblem.timezone);
      }
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
                  Text(cityOf(zone)),
                  if (!widget.forSky)
                    SwitchListTile(
                      title: Text(l10n.inIsraelOneDay),
                      value: inIsrael,
                      onChanged: (v) => update(() => inIsrael = v),
                    ),
                  Text(widget.forSky ? l10n.skyLocationLocalTimes : l10n.locationDeviceOnly),
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
      _save(
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
        local: true,
      );
      Navigator.pop(context);
    } on LocationFailure catch (error) {
      if (mounted) {
        setState(() {
          _error = switch (error.problem) {
            LocationProblem.servicesOff => l10n.locationServicesOff,
            LocationProblem.denied => l10n.locationDenied,
            LocationProblem.timeout => l10n.locationTimedOut,
            LocationProblem.timezone => l10n.locationTimeZoneUnavailable,
          };
          _openSettings =
              error.problem == LocationProblem.servicesOff || error.problem == LocationProblem.denied;
        });
      }
    } catch (_) {
      if (mounted) setState(() => _error = l10n.locationUnavailable);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final choices = widget.forSky
        ? <String, Place>{
            for (final p in [...ZonePlaces.all, ...Places.all]) '${p.name}|${p.timeZone}': p,
          }.values
        : Places.all;
    final cities =
        choices.where((p) => normalized('${p.name} ${p.timeZone}').contains(normalized(_query))).toList()
          ..sort((a, b) => a.name.compareTo(b.name));
    return Scaffold(
      appBar: AppBar(title: Text(widget.forSky ? l10n.skyChooseCity : l10n.changeCity)),
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
                  onPressed: _busy ? null : () => _locate(),
                  icon: const Icon(Icons.my_location),
                  label: Text(_busy ? l10n.locationLooking : l10n.useMyLocation),
                ),
                if (_error != null)
                  Text(_error!, style: TextStyle(color: Theme.of(context).colorScheme.error)),
                if (_openSettings)
                  TextButton(onPressed: Geolocator.openLocationSettings, child: Text(l10n.locationSettings)),
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
                  subtitle: place.name == cityOf(place.timeZone)
                      ? null
                      : Text(l10n.cityTime(cityOf(place.timeZone))),
                  onTap: () {
                    _save(place);
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
