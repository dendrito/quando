import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quando/l10n/l10n.dart';

import '../../../app/providers.dart';

String themeName(ThemeChoice t) => switch (t) {
  ThemeChoice.auto => l10n.themeAuto,
  ThemeChoice.dark => l10n.themeDark,
  ThemeChoice.light => l10n.themeLight,
};

/// Auto (the phone's), Dark or Light: one tap, no restart.
class ThemeSwitch extends ConsumerWidget {
  const ThemeSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final choice = ref.watch(themeChoiceProvider);
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Semantics(
        label: l10n.themeTitle,
        child: SegmentedButton<ThemeChoice>(
          key: const Key('themeSwitch'),
          showSelectedIcon: false,
          segments: [
            for (final t in ThemeChoice.values)
              ButtonSegment(
                value: t,
                label: Text(themeName(t), key: Key('theme-${t.name}')),
              ),
          ],
          selected: {choice},
          onSelectionChanged: (v) => ref.read(themeChoiceProvider.notifier).set(v.first),
        ),
      ),
    );
  }
}
