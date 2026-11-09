import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timezone/timezone.dart' as tz;

import '../../../app/providers.dart';
import '../../../app/theme.dart';
import '../../../core/util/local_time.dart';
import '../../../l10n/l10n.dart';
import '../../shabbat/domain/jewish_times.dart';
import '../../shabbat/domain/place.dart';
import '../../shabbat/ui/city_picker.dart';
import '../domain/moon.dart';
import '../domain/moon_phases.dart';
import '../domain/moon_backdrop.dart';
import '../data/home_information_providers.dart';
import '../data/weather_repository.dart';
import '../domain/sky.dart';
import '../domain/sky_weather.dart';
import 'day_arc.dart';
import 'home_display_controls.dart';
import 'moon_details.dart';
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
              Text('${l10n.moonriseLabel} · ${time(moon.rise, l10n.noRiseToday)}', style: text.bodySmall),
            if (!options.moon)
              Text('${l10n.moonsetLabel} · ${time(moon.set, l10n.noSetToday)}', style: text.bodySmall),
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
    final plainSun = Column(
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
    final Widget sunContent = options.weather && place != null && _page == 0
        ? _SunWeatherCard(
            sky: sky,
            place: place,
            zone: zone,
            marks: widget.marks,
            fallback: plainSun,
            footer: nightDetails,
          )
        : plainSun;
    // The card follows the sky right now: a starry indigo night, or the
    // Sun's own color by day. The Moon's path dots still show when it is up
    // in daylight (amber) or at night (silver).
    final skyNow = place == null ? sky : SkyDay.of(place, sky.now);
    final nightCard = !skyNow.isDay;
    final details = illumination != null && phases != null
        ? MoonDetails(
            illumination: illumination,
            phaseName: moonPhaseLabel(illumination.phaseIndex),
            rises: track == null ? '—' : trackTime(track.rise, l10n.noRiseToday),
            sets: track == null ? '—' : trackTime(track.set, l10n.noSetToday),
            newMoon: phaseTime(phases.newMoon),
            fullMoon: phaseTime(phases.fullMoon),
          )
        : null;
    final moonContent = Container(
      key: const ValueKey('moon-daylight-background'),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: nightCard
              ? const [Color(0xFF141033), Color(0xFF1E1846), Color(0xFF2B1F4E)]
              : [skyNow.color, Color.lerp(skyNow.color, QuandoColors.ground, .35)!],
        ),
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: details == null ? null : () => showMoonDetails(context, details),
          child: CustomPaint(
            painter: nightCard ? const _StarsPainter() : null,
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(l10n.skyMoon, style: text.titleMedium),
                  if (track != null && illumination != null) ...[
                    Text(track.above ? l10n.moonAboveHorizon : l10n.moonBelowHorizon, style: text.bodySmall),
                    MoonArc(
                      track: track,
                      illumination: illumination,
                      daylight: place == null ? null : MoonBackdrop.daylightForTrack(place, track),
                    ),
                    Row(
                      textDirection: TextDirection.ltr,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            '${l10n.moonriseLabel} · ${trackTime(track.rise, l10n.noRiseToday)}',
                            style: text.bodySmall,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            '${l10n.moonsetLabel} · ${trackTime(track.set, l10n.noSetToday)}',
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
                            Text('${l10n.moonNextNew} · ${phaseTime(phases.newMoon)}', style: text.bodySmall),
                            const SizedBox(height: 4),
                            Text(
                              '${l10n.moonNextFull} · ${phaseTime(phases.fullMoon)}',
                              style: text.bodySmall,
                            ),
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
            ),
          ),
        ),
      ),
    );

    final pages = <({String label, Widget child})>[
      (label: l10n.skySun, child: sunContent),
      if (options.moon) (label: l10n.skyMoon, child: moonContent),
      if (options.moon && options.moonDetails && details != null) (label: l10n.skyMoonPhase, child: details),
      if (options.weather && place != null)
        (
          label: l10n.weatherLabel,
          child: WeatherPanel(
            now: sky.now,
            active: _page == 1 + (options.moon ? 1 : 0) + (options.moon && options.moonDetails ? 1 : 0),
            place: place,
          ),
        ),
    ];
    final onDetailsPage = options.moon && options.moonDetails && details != null && _page == 2;
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
                      : '${timesInLabel(place.name, place.timeZone)}${!options.skyUseShabbat && ref.watch(skyLocationProvider) == null ? ' · ${l10n.skyReferenceCity}' : ''}',
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
                height: onDetailsPage
                    ? (constraints.maxWidth >= 560 ? 260 : 460) *
                          MediaQuery.textScalerOf(context).scale(1).clamp(1, 2)
                    : _page == 1 && options.moon
                    ? (constraints.maxWidth - 36 >= 700 * MediaQuery.textScalerOf(context).scale(1)
                              ? 300
                              : 390) *
                          MediaQuery.textScalerOf(context).scale(1).clamp(1, 2)
                    : _page == 0 && options.weather && place != null
                    ? 400 * MediaQuery.textScalerOf(context).scale(1).clamp(1, 2)
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

