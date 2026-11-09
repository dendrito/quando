import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../app/theme.dart';

/// The music services Quando can wake you with.
enum MusicService { spotify, youTube, youTubeMusic, appleMusic, soundCloud }

/// A music service's own logo, in its own colours, so the list reads at a
/// glance. [connected] adds a small check.
class ServiceLogo extends StatelessWidget {
  const ServiceLogo(this.service, {super.key, this.size = 40, this.connected = false});

  final MusicService service;
  final double size;
  final bool connected;

  static const spotifyGreen = Color(0xFF1DB954);
  static const youTubeRed = Color(0xFFFF0000);
  static const appleMusicRed = Color(0xFFFA243C);
  static const soundCloudOrange = Color(0xFFFF5500);

  @override
  Widget build(BuildContext context) {
    final logo = SizedBox.square(dimension: size, child: _logo());
    if (!connected) return logo;
    return SizedBox.square(
      dimension: size,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          logo,
          Positioned(right: 0, top: 0, child: _Check(size: size * .42)),
        ],
      ),
    );
  }

  Widget _tile({required Widget child, Color? color, Gradient? gradient}) => DecoratedBox(
    decoration: BoxDecoration(
      color: color,
      gradient: gradient,
      borderRadius: BorderRadius.circular(size * .24),
    ),
    child: Center(child: child),
  );

  Widget _logo() => switch (service) {
    // Spotify's green circle, its sound waves cut out of it.
    MusicService.spotify => _tile(
      color: const Color(0xFF191414),
      child: FaIcon(FontAwesomeIcons.spotify, size: size * .7, color: spotifyGreen),
    ),
    // The red play button, with a white play triangle.
    MusicService.youTube => _tile(
      color: Colors.white,
      child: FaIcon(FontAwesomeIcons.youtube, size: size * .66, color: youTubeRed),
    ),
    MusicService.youTubeMusic => CustomPaint(painter: _YouTubeMusicPainter()),
    MusicService.appleMusic => _tile(
      gradient: const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFFFA5C70), appleMusicRed],
      ),
      child: FaIcon(FontAwesomeIcons.itunesNote, size: size * .52, color: Colors.white),
    ),
    MusicService.soundCloud => _tile(
      color: soundCloudOrange,
      child: FaIcon(FontAwesomeIcons.soundcloud, size: size * .62, color: Colors.white),
    ),
  };
}

/// YouTube Music: a red disc, a white ring and a play triangle.
class _YouTubeMusicPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final c = size.center(Offset.zero), r = size.shortestSide / 2;
    canvas.drawCircle(c, r, Paint()..color = ServiceLogo.youTubeRed);
    canvas.drawCircle(
      c,
      r * .56,
      Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = r * .1,
    );
    final t = r * .26;
    canvas.drawPath(
      Path()
        ..moveTo(c.dx - t * .7, c.dy - t)
        ..lineTo(c.dx + t, c.dy)
        ..lineTo(c.dx - t * .7, c.dy + t)
        ..close(),
      Paint()..color = Colors.white,
    );
  }

  @override
  bool shouldRepaint(_YouTubeMusicPainter old) => false;
}

/// YouTube and YouTube Music side by side, for the one Google sign-in that
/// reaches both.
class YouTubePairLogo extends StatelessWidget {
  const YouTubePairLogo({super.key, this.size = 40, this.connected = false});
  final double size;
  final bool connected;

  @override
  Widget build(BuildContext context) => SizedBox.square(
    dimension: size,
    child: Stack(
      clipBehavior: Clip.none,
      children: [
        ServiceLogo(MusicService.youTube, size: size * .74),
        Positioned(
          right: 0,
          bottom: 0,
          child: DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: QuandoColors.ground, width: 2),
            ),
            child: ServiceLogo(MusicService.youTubeMusic, size: size * .5),
          ),
        ),
        if (connected) Positioned(right: 0, top: 0, child: _Check(size: size * .42)),
      ],
    ),
  );
}

class _Check extends StatelessWidget {
  const _Check({required this.size});
  final double size;
  @override
  Widget build(BuildContext context) => Transform.translate(
    offset: Offset(size * .3, -size * .3),
    child: Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: QuandoColors.amber,
        shape: BoxShape.circle,
        border: Border.all(color: QuandoColors.ground, width: 2),
      ),
      child: Icon(Icons.check, size: size * .62, color: QuandoColors.ground),
    ),
  );
}
