import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/providers.dart';
import '../domain/quote.dart';

import 'package:quando/l10n/l10n.dart';

String quoteSourceName(QuoteSource s) => switch (s) {
  QuoteSource.songs => l10n.quoteSongs,
  QuoteSource.movies => l10n.quoteMovies,
  QuoteSource.literature => l10n.quoteLiterature,
  QuoteSource.tanakh => l10n.quoteTanakh,
  QuoteSource.sages => l10n.quoteSages,
  QuoteSource.speeches => l10n.quoteSpeeches,
  QuoteSource.philosophy => l10n.quotePhilosophy,
  QuoteSource.proverbs => l10n.quoteProverbs,
};

IconData _icon(QuoteSource s) => switch (s) {
  QuoteSource.songs => Icons.music_note_outlined,
  QuoteSource.movies => Icons.movie_outlined,
  QuoteSource.literature => Icons.menu_book_outlined,
  QuoteSource.tanakh => Icons.auto_stories_outlined,
  QuoteSource.sages => Icons.school_outlined,
  QuoteSource.speeches => Icons.campaign_outlined,
  QuoteSource.philosophy => Icons.psychology_outlined,
  QuoteSource.proverbs => Icons.chat_bubble_outline,
};

/// Turns each kind of quote on or off.
class QuoteSourcesSheet extends ConsumerWidget {
  const QuoteSourcesSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final on = ref.watch(quoteSourcesProvider);
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.quotesTitle, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 6),
            Text(l10n.quotesHint),
            const SizedBox(height: 8),
            for (final s in QuoteSource.values)
              CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                secondary: Icon(_icon(s)),
                title: Text(quoteSourceName(s)),
                value: on.contains(s),
                onChanged: (v) => ref.read(quoteSourcesProvider.notifier).toggle(s, v ?? false),
              ),
          ],
        ),
      ),
    );
  }
}
