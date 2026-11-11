import '../../home/data/weather_repository.dart';

/// One reminder: how long before the weather (or the thing you're going
/// out for) it goes off, and whether it rings loudly or just pings softly.
class WeatherReminder {
  const WeatherReminder({required this.lead, this.loud = true});

  final Duration lead;
  final bool loud;

  WeatherReminder copyWith({Duration? lead, bool? loud}) =>
      WeatherReminder(lead: lead ?? this.lead, loud: loud ?? this.loud);

  Map<String, dynamic> toJson() => {'minutes': lead.inMinutes, 'loud': loud};

  factory WeatherReminder.fromJson(Map<String, dynamic> j) => WeatherReminder(
    lead: Duration(minutes: ((j['minutes'] as num?)?.toInt() ?? 60).clamp(1, 48 * 60)),
    loud: j['loud'] as bool? ?? true,
  );
}

/// The weather kinds a reminder can be about, most serious first.
const weatherAlarmKinds = [WeatherKind.thunder, WeatherKind.snow, WeatherKind.rain, WeatherKind.fog];

/// "Warn me before it rains": which weather, how many reminders and when.
class WeatherAlarmSettings {
  const WeatherAlarmSettings({
    this.enabled = false,
    this.kinds = const {WeatherKind.rain, WeatherKind.thunder, WeatherKind.snow},
    this.reminders = const [
      WeatherReminder(lead: Duration(hours: 2)),
      WeatherReminder(lead: Duration(minutes: 30), loud: false),
    ],
    this.anytime = true,
    this.tied = true,
  });

  final bool enabled;
  final Set<WeatherKind> kinds;
  final List<WeatherReminder> reminders;

  /// Remind before the weather arrives, whatever you are doing.
  final bool anytime;

  /// Also remind before each of your alarms and calendar events when the
  /// forecast says that weather will be there.
  final bool tied;

  bool get active => enabled && kinds.isNotEmpty && reminders.isNotEmpty && (anytime || tied);

  WeatherAlarmSettings copyWith({
    bool? enabled,
    Set<WeatherKind>? kinds,
    List<WeatherReminder>? reminders,
    bool? anytime,
    bool? tied,
  }) => WeatherAlarmSettings(
    enabled: enabled ?? this.enabled,
    kinds: kinds ?? this.kinds,
    reminders: reminders ?? this.reminders,
    anytime: anytime ?? this.anytime,
    tied: tied ?? this.tied,
  );

  Map<String, dynamic> toJson() => {
    'enabled': enabled,
    'kinds': [for (final k in kinds) k.name],
    'reminders': [for (final r in reminders) r.toJson()],
    'anytime': anytime,
    'tied': tied,
  };

  factory WeatherAlarmSettings.fromJson(Map<String, dynamic> j) {
    const d = WeatherAlarmSettings();
    final kinds = j['kinds'] is List
        ? {
            for (final n in j['kinds'] as List)
              for (final k in weatherAlarmKinds)
                if (k.name == n) k,
          }
        : d.kinds;
    final reminders = j['reminders'] is List
        ? [
            for (final r in j['reminders'] as List)
              if (r is Map) WeatherReminder.fromJson(r.cast<String, dynamic>()),
          ]
        : d.reminders;
    return WeatherAlarmSettings(
      enabled: j['enabled'] as bool? ?? false,
      kinds: kinds,
      reminders: reminders,
      anytime: j['anytime'] as bool? ?? true,
      tied: j['tied'] as bool? ?? true,
    );
  }
}

/// A moment in your day the forecast is checked against: one of your
/// alarms or a calendar event.
class WeatherAnchor {
  const WeatherAnchor({required this.id, required this.at, required this.title});
  final String id;
  final DateTime at;
  final String title;
}

/// One reminder the planner wants to ring.
class WeatherAlert {
  const WeatherAlert({
    required this.key,
    required this.at,
    required this.kind,
    required this.onset,
    required this.lead,
    required this.loud,
    this.anchorTitle,
  });

  /// Stable across re-planning, so the same alert is never set twice.
  final String key;
  final DateTime at;
  final WeatherKind kind;

