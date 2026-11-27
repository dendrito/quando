import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/providers.dart';
import '../../../app/theme.dart';
import '../../../core/util/local_time.dart';
import '../../../l10n/l10n.dart';
import '../../shabbat/domain/jewish_times.dart';
import '../../shabbat/domain/place.dart';
import '../data/home_information_providers.dart';
import '../data/weather_repository.dart';
import '../domain/moon.dart';
import '../domain/sky.dart';
import '../domain/sky_weather.dart';
import 'day_arc.dart';
import 'sky_panel.dart';
import 'weather_panel.dart';

/// The optional sky cards: the same sky, drawn four ways.
enum SkyStyle { living, band, ring, timeline }

/// A sky card in one of the [SkyStyle]s. It keeps the app's colours, shows
/// only the times, and follows the real sky and weather right now.
class SkyStyleCard extends ConsumerWidget {
  const SkyStyleCard({super.key, required this.style, required this.sky});
  final SkyStyle style;
  final SkyDay sky;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final place = ref.watch(skyPlaceProvider);
    if (place == null) return const SizedBox(height: 120);
    final options = ref.watch(homeDisplayProvider);
    final weatherPlace = ref.watch(weatherPlaceProvider);
    final report = options.weather && weatherPlace != null
        ? ref
              .watch(
                weatherReportProvider((
                  weatherPlace,
                  ref.watch(weatherRepositoryProvider).pollBucket(sky.now),
                )),
              )
              .value
        : null;
    final current = report?.current(sky.now);
    final nightfall = options.night
        ? JewishTimes(
            place: place,
            havdalah: ref.watch(havdalahProvider),
          ).nightfallOn(inZone(sky.now, place.timeZone))
        : null;
    return _SkyStyleBody(
      style: style,
      sky: SkyDay.of(place, sky.now),
      place: place,
      report: report,
      current: current,
      nightfall: nightfall,
    );
  }
}

class _SkyStyleBody extends StatelessWidget {
  const _SkyStyleBody({
    required this.style,
    required this.sky,
    required this.place,
    required this.report,
    required this.current,
    required this.nightfall,
  });
  final SkyStyle style;
  final SkyDay sky;
  final Place place;
  final WeatherReport? report;
  final WeatherHour? current;
  final DateTime? nightfall;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final zone = place.timeZone;
    final isNight = !sky.isDay;
    String hm(DateTime? at) => at == null ? '—' : hhmm(inZone(at, zone));

    // By day the sky runs sunrise to sunset; by night, from now to the next
    // sunrise, as on the Sun card.
    final rise = sky.sunrise, set = sky.sunset;
    DateTime? nextRise;
    if (isNight) {
      final tomorrow = SkyDay.of(place, sky.now.add(const Duration(days: 1)));
      nextRise = rise != null && sky.now.isBefore(rise) ? rise : tomorrow.sunrise;
    }
    final strip = !isNight && rise != null && set != null
        ? SkyStrip.between(place, rise, set, report, now: sky.now)
        : isNight && nextRise != null
        ? SkyStrip.between(place, sky.now, nextRise, report, now: sky.now)
        : null;
    final (top, bottom) = skyWeatherGradient(sky, current?.kind);

