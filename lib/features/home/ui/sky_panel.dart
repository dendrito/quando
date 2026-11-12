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
import '../domain/moon.dart';
import '../domain/moon_phases.dart';
import '../domain/moon_backdrop.dart';
import '../data/home_information_providers.dart';
import '../data/weather_repository.dart';
import '../domain/sky.dart';
import '../domain/sky_weather.dart';
import 'day_arc.dart';
import 'moon_details.dart';
import 'weather_overlay.dart';
import 'weather_panel.dart';
import 'place_sheet.dart';
import 'home_display_controls.dart';

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

/// One of the sky cards, for showing it on its own.
enum SkyCard { sun, moon, phase, weather }

class SkyPanel extends ConsumerStatefulWidget {
  const SkyPanel({super.key, required this.sky, this.marks = const [], this.only, this.simple = false});
  final SkyDay sky;
  final List<double> marks;

  /// Shows just one of the cards, with no tabs: [SkyCard.sun], [SkyCard.moon]
  /// or [SkyCard.weather]. null shows them all as swipeable pages.
  final SkyCard? only;

  /// Simple level: just the day's sky, with no tabs, city or display buttons.
  final bool simple;
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
    final weatherPlace = ref.watch(weatherPlaceProvider);
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
        if (place == null)
          TextButton.icon(
            onPressed: () => showPlaceSheet(context),
            icon: const Icon(Icons.place_outlined),
            label: Text(l10n.skyChooseCity),
          ),
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
    // The card follows the sky right now: a starry night, or the day's sky.
    final skyNow = place == null ? sky : SkyDay.of(place, sky.now);
    final nightCard = !skyNow.isDay;
    final bucket = ref.watch(weatherRepositoryProvider).pollBucket(sky.now);
    final report = options.weather && weatherPlace != null
        ? ref.watch(weatherReportProvider((weatherPlace, bucket))).value
        : null;
    final current = report?.current(sky.now);
    final moonSky = place != null && track != null ? SkyStrip.ofMoon(place, track, report) : null;
    final nightfallText = nightfall == null
        ? null
        : '${l10n.nightfallLabel} ${time(nightfall, '—')} · ${ref.watch(havdalahProvider) == HavdalahOpinion.geonim ? '8.5°' : '+72m'}';
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
    // The Moon card's sky runs from night to day along the Moon's pass, so a
    // pass that crosses sunrise or sunset fades between the two, and one that
    // is mostly in daylight reads like the Sun's day card. The weather is
    // drawn the same way as on the Sun.
    Widget moonCard({required bool compact}) {
      final stars = moonSky != null ? moonSky.maxNight > .15 : nightCard;
      final local = inZone(sky.now, zone);
      return Container(
        key: ValueKey(compact ? 'moon-night-sun-card' : 'moon-daylight-background'),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: moonSky == null ? Alignment.topCenter : Alignment.centerLeft,
            end: moonSky == null ? Alignment.bottomCenter : Alignment.centerRight,
            colors: moonSky != null
                ? moonSky.colors
                : nightCard
                ? const [Color(0xFF141033), Color(0xFF1E1846), Color(0xFF2B1F4E)]
                : [skyNow.color, Color.lerp(skyNow.color, QuandoColors.ground, .35)!],
          ),
        ),
        foregroundDecoration: moonSky == null
            ? null
            : BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0x00000000), SkyStrip.shade],
                ),
              ),
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: details == null ? null : () => showMoonDetails(context, details),
            child: CustomPaint(
              painter: stars ? _StarsPainter(moonSky?.night) : null,
              child: _Overlaid(
                kinds: moonSky?.kinds,
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (current != null)
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Text(
                              '${current.celsius.round()}°',
                              style: text.displaySmall?.copyWith(
                                color: QuandoColors.text,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Flexible(
                              child: Text(
                                weatherLabel(current.kind).toLowerCase(),
                                style: text.titleLarge?.copyWith(color: QuandoColors.text),
                              ),
                            ),
                          ],
                        )
                      else
                        Text(l10n.skyMoon, style: text.titleMedium),
                      if (track != null && illumination != null) ...[
                        Text(
                          track.above ? l10n.moonAboveHorizon : l10n.moonBelowHorizon,
                          style: text.bodySmall,
                        ),
                        MoonArc(
                          track: track,
                          illumination: illumination,
                          daylight: place == null ? null : MoonBackdrop.daylightForTrack(place, track),
                          weather: report == null ? const [] : moonArcWeather(track, report, zone),
                          nowWeather: current?.kind,
                          nowLabel: current == null ? null : '${l10n.nowCap} ${hhmm(local)}',
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
                      if (!compact && illumination != null && phases != null) ...[
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
                                Text(
                                  '${l10n.moonNextNew} · ${phaseTime(phases.newMoon)}',
                                  style: text.bodySmall,
                                ),
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
                                    child: Align(
                                      alignment: Alignment.topRight,
                                      heightFactor: 1,
                                      child: dates,
                                    ),
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
        ),
      );
    }

    final moonContent = moonCard(compact: false);

    // After sunset and before sunrise the Sun page shows the night sky with
    // the Moon's path and the weather; by day it is the Sun's own arc.
    final nightMoonCard =
        options.weather && options.moon && nightCard && illumination != null && track != null;
    final Widget sunContent = options.weather && weatherPlace != null && _page == 0
        ? nightMoonCard
              ? moonCard(compact: true)
              : _SunWeatherCard(
                  sky: sky,
                  place: weatherPlace,
                  zone: zone,
                  marks: widget.marks,
                  fallback: plainSun,
                  nightfall: nightfallText,
                  footer: [
                    if (moon != null && moon.alwaysUp) Text(l10n.moonAlwaysUp, style: text.bodySmall),
                    if (moon != null && moon.alwaysDown) Text(l10n.moonAlwaysDown, style: text.bodySmall),
                  ],
                )
        : plainSun;

    // Pages before the Moon's: the Sun's, unless it is hidden.
    final lead = options.sun ? 1 : 0;
    final pages = <({String label, Widget child})>[
      if (options.sun) (label: l10n.skySun, child: sunContent),
      if (options.moon) (label: l10n.skyMoon, child: moonContent),
      if (options.moon && options.moonDetails && details != null) (label: l10n.skyMoonPhase, child: details),
      if (options.weather && weatherPlace != null)
        (
          label: l10n.weatherLabel,
          child: WeatherPanel(
            now: sky.now,
            active: _page == lead + (options.moon ? 1 : 0) + (options.moon && options.moonDetails ? 1 : 0),
            place: weatherPlace,
          ),
        ),
    ];
    if (widget.only case final only?) {
      return switch (only) {
        SkyCard.sun => options.sun ? sunContent : const SizedBox.shrink(),
        SkyCard.moon => options.moon ? moonCard(compact: true) : const SizedBox.shrink(),
        SkyCard.phase => details ?? const SizedBox.shrink(),
        SkyCard.weather =>
          options.weather && weatherPlace != null
              ? WeatherPanel(now: sky.now, active: true, place: weatherPlace)
              : const SizedBox.shrink(),
      };
    }
    if (pages.isEmpty) return const SizedBox.shrink();
    if (widget.simple) return options.sun ? sunContent : const SizedBox.shrink();
    final onDetailsPage = options.moon && options.moonDetails && details != null && _page == lead + 1;
    if (_page >= pages.length) {
      _page = 0;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted && _pager.hasClients) _pager.jumpToPage(0);
      });
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: pages.length == 1
                  ? const SizedBox.shrink()
                  : SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
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
                    ),
            ),
            IconButton(
              tooltip: l10n.homePlaceTitle,
              icon: const Icon(Icons.place_outlined),
              onPressed: () => showPlaceSheet(context),
            ),
            IconButton(
              tooltip: l10n.homeDisplay,
              icon: const Icon(Icons.tune),
              onPressed: () => showHomeDisplayControls(context),
            ),
          ],
        ),
        if (pages.length == 1)
          sunContent
        else ...[
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
                    : _page == lead && options.moon
                    ? (constraints.maxWidth - 36 >= 700 * MediaQuery.textScalerOf(context).scale(1)
                              ? 300
                              : 390) *
                          (report == null ? 1 : 1.2) *
                          MediaQuery.textScalerOf(context).scale(1).clamp(1, 2)
                    : options.sun && _page == 0 && options.weather && weatherPlace != null
                    ? (nightMoonCard ? 300 : 370) * MediaQuery.textScalerOf(context).scale(1).clamp(1, 2)
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
    this.nightfall,
  });
  final SkyDay sky;
  final Place place;
  final String zone;
  final List<double> marks;
  final Widget fallback;
  final List<Widget> footer;

  /// "Nightfall 18:45 · 8.5°", shown at the right of the Tonight row.
  final String? nightfall;

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
    // By day the card's sky runs from sunrise (left) to sunset (right), with
    // the forecast weather blended along it, as on the Moon card.
    final rise = sky.sunrise, set = sky.sunset;
    final strip = skyNow.isDay && rise != null && set != null
        ? SkyStrip.between(place, rise, set, report, now: sky.now)
        : null;
    return Container(
      key: const ValueKey('sun-weather-card'),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: strip == null
            ? LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [top, bottom])
            : LinearGradient(begin: Alignment.centerLeft, end: Alignment.centerRight, colors: strip.colors),
      ),
      foregroundDecoration: strip == null
          ? null
          : BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0x00000000), SkyStrip.shade],
              ),
            ),
      child: _Overlaid(
        kinds: strip?.kinds,
        child: Padding(
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
              if (subtitle.isNotEmpty)
                Text(subtitle, style: text.bodySmall?.copyWith(color: QuandoColors.blush)),
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
              if (tonight != null || morning != null || nightfall != null) ...[
                const SizedBox(height: 14),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (tonight != null) Expanded(child: later(l10n.weatherTonight, tonight)),
                    if (morning != null) Expanded(child: later(l10n.weatherTomorrowMorning, morning)),
                    if (nightfall != null)
                      Expanded(
                        child: Text(
                          nightfall!,
                          textAlign: TextAlign.end,
                          style: text.bodySmall?.copyWith(color: QuandoColors.text),
                        ),
                      ),
                  ],
                ),
              ],
              ...footer,
            ],
          ),
        ),
      ),
    );
  }
}

