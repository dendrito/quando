import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../app/providers.dart';
import '../../../app/theme.dart';
import '../../../core/util/local_time.dart';
import '../../../l10n/l10n.dart';
import '../data/home_information_providers.dart';
import '../data/weather_repository.dart';
import 'weather_motion.dart';

String weatherLabel(WeatherKind kind) => switch (kind) {
  WeatherKind.clear => l10n.weatherClear,
  WeatherKind.clouds => l10n.weatherClouds,
  WeatherKind.rain => l10n.weatherRain,
  WeatherKind.snow => l10n.weatherSnow,
  WeatherKind.fog => l10n.weatherFog,
  WeatherKind.thunder => l10n.weatherThunder,
};

class WeatherPanel extends ConsumerStatefulWidget {
  const WeatherPanel({super.key, required this.now, required this.active});
  final DateTime now;
  final bool active;
  @override
  ConsumerState<WeatherPanel> createState() => _WeatherPanelState();
}

class _WeatherPanelState extends ConsumerState<WeatherPanel> with WidgetsBindingObserver {
  bool _foreground = true;
  @override
  void initState() {
    super.initState();
    _foreground =
        WidgetsBinding.instance.lifecycleState == null ||
        WidgetsBinding.instance.lifecycleState == AppLifecycleState.resumed;
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (mounted) setState(() => _foreground = state == AppLifecycleState.resumed);
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.active || !_foreground) return Center(child: Text(l10n.weatherLabel));
    final place = ref.watch(placeProvider), repo = ref.watch(weatherRepositoryProvider);
    final key = (place, repo.pollBucket(widget.now));
    final report = ref.watch(weatherReportProvider(key));
    final text = Theme.of(context).textTheme;
    return report.when(
      loading: () => const Center(child: SizedBox(width: 24, height: 24, child: CircularProgressIndicator())),
      error: (_, _) => Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(l10n.weatherUnavailable),
            TextButton(
              onPressed: () => ref.invalidate(weatherReportProvider(key)),
              child: Text(l10n.homeRefresh),
            ),
          ],
        ),
      ),
      data: (data) {
        final current = data.current(widget.now);
        if (current == null) return Center(child: Text(l10n.weatherUnavailable));
        final upcoming = data.hours
            .where((h) => h.at.isAfter(widget.now) && h.at.difference(widget.now) <= const Duration(hours: 3))
            .toList();
        final thunder = upcoming.where((h) => h.kind == WeatherKind.thunder).firstOrNull;
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                WeatherMotion(
                  kind: thunder?.kind ?? current.kind,
                  night: current.night,
                  active: widget.active,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${current.celsius.round()}°C',
                        style: text.displaySmall?.copyWith(color: QuandoColors.text),
                      ),
                      Text(weatherLabel(current.kind), style: text.titleMedium),
                      if (thunder != null && current.kind != WeatherKind.thunder)
                        Text(
                          '${l10n.weatherThunderExpected} · ${hhmm(inZone(thunder.at, place.timeZone))}',
                          style: text.bodySmall,
                        ),
                    ],
                  ),
                ),
              ],
            ),
            Wrap(
              alignment: WrapAlignment.spaceBetween,
              spacing: 12,
              children: [
                for (final h in upcoming)
                  Text(
                    '${hhmm(inZone(h.at, place.timeZone))}  ${h.celsius.round()}°',
                    style: text.bodySmall?.copyWith(color: QuandoColors.blush),
                  ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              '${data.stale ? l10n.weatherCached : l10n.weatherForecast} · ${l10n.weatherUpdated} ${hhmm(inZone(data.fetched, place.timeZone))}',
              style: text.bodySmall,
            ),
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(0, 32),
                  foregroundColor: QuandoColors.blush,
                ),
                onPressed: () => showDialog<void>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('MET Norway'),
                    content: Text(l10n.weatherSource),
                    actions: [
                      TextButton(
                        onPressed: () => launchUrl(
                          Uri.parse('https://api.met.no/doc/License'),
                          mode: LaunchMode.externalApplication,
                        ),
                        child: const Text('CC BY 4.0'),
                      ),
                      TextButton(onPressed: () => Navigator.pop(context), child: Text(l10n.done)),
                    ],
                  ),
                ),
                child: Text(l10n.weatherSource, style: text.bodySmall),
              ),
            ),
          ],
        );
      },
    );
  }
}
