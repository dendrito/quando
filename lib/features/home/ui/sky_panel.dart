import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/providers.dart';
import '../../../app/theme.dart';
import '../../../core/util/local_time.dart';
import '../../../l10n/l10n.dart';
import '../../shabbat/domain/jewish_times.dart';
import '../../shabbat/ui/city_picker.dart';
import '../domain/moon.dart';
import '../domain/moon_phases.dart';
import '../domain/moon_backdrop.dart';
import '../domain/sky.dart';
import 'day_arc.dart';
import 'home_display_controls.dart';
import 'weather_panel.dart';

String moonPhaseLabel(int phase) => switch (phase) {
  0 => l10n.moonNew,
  1 => l10n.moonWaxingCrescent,
  2 => l10n.moonFirstQuarter,
  3 => l10n.moonWaxingGibbous,
  4 => l10n.moonFull,
  5 => l10n.moonWaningGibbous,
  6 => l10n.moonLastQuarter,
  _ => l10n.moonWaningCrescent,
};

class SkyPanel extends ConsumerStatefulWidget {
  const SkyPanel({super.key, required this.sky, this.marks = const []});
  final SkyDay sky;
  final List<double> marks;
  @override
  ConsumerState<SkyPanel> createState() => _SkyPanelState();
}

class _SkyPanelState extends ConsumerState<SkyPanel> {
  final _pager = PageController();
  int _page = 0;
  void _toPage(BuildContext context, int page) {
    if (MediaQuery.disableAnimationsOf(context)) {
      _pager.jumpToPage(page);
    } else {
      _pager.animateToPage(page, duration: const Duration(milliseconds: 250), curve: Curves.easeOut);
    }
  }

