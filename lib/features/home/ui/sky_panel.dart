import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/providers.dart';
import '../../../app/theme.dart';
import '../../../core/util/local_time.dart';
import '../../../l10n/l10n.dart';
import '../../shabbat/domain/jewish_times.dart';
import '../domain/moon.dart';
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
    final options = ref.watch(homeDisplayProvider), place = ref.watch(placeProvider), sky = widget.sky;
    final text = Theme.of(context).textTheme;
    final moon = options.night ? MoonDay.of(place, sky.now) : null;
    final illumination = options.moon ? MoonIllumination.at(sky.now) : null;
    final nightfall = options.night
        ? JewishTimes(
            place: place,
            havdalah: ref.watch(havdalahProvider),
          ).nightfallOn(inZone(sky.now, place.timeZone))
        : null;
    String time(DateTime? at, String absent) => at == null ? absent : hhmm(inZone(at, place.timeZone));
    final content = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        DayArc(sky: sky, marks: widget.marks),
        Row(
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
        if (moon != null) ...[
          const SizedBox(height: 10),
          Wrap(
            spacing: 16,
            runSpacing: 6,
            children: [
              Text('☾ ${l10n.moonriseLabel} ≈ ${time(moon.rise, l10n.noRiseToday)}', style: text.bodySmall),
              Text('☾ ${l10n.moonsetLabel} ≈ ${time(moon.set, l10n.noSetToday)}', style: text.bodySmall),
              Text(
                '✦ ${l10n.nightfallLabel} ${time(nightfall, '—')} · ${ref.watch(havdalahProvider) == HavdalahOpinion.geonim ? '8.5°' : '+72m'}',
                style: text.bodySmall,
              ),
              if (moon.alwaysUp) Text(l10n.moonAlwaysUp, style: text.bodySmall),
              if (moon.alwaysDown) Text(l10n.moonAlwaysDown, style: text.bodySmall),
            ],
          ),
        ],
        if (illumination != null)
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              '${const ['🌑', '🌒', '🌓', '🌔', '🌕', '🌖', '🌗', '🌘'][illumination.phaseIndex]} ${moonPhaseLabel(illumination.phaseIndex)} · ${(illumination.fraction * 100).round()}% ${l10n.moonIlluminated}',
              style: text.bodySmall,
            ),
          ),
      ],
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                l10n.timesIn(place.name, place.timeZone),
                style: text.bodySmall?.copyWith(color: QuandoColors.blush),
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
        if (!options.weather)
          content
        else ...[
          Row(
            children: [
              TextButton(
                onPressed: () => _toPage(context, 0),
                child: Text(
                  options.night ? l10n.skyDayNight : l10n.skyDay,
                  style: TextStyle(color: _page == 0 ? QuandoColors.amber : QuandoColors.blush),
                ),
              ),
              TextButton(
                onPressed: () => _toPage(context, 1),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      l10n.weatherLabel,
                      style: TextStyle(color: _page == 1 ? QuandoColors.amber : QuandoColors.blush),
                    ),
                    const SizedBox(width: 4),
                    const Icon(Icons.chevron_right, size: 16),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: max(228.0, 170.0 + (options.night ? 90 : 0) + (options.moon ? 45 : 0)),
            child: PageView(
              controller: _pager,
              onPageChanged: (p) => setState(() => _page = p),
              children: [
                SingleChildScrollView(child: content),
                SingleChildScrollView(
                  child: WeatherPanel(now: sky.now, active: _page == 1),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}
