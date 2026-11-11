import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/edition.dart';
import '../../../app/providers.dart';
import '../../../app/theme.dart';
import '../../../core/util/local_time.dart';
import '../../../core/util/platform.dart';
import '../../calendar/data/loud_notifications.dart';
import '../data/busy_mode.dart';
import '../domain/busy.dart';

import 'package:quando/l10n/l10n.dart';

/// Busy mode: what happens while you're busy (Do Not Disturb, answers to
/// messages) and the busy times coming up. What makes you busy is set on
/// each alarm, calendar alarm and lock.
class BusyScreen extends ConsumerStatefulWidget {
  const BusyScreen({super.key});

  @override
  ConsumerState<BusyScreen> createState() => _BusyScreenState();
}

class _BusyScreenState extends ConsumerState<BusyScreen> with WidgetsBindingObserver {
  bool _dndAllowed = false;
  bool _listenerAllowed = false;
  late final TextEditingController _text;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _text = TextEditingController(text: ref.read(busySettingsProvider).replyText);
    _check();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _text.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) _check();
  }

  Future<void> _check() async {
    final dnd = await BusyMode.dndAllowed();
    final listener = await LoudNotifications.allowed();
    if (mounted) {
      setState(() {
        _dndAllowed = dnd;
        _listenerAllowed = listener;
      });
    }
  }

  void _update(BusySettings Function(BusySettings) change) =>
      ref.read(busySettingsProvider.notifier).update(change);

  Future<void> _turnReplies(bool on) async {
    if (!on) return _update((s) => s.copyWith(replies: false));
    // Play policy: say plainly what is read and sent, before asking.
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.busyRepliesDisclosureTitle),
        content: Text(l10n.busyRepliesDisclosure),
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
    _update((s) => s.copyWith(replies: true));
    if (!_listenerAllowed) await LoudNotifications.openSettings();
  }

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final s = ref.watch(busySettingsProvider);
    final windows = ref.watch(busyWindowsProvider);
    final home = ref.watch(homeZoneProvider);
    final shabbat = ref.watch(shabbatInUseProvider);
    String when(DateTime utc) => '${dayLabel(inZone(utc, home))} · ${hhmm(inZone(utc, home))}';

    return Scaffold(
      appBar: AppBar(title: Text(l10n.busyMode), backgroundColor: Colors.transparent),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(24, 8, 24, 48),
        children: [
          Text(l10n.busyIntro, style: text.bodyMedium),
          const SizedBox(height: 20),
          if (!isAndroid) ...[
            // iPhone and iPad: apps can't switch Focus or answer messages.
            Text(l10n.busyIosFocus, style: text.bodyMedium),
            const SizedBox(height: 20),
          ] else ...[
            Text(l10n.busyWhileHeading, style: text.labelSmall),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              secondary: const Icon(Icons.do_not_disturb_on_outlined, color: QuandoColors.amber),
              title: Text(l10n.busyDnd),
              subtitle: Text(l10n.busyDndHint, style: text.bodySmall),
              value: s.dnd,
              onChanged: (v) => _update((s) => s.copyWith(dnd: v)),
            ),
            if (s.dnd && !_dndAllowed)
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.warning_amber_rounded, color: Colors.orangeAccent),
                title: Text(l10n.busyDndNoAccess, style: text.bodySmall),
                trailing: FilledButton.tonal(
                  onPressed: BusyMode.openDndSettings,
                  child: Text(l10n.loudNotificationsAllow),
                ),
              ),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              secondary: const Icon(Icons.quickreply_outlined, color: QuandoColors.amber),
              title: Text(l10n.busyReplies),
              subtitle: Text(l10n.busyRepliesHint, style: text.bodySmall),
              value: s.replies,
              onChanged: _turnReplies,
            ),
            if (s.replies) ...[
              if (!_listenerAllowed)
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.warning_amber_rounded, color: Colors.orangeAccent),
                  title: Text(l10n.loudNotificationsNoAccess, style: text.bodySmall),
                  trailing: FilledButton.tonal(
                    onPressed: LoudNotifications.openSettings,
                    child: Text(l10n.loudNotificationsAllow),
                  ),
                ),
              TextField(
                controller: _text,
                minLines: 2,
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: l10n.busyReplyText,
                  hintText: l10n.busyReplyDefault('{until}'),
                  helperText: l10n.busyReplyTextHint('{until}'),
                ),
                onChanged: (v) => _update((s) => s.copyWith(replyText: v)),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children: [
                  for (final a in ReplyApp.known)
                    FilterChip(
                      label: Text(a.name),
                      selected: s.apps.contains(a.package),
                      onSelected: (v) => _update((s) {
                        final apps = {...s.apps};
                        v ? apps.add(a.package) : apps.remove(a.package);
                        return s.copyWith(apps: apps);
                      }),
                    ),
                ],
              ),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(l10n.busyGroups),
                subtitle: Text(l10n.busyGroupsHint, style: text.bodySmall),
                value: s.groups,
                onChanged: (v) => _update((s) => s.copyWith(groups: v)),
              ),
              if (shabbat)
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(l10n.busyRepliesOnShabbat),
                  subtitle: Text(l10n.busyAskRabbi, style: text.bodySmall),
                  value: s.repliesOnShabbat,
                  onChanged: (v) => _update((s) => s.copyWith(repliesOnShabbat: v)),
                ),
            ],
            const SizedBox(height: 20),
          ],
          Text(l10n.busyWhenHeading, style: text.labelSmall),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(l10n.busyWhenHint, style: text.bodySmall),
          ),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            secondary: const Icon(Icons.lock_outline, color: QuandoColors.amber),
            title: Text(l10n.busyDuringLock),
            subtitle: jewishHome ? Text(l10n.busyAskRabbi, style: text.bodySmall) : null,
            value: s.duringLock,
            onChanged: (v) => _update((s) => s.copyWith(duringLock: v)),
          ),
          const SizedBox(height: 12),
          Text(l10n.comingUpHeading, style: text.labelSmall),
          if (windows.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(l10n.busyNoneComing, style: text.bodySmall),
            ),
          for (final w in windows.take(10))
            ListTile(
              contentPadding: EdgeInsets.zero,
              dense: true,
              title: Text(w.label),
              trailing: Text(
                '${when(w.start)} – ${hhmm(inZone(w.end, home))}',
                style: text.bodySmall?.copyWith(color: QuandoColors.amber),
              ),
            ),
        ],
      ),
    );
  }
}
