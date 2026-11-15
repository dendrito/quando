import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/edition.dart';
import 'beta_log.dart';

/// Beta words. English only on purpose: the beta is short and its testers
/// are asked in English, so these skip the 20-language review.
class BetaWords {
  static const group = 'Beta';
  static const share = 'Share how I use it';
  static const shareHint = 'Anonymous. No email, alarms or places.';
  static const feedback = 'Send feedback';
  static const bug = 'Bug';
  static const idea = 'Idea';
  static const love = 'Love';
  static const send = 'Send';
  static const email = 'Email (optional)';
  static const thanks = 'Thank you';
  static const failed = 'Could not send. Try again.';
  static const veryDisappointed = 'Very disappointed';
  static const somewhat = 'Somewhat';
  static const notReally = 'Not really';
  static String survey(String app) => 'How would you feel if you could no longer use $app?';
}

class BetaShareNotifier extends Notifier<bool> {
  @override
  bool build() {
    return BetaLog.on;
  }

  Future<void> set(bool on) async {
    await BetaLog.setOn(on);
    state = BetaLog.on;
  }
}

final betaShareProvider = NotifierProvider<BetaShareNotifier, bool>(BetaShareNotifier.new);

/// The two rows at the bottom of Settings.
class BetaSettings extends ConsumerWidget {
  const BetaSettings({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => Column(
    children: [
      SwitchListTile(
        contentPadding: EdgeInsets.zero,
        title: const Text(BetaWords.share),
        subtitle: const Text(BetaWords.shareHint),
        value: ref.watch(betaShareProvider),
        onChanged: (v) => ref.read(betaShareProvider.notifier).set(v),
      ),
      ListTile(
        contentPadding: EdgeInsets.zero,
        leading: const Icon(Icons.chat_bubble_outline),
        title: const Text(BetaWords.feedback),
        onTap: () => showBetaFeedback(context),
      ),
    ],
  );
}

Future<void> showBetaFeedback(BuildContext context) => showModalBottomSheet<void>(
  context: context,
  showDragHandle: true,
  isScrollControlled: true,
  builder: (_) => const _FeedbackSheet(),
);

class _FeedbackSheet extends StatefulWidget {
  const _FeedbackSheet();

  @override
  State<_FeedbackSheet> createState() => _FeedbackSheetState();
}

class _FeedbackSheetState extends State<_FeedbackSheet> {
  var _kind = 'bug';
  var _busy = false;
  final _text = TextEditingController();
  final _contact = TextEditingController();

  @override
  void dispose() {
    _text.dispose();
    _contact.dispose();
    super.dispose();
  }

  Future<void> _send() async {
    final body = _text.text.trim();
    if (body.isEmpty || _busy) return;
    setState(() => _busy = true);
    final ok = await BetaLog.feedback(_kind, body, contact: _contact.text.trim());
    if (!mounted) return;
    final messenger = ScaffoldMessenger.of(context);
    if (ok) Navigator.pop(context);
    messenger.showSnackBar(SnackBar(content: Text(ok ? BetaWords.thanks : BetaWords.failed)));
    if (!ok) setState(() => _busy = false);
  }

  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.fromLTRB(20, 0, 20, 16 + MediaQuery.viewInsetsOf(context).bottom),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Wrap(
          spacing: 8,
          children: [
            for (final (k, l) in const [
              ('bug', BetaWords.bug),
              ('idea', BetaWords.idea),
              ('love', BetaWords.love),
            ])
              ChoiceChip(label: Text(l), selected: _kind == k, onSelected: (_) => setState(() => _kind = k)),
          ],
        ),
        const SizedBox(height: 12),
        TextField(controller: _text, autofocus: true, minLines: 3, maxLines: 6, maxLength: 2000),
        TextField(
          controller: _contact,
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(hintText: BetaWords.email),
        ),
        const SizedBox(height: 12),
        FilledButton(onPressed: _busy ? null : _send, child: const Text(BetaWords.send)),
      ],
    ),
  );
}

/// Day 7: one question, once. Swiping it away asks again next time.
Future<void> askBetaSurvey(BuildContext context) async {
  if (!BetaLog.surveyDue()) return;
  final answer = await showModalBottomSheet<String>(
    context: context,
    showDragHandle: true,
    builder: (context) => SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(BetaWords.survey(appTitle), style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 12),
            FilledButton(
              onPressed: () => Navigator.pop(context, 'very'),
              child: const Text(BetaWords.veryDisappointed),
            ),
            const SizedBox(height: 8),
            OutlinedButton(
              onPressed: () => Navigator.pop(context, 'somewhat'),
              child: const Text(BetaWords.somewhat),
            ),
            const SizedBox(height: 8),
            OutlinedButton(
              onPressed: () => Navigator.pop(context, 'not'),
              child: const Text(BetaWords.notReally),
            ),
          ],
        ),
      ),
    ),
  );
  if (answer != null) await BetaLog.answerSurvey(answer);
}
