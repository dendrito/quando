import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/providers.dart';
import '../../../app/theme.dart';
import '../../../l10n/l10n.dart';
import '../../rules/domain/reminder_delivery.dart';

class SmartHomeTile extends ConsumerWidget {
  const SmartHomeTile({super.key, required this.value, required this.onChanged});
  final ReminderDelivery value;
  final ValueChanged<ReminderDelivery> onChanged;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scenes = {
      for (final scene in ref.watch(tuyaScenesProvider)) scene.key: scene,
      if (value.tuyaScene != null) value.tuyaScene!.key: value.tuyaScene!,
    };
    final enabled = ref.watch(integrationsProvider).smartHomeOn;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Material(
        color: QuandoColors.surface,
        borderRadius: BorderRadius.circular(20),
        clipBehavior: Clip.antiAlias,
        child: ExpansionTile(
          title: Text(l10n.smartHomeHeading),
          leading: const Icon(Icons.home_outlined),
          subtitle: value.tuyaScene == null ? null : Text(value.tuyaScene!.name),
          childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          children: [
            if (!enabled) Text(l10n.smartHomeDeviceOff),
            DropdownButtonFormField<String>(
              key: ValueKey(value.tuyaScene?.key),
              initialValue: value.tuyaScene?.key ?? '__none__',
              isExpanded: true,
              decoration: InputDecoration(labelText: l10n.tuyaAlarmScene),
              items: [
                DropdownMenuItem(value: '__none__', child: Text(l10n.off)),
                for (final scene in scenes.values)
                  DropdownMenuItem(
                    value: scene.key,
                    child: Text(scene.name, overflow: TextOverflow.ellipsis),
                  ),
              ],
              onChanged: (key) =>
                  onChanged(value.copyWith(tuyaScene: scenes[key], clearTuyaScene: key == '__none__')),
            ),
            TextButton.icon(
              onPressed: () => context.push('/connections'),
              icon: const Icon(Icons.link),
              label: Text(l10n.smartHomeConnect),
            ),
          ],
        ),
      ),
    );
  }
}
