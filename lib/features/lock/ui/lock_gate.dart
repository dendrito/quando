import 'dart:async';

import 'package:alarm/alarm.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kiosk_mode/kiosk_mode.dart';

import '../../../app/providers.dart';
import '../../../app/theme.dart';
import '../../../app/widgets/brand.dart';
import '../../../core/util/local_time.dart';
import '../../../core/util/platform.dart';
import '../../home/domain/sky.dart';
import '../../ringing/ring_payload.dart';
import '../domain/lock.dart';

import 'package:quando/l10n/l10n.dart';

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
    if (supportsLocalAlarms) {
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
    final zone = ref.watch(homeZoneProvider);
    final now = widget.now();
    final next = ref.watch(planProvider).where((a) => a.at.isAfter(now) && a.ruleId != 'lock').firstOrNull;
    String at(DateTime utc) => '${dayLabel(inZone(utc, zone))} · ${hhmm(inZone(utc, zone))}';
    final text = Theme.of(context).textTheme;

    final holy = widget.period.look == LockLook.shabbat;
    final greeting = !holy
        ? (widget.period.allIds.every((id) => id.startsWith('manual.')) ? l10n.locked : l10n.lockQuietTime)
        : widget.period.reason.contains(l10n.shabbat) || widget.period.id.startsWith('cl.')
        ? l10n.shabbatShalom
        : l10n.chagSameach;
    final endLocal = inZone(widget.period.end, zone);

    return PopScope(
      canPop: false,
      child: Material(
        color: QuandoColors.night,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(28, 32, 28, 28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (holy)
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flame(height: 130, candle: true, glow: true),
                      SizedBox(width: 36),
                      Flame(height: 130, candle: true, glow: true),
                    ],
                  )
                else
                  const Center(child: _CalmOrb()),
                const SizedBox(height: 20),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(greeting, textAlign: TextAlign.center, style: text.displaySmall),
                ),
                const SizedBox(height: 6),
                Text(
                  widget.period.reason,
                  textAlign: TextAlign.center,
                  style: text.bodyLarge?.copyWith(color: QuandoColors.muted),
                ),
                const Spacer(),
                Text(l10n.unlocksHeading, textAlign: TextAlign.center, style: text.labelSmall),
                Text(
                  hhmm(endLocal),
                  textAlign: TextAlign.center,
                  style: text.displayLarge?.copyWith(color: QuandoColors.amber, fontSize: 80),
                ),
                Text(
                  '${dayLabel(endLocal)} · ${countdown(widget.period.end.difference(now))}',
                  textAlign: TextAlign.center,
                  style: text.bodyMedium?.copyWith(color: QuandoColors.muted),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
                  decoration: const BoxDecoration(
                    color: QuandoColors.surface,
                    borderRadius: BorderRadius.all(Radius.circular(28)),
                  ),
                  child: Column(
                    children: [
                      _Row(l10n.nowCap, hhmm(inZone(now, zone))),
                      if (next != null) ...[
                        const SizedBox(height: 8),
                        _Row(l10n.nextAlarm, '${next.title} · ${at(next.at)}'),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                GestureDetector(
                  onTapDown: (_) => _hold.forward(),
                  onTapUp: (_) => _hold.reverse(),
                  onTapCancel: () => _hold.reverse(),
                  child: AnimatedBuilder(
                    animation: _hold,
                    builder: (context, _) => Container(
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: QuandoColors.line, width: 1.5),
                        gradient: LinearGradient(
                          colors: [QuandoColors.amber.withValues(alpha: 0.4), Colors.transparent],
                          stops: [_hold.value, _hold.value],
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(l10n.holdToUnlock, style: text.titleMedium),
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 96,
          child: Text(label, style: text.bodyMedium?.copyWith(color: QuandoColors.muted)),
        ),
        Expanded(
          child: Text(value, style: text.bodyLarge?.copyWith(fontWeight: FontWeight.w600)),
        ),
      ],
    );
  }
}

/// The generic lock picture: a slow, breathing glow, like a moon behind
/// mist. No religious or brand symbols, so it fits any event.
class _CalmOrb extends StatefulWidget {
  const _CalmOrb();

  @override
  State<_CalmOrb> createState() => _CalmOrbState();
}

class _CalmOrbState extends State<_CalmOrb> with SingleTickerProviderStateMixin {
  late final AnimationController _breath = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 6),
  )..repeat(reverse: true);

  @override
  void dispose() {
    _breath.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => SizedBox(
    height: 130,
    width: 130,
    child: AnimatedBuilder(
      animation: _breath,
      builder: (context, _) {
        final t = Curves.easeInOut.transform(_breath.value);
        return Center(
          child: Container(
            width: 96 + 30 * t,
            height: 96 + 30 * t,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  QuandoColors.blush,
                  QuandoColors.blush.withValues(alpha: 0.85),
                  QuandoColors.coral.withValues(alpha: 0.3 + 0.15 * t),
                  Colors.transparent,
                ],
                stops: const [0.0, 0.42, 0.6, 1.0],
              ),
            ),
            alignment: Alignment.center,
            child: const Icon(Icons.lock_outline, size: 34, color: QuandoColors.night),
          ),
        );
      },
    ),
  );
}
