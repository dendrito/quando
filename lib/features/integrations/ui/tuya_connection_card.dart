import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/providers.dart';
import '../../../app/theme.dart';
import '../../../l10n/l10n.dart';
import '../data/service_connections_sync.dart';
import '../data/tuya_client.dart';
import '../data/tuya_scene_cache.dart';
import '../domain/tuya.dart';

class TuyaConnectionCard extends ConsumerStatefulWidget {
  const TuyaConnectionCard({super.key});
  @override
  ConsumerState<TuyaConnectionCard> createState() => _TuyaConnectionCardState();
}

class _TuyaConnectionCardState extends ConsumerState<TuyaConnectionCard> {
  late final _id = TextEditingController(text: ref.read(integrationsProvider).tuya.clientId);
  late final _secret = TextEditingController(text: ref.read(integrationsProvider).tuya.secret);
  late final _uid = TextEditingController(text: ref.read(integrationsProvider).tuya.uid);
  bool _loading = false;
  bool _loaded = false;
  String? _error;
  String? _running;

  @override
  void dispose() {
    _id.dispose();
    _secret.dispose();
    _uid.dispose();
    super.dispose();
  }

  void _save({TuyaRegion? region}) => ref
      .read(integrationsProvider.notifier)
      .update(
        (s) => s.copyWith(
          tuya: TuyaSettings(
            clientId: _id.text.trim(),
            secret: _secret.text.trim(),
            uid: _uid.text.trim(),
            region: region ?? s.tuya.region,
          ),
        ),
      );

  Future<void> _load() async {
    final settings = ref.read(integrationsProvider).tuya;
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final scenes = await ref.read(tuyaClientProvider).scenes(settings);
      final prefs = ref.read(prefsProvider);
      await TuyaSceneCache.write(prefs, settings, scenes);
      await ServiceConnectionsSync.publish(prefs);
      ref.invalidate(tuyaScenesProvider);
      if (mounted) setState(() => _loaded = true);
    } catch (e) {
      if (mounted) setState(() => _error = '${l10n.tuyaFailed} ${e is TuyaException ? e.code : 'network'}');
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _run(TuyaScene scene) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(scene.name),
        content: Text(l10n.tuyaRunConfirm),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: Text(l10n.cancel)),
          FilledButton(onPressed: () => Navigator.pop(context, true), child: Text(l10n.tuyaRunNow)),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;
    setState(() {
      _running = scene.key;
      _error = null;
    });
    try {
      await ref.read(tuyaClientProvider).runScene(ref.read(integrationsProvider).tuya, scene);
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(l10n.tuyaSent)));
    } catch (e) {
      if (mounted) setState(() => _error = '${l10n.tuyaFailed} ${e is TuyaException ? e.code : 'network'}');
    } finally {
      if (mounted) setState(() => _running = null);
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(integrationsProvider, (before, after) {
      if (_id.text == (before?.tuya.clientId ?? '')) _id.text = after.tuya.clientId;
      if (_secret.text == (before?.tuya.secret ?? '')) _secret.text = after.tuya.secret;
      if (_uid.text == (before?.tuya.uid ?? '')) _uid.text = after.tuya.uid;
    });
    final settings = ref.watch(integrationsProvider).tuya;
    final scenes = ref.watch(tuyaScenesProvider);
    return Material(
      color: QuandoColors.surface,
      borderRadius: BorderRadius.circular(20),
      clipBehavior: Clip.antiAlias,
      child: ExpansionTile(
        title: const Text('Tuya · Smart Life'),
        leading: const Icon(Icons.home_outlined),
        childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        children: [
          Text(l10n.tuyaSetupHint),
          DropdownButtonFormField<TuyaRegion>(
            key: ValueKey(settings.region),
            initialValue: settings.region,
            isExpanded: true,
            decoration: InputDecoration(labelText: l10n.tuyaDataCenter),
            items: [for (final r in TuyaRegion.values) DropdownMenuItem(value: r, child: Text(r.label))],
            onChanged: (r) {
              if (r != null) _save(region: r);
            },
          ),
          TextField(
            controller: _id,
            decoration: InputDecoration(labelText: l10n.tuyaAccessId),
            onChanged: (_) => _save(),
            autocorrect: false,
          ),
          TextField(
            controller: _secret,
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            decoration: InputDecoration(labelText: l10n.tuyaAccessSecret),
            onChanged: (_) => _save(),
          ),
          TextField(
            controller: _uid,
            decoration: InputDecoration(labelText: l10n.tuyaUserId),
            onChanged: (_) => _save(),
            autocorrect: false,
          ),
          const SizedBox(height: 12),
          FilledButton.icon(
            onPressed: settings.ready && !_loading && _running == null ? _load : null,
            icon: const Icon(Icons.refresh),
            label: Text(_loading ? l10n.loading : l10n.tuyaLoadScenes),
          ),
          if (_loaded && scenes.isEmpty) Text(l10n.tuyaNoScenes),
          if (_error != null) Text(_error!, style: TextStyle(color: Theme.of(context).colorScheme.error)),
          for (final scene in scenes)
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(scene.name),
              subtitle: Text(l10n.tuyaRunNow),
              leading: const Icon(Icons.play_circle_outline),
              onTap: _running == null && !_loading ? () => _run(scene) : null,
              trailing: _running == scene.key
                  ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator())
                  : null,
            ),
        ],
      ),
    );
  }
}
