import 'package:flutter/material.dart';

/// Official, unmodified round logo, bundled for offline display.
class PushoverIcon extends StatelessWidget {
  const PushoverIcon({super.key, this.size = 28});
  final double size;

  @override
  Widget build(BuildContext context) =>
      Image.asset('assets/brands/pushover.png', width: size, height: size, semanticLabel: 'Pushover');
}
