import 'package:flutter/material.dart';

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
        decoration: const InputDecoration(hintText: 'Work, Kids, Gym…'),
        onSubmitted: (v) => Navigator.pop(context, v.trim()),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
        TextButton(onPressed: () => Navigator.pop(context, controller.text.trim()), child: const Text('OK')),
      ],
    ),
  ).whenComplete(controller.dispose);
}

/// Lets you put an alarm in a group: one you have, a new one, or none.
/// Returns null when cancelled.
Future<String?> pickGroup(
  BuildContext context, {
  required List<String> groups,
  required String current,
}) async {
  final choice = await showModalBottomSheet<String>(
    context: context,
    showDragHandle: true,
    builder: (context) => SafeArea(
      child: ListView(
        shrinkWrap: true,
        children: [
          ListTile(
            leading: const Icon(Icons.block),
            title: const Text('No group'),
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
            title: const Text('New group…'),
            onTap: () => Navigator.pop(context, '\u0000new'),
          ),
        ],
      ),
    ),
  );
  if (choice != '\u0000new' || !context.mounted) return choice;
  final name = await askGroupName(context, title: 'New group');
  return name == null || name.isEmpty ? null : name;
}
