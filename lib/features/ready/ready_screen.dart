import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../app/providers.dart';
import '../../app/theme.dart';
import '../../core/util/format.dart';
import '../ringing/ring_payload.dart';

/// One thing the phone must allow for alarms to ring on time.
enum ReadyCheck {
  notifications('Show alarms', 'Lets the ringing screen and Stop button appear.', Icons.notifications_active),
  fullScreen(
    'Ring over the lock screen',
    'Shows the alarm full screen, even when the phone is locked.',
    Icons.fullscreen,
  ),
  exact('Ring on the minute', 'Without it, the phone may ring alarms a few minutes late.', Icons.schedule),
  battery(
    'Keep running on battery saver',
    'Stops battery saving from silencing alarms overnight.',
    Icons.battery_charging_full,
  );

  const ReadyCheck(this.title, this.why, this.icon);
  final String title;
  final String why;
  final IconData icon;
}

/// Reads and fixes [ReadyCheck]s. Android only; elsewhere all is well.
class Readiness {
  static const _phone = MethodChannel('quando/phone');

  static bool get applies => !kIsWeb && defaultTargetPlatform == TargetPlatform.android;

  static Future<Map<ReadyCheck, bool>> read() async {
    if (!applies) return {for (final c in ReadyCheck.values) c: true};
    Future<bool> safe(Future<bool> f) async {
      try {
        return await f;
      } catch (_) {
        return true; // Not on this Android version: nothing to fix.
      }
    }

    return {
      ReadyCheck.notifications: await safe(Permission.notification.isGranted),
      ReadyCheck.fullScreen: await safe(_phone.invokeMethod<bool>('fullScreen').then((v) => v ?? true)),
      ReadyCheck.exact: await safe(Permission.scheduleExactAlarm.isGranted),
      ReadyCheck.battery: await safe(Permission.ignoreBatteryOptimizations.isGranted),
    };
  }

  static Future<void> fix(ReadyCheck c) async {
    try {
      switch (c) {
        case ReadyCheck.notifications:
          if (await Permission.notification.request().isPermanentlyDenied) await openAppSettings();
        case ReadyCheck.fullScreen:
          if (await _phone.invokeMethod<bool>('openFullScreen') != true) await openAppSettings();
        case ReadyCheck.exact:
          await Permission.scheduleExactAlarm.request();
        case ReadyCheck.battery:
          await Permission.ignoreBatteryOptimizations.request();
      }
    } catch (_) {
      await openAppSettings();
    }
  }

  static Future<String> brand() async {
    try {
      return await _phone.invokeMethod<String>('brand') ?? '';
    } catch (_) {
      return '';
    }
  }

  /// Extra steps some phone makers add on top of Android.
  static String? brandTip(String brand) => switch (brand) {
    'xiaomi' || 'redmi' || 'poco' => 'Xiaomi phones: in Settings › Apps › Quando, turn on Autostart and set Battery saver to No restrictions.',
    'samsung' =>
      'Samsung phones: in Settings › Battery › Background usage limits, make sure Quando isn\'t sleeping.',
    'huawei' || 'honor' => 'Huawei and Honor phones: in Settings › Battery › App launch, set Quando to Manage manually and allow everything.',
    'oppo' || 'realme' || 'oneplus' || 'vivo' => 'On this phone: in Settings › Battery, allow Quando to run in the background and turn off Optimise for it.',
    _ => null,
  };
}

/// Whether anything needs fixing, checked when the app starts and after a fix.
final readinessProvider = FutureProvider<Map<ReadyCheck, bool>>((ref) => Readiness.read());

/// "Ready to ring": what the phone allows, a fix button for each, and a
/// quick test ring with the phone locked.
class ReadyScreen extends ConsumerStatefulWidget {
  const ReadyScreen({super.key});

  @override
  ConsumerState<ReadyScreen> createState() => _ReadyScreenState();
}

class _ReadyScreenState extends ConsumerState<ReadyScreen> with WidgetsBindingObserver {
  String _brand = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    Readiness.brand().then((b) => mounted ? setState(() => _brand = b) : null);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // Back from the phone's settings: check again.
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) ref.invalidate(readinessProvider);
  }

  Future<void> _testRing() async {
    final messenger = ScaffoldMessenger.of(context);
    final at = DateTime.now().add(const Duration(seconds: 20));
    final o = ref.read(alarmOptionsProvider);
    await ref
        .read(registrarProvider)
        .set(
          stableId('ready|${at.millisecondsSinceEpoch}'),
          at,
          RingPayload(
            title: 'Test ring',
            body: 'Quando can wake you',
            ringSeconds: 30,
            spoken: false,
            loudness: o.loudness,
            transient: true,
          ),
        );
    messenger.showSnackBar(
      const SnackBar(content: Text('Rings in 20 seconds. Lock your phone now and wait.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final checks = ref.watch(readinessProvider).value ?? const {};
    final missing = checks.values.where((ok) => !ok).length;
    final tip = Readiness.brandTip(_brand);

    return Scaffold(
      appBar: AppBar(title: const Text('Ready to ring'), backgroundColor: Colors.transparent),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(24, 8, 24, 40),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: missing == 0 ? QuandoColors.raised : QuandoColors.coral,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Row(
              children: [
                Icon(
                  missing == 0 ? Icons.verified : Icons.warning_amber_rounded,
                  size: 40,
                  color: missing == 0 ? QuandoColors.amber : QuandoColors.ground,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    checks.isEmpty
                        ? 'Checking your phone…'
                        : (missing == 0
                              ? 'Your phone is set up to ring every alarm on time.'
                              : '$missing ${missing == 1 ? 'thing needs' : 'things need'} fixing, or alarms may '
                                    'not ring.'),
                    style: text.titleMedium?.copyWith(color: missing == 0 ? null : QuandoColors.ground),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          for (final c in ReadyCheck.values)
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(c.icon, color: QuandoColors.amber),
              title: Text(c.title),
              subtitle: Text(c.why, style: text.bodySmall),
              trailing: checks[c] ?? true
                  ? const Icon(Icons.check_circle, color: QuandoColors.amber)
                  : FilledButton(
                      onPressed: () async {
                        await Readiness.fix(c);
                        ref.invalidate(readinessProvider);
                      },
                      child: const Text('Fix'),
                    ),
            ),
          if (tip != null) ...[
            const SizedBox(height: 12),
            Text(tip, style: text.bodyMedium?.copyWith(color: QuandoColors.muted)),
          ],
          const SizedBox(height: 24),
          FilledButton.icon(
            style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(56)),
            onPressed: _testRing,
            icon: const Icon(Icons.alarm),
            label: const Text('Test it: ring in 20 seconds'),
          ),
          const SizedBox(height: 8),
          Text(
            'Lock the phone and put it down. If the alarm rings and shows full screen, you\'re all set.',
            style: text.bodySmall,
          ),
        ],
      ),
    );
  }
}
