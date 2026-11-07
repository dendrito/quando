import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/edition.dart';
import '../../../app/providers.dart';
import '../../../l10n/l10n.dart';

String courseLabel(String id) => switch (id) {
  'daf' => l10n.courseDaf,
  'rambam1' => l10n.courseRambam1,
  'rambam3' => l10n.courseRambam3,
  'mitzvot' => l10n.courseMitzvot,
  'mishnah' => l10n.courseMishnah,
  'nach' => l10n.courseNach,
  _ => id,
};

Future<void> showHomeDisplayControls(BuildContext context) => showModalBottomSheet<void>(
  context: context,
  showDragHandle: true,
  isScrollControlled: true,
  builder: (context) => Consumer(
    builder: (context, ref, _) {
      final s = ref.watch(homeDisplayProvider), n = ref.read(homeDisplayProvider.notifier);
      return SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(l10n.homeDisplay, style: Theme.of(context).textTheme.titleLarge),
                ),
                SwitchListTile(
                  title: Text(l10n.skyDayNight),
                  subtitle: Text('${l10n.moonriseLabel} · ${l10n.moonsetLabel} · ${l10n.nightfallLabel}'),
                  value: s.night,
                  onChanged: (v) => n.set(s.copyWith(night: v)),
                ),
                SwitchListTile(
                  title: Text(l10n.skyMoonDisplay),
                  value: s.moon,
                  onChanged: (v) => n.set(s.copyWith(moon: v)),
                ),
                if (s.moon)
                  SwitchListTile(
                    title: Text(l10n.skyMoonDetailsDisplay),
                    subtitle: Text(l10n.skyMoonDetailsHint),
                    value: s.moonDetails,
                    onChanged: (v) => n.set(s.copyWith(moonDetails: v)),
                  ),
                SwitchListTile(
                  title: Text(l10n.weatherLabel),
                  subtitle: Text(l10n.weatherConsent),
                  value: s.weather,
                  onChanged: (v) => n.set(s.copyWith(weather: v)),
                ),
                SwitchListTile(
                  title: Text(l10n.parashaHeading),
                  value: s.parasha,
                  onChanged: (v) => n.set(s.copyWith(parasha: v)),
                ),
                SwitchListTile(
                  title: Text(l10n.roshHodeshHeading),
                  subtitle: Text(l10n.roshHodeshExplain),
                  value: s.roshHodesh,
                  onChanged: (v) => n.set(s.copyWith(roshHodesh: v)),
                ),
                if (jewishHome) ...[
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text(l10n.dailyStudyHeading, style: Theme.of(context).textTheme.titleMedium),
                  ),
                  for (final id in ['daf', 'rambam1', 'rambam3', 'mitzvot', 'mishnah', 'nach'])
                    SwitchListTile(
                      title: Text(courseLabel(id)),
                      value: s.courses.contains(id),
                      onChanged: (on) {
                        final chosen = {...s.courses};
                        on ? chosen.add(id) : chosen.remove(id);
                        n.set(s.copyWith(courses: chosen));
                      },
                    ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text(l10n.learningConsent, style: Theme.of(context).textTheme.bodySmall),
                  ),
                ],
              ],
            ),
          ),
        ),
      );
    },
  ),
);
