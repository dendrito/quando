import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../app/providers.dart';
import '../../../app/theme.dart';
import '../../../app/widgets/feature_header.dart';
import '../domain/integrations.dart';
import 'pushover_icon.dart';
import '../data/pushover_credentials_sync.dart';
import '../data/service_connections_sync.dart';
import 'tuya_connection_card.dart';
import '../../sync/key_vault.dart';
import '../../sync/sync_service.dart';
import '../../sync/ui/key_vault_card.dart';

import 'package:quando/l10n/l10n.dart';

/// Pushover, Zapier, IFTTT and any other webhook.
class IntegrationsScreen extends ConsumerStatefulWidget {
  const IntegrationsScreen({super.key});

  @override
  ConsumerState<IntegrationsScreen> createState() => _IntegrationsScreenState();
}

class _IntegrationsScreenState extends ConsumerState<IntegrationsScreen> {
  late final _user = TextEditingController(text: ref.read(integrationsProvider).pushoverUser);
  late final _token = TextEditingController(text: ref.read(integrationsProvider).pushoverToken);
  var _testing = false;
  var _loading = false;

  /// Pushover's own sounds, shown before anything is loaded. Loading adds
  /// the ones you uploaded.
  Map<String, String> _sounds = const {
    'pushover': 'Pushover',
    'bike': 'Bike',
    'bugle': 'Bugle',
    'cashregister': 'Cash Register',
    'classical': 'Classical',
    'cosmic': 'Cosmic',
    'falling': 'Falling',
    'gamelan': 'Gamelan',
    'incoming': 'Incoming',
    'intermission': 'Intermission',
    'magic': 'Magic',
    'mechanical': 'Mechanical',
    'pianobar': 'Piano Bar',
    'siren': 'Siren',
    'spacealarm': 'Space Alarm',
    'tugboat': 'Tug Boat',
    'alien': 'Alien Alarm (long)',
    'climb': 'Climb (long)',
    'persistent': 'Persistent (long)',
    'echo': 'Pushover Echo (long)',
    'updown': 'Up Down (long)',
    'vibrate': 'Vibrate only',
    'none': 'None (silent)',
  };

