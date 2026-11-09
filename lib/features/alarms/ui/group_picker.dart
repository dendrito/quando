import 'package:flutter/material.dart';
import 'package:quando/l10n/l10n.dart';

/// Asks for a group name. Returns null when cancelled, '' to leave groups.
Future<String?> askGroupName(BuildContext context, {required String title, String initial = ''}) {
  final controller = TextEditingController(text: initial);
  return showDialog<String>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: TextField(
        controller: controller,
        autofocus: true,
        textCapitalization: TextCapitalization.words,
        decoration: InputDecoration(hintText: l10n.groupNameHint),
        onSubmitted: (v) => Navigator.pop(context, v.trim()),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: Text(l10n.cancel)),
        TextButton(onPressed: () => Navigator.pop(context, controller.text.trim()), child: Text(l10n.ok)),
      ],
    ),
  ).whenComplete(controller.dispose);
}

/// Lets you put an alarm in a group: one you have, a new one, or none.
/// Returns null when cancelled.
Future<String?> pickGroup(BuildContext context, {required List<String> groups, required String current}) async {
  final choice = await showModalBottomSheet<String>(
    context: context,
    showDragHandle: true,
    builder: (context) => SafeArea(
      child: ListView(
        shrinkWrap: true,
        children: [
          ListTile(
            leading: const Icon(Icons.block),
            title: Text(l10n.noGroup),
            selected: current.isEmpty,
            onTap: () => Navigator.pop(context, ''),
          ),
          for (final g in groups)
            ListTile(
              leading: const Icon(Icons.folder_outlined),
              title: Text(g),
              selected: g == current,
              onTap: () => Navigator.pop(context, g),
            ),
          ListTile(
            leading: const Icon(Icons.create_new_folder_outlined),
            title: Text(l10n.newGroupEllipsis),
            onTap: () => Navigator.pop(context, '\u0000new'),
          ),
        ],
      ),
    ),
  );
  if (choice != '\u0000new' || !context.mounted) return choice;
  final name = await askGroupName(context, title: l10n.newGroup);
  return name == null || name.isEmpty ? null : name;
}
