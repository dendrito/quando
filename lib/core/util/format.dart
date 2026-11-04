import 'package:quando/l10n/l10n.dart';

/// "2 hours", "30 minutes", "1 day", "1 hour 30 minutes".
String formatSpan(Duration d) {
  d = d.abs();
  final parts = <String>[];
  final days = d.inDays;
  final hours = d.inHours % 24;
  final minutes = d.inMinutes % 60;
  final seconds = d.inSeconds % 60;
  if (days > 0) parts.add(l10n.spanDays(days));
  if (hours > 0) parts.add(l10n.spanHours(hours));
  if (minutes > 0) parts.add(l10n.spanMinutes(minutes));
  if (seconds > 0) parts.add(l10n.spanSeconds(seconds));
  return parts.isEmpty ? l10n.now : parts.join(' ');
}

/// "1 hour before", "15 minutes after", "now".
String describeOffset(Duration offset) {
  if (offset == Duration.zero) return l10n.now;
  return offset.isNegative ? l10n.spanBefore(formatSpan(offset)) : l10n.spanAfter(formatSpan(offset));
}

/// 32-bit FNV-1a, masked to a positive int. Used for stable alarm ids.
int stableId(String input) {
  var hash = 0x811c9dc5;
  for (final unit in input.codeUnits) {
    hash ^= unit;
    hash = (hash * 0x01000193) & 0xffffffff;
  }
  return hash & 0x7fffffff;
}