  @override
  void initState() {
    super.initState();
    // Keys already saved: fetch your own sounds and devices straight away.
    final s = ref.read(integrationsProvider);
    if (s.pushoverOn && s.pushoverUser.isNotEmpty && s.pushoverToken.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _loadPushover(quiet: true));
    }
  }

  List<String> _devices = const [];

  Future<void> _loadPushover({bool quiet = false}) async {
    final s = ref.read(integrationsProvider);
    final sender = ref.read(integrationSenderProvider);
    setState(() => _loading = true);
    try {
      final sounds = await sender.pushoverSounds(s.pushoverToken);
      final devices = await sender.pushoverDevices(s.pushoverToken, s.pushoverUser);
      if (!mounted) return;
      setState(() {
        _sounds = {..._sounds, ...sounds};
        _devices = devices;
      });
      if (!quiet) _say(l10n.foundSoundsDevices(sounds.length, devices.length));
    } catch (e) {
      if (mounted && !quiet) _say('$e'.replaceFirst('Exception: ', ''));
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  void dispose() {
    _user.dispose();
    _token.dispose();
    super.dispose();
  }

  void _say(String msg) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));

  /// Shared, or why not: signed out, or no sync passphrase on this device yet.
  String _shareResult(bool shared) => shared
      ? l10n.pushoverShareQueued
      : ref.read(syncProvider).phase == SyncPhase.on && !KeyVault.unlocked(ref.read(prefsProvider))
      ? l10n.keysShareNeedsPassphrase
      : l10n.pushoverShareSignIn;

  Future<void> _open(String url) => launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);

  Future<void> _testPushover() async {
    setState(() => _testing = true);
    final err = await ref.read(integrationSenderProvider).testPushover(ref.read(integrationsProvider));
    if (!mounted) return;
    setState(() => _testing = false);
    if (err == null) {
      await PushoverCredentialsSync.publish(ref.read(prefsProvider), ref.read(integrationsProvider));
    }
    if (mounted) _say(err ?? l10n.sentCheckDevices);
  }

  Future<void> _testWebhook(Webhook w) async {
    final err = await ref.read(integrationSenderProvider).testWebhook(w);
    if (mounted) _say(err ?? l10n.sentTo(w.title));
  }

  Future<void> _addWebhook(WebhookKind kind) async {
    final url = TextEditingController();
    final event = TextEditingController(text: 'quando_alarm');
    final key = TextEditingController();
    final result = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(switch (kind) {
          WebhookKind.zapier => 'Zapier',
          WebhookKind.ifttt => 'IFTTT',
          WebhookKind.other => 'Webhook',
          WebhookKind.homeAssistant => 'Home Assistant',
          WebhookKind.nodeRed => 'Node-RED',
        }),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: switch (kind) {
              WebhookKind.zapier => [
                Text(l10n.zapierHowTo),
                TextField(
                  controller: url,
                  decoration: InputDecoration(labelText: l10n.catchHookUrl),
                ),
              ],
              WebhookKind.ifttt => [
                Text(l10n.iftttHowTo),
                TextField(
                  controller: event,
                  decoration: InputDecoration(labelText: l10n.eventName),
                ),
                TextField(
                  controller: key,
                  decoration: InputDecoration(labelText: l10n.webhooksKey),
                ),
              ],
              WebhookKind.other || WebhookKind.homeAssistant || WebhookKind.nodeRed => [
                Text(switch (kind) {
                  WebhookKind.homeAssistant => l10n.homeAssistantHowTo,
                  WebhookKind.nodeRed => l10n.nodeRedHowTo,
                  _ => l10n.webhookHowTo,
                }),
                TextField(
                  controller: url,
                  decoration: const InputDecoration(labelText: 'https://…'),
                ),
              ],
            },
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text(l10n.cancel)),
          FilledButton(
            onPressed: () => Navigator.pop(
              context,
              kind == WebhookKind.ifttt ? Webhook.iftttUrl(event.text, key.text) : url.text.trim(),
            ),
            child: Text(l10n.add),
          ),
        ],
      ),
    );
    if (result == null) return;
    final bad = !Webhook.acceptsUrl(result, kind) || (kind == WebhookKind.ifttt && key.text.trim().isEmpty);
    if (bad) {
      _say(l10n.notAWebAddress);
      return;
    }
    ref
        .read(integrationsProvider.notifier)
        .addWebhook(
          Webhook(id: DateTime.now().microsecondsSinceEpoch.toRadixString(36), kind: kind, url: result),
        );
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(integrationsProvider, (before, after) {
      if (_user.text == (before?.pushoverUser ?? '')) _user.text = after.pushoverUser;
      if (_token.text == (before?.pushoverToken ?? '')) _token.text = after.pushoverToken;
    });
    final account = ref.watch(syncProvider);
    final s = ref.watch(integrationsProvider);
    final n = ref.read(integrationsProvider.notifier);
    final text = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.connections), backgroundColor: Colors.transparent),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(24, 8, 24, 40),
        children: [
          FeatureHeader(icon: Icons.hub, sentence: l10n.connectionsSentence),
          Text(l10n.shareServicesHint, style: text.bodySmall),
          TextButton.icon(
            icon: const Icon(Icons.devices),
            label: Text(l10n.shareServices),
            onPressed: account.phase != SyncPhase.on
                ? null
                : () async {
                    final p = ref.read(prefsProvider);
                    await PushoverCredentialsSync.publish(p, ref.read(integrationsProvider));
                    final shared = await ServiceConnectionsSync.publish(p);
                    if (mounted) _say(_shareResult(shared));
                  },
          ),
          const KeyVaultCard(),
          Row(
            children: [
              const PushoverIcon(),
              const SizedBox(width: 8),
              Text('PUSHOVER', style: text.labelSmall),
            ],
          ),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(l10n.pushWhenRings),
            subtitle: Text(l10n.pushWhenRingsHint),
            value: s.pushoverOn,
            onChanged: (v) => n.update((x) => x.copyWith(pushoverOn: v)),
          ),
          if (s.pushoverOn) ...[
            Text(l10n.pushoverShareHint, style: text.bodySmall),
            TextButton.icon(
              onPressed: account.phase == SyncPhase.on && s.pushoverReady
                  ? () async {
                      final shared = await PushoverCredentialsSync.publish(ref.read(prefsProvider), s);
                      if (mounted) _say(_shareResult(shared));
                    }
                  : null,
              icon: const Icon(Icons.devices),
              label: Text(l10n.pushoverShareDevices),
            ),
            if (account.phase != SyncPhase.on) Text(l10n.pushoverShareSignIn, style: text.bodySmall),
            TextField(
              controller: _user,
              decoration: InputDecoration(labelText: l10n.yourUserKey),
              onChanged: (v) => n.update((x) => x.copyWith(pushoverUser: v.trim())),
            ),
            TextField(
              controller: _token,
              decoration: InputDecoration(labelText: l10n.appToken),
              onChanged: (v) => n.update((x) => x.copyWith(pushoverToken: v.trim())),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: Text(l10n.soundAndDevicesHeading, style: text.labelSmall)),
                TextButton.icon(
                  onPressed: s.pushoverUser.isNotEmpty && s.pushoverToken.isNotEmpty && !_loading
                      ? _loadPushover
                      : null,
                  icon: const Icon(Icons.refresh, size: 18),
                  label: Text(_loading ? l10n.loading : l10n.loadFromPushover),
                ),
              ],
            ),
            DropdownButtonFormField<String?>(
              initialValue: s.pushoverSound,
              isExpanded: true,
              decoration: InputDecoration(labelText: l10n.soundItPlays),
              items: [
                DropdownMenuItem(value: null, child: Text(l10n.myPushoverDefault)),
                for (final e in {
                  ..._sounds,
                  if (s.pushoverSound != null && !_sounds.containsKey(s.pushoverSound))
                    s.pushoverSound!: s.pushoverSound!,
                }.entries)
                  DropdownMenuItem(value: e.key, child: Text(e.value)),
              ],
              onChanged: (v) => n.update(
                (x) => v == null ? x.copyWith(defaultPushoverSound: true) : x.copyWith(pushoverSound: v),
              ),
            ),
            const SizedBox(height: 4),
            Text(l10n.pushoverOwnSounds, style: text.bodySmall),
            const SizedBox(height: 12),
            Wrap(
              spacing: 6,
              children: [
                FilterChip(
                  label: Text(l10n.allMyDevices),
                  selected: s.pushoverDevices.isEmpty,
                  onSelected: (_) => n.update((x) => x.copyWith(pushoverDevices: {})),
                ),
                for (final d in {..._devices, ...s.pushoverDevices})
                  FilterChip(
                    label: Text(d),
                    selected: s.pushoverDevices.contains(d),
                    onSelected: (on) => n.update(
                      (x) => x.copyWith(
                        pushoverDevices: on ? {...x.pushoverDevices, d} : ({...x.pushoverDevices}..remove(d)),
                      ),
                    ),
                  ),
              ],
            ),
            Text(l10n.pushoverOnThisPhone, style: text.bodySmall),
            Text(l10n.pushoverSoundTestHint, style: text.bodySmall),
            const SizedBox(height: 12),
            DropdownButtonFormField<int>(
              initialValue: s.pushoverPriority,
              decoration: InputDecoration(labelText: l10n.priority),
              items: [
                DropdownMenuItem(value: 0, child: Text(l10n.priorityNormal)),
                DropdownMenuItem(value: 1, child: Text(l10n.priorityHigh)),
                DropdownMenuItem(value: 2, child: Text(l10n.priorityEmergency)),
              ],
              onChanged: (v) => n.update((x) => x.copyWith(pushoverPriority: v)),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: [
                FilledButton.tonal(
                  onPressed: s.pushoverReady && !_testing ? _testPushover : null,
                  child: Text(_testing ? l10n.sending : l10n.testPushoverSound),
                ),
                TextButton(onPressed: () => _open('https://pushover.net'), child: Text(l10n.findUserKey)),
                TextButton(
                  onPressed: () => _open('https://pushover.net/apps/build'),
                  child: Text(l10n.makeAppToken),
                ),
              ],
            ),
          ],
          const SizedBox(height: 28),
          Text(l10n.smartHomeHeading, style: text.labelSmall),
          Text(l10n.smartHomeHint, style: text.bodySmall),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(l10n.smartHomeDeviceOn),
            subtitle: Text(l10n.smartHomeDeviceHint),
            value: s.smartHomeOn,
            onChanged: (on) => n.update((s) => s.copyWith(smartHomeOn: on)),
          ),
          const SizedBox(height: 12),
          const TuyaConnectionCard(),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            children: [
              OutlinedButton.icon(
                onPressed: () => _addWebhook(WebhookKind.homeAssistant),
                icon: const Icon(Icons.home_outlined),
                label: const Text('Home Assistant'),
              ),
              OutlinedButton.icon(
                onPressed: () => _addWebhook(WebhookKind.nodeRed),
                icon: const Icon(Icons.account_tree_outlined),
                label: const Text('Node-RED'),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(l10n.webhooksHeading, style: text.labelSmall),
          const SizedBox(height: 4),
          Text(l10n.webhooksExplain, style: text.bodySmall),
          for (final w in s.webhooks)
            Card(
              margin: const EdgeInsets.only(top: 12),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 8, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(child: Text(w.title, style: text.titleMedium)),
                        Switch(
                          value: w.enabled,
                          onChanged: (v) => n.replaceWebhook(w.copyWith(enabled: v)),
                        ),
                        IconButton(
                          tooltip: l10n.remove,
                          icon: const Icon(Icons.delete_outline),
                          onPressed: () => n.removeWebhook(w.id),
                        ),
                      ],
                    ),
                    Text(l10n.sendWhenAlarm, style: text.bodySmall),
                    Wrap(
                      spacing: 6,
                      children: [
                        for (final h in AlarmHappening.values)
                          FilterChip(
                            label: Text(h.label),
                            selected: w.events.contains(h.key),
                            onSelected: (on) => n.replaceWebhook(
                              w.copyWith(events: on ? {...w.events, h.key} : ({...w.events}..remove(h.key))),
                            ),
                          ),
                      ],
                    ),
                    Text(l10n.automationTestHint, style: text.bodySmall),
                    TextButton(onPressed: () => _testWebhook(w), child: Text(l10n.sendATest)),
                  ],
                ),
              ),
            ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            children: [
              OutlinedButton.icon(
                onPressed: () => _addWebhook(WebhookKind.zapier),
                icon: const Icon(Icons.add),
                label: const Text('Zapier'),
              ),
              OutlinedButton.icon(
                onPressed: () => _addWebhook(WebhookKind.ifttt),
                icon: const Icon(Icons.add),
                label: const Text('IFTTT'),
              ),
              OutlinedButton.icon(
                onPressed: () => _addWebhook(WebhookKind.other),
                icon: const Icon(Icons.add),
                label: Text(l10n.other),
              ),
            ],
          ),
          const SizedBox(height: 28),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(l10n.pauseOnShabbat),
            subtitle: Text(l10n.pauseOnShabbatHint),
            value: s.pauseOnShabbat,
            onChanged: (v) => n.update((x) => x.copyWith(pauseOnShabbat: v)),
          ),
          const SizedBox(height: 12),
          Text(l10n.webhookPayloadNote, style: text.bodySmall?.copyWith(color: QuandoColors.muted)),
        ],
      ),
    );
  }
}
