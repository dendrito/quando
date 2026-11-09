import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kosher_dart/kosher_dart.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../app/providers.dart';
import '../../../app/theme.dart';
import '../../../core/util/local_time.dart';
import '../../../l10n/l10n.dart';
import '../data/home_information_providers.dart';
import '../data/learning_repository.dart';
import 'home_display_controls.dart';

class LearningCard extends ConsumerWidget {
  const LearningCard({super.key, required this.now});
  final DateTime now;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(homeDisplayProvider).courses;
    if (selected.isEmpty) return const SizedBox.shrink();
    final place = ref.watch(placeProvider), local = inZone(now, place.timeZone);
    final needsOnline = selected.any((id) => id != 'daf');
    final key = (local.year, local.month, place.inIsrael);
    final schedule = needsOnline
        ? ref.watch(learningMonthProvider(key))
        : const AsyncData<List<LearningReading>>([]);
    final readings =
        schedule.asData?.value
            .where((r) => r.date == learningDateKey(local) && selected.contains(r.course))
            .toList() ??
        <LearningReading>[];
    if (selected.contains('daf') && !readings.any((r) => r.course == 'daf')) {
      try {
        final daf = YomiCalculator.getDafYomiBavli(
          JewishCalendar.fromDateTime(DateTime(local.year, local.month, local.day)),
        );
        final format = HebrewDateFormatter()..hebrewFormat = false;
        final he = HebrewDateFormatter()..hebrewFormat = true;
        readings.insert(
          0,
          LearningReading(
            course: 'daf',
            date: learningDateKey(local),
            title: format.formatDafYomiBavli(daf),
            hebrew: he.formatDafYomiBavli(daf),
          ),
        );
      } catch (_) {
        /* Dates outside the established cycle have no assignment. */
      }
    }
    final text = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Material(
        color: QuandoColors.surface,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text('${l10n.dailyStudyHeading} · ${dayLabel(local)}', style: text.titleMedium),
                  ),
                  IconButton(
                    tooltip: l10n.homeDisplay,
                    onPressed: () => showHomeDisplayControls(context),
                    icon: const Icon(Icons.tune, size: 20),
                  ),
                ],
              ),
              for (final r in readings)
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  dense: true,
                  title: Text(courseLabel(r.course)),
                  subtitle: Text(l10n.localeName == 'he' && r.hebrew.isNotEmpty ? r.hebrew : r.title),
                  trailing: r.link == null ? null : const Icon(Icons.open_in_new, size: 16),
                  onTap: r.link == null
                      ? null
                      : () => launchUrl(r.link!, mode: LaunchMode.externalApplication),
                ),
              if (schedule.isLoading) const LinearProgressIndicator(),
              if (schedule.hasError)
                Row(
                  children: [
                    Expanded(child: Text(l10n.learningUnavailable, style: text.bodySmall)),
                    IconButton(
                      tooltip: l10n.homeRefresh,
                      onPressed: () => ref.invalidate(learningMonthProvider(key)),
                      icon: const Icon(Icons.refresh),
                    ),
                  ],
                ),
              if (needsOnline)
                TextButton(
                  style: TextButton.styleFrom(
                    alignment: AlignmentDirectional.centerStart,
                    padding: EdgeInsets.zero,
                  ),
                  onPressed: () => launchUrl(
                    Uri.parse('https://www.hebcal.com/home/195/jewish-calendar-rest-api'),
                    mode: LaunchMode.externalApplication,
                  ),
                  child: Text(l10n.learningCalendarSource, style: text.bodySmall),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
