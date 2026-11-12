import 'package:flutter/material.dart';

import '../../../app/theme.dart';

/// One button in the header: an icon and its word.
class HeaderAction {
  const HeaderAction({required this.icon, required this.label, required this.onTap});

  final IconData icon;
  final String label;
  final VoidCallback onTap;
}

/// The header buttons as small glass pills on the sky, each with its word.
/// When the words do not fit (long languages, small phones) they become
/// icons with the word under each, in small type. Words are never cut.
class HeaderPills extends StatelessWidget {
  const HeaderPills({super.key, required this.actions});

  final List<HeaderAction> actions;

  static const _icon = 14.0;
  static const _gap = 3.0;
  static const _padStart = 7.0;
  static const _padEnd = 9.0;
  static const _between = 5.0;

  @override
  Widget build(BuildContext context) {
    final style = (Theme.of(context).textTheme.labelLarge ?? const TextStyle()).copyWith(
      fontSize: 11,
      fontWeight: FontWeight.w600,
      color: QuandoColors.text,
    );
    return LayoutBuilder(
      builder: (context, box) {
        double word(String s) {
          final p = TextPainter(
            text: TextSpan(text: s, style: style),
            textDirection: Directionality.of(context),
            textScaler: MediaQuery.textScalerOf(context),
            maxLines: 1,
          )..layout();
          return p.width;
        }

        final need =
            actions.fold<double>(0, (sum, a) => sum + _padStart + _icon + _gap + word(a.label) + _padEnd) +
            _between * (actions.length - 1);
        if (need <= box.maxWidth) {
          return Row(
            key: const Key('headerPills'),
            children: [
              for (final a in actions) ...[
                Padding(
                  padding: const EdgeInsetsDirectional.only(end: _between),
                  child: _Pill(action: a, style: style),
                ),
              ],
            ],
          );
        }
        return Row(
          key: const Key('headerStacked'),
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (final a in actions)
              Flexible(
                child: _Stacked(action: a, style: style),
              ),
          ],
        );
      },
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill({required this.action, required this.style});

  final HeaderAction action;
  final TextStyle style;

  @override
  Widget build(BuildContext context) => Material(
    color: QuandoColors.text.withValues(alpha: 0.12),
    shape: const StadiumBorder(),
    clipBehavior: Clip.antiAlias,
    child: InkWell(
      key: Key('pill-${action.label}'),
      onTap: action.onTap,
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(HeaderPills._padStart, 6, HeaderPills._padEnd, 6),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(action.icon, size: HeaderPills._icon, color: QuandoColors.text),
            const SizedBox(width: HeaderPills._gap),
            Text(action.label, style: style, maxLines: 1, softWrap: false),
          ],
        ),
      ),
    ),
  );
}

class _Stacked extends StatelessWidget {
  const _Stacked({required this.action, required this.style});

  final HeaderAction action;
  final TextStyle style;

  @override
  Widget build(BuildContext context) => InkWell(
    key: Key('pill-${action.label}'),
    borderRadius: const BorderRadius.all(Radius.circular(14)),
    onTap: action.onTap,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(action.icon, color: QuandoColors.text),
          const SizedBox(height: 2),
          Text(
            action.label,
            style: style.copyWith(fontSize: 10),
            textAlign: TextAlign.center,
            softWrap: true,
          ),
        ],
      ),
    ),
  );
}