    final weather = current == null
        ? null
        : Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                '${current!.celsius.round()}°',
                style: text.displaySmall?.copyWith(color: DuskColors.text, fontWeight: FontWeight.w800),
              ),
              const SizedBox(width: 10),
              Flexible(
                child: Text(
                  weatherLabel(current!.kind).toLowerCase(),
                  style: text.titleLarge?.copyWith(color: DuskColors.text),
                ),
              ),
            ],
          );
    Text line(String value, {TextAlign align = TextAlign.start}) => Text(
      value,
      textAlign: align,
      style: text.bodySmall?.copyWith(color: DuskColors.text),
    );
    final times = Row(
      textDirection: TextDirection.ltr,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        line(l10n.sunriseAt(hm(isNight ? nextRise : rise))),
        line(l10n.sunsetAt(hm(set))),
        if (nightfall != null) line('${l10n.nightfallLabel} ${hm(nightfall)}', align: TextAlign.end),
      ],
    );
    final BoxDecoration frame = BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      gradient: style == SkyStyle.living && strip != null
          ? LinearGradient(begin: Alignment.centerLeft, end: Alignment.centerRight, colors: strip.colors)
          : style == SkyStyle.living
          ? LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [top, bottom])
          : const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF1A1438), Color(0xFF241B4A)],
            ),
    );
    final body = Padding(
      padding: const EdgeInsets.all(18),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ?weather,
          const SizedBox(height: 12),
          switch (style) {
            SkyStyle.living => _LivingSky(sky: sky, place: place, strip: strip),
            SkyStyle.band => _HorizonBand(sky: sky, place: place, report: report),
            SkyStyle.ring => _DayRing(sky: sky, zone: zone, nightfall: nightfall),
            SkyStyle.timeline => _Timeline(sky: sky, zone: zone, nightfall: nightfall),
          },
          const SizedBox(height: 12),
          times,
        ],
      ),
    );
    return Container(
      key: ValueKey('sky-style-${style.name}'),
      clipBehavior: Clip.antiAlias,
      decoration: frame,
      foregroundDecoration: style == SkyStyle.living && strip != null
          ? const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0x00000000), SkyStrip.shade],
              ),
            )
          : null,
      child: SkyOverlaid(
        stars: style == SkyStyle.living && isNight ? SkyStars(strip?.night, true) : null,
        kinds: style == SkyStyle.living ? strip?.kinds : null,
        child: body,
      ),
    );
  }
}

/// No chart: the card is the sky, with the Sun or the Moon in it.
class _LivingSky extends StatelessWidget {
  const _LivingSky({required this.sky, required this.place, required this.strip});
  final SkyDay sky;
  final Place place;
  final SkyStrip? strip;

  @override
  Widget build(BuildContext context) {
    final p = sky.progress;
    return SizedBox(
      height: 120,
      child: LayoutBuilder(
        builder: (context, box) {
          if (sky.isDay && p != null) {
            final x = (p.clamp(0, 1) * (box.maxWidth - 56)).toDouble();
            return Stack(
              children: [
                Positioned(
                  left: x,
                  top: 30 - 22 * sin(p.clamp(0, 1) * pi),
                  child: Container(
                    width: 56,
                    height: 56,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: DuskColors.amber,
                      boxShadow: [BoxShadow(color: Color(0x88FFB547), blurRadius: 40, spreadRadius: 10)],
                    ),
                  ),
                ),
              ],
            );
          }
          return Align(
            alignment: Alignment.topRight,
            child: MoonDisc(illumination: MoonIllumination.at(sky.now)),
          );
        },
      ),
    );
  }
}

/// A sky that fades from dawn through day to dusk, with now marked.
class _HorizonBand extends StatelessWidget {
  const _HorizonBand({required this.sky, required this.place, required this.report});
  final SkyDay sky;
  final Place place;
  final WeatherReport? report;

