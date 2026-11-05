import 'package:flutter/material.dart';

import '../theme.dart';

/// The top of a feature screen: a big picture and one sentence on what it
/// does, so nobody has to read a manual.
class FeatureHeader extends StatelessWidget {
  const FeatureHeader({super.key, required this.icon, required this.sentence});

  final IconData icon;
  final String sentence;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
      decoration: BoxDecoration(
        color: QuandoColors.surface,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        children: [
          Container(
            width: 88,
            height: 88,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [QuandoColors.amber, QuandoColors.coral],
              ),
            ),
            child: Icon(icon, size: 46, color: QuandoColors.ground),
          ),
          const SizedBox(height: 16),
          Text(sentence, textAlign: TextAlign.center, style: text.titleMedium),
        ],
      ),
    );
  }
}
