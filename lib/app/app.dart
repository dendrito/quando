import 'dart:async';

import 'package:alarm/alarm.dart';
import 'package:alarm/utils/alarm_set.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../features/alarms/data/permissions.dart';
import '../features/alarms/ui/edit_alarm_screen.dart';
import '../features/busy/ui/busy_screen.dart';
import '../features/calendar/ui/calendar_rule_screen.dart';
import '../features/calendar/ui/calendar_screen.dart';
import '../features/home/ui/home_screen.dart';
import '../features/integrations/ui/integrations_screen.dart';
import '../features/home/ui/settings_screen.dart';
import '../features/lock/ui/lock_gate.dart';
import '../features/lock/ui/lock_screen.dart';
import '../features/ringing/ring_payload.dart';
import '../features/ringing/ring_screen.dart';
import '../features/rules/ui/preset_screen.dart';
import '../features/shabbat/ui/shabbat_screen.dart';
import '../features/sync/sync_service.dart';
import '../features/timers/ui/timers_screen.dart';
import '../features/sounds/ui/sounds_screen.dart';
import '../features/ready/ready_screen.dart';
import '../core/util/platform.dart';
import '../l10n/l10n.dart';
import 'edition.dart';
import 'providers.dart';
import 'theme.dart';

final _navigatorKey = GlobalKey<NavigatorState>();

final _router = GoRouter(
  navigatorKey: _navigatorKey,
  routes: [
    GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
    GoRoute(path: '/settings', builder: (context, state) => const SettingsScreen()),
    GoRoute(path: '/calendar', builder: (context, state) => const CalendarScreen()),
    GoRoute(path: '/lock', builder: (context, state) => const LockScreen()),
    GoRoute(
      path: '/timers',
      builder: (context, state) =>
          TimersScreen(initialTab: int.tryParse(state.uri.queryParameters['tab'] ?? '') ?? 0),
    ),
    GoRoute(path: '/sounds', builder: (context, state) => const SoundsScreen()),
    GoRoute(path: '/connections', builder: (context, state) => const IntegrationsScreen()),
    GoRoute(path: '/ready', builder: (context, state) => const ReadyScreen()),
    GoRoute(path: '/busy', builder: (context, state) => const BusyScreen()),
    GoRoute(
      path: '/calendar/rule/:id',
      builder: (context, state) =>
          CalendarRuleScreen(id: state.pathParameters['id']!, timesQuery: state.uri.queryParameters['times']),
    ),
    GoRoute(path: '/shabbat', builder: (context, state) => const ShabbatScreen()),
    GoRoute(
      path: '/preset/:id',
      builder: (context, state) => PresetScreen(id: state.pathParameters['id']!),
    ),
    GoRoute(
      path: '/alarm/:id',
      builder: (context, state) => EditAlarmScreen(id: state.pathParameters['id']!),
    ),
  ],
);

class QuandoApp extends ConsumerStatefulWidget {
  const QuandoApp({super.key});

  @override
  ConsumerState<QuandoApp> createState() => _QuandoAppState();
}

class _QuandoAppState extends ConsumerState<QuandoApp> with WidgetsBindingObserver {
  StreamSubscription<AlarmSet>? _ringingSub;
  final _shown = <int>{};
  Timer? _syncTimer;

  @override
  void initState() {
    super.initState();
    if (supportsLocalAlarms) {
      WidgetsBinding.instance.addObserver(this);
      _listen();
      // Keep the phone's alarms in step with the plan, whatever changes it.
      ref.listenManual(planProvider, (_, _) => _scheduleSync());
      ref.listenManual(payloadForProvider, (_, _) => _scheduleSync());
      ref.listenManual(busyWindowsProvider, (_, _) => _scheduleSync());
      ref.listenManual(busySettingsProvider, (_, _) => _scheduleSync());
      // New calendar rules may reach further ahead: read events again.
      ref.listenManual(calendarRulesProvider, (_, _) => ref.read(calendarProvider.notifier).refresh());
      // Signed in to sync: pick up where it left off.
      ref.read(syncProvider);
      _start();
    }
  }

  Future<void> _start() async {
    await ensureAlarmPermissions();
    ref.invalidate(readinessProvider);
    await ref.read(calendarProvider.notifier).refresh();
    await _sync();
  }

  void _scheduleSync() {
    _syncTimer?.cancel();
    _syncTimer = Timer(const Duration(seconds: 1), _sync);
  }

  Future<void> _sync() async {
    try {
      await ref.read(registrarProvider).sync(ref.read(planProvider), ref.read(payloadForProvider));
    } catch (e) {
      debugPrint('Quando?: could not set alarms: $e');
    }
    if (isAndroid) {
      try {
        await ref
            .read(loudNotificationsProvider)
            .publish(
              now: DateTime.now(),
              plan: ref.read(planProvider),
              payloadFor: ref.read(payloadForProvider),
              quiet: ref.read(shabbatInUseProvider) ? ref.read(periodsProvider) : const [],
            );
      } catch (e) {
        debugPrint('Quando?: could not prepare loud calendar notifications: $e');
      }
      try {
        final busy = ref.read(busySettingsProvider);
        await ref
            .read(busyModeProvider)
            .publish(
              settings: busy,
              windows: ref.read(busyWindowsProvider),
              replyText: busy.replyText.trim().isEmpty
                  ? l10n.busyReplyDefault('{until}')
                  : busy.replyText.trim(),
              holy: ref.read(shabbatInUseProvider) ? ref.read(periodsProvider) : const [],
            );
      } catch (e) {
        debugPrint('Quando?: could not prepare Busy mode: $e');
      }
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Back after a while: plan again from the real time now.
    if (state == AppLifecycleState.resumed) {
      ref.invalidate(clockProvider);
      ref.read(calendarProvider.notifier).refresh();
    }
  }

  Future<void> _listen() async {
    await ref.read(registrarProvider).init();
    // Seeded stream: also fires when the phone opens the app for an alarm.
    _ringingSub = Alarm.ringing.listen((set) {
      final ids = set.alarms.map((a) => a.id).toSet();
      _shown.removeWhere((id) => !ids.contains(id));
      for (final alarm in set.alarms) {
        if (!_shown.add(alarm.id)) continue;
        if (RingPayload.decode(alarm.payload).isLock) {
          // Its only job was to open Quando; the lock screen takes over.
          Alarm.stop(alarm.id);
        } else if (RingPayload.decode(alarm.payload).localAudio) {
          _showRinging(alarm);
        }
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
    WidgetsBinding.instance.removeObserver(this);
    _syncTimer?.cancel();
    _ringingSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final language = ref.watch(languageProvider);
    return MaterialApp.router(
      onGenerateTitle: (_) => appTitle,
      debugShowCheckedModeBanner: false,
      theme: buildTheme(),
      routerConfig: _router,
      locale: language == null ? null : localeFromTag(language),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      localeListResolutionCallback: (wanted, _) {
        final locale = useLocale(wanted ?? const []);
        // Words already made in the old language are made again.
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) ref.read(localeProvider.notifier).changed(locale);
        });
        return locale;
      },
      // A new language rebuilds every screen with the new words.
      builder: (context, child) => KeyedSubtree(
        key: ValueKey(Localizations.localeOf(context)),
        child: LockGate(child: child!),
      ),
    );
  }
}
