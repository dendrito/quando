import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:quando/l10n/l10n.dart';

import '../../../app/providers.dart';
import '../../../app/theme.dart';
import '../key_vault.dart';
import '../sync_service.dart';

/// "Keys on your devices": choose, type or change the sync passphrase that
/// locks Pushover, Spotify, Tuya and webhook keys before they're synced.
class KeyVaultCard extends ConsumerStatefulWidget {
  const KeyVaultCard({super.key});

  @override
  ConsumerState<KeyVaultCard> createState() => _KeyVaultCardState();
}

class _KeyVaultCardState extends ConsumerState<KeyVaultCard> {
  Future<void> _ask({required bool unlock, bool startOver = false}) async {
    final done = await showDialog<bool>(
      context: context,
      builder: (_) => _PassphraseDialog(unlock: unlock, startOver: startOver),
    );
    if (done == true && mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final account = ref.watch(syncProvider);
    ref.watch(integrationsProvider); // rebuilds after keys arrive
    if (account.phase != SyncPhase.on) return const SizedBox.shrink();
    final prefs = ref.read(prefsProvider);
    final waiting = KeyVault.waiting(prefs);
    final on = KeyVault.unlocked(prefs) && !waiting;
    final text = Theme.of(context).textTheme;
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
                  Icon(
                    on ? Icons.lock : (waiting ? Icons.lock_clock : Icons.lock_open),
                    color: QuandoColors.amber,
                  ),
                  const SizedBox(width: 10),
                  Expanded(child: Text(l10n.keysLockTitle, style: text.titleSmall)),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                waiting
                    ? l10n.keysLockWaiting
                    : on
                    ? l10n.keysLockOn
                    : l10n.keysLockOff,
                style: text.bodySmall,
              ),
              const SizedBox(height: 10),
              if (waiting) ...[
                FilledButton.icon(
                  onPressed: () => _ask(unlock: true),
                  icon: const Icon(Icons.key, size: 18),
                  label: Text(l10n.keysUnlock),
                ),
                TextButton(
                  onPressed: () => _ask(unlock: false, startOver: true),
                  child: Text(l10n.keysStartOver),
                ),
              ] else
                OutlinedButton.icon(
                  onPressed: () => _ask(unlock: false),
                  icon: const Icon(Icons.key, size: 18),
                  label: Text(on ? l10n.keysChangePassphrase : l10n.keysSetPassphrase),
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
      await sync.setKeyPassphrase(phrase);
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