  @override
  Widget build(BuildContext context) {
    final rise = sky.sunrise, set = sky.sunset;
    if (rise == null || set == null) return const SizedBox(height: 60);
    const pad = Duration(minutes: 90);
    final start = rise.subtract(pad), end = set.add(pad);
    final strip = SkyStrip.between(place, start, end, report, now: sky.now);
    final t = (sky.now.difference(start).inSeconds / end.difference(start).inSeconds).clamp(0.0, 1.0);
    return SizedBox(
      height: 70,
      child: LayoutBuilder(
        builder: (context, box) => Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned.fill(
              top: 5,
              bottom: 5,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  gradient: LinearGradient(colors: strip.colors),
                ),
              ),
            ),
            Positioned(
              left: t * (box.maxWidth - 6),
              top: 0,
              bottom: 0,
              child: Container(
                width: 6,
                decoration: BoxDecoration(
                  color: DuskColors.text,
                  borderRadius: BorderRadius.circular(4),
                  boxShadow: const [BoxShadow(color: Color(0x88FFFFFF), blurRadius: 10)],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// A 24-hour ring: day, twilight and night, midnight at the bottom.
class _DayRing extends StatelessWidget {
  const _DayRing({required this.sky, required this.zone, required this.nightfall});
  final SkyDay sky;
  final String zone;
  final DateTime? nightfall;

  @override
  Widget build(BuildContext context) {
    final local = inZone(sky.now, zone);
    return SizedBox(
      height: 170,
      child: Center(
        child: SizedBox.square(
          dimension: 170,
          child: CustomPaint(
            painter: _RingPainter(sky: sky, zone: zone, nightfall: nightfall),
            child: Center(
              child: Text(
                hhmm(local),
                style: Theme.of(context).textTheme.headlineMedium
                    ?.copyWith(color: DuskColors.text, fontWeight: FontWeight.w800),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Fraction of the local day (0 at midnight) for [at].
double _dayFraction(DateTime at, String zone) {
  final l = inZone(at, zone);
  return (l.hour * 60 + l.minute + l.second / 60) / 1440;
}

class _RingPainter extends CustomPainter {
  const _RingPainter({required this.sky, required this.zone, required this.nightfall});
  final SkyDay sky;
  final String zone;
  final DateTime? nightfall;

  @override
  void paint(Canvas canvas, Size size) {
    final c = size.center(Offset.zero);
    final radius = size.width / 2 - 14;
    final rect = Rect.fromCircle(center: c, radius: radius);
    // Midnight at the bottom, noon at the top, time running clockwise.
    double angle(double f) => pi / 2 + f * 2 * pi;
    Paint ring(Color color) => Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 18
      ..strokeCap = StrokeCap.butt;
    void arc(double from, double to, Color color) {
      if (to < from) to += 1;
      canvas.drawArc(rect, angle(from), (to - from) * 2 * pi, false, ring(color));
    }

    canvas.drawCircle(c, radius, ring(const Color(0xFF120D2E)));
    final rise = sky.sunrise, set = sky.sunset;
    if (rise != null && set != null) {
      final r = _dayFraction(rise, zone), s = _dayFraction(set, zone);
      const twilight = 45 / 1440;
      arc(r - twilight, r, const Color(0xFFB5476F));
      arc(r, s, DuskColors.amber);
      arc(s, s + twilight, const Color(0xFFB5476F));
    }
    final f = _dayFraction(sky.now, zone);
    final a = angle(f);
    canvas.drawCircle(c + Offset(cos(a), sin(a)) * radius, 8, Paint()..color = DuskColors.text);
  }

  @override
  bool shouldRepaint(_RingPainter old) => old.sky.now != sky.now || old.zone != zone;
}

/// Sunrise, sunset and nightfall as dots on one line, with stars after dark.
class _Timeline extends StatelessWidget {
  const _Timeline({required this.sky, required this.zone, required this.nightfall});
  final SkyDay sky;
  final String zone;
  final DateTime? nightfall;

  @override
  Widget build(BuildContext context) {
    final rise = sky.sunrise, set = sky.sunset;
    return SizedBox(
      height: 90,
      child: LayoutBuilder(
        builder: (context, box) {
          const dot = 22.0;
          double x(DateTime at) =>
              (_dayFraction(at, zone) * (box.maxWidth - dot)).clamp(0, box.maxWidth - dot);
          Widget mark(DateTime? at, Color color, [double size = dot]) => at == null
              ? const SizedBox.shrink()
              : Positioned(
                  left: x(at) - (size - dot) / 2,
                  top: 34 - (size - dot) / 2,
                  child: Container(
                    width: size,
                    height: size,
                    decoration: BoxDecoration(shape: BoxShape.circle, color: color),
                  ),
                );
          return Stack(
            children: [
              Positioned(
                left: 0,
                right: 0,
                top: 44,
                child: Container(height: 3, color: const Color(0x55FFF4E6)),
              ),
              mark(rise, DuskColors.amber),
              mark(set, DuskColors.coral),
              mark(nightfall, const Color(0xFFB5476F)),
              mark(sky.now, DuskColors.text, 30),
              if (nightfall != null)
                Positioned(
                  left: x(nightfall!),
                  top: 0,
                  child: Text(
                    '✦ ✦',
                    style: TextStyle(color: DuskColors.text.withAlpha(200), letterSpacing: 6),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
