import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/providers.dart';
import '../domain/ui_level.dart';

import 'package:quando/l10n/l10n.dart';

String uiLevelName(UiLevel l) => switch (l) {
  UiLevel.simple => l10n.uiSimple,
  UiLevel.everything => l10n.uiEverything,
};

/// The top row of Settings: Simple or Everything, one tap, no restart.
class LevelSwitch extends ConsumerWidget {
  const LevelSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final level = ref.watch(uiLevelProvider);
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: SegmentedButton<UiLevel>(
        key: const Key('levelSwitch'),
        showSelectedIcon: false,
        segments: [
          for (final l in UiLevel.values)
            ButtonSegment(
              value: l,
              label: Text(uiLevelName(l), key: Key('level-${l.name}')),
            ),
        ],
        selected: {level},
        onSelectionChanged: (v) => ref.read(uiLevelProvider.notifier).set(v.first),
      ),
    );
  }
}
