import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/edition.dart';
import '../../../app/providers.dart';
import '../../../l10n/l10n.dart';
import '../../shabbat/domain/hebrew_date.dart';
import '../domain/home_display.dart';

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
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (!jewishHome) ...[
                        Text(l10n.homeLayout, style: Theme.of(context).textTheme.bodyLarge),
                        const SizedBox(height: 8),
                        SegmentedButton<HomeStyle>(
                          key: const ValueKey('home-style'),
                          showSelectedIcon: false,
                          segments: [
                            ButtonSegment(value: HomeStyle.classic, label: Text(l10n.homeLayoutClassic)),
                            ButtonSegment(value: HomeStyle.cards, label: Text(l10n.homeLayoutCards)),
                          ],
                          selected: {s.cardsOn(MediaQuery.sizeOf(context).width) ? HomeStyle.cards : HomeStyle.classic},
                          onSelectionChanged: (v) => n.set(s.copyWith(style: v.first)),
                        ),
                        const SizedBox(height: 16),
                      ],
                      Text(l10n.homeClockSize, style: Theme.of(context).textTheme.bodyLarge),
                      const SizedBox(height: 8),
                      SegmentedButton<ClockSize>(
                        key: const ValueKey('clock-size'),
                        showSelectedIcon: false,
                        segments: [
                          ButtonSegment(value: ClockSize.large, label: Text(l10n.sizeLarge)),
                          ButtonSegment(value: ClockSize.medium, label: Text(l10n.sizeMedium)),
                          ButtonSegment(value: ClockSize.small, label: Text(l10n.sizeSmall)),
                          ButtonSegment(value: ClockSize.off, label: Text(l10n.off)),
                        ],
                        selected: {s.clock},
                        onSelectionChanged: (v) => n.set(s.copyWith(clock: v.first)),
                      ),
                    ],
                  ),
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
                if ((s.parasha || s.roshHodesh || jewishHome) && l10n.localeName != 'he')
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(l10n.hebrewNamesHeading, style: Theme.of(context).textTheme.bodyMedium),
                        const SizedBox(height: 8),
                        SegmentedButton<HebrewNames>(
                          key: const ValueKey('hebrew-names'),
                          showSelectedIcon: false,
                          segments: [
                            ButtonSegment(value: HebrewNames.israeli, label: Text(l10n.hebrewNamesIsraeli)),
                            ButtonSegment(value: HebrewNames.ashkenazi, label: Text(l10n.hebrewNamesAshkenazi)),
                            const ButtonSegment(value: HebrewNames.hebrew, label: Text('תולדות')),
                          ],
                          selected: {s.hebrewNames},
                          onSelectionChanged: (v) => n.set(s.copyWith(hebrewNames: v.first)),
                        ),
                      ],
                    ),
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
