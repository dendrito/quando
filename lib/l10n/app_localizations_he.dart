// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hebrew (`he`).
class AppLocalizationsHe extends AppLocalizations {
  AppLocalizationsHe([String locale = 'he']) : super(locale);

  @override
  String get undo => 'ביטול';

  @override
  String duplicatedNamed(String name) {
    return '„$name” שוכפל';
  }

  @override
  String deletedNamed(String name) {
    return '„$name” נמחק';
  }

  @override
  String get when => 'מתי?';

  @override
  String get newAtTime => 'בשעה מסוימת';

  @override
  String get newAtTimeHint => 'כל יום חול ב־7:00, פעם אחת ב־15:30…';

  @override
  String get newAroundEvent => 'סביב אירוע';

  @override
  String get newAroundEventHint => 'חיפוש ביומנים, בזמני שבת ובזמני השמש, וצלצול לפני, בזמן או אחרי';

  @override
  String get editThisAlarm => 'עריכת ההתראה';

  @override
  String editNamed(String name) {
    return 'עריכת „$name”';
  }

  @override
  String get preset => 'תבנית';

  @override
  String get editThisCalendarRule => 'עריכת כלל היומן';

  @override
  String get ringThisOneAfterAll => 'בכל זאת לצלצל';

  @override
  String get skipJustThisOne => 'לדלג רק על זו';

  @override
  String get renameGroup => 'שינוי שם הקבוצה';

  @override
  String quickSet(String label, String time) {
    return '$label · מצלצל ב־$time';
  }

  @override
  String get newAlarm => 'התראה חדשה';

  @override
  String get appName => 'Quando?';

  @override
  String get lockMode => 'מצב נעילה';

  @override
  String get calendars => 'יומנים';

  @override
  String get settings => 'הגדרות';

  @override
  String get nextAlarmHeading => 'ההתראה הבאה';

  @override
  String get nothingSet => 'אין התראות';

  @override
  String get tagline => 'לַכֹּל זְמָן.';

  @override
  String sunriseAt(String time) {
    return 'זריחה $time';
  }

  @override
  String sunsetAt(String time) {
    return 'שקיעה $time';
  }

  @override
  String get alarmsMayNotRing => 'ייתכן שההתראות לא יצלצלו';

  @override
  String get tapToFixIt => 'הקישו לתיקון';

  @override
  String inMinutes(int minutes) {
    return 'בעוד $minutes דק׳';
  }

  @override
  String get atSunset => 'בשקיעה';

  @override
  String get sunset => 'שקיעה';

  @override
  String get shabbatModeIsOn => 'מצב שבת פעיל';

  @override
  String nextInCity(String city) {
    return 'הבא · $city';
  }

  @override
  String get candleLighting => 'הדלקת נרות';

  @override
  String get havdalah => 'הבדלה';

  @override
  String get shabbatAndFestivals => 'שבת וחגים';

  @override
  String get yourAlarmsHeading => 'ההתראות שלך';

  @override
  String get tapWhenToAdd => 'הקישו על „מתי?” כדי להוסיף התראה.';

  @override
  String get aroundEventsHeading => 'סביב אירועים';

  @override
  String searchFor(String words) {
    return 'חיפוש: $words';
  }

  @override
  String get thisWeekHeading => 'ההתראות השבוע';

  @override
  String get noAlarmsThisWeek => 'אין התראות ב־7 הימים הקרובים.';

  @override
  String get alarmsSetThemselves => 'ההתראות נקבעות מעצמן בטלפון הזה בכל פעם שמשנים משהו.';

  @override
  String cityTime(String city) {
    return 'שעון $city';
  }

  @override
  String get more => 'עוד';

  @override
  String get turnOff => 'כיבוי';

  @override
  String get turnOn => 'הפעלה';

  @override
  String get duplicate => 'שכפול';

  @override
  String get delete => 'מחיקה';

  @override
  String get inOneHour => 'בעוד שעה';

  @override
  String get logoLabel => 'הלוגו של Quando?';

  @override
  String get noTimesSet => 'לא נקבעו זמנים';

  @override
  String get atTheMoment => 'בזמן עצמו';

  @override
  String timesRange(int count, String from, String to) {
    return '$count פעמים · מ$from עד $to';
  }

