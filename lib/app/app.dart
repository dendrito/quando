import 'dart:async';

import 'package:alarm/alarm.dart';
import 'package:alarm/utils/alarm_set.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../features/home/ui/home_screen.dart';
import '../features/home/ui/settings_screen.dart';
import '../features/ringing/ring_screen.dart';
import 'providers.dart';
import 'theme.dart';

final _navigatorKey = GlobalKey<NavigatorState>();

final _router = GoRouter(
  navigatorKey: _navigatorKey,
  routes: [
    GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
    GoRoute(path: '/settings', builder: (context, state) => const SettingsScreen()),
  ],
);

bool get _onPhone =>
    !kIsWeb &&
    (defaultTargetPlatform == TargetPlatform.android || defaultTargetPlatform == TargetPlatform.iOS);

class QuandoApp extends ConsumerStatefulWidget {
  const QuandoApp({super.key});

  @override
  ConsumerState<QuandoApp> createState() => _QuandoAppState();
}

class _QuandoAppState extends ConsumerState<QuandoApp> {
  StreamSubscription<AlarmSet>? _ringingSub;
  final _shown = <int>{};

  @override
  void initState() {
    super.initState();
    if (_onPhone) _listen();
  }

  Future<void> _listen() async {
    await ref.read(registrarProvider).init();
    // Seeded stream: also fires when the phone opens the app for an alarm.
    _ringingSub = Alarm.ringing.listen((set) {
      final ids = set.alarms.map((a) => a.id).toSet();
      _shown.removeWhere((id) => !ids.contains(id));
      for (final alarm in set.alarms) {
        if (_shown.add(alarm.id)) _showRinging(alarm);
      }
    });
  }

  void _showRinging(AlarmSettings alarm) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _navigatorKey.currentState?.push(
        MaterialPageRoute<void>(fullscreenDialog: true, builder: (_) => RingScreen(alarm: alarm)),
      );
    });
  }

  @override
  void dispose() {
    _ringingSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Quando',
      debugShowCheckedModeBanner: false,
      theme: buildTheme(),
      routerConfig: _router,
    );
  }
}
