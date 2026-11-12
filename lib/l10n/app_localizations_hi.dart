// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get undo => 'पहले जैसा करें';

  @override
  String duplicatedNamed(String name) {
    return '“$name” की कॉपी बनी';
  }

  @override
  String deletedNamed(String name) {
    return '“$name” हटाया गया';
  }

  @override
  String get when => 'कब?';

  @override
  String get newAtTime => 'किसी समय पर';

  @override
  String get newAtTimeHint => 'हर कार्यदिवस 7:00 बजे, एक बार 15:30 बजे…';

  @override
  String get newAroundEvent => 'किसी इवेंट के आसपास';

  @override
  String get newAroundEventHint =>
      'कैलेंडर, शब्बात और सूरज के समय में खोजें, फिर पहले, उसी समय या बाद में बजाएँ';

  @override
  String get editThisAlarm => 'यह अलार्म बदलें';

  @override
  String editNamed(String name) {
    return '“$name” बदलें';
  }

  @override
  String get preset => 'टेम्पलेट';

  @override
  String get editThisCalendarRule => 'यह कैलेंडर नियम बदलें';

  @override
  String get ringThisOneAfterAll => 'फिर भी इसे बजाएँ';

  @override
  String get skipJustThisOne => 'सिर्फ़ इसे छोड़ें';

  @override
  String get renameGroup => 'समूह का नाम बदलें';

  @override
  String quickSet(String label, String time) {
    return '$label · $time पर बजेगा';
  }

  @override
  String get newAlarm => 'नया अलार्म';

  @override
  String get appName => 'Quando?';

  @override
  String get lockMode => 'लॉक मोड';

  @override
  String get calendars => 'कैलेंडर';

  @override
  String get settings => 'सेटिंग्स';

  @override
  String get nextAlarmHeading => 'अगला अलार्म';

  @override
  String get nothingSet => 'कुछ सेट नहीं';

  @override
  String get tagline => 'हर चीज़ अपने समय पर।';

  @override
  String sunriseAt(String time) {
    return 'सूर्योदय $time';
  }

  @override
  String sunsetAt(String time) {
    return 'सूर्यास्त $time';
  }

  @override
  String get alarmsMayNotRing => 'आपके अलार्म शायद न बजें';

  @override
  String get tapToFixIt => 'ठीक करने के लिए टैप करें';

  @override
  String inMinutes(int minutes) {
    return '$minutes मिनट में';
  }

  @override
  String get atSunset => 'सूर्यास्त पर';

  @override
  String get sunset => 'सूर्यास्त';

  @override
  String get shabbatModeIsOn => 'शब्बात मोड चालू है';

  @override
  String nextInCity(String city) {
    return 'अगला · $city';
  }

  @override
  String get candleLighting => 'मोमबत्ती जलाना';

  @override
  String get havdalah => 'हवदाला';

  @override
  String get shabbatAndFestivals => 'शब्बात और त्योहार';

  @override
  String get yourAlarmsHeading => 'आपके अलार्म';

  @override
  String get tapWhenToAdd => 'अलार्म जोड़ने के लिए “कब?” पर टैप करें।';

  @override
  String get aroundEventsHeading => 'इवेंट के आसपास';

  @override
  String searchFor(String words) {
    return 'खोज: $words';
  }

  @override
  String get thisWeekHeading => 'इस हफ़्ते के अलार्म';

  @override
  String get noAlarmsThisWeek => 'अगले 7 दिनों में कोई अलार्म नहीं।';

  @override
  String get alarmsSetThemselves => 'जब भी आप कुछ बदलते हैं, अलार्म इस फ़ोन पर खुद सेट हो जाते हैं।';

  @override
  String cityTime(String city) {
    return '$city का समय';
  }

  @override
  String get more => 'और';

  @override
  String get turnOff => 'बंद करें';

  @override
  String get turnOn => 'चालू करें';

  @override
  String get duplicate => 'कॉपी बनाएँ';

  @override
  String get delete => 'हटाएँ';

  @override
  String get inOneHour => '1 घंटे में';

  @override
  String get logoLabel => 'Quando? लोगो';

  @override
  String get noTimesSet => 'कोई समय सेट नहीं';

  @override
  String get atTheMoment => 'उसी पल';

  @override
  String timesRange(int count, String from, String to) {
    return '$count बार · $from से $to';
  }

  @override
  String spanDays(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n दिन', one: '1 दिन');
    return '$_temp0';
  }

  @override
  String spanHours(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n घंटे', one: '1 घंटा');
    return '$_temp0';
  }

  @override
  String spanMinutes(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n मिनट', one: '1 मिनट');
    return '$_temp0';
  }

  @override
  String spanSeconds(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n सेकंड', one: '1 सेकंड');
    return '$_temp0';
  }

  @override
  String get now => 'अभी';

  @override
  String spanBefore(String span) {
    return '$span पहले';
  }

  @override
  String spanAfter(String span) {
    return '$span बाद';
  }

  @override
  String alarmCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n अलार्म', one: '1 अलार्म');
    return '$_temp0';
  }

  @override
  String get allOn => 'सभी चालू';

  @override
  String get allOff => 'सभी बंद';

  @override
  String someOn(int n) {
    return '$n चालू';
  }

  @override
  String skippedBody(String body) {
    return 'छोड़ा गया · $body';
  }

  @override
  String timeToTime(String from, String to) {
    return '$from – $to';
  }

  @override
  String skippedCount(int n) {
    return '$n छोड़े गए';
  }

  @override
  String get sunNoRiseSet => 'आज यहाँ सूरज न उगता है न डूबता है';

  @override
  String sunProgress(int percent) {
    return 'सूरज ने दिन का $percent% पार कर लिया';
  }

  @override
  String get sunIsDown => 'सूरज डूब चुका है';

  @override
  String get searchCity => 'शहर खोजें';

  @override
  String get tomorrowLower => 'कल';

  @override
  String get yesterdayLower => 'बीता कल';

  @override
  String get worldClocksHeading => 'विश्व घड़ियाँ';

  @override
  String get add => 'जोड़ें';

  @override
  String cityHere(String city) {
    return '$city · यहाँ';
  }

  @override
  String get worldClocksHint =>
      'शहरों का समय यहाँ देखने के लिए उन्हें जोड़ें। हटाने के लिए बाएँ स्वाइप करें।';

  @override
  String get groupNameHint => 'काम, बच्चे, जिम…';

  @override
  String get cancel => 'रद्द करें';

  @override
  String get ok => 'ठीक है';

  @override
  String get noGroup => 'कोई समूह नहीं';

  @override
  String get newGroupEllipsis => 'नया समूह…';

  @override
  String get newGroup => 'नया समूह';

  @override
  String secondsShort(int n) {
    return '$n से';
  }

  @override
  String minutesShort(int n) {
    return '$n मि';
  }

  @override
  String get minutes => 'मिनट';

  @override
  String get ringFor => 'बजने की अवधि';

  @override
  String get seconds => 'सेकंड';

  @override
  String get oneSecondLess => '1 सेकंड कम';

  @override
  String get oneSecondMore => '1 सेकंड ज़्यादा';

  @override
  String inDays(int d) {
    return '$d दिन में';
  }

  @override
  String inDaysHours(int d, int h) {
    return '$d दिन $h घं में';
  }

  @override
  String inHours(int h) {
    return '$h घं में';
  }

  @override
  String inHoursMinutes(int h, int m) {
    return '$h घं $m मि में';
  }

  @override
  String inMins(int m) {
    return '$m मि में';
  }

  @override
  String placeChange(String city, String where) {
    return '$city · $where · बदलें';
  }

  @override
  String get israel => 'इज़राइल';

  @override
  String get outsideIsrael => 'इज़राइल के बाहर';

  @override
  String get comingUpHeading => 'आने वाले';

  @override
  String get lockForShabbat => 'शब्बात के लिए फ़ोन लॉक करें';

  @override
  String get lockForShabbatHint => 'मोमबत्ती जलाने से हवदाला तक, त्योहारों पर भी';

  @override
  String get ownShabbatAlarmsHeading => 'आपके शब्बात अलार्म';

  @override
  String get addShabbatAlarm => 'शब्बात या त्योहार का अलार्म जोड़ें';

  @override
  String get readyMadeHeading => 'तैयार अलार्म';

  @override
  String bringBackDeleted(int n) {
    return 'हटाए गए वापस लाएँ ($n)';
  }

  @override
  String get presetsHint => 'समय बदलने के लिए किसी पर टैप करें। हटाने के लिए स्वाइप करें।';

  @override
  String get lockSentence => 'शब्बात या ध्यान वाली रात के लिए फ़ोन को सिर्फ़ घड़ी और अलार्म तक सीमित करें।';

  @override
  String get lockExplain =>
      'लॉक रहते हुए Quando? सिर्फ़ समय, अगला अलार्म और लॉक कब खत्म होगा, दिखाता है। अलार्म काम करते रहते हैं और अनलॉक होने तक कुछ नहीं बदला जा सकता।';

  @override
  String get lockNowHeading => 'अभी लॉक करें';

  @override
  String get lockAutoHeading => 'अपने आप लॉक करें';

  @override
  String get shabbatAndFestivalsLong => 'शब्बात और त्योहार';

  @override
  String get fromCandleToHavdalah => 'मोमबत्ती जलाने से हवदाला तक';

  @override
  String get lockCalendarWord => 'इस शब्द वाले कैलेंडर इवेंट के दौरान';

  @override
  String get lockCalendarWordHint => 'जैसे लॉक, परीक्षा, फ़ोकस';

  @override
  String get leaveEmptyForNone => 'बंद रखने के लिए खाली छोड़ें';

  @override
  String get connectCalendarsFirst => 'पहले कैलेंडर जोड़ें (कैलेंडर आइकन)';

  @override
  String get openWhenLockStarts => 'लॉक शुरू होने पर Quando? खोलें';

  @override
  String get openWhenLockStartsHint => '1 सेकंड की धीमी आवाज़ Quando? को सामने लाती है ताकि वह लॉक कर सके';

  @override
  String get pinToScreen => 'Quando? को स्क्रीन पर पिन करें';

  @override
  String get pinToScreenHint => 'लॉक के दौरान दूसरे ऐप नहीं खुलते। Android पहली बार पुष्टि माँगता है।';

  @override
  String get noLocksComingUp => 'कोई लॉक आने वाला नहीं।';

  @override
  String get leaveLockEarly => 'जल्दी निकलने के लिए “अनलॉक के लिए दबाकर रखें” को 3 सेकंड दबाकर रखें।';

  @override
  String get locked => 'लॉक है';

  @override
  String get shabbatShalom => 'शब्बात शालोम';

  @override
  String get chagSameach => 'हग समेआख';

  @override
  String get unlocksHeading => 'अनलॉक होगा';

  @override
  String get nowCap => 'अभी';

  @override
  String get nextAlarm => 'अगला अलार्म';

  @override
  String get holdToUnlock => 'अनलॉक के लिए दबाकर रखें';

  @override
  String get lockSentenceCalm => 'फ़ोन को घड़ी और अलार्म तक लॉक करें: परीक्षा, मीटिंग या शांत शाम के लिए।';

  @override
  String get lockCalendarHeading => 'अपने कैलेंडर से';

  @override
  String get lockCalendarExplain =>
      'किसी इवेंट के दौरान, या एक इवेंट से आपके चुने अगले इवेंट तक लॉक करें। चुने गए हर कैलेंडर के साथ काम करता है, साझा वाले भी।';

  @override
  String get lockAddCalendar => 'कैलेंडर लॉक जोड़ें';

  @override
  String get lockEditCalendar => 'कैलेंडर लॉक';

  @override
  String get lockDuring => 'इवेंट के दौरान';

  @override
  String get lockBetween => 'दो इवेंट के बीच';

  @override
  String get lockStartsAt => 'इस नाम के इवेंट…';

  @override
  String get lockStartsAtBetween => 'इस नाम के इवेंट पर शुरू…';

  @override
  String get lockEndsAt => 'इस नाम के अगले इवेंट पर ख़त्म…';

  @override
  String get lockStartHint => 'जैसे परीक्षा, फ़ोकस, जिम';

  @override
  String get lockEndHint => 'जैसे घर पर';

  @override
  String get lockAnyCalendar => 'कोई भी कैलेंडर';

  @override
  String get lockNoMatches => 'अभी आपके कैलेंडर में कुछ मेल नहीं खाता।';

  @override
  String get lockNextTimes => 'अगली बार';

  @override
  String lockDuringTitle(String a) {
    return '“$a” के दौरान';
  }

  @override
  String lockBetweenTitle(String a, String b) {
    return '“$a” से अगले “$b” तक';
  }

  @override
  String lockShabbatCalendarFound(String name) {
    return '“$name” में शब्बात के समय हैं।';
  }

  @override
  String get lockShabbatFromCalendar => 'मोमबत्ती जलाने से हवदाला तक लॉक करें';

  @override
  String get lockShabbatFromCalendarHint => 'उस कैलेंडर के समय, लॉक स्क्रीन पर मोमबत्तियों के साथ।';

  @override
  String get lockMoreWays => 'लॉक करने के और तरीके';

  @override
  String get lockQuietTime => 'शांत समय';

  @override
  String nextCandleLightingFrom(String time, String name) {
    return 'अगली मोमबत्ती: $time, $name से';
  }

  @override
  String get calendarAlarm => 'कैलेंडर अलार्म';

  @override
  String get connectCalendars => 'कैलेंडर जोड़ें';

  @override
  String get calendarAlarmsHeading => 'कैलेंडर अलार्म';

  @override
  String get calendarNoneYet => 'अभी कोई नहीं। इससे शुरू करें, फिर जैसे चाहें बदलें:';

  @override
  String get fifteenBeforeEvery => 'हर इवेंट से 15 मिनट पहले';

  @override
  String get useTheseCalendarsHeading => 'ये कैलेंडर इस्तेमाल करें';

  @override
  String get noTimedEvents => 'इन कैलेंडर में समय वाले कोई आगामी इवेंट नहीं।';

  @override
  String get atTheStart => 'शुरुआत में';

  @override
  String everyForBefore(String every, String span) {
    return 'हर $every, $span पहले से';
  }

  @override
  String spanAfterItEnds(String span) {
    return 'खत्म होने के $span बाद';
  }

  @override
  String get noAlarmsChosen => 'कोई अलार्म नहीं चुना';

  @override
  String get gentleWakeUp => 'धीरे से जगाना';

  @override
  String gentleSummary(int minutes, String sound) {
    return '$minutes मि पहले · $sound';
  }

  @override
  String get off => 'बंद';

  @override
  String get gentleSentence =>
      'अलार्म से पहले एक शांत आवाज़ धीरे से शुरू होती है, ताकि आप कभी झटके से न जागें।';

  @override
  String get gentleExplain =>
      'यह धीरे-धीरे तेज़ होती है, आपको हल्की नींद से निकालती है और अलार्म बजने से ठीक पहले रुक जाती है।';

  @override
  String get startsBeforeHeading => 'अलार्म से पहले शुरू होता है';

  @override
  String get leadUpSoundHeading => 'शुरुआती आवाज़';

  @override
  String get listen => 'सुनें';

  @override
  String get whoRecordedThese => 'ये आवाज़ें किसने रिकॉर्ड कीं';

  @override
  String get done => 'हो गया';

  @override
  String get soundCredits => 'आवाज़ों का श्रेय';

  @override
  String yourTimeCity(String city) {
    return 'आपका समय ($city)';
  }

  @override
  String get anotherCity => 'दूसरा शहर…';

  @override
  String get ringingIn5 => '5 सेकंड में बजेगा…';

  @override
  String get alarmSaved => 'अलार्म सहेजा गया।';

  @override
  String alarmSetFor(String span) {
    return 'अलार्म $span में बजेगा।';
  }

  @override
  String hoursMinutesShort(int h, int m) {
    return '$h घं $m मि';
  }

  @override
  String get editAlarm => 'अलार्म बदलें';

  @override
  String get previewCaps => 'सुनें';

  @override
  String get saveCaps => 'सहेजें';

  @override
  String cityTimeForYou(String city, String time) {
    return '$city का समय · आपके लिए $time';
  }

  @override
  String repeatHeading(String repeat) {
    return 'दोहराएँ · $repeat';
  }

  @override
  String get labelField => 'लेबल (बोलने वाले अलार्म चालू हों तो ज़ोर से पढ़ा जाता है)';

  @override
  String get group => 'समूह';

  @override
  String ringsForHeading(String span) {
    return '$span तक बजता है';
  }

  @override
  String useDefault(String value) {
    return 'डिफ़ॉल्ट इस्तेमाल करें ($value)';
  }

  @override
  String get save => 'सहेजें';

  @override
  String get sameTime => 'वही समय';

  @override
  String get untilYouStopIt => 'जब तक आप रोकें नहीं';

  @override
  String get alarm => 'अलार्म';

  @override
  String get once => 'एक बार';

  @override
  String get everyDay => 'हर दिन';

  @override
  String get weekdays => 'कार्यदिवस';

  @override
  String get weekends => 'सप्ताहांत';

  @override
  String timeInCity(String time, String city) {
    return '$city समय से $time';
  }

  @override
  String eventsMatching(String words) {
    return '“$words” वाले इवेंट';
  }

  @override
  String get everyEvent => 'हर इवेंट';

  @override
  String get sunrise => 'सूर्योदय';

  @override
  String havdalahEndOf(String day) {
    return 'हवदाला · $day का अंत';
  }

  @override
  String get yomTov => 'योम तोव';

  @override
  String get shabbat => 'शब्बात';

  @override
  String get presetCountdown => 'मोमबत्ती जलाने की उलटी गिनती';

  @override
  String get presetHourly => 'हर घंटे, 6 घंटे पहले से';

  @override
  String get presetDailyWeek => 'दिन में एक बार, पिछले हफ़्ते में';

  @override
  String get presetSecondNight => 'दूसरी रात की मोमबत्तियाँ';

  @override
  String get presetFridayReminder => '3 घंटे पहले याद दिलाएँ: फ़ोन चार्ज करें';

  @override
  String get presetFridayReminderLabel => 'फ़ोन चार्ज करें और कल के अलार्म सेट करें';

  @override
  String get presetSunset => 'सूर्यास्त, और 15 मिनट पहले';

  @override
  String get pesach => 'पेसख';

  @override
  String get shavuot => 'शावुओत';

  @override
  String get roshHashanah => 'रोश हशाना';

  @override
  String get yomKippur => 'योम किप्पुर';

  @override
  String get sukkot => 'सुक्कोत';

  @override
  String get sheminiAtzeret => 'शमीनी अत्सेरेत';

  @override
  String get simchatTorah => 'सिमख़त तोरा';

  @override
  String get readyNotifications => 'अलार्म दिखाएँ';

  @override
  String get readyNotificationsWhy => 'अलार्म स्क्रीन और रोकें बटन दिखने देता है।';

  @override
  String get readyFullScreen => 'लॉक स्क्रीन के ऊपर बजाएँ';

  @override
  String get readyFullScreenWhy => 'फ़ोन लॉक होने पर भी अलार्म पूरी स्क्रीन पर दिखाता है।';

  @override
  String get readyExact => 'ठीक मिनट पर बजाएँ';

  @override
  String get readyExactWhy => 'इसके बिना फ़ोन अलार्म को कुछ मिनट देर से बजा सकता है।';

  @override
  String get readyBattery => 'बैटरी सेवर में भी चलता रहे';

  @override
  String get readyBatteryWhy => 'बैटरी सेवर को रात में अलार्म चुप कराने से रोकता है।';

  @override
  String get tipXiaomi =>
      'Xiaomi फ़ोन: सेटिंग्स › ऐप्स › Quando? में ऑटोस्टार्ट चालू करें और बैटरी सेवर को कोई प्रतिबंध नहीं पर रखें।';

  @override
  String get tipSamsung =>
      'Samsung फ़ोन: सेटिंग्स › बैटरी › बैकग्राउंड उपयोग सीमा में देखें कि Quando? स्लीप में न हो।';

  @override
  String get tipHuawei =>
      'Huawei और Honor फ़ोन: सेटिंग्स › बैटरी › ऐप लॉन्च में Quando? को मैन्युअल रूप से प्रबंधित करें पर रखें और सब कुछ अनुमति दें।';

  @override
  String get tipOther =>
      'इस फ़ोन पर: सेटिंग्स › बैटरी में Quando? को बैकग्राउंड में चलने दें और ऑप्टिमाइज़ेशन बंद करें।';

  @override
  String get testRing => 'टेस्ट रिंग';

  @override
  String get testRingBody => 'Quando? आपको जगा सकता है';

  @override
  String get ringsIn20 => '20 सेकंड में बजेगा। अभी फ़ोन लॉक करें और इंतज़ार करें।';

  @override
  String get readyToRing => 'बजने के लिए तैयार';

  @override
  String get checkingPhone => 'आपका फ़ोन जाँचा जा रहा है…';

  @override
  String get phoneReady => 'आपका फ़ोन हर अलार्म समय पर बजाने के लिए तैयार है।';

  @override
  String thingsNeedFixing(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n चीज़ें ठीक करनी हैं, वरना अलार्म शायद न बजें।',
      one: '1 चीज़ ठीक करनी है, वरना अलार्म शायद न बजें।',
    );
    return '$_temp0';
  }

  @override
  String get fix => 'ठीक करें';

  @override
  String get testIn20 => 'टेस्ट: 20 सेकंड में बजेगा';

  @override
  String get testIn20Hint => 'फ़ोन लॉक करके रख दें। अगर अलार्म पूरी स्क्रीन पर बजे, तो सब तैयार है।';

  @override
  String get readyToRingHint => 'जाँचें कि आपका फ़ोन हर अलार्म समय पर बजाता है';

  @override
  String get connections => 'कनेक्शन';

  @override
  String get timeZoneHeading => 'टाइम ज़ोन';

  @override
  String get followPhone => 'फ़ोन के अनुसार';

  @override
  String followPhoneNow(String city) {
    return 'अभी $city। यात्रा करने पर खुद बदलता है।';
  }

  @override
  String get zoneFixed => 'तय। यात्रा में भी अलार्म यही समय रखते हैं।';

  @override
  String get shabbatCityHeading => 'शब्बात के लिए शहर';

  @override
  String get inIsraelOneDay => 'इज़राइल में (त्योहार का एक दिन)';

  @override
  String candleMinutesHeading(int n) {
    return 'मोमबत्तियाँ: सूर्यास्त से $n मिनट पहले';
  }

  @override
  String get endOfShabbatHeading => 'शब्बात और त्योहारों का अंत';

  @override
  String get nightfallGeonim => 'तारे निकलना (गेओनीम, 8.5°)';

  @override
  String get rabbeinuTam => 'सूर्यास्त के 72 मिनट बाद (रब्बेनु ताम)';

  @override
  String get whenAlarmRingsHeading => 'जब अलार्म बजता है';

  @override
  String get recordOrAddSounds => 'आवाज़ें रिकॉर्ड करें या जोड़ें';

  @override
  String get ringsForThisLong => 'इतनी देर बजता है, फिर खुद रुक जाता है';

  @override
  String get sameFades => 'सभी अलार्म के लिए एक जैसा फ़ेड';

  @override
  String get sameFadesOn => 'हर अलार्म का फ़ेड बदल देता है। हर अलार्म अपनी आवाज़ रखता है।';

  @override
  String get sameFadesOff => 'बंद: हर अलार्म अपने वॉल्यूम में सेट फ़ेड इस्तेमाल करता है।';

  @override
  String get sayItOutLoud => 'ज़ोर से बोलें';

  @override
  String get sayItOutLoudHint => 'बताता है कि अलार्म किसलिए है, जैसे “मोमबत्ती जलाना, 15 मिनट पहले”';

  @override
  String get noSnooze => 'स्नूज़ नहीं';

  @override
  String snoozeUpTo(int times, int minutes) {
    return '$minutes मि के लिए $times× तक स्नूज़';
  }

  @override
  String get wakeUpCheck => 'जागने की जाँच';

  @override
  String get wakeUpCheckHint => 'रोकने के बाद, अगर आप “मैं जाग गया” पर टैप न करें तो 3 मिनट में फिर बजता है';

  @override
  String get solveSum => 'रोकने के लिए सवाल हल करें';

  @override
  String get provesAwake => 'साबित करता है कि आप जागे हैं';

  @override
  String get shabbatNoTasks =>
      'शब्बात और त्योहारों पर इनमें से कुछ लागू नहीं होता: अलार्म खुद रुकते हैं और कभी फ़ोन छूने को नहीं कहते।';

  @override
  String get testAlarmIn1 => '1 मिनट में टेस्ट अलार्म बजाएँ';

  @override
  String get timesDisclaimer =>
      'समय फ़ोन पर गिने जाते हैं। संदेह की स्थिति में अपने रब्बी से पूछें या समुदाय का कैलेंडर देखें।';

  @override
  String get recommended => 'सुझाया गया';

  @override
  String get chooseCity => 'शहर चुनें';

  @override
  String get testOnlyOnPhone => 'टेस्ट अलार्म सिर्फ़ फ़ोन पर काम करते हैं।';

  @override
  String get testAlarm => 'टेस्ट अलार्म';

  @override
  String get testAlarmBody => 'आपके अलार्म ऐसे बजेंगे';

  @override
  String get testAlarmIn1Set => 'टेस्ट अलार्म 1 मिनट में। आप फ़ोन लॉक कर सकते हैं।';

  @override
  String get presetGone => 'यह टेम्पलेट अब मौजूद नहीं है।';

  @override
  String get editPreset => 'टेम्पलेट बदलें';

  @override
  String get on => 'चालू';

  @override
  String get ringsHeading => 'बजता है';

  @override
  String get noTimesYet => 'अभी कोई समय नहीं। नीचे जोड़ें।';

  @override
  String get atTheMomentItself => 'ठीक उसी पल';

  @override
  String get remove => 'हटाएँ';

  @override
  String get addATime => 'समय जोड़ें';

  @override
  String get resetPreset => 'मूल पर वापस लाएँ';

  @override
  String get skipOneHint =>
      'एक अलार्म छोड़ने के लिए होम स्क्रीन पर “इस हफ़्ते के अलार्म” में उस पर टैप करें।';

  @override
  String get unitMinutes => 'मिनट';

  @override
  String get unitHours => 'घंटे';

  @override
  String get unitDays => 'दिन';

  @override
  String get before => 'पहले';

  @override
  String get after => 'बाद';

  @override
  String get oneWeek => '1 हफ़्ता';

  @override
  String daysShort(int n) {
    return '$n दि';
  }

  @override
  String hoursShort(int n) {
    return '$n घं';
  }

  @override
  String get howToSearch => 'कैसे खोजें';

  @override
  String get searchHelpWord => 'शीर्षक में “dentist” हो, बड़े-छोटे अक्षर कोई भी';

  @override
  String get searchHelpStar => '* मतलब कोई भी अक्षर: dentist, dentures';

  @override
  String get searchHelpQuestion => '? मतलब एक अक्षर: yoga, toga';

  @override
  String get searchHelpPhrase => 'ठीक यही वाक्यांश';

  @override
  String get searchHelpAnd => 'दोनों शब्द (AND)';

  @override
  String get searchHelpOr => 'कोई एक। | भी चलता है';

  @override
  String get searchHelpNot => 'बाहर रखें। NOT और ! भी चलते हैं';

  @override
  String get searchHelpBrackets => 'कोष्ठक शब्दों को समूह बनाते हैं';

  @override
  String get searchHelpEmpty => 'हर इवेंट पर बजाने के लिए खाली छोड़ें।';

  @override
  String get customTime => 'दूसरा समय';

  @override
  String get other => 'अन्य';

  @override
  String get sun => 'सूरज';

  @override
  String get calendar => 'कैलेंडर';

  @override
  String get newEventAlarm => 'नया इवेंट अलार्म';

  @override
  String get eventAlarm => 'इवेंट अलार्म';

  @override
  String get findEventsHeading => 'इवेंट खोजें';

  @override
  String get searchEventsHint => 'खोजें: डेंटिस्ट, जिम OR योग, डेंट*…';

  @override
  String get alsoBuiltInTimes => 'शब्बात, त्योहार और सूरज के समय भी';

  @override
  String get alsoBuiltInTimesHint => 'जैसे “मोम*”, “हवदाला”, “सूर्यास्त”';

  @override
  String get allMyCalendars => 'मेरे सभी कैलेंडर';

  @override
  String get connectToSearch => 'उनमें खोजने के लिए कैलेंडर जोड़ें';

  @override
  String get searching => 'खोज रहे हैं…';

  @override
  String get nothingMatches60 => 'अगले 60 दिनों में कुछ नहीं मिला';

  @override
  String eventsIn60(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'अगले 60 दिनों में $n इवेंट',
      one: 'अगले 60 दिनों में 1 इवेंट',
    );
    return '$_temp0';
  }

  @override
  String nextRingsAt(String times, String title) {
    return 'अगला: “$title” के लिए $times पर बजेगा';
  }

  @override
  String showMoreLeft(int n) {
    return 'और दिखाएँ ($n बाकी)';
  }

  @override
  String get ringBeforeStartsHeading => 'शुरू होने से पहले बजाएँ';

  @override
  String get ringWhenStarts => 'शुरू होने पर बजाएँ';

  @override
  String get repeatBeforeHeading => 'और पहले दोहराएँ';

  @override
  String get everyPrefix => 'हर ';

  @override
  String get offLower => 'बंद';

  @override
  String get forInfix => '  तक ';

  @override
  String get ringAfterEndsHeading => 'खत्म होने के बाद बजाएँ';

  @override
  String get nameOptional => 'नाम (वैकल्पिक)';

  @override
  String get toppedUp => 'अलार्म अगले 7 दिनों के लिए सेट हैं और हर बार Quando? खोलने पर भर दिए जाते हैं।';

  @override
  String get back => 'पीछे';

  @override
  String get next => 'आगे';

  @override
  String get stepWhichEvents => 'कौन से इवेंट';

  @override
  String get stepWhenToRing => 'कब बजाएँ';

  @override
  String get stepHowItRings => 'कैसे बजे';

  @override
  String defaultNamed(String name) {
    return 'डिफ़ॉल्ट ($name)';
  }

  @override
  String get phoneAlarmSound => 'फ़ोन की अलार्म आवाज़';

  @override
  String get onlineRadio => 'ऑनलाइन रेडियो';

  @override
  String songLinkOpens(String app) {
    return 'गाने का लिंक · $app खोलता है';
  }

  @override
  String get builtIn => 'बिल्ट-इन';

  @override
  String get yourRecording => 'आपकी रिकॉर्डिंग';

  @override
  String get sound => 'आवाज़';

  @override
  String get wakeToOwnSound => 'अपनी आवाज़ से जागें';

  @override
  String get wakeToOwnSoundHint => 'आपकी आवाज़, कोई गाना, Spotify या लाइव रेडियो';

  @override
  String musicAdded(String name) {
    return '$name जोड़ा गया। इसे किसी भी अलार्म की आवाज़ चुनें।';
  }

  @override
  String get playlists => 'प्लेलिस्ट';

  @override
  String get likedSongs => 'पसंद किए गाने';

  @override
  String get noPlaylists => 'अभी कोई प्लेलिस्ट नहीं।';

  @override
  String get noLikedSongs => 'अभी कोई पसंद किया गाना नहीं।';

  @override
  String get needsMic => 'रिकॉर्ड करने के लिए Quando? को माइक्रोफ़ोन चाहिए।';

  @override
  String recordingN(int n) {
    return 'रिकॉर्डिंग $n';
  }

  @override
  String couldNotAddFile(String error) {
    return 'वह फ़ाइल नहीं जुड़ सकी: $error';
  }

  @override
  String get addSongLink => 'गाने का लिंक जोड़ें';

  @override
  String get songLink => 'गाने का लिंक';

  @override
  String get songLinkHowTo =>
      'Spotify, Apple Music, YouTube, YouTube Music या SoundCloud में शेयर पर, फिर लिंक कॉपी करें पर टैप करें और यहाँ पेस्ट करें।';

  @override
  String get songNameHint => 'नाम, जैसे सुबह की प्लेलिस्ट';

  @override
  String get whenAlarmGoesOffHeading => 'जब अलार्म बजे';

  @override
  String get playTheSong => 'गाना चलाएँ';

  @override
  String get ringThenOpen => 'बजाएँ, फिर खोलें';

  @override
  String get playTheSongHint =>
      'उसका ऐप खुलकर उसे चलाता है। 10 सेकंड चुप रहे तो बैकअप आवाज़ बजती है, ताकि आप हमेशा जागें। काम वाले अलार्म पहले बजते हैं, फिर इसे खोलते हैं।';

  @override
  String get ringThenOpenHint => 'बैकअप आवाज़ बजती है। रोकें गाने को उसके ऐप में खोलता है।';

  @override
  String get playForHeading => 'चलाने की अवधि';

  @override
  String get pausesAfter => 'Quando? इतनी देर बाद फ़ोन के पॉज़ बटन से गाना रोक देता है।';

  @override
  String get backupSoundHeading => 'बैकअप आवाज़';

  @override
  String get notALink => 'यह लिंक जैसा नहीं लगता।';

  @override
  String songOn(String app) {
    return '$app पर गाना';
  }

  @override
  String get theWeb => 'वेब';

  @override
  String get pickFromYouTube => 'मेरे YouTube से चुनें';

  @override
  String get youTubeAndMusic => 'YouTube और YouTube Music';

  @override
  String get youTubeOn => 'जुड़ा है · साइन आउट के लिए दबाकर रखें';

  @override
  String get youTubeSignIn => 'Google से साइन इन करें';

  @override
  String get addSongLinkInstead => 'इसके बजाय गाने का लिंक जोड़ें।';

  @override
  String get googleSignInFailed => 'Google साइन इन पूरा नहीं हुआ। फिर से कोशिश करें।';

  @override
  String get myYouTube => 'मेरा YouTube';

  @override
  String get spotifyDirectOn => 'Spotify सीधा प्लेबैक चालू';

  @override
  String get spotifyDirect => 'Spotify सीधा प्लेबैक';

  @override
  String get spotifyDirectOnHint => 'चालू · बंद करने के लिए टैप करें';

  @override
  String get spotifyDirectHint => 'वही गाना बजाता है। Premium ज़रूरी।';

  @override
  String get spotifyComingSoon => 'जल्द आ रहा है · Premium ज़रूरी';

  @override
  String get spotifyFailed =>
      'Spotify नहीं जुड़ा। देखें कि Spotify ऐप इंस्टॉल है, आप साइन इन हैं और Premium है।';

  @override
  String get nameThisSound => 'इस आवाज़ को नाम दें';

  @override
  String get sounds => 'आवाज़ें';

  @override
  String get soundsSentence => 'अपनी आवाज़, किसी गाने, प्लेलिस्ट या लाइव रेडियो से जागें।';

  @override
  String stopTimer(String time) {
    return 'रोकें · $time';
  }

  @override
  String get record => 'रिकॉर्ड करें';

  @override
  String get addAFile => 'फ़ाइल जोड़ें';

  @override
  String get addSongLinkLong => 'गाने का लिंक जोड़ें (Spotify, Apple Music, YouTube…)';

  @override
  String get musicAppsHeading => 'म्यूज़िक ऐप';

  @override
  String get pickFromSpotify => 'मेरे Spotify से चुनें';

  @override
  String get yourPlaylistsAndLiked => 'आपकी प्लेलिस्ट और पसंद किए गाने';

  @override
  String get mySpotify => 'मेरा Spotify';

  @override
  String get spotifySignInFailed => 'Spotify में साइन इन नहीं हो सका।';

  @override
  String get appleMusicNote => 'साइन इन iPhone संस्करण के साथ आएगा। अभी के लिए गाने का लिंक जोड़ें।';

  @override
  String noSignInNote(String service) {
    return '$service दूसरे ऐप को साइन इन नहीं करने देता। इसके बजाय गाने का लिंक जोड़ें।';
  }

  @override
  String get wakeToRadio => 'ऑनलाइन रेडियो से जागें';

  @override
  String get soundsExplain =>
      '5 मिनट तक रिकॉर्ड करें, फ़ाइल, गाने का लिंक या लाइव रेडियो जोड़ें। कुछ गड़बड़ हो तो बैकअप ध्वनि बजती है।';

  @override
  String get yourSoundsHeading => 'आपकी आवाज़ें';

  @override
  String playsIn(String app) {
    return '$app में चलता है';
  }

  @override
  String opensIn(String app) {
    return '$app में खुलता है';
  }

  @override
  String forSpan(String span) {
    return '$span तक';
  }

  @override
  String get defaultLabel => 'डिफ़ॉल्ट';

  @override
  String get radioUnreachable => 'स्टेशन सूची तक नहीं पहुँच सके। अपना कनेक्शन जाँचें।';

  @override
  String get addStreamAddress => 'स्ट्रीम पता जोड़ें';

  @override
  String get notAStream => 'यह स्ट्रीम पता नहीं लगता (http से शुरू होता है)।';

  @override
  String get anyGenre => 'कोई भी शैली';

  @override
  String get stationName => 'स्टेशन का नाम';

  @override
  String get closeSearch => 'खोज बंद करें';

  @override
  String get searchByName => 'नाम से खोजें';

  @override
  String get anywhere => 'कहीं भी';

  @override
  String get noStations => 'कोई स्टेशन नहीं मिला। दूसरी शैली या देश आज़माएँ।';

  @override
  String wakeUpTo(String name) {
    return '$name से जागें';
  }

  @override
  String get notQuite => 'लगभग। फिर कोशिश करें।';

  @override
  String shabbatStopsItself(int n) {
    return 'शब्बात मोड: $n सेकंड में खुद रुक जाएगा। फ़ोन छूने की ज़रूरत नहीं।';
  }

  @override
  String get solveToSnooze => 'स्नूज़ के लिए हल करें';

  @override
  String get solveToStop => 'रोकने के लिए हल करें';

  @override
  String get answer => 'जवाब';

  @override
  String get snooze => 'स्नूज़';

  @override
  String get stop => 'रोकें';

  @override
  String get shakeToSnooze => 'स्नूज़ के लिए हिलाएँ';

  @override
  String get shakeToStop => 'रोकने के लिए हिलाएँ';

  @override
  String get shakeHard => 'बार भरने तक फ़ोन ज़ोर से हिलाएँ।';

  @override
  String get cantShake => 'हिला नहीं सकते? सवाल हल करें';

  @override
  String get pairsToSnooze => 'स्नूज़ के लिए जोड़े मिलाएँ';

  @override
  String get pairsToStop => 'रोकने के लिए जोड़े मिलाएँ';

  @override
  String get typeToSnooze => 'स्नूज़ के लिए यह लिखें';

  @override
  String get typeToStop => 'रोकने के लिए यह लिखें';

  @override
  String get scanToSnooze => 'स्नूज़ के लिए अपना कोड स्कैन करें';

  @override
  String get scanToStop => 'रोकने के लिए अपना कोड स्कैन करें';

  @override
  String ringAgainUnless(int n) {
    return 'अगर आप नीचे टैप नहीं करते तो मैं $n मिनट में फिर बजूँगा।';
  }

  @override
  String get imUp => 'मैं जाग गया';

  @override
  String snoozeMin(int n) {
    return '$n मि स्नूज़';
  }

  @override
  String snoozeMinLeft(int n, int left) {
    return '$n मि स्नूज़ · $left बाकी';
  }

  @override
  String get noSnoozesLeft => 'कोई स्नूज़ बाकी नहीं';

  @override
  String get stopThenOpen => 'रोकें · फिर खोलें';

  @override
  String get startingSong => 'आपका गाना शुरू हो रहा है';

  @override
  String wayToStop(String way) {
    return 'रोकने के लिए $way';
  }

  @override
  String wayToSnooze(String way) {
    return 'स्नूज़ के लिए $way';
  }

  @override
  String ringsForMore(int n) {
    return '$n सेकंड और बजेगा';
  }

  @override
  String get leftToRing => 'बाकी';

  @override
  String get wayVolumeButtons => 'वॉल्यूम बटन';

  @override
  String get wayShake => 'फ़ोन हिलाएँ';

  @override
  String get taskNothing => 'कुछ नहीं';

  @override
  String get taskSum => 'सवाल हल करें';

  @override
  String get taskShake => '30 बार हिलाएँ';

  @override
  String get taskMemory => 'याददाश्त का खेल';

  @override
  String get taskPhrase => 'एक वाक्य लिखें';

  @override
  String get taskScan => 'कोड स्कैन करें';

  @override
  String get noLimit => 'कोई सीमा नहीं';

  @override
  String upToTimes(int n) {
    return '$n× तक';
  }

  @override
  String shorterEachTime(int n) {
    return 'हर बार $n मि कम';
  }

  @override
  String autoSnoozeAfter(int n) {
    return '$n मि बाद खुद स्नूज़';
  }

  @override
  String get card => 'कार्ड';

  @override
  String get hiddenCard => 'छिपा कार्ड';

  @override
  String get phrase1 => 'मैं जाग गया हूँ और यह दिन मेरा है';

  @override
  String get phrase2 => 'अभी नहीं तो कब';

  @override
  String get phrase3 => 'मुझे और मेरे सभी प्रियजनों को सुप्रभात';

  @override
  String get phrase4 => 'मेरे पैर ज़मीन पर हैं और मैं उठ गया हूँ';

  @override
  String get phrase5 => 'आज मैं नई शुरुआत करता हूँ';

  @override
  String get notQuiteWords => 'लगभग, हर शब्द जाँचें।';

  @override
  String get typeItHere => 'यहाँ लिखें';

  @override
  String get differentCode => 'यह अलग कोड है।';

  @override
  String get cameraUnavailable => 'कैमरा उपलब्ध नहीं है।';

  @override
  String get cantScan => 'स्कैन नहीं कर सकते? सवाल हल करें';

  @override
  String get saveCodeToScan => 'स्कैन के लिए कोड सहेजें';

  @override
  String get saveCodeHint =>
      'ऐसी जगह के बारकोड या QR कोड पर कैमरा रखें जहाँ चलकर जाना पड़े, जैसे रसोई में कोई डिब्बा या बाथरूम में टूथपेस्ट। अलार्म रोकने के लिए आप इसे फिर स्कैन करेंगे।';

  @override
  String get cameraUnavailableSettings => 'कैमरा उपलब्ध नहीं है। सेटिंग्स में कैमरा एक्सेस की अनुमति दें।';

  @override
  String gentleToGo(int n) {
    return 'धीरे से जगाना · $n मि बाकी';
  }

  @override
  String previewBody(String body) {
    return 'पूर्वावलोकन · $body';
  }

  @override
  String snoozedBody(String body) {
    return 'स्नूज़ किया: $body';
  }

  @override
  String get areYouUp => 'क्या आप जाग गए?';

  @override
  String get tapImUp => 'रोकने के लिए “मैं जाग गया” पर टैप करें';

  @override
  String get volume => 'वॉल्यूम';

  @override
  String get wakeCheckOn => 'जागने की जाँच चालू';

  @override
  String get stopsAtOnce => 'तुरंत रुकता है';

  @override
  String get ringsAgainIfNotUp => 'न उठें तो फिर बजता है';

  @override
  String get openAppAfter => 'बाद में ऐप खोलें';

  @override
  String get noTask => 'कोई काम नहीं';

  @override
  String get codeSaved => 'कोड सहेजा गया';

  @override
  String get tapToSaveDifferent => 'दूसरा सहेजने के लिए टैप करें';

  @override
  String get controlsHeading => 'नियंत्रण';

  @override
  String get onScreen => 'स्क्रीन पर';

  @override
  String get taskHeading => 'काम';

  @override
  String get none => 'कोई नहीं';

  @override
  String get snoozeSentence => 'पाँच मिनट और? चुनें कितनी देर, कितनी बार और क्या करना होगा।';

  @override
  String get settingsHeading => 'सेटिंग्स';

  @override
  String get snoozeTime => 'स्नूज़ समय';

  @override
  String get snoozeTimeHint => 'पहला स्नूज़ कितना लंबा हो';

  @override
  String get shortenSnoozes => 'बाद के स्नूज़ छोटे करें';

  @override
  String get shortenSnoozesHint => 'पहले के बाद हर स्नूज़ इतना छोटा होता है';

  @override
  String get autoSnooze => 'ऑटो स्नूज़';

  @override
  String get autoSnoozeHint => 'अगर आप न छुएँ तो इतनी देर बाद खुद स्नूज़ होता है';

  @override
  String get never => 'कभी नहीं';

  @override
  String get snoozeLimit => 'स्नूज़ सीमा';

  @override
  String get snoozeLimitHint => 'आप कितनी बार स्नूज़ कर सकते हैं';

  @override
  String get unlimited => 'असीमित';

  @override
  String get useSnoozeFromSettings => 'सेटिंग्स का स्नूज़ इस्तेमाल करें';

  @override
  String get stopSentence => 'आप अलार्म कैसे बंद करते हैं और पहले क्या करना होता है।';

  @override
  String get shabbatNoTask => 'शब्बात और त्योहारों पर अलार्म खुद रुकते हैं और कभी कोई काम नहीं माँगते।';

  @override
  String get volumeSentence => 'यह कितना तेज़ बजता है और कितनी नरमी से वहाँ पहुँचता है।';

  @override
  String get openAfterAlarm => 'अलार्म के बाद खोलें';

  @override
  String get pickAnApp => 'ऐप चुनें';

  @override
  String get orPasteLink => 'या लिंक पेस्ट करें: https://…';

  @override
  String get useThisLink => 'यह लिंक इस्तेमाल करें';

  @override
  String get noAppsFound => 'कोई ऐप नहीं मिला।';

  @override
  String get weather => 'मौसम';

  @override
  String get news => 'समाचार';

  @override
  String get usePhoneVolume => 'फ़ोन का अलार्म वॉल्यूम इस्तेमाल करें';

  @override
  String get setsPhoneVolume => 'बजते समय फ़ोन का अलार्म वॉल्यूम सेट करता है, फिर वापस कर देता है।';

  @override
  String get fadeInOff => 'फ़ेड इन बंद, तुरंत पूरी आवाज़';

  @override
  String fadeInOver(String span) {
    return '$span में तेज़ होता है';
  }

  @override
  String get fadeOutOff => 'फ़ेड आउट बंद';

  @override
  String fadeOutOver(String span) {
    return 'आखिरी $span में धीमा होता है';
  }

  @override
  String get fadesExplain =>
      'फ़ेड आउट तब होता है जब अलार्म खुद रुकता है। अगर फ़ेड बजने के समय से लंबे हों, तो दोनों छोटे हो जाते हैं।';

  @override
  String get soundSoftChime => 'हल्की घंटी';

  @override
  String get soundMorningRise => 'सुबह का उजाला';

  @override
  String get soundClassicBeep => 'क्लासिक बीप';

  @override
  String get calmCity => 'शांत शहर की सुबह';

  @override
  String get calmBirds => 'भोर के पंछी';

  @override
  String get calmWaves => 'किनारे की लहरें';

  @override
  String get calmRain => 'हल्की बारिश';

  @override
  String get calmStream => 'जंगल का झरना';

  @override
  String get calmWind => 'हल्की हवा';

  @override
  String get calmFire => 'चटकती आग';

  @override
  String get calmNight => 'गर्मी की रात';

  @override
  String get publicDomain => 'सार्वजनिक डोमेन';

  @override
  String get phoneVolume => 'फ़ोन वॉल्यूम';

  @override
  String fadesIn(String span) {
    return '$span में तेज़';
  }

  @override
  String fadesOut(String span) {
    return '$span में धीमा';
  }

  @override
  String get noFade => 'कोई फ़ेड नहीं';

  @override
  String minSecShort(int m, int s) {
    return '$m मि $s से';
  }

  @override
  String get happensRings => 'बजता है';

  @override
  String get happensStopped => 'आप इसे रोकते हैं';

  @override
  String get happensSnoozed => 'आप इसे स्नूज़ करते हैं';

  @override
  String get happensAutoStopped => 'खुद रुकता है';

  @override
  String get eventLower => 'इवेंट';

  @override
  String get appTest => 'Quando? टेस्ट';

  @override
  String get pushoverConnected => 'Pushover जुड़ा है';

  @override
  String get webhookConnected => 'वेबहुक जुड़ा है';

  @override
  String pushoverSaid(int code, String body) {
    return 'Pushover ने कहा $code: $body';
  }

  @override
  String couldNotReachPushover(String error) {
    return 'Pushover तक नहीं पहुँच सके ($error)';
  }

  @override
  String itAnswered(int code) {
    return 'जवाब: $code';
  }

  @override
  String couldNotReachIt(String error) {
    return 'नहीं पहुँच सके ($error)';
  }

  @override
  String get calendarNotAllowed => 'कैलेंडर एक्सेस की अनुमति नहीं मिली।';

  @override
  String get playlist => 'प्लेलिस्ट';

  @override
  String songCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n गाने', one: '1 गाना');
    return '$_temp0';
  }

  @override
  String get spotifySaidNo =>
      'Spotify ने मना किया। Spotify डैशबोर्ड में Quando? के लिए Web API चुनें और User Management में अपना खाता जोड़ें।';

  @override
  String serviceDidntAnswer(String service, int code) {
    return '$service ने जवाब नहीं दिया ($code)।';
  }

  @override
  String get youTubeSaidNo =>
      'YouTube ने मना किया। देखें कि आपका Google खाता Quando प्रोजेक्ट का टेस्ट यूज़र है।';

  @override
  String get event => 'इवेंट';

  @override
  String eventEnds(String title) {
    return '$title (अंत)';
  }

  @override
  String foundSoundsDevices(int s, int d) {
    return '$s आवाज़ें और $d डिवाइस मिले।';
  }

  @override
  String get sentCheckDevices => 'भेजा गया। अपने दूसरे डिवाइस देखें।';

  @override
  String sentTo(String name) {
    return '$name को भेजा गया।';
  }

  @override
  String get zapierHowTo =>
      'Zapier में “Webhooks by Zapier → Catch Hook” से शुरू होने वाला Zap बनाएँ, फिर उसका URL यहाँ पेस्ट करें।';

  @override
  String get catchHookUrl => 'Catch Hook URL';

  @override
  String get iftttHowTo =>
      'IFTTT में “Webhooks → Receive a web request with a JSON payload” से शुरू होने वाला एप्लेट बनाएँ। यहाँ वही इवेंट नाम इस्तेमाल करें। आपकी कुंजी ifttt.com/maker_webhooks/settings पर है।';

  @override
  String get eventName => 'इवेंट नाम';

  @override
  String get webhooksKey => 'Webhooks कुंजी';

  @override
  String get webhookHowTo => 'Quando? इस पते पर JSON POST भेजता है।';

  @override
  String get connectionsSentence => 'जब अलार्म बजे, रुके या स्नूज़ हो, तो दूसरे ऐप और डिवाइस को बताएँ।';

  @override
  String get pushWhenRings => 'अलार्म बजने पर सूचना भेजें';

  @override
  String get pushWhenRingsHint => 'आपके दूसरे फ़ोन, टैबलेट, घड़ी या कंप्यूटर पर';

  @override
  String get yourUserKey => 'आपकी यूज़र कुंजी';

  @override
  String get appToken => 'ऐप टोकन';

  @override
  String get soundAndDevicesHeading => 'आवाज़ और डिवाइस';

  @override
  String get loading => 'लोड हो रहा है…';

  @override
  String get loadFromPushover => 'Pushover से लोड करें';

  @override
  String get soundItPlays => 'बजने वाली आवाज़';

  @override
  String get myPushoverDefault => 'मेरा Pushover डिफ़ॉल्ट';

  @override
  String get pushoverOwnSounds =>
      'आपकी अपनी आवाज़ें pushover.net/sounds पर अपलोड करने के बाद यहाँ दिखती हैं।';

  @override
  String get allMyDevices => 'मेरे सभी डिवाइस';

  @override
  String get pushoverOnThisPhone =>
      'इस फ़ोन पर भी Pushover ऐप इंस्टॉल करें, यह यहाँ आपकी Pushover आवाज़ से बजेगा।';

  @override
  String get priority => 'प्राथमिकता';

  @override
  String get priorityNormal => 'सामान्य';

  @override
  String get priorityHigh => 'ऊँची: शांत घंटों को अनदेखा करती है';

  @override
  String get priorityEmergency => 'आपातकालीन: पुष्टि होने तक दोहराती है';

  @override
  String get sending => 'भेज रहे हैं…';

  @override
  String get sendATest => 'टेस्ट भेजें';

  @override
  String get findUserKey => 'मेरी यूज़र कुंजी खोजें';

  @override
  String get makeAppToken => 'ऐप टोकन बनाएँ';

  @override
  String get webhooksHeading => 'ZAPIER, IFTTT और वेबहुक';

  @override
  String get webhooksExplain =>
      'अलार्म बजने या रोकने पर कुछ भी शुरू करें: लाइट जलाएँ, जागने का समय दर्ज करें, किसी को मैसेज करें।';

  @override
  String get sendWhenAlarm => 'भेजें जब अलार्म:';

  @override
  String get pauseOnShabbat => 'शब्बात और त्योहारों पर रोकें';

  @override
  String get pauseOnShabbatHint => 'मोमबत्ती जलाने और हवदाला के बीच के अलार्म के लिए कुछ नहीं भेजा जाता';

  @override
  String get webhookPayloadNote =>
      'हर संदेश में होता है: event (ring, stopped, snoozed, auto_stopped), title, body, time, shabbat और snoozes। कुंजियाँ इसी फ़ोन पर रहती हैं।';

  @override
  String get today => 'आज';

  @override
  String get tomorrow => 'कल';

  @override
  String get notAWebAddress => 'यह https:// से शुरू होने वाला वेब पता नहीं लगता';

  @override
  String get language => 'भाषा';

  @override
  String get phoneLanguage => 'फ़ोन की भाषा';

  @override
  String get ringQuote => 'अगर अभी नहीं, तो कब?';

  @override
  String get ringQuoteBy => 'हिलेल';

  @override
  String get quotesTitle => 'समय पर उद्धरण';

  @override
  String get quotesHint =>
      'चुनें कि वे कहाँ से आएँ। दिन के हर हिस्से के लिए एक; दूसरा देखने के लिए उद्धरण पर टैप करें।';

  @override
  String get quotesOff => 'बंद';

  @override
  String get quoteSongs => 'गाने';

  @override
  String get quoteMovies => 'फ़िल्में';

  @override
  String get quoteLiterature => 'किताबें और कविताएँ';

  @override
  String get quoteTanakh => 'तनख़ (हिब्रू बाइबिल)';

  @override
  String get quoteSages => 'तलमूद और विद्वान';

  @override
  String get quoteSpeeches => 'प्रसिद्ध भाषण';

  @override
  String get quotePhilosophy => 'दार्शनिक';

  @override
  String get quoteProverbs => 'कहावतें और सूक्तियाँ';

  @override
  String get quotesAlso => 'यह भी दिखाएँ';

  @override
  String get quoteCarnaval => 'कार्निवल';

  @override
  String get quoteCarnavalHint => 'ब्राज़ील के कार्निवल के दौरान गाने और कहावतें';

  @override
  String get quoteNearMe => 'मेरे पास';

  @override
  String get quoteNearMeHint => 'आप जहाँ हैं वहाँ के कवि और दिन, आपके समय क्षेत्र और शब्बात शहर से';

  @override
  String get quoteSiddur => 'सिद्दूर (प्रार्थना पुस्तक)';

  @override
  String weeklyParasha(String name) {
    return 'पराशा $name';
  }

  @override
  String poweredBy(String name) {
    return '$name द्वारा संचालित';
  }

  @override
  String get syncTitle => 'मेरे डिवाइस सिंक करें';

  @override
  String get syncHint => 'अलार्म और सेटिंग सभी डिवाइस पर एक जैसी रखने के लिए Google से साइन इन करें।';

  @override
  String syncOn(String email) {
    return 'On · $email';
  }

  @override
  String get syncWorking => 'Connecting…';

  @override
  String get syncNotAllowed => 'This Google account can\'t sync.';

  @override
  String get syncFailed => 'कनेक्ट नहीं हो सका। दोबारा कोशिश करने के लिए टैप करें।';

  @override
  String get syncStop => 'Stop syncing';

  @override
  String get syncNotSetUp => 'इस वर्शन में सिंक अभी सेट नहीं है।';

  @override
  String get ringTheseAfterAll => 'फिर भी बजाएँ';

  @override
  String skipTheseDay(int n) {
    return 'आज ये $n छोड़ें';
  }

  @override
  String turnOffNamed(String name) {
    return '“$name” बंद करें';
  }

  @override
  String turnOnNamed(String name) {
    return '“$name” चालू करें';
  }

  @override
  String turnedOffNamed(String name) {
    return '“$name” बंद किया गया';
  }

  @override
  String removeTimeFrom(String time, String name) {
    return '“$name” से “$time” हटाएँ';
  }

  @override
  String removedTimeFrom(String time, String name) {
    return '“$name” से “$time” हटाया गया';
  }

  @override
  String get moveToGroup => 'ग्रुप में ले जाएँ';

  @override
  String inGroupMove(String group) {
    return '“$group” में, ले जाएँ';
  }

  @override
  String movedToGroup(String group) {
    return '“$group” में ले जाया गया';
  }

  @override
  String deleteNamed(String name) {
    return '“$name” हटाएँ';
  }

  @override
  String get signInWithGoogle => 'Google से साइन इन करें';

  @override
  String get signOut => 'Sign out';

  @override
  String get signInWithEmail => 'ईमेल से साइन इन करें';

  @override
  String get signIn => 'Sign in';

  @override
  String get createAccount => 'खाता बनाएँ';

  @override
  String get haveAccount => 'मेरा खाता है';

  @override
  String get forgotPassword => 'पासवर्ड भूल गए?';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get passwordResetSent => 'हमने आपको नया पासवर्ड चुनने का लिंक भेजा है।';

  @override
  String emailCheckInbox(String email) {
    return 'हमने $email पर एक लिंक भेजा है। उसे खोलें, फिर वापस आकर “मैंने पुष्टि कर दी” पर टैप करें।';
  }

  @override
  String get emailConfirmed => 'मैंने पुष्टि कर दी';

  @override
  String get emailNotYet => 'अभी पुष्टि नहीं हुई। पहले ईमेल का लिंक खोलें।';

  @override
  String get emailSendAgain => 'ईमेल दोबारा भेजें';

  @override
  String get emailSentAgain => 'भेज दिया। अपना इनबॉक्स और स्पैम देखें।';

  @override
  String get emailInvalid => 'यह ईमेल पता नहीं लगता।';

  @override
  String get emailWrong => 'ईमेल या पासवर्ड गलत है।';

  @override
  String get emailInUse =>
      'इस ईमेल से खाता पहले से है। साइन इन करें, या अगर आपने Google से बनाया था तो Google इस्तेमाल करें।';

  @override
  String get passwordWeak => 'कम से कम 6 अक्षरों का पासवर्ड चुनें।';

  @override
  String get emailNotSwitchedOn => 'ईमेल से साइन-इन अभी चालू नहीं है।';

  @override
  String get tooManyTries => 'बहुत ज़्यादा कोशिशें। कुछ मिनट रुकें।';

  @override
  String get spotifyLibrary => 'Spotify';

  @override
  String get spotifyLibrarySignIn => 'प्लेलिस्ट, पसंद किए गाने और खोज';

  @override
  String get spotifyLibraryOn => 'जुड़ा है · साइन आउट के लिए दबाकर रखें';

  @override
  String spotifyLoginError(String reason) {
    return 'Spotify साइन-इन नहीं हुआ: $reason';
  }

  @override
  String googleSignInError(String reason) {
    return 'Google साइन-इन नहीं हुआ: $reason';
  }

  @override
  String get searchSongsHint => 'गाने, कलाकार, प्लेलिस्ट खोजें';

  @override
  String nothingFound(String query) {
    return '“$query” के लिए कुछ नहीं मिला।';
  }

  @override
  String get deliveryTitle => 'सूचना का तरीका';

  @override
  String get deliveryLocal => 'स्थानीय ऑडियो';

  @override
  String get deliveryBoth => 'दोनों';

  @override
  String get deliveryConnect => 'Pushover जोड़ें';

  @override
  String get deliveryLoadFailed => 'ध्वनियाँ और डिवाइस लोड नहीं हुए। फिर कोशिश करें।';

  @override
  String get deliveryBothHint => 'Pushover विफल होने पर भी स्थानीय ऑडियो बजता है।';

  @override
  String get deliveryPushHint => 'केवल Pushover। सूचना के समय यह डिवाइस ऑनलाइन होना चाहिए।';

  @override
  String get deliveryFallback => 'Pushover डिस्कनेक्ट या रुका होने पर स्थानीय ऑडियो बना रहता है।';

  @override
  String get deliveryReset => 'मौजूदा सेटिंग इस्तेमाल करें';

  @override
  String get beforeShabbat => 'शब्बात से पहले';

  @override
  String get preparationReminders => 'तैयारी के रिमाइंडर';

  @override
  String get skipThisWeek => 'इस हफ़्ते को छोड़ें';

  @override
  String get restoreThisWeek => 'इस हफ़्ते को वापस लाएँ';

  @override
  String get allAlarms => 'All alarms';

  @override
  String get timesAndSound => 'समय और आवाज़';

  @override
  String get changeCity => 'Change city';

  @override
  String get useMyLocation => 'मेरी लोकेशन इस्तेमाल करें';

  @override
  String get locationUnavailable => 'लोकेशन अभी उपलब्ध नहीं है। दोबारा कोशिश करें या कोई शहर चुनें।';

  @override
  String get locationReview => 'इस लोकेशन की पुष्टि करें';

  @override
  String get locationDeviceOnly =>
      'यह लोकेशन सिर्फ़ इसी डिवाइस पर सहेजी जाती है। ये समय इस्तेमाल करने से पहले टाइमज़ोन और इज़राइल सेटिंग जाँच लें।';

  @override
  String timesIn(String city, String zone) {
    return '$city · $zone · शहर का समय';
  }

  @override
  String get preparationOff => 'तैयारी के रिमाइंडर बंद हैं। हवदाला और सामान्य अलार्म नहीं बदलते।';

  @override
  String get preparationSkipped =>
      'इस हफ़्ते तैयारी के रिमाइंडर छोड़े गए हैं। आपकी साप्ताहिक सेटिंग सुरक्षित हैं।';

  @override
  String get shabbatControls => 'शब्बात नियंत्रण';

  @override
  String get duringAfterShabbat => 'शब्बात के दौरान / बाद';

  @override
  String locationCoordinates(String latitude, String longitude) {
    return 'अक्षांश $latitude · देशांतर $longitude';
  }

  @override
  String get currentLocation => 'मौजूदा लोकेशन';

  @override
  String get testPushoverSound => 'Pushover पर आवाज़ जाँचें';

  @override
  String get pushoverSoundTestHint =>
      'चुनी हुई आवाज़ आपके चुने हुए Pushover डिवाइस पर बजाता है। साइलेंट और शांत-घंटों की सेटिंग फिर भी लागू रहती हैं।';

  @override
  String get pushoverShareDevices => 'मेरे डिवाइस के साथ क्रेडेंशियल साझा करें';

  @override
  String get pushoverShareHint =>
      'आपकी Pushover यूज़र कुंजी और ऐप टोकन Quando? और Matai? में आपके साइन-इन खाते के साथ चल सकते हैं।';

  @override
  String get pushoverShareQueued => 'क्रेडेंशियल आपके साइन-इन डिवाइस के लिए कतार में हैं।';

  @override
  String get pushoverShareSignIn =>
      'Pushover क्रेडेंशियल साझा करने के लिए हर डिवाइस पर एक ही ऐप खाते से साइन इन करें।';

  @override
  String get smartHomeHeading => 'Smart home';

  @override
  String get smartHomeHint => 'Tuya सीन सीधे चलाएँ, या अपने Home Assistant या Node-RED ऑटोमेशन जोड़ें।';

  @override
  String get shareServices => 'सेवा कनेक्शन साझा करें';

  @override
  String get shareServicesHint =>
      'Pushover, Tuya, Spotify लाइब्रेरी और ऑटोमेशन कनेक्शन साझा करने के लिए अपने डिवाइस पर एक ही ऐप खाता इस्तेमाल करें। YouTube और डिवाइस अनुमतियों के लिए हर डिवाइस पर फिर भी मंज़ूरी चाहिए हो सकती है।';

  @override
  String get tuyaSetupHint =>
      'अपना लिंक किया हुआ Tuya डेवलपर प्रोजेक्ट इस्तेमाल करें। उसका डेटा सेंटर, Access ID, Access Secret और “Link App Account” में दिखने वाला UID डालें। Home Assistant की ज़रूरत नहीं।';

  @override
  String get tuyaDataCenter => 'Data center';

  @override
  String get tuyaUserId => 'लिंक किए खाते का UID';

  @override
  String get tuyaAccessId => 'Access ID / Client ID';

  @override
  String get tuyaAccessSecret => 'Access Secret / Client Secret';

  @override
  String get tuyaLoadScenes => 'Load scenes';

  @override
  String get tuyaNoScenes =>
      'कोई उपलब्ध Tap-to-Run सीन नहीं मिला। लिंक किया खाता, डेटा सेंटर और सीन API अनुमतियाँ जाँचें।';

  @override
  String get tuyaRunNow => 'सीन अभी चलाएँ';

  @override
  String get tuyaRunConfirm => 'क्या यह सीन अभी आपके Tuya डिवाइस पर चलाएँ?';

  @override
  String get tuyaSent => 'Tuya ने सीन कमांड स्वीकार कर ली। अपने डिवाइस जाँचें।';

  @override
  String get tuyaFailed =>
      'Tuya अनुरोध पूरा नहीं कर सका। प्रोजेक्ट अनुमतियाँ, डेटा सेंटर और सदस्यता जाँचें। त्रुटि:';

  @override
  String get tuyaAlarmScene => 'यह अलार्म बजने पर Tuya सीन';

  @override
  String get homeAssistantHowTo =>
      'Webhook ट्रिगर वाला Home Assistant ऑटोमेशन बनाएँ जो POST और JSON स्वीकार करे। उसका URL यहाँ चिपकाएँ। अपनी कार्रवाइयाँ चुनने के लिए अलार्म इवेंट (ring, stopped, snoozed या auto_stopped) इस्तेमाल करें। नए डिवाइस को यह कनेक्शन बंद मिलता है।';

  @override
  String get nodeRedHowTo =>
      'POST स्वीकार करने वाला Node-RED HTTP In नोड इस्तेमाल करें, फिर आपका ऑटोमेशन और एक HTTP Response नोड। एंडपॉइंट यहाँ चिपकाएँ। लोकल HTTP हब और HTTPS एंडपॉइंट समर्थित हैं।';

  @override
  String get smartHomeConnect => 'स्मार्ट-होम सेवा जोड़ें';

  @override
  String get automationTestHint => 'टेस्ट करने पर जुड़ा हुआ ऑटोमेशन तुरंत चलता है।';

  @override
  String get smartHomeDeviceOn => 'इस डिवाइस पर स्मार्ट-होम अलार्म कार्रवाइयाँ चलाएँ';

  @override
  String get smartHomeDeviceHint =>
      'अपने ऑटोमेशन चलाने के लिए एक डिवाइस चुनें। कनेक्शन साझा हैं; यह स्विच सिर्फ़ इसी डिवाइस पर रहता है।';

  @override
  String get smartHomeDeviceOff =>
      'इस डिवाइस पर अलार्म कार्रवाइयाँ बंद हैं। उन्हें कनेक्शन में चालू करें; मैनुअल सीन टेस्ट फिर भी काम करते हैं।';

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
  String get weatherSwipeHint => 'आकाश और मौसम के बीच स्वाइप करें';

  @override
  String get parashaHeading => 'साप्ताहिक पराशा';

  @override
  String get dailyStudyHeading => 'रोज़ का अध्ययन';

  @override
  String get courseDaf => 'Daf Yomi';

  @override
  String get courseRambam1 => 'रमबाम · रोज़ 1 अध्याय';

  @override
  String get courseRambam3 => 'रमबाम · रोज़ 3 अध्याय';

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
  String get moonAlwaysUp => 'चाँद पूरे दिन क्षितिज के ऊपर';

  @override
  String get moonAlwaysDown => 'चाँद पूरे दिन क्षितिज के नीचे';

  @override
  String get noRiseToday => 'आज उदय नहीं';

  @override
  String get noSetToday => 'No set today';

  @override
  String get moonNew => 'New moon';

  @override
  String get moonWaxingCrescent => 'बढ़ता हुआ अर्धचंद्र';

  @override
  String get moonFirstQuarter => 'पहली तिमाही';

  @override
  String get moonWaxingGibbous => 'बढ़ता हुआ गिबस चाँद';

  @override
  String get moonFull => 'Full moon';

  @override
  String get moonWaningGibbous => 'घटता हुआ गिबस चाँद';

  @override
  String get moonLastQuarter => 'Last quarter';

  @override
  String get moonWaningCrescent => 'घटता हुआ अर्धचंद्र';

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
  String get weatherThunder => 'आँधी-तूफ़ान के साथ बारिश';

  @override
  String get weatherUnavailable => 'मौसम अभी उपलब्ध नहीं है';

  @override
  String get weatherCached => 'सहेजा हुआ पूर्वानुमान';

  @override
  String get weatherUpdated => 'Updated';

  @override
  String get weatherForecast => 'Forecast';

  @override
  String get weatherThunderExpected => 'आँधी-तूफ़ान का पूर्वानुमान';

  @override
  String get learningUnavailable => 'इस महीने का अध्ययन कार्यक्रम लोड करने के लिए कनेक्ट करें';

  @override
  String get festivalReading => 'त्योहार का तोराह पाठ';

  @override
  String get learningCalendarSource => 'अध्ययन कैलेंडर · Hebcal · CC BY 4.0';

  @override
  String get weatherSource => 'पूर्वानुमान · MET Norway · CC BY 4.0';

  @override
  String get weatherConsent =>
      'आपके चुने हुए शहर का मौसम। MET Norway के साथ गोल किए गए निर्देशांक उपयोग करता है।';

  @override
  String get learningConsent =>
      'रमबाम और अन्य अध्ययन कार्यक्रम Hebcal से लोड होते हैं और ऑफ़लाइन उपयोग के लिए सहेजे जाते हैं।';

  @override
  String get homeRefresh => 'Refresh';

  @override
  String get skyTimezone => 'My timezone';

  @override
  String get skyShabbat => 'Shabbat city';

  @override
  String get skyReferenceCity => 'टाइमज़ोन का संदर्भ शहर';

  @override
  String get skyChooseCity => 'आकाश का शहर चुनें';

  @override
  String get skyCityExplain =>
      'सूरज और चाँद इस शहर के निर्देशांक इस्तेमाल करते हैं। आपका शब्बात शहर और अलार्म का टाइमज़ोन वैसे ही रहते हैं जैसे आपने चुने।';

  @override
  String get skySun => 'Sun today';

  @override
  String get skyMoon => 'Moon today';

  @override
  String get moonAboveHorizon => 'चाँद क्षितिज के ऊपर';

  @override
  String get moonBelowHorizon => 'चाँद क्षितिज के नीचे';

  @override
  String get moonNextNew => 'अगली अमावस्या';

  @override
  String get moonNextFull => 'अगली पूर्णिमा';

  @override
  String get locationServicesOff => 'लोकेशन सेवाएँ बंद हैं। उन्हें सेटिंग में चालू करें या कोई शहर चुनें।';

  @override
  String get locationDenied => 'लोकेशन की अनुमति नहीं मिली। उसे सेटिंग में दें या कोई शहर चुनें।';

  @override
  String get locationTimedOut =>
      'अभी लोकेशन नहीं मिली। Mac पर वाई-फ़ाई चालू रखें और दोबारा कोशिश करें, या कोई शहर चुनें।';

  @override
  String get locationTimeZoneUnavailable =>
      'लोकेशन इस्तेमाल करने से पहले चुने हुए टाइमज़ोन का कोई शहर इस्तेमाल करें, या अपने डिवाइस का टाइमज़ोन अपनाएँ।';

  @override
  String get locationSettings => 'लोकेशन सेटिंग खोलें';

  @override
  String get locationLooking => 'लोकेशन मिल रही है…';

  @override
  String get skyMoonDisplay => 'चाँद दिखाएँ: उदय, अस्त और कला';

  @override
  String get tuyaConsumerPending =>
      'खाते से साइन-इन इस वर्शन में अभी उपलब्ध नहीं है। अगर आपके पास पहले से Tuya डेवलपर प्रोजेक्ट है, तो उन्नत सेटअप इस्तेमाल करें।';

  @override
  String get tuyaAdvanced => 'उन्नत सेटअप';

  @override
  String get tuyaSignInTitle => 'अपने Smart Life खाते से साइन इन करें';

  @override
  String get tuyaSignInHint =>
      'Smart Life या Tuya Smart ऐप जैसा ही देश, ईमेल या फ़ोन नंबर और पासवर्ड उपयोग करें। खाता पहले से आपके Tuya प्रोजेक्ट से जुड़ा होना चाहिए। पासवर्ड सिर्फ़ Tuya को जाता है और कभी सहेजा नहीं जाता।';

  @override
  String get tuyaCountryCode => 'देश कोड (ब्राज़ील 55, अमेरिका 1)';

  @override
  String get tuyaAccount => 'Smart Life ईमेल या फ़ोन';

  @override
  String get tuyaPassword => 'Smart Life पासवर्ड';

  @override
  String get tuyaSignIn => 'साइन इन करें और सीन लोड करें';

  @override
  String get tuyaRelayUrl => 'Quando Tuya रिले का पता (https)';

  @override
  String get tuyaRelayHint =>
      'अपने Smart Life या Tuya Smart खाते का देश, ईमेल या फ़ोन और पासवर्ड उपयोग करें। ये एक बार Quando के Tuya रिले को जाते हैं और सहेजे नहीं जाते। आपको अपने Quando खाते में साइन इन होना चाहिए।';

  @override
  String get tuyaGoogleHint =>
      'Smart Life में Google या Apple से साइन इन करते हैं? Smart Life में “पासवर्ड भूल गए” पर टैप करके पासवर्ड सेट करें, फिर उसे यहाँ उपयोग करें।';

  @override
  String get tuyaLinked => 'Smart Life खाता जुड़ा है';

  @override
  String get tuyaUnlink => 'अलग करें';

  @override
  String get tuyaNeedsAccount => 'पहले सेटिंग्स में अपने Quando खाते में साइन इन करें।';

  @override
  String get roshHodeshHeading => 'Rosh Hodesh';

  @override
  String get roshHodeshExplain => 'होम पर अगले हिब्रू महीने का पहला दिन या दो दिन दिखाता है।';

  @override
  String get roshHodeshNext => 'अगला रोश होदेश';

  @override
  String get roshHodeshBegins => 'सूर्यास्त पर शुरू:';

  @override
  String get openParashaSefaria => 'यह तोराह भाग Sefaria पर पढ़ें';

  @override
  String get skyMyLocation => 'My location';

  @override
  String get skyLocationLocalTimes =>
      'आकाश के समय इस जगह का टाइमज़ोन इस्तेमाल करते हैं। आपके अलार्म का टाइमज़ोन और शब्बात शहर नहीं बदलते। सिर्फ़ इसी डिवाइस पर सहेजा गया।';

  @override
  String get musicRingDurationHint =>
      'प्लेबैक इस अलार्म की बजने की अवधि का पालन करता है और रोकें या स्नूज़ दबाने पर रुकता है।';

  @override
  String get musicBackupPlaying => 'संगीत शुरू नहीं हो सका। स्थानीय अलार्म ध्वनि बज रही है।';

  @override
  String desktopMusicConnect(String service) {
    return '$service ऐप जोड़ें';
  }

  @override
  String desktopMusicOn(String service) {
    return '$service से जुड़ा · डिस्कनेक्ट के लिए दबाकर रखें';
  }

  @override
  String get musicSongs => 'गाने';

  @override
  String get noMusicSongs => 'आपकी Music लाइब्रेरी में कोई गाना नहीं मिला।';

  @override
  String serviceConnectUnavailable(String service) {
    return '$service लिंक जोड़ें · अलार्म के बाद खुलता है';
  }

  @override
  String get soundCloudWidgetNote => 'सार्वजनिक लिंक जोड़ें';

  @override
  String get youtubePlayerHint =>
      'YouTube दिखाई देने वाले प्लेयर में वीडियो चलाता है। छिपने या न चल पाने पर स्थानीय अलार्म जारी रहता है।';

  @override
  String get musicPreviewFailed => 'यह ध्वनि नहीं चल सकी। कनेक्शन जाँचें या दूसरा ट्रैक या स्टेशन आज़माएँ।';

  @override
  String get skyMoonPhase => 'चंद्र कला';

  @override
  String get skyMoonDetailsDisplay => 'चंद्र कला पेज जोड़ें';

  @override
  String get skyMoonDetailsHint => 'उस तक स्वाइप करें या कभी भी चंद्रमा कार्ड पर टैप करें';

  @override
  String get moonRises => 'उदय';

  @override
  String get moonSets => 'अस्त';

  @override
  String moonLunarDay(int day) {
    return 'इस चंद्र माह के 29.5 में से दिन $day';
  }

  @override
  String get moonDetailsOpen => 'चंद्र कला खोलें';

  @override
  String get musicPlaylists => 'संगीत प्लेलिस्ट';

  @override
  String get videoPlaylists => 'वीडियो प्लेलिस्ट';

  @override
  String get likedVideos => 'पसंद किए वीडियो';

  @override
  String get wholePlaylist => 'पूरी प्लेलिस्ट से जागें';

  @override
  String get noSongsInPlaylist => 'यहाँ चलाने लायक कोई गाना नहीं है।';

  @override
  String get hebrewNamesHeading => 'पराशा और महीनों के नामों की वर्तनी';

  @override
  String get hebrewNamesIsraeli => 'इज़राइली';

  @override
  String get hebrewNamesAshkenazi => 'अश्केनाज़ी';

  @override
  String pickFromService(String service) {
    return 'मेरे $service से चुनें';
  }

  @override
  String get weatherTonight => 'आज रात';

  @override
  String get weatherTomorrowMorning => 'कल सुबह';

  @override
  String weatherUntilAbout(String time) {
    return 'लगभग $time तक';
  }

  @override
  String get weatherSunBehindClouds => 'बादलों के पीछे सूरज';

  @override
  String get keysLockTitle => 'आपके डिवाइसों पर कुंजियाँ';

  @override
  String get keysLockOff =>
      'आपकी सेवा कुंजियाँ इसी डिवाइस पर रहती हैं। उन्हें एन्क्रिप्ट करके दूसरे डिवाइसों पर भेजने के लिए एक सिंक पासफ़्रेज़ चुनें।';

  @override
  String get keysLockOn =>
      'आपकी सेवा कुंजियाँ इस डिवाइस से निकलने से पहले सिंक पासफ़्रेज़ से एन्क्रिप्ट होती हैं। कोई और, Google भी, उन्हें नहीं पढ़ सकता।';

  @override
  String get keysLockWaiting =>
      'आपके दूसरे डिवाइस से कुंजियाँ यहाँ लॉक होकर आई हैं। उन्हें खोलने के लिए सिंक पासफ़्रेज़ लिखें।';

  @override
  String get keysSetPassphrase => 'पासफ़्रेज़ चुनें';

  @override
  String get keysChangePassphrase => 'पासफ़्रेज़ बदलें';

  @override
  String get keysUnlock => 'कुंजियाँ खोलें';

  @override
  String get keysStartOver => 'भूल गए? फिर से शुरू करें';

  @override
  String get keysStartOverHint =>
      'फिर से शुरू करने पर इस डिवाइस की कुंजियाँ नए पासफ़्रेज़ के साथ भेजी जाती हैं। आपके दूसरे डिवाइस नया पासफ़्रेज़ माँगेंगे।';

  @override
  String get keysPassphrase => 'सिंक पासफ़्रेज़';

  @override
  String get keysPassphraseAgain => 'फिर से लिखें';

  @override
  String keysPassphraseShort(int count) {
    return 'कम से कम $count अक्षर रखें।';
  }

  @override
  String get keysPassphraseMismatch => 'दोनों मेल नहीं खाते।';

  @override
  String get keysPassphraseWrong => 'यह पासफ़्रेज़ इन कुंजियों को नहीं खोलता।';

  @override
  String get keysPassphraseNote =>
      'इसे लिख लें: भूलने पर कोई इसे वापस नहीं ला सकता, और आपको कुंजियाँ फिर से डालनी होंगी।';

  @override
  String get keysShareNeedsPassphrase => 'पहले \'आपके डिवाइसों पर कुंजियाँ\' में सिंक पासफ़्रेज़ चुनें।';

  @override
  String get settingsAlarmDefaults => 'अलार्म की डिफ़ॉल्ट सेटिंग';

  @override
  String get settingsPlacesTime => 'जगहें और समय';

  @override
  String get settingsLook => 'रूप, भाषा और उद्धरण';

  @override
  String get settingsAbout => 'About';

  @override
  String get defaultForNewAlarms => 'नए अलार्म के लिए डिफ़ॉल्ट';

  @override
  String get preview => 'Preview';

  @override
  String atClock(String time) {
    return 'at $time';
  }

  @override
  String get connectACalendar => 'कैलेंडर जोड़ें';

  @override
  String get newFromReadyMade => 'तैयार अलार्म से';

  @override
  String get newFromReadyMadeHint => 'सूर्योदय, सूर्यास्त और आपके लिए पहले से तैयार दूसरे अलार्म';

  @override
  String get calendarSourcesIntro =>
      'Quando? आपके कैलेंडर के इवेंट से पहले और बाद में बज सकता है। चुनें कि वे कहाँ से आएँ।';

  @override
  String get deviceCalendarsHeading => 'इस डिवाइस पर';

  @override
  String get deviceCalendarsTitle => 'इस डिवाइस का कैलेंडर ऐप';

  @override
  String get deviceCalendarsHint =>
      'इस पर हर खाता: Google, Samsung, Outlook, iCloud और सिर्फ़ यहीं रखे कैलेंडर।';

  @override
  String get googleCalendarHeading => 'GOOGLE कैलेंडर';

  @override
  String get googleCalendarSignIn =>
      'अपने कैलेंडर सीधे Google से पढ़ने के लिए Google से साइन इन करें, भले ही आपका Google खाता इस डिवाइस पर न हो।';

  @override
  String googleCalendarSignedIn(String email) {
    return '$email के रूप में साइन इन';
  }

  @override
  String get googleCalendarSignOut => 'साइन आउट';

  @override
  String get googleCalendarNotHere =>
      'इस डिवाइस पर Google साइन-इन अभी उपलब्ध नहीं है। डिवाइस की सेटिंग में (कैलेंडर › खाते) अपना Google खाता जोड़ें, उसके कैलेंडर इस डिवाइस में दिखेंगे।';

  @override
  String get googleCalendarUnreachable =>
      'अभी Google कैलेंडर तक नहीं पहुँच सके। उससे पहले से लगे अलार्म फिर भी बजेंगे।';

  @override
  String get googleCalendarTwiceHint =>
      'इसी Google खाते के जो कैलेंडर यह डिवाइस पहले से दिखाता है, वे बंद से शुरू होते हैं, ताकि कुछ भी दो बार न बजे।';

  @override
  String get timersTitle => 'टाइमर';

  @override
  String get timerStopwatch => 'स्टॉपवॉच';

  @override
  String get timerCountdown => 'टाइमर';

  @override
  String get timerSequence => 'तैयार';

  @override
  String get timerStopwatchSub => 'ऊपर गिनता है, लैप के साथ';

  @override
  String get timerCountdownSub => 'उलटी गिनती, शून्य पर बजता है';

  @override
  String get timerSequenceSub => 'बोला गया स्टार्ट और निशान';

  @override
  String get timerStart => 'शुरू करें';

  @override
  String get timerPause => 'रोकें';

  @override
  String get timerResume => 'फिर शुरू करें';

  @override
  String get timerReset => 'रीसेट करें';

  @override
  String get timerLap => 'लैप';

  @override
  String get timerTimesUp => 'समय पूरा';

  @override
  String get timerSetTime => 'समय सेट करें';

  @override
  String get timerMinutes => 'मिनट';

  @override
  String get timerSeconds => 'सेकंड';

  @override
  String get seqOnYourMarks => 'अपनी जगह पर';

  @override
  String get seqGetSet => 'तैयार';

  @override
  String get seqGo => 'चलो!';

  @override
  String get seqFinish => 'समय!';

  @override
  String get seqReady => 'तैयार';

  @override
  String get seqSettings => 'सेटिंग';

  @override
  String get seqStartCalls => 'शुरू होने से पहले की पुकार';

  @override
  String get seqStartCallsHelp => '\"चलो\" से पहले ज़ोर से बोली जाती है, शुरुआत से उलटी गिनी जाती है।';

  @override
  String seqCallBefore(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n सेकंड पहले', one: '1 सेकंड पहले');
    return '$_temp0';
  }

  @override
  String get seqAddCall => 'पुकार जोड़ें';

  @override
  String get seqCallText => 'क्या बोलना है';

  @override
  String get seqGoText => 'शुरू में बोलें';

  @override
  String get seqFinishText => 'अंत में बोलें';

  @override
  String get seqLength => 'अवधि';

  @override
  String get seqNoLimit => 'कोई सीमा नहीं';

  @override
  String get seqSayEvery => 'समय बोलें हर';

  @override
  String get seqOff => 'बंद';

  @override
  String seqEverySeconds(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n सेकंड', one: '1 सेकंड');
    return '$_temp0';
  }

  @override
  String seqEveryMinutes(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n मिनट', one: '1 मिनट');
    return '$_temp0';
  }

  @override
  String get seqFinalCount => 'आख़िरी की उलटी गिनती';

  @override
  String get seqMarks => 'आपके निशान';

  @override
  String get seqAddMark => 'निशान जोड़ें';

  @override
  String seqMarkAt(String time) {
    return '$time पर';
  }

  @override
  String get seqSpeak => 'ज़ोर से बोलें';

  @override
  String get seqBeeps => 'बीप और कंपन';

  @override
  String get seqSayRemaining => 'बीता नहीं, बचा हुआ समय बोलें';

  @override
  String get seqPresets => 'प्रीसेट';

  @override
  String get seqPresetRace => 'रेस की शुरुआत';

  @override
  String get seqPresetSprint => '30 सेकंड का ज़ोर';

  @override
  String get seqPresetRound => '1 मिनट का राउंड';

  @override
  String get seqHintNoLimit => '\"चलो\" के बाद यह आपके रोकने तक ऊपर गिनता है।';

  @override
  String get seqHintLength => '\"चलो\" के बाद यह शून्य तक उलटी गिनती करता है।';

  @override
  String get seqWords => 'शब्द';

  @override
  String get homeEdit => 'Arrange home';

  @override
  String get homeEditHint => 'कार्ड को हिलाने, समेटने या उसका आकार बदलने के लिए हैंडल खींचें।';

  @override
  String get homeReset => 'Reset layout';

  @override
  String get homeMove => 'Move';

  @override
  String get homeExpand => 'Show';

  @override
  String get homeCollapse => 'Fold';

  @override
  String get homeSize => 'Size';

  @override
  String get homeBlockClock => 'CLOCK';

  @override
  String get homeBlockSky => 'सूरज, चाँद और मौसम';

  @override
  String get homeBlockQuick => 'QUICK ALARMS';

  @override
  String get homeBlockShabbat => 'शब्बात और त्योहार';

  @override
  String get homePlaceTitle => 'आकाश के लिए शहर';

  @override
  String nextAlarmLine(String title, String time) {
    return 'अगला अलार्म · $title $time';
  }

  @override
  String get showAllAlarms => 'सभी दिन दिखाएँ';

  @override
  String get noAlarmsThatDay => 'इस दिन कुछ नहीं बजता';

  @override
  String get homeClockSize => 'होम पर घड़ी';

  @override
  String get sizeSmall => 'छोटी';

  @override
  String get sizeMedium => 'मध्यम';

  @override
  String get sizeLarge => 'बड़ी';

  @override
  String get homeLayout => 'होम लेआउट';

  @override
  String get homeLayoutClassic => 'क्लासिक';

  @override
  String get homeLayoutCards => 'कार्ड';

  @override
  String get homeCardsHint =>
      'कार्ड को हिलाने के लिए खींचें। आकार बदलने के लिए उसका किनारा या कोना खींचें, या आकार चुनें।';

  @override
  String get homeAddCard => 'कार्ड जोड़ें';

  @override
  String get homeOnHome => 'होम पर';

  @override
  String get homeRemoveCard => 'हटाएँ';

  @override
  String get cardNext => 'अगला अलार्म';

  @override
  String get cardClock => 'घड़ी और तारीख';

  @override
  String get cardSky => 'सूरज, चाँद और मौसम';

  @override
  String get cardMoon => 'चाँद';

  @override
  String get cardWeather => 'मौसम';

  @override
  String get cardAlarms => 'आपके अलार्म';

  @override
  String get cardQuick => 'झटपट अलार्म';

  @override
  String get cardTools => 'स्टॉपवॉच, काउंटडाउन और तैयार';

  @override
  String get cardWorld => 'विश्व घड़ियाँ';

  @override
  String get cardWeek => 'इस हफ़्ते';

  @override
  String get cardShabbat => 'शब्बात और त्योहार';

  @override
  String get ringAtEventReminders => 'इवेंट के अपने रिमाइंडर पर बजाएँ';

  @override
  String get ringAtEventRemindersHint =>
      'आपके कैलेंडर ऐप के रिमाइंडर यहाँ इस अलार्म की आवाज़ में तेज़ अलार्म की तरह बजते हैं।';

  @override
  String get atEventReminders => 'इवेंट के रिमाइंडर पर';

  @override
  String get everyEventReminderLoud => 'हर इवेंट के रिमाइंडर पर तेज़ बजाएँ';

  @override
  String get loudNotificationsHeading => 'तेज़ कैलेंडर सूचनाएँ';

  @override
  String get loudNotificationsTitle => 'कैलेंडर सूचनाओं को तेज़ बनाएँ';

  @override
  String get loudNotificationsHint =>
      'जब कोई कैलेंडर ऐप रिमाइंडर दिखाता है, Quando? उसे अलार्म की तरह बजाता है, फ़ोन साइलेंट पर हो तब भी।';

  @override
  String get loudNotificationsDisclosureTitle => 'Quando? को कैलेंडर सूचनाएँ पढ़ने दें?';

  @override
  String get loudNotificationsDisclosure =>
      'आपके कैलेंडर रिमाइंडर तेज़ आवाज़ में बजाने के लिए Quando? को सूचना एक्सेस चाहिए। यह सिर्फ़ आपके चुने कैलेंडर ऐप की सूचनाएँ देखता है, अलार्म पर दिखाने के लिए उनका शीर्षक और टेक्स्ट इसी फ़ोन पर पढ़ता है, और उन्हें कभी सहेजता या कहीं भेजता नहीं। आप इसे कभी भी बंद कर सकते हैं।';

  @override
  String get loudNotificationsAgree => 'सहमत, आगे बढ़ें';

  @override
  String get loudNotificationsNoAccess => 'सूचना एक्सेस बंद है। खुलने वाली सूची में Quando? चालू करें।';

  @override
  String get loudNotificationsAllow => 'अनुमति दें';

  @override
  String get loudNotificationsNoApps => 'इस फ़ोन पर कोई समर्थित कैलेंडर ऐप नहीं मिला।';

  @override
  String get loudNotificationsTwiceNote =>
      'जिन इवेंट का पहले से Quando? कैलेंडर अलार्म है, वे सिर्फ़ एक बार बजते हैं।';

  @override
  String get loudNotificationsShabbatNote => 'शब्बात और त्योहारों में शांत।';

  @override
  String get busyMode => 'व्यस्त मोड';

  @override
  String get busyModeSubtitle => 'व्यस्त रहते हुए परेशान न करें और ऑटो-जवाब';

  @override
  String get busyIntro =>
      'आपके व्यस्त रहने पर Quando? फ़ोन को शांत कर सकता है और आपकी ओर से संदेशों का जवाब दे सकता है। अलार्म फिर भी बजते हैं।';

  @override
  String get busyIosFocus =>
      'iPhone और iPad पर ऐप Focus चालू नहीं कर सकते और न ही संदेशों का जवाब दे सकते हैं। Shortcuts ऐप में \"Quando? खुलने पर\" या किसी समय पर Focus चालू करने वाला ऑटोमेशन जोड़ें और Focus में ऑटो-जवाब सेट करें।';

  @override
  String get busyWhileHeading => 'व्यस्त रहते हुए';

  @override
  String get busyDnd => 'परेशान न करें';

  @override
  String get busyDndHint => 'केवल प्राथमिकता: कॉल और संदेश शांत, अलार्म बजते हैं। खत्म होने पर सामान्य।';

  @override
  String get busyDndNoAccess => 'Quando? को अभी परेशान न करें बदलने की अनुमति नहीं है।';

  @override
  String get busyReplies => 'संदेशों का जवाब दें';

  @override
  String get busyRepliesHint =>
      'हर व्यक्ति को एक बार, आपके टेक्स्ट से, ऐप के अपने जवाब बटन से। सिर्फ़ Android।';

  @override
  String get busyRepliesDisclosureTitle => 'Quando? को संदेशों का जवाब देने दें?';

  @override
  String get busyRepliesDisclosure =>
      'आपकी ओर से जवाब देने के लिए Quando? को सूचना एक्सेस चाहिए। सिर्फ़ आपके व्यस्त रहने पर, यह आपके चुने ऐप की संदेश सूचनाएँ देखता है, इसी फ़ोन पर भेजने वाले का नाम पढ़ता है और ऐप के अपने जवाब बटन से आपका टेक्स्ट एक बार भेजता है। संदेश कभी सहेजे या कहीं और भेजे नहीं जाते। जब तक आप अनुमति न दें, ग्रुप छोड़ दिए जाते हैं।';

  @override
  String get busyReplyText => 'आपका जवाब';

  @override
  String busyReplyTextHint(String until) {
    return '$until की जगह व्यस्त मोड खत्म होने का समय आएगा।';
  }

  @override
  String busyReplyDefault(String until) {
    return 'मैं अभी व्यस्त हूँ, $until के बाद जवाब दूँगा।';
  }

  @override
  String get busyGroups => 'ग्रुप चैट में भी जवाब दें';

  @override
  String get busyGroupsHint => 'बंद: ग्रुप को कभी जवाब नहीं।';

  @override
  String get busyRepliesOnShabbat => 'शब्बात और त्योहारों में भी जवाब दें';

  @override
  String get busyAskRabbi => 'डिफ़ॉल्ट रूप से बंद। शब्बात के लिए चालू करने से पहले अपने रब्बी से पूछें।';

  @override
  String get busyWhenHeading => 'आप कब व्यस्त हैं';

  @override
  String get busyWhenHint =>
      'किसी कैलेंडर अलार्म पर \"इन इवेंट के दौरान व्यस्त\" या किसी अलार्म पर \"बजने के बाद व्यस्त\" चालू करें।';

  @override
  String get busyDuringLock => 'लॉक मोड चालू रहने तक व्यस्त';

  @override
  String get busyNoneComing => 'अगले 7 दिनों में कुछ व्यस्त नहीं।';

  @override
  String get busyDuringEvents => 'इन इवेंट के दौरान व्यस्त';

  @override
  String get busyDuringEventsHint => 'हर इवेंट की शुरुआत से अंत तक व्यस्त मोड।';

  @override
  String get busySettings => 'व्यस्त मोड सेटिंग';

  @override
  String get busyAfterRing => 'बजने के बाद व्यस्त';

  @override
  String get busyAfterRingHint => 'कुछ देर परेशान न करें और ऑटो-जवाब, जैसे वर्कआउट या झपकी।';

  @override
  String get shareCard => 'अपनी सुबह शेयर करें';

  @override
  String get shareCardSubtitle => 'आज का आसमान और कोट, या अपनी फ़ोटो, स्टोरी और स्टेटस के लिए';

  @override
  String get shareAppMissing => 'यह ऐप इस फ़ोन पर नहीं है।';

  @override
  String get shareAsIs => 'जैसा है वैसा शेयर करें';

  @override
  String get shareTapQuote => 'दूसरे कोट के लिए कोट पर टैप करें।';

  @override
  String get shareStory => 'स्टोरी';

  @override
  String get shareSquare => 'चौकोर';

  @override
  String get shareYourWords => 'आपके अपने शब्द (वैकल्पिक)';

  @override
  String get shareYourWordsHint => 'आज के कोट की जगह';

  @override
  String get shareYourPhoto => 'आपकी फ़ोटो';

  @override
  String get shareOtherPhoto => 'दूसरी फ़ोटो';

  @override
  String get shareSkyBack => 'आज का आसमान';

  @override
  String get shareYourVideo => 'आपका वीडियो';

  @override
  String get shareInstagramStory => 'Instagram स्टोरी';

  @override
  String get shareWhatsApp => 'WhatsApp: स्टेटस या चैट';

  @override
  String get shareMore => 'और ऐप';

  @override
  String get shareYouPost =>
      'Quando? आपके कार्ड के साथ ऐप खोलता है। कहाँ जाए, आप चुनते हैं और पोस्ट खुद टैप करते हैं।';

  @override
  String get shareAndroidFirst => 'शेयरिंग जल्द iPhone और iPad पर।';

  @override
  String songSaved(String name) {
    return '“$name” अलार्म ध्वनि के रूप में सहेजा गया';
  }

  @override
  String get shareToQuando => 'Quando? पर गाना शेयर करें';

  @override
  String get shareToQuandoHint =>
      'YouTube, YouTube Music, Spotify, SoundCloud या Apple Music में शेयर, फिर Quando? टैप करें। यह अलार्म ध्वनि बन जाता है जो अपने ऐप में बजती है।';

  @override
  String get askOption => 'बोलें या लिखें';

  @override
  String get askOptionHint => '“कल 6 बजे”, “सूर्योदय से 30 मिनट पहले”';

  @override
  String get askHint => 'जैसे: कार्यदिवसों में सूर्योदय से 30 मिनट पहले जगाओ';

  @override
  String get askListening => 'सुन रहा हूँ…';

  @override
  String get askNotUnderstood =>
      'मुझे कोई समय नहीं मिला। “कार्यदिवसों में सुबह 7 बजे” या “20 मिनट में” आज़माएँ।';

  @override
  String askAnswerFromCalendar(String name) {
    return 'आपके कैलेंडर “$name” से';
  }

  @override
  String get askAnswerBuiltIn => 'आपके शहर के लिए Quando? के अपने समय';

  @override
  String get askNoAnswer => 'अभी इसका समय नहीं मिला।';

  @override
  String get askNoSpeech => 'इस डिवाइस पर आवाज़ उपलब्ध नहीं है। आप लिख सकते हैं।';

  @override
  String get askShabbatOff => 'शब्बत समय बजने के लिए सेटिंग्स में शब्बत चालू करें।';

  @override
  String askSaved(String what) {
    return 'सहेजा गया: $what';
  }

  @override
  String get askMic => 'बोलें';

  @override
  String get askMorning => 'सुबह';

  @override
  String get askEvening => 'शाम';

  @override
  String get askUnsure => 'शायद मुझसे कुछ छूट गया। सहेजने से पहले जाँच लें।';

  @override
  String get askTeach => 'मुझे यह सिखाएँ';

  @override
  String askTaught(String phrase, String time) {
    return 'समझ गया: “$phrase” का मतलब अब $time है।';
  }

  @override
  String get askSkipAction => 'छोड़ें';

  @override
  String get askNoMatch => 'कोई अलार्म इससे मेल नहीं खाता।';

  @override
  String askTurnedOff(String what) {
    return 'बंद किया: $what';
  }

  @override
  String askSkipped(String what) {
    return 'छोड़ा: $what';
  }

  @override
  String askEventPlan(String offset, String event) {
    return 'आपके कैलेंडर में “$event” से $offset';
  }

  @override
  String askEventNoCalendar(String event) {
    return 'कैलेंडर जोड़ें ताकि Quando? “$event” ढूँढ सके।';
  }

  @override
  String askSnoozeAll(int minutes) {
    return 'स्नूज़: $minutes मिनट, इस अलार्म के लिए';
  }

  @override
  String askWakeWith(String sound) {
    return 'आपको $sound से जगाता है';
  }

  @override
  String get askReadAs => 'ऐसे पढ़ा गया';

  @override
  String get askHelpTitle => 'वॉइस अलार्म बेहतर बनाने में मदद करें';

  @override
  String get askHelpBody =>
      'आप जो बोलते या टाइप करते हैं और उसके साथ क्या किया, वह गुमनाम रूप से भेजता है। कोई खाता या डिवाइस ID नहीं।';

  @override
  String get askHelpPromptTitle => 'Quando? को आपको समझने में मदद करें?';

  @override
  String askHelpPromptBody(String sentence) {
    return 'हम आपकी कही या टाइप की बात, जैसे “$sentence”, और आपने उसे सेव किया या नहीं, गुमनाम रूप से भेजेंगे। नाम, खाता या डिवाइस ID नहीं। आप कभी भी बंद कर सकते हैं।';
  }

  @override
  String get askHelpYes => 'हाँ, मदद करें';

  @override
  String get askHelpNo => 'नहीं, धन्यवाद';

  @override
  String get askQuoteTranslation =>
      'जीवन वह नहीं जो जिया गया, बल्कि वह है जो याद रहता है और जिस तरह याद रहता है, उसे सुनाने के लिए।';

  @override
  String get askHelpQuote => '';

  @override
  String get quickSetups => 'त्वरित सेटअप';

  @override
  String get qsMorningTitle => 'सुबह जो काम करे';

  @override
  String get qsStartTitle => 'कोई शुरुआत न चूकें';

  @override
  String get qsStretchTitle => 'हिस्सों में काम करें';

  @override
  String get qsWillChange => 'क्या बदलेगा';

  @override
  String get qsAlreadyOn => 'पहले से चालू है। बदलने को कुछ नहीं।';

  @override
  String get qsApply => 'लागू करें';

  @override
  String get qsDone => 'हो गया';

  @override
  String get qsUndo => 'पूर्ववत करें';

  @override
  String get qsSnoozeTimes => 'अनुमत स्नूज़';

  @override
  String get qsSnoozeMinutes => 'स्नूज़ के मिनट';

  @override
  String get qsFiveLeft => '5 मिनट बचे';

  @override
  String get syncHeading => 'जब कैलेंडर बदले';

  @override
  String get syncLive => 'कैलेंडर के साथ चलें';

  @override
  String get syncLiveHint =>
      'नए इवेंट को अलार्म मिलता है। इवेंट खिसके तो उसका अलार्म भी खिसकता है। इवेंट हटे तो उसका अलार्म हटता है।';

  @override
  String get syncKeepFirst => 'जैसा पहली बार देखा वैसा रखें';

  @override
  String get syncKeepFirstHint =>
      'नए इवेंट को अब भी अलार्म मिलता है। लगने के बाद अलार्म वहीं रहता है, चाहे इवेंट खिसके या हटे।';

  @override
  String get syncSnapshot => 'सिर्फ़ अभी के इवेंट';

  @override
  String get syncSnapshotHint =>
      'सिर्फ़ वे इवेंट जो सेव करते समय आपके कैलेंडर में हैं, जैसे अभी हैं। बाद में कुछ नया नहीं जुड़ता।';

  @override
  String get syncHelpButton => 'यह कैसे काम करता है';

  @override
  String get syncHelpTitle => 'अलार्म आपके कैलेंडर के साथ कैसे चलते हैं';

  @override
  String get syncHelpIntro =>
      'यह नियम आपकी खोज से मिलते इवेंट ढूँढता रहता है। कैलेंडर बदलने पर क्या हो, यह आप चुनते हैं।';

  @override
  String get syncHelpExampleLive =>
      'उदाहरण: “डेंटिस्ट” के लिए नियम। डेंटिस्ट मंगलवार की मुलाक़ात बुधवार कर देता है, तो आपका अलार्म भी बुधवार चला जाता है। मुलाक़ात रद्द हो तो उसका अलार्म हट जाता है।';

  @override
  String get syncHelpExampleKeepFirst =>
      'वही नियम: मुलाक़ात बुधवार चली जाती है, पर अलार्म मंगलवार पर ही रहता है, जैसा Quando? ने पहली बार देखा। अगले महीने की नई मुलाक़ात को फिर भी अपना अलार्म मिलता है।';

  @override
  String get syncHelpExampleSnapshot =>
      'वही नियम: आज कैलेंडर में जो मुलाक़ातें हैं उनके अलार्म मिलते हैं, और वे वैसे ही रहते हैं। अगले महीने जुड़ी मुलाक़ात को अलार्म नहीं मिलता।';

  @override
  String get syncHelpTip => 'पक्का नहीं? “कैलेंडर के साथ चलें” रहने दें।';

  @override
  String get syncHelpWhenTitle => 'Quando? बदलाव कब देखता है?';

  @override
  String get syncHelpWhenOpen =>
      'Quando? खुला हो तो: कुछ सेकंड में। यहाँ जुड़ा Google Calendar हर 2 मिनट में देखा जाता है।';

  @override
  String get syncHelpWhenClosed =>
      'Quando? बंद हो तो: अगली बार खोलने पर। तब तक लगे हुए अलार्म अपने पुराने समय पर बजते हैं।';

  @override
  String get syncHelpWhenClosedApple =>
      'iPhone और iPad ऐप को बैकग्राउंड में कैलेंडर देखने नहीं देते, इसलिए बदलाव Quando? खोलने पर आते हैं।';

  @override
  String get tapMiddleToStop => 'रोकने के लिए बीच में टैप करें';

  @override
  String get uiSimple => 'सरल';

  @override
  String get uiEverything => 'सब कुछ';

  @override
  String get firstRunTitle => 'आप कितना देखना चाहते हैं?';

  @override
  String get firstRunSimpleHint => 'अलार्म और ज़रूरी चीज़ें';

  @override
  String get firstRunEverythingHint => 'कैलेंडर, शब्बात, टाइमर, मौसम और बहुत कुछ';

  @override
  String get firstRunChangeLater => 'आप इसे कभी भी सेटिंग में बदल सकते हैं।';

  @override
  String get continueLabel => 'आगे बढ़ें';

  @override
  String get everyAlarm => 'हर अलार्म';

  @override
  String get wakeMeWith => 'मुझे इससे जगाएँ';

  @override
  String get ringOrMusic => 'घंटी या संगीत';

  @override
  String get ringsForRow => 'इतनी देर बजे';

  @override
  String gentleBeforeValue(int minutes) {
    return '$minutes मिनट पहले';
  }

  @override
  String get quandoSounds => 'Quando? की आवाज़ें';

  @override
  String get aSongApps => 'एक गाना (Spotify, YouTube…)';

  @override
  String get myRecording => 'मेरी रिकॉर्डिंग';

  @override
  String get useForNewAlarms => 'नए अलार्म के लिए इस्तेमाल करें';

  @override
  String get iWillLabel => 'यह बजे तो मैं…';

  @override
  String get foldVolume => 'वॉल्यूम और फ़ेड';

  @override
  String get foldSnoozeStop => 'स्नूज़ और रोकें';

  @override
  String get foldExtras => 'कैलेंडर और अतिरिक्त';

  @override
  String get groupAlarms => 'अलार्म';

  @override
  String get groupCalendarShabbat => 'कैलेंडर और शब्बात';

  @override
  String get groupLookQuotes => 'रूप और उद्धरण';

  @override
  String get groupConnectionsSync => 'कनेक्शन और सिंक';

  @override
  String qsSummary(int count, int on) {
    return '$count सेटअप · $on चालू';
  }

  @override
  String get deleteAccount => 'Delete account';

  @override
  String get deleteAccountTitle => 'Delete account?';

  @override
  String get deleteAccountBody =>
      'Your synced alarms, settings and keys are erased from the cloud and your sign-in is removed. Alarms on this device stay.';

  @override
  String get accountDeleted => 'Account deleted';

  @override
  String get deleteAccountFailed => 'Couldn\'t delete the account. Try again.';

  @override
  String get weatherRemindersTitle => 'मौसम अनुस्मारक';

  @override
  String get weatherRemindersSubtitle => 'बारिश, तूफ़ान या बर्फ़ से पहले बजता है';

  @override
  String get weatherIntro =>
      'बारिश, तूफ़ान या बर्फ़बारी से पहले जितने चाहें उतने अनुस्मारक पाएँ। Quando? पूर्वानुमान पढ़कर उन्हें आपके फ़ोन में सेट करता है।';

  @override
  String get weatherBackgroundNote => 'यह हर कुछ घंटों में बैकग्राउंड में भी पूर्वानुमान जाँचता है।';

  @override
  String get weatherOpenNote => 'यह ऐप खोलने पर पूर्वानुमान पढ़ता है, बंद होने पर जाँच नहीं सकता।';

  @override
  String get weatherNoPlace => 'पहले होम स्क्रीन पर अपनी जगह चुनें, ताकि पढ़ने के लिए पूर्वानुमान हो।';

  @override
  String get weatherWhichHeading => 'कौन-सा मौसम';

  @override
  String get weatherWhenHeading => 'कब';

  @override
  String get weatherAnytime => 'दिन के किसी भी समय';

  @override
  String get weatherAnytimeHint => 'मौसम आने से पहले, आप चाहे जो कर रहे हों।';

  @override
  String get weatherTied => 'मेरे अलार्म और कैलेंडर इवेंट से पहले';

  @override
  String get weatherTiedHint =>
      'जब पूर्वानुमान में किसी अलार्म या इवेंट के आसपास वह मौसम हो, तो मुझे पहले बताएँ, जैसे काम पर निकलने से पहले।';

  @override
  String get weatherRemindersHeading => 'अनुस्मारक';

  @override
  String weatherLeadMinutes(int n) {
    return '$n मिनट पहले';
  }

  @override
  String weatherLeadHours(int n) {
    return '$n घंटे पहले';
  }

  @override
  String get weatherAlarmOption => 'अलार्म';

  @override
  String get weatherSoftOption => 'धीमा';

  @override
  String get weatherRemove => 'हटाएँ';

  @override
  String get weatherAddReminder => 'अनुस्मारक जोड़ें';

  @override
  String get weatherQuietHeading => 'शांत घंटे';

  @override
  String get weatherQuietSwitch => 'शांत घंटे';

  @override
  String get weatherQuietHint =>
      'इस समय कोई अनुस्मारक नहीं बजता। जो इसके अंदर पड़े, वह इसके खत्म होने तक रुकता है, अगर तब तक मौसम न आया हो।';

  @override
  String get weatherQuietFrom => 'से';

  @override
  String get weatherQuietTo => 'तक';

  @override
  String get weatherComingUp => 'आगे आने वाले';

  @override
  String get weatherNothingComing => 'अगले दो दिनों के पूर्वानुमान में कुछ नहीं है।';

  @override
  String weatherRingsAt(String when) {
    return '$when बजेगा';
  }

  @override
  String get weatherShabbatNote => 'शब्बात और त्योहारों में मौसम अनुस्मारक शांत रहते हैं।';

  @override
  String get weatherTitleRain => 'बारिश का पूर्वानुमान';

  @override
  String get weatherTitleThunder => 'तूफ़ान का पूर्वानुमान';

  @override
  String get weatherTitleSnow => 'बर्फ़बारी का पूर्वानुमान';

  @override
  String get weatherTitleFog => 'कोहरे का पूर्वानुमान';

  @override
  String weatherBodyAny(String time) {
    return 'लगभग $time बजे';
  }

  @override
  String weatherBodyTied(String event, String time) {
    return '$event · लगभग $time बजे';
  }
}
