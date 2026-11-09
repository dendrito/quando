import 'package:kosher_dart/kosher_dart.dart';

import 'parasha_references.dart';

/// How parasha and month names are spelled: the Israeli (Sephardi)
/// spelling, as in Toldot and Tevet; the Ashkenazi one, as in Toldos and
/// Teves; or in Hebrew letters.
enum HebrewNames {
  israeli,
  ashkenazi,
  hebrew;

  static HebrewNames from(Object? name) =>
      values.firstWhere((v) => v.name == name, orElse: () => HebrewNames.israeli);
}

/// The Israeli (Sephardi) spelling, as Hebcal and Sefaria use it.
const israeliParashaNames = {
  Parsha.NONE: '',
  Parsha.BERESHIS: 'Bereshit',
  Parsha.NOACH: 'Noach',
  Parsha.LECH_LECHA: 'Lech Lecha',
  Parsha.VAYERA: 'Vayera',
  Parsha.CHAYEI_SARA: 'Chayei Sara',
  Parsha.TOLDOS: 'Toldot',
  Parsha.VAYETZEI: 'Vayetzei',
  Parsha.VAYISHLACH: 'Vayishlach',
  Parsha.VAYESHEV: 'Vayeshev',
  Parsha.MIKETZ: 'Miketz',
  Parsha.VAYIGASH: 'Vayigash',
  Parsha.VAYECHI: 'Vayechi',
  Parsha.SHEMOS: 'Shemot',
  Parsha.VAERA: 'Vaera',
  Parsha.BO: 'Bo',
  Parsha.BESHALACH: 'Beshalach',
  Parsha.YISRO: 'Yitro',
  Parsha.MISHPATIM: 'Mishpatim',
  Parsha.TERUMAH: 'Terumah',
  Parsha.TETZAVEH: 'Tetzaveh',
  Parsha.KI_SISA: 'Ki Tisa',
  Parsha.VAYAKHEL: 'Vayakhel',
  Parsha.PEKUDEI: 'Pekudei',
  Parsha.VAYIKRA: 'Vayikra',
  Parsha.TZAV: 'Tzav',
  Parsha.SHMINI: 'Shmini',
  Parsha.TAZRIA: 'Tazria',
  Parsha.METZORA: 'Metzora',
  Parsha.ACHREI_MOS: 'Achrei Mot',
  Parsha.KEDOSHIM: 'Kedoshim',
  Parsha.EMOR: 'Emor',
  Parsha.BEHAR: 'Behar',
  Parsha.BECHUKOSAI: 'Bechukotai',
  Parsha.BAMIDBAR: 'Bamidbar',
  Parsha.NASSO: 'Nasso',
  Parsha.BEHAALOSCHA: "Beha'alotcha",
  Parsha.SHLACH: "Sh'lach",
  Parsha.KORACH: 'Korach',
  Parsha.CHUKAS: 'Chukat',
  Parsha.BALAK: 'Balak',
  Parsha.PINCHAS: 'Pinchas',
  Parsha.MATOS: 'Matot',
  Parsha.MASEI: 'Masei',
  Parsha.DEVARIM: 'Devarim',
  Parsha.VAESCHANAN: 'Vaetchanan',
  Parsha.EIKEV: 'Eikev',
  Parsha.REEH: "Re'eh",
  Parsha.SHOFTIM: 'Shoftim',
  Parsha.KI_SEITZEI: 'Ki Teitzei',
  Parsha.KI_SAVO: 'Ki Tavo',
  Parsha.NITZAVIM: 'Nitzavim',
  Parsha.VAYEILECH: 'Vayeilech',
  Parsha.HAAZINU: "Ha'azinu",
  Parsha.VZOS_HABERACHA: 'Vezot Haberachah',
  Parsha.VAYAKHEL_PEKUDEI: 'Vayakhel-Pekudei',
  Parsha.TAZRIA_METZORA: 'Tazria-Metzora',
  Parsha.ACHREI_MOS_KEDOSHIM: 'Achrei Mot-Kedoshim',
  Parsha.BEHAR_BECHUKOSAI: 'Behar-Bechukotai',
  Parsha.CHUKAS_BALAK: 'Chukat-Balak',
  Parsha.MATOS_MASEI: 'Matot-Masei',
  Parsha.NITZAVIM_VAYEILECH: 'Nitzavim-Vayeilech',
  Parsha.SHKALIM: 'Shekalim',
  Parsha.ZACHOR: 'Zachor',
  Parsha.PARA: 'Parah',
  Parsha.HACHODESH: 'HaChodesh',
};

