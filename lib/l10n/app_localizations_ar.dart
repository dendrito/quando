// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get undo => 'تراجع';

  @override
  String duplicatedNamed(String name) {
    return 'تم نسخ “$name”';
  }

  @override
  String deletedNamed(String name) {
    return 'تم حذف “$name”';
  }

  @override
  String get when => 'متى؟';

  @override
  String get newAtTime => 'في وقت محدد';

  @override
  String get newAtTimeHint => 'كل يوم عمل الساعة 7:00، مرة واحدة الساعة 15:30…';

  @override
  String get newAroundEvent => 'حول حدث';

  @override
  String get newAroundEventHint => 'ابحث في التقويمات وأوقات السبت والشمس، ثم رنّ قبله أو عنده أو بعده';

  @override
  String get editThisAlarm => 'تعديل هذا المنبه';

  @override
  String editNamed(String name) {
    return 'تعديل “$name”';
  }

  @override
  String get preset => 'قالب';

  @override
  String get editThisCalendarRule => 'تعديل قاعدة التقويم هذه';

  @override
  String get ringThisOneAfterAll => 'رنّ هذا على أي حال';

  @override
  String get skipJustThisOne => 'تخطَّ هذا فقط';

  @override
  String get renameGroup => 'إعادة تسمية المجموعة';

  @override
  String quickSet(String label, String time) {
    return '$label · يرنّ الساعة $time';
  }

  @override
  String get newAlarm => 'منبه جديد';

  @override
  String get appName => 'Quando?';

  @override
  String get lockMode => 'وضع القفل';

  @override
  String get calendars => 'التقويمات';

  @override
  String get settings => 'الإعدادات';

  @override
  String get nextAlarmHeading => 'المنبه التالي';

  @override
  String get nothingSet => 'لا شيء مضبوط';

  @override
  String get tagline => 'كلّ شيء في أوانه.';

  @override
  String sunriseAt(String time) {
    return 'الشروق $time';
  }

  @override
  String sunsetAt(String time) {
    return 'الغروب $time';
  }

  @override
  String get alarmsMayNotRing => 'قد لا ترنّ منبهاتك';

  @override
  String get tapToFixIt => 'انقر لإصلاحه';

  @override
  String inMinutes(int minutes) {
    return 'بعد $minutes د';
  }

  @override
  String get atSunset => 'عند الغروب';

  @override
  String get sunset => 'الغروب';

  @override
  String get shabbatModeIsOn => 'وضع السبت مفعّل';

  @override
  String nextInCity(String city) {
    return 'التالي · $city';
  }

  @override
  String get candleLighting => 'إشعال الشموع';

  @override
  String get havdalah => 'الهفدالا';

  @override
  String get shabbatAndFestivals => 'السبت والأعياد';

  @override
  String get yourAlarmsHeading => 'منبهاتك';

  @override
  String get tapWhenToAdd => 'انقر على «متى؟» لإضافة منبه.';

  @override
  String get aroundEventsHeading => 'حول الأحداث';

  @override
  String searchFor(String words) {
    return 'بحث: $words';
  }

  @override
  String get thisWeekHeading => 'منبهات هذا الأسبوع';

  @override
  String get noAlarmsThisWeek => 'لا منبهات في الأيام السبعة القادمة.';

  @override
  String get alarmsSetThemselves => 'تُضبط المنبهات تلقائيًا على هذا الهاتف كلما غيّرت شيئًا.';

  @override
  String cityTime(String city) {
    return 'توقيت $city';
  }

  @override
  String get more => 'المزيد';

  @override
  String get turnOff => 'إيقاف';

  @override
  String get turnOn => 'تشغيل';

  @override
  String get duplicate => 'نسخ';

  @override
  String get delete => 'حذف';

  @override
  String get inOneHour => 'بعد ساعة';

  @override
  String get logoLabel => 'شعار Quando?';

  @override
  String get noTimesSet => 'لا أوقات مضبوطة';

  @override
  String get atTheMoment => 'في اللحظة نفسها';

  @override
  String timesRange(int count, String from, String to) {
    return '$count مرات · من $from إلى $to';
  }

  @override
  String spanDays(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n يوم',
      many: '$n يومًا',
      few: '$n أيام',
      two: 'يومان',
      one: 'يوم واحد',
    );
    return '$_temp0';
  }

  @override
  String spanHours(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n ساعة',
      many: '$n ساعة',
      few: '$n ساعات',
      two: 'ساعتان',
      one: 'ساعة واحدة',
    );
    return '$_temp0';
  }

  @override
  String spanMinutes(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n دقيقة',
      many: '$n دقيقة',
      few: '$n دقائق',
      two: 'دقيقتان',
      one: 'دقيقة واحدة',
    );
    return '$_temp0';
  }

  @override
  String spanSeconds(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n ثانية',
      many: '$n ثانية',
      few: '$n ثوانٍ',
      two: 'ثانيتان',
      one: 'ثانية واحدة',
    );
    return '$_temp0';
  }

  @override
  String get now => 'الآن';

  @override
  String spanBefore(String span) {
    return 'قبل $span';
  }

  @override
  String spanAfter(String span) {
    return 'بعد $span';
  }

  @override
  String alarmCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n منبه',
      many: '$n منبهًا',
      few: '$n منبهات',
      two: 'منبهان',
      one: 'منبه واحد',
    );
    return '$_temp0';
  }

  @override
  String get allOn => 'كلها مفعّلة';

  @override
  String get allOff => 'كلها متوقفة';

  @override
  String someOn(int n) {
    return '$n مفعّلة';
  }

  @override
  String skippedBody(String body) {
    return 'تم التخطي · $body';
  }

  @override
  String timeToTime(String from, String to) {
    return '$from – $to';
  }

  @override
  String skippedCount(int n) {
    return '$n متخطاة';
  }

  @override
  String get sunNoRiseSet => 'الشمس لا تشرق ولا تغرب هنا اليوم';

  @override
  String sunProgress(int percent) {
    return 'قطعت الشمس $percent% من النهار';
  }

  @override
  String get sunIsDown => 'غربت الشمس';

  @override
  String get searchCity => 'ابحث عن مدينة';

  @override
  String get tomorrowLower => 'غدًا';

  @override
  String get yesterdayLower => 'أمس';

  @override
  String get worldClocksHeading => 'ساعات العالم';

  @override
  String get add => 'إضافة';

  @override
  String cityHere(String city) {
    return '$city · هنا';
  }

  @override
  String get worldClocksHint => 'أضف مدنًا لترى وقتها هنا. اسحب لليسار لإزالة مدينة.';

  @override
  String get groupNameHint => 'العمل، الأطفال، النادي…';

  @override
  String get cancel => 'إلغاء';

  @override
  String get ok => 'حسنًا';

  @override
  String get noGroup => 'بلا مجموعة';

  @override
  String get newGroupEllipsis => 'مجموعة جديدة…';

  @override
  String get newGroup => 'مجموعة جديدة';

  @override
  String secondsShort(int n) {
    return '$n ث';
  }

  @override
  String minutesShort(int n) {
    return '$n د';
  }

  @override
  String get minutes => 'دقائق';

  @override
  String get ringFor => 'مدة الرنين';

  @override
  String get seconds => 'ثوانٍ';

  @override
  String get oneSecondLess => 'ثانية أقل';

  @override
  String get oneSecondMore => 'ثانية أكثر';

  @override
  String inDays(int d) {
    return 'بعد $d ي';
  }

  @override
  String inDaysHours(int d, int h) {
    return 'بعد $d ي $h س';
  }

  @override
  String inHours(int h) {
    return 'بعد $h س';
  }

  @override
  String inHoursMinutes(int h, int m) {
    return 'بعد $h س $m د';
  }

  @override
  String inMins(int m) {
    return 'بعد $m د';
  }

  @override
  String placeChange(String city, String where) {
    return '$city · $where · تغيير';
  }

  @override
  String get israel => 'إسرائيل';

  @override
  String get outsideIsrael => 'خارج إسرائيل';

  @override
  String get comingUpHeading => 'قريبًا';

  @override
  String get lockForShabbat => 'اقفل الهاتف للسبت';

  @override
  String get lockForShabbatHint => 'من إشعال الشموع حتى الهفدالا، وفي الأعياد أيضًا';

  @override
  String get ownShabbatAlarmsHeading => 'منبهات السبت الخاصة بك';

  @override
  String get addShabbatAlarm => 'أضف منبهًا للسبت أو العيد';

  @override
  String get readyMadeHeading => 'منبهات جاهزة';

  @override
  String bringBackDeleted(int n) {
    return 'استعادة المحذوفة ($n)';
  }

  @override
  String get presetsHint => 'انقر على منبه لتغيير أوقاته. اسحب لحذفه.';

  @override
  String get lockSentence => 'اجعل الهاتف ساعة ومنبهات فقط، للسبت أو لليلة مركّزة.';

  @override
  String get lockExplain =>
      'أثناء القفل يعرض Quando? الوقت والمنبه التالي وموعد انتهاء القفل فقط. تبقى المنبهات تعمل ولا يمكن تغيير أي شيء حتى يُفتح.';

  @override
  String get lockNowHeading => 'اقفل الآن';

  @override
  String get lockAutoHeading => 'اقفل تلقائيًا';

  @override
  String get shabbatAndFestivalsLong => 'السبت والأعياد';

  @override
  String get fromCandleToHavdalah => 'من إشعال الشموع حتى الهفدالا';

  @override
  String get lockCalendarWord => 'أثناء أحداث التقويم التي تحتوي هذه الكلمة';

  @override
  String get lockCalendarWordHint => 'مثل قفل، امتحان، تركيز';

  @override
  String get leaveEmptyForNone => 'اتركه فارغًا لعدم التفعيل';

  @override
  String get connectCalendarsFirst => 'اربط التقويمات أولًا (أيقونة التقويم)';

  @override
  String get openWhenLockStarts => 'افتح Quando? عند بدء القفل';

  @override
  String get openWhenLockStartsHint => 'صوت هادئ لثانية واحدة يُظهر Quando? ليقفل';

  @override
  String get pinToScreen => 'ثبّت Quando? على الشاشة';

  @override
  String get pinToScreenHint =>
      'لا تُفتح التطبيقات الأخرى أثناء القفل. يطلب Android التأكيد في المرة الأولى.';

  @override
  String get noLocksComingUp => 'لا أقفال قادمة.';

  @override
  String get leaveLockEarly => 'للخروج مبكرًا، اضغط مطولًا على “اضغط مطولًا لفتح القفل” لمدة 3 ثوانٍ.';

  @override
  String get locked => 'مقفل';

  @override
  String get shabbatShalom => 'شبات شالوم';

  @override
  String get chagSameach => 'حاج سميّاح';

  @override
  String get unlocksHeading => 'يُفتح';

  @override
  String get nowCap => 'الآن';

  @override
  String get nextAlarm => 'المنبه التالي';

  @override
  String get holdToUnlock => 'اضغط مطولًا لفتح القفل';

  @override
  String get calendarAlarm => 'منبه التقويم';

  @override
  String get calendarIntro =>
      'يستطيع Quando? أن يرنّ قبل الأحداث وبعدها في تقويمات هاتفك. تقويم Google مشمول بمجرد وجود حساب Google على الهاتف.';

  @override
  String get connectCalendars => 'اربط التقويمات';

  @override
  String get calendarAlarmsHeading => 'منبهات التقويم';

  @override
  String get calendarNoneYet => 'لا شيء بعد. ابدأ بهذا ثم غيّره كما تشاء:';

  @override
  String get fifteenBeforeEvery => 'قبل كل حدث بـ15 دقيقة';

  @override
  String get useTheseCalendarsHeading => 'استخدم هذه التقويمات';

  @override
  String get noTimedEvents => 'لا أحداث قادمة بوقت محدد في هذه التقويمات.';

  @override
  String get atTheStart => 'عند البداية';

  @override
  String everyForBefore(String every, String span) {
    return 'كل $every لمدة $span قبله';
  }

  @override
  String spanAfterItEnds(String span) {
    return 'بعد انتهائه بـ$span';
  }

  @override
  String get noAlarmsChosen => 'لم يتم اختيار منبهات';

  @override
  String get gentleWakeUp => 'استيقاظ لطيف';

  @override
  String gentleSummary(int minutes, String sound) {
    return 'قبل $minutes د · $sound';
  }

  @override
  String get off => 'متوقف';

  @override
  String get gentleSentence => 'يبدأ صوت هادئ بلطف قبل منبهك، فلا تستيقظ فجأة أبدًا.';

  @override
  String get gentleExplain => 'يعلو ببطء، ويخرجك من النوم الخفيف، ويتوقف قبيل رنين المنبه.';

  @override
  String get startsBeforeHeading => 'يبدأ قبل المنبه';

  @override
  String get leadUpSoundHeading => 'صوت التمهيد';

  @override
  String get listen => 'استمع';

  @override
  String get whoRecordedThese => 'من سجّل هذه الأصوات';

  @override
  String get done => 'تم';

  @override
  String get soundCredits => 'حقوق الأصوات';

  @override
  String yourTimeCity(String city) {
    return 'وقتك ($city)';
  }

  @override
  String get anotherCity => 'مدينة أخرى…';

  @override
  String get ringingIn5 => 'يرنّ بعد 5 ثوانٍ…';

  @override
  String get alarmSaved => 'تم حفظ المنبه.';

  @override
  String alarmSetFor(String span) {
    return 'المنبه بعد $span.';
  }

  @override
  String hoursMinutesShort(int h, int m) {
    return '$h س $m د';
  }

  @override
  String get editAlarm => 'تعديل المنبه';

  @override
  String get previewCaps => 'معاينة';

  @override
  String get saveCaps => 'حفظ';

  @override
  String cityTimeForYou(String city, String time) {
    return 'توقيت $city · $time عندك';
  }

  @override
  String repeatHeading(String repeat) {
    return 'تكرار · $repeat';
  }

  @override
  String get labelField => 'التسمية (تُقرأ بصوت عالٍ إذا كانت المنبهات الناطقة مفعّلة)';

  @override
  String get group => 'المجموعة';

  @override
  String ringsForHeading(String span) {
    return 'يرنّ لمدة $span';
  }

  @override
  String useDefault(String value) {
    return 'استخدم الافتراضي ($value)';
  }

  @override
  String get save => 'حفظ';

  @override
  String get sameTime => 'نفس الوقت';

  @override
  String get untilYouStopIt => 'حتى توقفه';

  @override
  String get alarm => 'منبه';

  @override
  String get once => 'مرة واحدة';

  @override
  String get everyDay => 'كل يوم';

  @override
  String get weekdays => 'أيام العمل';

  @override
  String get weekends => 'عطلات نهاية الأسبوع';

  @override
  String timeInCity(String time, String city) {
    return '$time بتوقيت $city';
  }

  @override
  String eventsMatching(String words) {
    return 'أحداث تحتوي “$words”';
  }

  @override
  String get everyEvent => 'كل حدث';

  @override
  String get sunrise => 'الشروق';

  @override
  String havdalahEndOf(String day) {
    return 'الهفدالا · نهاية $day';
  }

  @override
  String get yomTov => 'يوم طوف';

  @override
  String get shabbat => 'السبت';

  @override
  String get presetCountdown => 'العد التنازلي لإشعال الشموع';

  @override
  String get presetHourly => 'كل ساعة، بدءًا من 6 ساعات قبله';

  @override
  String get presetDailyWeek => 'مرة يوميًا، في الأسبوع السابق';

  @override
  String get presetSecondNight => 'شموع الليلة الثانية';

  @override
  String get presetFridayReminder => 'تذكير قبل 3 ساعات: اشحن هاتفك';

  @override
  String get presetFridayReminderLabel => 'اشحن هاتفك واضبط منبهات الغد';

  @override
  String get presetSunset => 'الغروب، وقبله بـ15 دقيقة';

  @override
  String get pesach => 'عيد الفصح (بيسح)';

  @override
  String get shavuot => 'شفوعوت';

  @override
  String get roshHashanah => 'روش هشناه';

  @override
  String get yomKippur => 'يوم الغفران';

  @override
  String get sukkot => 'سوكوت';

  @override
  String get sheminiAtzeret => 'شميني عتسيرت';

  @override
  String get simchatTorah => 'سمحات توراه';

  @override
  String get readyNotifications => 'إظهار المنبهات';

  @override
  String get readyNotificationsWhy => 'يتيح ظهور شاشة المنبه وزر الإيقاف.';

  @override
  String get readyFullScreen => 'الرنين فوق شاشة القفل';

  @override
  String get readyFullScreenWhy => 'يعرض المنبه بملء الشاشة، حتى والهاتف مقفل.';

  @override
  String get readyExact => 'الرنين في الدقيقة تمامًا';

  @override
  String get readyExactWhy => 'بدون هذا قد يؤخر الهاتف المنبهات بضع دقائق.';

  @override
  String get readyBattery => 'الاستمرار مع توفير البطارية';

  @override
  String get readyBatteryWhy => 'يمنع توفير البطارية من كتم المنبهات ليلًا.';

  @override
  String get tipXiaomi =>
      'هواتف Xiaomi: في الإعدادات › التطبيقات › Quando? فعّل التشغيل التلقائي واضبط توفير البطارية على بلا قيود.';

  @override
  String get tipSamsung =>
      'هواتف Samsung: في الإعدادات › البطارية › حدود الاستخدام في الخلفية تأكد أن Quando? ليس في وضع السكون.';

  @override
  String get tipHuawei =>
      'هواتف Huawei وHonor: في الإعدادات › البطارية › تشغيل التطبيقات اضبط Quando? على الإدارة اليدوية واسمح بكل شيء.';

  @override
  String get tipOther =>
      'على هذا الهاتف: في الإعدادات › البطارية اسمح لـQuando? بالعمل في الخلفية وأوقف التحسين.';

  @override
  String get testRing => 'رنين تجريبي';

  @override
  String get testRingBody => 'يستطيع Quando? إيقاظك';

  @override
  String get ringsIn20 => 'يرنّ بعد 20 ثانية. اقفل هاتفك الآن وانتظر.';

  @override
  String get readyToRing => 'جاهز للرنين';

  @override
  String get checkingPhone => 'جارٍ فحص هاتفك…';

  @override
  String get phoneReady => 'هاتفك جاهز ليرنّ كل منبه في وقته.';

  @override
  String thingsNeedFixing(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'هناك $n أمرًا يحتاج إصلاحًا، وإلا قد لا ترنّ المنبهات.',
      few: 'هناك $n أمور تحتاج إصلاحًا، وإلا قد لا ترنّ المنبهات.',
      two: 'هناك أمران يحتاجان إصلاحًا، وإلا قد لا ترنّ المنبهات.',
      one: 'هناك أمر واحد يحتاج إصلاحًا، وإلا قد لا ترنّ المنبهات.',
    );
    return '$_temp0';
  }

  @override
  String get fix => 'إصلاح';

  @override
  String get testIn20 => 'تجربة: يرنّ بعد 20 ثانية';

  @override
  String get testIn20Hint => 'اقفل هاتفك وضعه جانبًا. إذا رنّ المنبه بملء الشاشة فكل شيء جاهز.';

  @override
  String get readyToRingHint => 'تحقق أن هاتفك يرنّ كل منبه في وقته';

  @override
  String get connections => 'الاتصالات';

  @override
  String get timeZoneHeading => 'المنطقة الزمنية';

  @override
  String get followPhone => 'اتبع الهاتف';

  @override
  String followPhoneNow(String city) {
    return 'الآن $city. تتغير وحدها عند السفر.';
  }

  @override
  String get zoneFixed => 'ثابتة. تحافظ المنبهات على هذا الوقت حتى عند السفر.';

  @override
  String get shabbatCityHeading => 'مدينة السبت';

  @override
  String get inIsraelOneDay => 'في إسرائيل (يوم عيد واحد)';

  @override
  String candleMinutesHeading(int n) {
    return 'الشموع: قبل الغروب بـ$n دقيقة';
  }

  @override
  String get endOfShabbatHeading => 'نهاية السبت والأعياد';

  @override
  String get nightfallGeonim => 'ظهور النجوم (الجيونيم، 8.5°)';

  @override
  String get rabbeinuTam => '72 دقيقة بعد الغروب (رابينو تام)';

  @override
  String get whenAlarmRingsHeading => 'عندما يرنّ المنبه';

  @override
  String get recordOrAddSounds => 'سجّل أو أضف أصواتًا';

  @override
  String get ringsForThisLong => 'يرنّ هذه المدة ثم يتوقف وحده';

  @override
  String get sameFades => 'نفس التلاشي لكل المنبهات';

  @override
  String get sameFadesOn => 'يحل محل تلاشي كل منبه. يحتفظ كل منبه بمستوى صوته.';

  @override
  String get sameFadesOff => 'متوقف: يستخدم كل منبه التلاشي المضبوط في إعدادات الصوت الخاصة به.';

  @override
  String get sayItOutLoud => 'انطقه بصوت عالٍ';

  @override
  String get sayItOutLoudHint => 'يقرأ الغرض من المنبه، مثل “إشعال الشموع، قبل 15 دقيقة”';

  @override
  String get noSnooze => 'بلا غفوة';

  @override
  String snoozeUpTo(int times, int minutes) {
    return 'غفوة حتى $times× لمدة $minutes د';
  }

  @override
  String get wakeUpCheck => 'تحقق الاستيقاظ';

  @override
  String get wakeUpCheckHint => 'بعد إيقافه يرنّ مجددًا بعد 3 دقائق ما لم تنقر “استيقظت”';

  @override
  String get solveSum => 'حل مسألة حسابية للإيقاف';

  @override
  String get provesAwake => 'يثبت أنك مستيقظ';

  @override
  String get shabbatNoTasks =>
      'في السبت والأعياد لا ينطبق أي من هذا: تتوقف المنبهات وحدها ولا تطلب لمس الهاتف أبدًا.';

  @override
  String get testAlarmIn1 => 'شغّل منبهًا تجريبيًا بعد دقيقة';

  @override
  String get timesDisclaimer =>
      'تُحسب الأوقات على الهاتف. في الحالات الحدّية اسأل حاخامك أو راجع تقويم الجماعة.';

  @override
  String get recommended => 'موصى به';

  @override
  String get chooseCity => 'اختر مدينة';

  @override
  String get testOnlyOnPhone => 'المنبهات التجريبية تعمل على الهاتف فقط.';

  @override
  String get testAlarm => 'منبه تجريبي';

  @override
  String get testAlarmBody => 'هكذا سترنّ منبهاتك';

  @override
  String get testAlarmIn1Set => 'منبه تجريبي بعد دقيقة. يمكنك قفل هاتفك.';

  @override
  String get presetGone => 'هذا القالب لم يعد موجودًا.';

  @override
  String get editPreset => 'تعديل القالب';

  @override
  String get on => 'مفعّل';

  @override
  String get ringsHeading => 'يرنّ';

  @override
  String get noTimesYet => 'لا أوقات بعد. أضف واحدًا أدناه.';

  @override
  String get atTheMomentItself => 'في اللحظة نفسها';

  @override
  String get remove => 'إزالة';

  @override
  String get addATime => 'إضافة وقت';

  @override
  String get resetPreset => 'إعادة إلى الأصل';

  @override
  String get skipOneHint => 'لتخطي منبه واحد، انقر عليه في “منبهات هذا الأسبوع” على الشاشة الرئيسية.';

  @override
  String get unitMinutes => 'دقائق';

  @override
  String get unitHours => 'ساعات';

  @override
  String get unitDays => 'أيام';

  @override
  String get before => 'قبل';

  @override
  String get after => 'بعد';

  @override
  String get oneWeek => 'أسبوع';

  @override
  String daysShort(int n) {
    return '$n ي';
  }

  @override
  String hoursShort(int n) {
    return '$n س';
  }

  @override
  String get howToSearch => 'كيفية البحث';

  @override
  String get searchHelpWord => 'العنوان يحتوي “dentist” بأي حالة أحرف';

  @override
  String get searchHelpStar => '* تعني أي أحرف: dentist، dentures';

  @override
  String get searchHelpQuestion => '? تعني حرفًا واحدًا: yoga، toga';

  @override
  String get searchHelpPhrase => 'هذه العبارة بالضبط';

  @override
  String get searchHelpAnd => 'الكلمتان معًا (AND)';

  @override
  String get searchHelpOr => 'أيٌّ منهما. | تعمل أيضًا';

  @override
  String get searchHelpNot => 'استبعاد. NOT و ! تعملان أيضًا';

  @override
  String get searchHelpBrackets => 'الأقواس تجمع الكلمات';

  @override
  String get searchHelpEmpty => 'اتركه فارغًا ليرنّ عند كل حدث.';

  @override
  String get customTime => 'وقت آخر';

  @override
  String get other => 'أخرى';

  @override
  String get sun => 'الشمس';

  @override
  String get calendar => 'التقويم';

  @override
  String get newEventAlarm => 'منبه حدث جديد';

  @override
  String get eventAlarm => 'منبه حدث';

  @override
  String get findEventsHeading => 'ابحث عن أحداث';

  @override
  String get searchEventsHint => 'ابحث: طبيب أسنان، نادي OR يوغا، أسنا*…';

  @override
  String get alsoBuiltInTimes => 'وأيضًا أوقات السبت والأعياد والشمس';

  @override
  String get alsoBuiltInTimesHint => 'مثل “شمو*”، “الهفدالا”، “الغروب”';

  @override
  String get allMyCalendars => 'كل تقويماتي';

  @override
  String get connectToSearch => 'اربط التقويمات للبحث فيها';

  @override
  String get searching => 'جارٍ البحث…';

  @override
  String get nothingMatches60 => 'لا نتائج في الأيام الستين القادمة';

  @override
  String eventsIn60(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n حدثًا في الأيام الستين القادمة',
      few: '$n أحداث في الأيام الستين القادمة',
      two: 'حدثان في الأيام الستين القادمة',
      one: 'حدث واحد في الأيام الستين القادمة',
    );
    return '$_temp0';
  }

  @override
  String nextRingsAt(String times, String title) {
    return 'التالي: يرنّ الساعة $times لـ“$title”';
  }

  @override
  String showMoreLeft(int n) {
    return 'عرض المزيد (بقي $n)';
  }

  @override
  String get ringBeforeStartsHeading => 'رنّ قبل البداية';

  @override
  String get ringWhenStarts => 'رنّ عند البداية';

  @override
  String get repeatBeforeHeading => 'وكرّر قبله';

  @override
  String get everyPrefix => 'كل ';

  @override
  String get offLower => 'متوقف';

  @override
  String get forInfix => '  لمدة ';

  @override
  String get ringAfterEndsHeading => 'رنّ بعد الانتهاء';

  @override
  String get nameOptional => 'الاسم (اختياري)';

  @override
  String get toppedUp => 'المنبهات مضبوطة للأيام السبعة القادمة وتُجدد كلما فتحت Quando?.';

  @override
  String get back => 'رجوع';

  @override
  String get next => 'التالي';

  @override
  String get stepWhichEvents => 'أي أحداث';

  @override
  String get stepWhenToRing => 'متى يرنّ';

  @override
  String get stepHowItRings => 'كيف يرنّ';

  @override
  String defaultNamed(String name) {
    return 'الافتراضي ($name)';
  }

  @override
  String get phoneAlarmSound => 'صوت منبه الهاتف';

  @override
  String get onlineRadio => 'راديو عبر الإنترنت';

  @override
  String songLinkOpens(String app) {
    return 'رابط أغنية · يفتح $app';
  }

  @override
  String get builtIn => 'مدمج';

  @override
  String get yourRecording => 'تسجيلك';

  @override
  String get sound => 'الصوت';

  @override
  String get wakeToOwnSound => 'استيقظ على صوتك الخاص';

  @override
  String get wakeToOwnSoundHint => 'صوتك، أغنية، Spotify أو راديو مباشر';

  @override
  String musicAdded(String name) {
    return 'تمت إضافة $name. اختره صوتًا لأي منبه.';
  }

  @override
  String get playlists => 'قوائم التشغيل';

  @override
  String get likedSongs => 'الأغاني المفضلة';

  @override
  String get noPlaylists => 'لا قوائم تشغيل بعد.';

  @override
  String get noLikedSongs => 'لا أغاني مفضلة بعد.';

  @override
  String get needsMic => 'يحتاج Quando? إلى الميكروفون للتسجيل.';

  @override
  String recordingN(int n) {
    return 'تسجيل $n';
  }

  @override
  String couldNotAddFile(String error) {
    return 'تعذرت إضافة الملف: $error';
  }

  @override
  String get addSongLink => 'إضافة رابط أغنية';

  @override
  String get songLink => 'رابط الأغنية';

  @override
  String get songLinkHowTo =>
      'في Spotify أو Apple Music أو Amazon Music أو YouTube أو YouTube Music أو SoundCloud انقر مشاركة ثم نسخ الرابط، والصقه هنا.';

  @override
  String get songNameHint => 'الاسم، مثل قائمة الصباح';

  @override
  String get whenAlarmGoesOffHeading => 'عندما يرنّ المنبه';

  @override
  String get playTheSong => 'شغّل الأغنية';

  @override
  String get ringThenOpen => 'رنّ ثم افتح';

  @override
  String get playTheSongHint =>
      'يفتح تطبيقها ويشغّلها. إذا بقي صامتًا 10 ثوانٍ يرنّ الصوت الاحتياطي، فتستيقظ دائمًا. المنبهات ذات المهمة ترنّ أولًا ثم تفتحها.';

  @override
  String get ringThenOpenHint => 'يرنّ الصوت الاحتياطي. الإيقاف يفتح الأغنية في تطبيقها.';

  @override
  String get playForHeading => 'مدة التشغيل';

  @override
  String get pausesAfter => 'يوقف Quando? الأغنية مؤقتًا بعد هذه المدة بزر الإيقاف المؤقت في الهاتف.';

  @override
  String get backupSoundHeading => 'الصوت الاحتياطي';

  @override
  String get notALink => 'هذا لا يبدو رابطًا.';

  @override
  String songOn(String app) {
    return 'أغنية على $app';
  }

  @override
  String get theWeb => 'الويب';

  @override
  String get pickFromYouTube => 'اختر من YouTube الخاص بي';

  @override
  String get youTubeAndMusic => 'YouTube وYouTube Music';

  @override
  String get youTubeOn => 'قوائم تشغيلك وأغانيك المفضلة. اضغط مطولًا لتسجيل الخروج.';

  @override
  String get youTubeSignIn => 'سجّل الدخول عبر Google لتختار من قوائم تشغيلك وأغانيك المفضلة.';

  @override
  String get addSongLinkInstead => 'أضف رابط أغنية بدلًا من ذلك.';

  @override
  String get googleSignInFailed => 'لم يكتمل تسجيل الدخول إلى Google. حاول مجددًا.';

  @override
  String get myYouTube => 'YouTube الخاص بي';

  @override
  String get spotifyDirectOn => 'تشغيل Spotify المباشر مفعّل';

  @override
  String get spotifyDirect => 'تشغيل Spotify المباشر';

  @override
  String get spotifyDirectOnHint => 'يشغّل Spotify أغنيتك بالضبط كمنبه. انقر للإيقاف.';

  @override
  String get spotifyDirectHint =>
      'يشغّل أغنية Spotify الخاصة بك بالضبط كمنبه، بموثوقية أكبر. يتطلب تطبيق Spotify وSpotify Premium. انقر لتسجيل الدخول.';

  @override
  String get spotifyComingSoon =>
      'قريبًا: شغّل أغنية Spotify الخاصة بك بالضبط كمنبه (يتطلب Spotify Premium).';

  @override
  String get spotifyFailed => 'لم يتصل Spotify. تأكد من تثبيت تطبيق Spotify وتسجيل الدخول وامتلاك Premium.';

  @override
  String get nameThisSound => 'سمِّ هذا الصوت';

  @override
  String get sounds => 'الأصوات';

  @override
  String get soundsSentence => 'استيقظ على صوتك أو أغنية أو قائمة تشغيل أو راديو مباشر.';

  @override
  String stopTimer(String time) {
    return 'إيقاف · $time';
  }

  @override
  String get record => 'تسجيل';

  @override
  String get addAFile => 'إضافة ملف';

  @override
  String get addSongLinkLong => 'إضافة رابط أغنية (Spotify، Apple Music، YouTube…)';

  @override
  String get musicAppsHeading => 'تطبيقات الموسيقى';

  @override
  String get pickFromSpotify => 'اختر من Spotify الخاص بي';

  @override
  String get yourPlaylistsAndLiked => 'قوائم تشغيلك وأغانيك المفضلة';

  @override
  String get mySpotify => 'Spotify الخاص بي';

  @override
  String get spotifySignInFailed => 'تعذر تسجيل الدخول إلى Spotify.';

  @override
  String get appleMusicNote => 'سيأتي تسجيل الدخول مع نسخة iPhone. أضف رابط أغنية حاليًا.';

  @override
  String noSignInNote(String service) {
    return '$service لا يسمح للتطبيقات الأخرى بتسجيل الدخول. أضف رابط أغنية بدلًا من ذلك.';
  }

  @override
  String get wakeToRadio => 'استيقظ على راديو الإنترنت';

  @override
  String get soundsExplain =>
      'سجّل صوتك أو أغنية أو أي شيء، حتى 5 دقائق. أضف ملف MP3 أو M4A أو WAV من هاتفك. اربط أغنية أو قائمة تشغيل: يشغّلها تطبيقها كمنبه مع صوت احتياطي. أو اختر محطة راديو: تبث مباشرة، وإن لم تتصل يرنّ منبه الهاتف.';

  @override
  String get yourSoundsHeading => 'أصواتك';

  @override
  String playsIn(String app) {
    return 'يعمل في $app';
  }

  @override
  String opensIn(String app) {
    return 'يفتح في $app';
  }

  @override
  String forSpan(String span) {
    return 'لمدة $span';
  }

  @override
  String get defaultLabel => 'الافتراضي';

  @override
  String get radioUnreachable => 'تعذر الوصول إلى قائمة المحطات. تحقق من اتصالك.';

  @override
  String get addStreamAddress => 'إضافة عنوان بث';

  @override
  String get notAStream => 'هذا لا يبدو عنوان بث (يبدأ بـ http).';

  @override
  String get anyGenre => 'أي نوع';

  @override
  String get stationName => 'اسم المحطة';

  @override
  String get closeSearch => 'إغلاق البحث';

  @override
  String get searchByName => 'ابحث بالاسم';

  @override
  String get anywhere => 'في أي مكان';

  @override
  String get noStations => 'لم يُعثر على محطات. جرّب نوعًا أو بلدًا آخر.';

  @override
  String wakeUpTo(String name) {
    return 'استيقظ على $name';
  }

  @override
  String get notQuite => 'ليس تمامًا. حاول مجددًا.';

  @override
  String shabbatStopsItself(int n) {
    return 'وضع السبت: يتوقف وحده بعد $n ثانية. لا حاجة للمس الهاتف.';
  }

  @override
  String get solveToSnooze => 'حلّ للغفوة';

  @override
  String get solveToStop => 'حلّ للإيقاف';

  @override
  String get answer => 'الإجابة';

  @override
  String get snooze => 'غفوة';

  @override
  String get stop => 'إيقاف';

  @override
  String get shakeToSnooze => 'هزّ للغفوة';

  @override
  String get shakeToStop => 'هزّ للإيقاف';

  @override
  String get shakeHard => 'هزّ الهاتف بقوة حتى يمتلئ الشريط.';

  @override
  String get cantShake => 'لا تستطيع الهز؟ حلّ مسألة';

  @override
  String get pairsToSnooze => 'طابق الأزواج للغفوة';

  @override
  String get pairsToStop => 'طابق الأزواج للإيقاف';

  @override
  String get typeToSnooze => 'اكتب هذا للغفوة';

  @override
  String get typeToStop => 'اكتب هذا للإيقاف';

  @override
  String get scanToSnooze => 'امسح رمزك للغفوة';

  @override
  String get scanToStop => 'امسح رمزك للإيقاف';

  @override
  String ringAgainUnless(int n) {
    return 'سأرنّ مجددًا بعد $n دقائق ما لم تنقر أدناه.';
  }

  @override
  String get imUp => 'استيقظت';

  @override
  String snoozeMin(int n) {
    return 'غفوة $n د';
  }

  @override
  String snoozeMinLeft(int n, int left) {
    return 'غفوة $n د · بقي $left';
  }

  @override
  String get noSnoozesLeft => 'لا غفوات متبقية';

  @override
  String get stopThenOpen => 'إيقاف · ثم فتح';

  @override
  String get startingSong => 'جارٍ تشغيل أغنيتك';

  @override
  String wayToStop(String way) {
    return '$way للإيقاف';
  }

  @override
  String wayToSnooze(String way) {
    return '$way للغفوة';
  }

  @override
  String ringsForMore(int n) {
    return 'يرنّ $n ثانية أخرى';
  }

  @override
  String get leftToRing => 'متبقية';

  @override
  String get wayVolumeButtons => 'أزرار الصوت';

  @override
  String get wayShake => 'هزّ الهاتف';

  @override
  String get taskNothing => 'لا شيء';

  @override
  String get taskSum => 'حلّ مسألة';

  @override
  String get taskShake => 'هزّ 30 مرة';

  @override
  String get taskMemory => 'لعبة الذاكرة';

  @override
  String get taskPhrase => 'اكتب عبارة';

  @override
  String get taskScan => 'امسح رمزًا';

  @override
  String get noLimit => 'بلا حد';

  @override
  String upToTimes(int n) {
    return 'حتى $n×';
  }

  @override
  String shorterEachTime(int n) {
    return 'أقصر بـ$n د كل مرة';
  }

  @override
  String autoSnoozeAfter(int n) {
    return 'غفوة تلقائية بعد $n د';
  }

  @override
  String get card => 'بطاقة';

  @override
  String get hiddenCard => 'بطاقة مخفية';

  @override
  String get phrase1 => 'أنا مستيقظ وهذا اليوم لي';

  @override
  String get phrase2 => 'إن لم يكن الآن فمتى';

  @override
  String get phrase3 => 'صباح الخير لي ولكل من أحب';

  @override
  String get phrase4 => 'قدماي على الأرض وقد نهضت';

  @override
  String get phrase5 => 'اليوم أبدأ من جديد';

  @override
  String get notQuiteWords => 'ليس تمامًا، تحقق من كل كلمة.';

  @override
  String get typeItHere => 'اكتبه هنا';

  @override
  String get differentCode => 'هذا رمز مختلف.';

  @override
  String get cameraUnavailable => 'الكاميرا غير متاحة.';

  @override
  String get cantScan => 'لا تستطيع المسح؟ حلّ مسألة';

  @override
  String get saveCodeToScan => 'احفظ رمزًا لمسحه';

  @override
  String get saveCodeHint =>
      'وجّه الكاميرا إلى رمز شريطي أو QR في مكان يجب أن تمشي إليه، مثل علبة في المطبخ أو معجون أسنان في الحمام. لإيقاف المنبه ستمسحه مجددًا.';

  @override
  String get cameraUnavailableSettings => 'الكاميرا غير متاحة. اسمح بالوصول إلى الكاميرا في الإعدادات.';

  @override
  String gentleToGo(int n) {
    return 'استيقاظ لطيف · بقي $n د';
  }

  @override
  String previewBody(String body) {
    return 'معاينة · $body';
  }

  @override
  String snoozedBody(String body) {
    return 'غفوة: $body';
  }

  @override
  String get areYouUp => 'هل استيقظت؟';

  @override
  String get tapImUp => 'انقر “استيقظت” للإيقاف';

  @override
  String get volume => 'مستوى الصوت';

  @override
  String get wakeCheckOn => 'تحقق الاستيقاظ مفعّل';

  @override
  String get stopsAtOnce => 'يتوقف فورًا';

  @override
  String get ringsAgainIfNotUp => 'يرنّ مجددًا إن لم تستيقظ';

  @override
  String get openAppAfter => 'افتح تطبيقًا بعده';

  @override
  String get noTask => 'بلا مهمة';

  @override
  String get codeSaved => 'تم حفظ الرمز';

  @override
  String get tapToSaveDifferent => 'انقر لحفظ رمز آخر';

  @override
  String get controlsHeading => 'عناصر التحكم';

  @override
  String get onScreen => 'على الشاشة';

  @override
  String get taskHeading => 'المهمة';

  @override
  String get none => 'لا شيء';

  @override
  String get snoozeSentence => 'خمس دقائق أخرى؟ اختر المدة وعدد المرات وما المطلوب.';

  @override
  String get settingsHeading => 'الإعدادات';

  @override
  String get snoozeTime => 'مدة الغفوة';

  @override
  String get snoozeTimeHint => 'مدة الغفوة الأولى';

  @override
  String get shortenSnoozes => 'قصّر الغفوات اللاحقة';

  @override
  String get shortenSnoozesHint => 'كل غفوة بعد الأولى أقصر بهذا القدر';

  @override
  String get autoSnooze => 'غفوة تلقائية';

  @override
  String get autoSnoozeHint => 'إن لم تلمسه، يغفو وحده بعد';

  @override
  String get never => 'أبدًا';

  @override
  String get snoozeLimit => 'حد الغفوات';

  @override
  String get snoozeLimitHint => 'كم مرة يمكنك الغفوة';

  @override
  String get unlimited => 'بلا حد';

  @override
  String get useSnoozeFromSettings => 'استخدم الغفوة من الإعدادات';

  @override
  String get stopSentence => 'كيف توقف المنبه وما الذي عليك فعله أولًا.';

  @override
  String get shabbatNoTask => 'في السبت والأعياد تتوقف المنبهات وحدها ولا تطلب مهمة أبدًا.';

  @override
  String get volumeSentence => 'مدى ارتفاع رنينه ومدى لطف وصوله إلى ذلك.';

  @override
  String get openAfterAlarm => 'افتح بعد المنبه';

  @override
  String get pickAnApp => 'اختر تطبيقًا';

  @override
  String get orPasteLink => 'أو الصق رابطًا: https://…';

  @override
  String get useThisLink => 'استخدم هذا الرابط';

  @override
  String get noAppsFound => 'لم يُعثر على تطبيقات.';

  @override
  String get weather => 'الطقس';

  @override
  String get news => 'الأخبار';

  @override
  String get usePhoneVolume => 'استخدم مستوى صوت منبه الهاتف';

  @override
  String get setsPhoneVolume => 'يضبط مستوى صوت منبه الهاتف أثناء الرنين ثم يعيده.';

  @override
  String get fadeInOff => 'بلا تدرّج، الصوت كامل فورًا';

  @override
  String fadeInOver(String span) {
    return 'يعلو خلال $span';
  }

  @override
  String get fadeOutOff => 'بلا تلاشٍ';

  @override
  String fadeOutOver(String span) {
    return 'يخفت في آخر $span';
  }

  @override
  String get fadesExplain =>
      'يحدث التلاشي عندما يتوقف المنبه وحده. إذا كانت المدد أطول من الرنين يُقصَّر كلاهما.';

  @override
  String get soundSoftChime => 'جرس ناعم';

  @override
  String get soundMorningRise => 'إشراقة الصباح';

  @override
  String get soundClassicBeep => 'صفارة كلاسيكية';

  @override
  String get calmCity => 'صباح مدينة هادئ';

  @override
  String get calmBirds => 'طيور الفجر';

  @override
  String get calmWaves => 'أمواج على الشاطئ';

  @override
  String get calmRain => 'مطر خفيف';

  @override
  String get calmStream => 'جدول في الغابة';

  @override
  String get calmWind => 'نسيم لطيف';

  @override
  String get calmFire => 'نار متقدة';

  @override
  String get calmNight => 'ليلة صيف';

  @override
  String get publicDomain => 'ملكية عامة';

  @override
  String get phoneVolume => 'مستوى صوت الهاتف';

  @override
  String fadesIn(String span) {
    return 'يعلو خلال $span';
  }

  @override
  String fadesOut(String span) {
    return 'يخفت خلال $span';
  }

  @override
  String get noFade => 'بلا تدرّج';

  @override
  String minSecShort(int m, int s) {
    return '$m د $s ث';
  }

  @override
  String get happensRings => 'يرنّ';

  @override
  String get happensStopped => 'توقفه';

  @override
  String get happensSnoozed => 'تؤجله';

  @override
  String get happensAutoStopped => 'يتوقف وحده';

  @override
  String get eventLower => 'حدث';

  @override
  String get appTest => 'اختبار Quando?';

  @override
  String get pushoverConnected => 'Pushover متصل';

  @override
  String get webhookConnected => 'الويب هوك متصل';

  @override
  String pushoverSaid(int code, String body) {
    return 'ردّ Pushover بـ $code: $body';
  }

  @override
  String couldNotReachPushover(String error) {
    return 'تعذر الوصول إلى Pushover ($error)';
  }

  @override
  String itAnswered(int code) {
    return 'الرد: $code';
  }

  @override
  String couldNotReachIt(String error) {
    return 'تعذر الوصول ($error)';
  }

  @override
  String get calendarNotAllowed => 'لم يُسمح بالوصول إلى التقويم.';

  @override
  String get playlist => 'قائمة تشغيل';

  @override
  String songCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n أغنية',
      many: '$n أغنية',
      few: '$n أغانٍ',
      two: 'أغنيتان',
      one: 'أغنية واحدة',
    );
    return '$_temp0';
  }

  @override
  String get spotifySaidNo =>
      'رفض Spotify. في لوحة Spotify حدد Web API لـQuando? وأضف حسابك في User Management.';

  @override
  String serviceDidntAnswer(String service, int code) {
    return 'لم يرد $service ($code).';
  }

  @override
  String get youTubeSaidNo => 'رفض YouTube. تأكد أن حساب Google الخاص بك مستخدم تجريبي في مشروع Quando.';

  @override
  String get event => 'حدث';

  @override
  String eventEnds(String title) {
    return '$title (النهاية)';
  }

  @override
  String foundSoundsDevices(int s, int d) {
    return 'تم العثور على $s أصوات و$d أجهزة.';
  }

  @override
  String get sentCheckDevices => 'تم الإرسال. تحقق من أجهزتك الأخرى.';

  @override
  String sentTo(String name) {
    return 'أُرسل إلى $name.';
  }

  @override
  String get zapierHowTo =>
      'في Zapier أنشئ Zap يبدأ بـ “Webhooks by Zapier → Catch Hook”، ثم الصق عنوان URL الخاص به هنا.';

  @override
  String get catchHookUrl => 'عنوان Catch Hook';

  @override
  String get iftttHowTo =>
      'في IFTTT أنشئ applet يبدأ بـ “Webhooks → Receive a web request with a JSON payload”. استخدم اسم الحدث نفسه هنا. مفتاحك على ifttt.com/maker_webhooks/settings.';

  @override
  String get eventName => 'اسم الحدث';

  @override
  String get webhooksKey => 'مفتاح Webhooks';

  @override
  String get webhookHowTo => 'يرسل Quando? طلب JSON POST إلى هذا العنوان.';

  @override
  String get connectionsSentence => 'أبلغ التطبيقات والأجهزة الأخرى عندما يرنّ المنبه أو يتوقف أو يُؤجَّل.';

  @override
  String get pushWhenRings => 'أرسل إشعارًا عندما يرنّ منبه';

  @override
  String get pushWhenRingsHint => 'إلى هواتفك الأخرى أو أجهزتك اللوحية أو ساعتك أو حاسوبك';

  @override
  String get yourUserKey => 'مفتاح المستخدم الخاص بك';

  @override
  String get appToken => 'رمز التطبيق';

  @override
  String get soundAndDevicesHeading => 'الصوت والأجهزة';

  @override
  String get loading => 'جارٍ التحميل…';

  @override
  String get loadFromPushover => 'تحميل من Pushover';

  @override
  String get soundItPlays => 'الصوت الذي يُشغَّل';

  @override
  String get myPushoverDefault => 'الافتراضي في Pushover';

  @override
  String get pushoverOwnSounds => 'تظهر أصواتك الخاصة هنا بعد رفعها إلى pushover.net/sounds.';

  @override
  String get allMyDevices => 'كل أجهزتي';

  @override
  String get pushoverOnThisPhone =>
      'ثبّت تطبيق Pushover على هذا الهاتف أيضًا وسيرنّ هنا بصوت Pushover الخاص بك.';

  @override
  String get priority => 'الأولوية';

  @override
  String get priorityNormal => 'عادية';

  @override
  String get priorityHigh => 'عالية: تتجاوز ساعات الهدوء';

  @override
  String get priorityEmergency => 'طارئة: تتكرر حتى التأكيد';

  @override
  String get sending => 'جارٍ الإرسال…';

  @override
  String get sendATest => 'أرسل تجربة';

  @override
  String get findUserKey => 'اعثر على مفتاح المستخدم';

  @override
  String get makeAppToken => 'أنشئ رمز تطبيق';

  @override
  String get webhooksHeading => 'ZAPIER وIFTTT والويب هوك';

  @override
  String get webhooksExplain =>
      'شغّل أي شيء عندما يرنّ المنبه أو توقفه: أضئ الأنوار، سجّل وقت استيقاظك، راسل أحدًا.';

  @override
  String get sendWhenAlarm => 'أرسل عندما المنبه:';

  @override
  String get pauseOnShabbat => 'إيقاف مؤقت في السبت والأعياد';

  @override
  String get pauseOnShabbatHint => 'لا يُرسل شيء للمنبهات بين إشعال الشموع والهفدالا';

  @override
  String get webhookPayloadNote =>
      'كل رسالة تتضمن: event (ring، stopped، snoozed، auto_stopped)، title، body، time، shabbat وsnoozes. تبقى المفاتيح على هذا الهاتف.';

  @override
  String get today => 'اليوم';

  @override
  String get tomorrow => 'غدًا';

  @override
  String get notAWebAddress => 'هذا لا يبدو عنوان ويب يبدأ بـ https://';

  @override
  String get language => 'اللغة';

  @override
  String get phoneLanguage => 'لغة الهاتف';

  @override
  String get ringQuote => 'إن لم يكن الآن، فمتى؟';

  @override
  String get ringQuoteBy => 'هليل';

  @override
  String get quotesTitle => 'أقوال عن الوقت';

  @override
  String get quotesHint => 'اختر مصادرها. قول لكل جزء من اليوم؛ المس القول لرؤية غيره.';

  @override
  String get quotesOff => 'متوقفة';

  @override
  String get quoteSongs => 'أغانٍ';

  @override
  String get quoteMovies => 'أفلام';

  @override
  String get quoteLiterature => 'كتب وقصائد';

  @override
  String get quoteTanakh => 'التناخ (الكتاب المقدس العبري)';

  @override
  String get quoteSages => 'التلمود والحكماء';

  @override
  String get quoteSpeeches => 'خطب شهيرة';

  @override
  String get quotePhilosophy => 'فلاسفة';

  @override
  String get quoteProverbs => 'أمثال وأقوال';

  @override
  String get quotesAlso => 'اعرض أيضًا';

  @override
  String get quoteCarnaval => 'الكرنفال';

  @override
  String get quoteCarnavalHint => 'أغانٍ وأقوال خلال كرنفال البرازيل';

  @override
  String get quoteNearMe => 'بالقرب مني';

  @override
  String get quoteNearMeHint => 'شعراء ومناسبات المكان الذي أنت فيه، حسب منطقتك الزمنية ومدينة السبت';

  @override
  String get quoteSiddur => 'السيدور (كتاب الصلوات)';

  @override
  String weeklyParasha(String name) {
    return 'البارشاه $name';
  }

  @override
  String poweredBy(String name) {
    return 'بدعم من $name';
  }

  @override
  String get syncTitle => 'Sync my devices';

  @override
  String get syncHint => 'Sign in with Google to keep alarms and settings the same on all your devices.';

  @override
  String syncOn(String email) {
    return 'On · $email';
  }

  @override
  String get syncWorking => 'Connecting…';

  @override
  String get syncNotAllowed => 'This Google account can\'t sync.';

  @override
  String get syncFailed => 'Couldn\'t connect. Tap to try again.';

  @override
  String get syncStop => 'Stop syncing';

  @override
  String get syncNotSetUp => 'Sync isn\'t set up in this build yet.';
}
