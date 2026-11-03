import 'dart:async';

import 'package:alarm/alarm.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kiosk_mode/kiosk_mode.dart';

import '../../../app/providers.dart';
import '../../../app/theme.dart';
import '../../../core/util/local_time.dart';
import '../../ringing/ring_payload.dart';
import '../domain/lock.dart';

bool get _onAndroid => !kIsWeb && defaultTargetPlatform == TargetPlatform.android;

/// Covers the whole app while a lock is on: a calm clock, what the lock is
/// for, when it ends and the next alarm. Nothing can be changed. Ringing
/// alarms still show on top. "Hold to unlock" is the way out.
class LockGate extends ConsumerStatefulWidget {
  const LockGate({super.key, required this.child, this.now});

  final Widget child;

  /// For tests.
  final DateTime Function()? now;

  @override
  ConsumerState<LockGate> createState() => _LockGateState();
}

class _LockGateState extends ConsumerState<LockGate> {
  Timer? _tick;
  StreamSubscription<dynamic>? _ringingSub;
  var _ringing = false;
  var _pinned = false;
  LockPeriod? _active;

  DateTime _now() => (widget.now ?? () => DateTime.now().toUtc())();

  @override
  void initState() {
    super.initState();
    _tick = Timer.periodic(const Duration(seconds: 15), (_) => _check());
    if (!kIsWeb &&
        (defaultTargetPlatform == TargetPlatform.android || defaultTargetPlatform == TargetPlatform.iOS)) {
      _ringingSub = Alarm.ringing.listen((set) {
        final ringing = set.alarms.any((a) => !RingPayload.decode(a.payload).isLock);
        if (ringing != _ringing && mounted) setState(() => _ringing = ringing);
      });
    }
    WidgetsBinding.instance.addPostFrameCallback((_) => _check());
  }

  void _check() {
    if (!mounted) return;
    final now = _now();
    final active = ref.read(lockPeriodsProvider).where((p) => p.contains(now)).firstOrNull;
    if (active?.id != _active?.id) setState(() => _active = active);
    _syncPin(active != null && ref.read(lockSettingsProvider).pin);
  }

  Future<void> _syncPin(bool want) async {
    if (!_onAndroid || want == _pinned) return;
    _pinned = want;
    try {
      want ? await startKioskMode() : await stopKioskMode();
    } catch (_) {
      // Pinning not available: the lock screen still covers the app.
    }
  }

  @override
  void dispose() {
    _tick?.cancel();
    _ringingSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Re-check whenever the locks change (settings, calendar, unlock).
    ref.listen(lockPeriodsProvider, (_, _) => _check());
    final active = _active;
    return Stack(
      children: [
        widget.child,
        if (active != null && !_ringing)
          Positioned.fill(
            child: _LockView(
              period: active,
              now: _now,
              onUnlock: () {
                ref.read(dismissedLocksProvider.notifier).dismiss(active);
                setState(() => _active = null);
                _syncPin(false);
              },
            ),
          ),
      ],
    );
  }
}

class _LockView extends ConsumerStatefulWidget {
  const _LockView({required this.period, required this.now, required this.onUnlock});

  final LockPeriod period;
  final DateTime Function() now;
  final VoidCallback onUnlock;

  @override
  ConsumerState<_LockView> createState() => _LockViewState();
}

class _LockViewState extends ConsumerState<_LockView> with SingleTickerProviderStateMixin {
  static const holdFor = Duration(seconds: 3);
  late final AnimationController _hold = AnimationController(vsync: this, duration: holdFor)
    ..addStatusListener((s) {
      if (s == AnimationStatus.completed) {
        HapticFeedback.heavyImpact();
        widget.onUnlock();
      }
    });
  Timer? _clock;

  @override
  void initState() {
    super.initState();
    _clock = Timer.periodic(const Duration(seconds: 20), (_) => setState(() {}));
  }

  @override
  void dispose() {
    _clock?.cancel();
    _hold.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final zone = ref.watch(placeProvider).timeZone;
    final now = widget.now();
    final next = ref.watch(planProvider).where((a) => a.at.isAfter(now) && a.ruleId != 'lock').firstOrNull;
    String at(DateTime utc) => '${dayLabel(inZone(utc, zone))} · ${hhmm(inZone(utc, zone))}';
    final text = Theme.of(context).textTheme;

    return PopScope(
      canPop: false,
      child: Material(
        color: QuandoColors.ground,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(28, 48, 28, 28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('LOCKED', style: text.labelSmall),
                const SizedBox(height: 12),
                Text(widget.period.reason, style: text.headlineSmall),
                const Spacer(),
                Text(
                  hhmm(inZone(now, zone)),
                  textAlign: TextAlign.center,
                  style: text.displayLarge?.copyWith(color: QuandoColors.amber, fontSize: 88),
                ),
                const Spacer(),
                _Row('Unlocks', at(widget.period.end)),
                if (next != null) ...[
                  const SizedBox(height: 8),
                  _Row('Next alarm', '${next.title} · ${at(next.at)}'),
                ],
                const SizedBox(height: 32),
                GestureDetector(
                  onTapDown: (_) => _hold.forward(),
                  onTapUp: (_) => _hold.reverse(),
                  onTapCancel: () => _hold.reverse(),
                  child: AnimatedBuilder(
                    animation: _hold,
                    builder: (context, _) => Container(
                      height: 56,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(28),
                        border: Border.all(color: QuandoColors.line),
                        gradient: LinearGradient(
                          colors: [QuandoColors.amber.withValues(alpha: 0.35), Colors.transparent],
                          stops: [_hold.value, _hold.value],
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text('Hold to unlock', style: text.titleMedium),
                    ),
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

class _Row extends StatelessWidget {
  const _Row(this.label, this.value);

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    return Row(
      children: [
        Text(label, style: text.bodyMedium?.copyWith(color: QuandoColors.muted)),
        const SizedBox(width: 16),
        Expanded(
          child: Text(value, textAlign: TextAlign.end, style: text.bodyLarge),
        ),
      ],
    );
  }
}
