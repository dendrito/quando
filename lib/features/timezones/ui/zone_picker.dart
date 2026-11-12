import 'package:flutter/material.dart';

import '../../../app/theme.dart';
import '../../../core/util/local_time.dart';

import 'package:quando/l10n/l10n.dart';

/// Full-screen search over every city time zone. Returns the zone id, or
/// null if closed.
Future<String?> pickZone(BuildContext context, {required String home}) =>
    Navigator.of(context).push<String>(MaterialPageRoute(builder: (_) => _ZonePicker(home: home)));

class _ZonePicker extends StatefulWidget {
  const _ZonePicker({required this.home});

  final String home;

  @override
  State<_ZonePicker> createState() => _ZonePickerState();
}

class _ZonePickerState extends State<_ZonePicker> {
  final _all = allZones();
  var _query = '';

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now().toUtc();
    final q = _query.toLowerCase().replaceAll(' ', '_');
    // Names people search by that are not a zone's own city name.
    const aliases = {'rio': 'sao_paulo', 'rio_de_janeiro': 'sao_paulo'};
    final alias = aliases[q];
    final shown = q.isEmpty
        ? _all
        : _all.where((z) {
            final l = z.toLowerCase();
            return l.contains(q) || (alias != null && l.contains(alias));
          }).toList();
    final text = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: TextField(
          autofocus: true,
          decoration: InputDecoration(hintText: l10n.searchCity, border: InputBorder.none),
          onChanged: (v) => setState(() => _query = v.trim()),
        ),
      ),
      body: ListView.builder(
        itemCount: shown.length,
        itemBuilder: (context, i) {
          final z = shown[i];
          return ListTile(
            title: Text(cityOf(z)),
            subtitle: Text(
              '${z.split('/').first} · ${offsetFrom(z, widget.home, now)}',
              style: text.bodySmall,
            ),
            trailing: Text(
              hhmm(inZone(now, z)),
              style: text.titleMedium?.copyWith(color: QuandoColors.amber),
            ),
            onTap: () => Navigator.pop(context, z),
          );
        },
      ),
    );
  }
}
