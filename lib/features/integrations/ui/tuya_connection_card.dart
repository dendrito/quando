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
  late final _relay = TextEditingController(text: ref.read(integrationsProvider).tuya.relayUrl);
  final _country = TextEditingController();
  final _account = TextEditingController();
  final _password = TextEditingController();
  bool _signingIn = false;
  bool? _linked;
  bool _loading = false;
  bool _advanced = false;
  bool _loaded = false;
  String? _error;
  String? _running;

  @override
  void dispose() {
    _id.dispose();
    _secret.dispose();
    _uid.dispose();
    _relay.dispose();
    _country.dispose();
    _account.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    if (ref.read(integrationsProvider).tuya.viaRelay) _checkLinked();
  }

  Future<void> _checkLinked() async {
    try {
      final linked = await ref
          .read(tuyaClientProvider)
          .relay
          .linked(ref.read(integrationsProvider).tuya.relayUrl);
      if (mounted) setState(() => _linked = linked);
    } catch (_) {
      // Not signed in to Quando or offline: the sign-in form still shows.
    }
  }

  String _failure(Object e) {
    final code = e is TuyaException ? e.code : 'network';
    return code == 'signin' ? l10n.tuyaNeedsAccount : '${l10n.tuyaFailed} $code';
  }

  /// Links the Smart Life account through the relay. The password is cleared as soon as it is sent.
  Future<void> _relaySignIn() async {
    final url = ref.read(integrationsProvider).tuya.relayUrl;
    setState(() {
      _signingIn = true;
      _error = null;
    });
    try {
      await ref
          .read(tuyaClientProvider)
          .relay
          .login(url, countryCode: _country.text, username: _account.text, password: _password.text);
      _password.clear();
      if (mounted) setState(() => _linked = true);
      await _load();
    } catch (e) {
      if (mounted) setState(() => _error = _failure(e));
    } finally {
      if (mounted) setState(() => _signingIn = false);
    }
  }

  Future<void> _unlink() async {
    try {
      await ref.read(tuyaClientProvider).relay.logout(ref.read(integrationsProvider).tuya.relayUrl);
      final prefs = ref.read(prefsProvider);
      await TuyaSceneCache.write(prefs, ref.read(integrationsProvider).tuya, const []);
      ref.invalidate(tuyaScenesProvider);
      if (mounted) setState(() => _linked = false);
    } catch (e) {
      if (mounted) setState(() => _error = _failure(e));
    }
  }

  /// Signs in with the Smart Life account to find its Tuya user id, then loads the scenes.
  /// Only the user id is kept; the password is cleared as soon as the call returns.
  Future<void> _signIn() async {
    final settings = ref.read(integrationsProvider).tuya;
    setState(() {
      _signingIn = true;
      _error = null;
    });
    try {
      final uid = await ref
          .read(tuyaClientProvider)
          .login(settings, username: _account.text, password: _password.text, countryCode: _country.text);
      _uid.text = uid;
      _save();
      _password.clear();
      if (mounted) setState(() => _signingIn = false);
      await _load();
    } catch (e) {
      if (mounted) setState(() => _error = '${l10n.tuyaFailed} ${e is TuyaException ? e.code : 'network'}');
    } finally {
      if (mounted) setState(() => _signingIn = false);
    }
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
            relayUrl: _relay.text.trim(),
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
      if (mounted) setState(() => _error = _failure(e));
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

  /// Country, Smart Life email or phone, and password, plus the button that uses them.
  /// [directSignIn] uses the user's own project keys; otherwise Quando's relay is used.
  List<Widget> _signInForm({bool directSignIn = false}) {
    final settings = ref.read(integrationsProvider).tuya;
    final ready =
        !_signingIn &&
        !_loading &&
        _country.text.trim().isNotEmpty &&
        _account.text.trim().isNotEmpty &&
        _password.text.isNotEmpty &&
        (!directSignIn || settings.clientId.isNotEmpty && settings.secret.isNotEmpty);
    return [
      Text(l10n.tuyaSignInTitle, style: Theme.of(context).textTheme.titleSmall),
      Text(directSignIn ? l10n.tuyaSignInHint : l10n.tuyaRelayHint),
      TextField(
        controller: _country,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(labelText: l10n.tuyaCountryCode),
        onChanged: (_) => setState(() {}),
      ),
      TextField(
        controller: _account,
        keyboardType: TextInputType.emailAddress,
        autocorrect: false,
        decoration: InputDecoration(labelText: l10n.tuyaAccount),
        onChanged: (_) => setState(() {}),
      ),
      TextField(
        controller: _password,
        obscureText: true,
        enableSuggestions: false,
        autocorrect: false,
        decoration: InputDecoration(labelText: l10n.tuyaPassword),
        onChanged: (_) => setState(() {}),
      ),
      if (!directSignIn) Text(l10n.tuyaGoogleHint),
      const SizedBox(height: 8),
      FilledButton(
        onPressed: ready ? (directSignIn ? _signIn : _relaySignIn) : null,
        child: Text(_signingIn ? l10n.loading : l10n.tuyaSignIn),
      ),
    ];
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
          if (settings.viaRelay) ...[
            if (_linked == true)
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.check_circle_outline),
                title: Text(l10n.tuyaLinked),
                trailing: TextButton(onPressed: _unlink, child: Text(l10n.tuyaUnlink)),
              )
            else
              ..._signInForm(),
          ] else
            Text(l10n.tuyaConsumerPending),
          ExpansionTile(
            title: Text(l10n.tuyaAdvanced),
            onExpansionChanged: (value) => setState(() => _advanced = value),
            tilePadding: EdgeInsets.zero,
            children: [
              TextField(
                controller: _relay,
                keyboardType: TextInputType.url,
                autocorrect: false,
                decoration: InputDecoration(labelText: l10n.tuyaRelayUrl),
                onChanged: (_) => _save(),
              ),
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
              if (!settings.viaRelay) ...[const SizedBox(height: 16), ..._signInForm(directSignIn: true)],
            ],
          ),
          const SizedBox(height: 12),
          if (settings.ready || _advanced)
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
