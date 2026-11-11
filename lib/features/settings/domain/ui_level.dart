import 'package:shared_preferences/shared_preferences.dart';

/// How much of Quando? is on screen. Nothing is ever removed: alarms made
/// in Everything keep every option and ring the same in Simple.
enum UiLevel { simple, everything }

/// Where the level and the first-run question are kept.
class UiLevelStore {
  static const levelKey = 'ui.level';
  static const askKey = 'ui.ask';
  static const ringsKey = 'ring.count';

  /// Run once at start-up, before anything else writes a setting. A
  /// brand-new install (nothing saved yet) is asked the first-run question;
  /// everyone who already has settings is never asked and stays on
  /// Everything.
  static void init(SharedPreferences prefs) {
    if (prefs.containsKey(askKey)) return;
    prefs.setBool(askKey, prefs.getKeys().isEmpty);
  }

  static UiLevel read(SharedPreferences prefs) =>
      UiLevel.values.where((l) => l.name == prefs.getString(levelKey)).firstOrNull ?? UiLevel.everything;

  /// True until the first-run question has been answered.
  static bool pending(SharedPreferences prefs) =>
      prefs.getBool(askKey) == true && !prefs.containsKey(levelKey);
}
