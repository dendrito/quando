import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/providers.dart';
import '../../../core/util/local_time.dart';
import '../domain/quote.dart';

import 'package:quando/l10n/l10n.dart';

/// The line under the next alarm: a quote about time and who said it.
///
/// One quote per part of the day (see [pickQuote]); a tap shows another.
/// With no sources picked it shows the tagline when nothing is set, and
/// nothing otherwise.
class QuoteLine extends ConsumerStatefulWidget {
  const QuoteLine({super.key, required this.now, required this.idle, this.color});

  final DateTime now;
  final bool idle;
  final Color? color;

  @override
  ConsumerState<QuoteLine> createState() => _QuoteLineState();
}

class _QuoteLineState extends ConsumerState<QuoteLine> {
  int _skip = 0;
  String _slotKey = '';

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final local = inZone(widget.now, ref.watch(homeZoneProvider));
    final slotKey = '${local.year}-${local.month}-${local.day}-${slotOf(local).name}';
    if (slotKey != _slotKey) {
      _slotKey = slotKey;
      _skip = 0;
    }
    final today = [
      for (final e in ref.watch(calendarProvider.select((c) => c.events)))
        if (inZone(e.at, ref.read(homeZoneProvider)) case final d
            when d.year == local.year && d.month == local.month && d.day == local.day)
          e.title,
    ];
    final q = pickQuote(
      quotes: ref.watch(quotesProvider),
      sources: ref.watch(quoteSourcesProvider),
      local: local,
      eventTitles: today,
      idle: widget.idle,
      skip: _skip,
    );
    final color = widget.color ?? const Color(0xFFF7DCD0);
    if (q == null) {
      return widget.idle
          ? Text(l10n.tagline, style: text.bodyLarge?.copyWith(color: color))
          : const SizedBox.shrink();
    }
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => setState(() => _skip++),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 400),
        child: Column(
          key: ValueKey(q.text),
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              q.text,
              style: text.bodyLarge?.copyWith(color: color, fontStyle: FontStyle.italic),
            ),
            const SizedBox(height: 2),
            Text('— ${q.by}', style: text.bodySmall?.copyWith(color: color.withValues(alpha: 0.75))),
          ],
        ),
      ),
    );
  }
}
