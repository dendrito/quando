import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/providers.dart';
import '../../../app/theme.dart';
import '../../../core/util/platform.dart';
import '../../../l10n/l10n.dart';
import '../../home/data/weather_repository.dart';
import '../../shabbat/ui/city_picker.dart';
import '../data/weather_alarm_alarms.dart';
import '../data/weather_alarm_providers.dart';
import '../domain/weather_alarms.dart';

/// Weather reminders: ring a chosen number of times before rain,
/// thunderstorm or snow is forecast.
class WeatherAlarmsScreen extends ConsumerWidget {
  const WeatherAlarmsScreen({super.key});

  static const _leads = [
    Duration(minutes: 10),
    Duration(minutes: 15),
    Duration(minutes: 30),
    Duration(minutes: 45),
    Duration(hours: 1),
    Duration(hours: 2),
    Duration(hours: 3),
    Duration(hours: 6),
    Duration(hours: 12),
    Duration(hours: 24),
  ];

  static String _leadName(Duration d) =>
      d.inMinutes < 60 ? l10n.weatherLeadMinutes(d.inMinutes) : l10n.weatherLeadHours(d.inHours);

  static String _kindName(WeatherKind k) => switch (k) {
    WeatherKind.thunder => l10n.weatherThunder,
    WeatherKind.snow => l10n.weatherSnow,
    WeatherKind.fog => l10n.weatherFog,
    _ => l10n.weatherRain,
  };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final text = Theme.of(context).textTheme;
    final s = ref.watch(weatherAlarmSettingsProvider);
    final alerts = ref.watch(weatherAlertsProvider);
    final hasPlace = ref.watch(weatherPlaceProvider) != null;
    final shabbat = ref.watch(shabbatInUseProvider);
    final loc = MaterialLocalizations.of(context);
    String clock(int minutes) => loc.formatTimeOfDay(TimeOfDay(hour: minutes ~/ 60, minute: minutes % 60));
    void update(WeatherAlarmSettings Function(WeatherAlarmSettings) f) =>
        ref.read(weatherAlarmSettingsProvider.notifier).update(f);
    void setReminder(int i, WeatherReminder r) =>
        update((s) => s.copyWith(reminders: [...s.reminders]..[i] = r));

    Future<void> pickTime(int current, void Function(int minutes) set) async {
      final t = await showTimePicker(
        context: context,
        initialTime: TimeOfDay(hour: current ~/ 60, minute: current % 60),
      );
      if (t != null) set(t.hour * 60 + t.minute);
    }

    String when(DateTime utc) {
      final t = utc.toLocal();
      final time = loc.formatTimeOfDay(TimeOfDay.fromDateTime(t));
      final now = DateTime.now();
      final today = t.year == now.year && t.month == now.month && t.day == now.day;
      return today ? time : '${loc.formatShortDate(t)} $time';
    }

