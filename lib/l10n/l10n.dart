import 'package:flutter/widgets.dart';

import 'app_localizations.dart';

export 'app_localizations.dart';

/// Quando's words in the language in use. Global, so code without a
/// BuildContext (alarm titles, notifications, schedules) speaks it too.
AppLocalizations l10n = lookupAppLocalizations(const Locale('en'));

/// English, for matching searches saved in English (`candle*`).
final AppLocalizations l10nEn = lookupAppLocalizations(const Locale('en'));

Locale _locale = const Locale('en');

/// The language in use, after matching it to one Quando speaks.
Locale get currentLocale => _locale;

/// The language names, each in its own language, for the picker.
const languageNames = <String, String>{
  'en': 'English',
  'pt': 'Português (Brasil)',
  'es': 'Español',
  'fr': 'Français',
  'de': 'Deutsch',
  'it': 'Italiano',
  'nl': 'Nederlands',
  'pl': 'Polski',
  'ru': 'Русский',
  'uk': 'Українська',
  'tr': 'Türkçe',
  'ar': 'العربية',
  'he': 'עברית',
  'hi': 'हिन्दी',
  'id': 'Bahasa Indonesia',
  'ja': '日本語',
  'ko': '한국어',
  'zh': '中文（简体）',
  'zh_Hant': '中文（繁體）',
  'vi': 'Tiếng Việt',
};

/// `zh_Hant` -> Locale('zh', script 'Hant').
Locale localeFromTag(String tag) {
  final parts = tag.split('_');
  if (parts.length == 2 && parts[1].length == 4) {
    return Locale.fromSubtags(languageCode: parts[0], scriptCode: parts[1]);
  }
  return parts.length == 2 ? Locale(parts[0], parts[1]) : Locale(parts[0]);
}

/// The closest language Quando speaks to [wanted] (the phone's languages,
/// best first). Traditional Chinese for Taiwan, Hong Kong and Macau.
Locale resolveLocale(Iterable<Locale> wanted) {
  for (final w in wanted) {
    if (w.languageCode == 'zh') {
      final hant =
          w.scriptCode == 'Hant' ||
          const {'TW', 'HK', 'MO'}.contains(w.countryCode);
      return hant
          ? const Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hant')
          : const Locale('zh');
    }
    // Old Hebrew and Indonesian codes some phones still send.
    final code = switch (w.languageCode) {
      'iw' => 'he',
      'in' => 'id',
      final c => c,
    };
    if (AppLocalizations.supportedLocales.any((s) => s.languageCode == code))
      return Locale(code);
  }
  return const Locale('en');
}

/// Switches [l10n] to the closest language to [wanted].
Locale useLocale(Iterable<Locale> wanted) {
  _locale = resolveLocale(wanted);
  l10n = lookupAppLocalizations(_locale);
  return _locale;
}
