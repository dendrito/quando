import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/providers.dart';
import '../../../app/theme.dart';
import '../data/loud_notifications.dart';

import 'package:quando/l10n/l10n.dart';

/// "Make calendar notifications loud" (Android only): turn it on, allow
/// notification access after a clear disclosure, and pick the apps.
class LoudNotificationsSection extends ConsumerStatefulWidget {
  const LoudNotificationsSection({super.key});

  @override
  ConsumerState<LoudNotificationsSection> createState() => _LoudNotificationsSectionState();
}

class _LoudNotificationsSectionState extends ConsumerState<LoudNotificationsSection>
    with WidgetsBindingObserver {
  bool _allowed = false;
  List<CalendarApp> _apps = const [];

  LoudNotifications get _loud => ref.read(loudNotificationsProvider);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _check();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // Back from the phone's settings: see whether access was allowed.
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) _check();
  }

  Future<void> _check() async {
    final allowed = await LoudNotifications.allowed();
    final apps = await LoudNotifications.installed();
    if (!mounted) return;
    setState(() {
      _allowed = allowed;
      _apps = apps;
    });
  }

  Future<void> _publish() => _loud.publish(
    now: DateTime.now(),
    plan: ref.read(planProvider),
    payloadFor: ref.read(payloadForProvider),
    quiet: ref.read(shabbatInUseProvider) ? ref.read(periodsProvider) : const [],
  );

  Future<void> _turn(bool on) async {
    if (!on) {
      await _loud.setOn(false);
      setState(() {});
      return;
    }
    // Play policy: say plainly what is read and why, before asking.
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.loudNotificationsDisclosureTitle),
        content: Text(l10n.loudNotificationsDisclosure),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: Text(l10n.cancel)),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(l10n.loudNotificationsAgree),
          ),
        ],
      ),
    );
    if (ok != true) return;
    await _loud.setOn(true);
    await _publish();
    if (!_allowed) await LoudNotifications.openSettings();
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final on = _loud.on;
    final picked = _loud.apps;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.loudNotificationsHeading, style: text.labelSmall),
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          secondary: const Icon(Icons.campaign_outlined, color: QuandoColors.amber),
          title: Text(l10n.loudNotificationsTitle),
          subtitle: Text(l10n.loudNotificationsHint, style: text.bodySmall),
          value: on,
          onChanged: _turn,
        ),
        if (on && !_allowed)
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.warning_amber_rounded, color: Colors.orangeAccent),
            title: Text(l10n.loudNotificationsNoAccess, style: text.bodySmall),
            trailing: FilledButton.tonal(
              onPressed: LoudNotifications.openSettings,
              child: Text(l10n.loudNotificationsAllow),
            ),
          ),
        if (on) ...[
          const SizedBox(height: 4),
          if (_apps.isEmpty)
            Text(l10n.loudNotificationsNoApps, style: text.bodySmall)
          else
            Wrap(
              spacing: 8,
              runSpacing: 4,
              children: [
                for (final a in _apps)
                  FilterChip(
                    label: Text(a.name),
                    selected: picked.contains(a.package),
                    onSelected: (v) async {
                      final next = {...picked};
                      v ? next.add(a.package) : next.remove(a.package);
                      await _loud.setApps(next);
                      setState(() {});
                    },
                  ),
              ],
            ),
          const SizedBox(height: 6),
          Text(
            ref.watch(shabbatInUseProvider)
                ? '${l10n.loudNotificationsTwiceNote} ${l10n.loudNotificationsShabbatNote}'
                : l10n.loudNotificationsTwiceNote,
            style: text.bodySmall,
          ),
        ],
      ],
    );
  }
}