/// Months in the Israeli spelling, in kosher_dart's order.
const israeliMonthNames = [
  'Nisan',
  'Iyar',
  'Sivan',
  'Tamuz',
  'Av',
  'Elul',
  'Tishrei',
  'Cheshvan',
  'Kislev',
  'Tevet',
  "Sh'vat",
  'Adar',
  'Adar II',
  'Adar I',
];

/// A formatter for [names]; [hebrew] (the app in Hebrew) always uses
/// Hebrew letters.
HebrewDateFormatter hebrewFormatter({bool hebrew = false, HebrewNames names = HebrewNames.israeli}) {
  final f = HebrewDateFormatter()..hebrewFormat = hebrew || names == HebrewNames.hebrew;
  if (names == HebrewNames.israeli) {
    f.transliteratedParshaMap = {...f.transliteratedParshaMap, ...israeliParashaNames};
    f.transliteratedMonths = [...israeliMonthNames];
  }
  return f;
}

/// Today's Hebrew date and this week's parasha, such as
/// ("15 Cheshvan, 5787", "Toldot") or ("ט״ו חשון תשפ״ז", "וירא").
///
/// The Jewish day starts at nightfall: pass [afterSunset] to show tomorrow's
/// date in the evening. The parasha is empty on weeks a festival takes its
/// place.
(String, String) hebrewDate(
  DateTime local, {
  bool inIsrael = false,
  bool afterSunset = false,
  bool hebrew = false,
  HebrewNames names = HebrewNames.israeli,
}) {
  var day = DateTime(local.year, local.month, local.day);
  if (afterSunset) day = day.add(const Duration(days: 1));
  final jc = JewishCalendar.fromDateTime(day)..inIsrael = inIsrael;
  final f = hebrewFormatter(hebrew: hebrew, names: names);
  return (f.format(jc), f.formatWeeklyParsha(jc));
}

/// The same upcoming Shabbat as [hebrewDate], including Israel/diaspora and
/// Saturday-evening rollover. No approximate name-to-URL transliteration.
Uri? parashaSefaria(DateTime local, {bool inIsrael = false, bool afterSunset = false}) {
  var day = DateTime(local.year, local.month, local.day);
  if (afterSunset) day = day.add(const Duration(days: 1));
  day = day.add(Duration(days: (DateTime.saturday - day.weekday + 7) % 7));
  final calendar = JewishCalendar.fromDateTime(day)..inIsrael = inIsrael;
  final reference = parashaReferences[calendar.getParshah()];
  return reference == null ? null : Uri.https('www.sefaria.org', '/$reference', {'aliyot': '1'});
}

class RoshHodeshDate {
  const RoshHodeshDate({required this.first, required this.last, required this.month});
  final DateTime first, last;
  final String month;
  DateTime get begins => DateTime(first.year, first.month, first.day - 1);

  static RoshHodeshDate next(
    DateTime local, {
    bool afterSunset = false,
    bool hebrew = false,
    HebrewNames names = HebrewNames.israeli,
  }) {
    var today = DateTime(local.year, local.month, local.day);
    if (afterSunset) today = today.add(const Duration(days: 1));
    final format = hebrewFormatter(hebrew: hebrew, names: names);
    for (var i = 0; i < 65; i++) {
      final day = DateTime(today.year, today.month, today.day + i);
      final calendar = JewishCalendar.fromDateTime(day);
      if (!calendar.isRoshChodesh()) continue;
      final first =
          calendar.getJewishDayOfMonth() == 1 &&
              JewishCalendar.fromDateTime(DateTime(day.year, day.month, day.day - 1)).isRoshChodesh()
          ? DateTime(day.year, day.month, day.day - 1)
          : day;
      final last = calendar.getJewishDayOfMonth() == 30 ? DateTime(day.year, day.month, day.day + 1) : day;
      return RoshHodeshDate(
        first: first,
        last: last,
        month: format.formatMonth(JewishCalendar.fromDateTime(last)),
      );
    }
    throw StateError('No Rosh Hodesh within 65 days');
  }
}