  @override
  String spanDays(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n ימים',
      two: 'יומיים',
      one: 'יום אחד',
    );
    return '$_temp0';
  }

  @override
  String spanHours(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n שעות',
      two: 'שעתיים',
      one: 'שעה אחת',
    );
    return '$_temp0';
  }

  @override
  String spanMinutes(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n דקות', one: 'דקה אחת');
    return '$_temp0';
  }

  @override
  String spanSeconds(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n שניות', one: 'שנייה אחת');
    return '$_temp0';
  }

  @override
  String get now => 'עכשיו';

  @override
  String spanBefore(String span) {
    return '$span לפני';
  }

  @override
  String spanAfter(String span) {
    return '$span אחרי';
  }

  @override
  String alarmCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n התראות', one: 'התראה אחת');
    return '$_temp0';
  }

  @override
  String get allOn => 'כולן פעילות';

  @override
  String get allOff => 'כולן כבויות';

  @override
  String someOn(int n) {
    return '$n פעילות';
  }

  @override
  String skippedBody(String body) {
    return 'דולגה · $body';
  }

  @override
  String timeToTime(String from, String to) {
    return '$from עד $to';
  }

  @override
  String skippedCount(int n) {
    return '$n דולגו';
  }

  @override
  String get sunNoRiseSet => 'השמש לא זורחת ולא שוקעת כאן היום';

  @override
  String sunProgress(int percent) {
    return 'השמש עברה $percent% מהיום';
  }

  @override
  String get sunIsDown => 'השמש כבר שקעה';

  @override
  String get searchCity => 'חיפוש עיר';

  @override
  String get tomorrowLower => 'מחר';

  @override
  String get yesterdayLower => 'אתמול';

  @override
  String get worldClocksHeading => 'שעוני עולם';

  @override
  String get add => 'הוספה';

  @override
  String cityHere(String city) {
    return '$city · כאן';
  }

  @override
  String get worldClocksHint => 'הוסיפו ערים כדי לראות כאן את השעה בהן. החליקו שמאלה כדי להסיר.';

  @override
  String get groupNameHint => 'עבודה, ילדים, חדר כושר…';

  @override
  String get cancel => 'ביטול';

  @override
  String get ok => 'אישור';

  @override
  String get noGroup => 'ללא קבוצה';

  @override
  String get newGroupEllipsis => 'קבוצה חדשה…';

  @override
  String get newGroup => 'קבוצה חדשה';

  @override
  String secondsShort(int n) {
    return '$n שנ׳';
  }

  @override
  String minutesShort(int n) {
    return '$n דק׳';
  }

  @override
  String get minutes => 'דקות';

  @override
  String get ringFor => 'משך הצלצול';

  @override
  String get seconds => 'שניות';

  @override
  String get oneSecondLess => 'שנייה פחות';

  @override
  String get oneSecondMore => 'שנייה יותר';

  @override
  String inDays(int d) {
    return 'בעוד $d י׳';
  }

  @override
  String inDaysHours(int d, int h) {
    return 'בעוד $d י׳ $h ש׳';
  }

  @override
  String inHours(int h) {
    return 'בעוד $h ש׳';
  }

  @override
  String inHoursMinutes(int h, int m) {
    return 'בעוד $h ש׳ $m ד׳';
  }

  @override
  String inMins(int m) {
    return 'בעוד $m ד׳';
  }

  @override
  String placeChange(String city, String where) {
    return '$city · $where · שינוי';
  }

  @override
  String get israel => 'בארץ';

  @override
  String get outsideIsrael => 'בחו״ל';

  @override
  String get comingUpHeading => 'בקרוב';

  @override
  String get lockForShabbat => 'נעילת הטלפון בשבת';

  @override
  String get lockForShabbatHint => 'מהדלקת נרות ועד הבדלה, גם בחגים';

  @override
  String get ownShabbatAlarmsHeading => 'התראות השבת שלך';

  @override
  String get addShabbatAlarm => 'הוספת התראה לשבת או לחג';

  @override
  String get readyMadeHeading => 'התראות מוכנות';

  @override
  String bringBackDeleted(int n) {
    return 'החזרת אלה שנמחקו ($n)';
  }

  @override
  String get presetsHint => 'הקישו על אחת כדי לשנות את הזמנים. החליקו כדי למחוק.';

  @override
  String get lockSentence => 'נועלים את הטלפון רק לשעון ולהתראות, לשבת או ללילה של ריכוז.';

  @override
  String get lockExplain =>
      'בזמן הנעילה Quando? מציג רק את השעה, את ההתראה הבאה ומתי הנעילה מסתיימת. ההתראות ממשיכות לפעול, ואי אפשר לשנות דבר עד שהנעילה משתחררת.';

  @override
  String get lockNowHeading => 'נעילה עכשיו';

  @override
  String get lockAutoHeading => 'נעילה אוטומטית';

  @override
  String get shabbatAndFestivalsLong => 'שבתות וחגים';

  @override
  String get fromCandleToHavdalah => 'מהדלקת נרות ועד הבדלה';

  @override
  String get lockCalendarWord => 'בזמן אירועי יומן עם המילה הזו';

  @override
  String get lockCalendarWordHint => 'למשל נעילה, מבחן, ריכוז';

  @override
  String get leaveEmptyForNone => 'השאירו ריק כדי לא להשתמש';

  @override
  String get connectCalendarsFirst => 'קודם חברו יומנים (סמל היומן)';

  @override
  String get openWhenLockStarts => 'פתיחת Quando? כשנעילה מתחילה';

  @override
  String get openWhenLockStartsHint => 'צליל עדין של שנייה מביא את Quando? לקדמת המסך כדי לנעול';

  @override
  String get pinToScreen => 'הצמדת Quando? למסך';

  @override
  String get pinToScreenHint => 'אי אפשר לפתוח אפליקציות אחרות בזמן הנעילה. Android מבקש אישור בפעם הראשונה.';

  @override
  String get noLocksComingUp => 'אין נעילות קרובות.';

  @override
  String get leaveLockEarly => 'כדי לצאת מנעילה מוקדם, לחצו לחיצה ארוכה על „החזיקו לשחרור” במשך 3 שניות.';

  @override
  String get locked => 'נעול';

  @override
  String get shabbatShalom => 'שבת שלום';

  @override
  String get chagSameach => 'חג שמח';

  @override
  String get unlocksHeading => 'משתחרר';

  @override
  String get nowCap => 'עכשיו';

  @override
  String get nextAlarm => 'ההתראה הבאה';

  @override
  String get holdToUnlock => 'החזיקו לשחרור';

  @override
  String get calendarAlarm => 'התראת יומן';

  @override
  String get connectCalendars => 'חיבור יומנים';

  @override
  String get calendarAlarmsHeading => 'התראות יומן';

  @override
  String get calendarNoneYet => 'עדיין אין. התחילו מזו ושנו כרצונכם:';

  @override
  String get fifteenBeforeEvery => '15 דקות לפני כל אירוע';

  @override
  String get useTheseCalendarsHeading => 'להשתמש ביומנים האלה';

  @override
  String get noTimedEvents => 'אין אירועים עם שעה קרובים ביומנים האלה.';

  @override
  String get atTheStart => 'בתחילתו';

  @override
  String everyForBefore(String every, String span) {
    return 'כל $every במשך $span לפני';
  }

  @override
  String spanAfterItEnds(String span) {
    return '$span אחרי שהוא נגמר';
  }

  @override
  String get noAlarmsChosen => 'לא נבחרו התראות';

  @override
  String get gentleWakeUp => 'השכמה עדינה';

  @override
  String gentleSummary(int minutes, String sound) {
    return '$minutes דק׳ לפני · $sound';
  }

  @override
  String get off => 'כבוי';

  @override
  String get gentleSentence => 'צליל רגוע מתחיל בשקט לפני ההתראה, כך שלעולם לא תתעוררו בבהלה.';

  @override
  String get gentleExplain => 'הוא מתגבר לאט, מוציא אתכם משינה קלה, ונעצר ממש לפני שההתראה מצלצלת.';

  @override
  String get startsBeforeHeading => 'מתחיל לפני ההתראה';

  @override
  String get leadUpSoundHeading => 'צליל מקדים';

  @override
  String get listen => 'האזנה';

  @override
  String get whoRecordedThese => 'מי הקליט את הצלילים';

  @override
  String get done => 'סיום';

  @override
  String get soundCredits => 'קרדיטים לצלילים';

  @override
  String yourTimeCity(String city) {
    return 'השעה שלך ($city)';
  }

  @override
  String get anotherCity => 'עיר אחרת…';

  @override
  String get ringingIn5 => 'מצלצל בעוד 5 שניות…';

  @override
  String get alarmSaved => 'ההתראה נשמרה.';

  @override
  String alarmSetFor(String span) {
    return 'ההתראה נקבעה לעוד $span.';
  }

  @override
  String hoursMinutesShort(int h, int m) {
    return '$h ש׳ $m דק׳';
  }

  @override
  String get editAlarm => 'עריכת התראה';

  @override
  String get previewCaps => 'ניסיון';

  @override
  String get saveCaps => 'שמירה';

  @override
  String cityTimeForYou(String city, String time) {
    return 'שעון $city · $time אצלך';
  }

  @override
  String repeatHeading(String repeat) {
    return 'חזרה · $repeat';
  }

  @override
  String get labelField => 'תווית (מוקראת אם התראות מדוברות מופעלות)';

  @override
  String get group => 'קבוצה';

  @override
  String ringsForHeading(String span) {
    return 'מצלצל במשך $span';
  }

  @override
  String useDefault(String value) {
    return 'ברירת המחדל ($value)';
  }

  @override
  String get save => 'שמירה';

  @override
  String get sameTime => 'אותה שעה';

  @override
  String get untilYouStopIt => 'עד שעוצרים';

  @override
  String get alarm => 'התראה';

  @override
  String get once => 'פעם אחת';

  @override
  String get everyDay => 'כל יום';

  @override
  String get weekdays => 'ימי חול';

  @override
  String get weekends => 'סופי שבוע';

  @override
  String timeInCity(String time, String city) {
    return '$time שעון $city';
  }

  @override
  String eventsMatching(String words) {
    return 'אירועים עם „$words”';
  }

  @override
  String get everyEvent => 'כל אירוע';

  @override
  String get sunrise => 'זריחה';

  @override
  String havdalahEndOf(String day) {
    return 'הבדלה · צאת $day';
  }

  @override
  String get yomTov => 'יום טוב';

  @override
  String get shabbat => 'שבת';

  @override
  String get presetCountdown => 'ספירה לאחור עד הדלקת נרות';

  @override
  String get presetHourly => 'כל שעה, מ־6 שעות לפני';

  @override
  String get presetDailyWeek => 'פעם ביום, בשבוע שלפני';

  @override
  String get presetSecondNight => 'נרות של ליל שני';

  @override
  String get presetFridayReminder => 'תזכורת 3 שעות לפני: להטעין את הטלפון';

  @override
  String get presetFridayReminderLabel => 'להטעין את הטלפון ולכוון התראות למחר';

  @override
  String get presetSunset => 'שקיעה, ו־15 דקות לפני';

  @override
  String get pesach => 'פסח';

  @override
  String get shavuot => 'שבועות';

  @override
  String get roshHashanah => 'ראש השנה';

  @override
  String get yomKippur => 'יום כיפור';

  @override
  String get sukkot => 'סוכות';

  @override
  String get sheminiAtzeret => 'שמיני עצרת';

  @override
  String get simchatTorah => 'שמחת תורה';

  @override
  String get readyNotifications => 'הצגת התראות';

  @override
  String get readyNotificationsWhy => 'מאפשר למסך הצלצול ולכפתור העצירה להופיע.';

  @override
  String get readyFullScreen => 'צלצול מעל מסך הנעילה';

  @override
  String get readyFullScreenWhy => 'מציג את ההתראה במסך מלא, גם כשהטלפון נעול.';

  @override
  String get readyExact => 'צלצול בדקה המדויקת';

  @override
  String get readyExactWhy => 'בלי זה, הטלפון עלול לצלצל באיחור של כמה דקות.';

  @override
  String get readyBattery => 'המשך פעולה בחיסכון בסוללה';

  @override
  String get readyBatteryWhy => 'מונע מחיסכון הסוללה להשתיק התראות בלילה.';

  @override
  String get tipXiaomi =>
      'טלפוני Xiaomi: בהגדרות › אפליקציות › Quando?, הפעילו הפעלה אוטומטית וקבעו את חיסכון הסוללה ל„ללא הגבלות”.';

  @override
  String get tipSamsung =>
      'טלפוני Samsung: בהגדרות › סוללה › מגבלות שימוש ברקע, ודאו ש־Quando? לא במצב שינה.';

  @override
  String get tipHuawei =>
      'טלפוני Huawei ו־Honor: בהגדרות › סוללה › הפעלת אפליקציות, קבעו את Quando? לניהול ידני ואפשרו הכול.';

  @override
  String get tipOther =>
      'בטלפון הזה: בהגדרות › סוללה, אפשרו ל־Quando? לפעול ברקע וכבו עבורו את האופטימיזציה.';

  @override
  String get testRing => 'צלצול ניסיון';

  @override
  String get testRingBody => 'Quando? יכול להעיר אותך';

  @override
  String get ringsIn20 => 'מצלצל בעוד 20 שניות. נעלו את הטלפון עכשיו וחכו.';

  @override
  String get readyToRing => 'מוכן לצלצל';

  @override
  String get checkingPhone => 'בודקים את הטלפון…';

  @override
  String get phoneReady => 'הטלפון מוכן לצלצל כל התראה בזמן.';

  @override
  String thingsNeedFixing(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'צריך לתקן $n דברים, אחרת ייתכן שההתראות לא יצלצלו.',
      one: 'צריך לתקן דבר אחד, אחרת ייתכן שההתראות לא יצלצלו.',
    );
    return '$_temp0';
  }

  @override
  String get fix => 'תיקון';

  @override
  String get testIn20 => 'בדיקה: צלצול בעוד 20 שניות';

  @override
  String get testIn20Hint => 'נעלו את הטלפון והניחו אותו. אם ההתראה מצלצלת ומוצגת במסך מלא, הכול מוכן.';

  @override
  String get readyToRingHint => 'בדיקה שהטלפון מאפשר לכל התראה לצלצל בזמן';

  @override
  String get connections => 'חיבורים';

  @override
  String get timeZoneHeading => 'אזור זמן';

  @override
  String get followPhone => 'לפי הטלפון';

  @override
  String followPhoneNow(String city) {
    return 'כעת $city. משתנה מעצמו כשנוסעים.';
  }

  @override
  String get zoneFixed => 'קבוע. ההתראות שומרות על השעה הזו גם בנסיעות.';

  @override
  String get shabbatCityHeading => 'עיר לזמני השבת';

  @override
  String get inIsraelOneDay => 'בארץ ישראל (יום טוב אחד)';

  @override
  String candleMinutesHeading(int n) {
    return 'הדלקת נרות: $n דקות לפני השקיעה';
  }

  @override
  String get endOfShabbatHeading => 'צאת שבתות וחגים';

  @override
  String get nightfallGeonim => 'צאת הכוכבים (גאונים, 8.5°)';

  @override
  String get rabbeinuTam => '72 דקות אחרי השקיעה (רבנו תם)';

  @override
  String get whenAlarmRingsHeading => 'כשהתראה מצלצלת';

  @override
  String get recordOrAddSounds => 'הקלטה או הוספת צלילים';

  @override
  String get ringsForThisLong => 'מצלצל כל כך הרבה זמן ואז נעצר מעצמו';

  @override
  String get sameFades => 'אותם מעברים לכל ההתראות';

  @override
  String get sameFadesOn => 'גובר על המעברים של כל התראה. כל אחת שומרת על עוצמת הקול שלה.';

  @override
  String get sameFadesOff => 'כבוי: כל התראה משתמשת במעברים שנקבעו תחת עוצמת הקול שלה.';

  @override
  String get sayItOutLoud => 'הקראה בקול';

  @override
  String get sayItOutLoudHint => 'מקריא למה ההתראה, למשל „הדלקת נרות, 15 דקות לפני”';

  @override
  String get noSnooze => 'ללא נודניק';

  @override
  String snoozeUpTo(int times, int minutes) {
    return 'נודניק עד $times× של $minutes דק׳';
  }

  @override
  String get wakeUpCheck => 'בדיקת השכמה';

  @override
  String get wakeUpCheckHint => 'אחרי העצירה, מצלצל שוב בעוד 3 דקות אם לא מקישים „קמתי”';

  @override
  String get solveSum => 'לפתור תרגיל כדי לעצור';

  @override
  String get provesAwake => 'מוכיח שאתם ערים';

  @override
  String get shabbatNoTasks =>
      'בשבת ובחג אף אחד מאלה לא חל: ההתראות נעצרות מעצמן ולעולם לא מבקשות לגעת בטלפון.';

  @override
  String get testAlarmIn1 => 'צלצול ניסיון בעוד דקה';

  @override
  String get timesDisclaimer => 'הזמנים מחושבים בטלפון. במקרי גבול, התייעצו עם הרב או עם לוח הקהילה.';

  @override
  String get recommended => 'מומלץ';

  @override
  String get chooseCity => 'בחירת עיר';

  @override
  String get testOnlyOnPhone => 'התראות ניסיון פועלות רק בטלפון.';

  @override
  String get testAlarm => 'התראת ניסיון';

  @override
  String get testAlarmBody => 'כך יישמעו ההתראות שלך';

  @override
  String get testAlarmIn1Set => 'התראת ניסיון בעוד דקה. אפשר לנעול את הטלפון.';

  @override
  String get presetGone => 'התבנית הזו כבר לא קיימת.';

  @override
  String get editPreset => 'עריכת תבנית';

  @override
  String get on => 'פעיל';

  @override
  String get ringsHeading => 'מצלצל';

  @override
  String get noTimesYet => 'אין עדיין זמנים. הוסיפו למטה.';

  @override
  String get atTheMomentItself => 'בזמן עצמו';

  @override
  String get remove => 'הסרה';

  @override
  String get addATime => 'הוספת זמן';

  @override
  String get resetPreset => 'איפוס לברירת המחדל';

  @override
  String get skipOneHint => 'כדי לדלג על התראה אחת, הקישו עליה ב„ההתראות השבוע” במסך הבית.';

  @override
  String get unitMinutes => 'דקות';

  @override
  String get unitHours => 'שעות';

  @override
  String get unitDays => 'ימים';

  @override
  String get before => 'לפני';

  @override
  String get after => 'אחרי';

  @override
  String get oneWeek => 'שבוע';

  @override
  String daysShort(int n) {
    return '$n י׳';
  }

  @override
  String hoursShort(int n) {
    return '$n ש׳';
  }

  @override
  String get howToSearch => 'איך מחפשים';

  @override
  String get searchHelpWord => 'הכותרת מכילה „dentist”, בלי הבדל בין אותיות גדולות לקטנות';

  @override
  String get searchHelpStar => '‏* הוא כל רצף אותיות: dentist, dentures';

  @override
  String get searchHelpQuestion => '‏? הוא אות אחת: yoga, toga';

  @override
  String get searchHelpPhrase => 'הביטוי המדויק הזה';

  @override
  String get searchHelpAnd => 'שתי המילים (AND)';

  @override
  String get searchHelpOr => 'אחת מהן. גם | עובד';

  @override
  String get searchHelpNot => 'להוציא. גם NOT ו־! עובדים';

  @override
  String get searchHelpBrackets => 'סוגריים מקבצים מילים';

  @override
  String get searchHelpEmpty => 'השאירו ריק כדי לצלצל לכל אירוע.';

  @override
  String get customTime => 'זמן אחר';

  @override
  String get other => 'אחר';

  @override
  String get sun => 'שמש';

  @override
  String get calendar => 'יומן';

  @override
  String get newEventAlarm => 'התראת אירוע חדשה';

  @override
  String get eventAlarm => 'התראת אירוע';

  @override
  String get findEventsHeading => 'מציאת האירועים';

  @override
  String get searchEventsHint => 'חיפוש: רופא שיניים, כושר OR יוגה, רופא*…';

  @override
  String get alsoBuiltInTimes => 'גם זמני שבת, חגים ושמש';

  @override
  String get alsoBuiltInTimesHint => 'למשל „הדלקת*”, „הבדלה”, „שקיעה”';

  @override
  String get allMyCalendars => 'כל היומנים שלי';

  @override
  String get connectToSearch => 'חברו את היומנים כדי לחפש בהם';

  @override
  String get searching => 'מחפשים…';

  @override
  String get nothingMatches60 => 'אין התאמות ב־60 הימים הקרובים';

  @override
  String eventsIn60(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n אירועים ב־60 הימים הקרובים',
      one: 'אירוע אחד ב־60 הימים הקרובים',
    );
    return '$_temp0';
  }

  @override
  String nextRingsAt(String times, String title) {
    return 'הבא: מצלצל ב־$times עבור „$title”';
  }

  @override
  String showMoreLeft(int n) {
    return 'עוד (נותרו $n)';
  }

  @override
  String get ringBeforeStartsHeading => 'צלצול לפני שמתחיל';

  @override
  String get ringWhenStarts => 'צלצול כשמתחיל';

  @override
  String get repeatBeforeHeading => 'וחזרה לפניו';

  @override
  String get everyPrefix => 'כל ';

  @override
  String get offLower => 'כבוי';

  @override
  String get forInfix => '  במשך ';

  @override
  String get ringAfterEndsHeading => 'צלצול אחרי שנגמר';

  @override
  String get nameOptional => 'שם (לא חובה)';

  @override
  String get toppedUp => 'ההתראות נקבעות ל־7 הימים הקרובים ומתחדשות בכל פעם שפותחים את Quando?.';

  @override
  String get back => 'חזרה';

  @override
  String get next => 'הבא';

  @override
  String get stepWhichEvents => 'אילו אירועים';

  @override
  String get stepWhenToRing => 'מתי לצלצל';

  @override
  String get stepHowItRings => 'איך מצלצל';

  @override
  String defaultNamed(String name) {
    return 'ברירת מחדל ($name)';
  }

  @override
  String get phoneAlarmSound => 'צליל ההתראה של הטלפון';

  @override
  String get onlineRadio => 'רדיו מקוון';

  @override
  String songLinkOpens(String app) {
    return 'קישור לשיר · נפתח ב־$app';
  }

  @override
  String get builtIn => 'מובנה';

  @override
  String get yourRecording => 'ההקלטה שלך';

  @override
  String get sound => 'צליל';

  @override
  String get wakeToOwnSound => 'להתעורר לצליל שלך';

  @override
  String get wakeToOwnSoundHint => 'הקול שלך, שיר, Spotify או רדיו חי';

  @override
  String musicAdded(String name) {
    return '$name נוסף. בחרו בו כצליל לכל התראה.';
  }

  @override
  String get playlists => 'פלייליסטים';

  @override
  String get likedSongs => 'שירים שאהבתם';

  @override
  String get noPlaylists => 'עדיין אין פלייליסטים.';

  @override
  String get noLikedSongs => 'עדיין אין שירים שאהבתם.';

  @override
  String get needsMic => 'Quando? צריך את המיקרופון כדי להקליט.';

  @override
  String recordingN(int n) {
    return 'הקלטה $n';
  }

  @override
  String couldNotAddFile(String error) {
    return 'לא ניתן להוסיף את הקובץ: $error';
  }

  @override
  String get addSongLink => 'הוספת קישור לשיר';

  @override
  String get songLink => 'קישור לשיר';

  @override
  String get songLinkHowTo =>
      'ב־Spotify, Apple Music, YouTube, YouTube Music או SoundCloud, הקישו על שיתוף, אחר כך על העתקת קישור, והדביקו כאן.';

  @override
  String get songNameHint => 'שם, למשל פלייליסט של בוקר';

  @override
  String get whenAlarmGoesOffHeading => 'כשההתראה מצלצלת';

  @override
  String get playTheSong => 'לנגן את השיר';

  @override
  String get ringThenOpen => 'לצלצל ואז לפתוח';

  @override
  String get playTheSongHint =>
      'האפליקציה שלו נפתחת ומנגנת אותו. אם יש שקט 10 שניות, צליל הגיבוי מצלצל במקום, כדי שתמיד תתעוררו. התראות עם משימה מצלצלות ואז פותחות אותו.';

  @override
  String get ringThenOpenHint => 'צליל הגיבוי מצלצל. עצירה פותחת את השיר באפליקציה שלו.';

  @override
  String get playForHeading => 'לנגן במשך';

  @override
  String get pausesAfter => 'Quando? משהה את השיר אחרי הזמן הזה, בעזרת כפתור ההשהיה של הטלפון.';

  @override
  String get backupSoundHeading => 'צליל גיבוי';

  @override
  String get notALink => 'זה לא נראה כמו קישור.';

  @override
  String songOn(String app) {
    return 'שיר ב־$app';
  }

  @override
  String get theWeb => 'האינטרנט';

  @override
  String get pickFromYouTube => 'בחירה מ־YouTube שלי';

  @override
  String get youTubeAndMusic => 'YouTube ו־YouTube Music';

  @override
  String get youTubeOn => 'מחובר · לחיצה ארוכה להתנתקות';

  @override
  String get youTubeSignIn => 'התחברות עם Google';

  @override
  String get addSongLinkInstead => 'הוסיפו קישור לשיר במקום.';

  @override
  String get googleSignInFailed => 'ההתחברות ל־Google לא הסתיימה. נסו שוב.';

  @override
  String get myYouTube => 'ה־YouTube שלי';

  @override
  String get spotifyDirectOn => 'ניגון ישיר מ־Spotify פעיל';

  @override
  String get spotifyDirect => 'ניגון ישיר מ־Spotify';

  @override
  String get spotifyDirectOnHint => 'פעיל · הקישו לכיבוי';

  @override
  String get spotifyDirectHint => 'מנגן את השיר המדויק. דורש Premium.';

  @override
  String get spotifyComingSoon => 'בקרוב · דורש Premium';

  @override
  String get spotifyFailed =>
      'Spotify לא התחבר. ודאו שאפליקציית Spotify מותקנת, שאתם מחוברים ושיש לכם Premium.';

  @override
  String get nameThisSound => 'תנו שם לצליל';

  @override
  String get sounds => 'צלילים';

  @override
  String get soundsSentence => 'להתעורר לקול שלך, לשיר, לפלייליסט או לרדיו חי.';

  @override
  String stopTimer(String time) {
    return 'עצירה · $time';
  }

  @override
  String get record => 'הקלטה';

  @override
  String get addAFile => 'הוספת קובץ';

  @override
  String get addSongLinkLong => 'הוספת קישור לשיר (Spotify, Apple Music, YouTube…)';

  @override
  String get musicAppsHeading => 'אפליקציות מוזיקה';

  @override
  String get pickFromSpotify => 'בחירה מ־Spotify שלי';

  @override
  String get yourPlaylistsAndLiked => 'הפלייליסטים והשירים שאהבתם';

  @override
  String get mySpotify => 'ה־Spotify שלי';

  @override
  String get spotifySignInFailed => 'לא ניתן להתחבר ל־Spotify.';

  @override
  String get appleMusicNote => 'ההתחברות תגיע עם גרסת ה־iPhone. בינתיים, הוסיפו קישור לשיר.';

  @override
  String noSignInNote(String service) {
    return '$service לא מאפשר התחברות מאפליקציות אחרות. הוסיפו קישור לשיר במקום.';
  }

  @override
  String get wakeToRadio => 'להתעורר לרדיו מקוון';

  @override
  String get soundsExplain =>
      'הקליטו עד 5 דקות, הוסיפו קובץ, קישור לשיר או רדיו חי. צליל גיבוי מצלצל אם משהו נכשל.';

  @override
  String get yourSoundsHeading => 'הצלילים שלך';

  @override
  String playsIn(String app) {
    return 'מתנגן ב־$app';
  }

  @override
  String opensIn(String app) {
    return 'נפתח ב־$app';
  }

  @override
  String forSpan(String span) {
    return 'למשך $span';
  }

  @override
  String get defaultLabel => 'ברירת מחדל';

  @override
  String get radioUnreachable => 'אין גישה למדריך תחנות הרדיו. בדקו את החיבור.';

  @override
  String get addStreamAddress => 'הוספת כתובת שידור';

  @override
  String get notAStream => 'זה לא נראה ככתובת שידור (היא מתחילה ב־http).';

  @override
  String get anyGenre => 'כל סוגה';

  @override
  String get stationName => 'שם התחנה';

  @override
  String get closeSearch => 'סגירת החיפוש';

  @override
  String get searchByName => 'חיפוש לפי שם';

  @override
  String get anywhere => 'בכל מקום';

  @override
  String get noStations => 'לא נמצאו תחנות. נסו סוגה או מדינה אחרת.';

  @override
  String wakeUpTo(String name) {
    return 'להתעורר ל־$name';
  }

  @override
  String get notQuite => 'כמעט. נסו שוב.';

  @override
  String shabbatStopsItself(int n) {
    return 'מצב שבת: ייעצר מעצמו בעוד $n שניות. אין צורך לגעת בטלפון.';
  }

  @override
  String get solveToSnooze => 'פתרו לנודניק';

  @override
  String get solveToStop => 'פתרו כדי לעצור';

  @override
  String get answer => 'תשובה';

  @override
  String get snooze => 'נודניק';

  @override
  String get stop => 'עצירה';

  @override
  String get shakeToSnooze => 'נערו לנודניק';

  @override
  String get shakeToStop => 'נערו כדי לעצור';

  @override
  String get shakeHard => 'נערו את הטלפון חזק עד שהפס מתמלא.';

  @override
  String get cantShake => 'לא יכולים לנער? פתרו תרגיל';

  @override
  String get pairsToSnooze => 'מצאו את הזוגות לנודניק';

  @override
  String get pairsToStop => 'מצאו את הזוגות כדי לעצור';

  @override
  String get typeToSnooze => 'הקלידו את זה לנודניק';

  @override
  String get typeToStop => 'הקלידו את זה כדי לעצור';

  @override
  String get scanToSnooze => 'סרקו את הקוד לנודניק';

  @override
  String get scanToStop => 'סרקו את הקוד כדי לעצור';

  @override
  String ringAgainUnless(int n) {
    return 'אצלצל שוב בעוד $n דקות אם לא תקישו למטה.';
  }

  @override
  String get imUp => 'קמתי';

  @override
  String snoozeMin(int n) {
    return 'נודניק $n דק׳';
  }

  @override
  String snoozeMinLeft(int n, int left) {
    return 'נודניק $n דק׳ · נותרו $left';
  }

  @override
  String get noSnoozesLeft => 'לא נותרו נודניקים';

  @override
  String get stopThenOpen => 'עצירה · ואז פתיחה';

  @override
  String get startingSong => 'מפעילים את השיר שלך';

  @override
  String wayToStop(String way) {
    return '$way כדי לעצור';
  }

  @override
  String wayToSnooze(String way) {
    return '$way לנודניק';
  }

  @override
  String ringsForMore(int n) {
    return 'מצלצל עוד $n שניות';
  }

  @override
  String get leftToRing => 'נותרו לצלצול';

  @override
  String get wayVolumeButtons => 'כפתורי עוצמת הקול';

  @override
  String get wayShake => 'ניעור הטלפון';

  @override
  String get taskNothing => 'כלום';

  @override
  String get taskSum => 'פתרון תרגיל';

  @override
  String get taskShake => 'ניעור 30 פעמים';

  @override
  String get taskMemory => 'משחק זיכרון';

  @override
  String get taskPhrase => 'הקלדת משפט';

  @override
  String get taskScan => 'סריקת קוד';

  @override
  String get noLimit => 'בלי הגבלה';

  @override
  String upToTimes(int n) {
    return 'עד $n×';
  }

  @override
  String shorterEachTime(int n) {
    return 'קצר ב־$n דק׳ בכל פעם';
  }

  @override
  String autoSnoozeAfter(int n) {
    return 'נודניק אוטומטי אחרי $n דק׳';
  }

  @override
  String get card => 'קלף';

  @override
  String get hiddenCard => 'קלף הפוך';

  @override
  String get phrase1 => 'אני ער והיום שלי';

  @override
  String get phrase2 => 'אם לא עכשיו, אימתי';

  @override
  String get phrase3 => 'בוקר טוב לי ולכל מי שאני אוהב';

  @override
  String get phrase4 => 'הרגליים שלי על הרצפה ואני קם';

  @override
  String get phrase5 => 'היום אני מתחיל מחדש';

  @override
  String get notQuiteWords => 'כמעט, בדקו כל מילה.';

  @override
  String get typeItHere => 'הקלידו כאן';

  @override
  String get differentCode => 'זה קוד אחר.';

  @override
  String get cameraUnavailable => 'המצלמה לא זמינה.';

  @override
  String get cantScan => 'לא יכולים לסרוק? פתרו תרגיל';

  @override
  String get saveCodeToScan => 'שמירת קוד לסריקה';

  @override
  String get saveCodeHint =>
      'כוונו את המצלמה לברקוד או לקוד QR במקום שצריך ללכת אליו, כמו קופסה במטבח או משחת שיניים באמבטיה. כדי לעצור את ההתראה, תסרקו אותו שוב.';

  @override
  String get cameraUnavailableSettings => 'המצלמה לא זמינה. אפשרו גישה למצלמה בהגדרות.';

  @override
  String gentleToGo(int n) {
    return 'השכמה עדינה · עוד $n דק׳';
  }

  @override
  String previewBody(String body) {
    return 'ניסיון · $body';
  }

  @override
  String snoozedBody(String body) {
    return 'נודניק: $body';
  }

  @override
  String get areYouUp => 'קמתם?';

  @override
  String get tapImUp => 'הקישו „קמתי” כדי לעצור';

  @override
  String get volume => 'עוצמת קול';

  @override
  String get wakeCheckOn => 'בדיקת השכמה פעילה';

  @override
  String get stopsAtOnce => 'נעצר מיד';

  @override
  String get ringsAgainIfNotUp => 'מצלצל שוב אם לא קמתם';

  @override
  String get openAppAfter => 'פתיחת אפליקציה אחרי';

  @override
  String get noTask => 'ללא משימה';

  @override
  String get codeSaved => 'הקוד נשמר';

  @override
  String get tapToSaveDifferent => 'הקישו כדי לשמור קוד אחר';

  @override
  String get controlsHeading => 'פקדים';

  @override
  String get onScreen => 'על המסך';

  @override
  String get taskHeading => 'משימה';

  @override
  String get none => 'ללא';

  @override
  String get snoozeSentence => 'עוד חמש דקות? בחרו לכמה זמן, כמה פעמים ומה צריך לעשות.';

  @override
  String get settingsHeading => 'הגדרות';

  @override
  String get snoozeTime => 'זמן נודניק';

  @override
  String get snoozeTimeHint => 'כמה זמן נמשך הנודניק הראשון';

  @override
  String get shortenSnoozes => 'קיצור הנודניקים הבאים';

  @override
  String get shortenSnoozesHint => 'כל נודניק אחרי הראשון קצר בזמן הזה';

  @override
  String get autoSnooze => 'נודניק אוטומטי';

  @override
  String get autoSnoozeHint => 'אם לא נוגעים, נכנס לנודניק מעצמו אחרי';

  @override
  String get never => 'אף פעם';

  @override
  String get snoozeLimit => 'מגבלת נודניק';

  @override
  String get snoozeLimitHint => 'כמה פעמים אפשר לדחות';

  @override
  String get unlimited => 'ללא הגבלה';

  @override
  String get useSnoozeFromSettings => 'להשתמש בנודניק מההגדרות';

  @override
  String get stopSentence => 'איך מכבים את ההתראה ומה צריך לעשות קודם.';

  @override
  String get shabbatNoTask => 'בשבת ובחג ההתראות נעצרות מעצמן ולעולם לא מבקשות משימה.';

  @override
  String get volumeSentence => 'כמה חזק זה מצלצל, ובאיזו עדינות מגיע לשם.';

  @override
  String get openAfterAlarm => 'לפתוח אחרי ההתראה';

  @override
  String get pickAnApp => 'בחירת אפליקציה';

  @override
  String get orPasteLink => 'או הדביקו קישור: https://…';

  @override
  String get useThisLink => 'להשתמש בקישור הזה';

  @override
  String get noAppsFound => 'לא נמצאו אפליקציות.';

  @override
  String get weather => 'מזג אוויר';

  @override
  String get news => 'חדשות';

  @override
  String get usePhoneVolume => 'עוצמת ההתראה של הטלפון';

  @override
  String get setsPhoneVolume => 'קובע את עוצמת ההתראה של הטלפון בזמן הצלצול, ואחר כך מחזיר אותה.';

  @override
  String get fadeInOff => 'הגברה הדרגתית: כבוי, עוצמה מלאה מיד';

  @override
  String fadeInOver(String span) {
    return 'הגברה במשך $span';
  }

  @override
  String get fadeOutOff => 'החלשה הדרגתית: כבוי';

  @override
  String fadeOutOver(String span) {
    return 'החלשה ב־$span האחרונות';
  }

  @override
  String get fadesExplain =>
      'ההחלשה קורית כשההתראה נעצרת מעצמה. אם המעברים ארוכים מהצלצול, שניהם מתקצרים כדי להתאים.';

  @override
  String get soundSoftChime => 'פעמון עדין';

  @override
  String get soundMorningRise => 'בוקר עולה';

  @override
  String get soundClassicBeep => 'צפצוף קלאסי';

  @override
  String get calmCity => 'בוקר שקט בעיר';

  @override
  String get calmBirds => 'ציפורים עם שחר';

  @override
  String get calmWaves => 'גלים על החוף';

  @override
  String get calmRain => 'גשם עדין';

  @override
  String get calmStream => 'פלג ביער';

  @override
  String get calmWind => 'רוח עדינה';

  @override
  String get calmFire => 'אש מפצפצת';

  @override
  String get calmNight => 'ליל קיץ';

  @override
  String get publicDomain => 'נחלת הכלל';

  @override
  String get phoneVolume => 'עוצמת הטלפון';

  @override
  String fadesIn(String span) {
    return 'מתגבר ב־$span';
  }

  @override
  String fadesOut(String span) {
    return 'נחלש ב־$span';
  }

  @override
  String get noFade => 'ללא מעבר';

  @override
  String minSecShort(int m, int s) {
    return '$m דק׳ $s שנ׳';
  }

  @override
  String get happensRings => 'מצלצלת';

  @override
  String get happensStopped => 'עוצרים אותה';

  @override
  String get happensSnoozed => 'דוחים אותה';

  @override
  String get happensAutoStopped => 'נעצרת מעצמה';

  @override
  String get eventLower => 'אירוע';

  @override
  String get appTest => 'ניסיון Quando?';

  @override
  String get pushoverConnected => 'Pushover מחובר';

  @override
  String get webhookConnected => 'ה־webhook מחובר';

  @override
  String pushoverSaid(int code, String body) {
    return 'Pushover השיב $code: $body';
  }

  @override
  String couldNotReachPushover(String error) {
    return 'לא ניתן להגיע ל־Pushover ($error)';
  }

  @override
  String itAnswered(int code) {
    return 'התקבלה תשובה $code';
  }

  @override
  String couldNotReachIt(String error) {
    return 'לא ניתן להגיע ($error)';
  }

  @override
  String get calendarNotAllowed => 'הגישה ליומן לא אושרה.';

  @override
  String get playlist => 'פלייליסט';

  @override
  String songCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n שירים', one: 'שיר אחד');
    return '$_temp0';
  }

  @override
  String get spotifySaidNo =>
      'Spotify סירב. בלוח הבקרה של Spotify, סמנו Web API עבור Quando? והוסיפו את החשבון שלכם תחת User Management.';

  @override
  String serviceDidntAnswer(String service, int code) {
    return '$service לא ענה ($code).';
  }

  @override
  String get youTubeSaidNo => 'YouTube סירב. ודאו שחשבון Google שלכם הוא משתמש ניסיון בפרויקט Quando.';

  @override
  String get event => 'אירוע';

  @override
  String eventEnds(String title) {
    return '$title (סיום)';
  }

  @override
  String foundSoundsDevices(int s, int d) {
    return 'נמצאו $s צלילים ו־$d מכשירים.';
  }

  @override
  String get sentCheckDevices => 'נשלח. בדקו את המכשירים האחרים שלכם.';

  @override
  String sentTo(String name) {
    return 'נשלח אל $name.';
  }

  @override
  String get zapierHowTo =>
      'ב־Zapier, צרו Zap שמתחיל ב־„Webhooks by Zapier → Catch Hook”, ואז הדביקו כאן את הכתובת שלו.';

  @override
  String get catchHookUrl => 'כתובת Catch Hook';

  @override
  String get iftttHowTo =>
      'ב־IFTTT, צרו applet שמתחיל ב־„Webhooks → Receive a web request with a JSON payload”. השתמשו כאן באותו שם אירוע. המפתח שלכם נמצא ב־ifttt.com/maker_webhooks/settings.';

  @override
  String get eventName => 'שם האירוע';

  @override
  String get webhooksKey => 'מפתח Webhooks';

  @override
  String get webhookHowTo => 'Quando? שולח JSON POST לכתובת הזו.';

  @override
  String get connectionsSentence => 'עדכנו אפליקציות ומכשירים אחרים כשהתראה מצלצלת, נעצרת או נדחית.';

  @override
  String get pushWhenRings => 'שליחת הודעה כשהתראה מצלצלת';

  @override
  String get pushWhenRingsHint => 'לטלפונים האחרים, לטאבלט, לשעון או למחשב';

  @override
  String get yourUserKey => 'מפתח המשתמש שלך';

  @override
  String get appToken => 'טוקן האפליקציה';

  @override
  String get soundAndDevicesHeading => 'צליל ומכשירים';

  @override
  String get loading => 'טוען…';

  @override
  String get loadFromPushover => 'טעינה מ־Pushover';

  @override
  String get soundItPlays => 'הצליל שמתנגן';

  @override
  String get myPushoverDefault => 'ברירת המחדל שלי ב־Pushover';

  @override
  String get pushoverOwnSounds => 'הצלילים שלכם מופיעים כאן אחרי שמעלים אותם ב־pushover.net/sounds.';

  @override
  String get allMyDevices => 'כל המכשירים שלי';

  @override
  String get pushoverOnThisPhone =>
      'התקינו את אפליקציית Pushover גם בטלפון הזה והוא יצלצל כאן עם צליל ה־Pushover שלכם.';

  @override
  String get priority => 'עדיפות';

  @override
  String get priorityNormal => 'רגילה';

  @override
  String get priorityHigh => 'גבוהה: גם בשעות שקט';

  @override
  String get priorityEmergency => 'חירום: חוזרת עד לאישור';

  @override
  String get sending => 'שולח…';

  @override
  String get sendATest => 'שליחת ניסיון';

  @override
  String get findUserKey => 'איפה מפתח המשתמש שלי';

  @override
  String get makeAppToken => 'יצירת טוקן לאפליקציה';

  @override
  String get webhooksHeading => 'ZAPIER, IFTTT ו־WEBHOOKS';

  @override
  String get webhooksExplain =>
      'הפעילו כל דבר כשהתראה מצלצלת או כשעוצרים אותה: להדליק אורות, לרשום מתי קמתם, לשלוח הודעה למישהו.';

  @override
  String get sendWhenAlarm => 'לשלוח כשההתראה:';

  @override
  String get pauseOnShabbat => 'השהיה בשבת ובחגים';

  @override
  String get pauseOnShabbatHint => 'שום דבר לא נשלח עבור התראות מהדלקת נרות ועד הבדלה';

  @override
  String get webhookPayloadNote =>
      'כל הודעה כוללת: event (ring, stopped, snoozed, auto_stopped), title, body, time, shabbat ו־snoozes. המפתחות נשארים בטלפון הזה.';

  @override
  String get today => 'היום';

  @override
  String get tomorrow => 'מחר';

  @override
  String get notAWebAddress => 'זה לא נראה ככתובת אינטרנט שמתחילה ב־https://';

  @override
  String get language => 'שפה';

  @override
  String get phoneLanguage => 'שפת הטלפון';

  @override
  String get ringQuote => 'וְאִם לֹא עַכְשָׁיו, אֵימָתַי?';

  @override
  String get ringQuoteBy => 'הלל';

  @override
  String get quotesTitle => 'ציטוטים על זמן';

  @override
  String get quotesHint => 'בחרו מאיפה הם יגיעו. אחד לכל חלק ביום; הקישו על הציטוט כדי לראות אחר.';

  @override
  String get quotesOff => 'כבוי';

  @override
  String get quoteSongs => 'שירים';

  @override
  String get quoteMovies => 'סרטים';

  @override
  String get quoteLiterature => 'ספרים ושירה';

  @override
  String get quoteTanakh => 'תנ״ך';

  @override
  String get quoteSages => 'תלמוד וחכמים';

  @override
  String get quoteSpeeches => 'נאומים מפורסמים';

  @override
  String get quotePhilosophy => 'פילוסופים';

  @override
  String get quoteProverbs => 'פתגמים ואמרות';

  @override
  String get quotesAlso => 'להציג גם';

  @override
  String get quoteCarnaval => 'קרנבל';

  @override
  String get quoteCarnavalHint => 'שירים ואמרות בזמן הקרנבל בברזיל';

  @override
  String get quoteNearMe => 'לידי';

  @override
  String get quoteNearMeHint => 'משוררים וימים מקומיים לפי אזור הזמן ועיר השבת שלך';

  @override
  String get quoteSiddur => 'סידור';

  @override
  String weeklyParasha(String name) {
    return 'פרשת השבוע: $name';
  }

  @override
  String poweredBy(String name) {
    return 'מבית $name';
  }

  @override
  String get syncTitle => 'סנכרון המכשירים שלי';

  @override
  String get syncHint => 'התחברו עם Google כדי לשמור על אותן התראות והגדרות בכל המכשירים.';

  @override
  String syncOn(String email) {
    return 'פעיל · $email';
  }

  @override
  String get syncWorking => 'מתחבר…';

  @override
  String get syncNotAllowed => 'החשבון הזה עדיין לא יכול לסנכרן. אם נכנסת עם אימייל, אשר אותו קודם.';

  @override
  String get syncFailed => 'החיבור נכשל. הקישו לנסות שוב.';

  @override
  String get syncStop => 'הפסקת סנכרון';

  @override
  String get syncNotSetUp => 'הסנכרון עוד לא מוגדר בגרסה זו.';

  @override
  String get ringTheseAfterAll => 'שיצלצלו בכל זאת';

  @override
  String skipTheseDay(int n) {
    return 'לדלג על $n אלה ביום הזה';
  }

  @override
  String turnOffNamed(String name) {
    return 'לכבות את “$name”';
  }

  @override
  String turnOnNamed(String name) {
    return 'להפעיל את “$name”';
  }

  @override
  String turnedOffNamed(String name) {
    return '“$name” כובה';
  }

  @override
  String removeTimeFrom(String time, String name) {
    return 'להסיר את “$time” מ“$name”';
  }

  @override
  String removedTimeFrom(String time, String name) {
    return '“$time” הוסר מ“$name”';
  }

  @override
  String get moveToGroup => 'להעביר לקבוצה';

  @override
  String inGroupMove(String group) {
    return 'ב“$group”, להעביר';
  }

  @override
  String movedToGroup(String group) {
    return 'הועבר ל“$group”';
  }

  @override
  String deleteNamed(String name) {
    return 'למחוק את “$name”';
  }

  @override
  String get signInWithGoogle => 'כניסה עם Google';

  @override
  String get signOut => 'יציאה';

  @override
  String get signInWithEmail => 'כניסה עם אימייל';

  @override
  String get signIn => 'כניסה';

  @override
  String get createAccount => 'יצירת חשבון';

  @override
  String get haveAccount => 'יש לי חשבון';

  @override
  String get forgotPassword => 'שכחתי סיסמה';

  @override
  String get email => 'אימייל';

  @override
  String get password => 'סיסמה';

  @override
  String get passwordResetSent => 'שלחנו לך קישור לבחירת סיסמה חדשה.';

  @override
  String emailCheckInbox(String email) {
    return 'שלחנו קישור אל $email. פתח אותו, חזור והקש “אישרתי”.';
  }

  @override
  String get emailConfirmed => 'אישרתי';

  @override
  String get emailNotYet => 'עדיין לא אושר. פתח קודם את הקישור באימייל.';

  @override
  String get emailSendAgain => 'לשלוח שוב את האימייל';

  @override
  String get emailSentAgain => 'נשלח. בדוק את תיבת הדואר והספאם.';

  @override
  String get emailInvalid => 'זו לא נראית כתובת אימייל.';

  @override
  String get emailWrong => 'אימייל או סיסמה שגויים.';

  @override
  String get emailInUse => 'כבר יש חשבון עם האימייל הזה. היכנס אליו, או השתמש ב-Google אם נוצר דרך Google.';

  @override
  String get passwordWeak => 'בחר סיסמה של 6 תווים לפחות.';

  @override
  String get emailNotSwitchedOn => 'הכניסה עם אימייל עדיין לא הופעלה.';

  @override
  String get tooManyTries => 'יותר מדי ניסיונות. המתן כמה דקות.';

  @override
  String get spotifyLibrary => 'Spotify';

  @override
  String get spotifyLibrarySignIn => 'פלייליסטים, שירים שאהבתם וחיפוש';

  @override
  String get spotifyLibraryOn => 'מחובר · לחיצה ארוכה להתנתקות';

  @override
  String spotifyLoginError(String reason) {
    return 'ההתחברות ל-Spotify לא הצליחה: $reason';
  }

  @override
  String googleSignInError(String reason) {
    return 'ההתחברות ל-Google לא הצליחה: $reason';
  }

  @override
  String get searchSongsHint => 'חיפוש שירים, אמנים, פלייליסטים';

  @override
  String nothingFound(String query) {
    return 'לא נמצא דבר עבור „$query”.';
  }

  @override
  String get deliveryTitle => 'אופן התראה';

  @override
  String get deliveryLocal => 'צליל מקומי';

  @override
  String get deliveryBoth => 'שניהם';

  @override
  String get deliveryConnect => 'חיבור ל־Pushover';

  @override
  String get deliveryLoadFailed => 'לא ניתן לטעון צלילים ומכשירים. נסו שוב.';

  @override
  String get deliveryBothHint => 'הצליל המקומי יושמע גם אם Pushover נכשל.';

  @override
  String get deliveryPushHint => 'Pushover בלבד. המכשיר חייב להיות מחובר בזמן ההתראה.';

  @override
  String get deliveryFallback => 'הצליל המקומי נשמר אם Pushover מנותק או מושהה.';

  @override
  String get deliveryReset => 'שימוש בהגדרות הקיימות';

  @override
  String get beforeShabbat => 'לפני שבת';

  @override
  String get preparationReminders => 'תזכורות להכנות';

  @override
  String get skipThisWeek => 'דלג השבוע';

  @override
  String get restoreThisWeek => 'שחזר השבוע';

  @override
  String get allAlarms => 'כל השעונים';

  @override
  String get timesAndSound => 'זמנים וצליל';

  @override
  String get changeCity => 'שינוי עיר';

  @override
  String get useMyLocation => 'המיקום שלי';

  @override
  String get locationUnavailable => 'המיקום אינו זמין כרגע. יש לנסות שוב או לבחור עיר.';

  @override
  String get locationReview => 'אישור מיקום';

  @override
  String get locationDeviceOnly =>
      'המיקום נשמר רק במכשיר זה. בדוק את אזור הזמן ואת הגדרת ישראל לפני השימוש בזמנים.';

  @override
  String timesIn(String city, String zone) {
    return '$city · $zone · זמן מקומי בעיר';
  }

  @override
  String get preparationOff => 'תזכורות ההכנה כבויות. הבדלה ושעונים רגילים לא השתנו.';

  @override
  String get preparationSkipped => 'תזכורות ההכנה דולגו השבוע. ההגדרות השבועיות נשמרו.';

  @override
  String get shabbatControls => 'הגדרות שבת';

  @override
  String get duringAfterShabbat => 'במהלך שבת / אחרי שבת';

  @override
  String locationCoordinates(String latitude, String longitude) {
    return 'קו רוחב $latitude · קו אורך $longitude';
  }

  @override
  String get currentLocation => 'מיקום נוכחי';

  @override
  String get testPushoverSound => 'בדיקת צליל ב־Pushover';

  @override
  String get pushoverSoundTestHint => 'משמיע את הצליל שנבחר במכשירי Pushover שנבחרו. הגדרות השקט עדיין חלות.';

  @override
  String get pushoverShareDevices => 'שיתוף פרטי חיבור עם המכשירים שלי';

  @override
  String get pushoverShareHint =>
      'מפתח המשתמש ואסימון האפליקציה של Pushover יכולים להסתנכרן דרך החשבון שלך ב־Quando? וב־Matai?.';

  @override
  String get pushoverShareQueued => 'פרטי החיבור ממתינים לסנכרון עם המכשירים המחוברים שלך.';

  @override
  String get pushoverShareSignIn => 'יש להתחבר לאותו חשבון אפליקציה בכל מכשיר לשיתוף פרטי Pushover.';

  @override
  String get smartHomeHeading => 'Smart home';

  @override
  String get smartHomeHint =>
      'Run Tuya scenes directly, or connect your own Home Assistant or Node-RED automations.';

  @override
  String get shareServices => 'Share service connections';

  @override
  String get shareServicesHint =>
      'Use the same app account on your devices to share Pushover, Tuya, Spotify library and automation connections. YouTube and device permissions may still need approval on each device.';

  @override
  String get tuyaSetupHint =>
      'Use your linked Tuya developer project. Enter its data center, Access ID, Access Secret and the UID shown under Link App Account. No Home Assistant needed.';

  @override
  String get tuyaDataCenter => 'Data center';

  @override
  String get tuyaUserId => 'Linked account UID';

  @override
  String get tuyaAccessId => 'Access ID / Client ID';

  @override
  String get tuyaAccessSecret => 'Access Secret / Client Secret';

  @override
  String get tuyaLoadScenes => 'Load scenes';

  @override
  String get tuyaNoScenes =>
      'No available Tap-to-Run scenes found. Check the linked account, data center and scene API permissions.';

  @override
  String get tuyaRunNow => 'Run scene now';

  @override
  String get tuyaRunConfirm => 'Run this scene on your Tuya devices now?';

  @override
  String get tuyaSent => 'Tuya accepted the scene command. Check your devices.';

  @override
  String get tuyaFailed =>
      'Tuya could not complete the request. Check project permissions, data center and subscription. Error:';

  @override
  String get tuyaAlarmScene => 'Tuya scene when this alarm rings';

  @override
  String get homeAssistantHowTo =>
      'Create a Home Assistant automation with a Webhook trigger accepting POST and JSON. Paste its URL here. Use the alarm event (ring, stopped, snoozed or auto_stopped) to choose your actions. New devices receive this connection switched off.';

  @override
  String get nodeRedHowTo =>
      'Use a Node-RED HTTP In node accepting POST, followed by your automation and an HTTP Response node. Paste the endpoint here. Local HTTP hubs and HTTPS endpoints are supported.';

  @override
  String get smartHomeConnect => 'Connect a smart-home service';

  @override
  String get automationTestHint => 'Testing runs the connected automation immediately.';

  @override
  String get smartHomeDeviceOn => 'Run smart-home alarm actions on this device';

  @override
  String get smartHomeDeviceHint =>
      'Choose one device to run your automations. Connections are shared; this switch stays on this device.';

  @override
  String get smartHomeDeviceOff =>
      'Alarm actions are off on this device. Enable them in Connections; manual scene tests still work.';

  @override
  String get homeDisplay => 'Home display';

  @override
  String get skyDay => 'Day';

  @override
  String get skyDayNight => 'Day + night';

  @override
  String get showMoonPhase => 'Moon phase';

  @override
  String get weatherLabel => 'Weather';

  @override
  String get skyLabel => 'Sky';

  @override
  String get weatherSwipeHint => 'Swipe between sky and weather';

  @override
  String get parashaHeading => 'Weekly parashah';

  @override
  String get dailyStudyHeading => 'Daily learning';

  @override
  String get courseDaf => 'Daf Yomi';

  @override
  String get courseRambam1 => 'Rambam · 1 chapter/day';

  @override
  String get courseRambam3 => 'Rambam · 3 chapters/day';

  @override
  String get courseMitzvot => 'Sefer HaMitzvot';

  @override
  String get courseMishnah => 'Mishnah Yomit';

  @override
  String get courseNach => 'Nach Yomi';

  @override
  String get moonriseLabel => 'Moonrise';

  @override
  String get moonsetLabel => 'Moonset';

  @override
  String get nightfallLabel => 'Nightfall';

  @override
  String get moonAlwaysUp => 'Moon above horizon all day';

  @override
  String get moonAlwaysDown => 'Moon below horizon all day';

  @override
  String get noRiseToday => 'No rise today';

  @override
  String get noSetToday => 'No set today';

  @override
  String get moonNew => 'New moon';

  @override
  String get moonWaxingCrescent => 'Waxing crescent';

  @override
  String get moonFirstQuarter => 'First quarter';

  @override
  String get moonWaxingGibbous => 'Waxing gibbous';

  @override
  String get moonFull => 'Full moon';

  @override
  String get moonWaningGibbous => 'Waning gibbous';

  @override
  String get moonLastQuarter => 'Last quarter';

  @override
  String get moonWaningCrescent => 'Waning crescent';

  @override
  String get moonIlluminated => 'illuminated';

  @override
  String get weatherClear => 'Clear';

  @override
  String get weatherClouds => 'Cloudy';

  @override
  String get weatherRain => 'Rain';

  @override
  String get weatherSnow => 'Snow / sleet';

  @override
  String get weatherFog => 'Fog';

  @override
  String get weatherThunder => 'Thunderstorms';

  @override
  String get weatherUnavailable => 'Weather is temporarily unavailable';

  @override
  String get weatherCached => 'Saved forecast';

  @override
  String get weatherUpdated => 'Updated';

  @override
  String get weatherForecast => 'Forecast';

  @override
  String get weatherThunderExpected => 'Thunderstorms forecast';

  @override
  String get learningUnavailable => 'Connect to load this month’s learning schedule';

  @override
  String get festivalReading => 'Festival Torah reading';

  @override
  String get learningCalendarSource => 'Learning calendar · Hebcal · CC BY 4.0';

  @override
  String get weatherSource => 'Forecast · MET Norway · CC BY 4.0';

  @override
  String get weatherConsent => 'Weather for your selected city. Uses rounded coordinates with MET Norway.';

  @override
  String get learningConsent =>
      'Rambam and other study schedules are loaded from Hebcal and saved for offline use.';

  @override
  String get homeRefresh => 'Refresh';

  @override
  String get skyTimezone => 'אזור הזמן שלי';

  @override
  String get skyShabbat => 'עיר לשבת';

  @override
  String get skyReferenceCity => 'עיר ייחוס לאזור הזמן';

  @override
  String get skyChooseCity => 'בחירת עיר לתצוגת השמיים';

  @override
  String get skyCityExplain =>
      'השמש והירח מחושבים לפי קואורדינטות העיר הזאת. העיר לשבת ואזור הזמן של ההתראות נשארים כפי שנבחרו.';

  @override
  String get skySun => 'השמש היום';

  @override
  String get skyMoon => 'הירח היום';

  @override
  String get moonAboveHorizon => 'הירח מעל האופק';

  @override
  String get moonBelowHorizon => 'הירח מתחת לאופק';

  @override
  String get moonNextNew => 'הירח החדש הבא';

  @override
  String get moonNextFull => 'הירח המלא הבא';

  @override
  String get locationServicesOff => 'שירותי המיקום כבויים. יש להפעיל אותם בהגדרות או לבחור עיר.';

  @override
  String get locationDenied => 'הגישה למיקום נדחתה. יש לאפשר אותה בהגדרות או לבחור עיר.';

  @override
  String get locationTimedOut =>
      'המיקום עדיין לא התקבל. ב־Mac יש להשאיר את ה־Wi-Fi פעיל ולנסות שוב, או לבחור עיר.';

  @override
  String get locationTimeZoneUnavailable =>
      'יש לבחור עיר באזור הזמן שנבחר, או לעקוב אחר אזור הזמן של המכשיר לפני השימוש במיקום.';

  @override
  String get locationSettings => 'פתיחת הגדרות המיקום';

  @override
  String get locationLooking => 'מקבל מיקום…';

  @override
  String get skyMoonDisplay => 'הצגת הירח: זריחה, שקיעה ומופע';

  @override
  String get tuyaConsumerPending =>
      'כניסה לחשבון עדיין אינה זמינה בגרסה זו. אם כבר יש לך פרויקט מפתח של Tuya, אפשר להשתמש בהגדרה מתקדמת.';

  @override
  String get tuyaAdvanced => 'הגדרה מתקדמת';

  @override
  String get tuyaSignInTitle => 'התחברות עם חשבון Smart Life';

  @override
  String get tuyaSignInHint =>
      'השתמשו באותה מדינה, אימייל או טלפון וסיסמה כמו באפליקציית Smart Life או Tuya Smart. החשבון חייב להיות מקושר כבר לפרויקט Tuya שלכם. הסיסמה נשלחת רק ל‑Tuya ולעולם לא נשמרת.';

  @override
  String get tuyaCountryCode => 'קידומת מדינה (ברזיל 55, ארה״ב 1)';

  @override
  String get tuyaAccount => 'אימייל או טלפון של Smart Life';

  @override
  String get tuyaPassword => 'סיסמת Smart Life';

  @override
  String get tuyaSignIn => 'התחברות וטעינת סצנות';

  @override
  String get tuyaRelayUrl => 'כתובת ממסר ה‑Tuya של Quando‏ (https)';

  @override
  String get tuyaRelayHint =>
      'השתמשו במדינה, באימייל או בטלפון ובסיסמה של חשבון Smart Life או Tuya Smart. הם נשלחים פעם אחת לממסר ה‑Tuya של Quando ואינם נשמרים. צריך להיות מחוברים לחשבון Quando.';

  @override
  String get tuyaGoogleHint =>
      'מתחברים ל‑Smart Life עם Google או Apple? ב‑Smart Life הקישו על ״שכחתי סיסמה״ כדי להגדיר סיסמה, והשתמשו בה כאן.';

  @override
  String get tuyaLinked => 'חשבון Smart Life מקושר';

  @override
  String get tuyaUnlink => 'ניתוק';

  @override
  String get tuyaNeedsAccount => 'קודם התחברו לחשבון Quando שלכם בהגדרות.';

  @override
  String get roshHodeshHeading => 'ראש חודש';

  @override
  String get roshHodeshExplain => 'הצגת ראש החודש הבא, יום אחד או יומיים, במסך הבית.';

  @override
  String get roshHodeshNext => 'ראש החודש הבא';

  @override
  String get roshHodeshBegins => 'מתחיל בשקיעה בתאריך';

  @override
  String get openParashaSefaria => 'קריאת פרשת השבוע בספריא';

  @override
  String get skyMyLocation => 'המיקום שלי';

  @override
  String get skyLocationLocalTimes =>
      'זמני השמיים מוצגים לפי אזור הזמן של המיקום הזה. אזור הזמן של השעון ועיר השבת אינם משתנים. נשמר במכשיר זה בלבד.';

  @override
  String get musicRingDurationHint => 'הנגינה נמשכת לפי משך הצלצול שהוגדר בהתראה, ונעצרת בעצירה או בנודניק.';

  @override
  String get musicBackupPlaying => 'לא ניתן להתחיל את המוזיקה. צליל ההתראה המקומי מתנגן.';

  @override
  String desktopMusicConnect(String service) {
    return 'חיבור האפליקציה $service';
  }

  @override
  String desktopMusicOn(String service) {
    return 'מחובר ל-$service · לחיצה ארוכה לניתוק';
  }

  @override
  String get musicSongs => 'שירים';

  @override
  String get noMusicSongs => 'לא נמצאו שירים בספריית Music.';

  @override
  String serviceConnectUnavailable(String service) {
    return 'הוסיפו קישור של $service · נפתח אחרי ההתראה';
  }

  @override
  String get soundCloudWidgetNote => 'הוסיפו קישור ציבורי';

  @override
  String get youtubePlayerHint =>
      'YouTube מציג וידאו בנגן גלוי. אם הנגן מוסתר או לא יכול לנגן, ההתראה המקומית ממשיכה.';

  @override
  String get musicPreviewFailed => 'לא ניתן לנגן את הצליל. בדקו את החיבור או נסו שיר או תחנה אחרים.';

  @override
  String get skyMoonPhase => 'מופע הירח';

  @override
  String get skyMoonDetailsDisplay => 'הוספת עמוד מופע הירח';

  @override
  String get skyMoonDetailsHint => 'החליקו אליו, או הקישו על כרטיס הירח בכל עת';

  @override
  String get moonRises => 'זורח';

  @override
  String get moonSets => 'שוקע';

  @override
  String moonLunarDay(int day) {
    return 'יום $day מתוך 29.5 בחודש הירחי';
  }

  @override
  String get moonDetailsOpen => 'פתיחת מופע הירח';

  @override
  String get musicPlaylists => 'פלייליסטים של מוזיקה';

  @override
  String get videoPlaylists => 'פלייליסטים של סרטונים';

  @override
  String get likedVideos => 'סרטונים שאהבתם';

  @override
  String get wholePlaylist => 'להתעורר לכל הפלייליסט';

  @override
  String get noSongsInPlaylist => 'אין כאן שירים שאפשר לנגן.';

  @override
  String get hebrewNamesHeading => 'כתיב שמות הפרשה והחודשים';

  @override
  String get hebrewNamesIsraeli => 'ישראלי';

  @override
  String get hebrewNamesAshkenazi => 'אשכנזי';

  @override
  String pickFromService(String service) {
    return 'בחירה מ־$service שלי';
  }

  @override
  String get weatherTonight => 'הלילה';

  @override
  String get weatherTomorrowMorning => 'מחר בבוקר';

  @override
  String weatherUntilAbout(String time) {
    return 'עד בערך $time';
  }

  @override
  String get weatherSunBehindClouds => 'השמש מאחורי העננים';

  @override
  String get keysLockTitle => 'מפתחות במכשירים שלך';

  @override
  String get keysLockOff =>
      'מפתחות השירותים שלך נשארים במכשיר הזה. בחר סיסמת סנכרון כדי לשלוח אותם, מוצפנים, למכשירים האחרים שלך.';

  @override
  String get keysLockOn =>
      'מפתחות השירותים שלך מוצפנים בסיסמת הסנכרון לפני שהם יוצאים מהמכשיר. אף אחד אחר, אפילו לא Google, לא יכול לקרוא אותם.';

  @override
  String get keysLockWaiting =>
      'הגיעו לכאן מפתחות מהמכשיר האחר שלך, נעולים. הקלד את סיסמת הסנכרון כדי לפתוח אותם.';

  @override
  String get keysSetPassphrase => 'בחירת סיסמה';

  @override
  String get keysChangePassphrase => 'החלפת סיסמה';

  @override
  String get keysUnlock => 'פתיחת המפתחות';

  @override
  String get keysStartOver => 'שכחת? להתחיל מחדש';

  @override
  String get keysStartOverHint =>
      'התחלה מחדש שולחת את המפתחות של המכשיר הזה עם סיסמה חדשה. המכשירים האחרים יבקשו את החדשה.';

  @override
  String get keysPassphrase => 'סיסמת סנכרון';

  @override
  String get keysPassphraseAgain => 'הקלד שוב';

  @override
  String keysPassphraseShort(int count) {
    return 'לפחות $count תווים.';
  }

  @override
  String get keysPassphraseMismatch => 'השתיים לא תואמות.';

  @override
  String get keysPassphraseWrong => 'הסיסמה הזו לא פותחת את המפתחות האלה.';

  @override
  String get keysPassphraseNote => 'רשום אותה: אם תשכח, אף אחד לא יוכל לשחזר אותה, ותקליד את המפתחות שוב.';

  @override
  String get keysShareNeedsPassphrase => 'קודם בחר סיסמת סנכרון, תחת מפתחות במכשירים שלך.';

  @override
  String get settingsAlarmDefaults => 'Alarm defaults';

  @override
  String get settingsPlacesTime => 'Places & time';

  @override
  String get settingsLook => 'Look, language & quotes';

  @override
  String get settingsAbout => 'About';

  @override
  String get defaultForNewAlarms => 'Default for new alarms';

  @override
  String get preview => 'Preview';

  @override
  String atClock(String time) {
    return 'at $time';
  }

  @override
  String get connectACalendar => 'Connect a calendar';

  @override
  String get newFromReadyMade => 'From a ready-made';

  @override
  String get newFromReadyMadeHint => 'Sunrise, sunset and other alarms that are already set up for you';

  @override
  String get calendarSourcesIntro =>
      'Quando? יכול לצלצל לפני אירועים ביומנים שלך ואחריהם. בחר מאיפה הם מגיעים.';

  @override
  String get deviceCalendarsHeading => 'במכשיר הזה';

  @override
  String get deviceCalendarsTitle => 'אפליקציית היומן של המכשיר';

  @override
  String get deviceCalendarsHint =>
      'כל החשבונות בו: Google, Samsung, Outlook, iCloud ויומנים שנשמרים רק כאן.';

  @override
  String get googleCalendarHeading => 'יומן Google';

  @override
  String get googleCalendarSignIn =>
      'התחבר עם Google כדי לקרוא את היומנים ישירות מ-Google, גם כשחשבון Google שלך לא נמצא במכשיר.';

  @override
  String googleCalendarSignedIn(String email) {
    return 'מחובר בתור $email';
  }

  @override
  String get googleCalendarSignOut => 'התנתק';

  @override
  String get googleCalendarNotHere =>
      'התחברות עם Google עדיין לא זמינה במכשיר הזה. הוסף את חשבון Google בהגדרות המכשיר (לוח שנה › חשבונות) והיומנים שלו יופיעו תחת המכשיר.';

  @override
  String get googleCalendarUnreachable =>
      'לא ניתן להגיע ליומן Google כרגע. התראות שכבר נקבעו ממנו עדיין יצלצלו.';

  @override
  String get googleCalendarTwiceHint =>
      'יומנים שהמכשיר כבר מציג מאותו חשבון Google מתחילים כבויים, כדי ששום דבר לא יצלצל פעמיים.';

  @override
  String get timersTitle => 'טיימרים';

  @override
  String get timerStopwatch => 'סטופר';

  @override
  String get timerCountdown => 'טיימר';

  @override
  String get timerSequence => 'היכון';

  @override
  String get timerStopwatchSub => 'סופר למעלה, עם הקפות';

  @override
  String get timerCountdownSub => 'סופר לאחור, מצלצל באפס';

  @override
  String get timerSequenceSub => 'זינוק וסימונים בקול';

  @override
  String get timerStart => 'התחל';

  @override
  String get timerPause => 'השהה';

  @override
  String get timerResume => 'המשך';

  @override
  String get timerReset => 'אפס';

  @override
  String get timerLap => 'הקפה';

  @override
  String get timerTimesUp => 'הזמן נגמר';

  @override
  String get timerSetTime => 'קבע את הזמן';

  @override
  String get timerMinutes => 'דקות';

  @override
  String get timerSeconds => 'שניות';

  @override
  String get seqOnYourMarks => 'על סימניכם';

  @override
  String get seqGetSet => 'היכון';

  @override
  String get seqGo => 'צא!';

  @override
  String get seqFinish => 'זמן!';

  @override
  String get seqReady => 'מוכן';

  @override
  String get seqSettings => 'הגדרות';

  @override
  String get seqStartCalls => 'הכרזות לפני הזינוק';

  @override
  String get seqStartCallsHelp => 'נאמרות בקול לפני \"צא\", בספירה לאחור מרגע הזינוק.';

  @override
  String seqCallBefore(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n שניות לפני',
      one: 'שנייה אחת לפני',
    );
    return '$_temp0';
  }

  @override
  String get seqAddCall => 'הוסף הכרזה';

  @override
  String get seqCallText => 'מה לומר';

  @override
  String get seqGoText => 'בזינוק, אמור';

  @override
  String get seqFinishText => 'בסוף, אמור';

  @override
  String get seqLength => 'משך';

  @override
  String get seqNoLimit => 'ללא הגבלה';

  @override
  String get seqSayEvery => 'הכרז על הזמן כל';

  @override
  String get seqOff => 'כבוי';

  @override
  String seqEverySeconds(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n שניות', one: 'שנייה אחת');
    return '$_temp0';
  }

  @override
  String seqEveryMinutes(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n דקות', one: 'דקה אחת');
    return '$_temp0';
  }

  @override
  String get seqFinalCount => 'ספור לאחור את האחרונות';

  @override
  String get seqMarks => 'הסימונים שלך';

  @override
  String get seqAddMark => 'הוסף סימון';

  @override
  String seqMarkAt(String time) {
    return 'ב-$time';
  }

  @override
  String get seqSpeak => 'דבר בקול';

  @override
  String get seqBeeps => 'צפצופים ורטט';

  @override
  String get seqSayRemaining => 'אמור את הזמן שנותר, לא את הזמן שעבר';

  @override
  String get seqPresets => 'הגדרות מוכנות';

  @override
  String get seqPresetRace => 'זינוק מירוץ';

  @override
  String get seqPresetSprint => 'מאמץ של 30 שניות';

  @override
  String get seqPresetRound => 'סבב של דקה';

  @override
  String get seqHintNoLimit => 'אחרי \"צא\" הוא סופר למעלה עד שתעצור אותו.';

  @override
  String get seqHintLength => 'אחרי \"צא\" הוא סופר לאחור עד אפס.';

  @override
  String get seqWords => 'מילים';

  @override
  String get homeReset => 'איפוס פריסה';

  @override
  String get homeSize => 'גודל';

  @override
  String get homeBlockClock => 'CLOCK';

  @override
  String get homeBlockSky => 'SUN, MOON AND WEATHER';

  @override
  String get homeBlockQuick => 'QUICK ALARMS';

  @override
  String get homeBlockShabbat => 'SHABBAT AND HOLIDAYS';

  @override
  String get homePlaceTitle => 'City for the sky';

  @override
  String nextAlarmLine(String title, String time) {
    return 'Next alarm · $title $time';
  }

  @override
  String get showAllAlarms => 'Show all days';

  @override
  String get noAlarmsThatDay => 'Nothing rings this day';

  @override
  String get homeSizeSmall => 'קטן';

  @override
  String get homeSizeMedium => 'בינוני';

  @override
  String get homeSizeLarge => 'גדול';

  @override
  String get homeHide => 'הסתר';

  @override
  String homeHiddenCards(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count כרטיסים מוסתרים',
      one: 'כרטיס מוסתר אחד',
    );
    return '$_temp0';
  }

  @override
  String get homeLayoutHint =>
      'לחצו לחיצה ארוכה על כרטיס כדי להזיז אותו. גררו את הקצה התחתון (או הצדדי ב-iPad וב-Mac) כדי לשנות גודל.';

  @override
  String get homeLayoutHintDismiss => 'הבנתי';

  @override
  String get homeLayoutTitle => 'מסך הבית';

  @override
  String get homeResetSubtitle => 'מחזיר את הכרטיסים לסדר ולגדלים המוגדרים כברירת מחדל';

  @override
  String get homeLayoutResetDone => 'הפריסה אופסה';
}