    return Scaffold(
      appBar: AppBar(title: Text(l10n.weatherRemindersTitle), backgroundColor: Colors.transparent),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(24, 8, 24, 48),
        children: [
          Text(l10n.weatherIntro, style: text.bodyMedium),
          const SizedBox(height: 4),
          Text(isAndroid ? l10n.weatherBackgroundNote : l10n.weatherOpenNote, style: text.bodySmall),
          const SizedBox(height: 12),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(l10n.weatherRemindersTitle),
            value: s.enabled,
            onChanged: (v) => update((s) => s.copyWith(enabled: v)),
          ),
          if (s.enabled) ...[
            Builder(
              builder: (context) {
                final weatherPlace = ref.watch(weatherPlaceProvider);
                final own = ref.watch(weatherLocationProvider) != null;
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(own ? Icons.my_location : Icons.place_outlined),
                  title: Text(weatherPlace?.name ?? l10n.skyChooseCity),
                  onTap: () => Navigator.of(context).push<void>(
                    MaterialPageRoute(builder: (_) => const CityPicker(forWeather: true)),
                  ),
                );
              },
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.my_location),
              title: Text(l10n.useMyLocation),
              onTap: () => Navigator.of(context).push<void>(
                MaterialPageRoute(builder: (_) => const CityPicker(forWeather: true, locateOnOpen: true)),
              ),
            ),
          ],
          if (s.enabled && !hasPlace)
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.warning_amber_rounded, color: Colors.orangeAccent),
              title: Text(l10n.weatherNoPlace, style: text.bodySmall),
            ),
          if (s.enabled) ...[
            const SizedBox(height: 8),
            Text(l10n.weatherWhichHeading.toUpperCase(), style: text.labelSmall),
            Wrap(
              spacing: 8,
              children: [
                for (final k in weatherAlarmKinds)
                  FilterChip(
                    label: Text(_kindName(k)),
                    selected: s.kinds.contains(k),
                    onSelected: (on) =>
                        update((s) => s.copyWith(kinds: on ? {...s.kinds, k} : ({...s.kinds}..remove(k)))),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            Text(l10n.weatherWhenHeading.toUpperCase(), style: text.labelSmall),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(l10n.weatherAnytime),
              subtitle: Text(l10n.weatherAnytimeHint, style: text.bodySmall),
              value: s.anytime,
              onChanged: (v) => update((s) => s.copyWith(anytime: v)),
            ),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(l10n.weatherTied),
              subtitle: Text(l10n.weatherTiedHint, style: text.bodySmall),
              value: s.tied,
              onChanged: (v) => update((s) => s.copyWith(tied: v)),
            ),
            const SizedBox(height: 16),
            Text(l10n.weatherRemindersHeading.toUpperCase(), style: text.labelSmall),
            for (var i = 0; i < s.reminders.length; i++)
              Row(
                children: [
                  Expanded(
                    child: DropdownButton<Duration>(
                      isExpanded: true,
                      value: _leads.contains(s.reminders[i].lead) ? s.reminders[i].lead : null,
                      hint: Text(_leadName(s.reminders[i].lead)),
                      items: [for (final d in _leads) DropdownMenuItem(value: d, child: Text(_leadName(d)))],
                      onChanged: (d) {
                        if (d != null) setReminder(i, s.reminders[i].copyWith(lead: d));
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  SegmentedButton<bool>(
                    showSelectedIcon: false,
                    segments: [
                      ButtonSegment(value: true, label: Text(l10n.weatherAlarmOption)),
                      ButtonSegment(value: false, label: Text(l10n.weatherSoftOption)),
                    ],
                    selected: {s.reminders[i].loud},
                    onSelectionChanged: (v) => setReminder(i, s.reminders[i].copyWith(loud: v.first)),
                  ),
                  IconButton(
                    tooltip: l10n.weatherRemove,
                    icon: const Icon(Icons.close),
                    onPressed: () => update((s) => s.copyWith(reminders: [...s.reminders]..removeAt(i))),
                  ),
                ],
              ),
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: TextButton.icon(
                icon: const Icon(Icons.add),
                label: Text(l10n.weatherAddReminder),
                onPressed: () {
                  final used = s.reminders.map((r) => r.lead).toSet();
                  final next = _leads.firstWhere((d) => !used.contains(d), orElse: () => _leads.first);
                  update(
                    (s) => s.copyWith(
                      reminders: [
                        ...s.reminders,
                        WeatherReminder(lead: next),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            Text(l10n.weatherQuietHeading.toUpperCase(), style: text.labelSmall),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(l10n.weatherQuietSwitch),
              subtitle: Text(l10n.weatherQuietHint, style: text.bodySmall),
              value: s.quiet,
              onChanged: (v) => update((s) => s.copyWith(quiet: v)),
            ),
            if (s.quiet)
              Row(
                children: [
                  Expanded(
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(l10n.weatherQuietFrom),
                      subtitle: Text(clock(s.quietStart)),
                      onTap: () => pickTime(s.quietStart, (m) => update((s) => s.copyWith(quietStart: m))),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(l10n.weatherQuietTo),
                      subtitle: Text(clock(s.quietEnd)),
                      onTap: () => pickTime(s.quietEnd, (m) => update((s) => s.copyWith(quietEnd: m))),
                    ),
                  ),
                ],
              ),
            const SizedBox(height: 16),
            Text(l10n.weatherComingUp.toUpperCase(), style: text.labelSmall),
            if (alerts.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(l10n.weatherNothingComing, style: text.bodySmall),
              )
            else
              for (final a in alerts.where((a) => a.at.isAfter(DateTime.now())).take(12))
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  dense: true,
                  leading: Icon(a.loud ? Icons.alarm : Icons.notifications_none, color: QuandoColors.amber),
                  title: Text(weatherTitle(a.kind)),
                  subtitle: Text(l10n.weatherRingsAt(when(a.at))),
                ),
            if (shabbat) ...[
              const SizedBox(height: 12),
              Text(l10n.weatherShabbatNote, style: text.bodySmall),
            ],
          ],
        ],
      ),
    );
  }
}
