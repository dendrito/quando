import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/providers.dart';
import '../../../app/theme.dart';
import '../../home/data/weather_repository.dart';
import '../data/weather_alarm_providers.dart';
import '../domain/weather_alarms.dart';

/// Weather reminders: ring a chosen number of times before rain,
/// thunderstorm or snow is forecast.
// TODO(weather-alarms): move these texts into the translations.
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

  static String _leadName(Duration d) => d.inMinutes < 60
      ? '${d.inMinutes} minutes before'
      : '${d.inHours} ${d.inHours == 1 ? 'hour' : 'hours'} before';

  static String _kindName(WeatherKind k) => switch (k) {
    WeatherKind.thunder => 'Thunderstorm',
    WeatherKind.snow => 'Snow',
    WeatherKind.fog => 'Fog',
    _ => 'Rain',
  };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final text = Theme.of(context).textTheme;
    final s = ref.watch(weatherAlarmSettingsProvider);
    final alerts = ref.watch(weatherAlertsProvider);
    final hasPlace = ref.watch(skyPlaceProvider) != null;
    void update(WeatherAlarmSettings Function(WeatherAlarmSettings) f) =>
        ref.read(weatherAlarmSettingsProvider.notifier).update(f);
    void setReminder(int i, WeatherReminder r) =>
        update((s) => s.copyWith(reminders: [...s.reminders]..[i] = r));

    return Scaffold(
      appBar: AppBar(title: const Text('Weather reminders'), backgroundColor: Colors.transparent),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(24, 8, 24, 48),
        children: [
          Text(
            'Get reminders before it rains, storms or snows, as many as you want. '
            'Quando? checks the forecast whenever you open it and sets the reminders on your phone.',
            style: text.bodyMedium,
          ),
          const SizedBox(height: 12),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Weather reminders'),
            value: s.enabled,
            onChanged: (v) => update((s) => s.copyWith(enabled: v)),
          ),
          if (s.enabled && !hasPlace)
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.warning_amber_rounded, color: Colors.orangeAccent),
              title: Text(
                'Choose your place on the home screen first, so there is a forecast to read.',
                style: text.bodySmall,
              ),
            ),
          if (s.enabled) ...[
            const SizedBox(height: 8),
            Text('WHICH WEATHER', style: text.labelSmall),
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
            Text('WHEN', style: text.labelSmall),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Any time of day'),
              subtitle: Text('Before the weather arrives, whatever you are doing.', style: text.bodySmall),
              value: s.anytime,
              onChanged: (v) => update((s) => s.copyWith(anytime: v)),
            ),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Before my alarms and calendar events'),
              subtitle: Text(
                'When the forecast has that weather around an alarm or event, remind me ahead of it, '
                'for example before leaving for work.',
                style: text.bodySmall,
              ),
              value: s.tied,
              onChanged: (v) => update((s) => s.copyWith(tied: v)),
            ),
            const SizedBox(height: 16),
            Text('REMINDERS', style: text.labelSmall),
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
                    segments: const [
                      ButtonSegment(value: true, label: Text('Alarm')),
                      ButtonSegment(value: false, label: Text('Soft')),
                    ],
                    selected: {s.reminders[i].loud},
                    onSelectionChanged: (v) => setReminder(i, s.reminders[i].copyWith(loud: v.first)),
                  ),
                  IconButton(
                    tooltip: 'Remove',
                    icon: const Icon(Icons.close),
                    onPressed: () => update((s) => s.copyWith(reminders: [...s.reminders]..removeAt(i))),
                  ),
                ],
              ),
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton.icon(
                icon: const Icon(Icons.add),
                label: const Text('Add a reminder'),
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
            Text('COMING UP', style: text.labelSmall),
            if (alerts.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text('Nothing in the forecast for the next two days.', style: text.bodySmall),
              )
            else
              for (final a in alerts.where((a) => a.at.isAfter(DateTime.now())).take(12))
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  dense: true,
                  leading: Icon(a.loud ? Icons.alarm : Icons.notifications_none, color: QuandoColors.amber),
                  title: Text('${_kindName(a.kind)}${a.anchorTitle == null ? '' : ' · ${a.anchorTitle}'}'),
                  subtitle: Text('Rings ${_when(a.at)}'),
                ),
            const SizedBox(height: 12),
            Text(
              'Forecasts change. Quando? updates these reminders whenever you open it. '
              'On Android and iPhone it cannot read a new forecast while closed yet.',
              style: text.bodySmall,
            ),
          ],
        ],
      ),
    );
  }

  static String _when(DateTime utc) {
    final t = utc.toLocal();
    final hm = '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}';
    final today = DateTime.now();
    final sameDay = t.year == today.year && t.month == today.month && t.day == today.day;
    return sameDay ? 'today $hm' : '${t.day}/${t.month} $hm';
  }
}
