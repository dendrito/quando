import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_auth/local_auth.dart';

import 'package:quando/l10n/l10n.dart';

import '../../../app/providers.dart';

/// "Ask for Face ID or fingerprint": an optional lock, kept per device, in
/// front of the screen that shows your service keys.
class BiometricLock {
  static const pref = 'keys.biometric';
  static final _auth = LocalAuthentication();

  static bool on(WidgetRef ref) => ref.read(prefsProvider).getBool(pref) ?? false;

  static Future<bool> available() async {
    try {
      return await _auth.isDeviceSupported();
    } catch (_) {
      return false;
    }
  }

  /// Face ID, fingerprint, or the device's own PIN as a fallback.
  static Future<bool> confirm() async {
    try {
      return await _auth.authenticate(localizedReason: l10n.keysBiometricReason);
    } catch (_) {
      return false;
    }
  }
}

/// Shows [child] only after the device owner confirms, when the lock is on.
class BiometricGate extends ConsumerStatefulWidget {
  const BiometricGate({super.key, required this.child});

  final Widget child;

  @override
  ConsumerState<BiometricGate> createState() => _BiometricGateState();
}

class _BiometricGateState extends ConsumerState<BiometricGate> {
  late var _open = !BiometricLock.on(ref);
  var _asking = false;

  @override
  void initState() {
    super.initState();
    if (!_open) WidgetsBinding.instance.addPostFrameCallback((_) => _ask());
  }

  Future<void> _ask() async {
    if (_asking) return;
    setState(() => _asking = true);
    final ok = await BiometricLock.confirm();
    if (!mounted) return;
    setState(() {
      _asking = false;
      _open = ok;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_open) return widget.child;
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.fingerprint, size: 56),
            const SizedBox(height: 12),
            Text(l10n.keysBiometricLocked, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 16),
            FilledButton(onPressed: _asking ? null : _ask, child: Text(l10n.keysBiometricUnlock)),
          ],
        ),
      ),
    );
  }
}