  @override
  void dispose() {
    _pager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final options = ref.watch(homeDisplayProvider), place = ref.watch(skyPlaceProvider), sky = widget.sky;
    final text = Theme.of(context).textTheme;
    final moon = options.night && place != null ? MoonDay.of(place, sky.now) : null;
    final illumination = options.moon ? MoonIllumination.at(sky.now) : null;
    final track = options.moon && place != null ? MoonTrack.of(place, sky.now) : null;
    final phases = options.moon ? MoonPhases.nextAfter(sky.now) : null;
    final nightfall = options.night && place != null
        ? JewishTimes(
            place: place,
            havdalah: ref.watch(havdalahProvider),
          ).nightfallOn(inZone(sky.now, place.timeZone))
        : null;
    final String zone = place?.timeZone ?? ref.watch(homeZoneProvider);
    String time(DateTime? at, String absent) => at == null ? absent : hhmm(inZone(at, zone));
    String phaseTime(DateTime at) {
      final local = inZone(at, zone);
      return '${dayLabel(local)} · ${hhmm(local)}';
    }

    String trackTime(DateTime? at, String absent) {
      if (at == null) return absent;
      final local = inZone(at, zone), today = inZone(sky.now, zone);
      return local.year == today.year && local.month == today.month && local.day == today.day
          ? hhmm(local)
          : '${dayLabel(local)} · ${hhmm(local)}';
    }

    final nightDetails = <Widget>[
      if (moon != null) ...[
        const SizedBox(height: 10),
        Wrap(
          spacing: 16,
          runSpacing: 6,
          children: [
            if (!options.moon)
              Text('${l10n.moonriseLabel} ≈ ${time(moon.rise, l10n.noRiseToday)}', style: text.bodySmall),
            if (!options.moon)
              Text('${l10n.moonsetLabel} ≈ ${time(moon.set, l10n.noSetToday)}', style: text.bodySmall),
            Text(
              '${l10n.nightfallLabel} ${time(nightfall, '—')} · ${ref.watch(havdalahProvider) == HavdalahOpinion.geonim ? '8.5°' : '+72m'}',
              style: text.bodySmall,
            ),
            if (moon.alwaysUp) Text(l10n.moonAlwaysUp, style: text.bodySmall),
            if (moon.alwaysDown) Text(l10n.moonAlwaysDown, style: text.bodySmall),
          ],
        ),
      ],
    ];
    final sunContent = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (place == null) Text(l10n.skyCityExplain),
        DayArc(sky: sky, marks: widget.marks),
        Row(
          textDirection: TextDirection.ltr,
          children: [
            Expanded(
              child: Text(
                sky.sunrise == null ? '' : l10n.sunriseAt(time(sky.sunrise, '')),
                style: text.bodySmall?.copyWith(color: QuandoColors.blush),
              ),
            ),
            Flexible(
              child: Text(
                sky.sunset == null
                    ? ''
                    : sky.sunset!.isAfter(sky.now)
                    ? '${l10n.sunsetAt(time(sky.sunset, ''))} · ${countdown(sky.sunset!.difference(sky.now))}'
                    : l10n.sunsetAt(time(sky.sunset, '')),
                textAlign: TextAlign.end,
                style: text.bodySmall?.copyWith(color: QuandoColors.blush),
              ),
            ),
          ],
        ),
        ...nightDetails,
      ],
    );
    final moonContent = Container(
      key: const ValueKey('moon-daylight-background'),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: place != null && track != null
              ? MoonBackdrop.forTrack(place, track)
              : [SkyColors.night, SkyColors.night],
        ),
      ),
      padding: const EdgeInsets.all(18),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(l10n.skyMoon, style: text.titleMedium),
          if (track != null && illumination != null) ...[
            Text(track.above ? l10n.moonAboveHorizon : l10n.moonBelowHorizon, style: text.bodySmall),
            MoonArc(track: track, illumination: illumination),
            Row(
              textDirection: TextDirection.ltr,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    '${l10n.moonriseLabel} ≈ ${trackTime(track.rise, l10n.noRiseToday)}',
                    style: text.bodySmall,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    '${l10n.moonsetLabel} ≈ ${trackTime(track.set, l10n.noSetToday)}',
                    style: text.bodySmall,
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
          ] else
            Text(l10n.skyCityExplain, style: text.bodySmall),
          if (illumination != null && phases != null) ...[
            const SizedBox(height: 12),
            LayoutBuilder(
              builder: (context, constraints) {
                final phase = Row(
                  children: [
                    MoonDisc(illumination: illumination),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        '${moonPhaseLabel(illumination.phaseIndex)} · ${(illumination.fraction * 100).round()}% ${l10n.moonIlluminated}',
                        style: text.bodyMedium,
                      ),
                    ),
                  ],
                );
                final dates = Column(
                  key: const ValueKey('moon-upcoming-dates'),
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${l10n.moonNextNew} ≈ ${phaseTime(phases.newMoon)}', style: text.bodySmall),
                    const SizedBox(height: 4),
                    Text('${l10n.moonNextFull} ≈ ${phaseTime(phases.fullMoon)}', style: text.bodySmall),
                  ],
                );
                if (constraints.maxWidth >= 700 * MediaQuery.textScalerOf(context).scale(1)) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    textDirection: TextDirection.ltr,
                    children: [
                      Expanded(child: phase),
                      const SizedBox(width: 24),
                      Flexible(
                        child: Align(alignment: Alignment.topRight, heightFactor: 1, child: dates),
                      ),
                    ],
                  );
                }
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [phase, const SizedBox(height: 12), dates],
                );
              },
            ),
          ],
        ],
      ),
    );
    final pages = <({String label, Widget child})>[
      (label: l10n.skySun, child: sunContent),
      if (options.moon) (label: l10n.skyMoon, child: moonContent),
      if (options.weather && place != null)
        (
          label: l10n.weatherLabel,
          child: WeatherPanel(now: sky.now, active: _page == (options.moon ? 2 : 1), place: place),
        ),
    ];
    if (_page >= pages.length) {
      _page = 0;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted && _pager.hasClients) _pager.jumpToPage(0);
      });
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 4,
          children: [
            TextButton.icon(
              onPressed: () => Navigator.of(context).push<void>(
                MaterialPageRoute(builder: (_) => const CityPicker(forSky: true, locateOnOpen: true)),
              ),
              icon: const Icon(Icons.my_location, size: 18),
              label: Text(l10n.useMyLocation),
            ),
            ChoiceChip(
              label: Text(ref.watch(skyLocationProvider) == null ? l10n.skyTimezone : l10n.skyMyLocation),
              selected: !options.skyUseShabbat,
              onSelected: (_) =>
                  ref.read(homeDisplayProvider.notifier).set(options.copyWith(skyUseShabbat: false)),
            ),
            ChoiceChip(
              label: Text(l10n.skyShabbat),
              selected: options.skyUseShabbat,
              onSelected: (_) =>
                  ref.read(homeDisplayProvider.notifier).set(options.copyWith(skyUseShabbat: true)),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: TextButton(
                onPressed: () => Navigator.of(
                  context,
                ).push<void>(MaterialPageRoute(builder: (_) => CityPicker(forSky: !options.skyUseShabbat))),
                style: TextButton.styleFrom(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.zero,
                  foregroundColor: QuandoColors.blush,
                ),
                child: Text(
                  place == null
                      ? l10n.skyChooseCity
                      : '${l10n.timesIn(place.name, place.timeZone)}${!options.skyUseShabbat && ref.watch(skyLocationProvider) == null ? ' · ${l10n.skyReferenceCity}' : ''}',
                  style: text.bodySmall?.copyWith(color: QuandoColors.blush),
                ),
              ),
            ),
            TextButton(
              onPressed: () => showHomeDisplayControls(context),
              style: TextButton.styleFrom(
                foregroundColor: QuandoColors.blush,
                minimumSize: const Size(0, 36),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.tune, size: 16),
                  const SizedBox(width: 5),
                  Text(l10n.homeDisplay, style: text.bodySmall),
                ],
              ),
            ),
          ],
        ),
        if (pages.length == 1)
          sunContent
        else ...[
          Wrap(
            spacing: 8,
            children: [
              for (var i = 0; i < pages.length; i++)
                TextButton(
                  onPressed: () => _toPage(context, i),
                  style: TextButton.styleFrom(
                    foregroundColor: _page == i ? QuandoColors.amber : QuandoColors.blush,
                  ),
                  child: Text(pages[i].label),
                ),
            ],
          ),
          LayoutBuilder(
            builder: (context, constraints) => AnimatedSize(
              duration: MediaQuery.disableAnimationsOf(context)
                  ? Duration.zero
                  : const Duration(milliseconds: 250),
              alignment: Alignment.topCenter,
              child: SizedBox(
                height: _page == 1 && options.moon
                    ? (constraints.maxWidth - 36 >= 700 * MediaQuery.textScalerOf(context).scale(1)
                              ? 300
                              : 390) *
                          MediaQuery.textScalerOf(context).scale(1).clamp(1, 2)
                    : max(228.0, options.night ? 260.0 : 180.0),
                child: PageView(
                  controller: _pager,
                  onPageChanged: (p) => setState(() => _page = p),
                  children: [for (final page in pages) SingleChildScrollView(child: page.child)],
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}
