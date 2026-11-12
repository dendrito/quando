import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/providers.dart';
import '../../../app/theme.dart';
import '../domain/ui_level.dart';

import 'package:quando/l10n/l10n.dart';

/// Shows [child] (Home), except on a brand-new install, which first gets
/// the one question.
class FirstRunGate extends ConsumerWidget {
  const FirstRunGate({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) =>
      ref.watch(firstRunProvider) ? const FirstRunScreen() : child;
}

/// "How much do you want to see?" Simple is chosen for you. Nothing is
/// asked about the person.
class FirstRunScreen extends ConsumerStatefulWidget {
  const FirstRunScreen({super.key});

  @override
  ConsumerState<FirstRunScreen> createState() => _FirstRunScreenState();
}

class _FirstRunScreenState extends ConsumerState<FirstRunScreen> {
  var _level = UiLevel.simple;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    Widget choice(UiLevel level, String title, String hint) {
      final on = _level == level;
      return Material(
        color: QuandoColors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(Radius.circular(28)),
          side: BorderSide(color: on ? QuandoColors.amber : Colors.transparent, width: 2.5),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          key: Key('first-${level.name}'),
          onTap: () => setState(() => _level = level),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(22, 20, 18, 20),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: text.headlineSmall),
                      const SizedBox(height: 4),
                      Text(hint, style: text.bodyMedium),
                    ],
                  ),
                ),
                Icon(
                  on ? Icons.radio_button_checked : Icons.radio_button_off,
                  color: on ? QuandoColors.amber : QuandoColors.faint,
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 520),
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
              children: [
                Text(l10n.firstRunTitle, style: text.displaySmall),
                const SizedBox(height: 28),
                choice(UiLevel.simple, l10n.uiSimple, l10n.firstRunSimpleHint),
                const SizedBox(height: 12),
                choice(UiLevel.everything, l10n.uiEverything, l10n.firstRunEverythingHint),
                const SizedBox(height: 28),
                SizedBox(
                  height: 60,
                  child: FilledButton(
                    key: const Key('firstRunContinue'),
                    onPressed: () => ref.read(firstRunProvider.notifier).answer(_level),
                    child: Text(l10n.continueLabel),
                  ),
                ),
                const SizedBox(height: 14),
                Text(l10n.firstRunChangeLater, style: text.bodySmall, textAlign: TextAlign.center),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
