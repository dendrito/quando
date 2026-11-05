import 'package:flutter/material.dart';

import '../../../app/theme.dart';
import '../../../app/widgets/brand.dart';

/// The amber card with the next Shabbat or festival and its times.
class ShabbatCard extends StatelessWidget {
  const ShabbatCard({
    super.key,
    required this.title,
    required this.names,
    required this.rows,
    this.onTap,
  });

  /// Opens the Shabbat screen. null = not tappable.
  final VoidCallback? onTap;

  final String title;
  final String names;
  final List<Widget> rows;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    const ink = QuandoColors.ground;
    return Material(
      color: QuandoColors.amber,
      borderRadius: const BorderRadius.all(Radius.circular(28)),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 18),
          child: DefaultTextStyle.merge(
            style: const TextStyle(color: ink),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 4),
                  child: Flame(height: 52),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              title,
                              style: text.labelSmall?.copyWith(color: ink),
                            ),
                          ),
                          if (onTap != null)
                            const Icon(Icons.chevron_right, color: ink),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        names,
                        style: text.headlineSmall?.copyWith(color: ink),
                      ),
                      const SizedBox(height: 10),
                      for (final r in rows)
                        Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: r,
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ShabbatTimeRow extends StatelessWidget {
  const ShabbatTimeRow({
    super.key,
    required this.label,
    required this.day,
    required this.time,
  });

  final String label;
  final String day;
  final String time;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    const ink = QuandoColors.ground;
    return Row(
      children: [
        Expanded(
          child: Text(
            '$label · $day',
            style: text.bodyMedium?.copyWith(color: ink),
          ),
        ),
        Text(time, style: text.titleLarge?.copyWith(color: ink, fontSize: 22)),
      ],
    );
  }
}
