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
  String get calendarIntro =>
      'Quando? יכול לצלצל לפני ואחרי אירועים ביומנים שבטלפון. יומן Google נכלל ברגע שחשבון Google שלכם מחובר לטלפון.';

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
      'ב־Spotify, Apple Music, Amazon Music, YouTube, YouTube Music או SoundCloud, הקישו על שיתוף, אחר כך על העתקת קישור, והדביקו כאן.';

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
  String get youTubeOn => 'הפלייליסטים והשירים שאהבתם. לחיצה ארוכה ליציאה.';

  @override
  String get youTubeSignIn => 'התחברו עם Google כדי לבחור מהפלייליסטים ומהשירים שאהבתם.';

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
  String get spotifyDirectOnHint => 'Spotify מנגן בדיוק את השיר שלכם כהתראה. הקישו לכיבוי.';

  @override
  String get spotifyDirectHint =>
      'מנגן בדיוק את השיר שלכם מ־Spotify כהתראה, באמינות גבוהה יותר. נדרשים אפליקציית Spotify ו־Spotify Premium. הקישו להתחברות.';

  @override
  String get spotifyComingSoon => 'בקרוב: ניגון בדיוק של השיר שלכם מ־Spotify כהתראה (נדרש Spotify Premium).';

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
      'הקליטו את הקול שלכם, שיר או כל דבר אחר, עד 5 דקות. הוסיפו MP3, M4A או WAV מהטלפון. קשרו שיר או פלייליסט: האפליקציה שלו מנגנת אותו כהתראה, עם צליל גיבוי. או בחרו תחנת רדיו: היא מתנגנת בשידור חי, ואם אין חיבור, מצלצל צליל ההתראה של הטלפון.';

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
    return 'פרשת $name';
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
  String get syncNotAllowed => 'חשבון Google זה לא יכול לסנכרן.';

  @override
  String get syncFailed => 'החיבור נכשל. הקישו לנסות שוב.';

  @override
  String get syncStop => 'הפסקת סנכרון';

  @override
  String get syncNotSetUp => 'הסנכרון עוד לא מוגדר בגרסה זו.';
}
