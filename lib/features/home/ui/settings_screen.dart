import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/providers.dart';
import '../../../core/util/format.dart';
import '../../alarms/data/permissions.dart';
import '../../alarms/ui/ring_length_picker.dart';
import '../../../app/theme.dart';
import '../../../core/util/local_time.dart';
import '../../sounds/ui/sound_picker.dart';
import '../../timezones/ui/zone_picker.dart';
import '../../ringing/ring_payload.dart';
import '../../ringing/ui/alarm_extras.dart';
import '../../shabbat/domain/jewish_times.dart';
import '../../settings/domain/alarm_options.dart';
import '../../shabbat/domain/place.dart';
import '../../quotes/domain/quote.dart';
import '../../quotes/ui/quote_sources_sheet.dart';
import '../../sync/sync_service.dart';

import 'package:quando/l10n/l10n.dart';

import '../../../app/edition.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final place = ref.watch(placeProvider);
    final havdalah = ref.watch(havdalahProvider);
    final o = ref.watch(alarmOptionsProvider);
    final zones = ref.watch(timeZonesProvider);
    void setO(AlarmOptions Function(AlarmOptions) f) => ref.read(alarmOptionsProvider.notifier).update(f);
    final text = Theme.of(context).textTheme;
    final shabbatOn = ref.watch(shabbatInUseProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.settings), backgroundColor: Colors.transparent),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        children: [
          const _AccountCard(),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.verified_outlined, color: QuandoColors.amber),
            title: Text(l10n.readyToRing),
            subtitle: Text(l10n.readyToRingHint),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.push('/ready'),
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.hub_outlined, color: QuandoColors.amber),
            title: Text(l10n.connections),
            subtitle: const Text('Pushover, Zapier, IFTTT'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.push('/connections'),
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.translate, color: QuandoColors.amber),
            title: Text(l10n.language),
            subtitle: Text(
              ref.watch(languageProvider) == null
                  ? l10n.phoneLanguage
                  : languageNames[ref.watch(languageProvider)] ?? '',
            ),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _pickLanguage(context, ref),
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.format_quote, color: QuandoColors.amber),
            title: Text(l10n.quotesTitle),
            subtitle: Text(
              ref.watch(quoteSourcesProvider).isEmpty
                  ? l10n.quotesOff
                  : [
                      for (final s in QuoteSource.values)
                        if (ref.watch(quoteSourcesProvider).contains(s)) quoteSourceName(s),
                    ].join(', '),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => showModalBottomSheet<void>(
              context: context,
              showDragHandle: true,
              isScrollControlled: true,
              builder: (context) => const QuoteSourcesSheet(),
            ),
          ),
          if (!kodesh)
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.local_fire_department_outlined, color: QuandoColors.amber),
              title: Text(l10n.shabbatAndFestivals),
              subtitle: Text(shabbatOn ? l10n.on : l10n.off),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => context.push('/shabbat'),
            ),
          const SizedBox(height: 16),
          Text(l10n.timeZoneHeading, style: text.labelSmall),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.public, color: QuandoColors.amber),
            title: Text(zones.fixed == null ? l10n.followPhone : cityOf(zones.fixed!)),
            subtitle: Text(
              zones.fixed == null ? l10n.followPhoneNow(cityOf(ref.watch(homeZoneProvider))) : l10n.zoneFixed,
            ),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _pickHomeZone(context, ref),
          ),
          if (shabbatOn) ...[
            const SizedBox(height: 16),
            Text(l10n.shabbatCityHeading, style: text.labelSmall),
            DropdownButton<String>(
              isExpanded: true,
              value: place.name,
              items: [for (final p in Places.all) DropdownMenuItem(value: p.name, child: Text(p.name))],
              onChanged: (name) =>
                  ref.read(placeProvider.notifier).set(Places.all.firstWhere((p) => p.name == name)),
            ),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(l10n.inIsraelOneDay),
              value: place.inIsrael,
              onChanged: (v) => ref.read(placeProvider.notifier).setInIsrael(v),
            ),
            const SizedBox(height: 16),
            Text(l10n.candleMinutesHeading(place.candleLightingMinutes), style: text.labelSmall),
            Slider(
              min: 10,
              max: 60,
              divisions: 50,
              value: place.candleLightingMinutes.toDouble(),
              label: '${place.candleLightingMinutes}',
              onChanged: (v) => ref.read(placeProvider.notifier).setCandleMinutes(v.round()),
            ),
            const SizedBox(height: 16),
            Text(l10n.endOfShabbatHeading, style: text.labelSmall),
            RadioGroup<HavdalahOpinion>(
              groupValue: havdalah,
              onChanged: (v) => ref.read(havdalahProvider.notifier).set(v!),
              child: Column(
                children: [
                  RadioListTile(
                    contentPadding: EdgeInsets.zero,
                    value: HavdalahOpinion.geonim,
                    title: Text(l10n.nightfallGeonim),
                  ),
                  RadioListTile(
                    contentPadding: EdgeInsets.zero,
                    value: HavdalahOpinion.rabbeinuTam,
                    title: Text(l10n.rabbeinuTam),
                  ),
                ],
              ),
            ),
          ],
          const SizedBox(height: 24),
          Text(l10n.whenAlarmRingsHeading, style: text.labelSmall),
          SoundPickerTile(
            value: o.soundId,
            allowDefault: false,
            onChanged: (id) =>
                setO((x) => id == null ? x.copyWith(phoneSound: true) : x.copyWith(soundId: id)),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton.icon(
              onPressed: () => context.push('/sounds'),
              icon: const Icon(Icons.mic_none),
              label: Text(l10n.recordOrAddSounds),
            ),
          ),
          Text(l10n.ringsForThisLong),
          const SizedBox(height: 8),
          RingLengthPicker(
            seconds: o.ringSeconds,
            onChanged: (s) => setO((x) => x.copyWith(ringSeconds: s)),
          ),
          const SizedBox(height: 8),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(l10n.sameFades),
            subtitle: Text(o.fadesForAll ? l10n.sameFadesOn : l10n.sameFadesOff),
            value: o.fadesForAll,
            onChanged: (v) => setO((x) => x.copyWith(fadesForAll: v)),
          ),
          if (o.fadesForAll)
            LoudnessEditor(
              fadesOnly: true,
              value: o.loudness,
              onChanged: (l) => setO((x) => x.copyWith(loudness: l)),
            ),
          const SizedBox(height: 8),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(l10n.sayItOutLoud),
            subtitle: Text(l10n.sayItOutLoudHint),
            value: o.spoken,
            onChanged: (v) => setO((x) => x.copyWith(spoken: v)),
          ),
          Text(o.maxSnoozes == 0 ? l10n.noSnooze : l10n.snoozeUpTo(o.maxSnoozes, o.snoozeMinutes)),
          Slider(
            min: 0,
            max: 5,
            divisions: 5,
            value: o.maxSnoozes.toDouble(),
            label: '${o.maxSnoozes}',
            onChanged: (v) => setO((x) => x.copyWith(maxSnoozes: v.round())),
          ),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(l10n.wakeUpCheck),
            subtitle: Text(l10n.wakeUpCheckHint),
            value: o.wakeCheck,
            onChanged: (v) => setO((x) => x.copyWith(wakeCheck: v)),
          ),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(l10n.solveSum),
            subtitle: Text(l10n.provesAwake),
            value: o.mathTask,
            onChanged: (v) => setO((x) => x.copyWith(mathTask: v)),
          ),
          if (shabbatOn) Text(l10n.shabbatNoTasks, style: text.bodySmall),
          const SizedBox(height: 16),
          OutlinedButton(onPressed: () => _testAlarm(context, ref, o), child: Text(l10n.testAlarmIn1)),
          const SizedBox(height: 24),
          Text(l10n.timesDisclaimer, style: text.bodySmall),
          const _VersionLine(),
        ],
      ),
    );
  }

  Future<void> _pickLanguage(BuildContext context, WidgetRef ref) async {
    final current = ref.read(languageProvider);
    final choice = await showModalBottomSheet<String>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.7,
        builder: (context, scroll) => ListView(
          controller: scroll,
          children: [
            ListTile(
              leading: const Icon(Icons.phone_android),
              title: Text(l10n.phoneLanguage),
              selected: current == null,
              onTap: () => Navigator.pop(context, ''),
            ),
            for (final MapEntry(key: tag, value: name) in languageNames.entries)
              ListTile(
                leading: const SizedBox(width: 24),
                title: Text(name),
                selected: current == tag,
                onTap: () => Navigator.pop(context, tag),
              ),
          ],
        ),
      ),
    );
    if (choice == null) return;
    ref.read(languageProvider.notifier).set(choice.isEmpty ? null : choice);
  }

  Future<void> _pickHomeZone(BuildContext context, WidgetRef ref) async {
    final choice = await showModalBottomSheet<String>(
      context: context,
      showDragHandle: true,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.phone_android),
              title: Text(l10n.followPhone),
              subtitle: Text(l10n.recommended),
              onTap: () => Navigator.pop(context, 'phone'),
            ),
            ListTile(
              leading: const Icon(Icons.search),
              title: Text(l10n.chooseCity),
              onTap: () => Navigator.pop(context, 'pick'),
            ),
          ],
        ),
      ),
    );
    if (choice == 'phone') ref.read(timeZonesProvider.notifier).followPhone();
    if (choice == 'pick' && context.mounted) {
      final z = await pickZone(context, home: ref.read(homeZoneProvider));
      if (z != null) ref.read(timeZonesProvider.notifier).setFixed(z);
    }
  }

  Future<void> _testAlarm(BuildContext context, WidgetRef ref, AlarmOptions o) async {
    final messenger = ScaffoldMessenger.of(context);
    final supported =
        !kIsWeb &&
        (defaultTargetPlatform == TargetPlatform.android || defaultTargetPlatform == TargetPlatform.iOS);
    if (!supported) {
      messenger.showSnackBar(SnackBar(content: Text(l10n.testOnlyOnPhone)));
      return;
    }
    await ensureAlarmPermissions();
    final at = DateTime.now().add(const Duration(minutes: 1));
    final p = RingPayload.forAlarm(
      title: l10n.testAlarm,
      body: l10n.testAlarmBody,
      options: o,
      shabbatSafe: false,
    );
    await ref
        .read(registrarProvider)
        .set(
          stableId('test|${at.millisecondsSinceEpoch}'),
          at,
          RingPayload(
            title: p.title,
            body: p.body,
            ringSeconds: p.ringSeconds,
            spoken: p.spoken,
            maxSnoozes: p.maxSnoozes,
            snoozeMinutes: 1,
            wakeCheck: p.wakeCheck,
            mathTask: p.mathTask,
            loudness: p.loudness,
            transient: true,
          ),
        );
    messenger.showSnackBar(SnackBar(content: Text(l10n.testAlarmIn1Set)));
  }
}