  /// When the weather is expected (or the time of the alarm or event it is
  /// tied to, when [anchorTitle] is set).
  final DateTime onset;
  final Duration lead;
  final bool loud;
  final String? anchorTitle;

  Map<String, dynamic> toJson() => {
    'key': key,
    'at': at.toUtc().toIso8601String(),
    'kind': kind.name,
    'onset': onset.toUtc().toIso8601String(),
    'lead': lead.inMinutes,
    'loud': loud,
    if (anchorTitle != null) 'anchor': anchorTitle,
  };

  static WeatherAlert? fromJson(Object? raw) {
    try {
      final j = (raw as Map).cast<String, dynamic>();
      return WeatherAlert(
        key: j['key'] as String,
        at: DateTime.parse(j['at'] as String),
        kind: WeatherKind.values.firstWhere((k) => k.name == j['kind']),
        onset: DateTime.parse(j['onset'] as String),
        lead: Duration(minutes: (j['lead'] as num).toInt()),
        loud: j['loud'] as bool? ?? true,
        anchorTitle: j['anchor'] as String?,
      );
    } catch (_) {
      return null;
    }
  }
}

/// Turns a forecast into the reminders to ring. Pure, so it is easy to test.
class WeatherPlanner {
  const WeatherPlanner({
    this.horizon = const Duration(hours: 48),
    this.tiedWindow = const Duration(hours: 1),
  });

  /// How far ahead reminders are planned.
  final Duration horizon;

  /// An alarm or event counts as "in the rain" when the weather is forecast
  /// within this long before or after it.
  final Duration tiedWindow;

  List<WeatherAlert> plan({
    required WeatherAlarmSettings settings,
    required List<WeatherHour> hours,
    required DateTime now,
    Iterable<WeatherAnchor> anchors = const [],
  }) {
    if (!settings.active || hours.isEmpty) return const [];
    final end = now.add(horizon);
    final sorted = [...hours]..sort((a, b) => a.at.compareTo(b.at));
    // Each forecast point covers the time up to the next one.
    DateTime stop(int i) =>
        i + 1 < sorted.length ? sorted[i + 1].at : sorted[i].at.add(const Duration(hours: 1));
    final reminders = [...settings.reminders]..sort((a, b) => b.lead.compareTo(a.lead));
    final out = <String, WeatherAlert>{};

    void add(String key, DateTime anchor, WeatherKind kind, {String? title}) {
      for (final r in reminders) {
        final at = anchor.subtract(r.lead);
        if (!at.isAfter(now) || at.isAfter(end)) continue;
        final k = '$key|${r.lead.inMinutes}';
        out.putIfAbsent(
          k,
          () => WeatherAlert(
            key: k,
            at: at,
            kind: kind,
            onset: anchor,
            lead: r.lead,
            loud: r.loud,
            anchorTitle: title,
          ),
        );
      }
    }

    if (settings.anytime) {
      for (var i = 0; i < sorted.length; i++) {
        final h = sorted[i];
        if (!settings.kinds.contains(h.kind)) continue;
        // Only the start of a spell: already raining means nothing to warn of.
        final startsSpell = i > 0 && !settings.kinds.contains(sorted[i - 1].kind);
        if (!startsSpell || !h.at.isAfter(now) || h.at.isAfter(end)) continue;
        add('any|${h.kind.name}|${h.at.millisecondsSinceEpoch ~/ 60000}', h.at, h.kind);
      }
    }

    if (settings.tied) {
      for (final a in anchors) {
        if (!a.at.isAfter(now) || a.at.isAfter(end)) continue;
        WeatherKind? worst;
        for (var i = 0; i < sorted.length; i++) {
          final h = sorted[i];
          if (!settings.kinds.contains(h.kind)) continue;
          final overlaps = h.at.isBefore(a.at.add(tiedWindow)) && stop(i).isAfter(a.at.subtract(tiedWindow));
          if (!overlaps) continue;
          if (worst == null || weatherAlarmKinds.indexOf(h.kind) < weatherAlarmKinds.indexOf(worst)) {
            worst = h.kind;
          }
        }
        if (worst != null) add('tied|${a.id}|${worst.name}', a.at, worst, title: a.title);
      }
    }
    return out.values.toList()..sort((a, b) => a.at.compareTo(b.at));
  }
}