/// Option C: the Sun card with the weather on the Sun's path. The card's
/// colour follows the real sky (see [skyWeatherGradient]).
class _SunWeatherCard extends ConsumerWidget {
  const _SunWeatherCard({
    required this.sky,
    required this.place,
    required this.zone,
    required this.marks,
    required this.fallback,
    required this.footer,
  });
  final SkyDay sky;
  final Place place;
  final String zone;
  final List<double> marks;
  final Widget fallback;
  final List<Widget> footer;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repo = ref.watch(weatherRepositoryProvider);
    final report = ref.watch(weatherReportProvider((place, repo.pollBucket(sky.now)))).value;
    final current = report?.current(sky.now);
    if (report == null || current == null) return fallback;
    final text = Theme.of(context).textTheme;
    final skyNow = SkyDay.of(place, sky.now);
    final (top, bottom) = skyWeatherGradient(skyNow, current.kind);
    final local = inZone(sky.now, zone);
    String time(DateTime? at) => at == null ? '' : hhmm(inZone(at, zone));
    final wet = {WeatherKind.rain, WeatherKind.thunder, WeatherKind.snow}.contains(current.kind);
    final ends = wet ? spellEnds(report, sky.now, current.kind) : null;
    final behind = skyNow.isDay && current.kind != WeatherKind.clear;
    final subtitle = [
      if (behind) l10n.weatherSunBehindClouds,
      if (ends != null) l10n.weatherUntilAbout(time(ends)),
    ].join(' · ');
    // Tonight at 22:00, tomorrow morning at 08:00, both in the city's time.
    DateTime at(int dayOffset, int hour) =>
        tz.TZDateTime(tz.getLocation(zone), local.year, local.month, local.day + dayOffset, hour);
    final tonight = local.hour < 22 ? hourNear(report, at(0, 22)) : null;
    final morning = hourNear(report, at(1, 8));
    String describe(WeatherHour h) => '${h.celsius.round()}° · ${weatherLabel(h.kind).toLowerCase()}';
    Widget later(String title, WeatherHour h) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title.toUpperCase(),
          style: text.labelSmall?.copyWith(color: QuandoColors.blush, letterSpacing: .8),
        ),
        const SizedBox(height: 2),
        Text(describe(h), style: text.bodyMedium?.copyWith(color: QuandoColors.text)),
      ],
    );
    return Container(
      key: const ValueKey('sun-weather-card'),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [top, bottom],
        ),
      ),
      padding: const EdgeInsets.all(18),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                '${current.celsius.round()}°',
                style: text.displaySmall?.copyWith(color: QuandoColors.text, fontWeight: FontWeight.w800),
              ),
              const SizedBox(width: 10),
              Flexible(
                child: Text(
                  weatherLabel(current.kind).toLowerCase(),
                  style: text.titleLarge?.copyWith(color: QuandoColors.text),
                ),
              ),
            ],
          ),
          if (subtitle.isNotEmpty) Text(subtitle, style: text.bodySmall?.copyWith(color: QuandoColors.blush)),
          DayArc(
            sky: sky,
            marks: marks,
            weather: arcWeather(sky, report, zone),
            nowWeather: skyNow.isDay ? current.kind : null,
            nowLabel: skyNow.isDay ? '${l10n.nowCap} ${hhmm(local)}' : null,
          ),
          Row(
            textDirection: TextDirection.ltr,
            children: [
              Expanded(
                child: Text(
                  sky.sunrise == null ? '' : l10n.sunriseAt(time(sky.sunrise)),
                  style: text.bodySmall?.copyWith(color: QuandoColors.text),
                ),
              ),
              Expanded(
                child: Text(
                  sky.sunset == null ? '' : l10n.sunsetAt(time(sky.sunset)),
                  textAlign: TextAlign.end,
                  style: text.bodySmall?.copyWith(color: QuandoColors.text),
                ),
              ),
            ],
          ),
          if (tonight != null || morning != null) ...[
            const SizedBox(height: 14),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (tonight != null) Expanded(child: later(l10n.weatherTonight, tonight)),
                if (morning != null) Expanded(child: later(l10n.weatherTomorrowMorning, morning)),
              ],
            ),
          ],
          ...footer,
        ],
      ),
    );
  }
}

/// A few fixed stars for the night Moon card.
class _StarsPainter extends CustomPainter {
  const _StarsPainter();
  static const _stars = [
    (.14, .10, 1.2, .7),
    (.31, .20, .9, .5),
    (.49, .07, 1.4, .8),
    (.63, .24, 1.0, .5),
    (.77, .12, 1.2, .6),
    (.91, .22, .9, .5),
    (.42, .33, .8, .4),
  ];
  @override
  void paint(Canvas canvas, Size size) {
    for (final (x, y, r, a) in _stars) {
      canvas.drawCircle(
        Offset(x * size.width, y * size.height),
        r,
        Paint()..color = QuandoColors.text.withValues(alpha: a),
      );
    }
  }

  @override
  bool shouldRepaint(_StarsPainter old) => false;
}
