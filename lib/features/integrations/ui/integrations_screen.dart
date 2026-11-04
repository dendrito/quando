import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../app/providers.dart';
import '../../../app/theme.dart';
import '../../../app/widgets/feature_header.dart';
import '../domain/integrations.dart';

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
      if (!quiet) _say('Found ${sounds.length} sounds and ${devices.length} devices.');
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

  Future<void> _open(String url) => launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);

  Future<void> _testPushover() async {
    setState(() => _testing = true);
    final err = await ref.read(integrationSenderProvider).testPushover(ref.read(integrationsProvider));
    if (!mounted) return;
    setState(() => _testing = false);
    _say(err ?? 'Sent. Check your other devices.');
  }

  Future<void> _testWebhook(Webhook w) async {
    final err = await ref.read(integrationSenderProvider).testWebhook(w);
    if (mounted) _say(err ?? 'Sent to ${w.title}.');
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
        }),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: switch (kind) {
              WebhookKind.zapier => [
                const Text(
                  'In Zapier, make a Zap that starts with "Webhooks by Zapier → Catch Hook", then paste its '
                  'URL here.',
                ),
                TextField(
                  controller: url,
                  decoration: const InputDecoration(labelText: 'Catch Hook URL'),
                ),
              ],
              WebhookKind.ifttt => [
                const Text(
                  'In IFTTT, make an applet that starts with "Webhooks → Receive a web request with a JSON '
                  'payload". Use the same event name here. Your key is on ifttt.com/maker_webhooks/settings.',
                ),
                TextField(
                  controller: event,
                  decoration: const InputDecoration(labelText: 'Event name'),
                ),
                TextField(
                  controller: key,
                  decoration: const InputDecoration(labelText: 'Webhooks key'),
                ),
              ],
              WebhookKind.other => [
                const Text('Quando sends a JSON POST to this address.'),
                TextField(
                  controller: url,
                  decoration: const InputDecoration(labelText: 'https://…'),
                ),
              ],
            },
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          FilledButton(
            onPressed: () => Navigator.pop(
              context,
              kind == WebhookKind.ifttt ? Webhook.iftttUrl(event.text, key.text) : url.text.trim(),
            ),
            child: const Text('Add'),
          ),
        ],
      ),
    );
    if (result == null) return;
    final uri = Uri.tryParse(result);
    final bad =
        uri == null || !uri.isScheme('https') || (kind == WebhookKind.ifttt && key.text.trim().isEmpty);
    if (bad) {
      _say('That doesn\'t look like a web address starting with https://');
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
    final s = ref.watch(integrationsProvider);
    final n = ref.read(integrationsProvider.notifier);
    final text = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Connections'), backgroundColor: Colors.transparent),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(24, 8, 24, 40),
        children: [
          const FeatureHeader(
            icon: Icons.hub,
            sentence: 'Tell your other apps and devices when an alarm rings, stops or snoozes.',
          ),
          Text('PUSHOVER', style: text.labelSmall),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Send a push when an alarm rings'),
            subtitle: const Text('To your other phones, tablet, watch or computer'),
            value: s.pushoverOn,
            onChanged: (v) => n.update((x) => x.copyWith(pushoverOn: v)),
          ),
          if (s.pushoverOn) ...[
            TextField(
              controller: _user,
              decoration: const InputDecoration(labelText: 'Your user key'),
              onChanged: (v) => n.update((x) => x.copyWith(pushoverUser: v.trim())),
            ),
            TextField(
              controller: _token,
              decoration: const InputDecoration(labelText: 'App token'),
              onChanged: (v) => n.update((x) => x.copyWith(pushoverToken: v.trim())),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: Text('SOUND AND DEVICES', style: text.labelSmall)),
                TextButton.icon(
                  onPressed: s.pushoverUser.isNotEmpty && s.pushoverToken.isNotEmpty && !_loading
                      ? _loadPushover
                      : null,
                  icon: const Icon(Icons.refresh, size: 18),
                  label: Text(_loading ? 'Loading…' : 'Load from Pushover'),
                ),
              ],
            ),
            DropdownButtonFormField<String?>(
              initialValue: s.pushoverSound,
              isExpanded: true,
              decoration: const InputDecoration(labelText: 'Sound it plays'),
              items: [
                const DropdownMenuItem(value: null, child: Text('My Pushover default')),
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
            Text(
              'Your own sounds appear here after you upload them at pushover.net/sounds.',
              style: text.bodySmall,
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 6,
              children: [
                FilterChip(
                  label: const Text('All my devices'),
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
            Text(
              'Install the Pushover app on this phone too and it rings here with your Pushover sound.',
              style: text.bodySmall,
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<int>(
              initialValue: s.pushoverPriority,
              decoration: const InputDecoration(labelText: 'Priority'),
              items: const [
                DropdownMenuItem(value: 0, child: Text('Normal')),
                DropdownMenuItem(value: 1, child: Text('High: through quiet hours')),
                DropdownMenuItem(value: 2, child: Text('Emergency: repeats until acknowledged')),
              ],
              onChanged: (v) => n.update((x) => x.copyWith(pushoverPriority: v)),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: [
                FilledButton.tonal(
                  onPressed: s.pushoverReady && !_testing ? _testPushover : null,
                  child: Text(_testing ? 'Sending…' : 'Send a test'),
                ),
                TextButton(
                  onPressed: () => _open('https://pushover.net'),
                  child: const Text('Find my user key'),
                ),
                TextButton(
                  onPressed: () => _open('https://pushover.net/apps/build'),
                  child: const Text('Make an app token'),
                ),
              ],
            ),
          ],
          const SizedBox(height: 28),
          Text('ZAPIER, IFTTT AND WEBHOOKS', style: text.labelSmall),
          const SizedBox(height: 4),
          Text(
            'Start anything when an alarm rings or you stop it: turn on lights, log your wake-up time, '
            'message someone.',
            style: text.bodySmall,
          ),
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
                          tooltip: 'Remove',
                          icon: const Icon(Icons.delete_outline),
                          onPressed: () => n.removeWebhook(w.id),
                        ),
                      ],
                    ),
                    Text('Send when the alarm:', style: text.bodySmall),
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
                    TextButton(onPressed: () => _testWebhook(w), child: const Text('Send a test')),
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
                label: const Text('Other'),
              ),
            ],
          ),
          const SizedBox(height: 28),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Pause on Shabbat and festivals'),
            subtitle: const Text('Nothing is sent for alarms from candle lighting to havdalah'),
            value: s.pauseOnShabbat,
            onChanged: (v) => n.update((x) => x.copyWith(pauseOnShabbat: v)),
          ),
          const SizedBox(height: 12),
          Text(
            'Each message carries: event (ring, stopped, snoozed, auto_stopped), title, body, time, shabbat and '
            'snoozes. Keys stay on this phone.',
            style: text.bodySmall?.copyWith(color: QuandoColors.muted),
          ),
        ],
      ),
    );
  }
}
