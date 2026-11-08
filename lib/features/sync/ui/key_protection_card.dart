import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:quando/l10n/l10n.dart';

import '../../../app/providers.dart';
import '../../../app/theme.dart';
import '../key_vault.dart';
import '../sync_service.dart';
import 'biometric_gate.dart';

/// "Key protection": how Pushover, Spotify, Tuya and webhook keys reach your
/// other devices (Standard, Sync passphrase, This device only), plus an
/// optional Face ID or fingerprint lock on this device.
class KeyProtectionCard extends ConsumerStatefulWidget {
  const KeyProtectionCard({super.key});

  @override
  ConsumerState<KeyProtectionCard> createState() => _KeyProtectionCardState();
}

class _KeyProtectionCardState extends ConsumerState<KeyProtectionCard> {
  var _busy = false;
  late final Future<bool> _biometrics = BiometricLock.available();

  Future<void> _ask({required bool unlock, bool startOver = false}) async {
    final done = await showDialog<bool>(
      context: context,
      builder: (_) => _PassphraseDialog(unlock: unlock, startOver: startOver),
    );
    if (done == true && mounted) setState(() {});
  }

  Future<void> _choose(KeyProtection? level) async {
    if (level == null || level == KeyVault.level(ref.read(prefsProvider))) return;
    if (level == KeyProtection.passphrase) return _ask(unlock: false);
    setState(() => _busy = true);
    await ref.read(syncProvider.notifier).setKeyProtection(level);
    if (mounted) setState(() => _busy = false);
  }