/// [child] with the falling weather of [kinds] drawn behind it, when any is
/// forecast.
class _Overlaid extends StatelessWidget {
  const _Overlaid({required this.kinds, required this.child});
  final List<WeatherKind?>? kinds;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final k = kinds;
    if (k == null || !WeatherOverlay.needed(k)) return child;
    return Stack(
      children: [
        WeatherOverlay(kinds: k),
        child,
      ],
    );
  }
}

/// A few fixed stars for the night Moon card.
class _StarsPainter extends CustomPainter {
  /// [night] is how dark the sky is from left to right (0 day, 1 night);
  /// the stars fade out where it is day. Null means all night.
  const _StarsPainter([this.night]);
  final List<double>? night;
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
      var dark = 1.0;
      final n = night;
      if (n != null && n.length > 1) {
        final at = (x * (n.length - 1)).clamp(0, n.length - 1.0), i = at.floor();
        final j = (i + 1).clamp(0, n.length - 1);
        dark = n[i] + (n[j] - n[i]) * (at - i);
      }
      canvas.drawCircle(
        Offset(x * size.width, y * size.height),
        r,
        Paint()..color = QuandoColors.text.withValues(alpha: a * dark),
      );
    }
  }

  @override
  bool shouldRepaint(_StarsPainter old) => old.night != night;
}
