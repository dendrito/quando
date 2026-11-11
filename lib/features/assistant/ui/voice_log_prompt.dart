import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/edition.dart';
import '../../../app/providers.dart';

import 'package:quando/l10n/l10n.dart';

import '../data/voice_log.dart';

/// Asked once, right after someone's first saved voice or typed alarm:
/// may Quando? see what they said, anonymously, to understand people
/// better. "No thanks" and swiping it away both end the question for good;
/// the switch stays in the Say-or-type sheet.
Future<void> askVoiceLog(BuildContext context, ProviderContainer ref, String sentence) async {
  final prefs = ref.read(prefsProvider);
  final shown = voiceSample(sentence: sentence, lang: '', understood: '', outcome: 'saved') != null;
  if (!voiceLogMayAsk(
    prefs.getBool(voiceLogAskedKey) ?? false,
    ref.read(voiceLogProvider),
    jewishEdition: jewishHome,
  )) {
    return;
  }
  await prefs.setBool(voiceLogAskedKey, true);
  if (!context.mounted) return;
  final yes = await showModalBottomSheet<bool>(
    context: context,
    showDragHandle: true,
    builder: (ctx) {
      final text = Theme.of(ctx).textTheme;
      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(l10n.askHelpPromptTitle, style: text.titleLarge),
              const SizedBox(height: 8),
              Text(shown ? l10n.askHelpPromptBody(sentence) : l10n.askHelpBody),
              if (l10n.askHelpQuote.isNotEmpty) ...[
                const SizedBox(height: 12),
                Text(
                  l10n.askHelpQuote,
                  style: text.bodySmall?.copyWith(fontStyle: FontStyle.italic),
                  textAlign: TextAlign.center,
                ),
              ],
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(minimumSize: const Size.fromHeight(52)),
                      onPressed: () => Navigator.pop(ctx, false),
                      child: Text(l10n.askHelpNo),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: FilledButton(
                      style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(52)),
                      onPressed: () => Navigator.pop(ctx, true),
                      child: Text(l10n.askHelpYes),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
  if (yes == true) ref.read(voiceLogProvider.notifier).set(true);
}