/// Your account: sign in with Google to keep alarms and settings the same
/// on every device, see who you're signed in as, sign out.
class _AccountCard extends ConsumerWidget {
  const _AccountCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sync = ref.watch(syncProvider);
    final notifier = ref.read(syncProvider.notifier);
    if (!notifier.available) return const SizedBox.shrink();
    final text = Theme.of(context).textTheme;
    final on = sync.phase == SyncPhase.on;
    final working = sync.phase == SyncPhase.working;
    final who = sync.name?.isNotEmpty == true ? sync.name! : (sync.email ?? '');
    final status = switch (sync.phase) {
      SyncPhase.off => l10n.syncHint,
      SyncPhase.working => l10n.syncWorking,
      SyncPhase.on => l10n.syncOn(sync.email ?? ''),
      SyncPhase.notAllowed => l10n.syncNotAllowed,
      SyncPhase.failed => l10n.syncFailed,
      SyncPhase.verify => l10n.emailCheckInbox(sync.email ?? ''),
    };
    return Padding(
      padding: const EdgeInsets.only(top: 4, bottom: 12),
      child: Material(
        color: QuandoColors.surface,
        borderRadius: const BorderRadius.all(Radius.circular(24)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: QuandoColors.raised,
                    foregroundImage: on && sync.photo != null ? NetworkImage(sync.photo!) : null,
                    child: on && who.isNotEmpty
                        ? Text(who.characters.first.toUpperCase(), style: text.titleLarge)
                        : const Icon(Icons.person_outline, color: QuandoColors.amber),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(on && who.isNotEmpty ? who : l10n.syncTitle, style: text.titleMedium),
                        const SizedBox(height: 2),
                        Text(status, style: text.bodySmall),
                      ],
                    ),
                  ),
                  if (working)
                    const SizedBox.square(dimension: 20, child: CircularProgressIndicator(strokeWidth: 2)),
                ],
              ),
              if (!working) ...[
                const SizedBox(height: 12),
                if (on)
                  OutlinedButton.icon(
                    onPressed: notifier.signOut,
                    icon: const Icon(Icons.logout, size: 18),
                    label: Text(l10n.signOut),
                  )
                else if (sync.phase == SyncPhase.verify) ...[
                  FilledButton(
                    onPressed: () async {
                      final ok = await notifier.confirmEmail();
                      if (!ok && context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(l10n.emailNotYet)));
                      }
                    },
                    child: Text(l10n.emailConfirmed),
                  ),
                  Row(
                    children: [
                      TextButton(
                        onPressed: () async {
                          await notifier.resendConfirmation();
                          if (context.mounted) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(SnackBar(content: Text(l10n.emailSentAgain)));
                          }
                        },
                        child: Text(l10n.emailSendAgain),
                      ),
                      const Spacer(),
                      TextButton(onPressed: notifier.signOut, child: Text(l10n.cancel)),
                    ],
                  ),
                ] else ...[
                  FilledButton.icon(
                    onPressed: notifier.signIn,
                    icon: const Icon(Icons.login, size: 18),
                    label: Text(l10n.signInWithGoogle),
                  ),
                  const SizedBox(height: 8),
                  OutlinedButton.icon(
                    onPressed: () => showDialog<void>(context: context, builder: (_) => const _EmailDialog()),
                    icon: const Icon(Icons.mail_outline, size: 18),
                    label: Text(l10n.signInWithEmail),
                  ),
                ],
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// Email and password: sign in, make an account, or reset the password.
class _EmailDialog extends ConsumerStatefulWidget {
  const _EmailDialog();

