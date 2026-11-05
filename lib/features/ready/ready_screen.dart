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

import 'package:quando/l10n/l10n.dart';

/// One thing the phone must allow for alarms to ring on time.
enum ReadyCheck {
  notifications(Icons.notifications_active),
  fullScreen(Icons.fullscreen),
  exact(Icons.schedule),
  battery(Icons.battery_charging_full);

  const ReadyCheck(this.icon);
  final IconData icon;

  String get title => switch (this) {
    notifications => l10n.readyNotifications,
    fullScreen => l10n.readyFullScreen,
    exact => l10n.readyExact,
    battery => l10n.readyBattery,
  };

  String get why => switch (this) {
    notifications => l10n.readyNotificationsWhy,
    fullScreen => l10n.readyFullScreenWhy,
    exact => l10n.readyExactWhy,
    battery => l10n.readyBatteryWhy,
  };
}

/// Reads and fixes [ReadyCheck]s. Android only; elsewhere all is well.
class Readiness {
  static const _phone = MethodChannel('quando/phone');

  static bool get applies =>
      !kIsWeb && defaultTargetPlatform == TargetPlatform.android;

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
      ReadyCheck.fullScreen: await safe(
        _phone.invokeMethod<bool>('fullScreen').then((v) => v ?? true),
      ),
      ReadyCheck.exact: await safe(Permission.scheduleExactAlarm.isGranted),
      ReadyCheck.battery: await safe(
        Permission.ignoreBatteryOptimizations.isGranted,
      ),
    };
  }

  static Future<void> fix(ReadyCheck c) async {
    try {
      switch (c) {
        case ReadyCheck.notifications:
          if (await Permission.notification.request().isPermanentlyDenied)
            await openAppSettings();
        case ReadyCheck.fullScreen:
          if (await _phone.invokeMethod<bool>('openFullScreen') != true)
            await openAppSettings();
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
    'xiaomi' || 'redmi' || 'poco' => l10n.tipXiaomi,
    'samsung' => l10n.tipSamsung,
    'huawei' || 'honor' => l10n.tipHuawei,
    'oppo' || 'realme' || 'oneplus' || 'vivo' => l10n.tipOther,
    _ => null,
  };
}

/// Whether anything needs fixing, checked when the app starts and after a fix.
final readinessProvider = FutureProvider<Map<ReadyCheck, bool>>(
  (ref) => Readiness.read(),
);

/// "Ready to ring": what the phone allows, a fix button for each, and a
/// quick test ring with the phone locked.
class ReadyScreen extends ConsumerStatefulWidget {
  const ReadyScreen({super.key});

  @override
  ConsumerState<ReadyScreen> createState() => _ReadyScreenState();
}

class _ReadyScreenState extends ConsumerState<ReadyScreen>
    with WidgetsBindingObserver {
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
            title: l10n.testRing,
            body: l10n.testRingBody,
            ringSeconds: 30,
            spoken: false,
            loudness: o.loudness,
            transient: true,
          ),
        );
    messenger.showSnackBar(SnackBar(content: Text(l10n.ringsIn20)));
  }

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final checks = ref.watch(readinessProvider).value ?? const {};
    final missing = checks.values.where((ok) => !ok).length;
    final tip = Readiness.brandTip(_brand);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.readyToRing),
        backgroundColor: Colors.transparent,
      ),
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
                  color: missing == 0
                      ? QuandoColors.amber
                      : QuandoColors.ground,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    checks.isEmpty
                        ? l10n.checkingPhone
                        : (missing == 0
                              ? l10n.phoneReady
                              : l10n.thingsNeedFixing(missing)),
                    style: text.titleMedium?.copyWith(
                      color: missing == 0 ? null : QuandoColors.ground,
                    ),
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
                      child: Text(l10n.fix),
                    ),
            ),
          if (tip != null) ...[
            const SizedBox(height: 12),
            Text(
              tip,
              style: text.bodyMedium?.copyWith(color: QuandoColors.muted),
            ),
          ],
          const SizedBox(height: 24),
          FilledButton.icon(
            style: FilledButton.styleFrom(
              minimumSize: const Size.fromHeight(56),
            ),
            onPressed: _testRing,
            icon: const Icon(Icons.alarm),
            label: Text(l10n.testIn20),
          ),
          const SizedBox(height: 8),
          Text(l10n.testIn20Hint, style: text.bodySmall),
        ],
      ),
    );
  }
}