  Future<void> _biometric(bool on) async {
    // Turning the lock on or off both need the owner, so a borrowed phone
    // can't switch it off.
    if (!await BiometricLock.confirm()) return;
    await ref.read(prefsProvider).setBool(BiometricLock.pref, on);
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final account = ref.watch(syncProvider);
    ref.watch(integrationsProvider); // rebuilds after keys arrive
    final prefs = ref.read(prefsProvider);
    final text = Theme.of(context).textTheme;
    final level = KeyVault.level(prefs);
    final signedIn = account.phase == SyncPhase.on;
    final waiting = signedIn && KeyVault.waiting(prefs);

    Widget option(KeyProtection value, String title, String hint) => RadioListTile<KeyProtection>(
      contentPadding: EdgeInsets.zero,
      value: value,
      enabled: signedIn && !_busy,
      title: Text(title),
      subtitle: Text(hint, style: text.bodySmall),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Material(
        color: QuandoColors.surface,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Icon(switch (level) {
                    KeyProtection.standard => Icons.shield_outlined,
                    KeyProtection.passphrase => Icons.lock,
                    KeyProtection.deviceOnly => Icons.phonelink_lock,
                  }, color: QuandoColors.amber),
                  const SizedBox(width: 10),
                  Expanded(child: Text(l10n.keysLockTitle, style: text.titleSmall)),
                  if (_busy)
                    const SizedBox.square(dimension: 18, child: CircularProgressIndicator(strokeWidth: 2)),
                ],
              ),
              if (waiting) ...[
                const SizedBox(height: 8),
                Text(l10n.keysLockWaiting, style: text.bodySmall),
                const SizedBox(height: 8),
                FilledButton.icon(
                  onPressed: () => _ask(unlock: true),
                  icon: const Icon(Icons.key, size: 18),
                  label: Text(l10n.keysUnlock),
                ),
                TextButton(
                  onPressed: () => _ask(unlock: false, startOver: true),
                  child: Text(l10n.keysStartOver),
                ),
              ],
              RadioGroup<KeyProtection>(
                groupValue: level,
                onChanged: _choose,
                child: Column(
                  children: [
                    option(KeyProtection.standard, l10n.keysLockStandard, l10n.keysLockStandardHint),
                    option(KeyProtection.passphrase, l10n.keysPassphrase, l10n.keysLockPassphraseHint),
                    option(KeyProtection.deviceOnly, l10n.keysLockDeviceOnly, l10n.keysLockDeviceOnlyHint),
                  ],
                ),
              ),
              if (level == KeyProtection.passphrase && !waiting && signedIn)
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: TextButton.icon(
                    onPressed: () => _ask(unlock: false),
                    icon: const Icon(Icons.key, size: 18),
                    label: Text(l10n.keysChangePassphrase),
                  ),
                ),
              FutureBuilder<bool>(
                future: _biometrics,
                builder: (context, snap) => snap.data != true
                    ? const SizedBox.shrink()
                    : SwitchListTile(
                        contentPadding: EdgeInsets.zero,
                        secondary: const Icon(Icons.fingerprint),
                        title: Text(l10n.keysBiometric),
                        subtitle: Text(l10n.keysBiometricHint, style: text.bodySmall),
                        value: prefs.getBool(BiometricLock.pref) ?? false,
                        onChanged: _biometric,
                      ),
              ),
              const SizedBox(height: 4),
              InkWell(
                onTap: () => launchUrl(
                  Uri.parse('https://myaccount.google.com/signinoptions/two-step-verification'),
                  mode: LaunchMode.externalApplication,
                ),
                child: Row(
                  children: [
                    const Icon(Icons.verified_user_outlined, size: 18),
                    const SizedBox(width: 8),
                    Expanded(child: Text(l10n.keysTwoStep, style: text.bodySmall)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PassphraseDialog extends ConsumerStatefulWidget {
  const _PassphraseDialog({required this.unlock, required this.startOver});

  final bool unlock;
  final bool startOver;

  @override
  ConsumerState<_PassphraseDialog> createState() => _PassphraseDialogState();
}

class _PassphraseDialogState extends ConsumerState<_PassphraseDialog> {
  final _first = TextEditingController();
  final _again = TextEditingController();
  String? _error;
  var _busy = false;
  var _hidden = true;

  @override
  void dispose() {
    _first.dispose();
    _again.dispose();
    super.dispose();
  }

  Future<void> _go() async {
    final phrase = _first.text;
    if (!widget.unlock) {
      if (phrase.length < KeyVault.minLength) {
        setState(() => _error = l10n.keysPassphraseShort(KeyVault.minLength));
        return;
      }
      if (phrase != _again.text) {
        setState(() => _error = l10n.keysPassphraseMismatch);
        return;
      }
    }
    setState(() {
      _busy = true;
      _error = null;
    });
    final sync = ref.read(syncProvider.notifier);
    var ok = true;
    if (widget.unlock) {
      ok = await sync.unlockKeys(phrase);
    } else {
      await sync.setKeyProtection(KeyProtection.passphrase, passphrase: phrase);
    }
    if (!mounted) return;
    if (ok) {
      Navigator.pop(context, true);
    } else {
      setState(() {
        _busy = false;
        _error = l10n.keysPassphraseWrong;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    return AlertDialog(
      title: Text(widget.unlock ? l10n.keysUnlock : l10n.keysPassphrase),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (widget.startOver) ...[
              Text(l10n.keysStartOverHint, style: text.bodySmall),
              const SizedBox(height: 8),
            ],
            TextField(
              controller: _first,
              autofocus: true,
              obscureText: _hidden,
              enabled: !_busy,
              autocorrect: false,
              enableSuggestions: false,
              decoration: InputDecoration(
                labelText: l10n.keysPassphrase,
                suffixIcon: IconButton(
                  icon: Icon(_hidden ? Icons.visibility : Icons.visibility_off),
                  onPressed: () => setState(() => _hidden = !_hidden),
                ),
              ),
              onSubmitted: widget.unlock ? (_) => _go() : null,
            ),
            if (!widget.unlock) ...[
              TextField(
                controller: _again,
                obscureText: _hidden,
                enabled: !_busy,
                autocorrect: false,
                enableSuggestions: false,
                decoration: InputDecoration(labelText: l10n.keysPassphraseAgain),
                onSubmitted: (_) => _go(),
              ),
              const SizedBox(height: 10),
              Text(l10n.keysPassphraseNote, style: text.bodySmall),
            ],
            if (_error != null) ...[
              const SizedBox(height: 10),
              Text(_error!, style: text.bodySmall?.copyWith(color: Theme.of(context).colorScheme.error)),
            ],
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: _busy ? null : () => Navigator.pop(context, false), child: Text(l10n.cancel)),
        FilledButton(
          onPressed: _busy ? null : _go,
          child: _busy
              ? const SizedBox.square(dimension: 18, child: CircularProgressIndicator(strokeWidth: 2))
              : Text(widget.unlock ? l10n.keysUnlock : l10n.keysSetPassphrase),
        ),
      ],
    );
  }
}