  @override
  ConsumerState<_EmailDialog> createState() => _EmailDialogState();
}

class _EmailDialogState extends ConsumerState<_EmailDialog> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _create = false;
  bool _busy = false;
  String? _error;
  String? _note;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _go() async {
    setState(() {
      _busy = true;
      _error = null;
      _note = null;
    });
    final error = await ref
        .read(syncProvider.notifier)
        .signInWithEmail(_email.text, _password.text, create: _create);
    if (!mounted) return;
    if (error == null) {
      Navigator.pop(context);
    } else {
      setState(() {
        _busy = false;
        _error = error;
      });
    }
  }

  Future<void> _reset() async {
    if (_email.text.trim().isEmpty) {
      setState(() => _error = l10n.emailInvalid);
      return;
    }
    setState(() {
      _busy = true;
      _error = null;
      _note = null;
    });
    final error = await ref.read(syncProvider.notifier).resetPassword(_email.text);
    if (!mounted) return;
    setState(() {
      _busy = false;
      _error = error;
      _note = error == null ? l10n.passwordResetSent : null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    return AlertDialog(
      title: Text(_create ? l10n.createAccount : l10n.signInWithEmail),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _email,
              autofocus: true,
              keyboardType: TextInputType.emailAddress,
              autofillHints: const [AutofillHints.email],
              decoration: InputDecoration(labelText: l10n.email),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _password,
              obscureText: true,
              autofillHints: [_create ? AutofillHints.newPassword : AutofillHints.password],
              decoration: InputDecoration(labelText: l10n.password),
              onSubmitted: (_) => _go(),
            ),
            if (_error != null) ...[
              const SizedBox(height: 10),
              Text(_error!, style: text.bodySmall?.copyWith(color: QuandoColors.coral)),
            ],
            if (_note != null) ...[const SizedBox(height: 10), Text(_note!, style: text.bodySmall)],
            const SizedBox(height: 8),
            Row(
              children: [
                TextButton(
                  onPressed: _busy
                      ? null
                      : () => setState(() {
                          _create = !_create;
                          _error = null;
                          _note = null;
                        }),
                  child: Text(_create ? l10n.haveAccount : l10n.createAccount),
                ),
                const Spacer(),
                if (!_create) TextButton(onPressed: _busy ? null : _reset, child: Text(l10n.forgotPassword)),
              ],
            ),
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: Text(l10n.cancel)),
        FilledButton(
          onPressed: _busy ? null : _go,
          child: _busy
              ? const SizedBox.square(dimension: 18, child: CircularProgressIndicator(strokeWidth: 2))
              : Text(_create ? l10n.createAccount : l10n.signIn),
        ),
      ],
    );
  }
}

class _VersionLine extends StatelessWidget {
  const _VersionLine();

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 16),
    child: Text('$appTitle $appVersion', style: Theme.of(context).textTheme.bodySmall),
  );
}
