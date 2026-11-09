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
  String get calendarAlarm => 'कैलेंडर अलार्म';

  @override
  String get calendarIntro =>
      'Quando? आपके फ़ोन के कैलेंडर के इवेंट से पहले और बाद में बज सकता है। फ़ोन पर Google खाता होते ही Google Calendar शामिल हो जाता है।';

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

  @override
  String get ringTheseAfterAll => 'Ring these after all';

  @override
  String skipTheseDay(int n) {
    return 'Skip these $n today';
  }

  @override
  String turnOffNamed(String name) {
    return 'Turn off “$name”';
  }

  @override
  String turnOnNamed(String name) {
    return 'Turn on “$name”';
  }

  @override
  String turnedOffNamed(String name) {
    return 'Turned off “$name”';
  }

  @override
  String removeTimeFrom(String time, String name) {
    return 'Remove “$time” from “$name”';
  }

  @override
  String removedTimeFrom(String time, String name) {
    return 'Removed “$time” from “$name”';
  }

  @override
  String get moveToGroup => 'Move to a group';

  @override
  String inGroupMove(String group) {
    return 'In “$group”, move';
  }

  @override
  String movedToGroup(String group) {
    return 'Moved to “$group”';
  }

  @override
  String deleteNamed(String name) {
    return 'Delete “$name”';
  }

  @override
  String get signInWithGoogle => 'Sign in with Google';

  @override
  String get signOut => 'Sign out';

  @override
  String get signInWithEmail => 'Sign in with email';

  @override
  String get signIn => 'Sign in';

  @override
  String get createAccount => 'Create account';

  @override
  String get haveAccount => 'I have an account';

  @override
  String get forgotPassword => 'Forgot password?';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get passwordResetSent => 'We sent you a link to choose a new password.';

  @override
  String emailCheckInbox(String email) {
    return 'We sent a link to $email. Open it, then come back and tap “I’ve confirmed”.';
  }

  @override
  String get emailConfirmed => 'I’ve confirmed';

  @override
  String get emailNotYet => 'Not confirmed yet. Open the link in the email first.';

  @override
  String get emailSendAgain => 'Send the email again';

  @override
  String get emailSentAgain => 'Sent. Check your inbox and spam.';

  @override
  String get emailInvalid => 'That doesn’t look like an email address.';

  @override
  String get emailWrong => 'Wrong email or password.';

  @override
  String get emailInUse =>
      'There’s already an account with this email. Sign in instead, or use Google if you made it with Google.';

  @override
  String get passwordWeak => 'Choose a password of at least 6 characters.';

  @override
  String get emailNotSwitchedOn => 'Email sign-in isn’t switched on yet.';

  @override
  String get tooManyTries => 'Too many tries. Wait a few minutes.';

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
  String get beforeShabbat => 'Before Shabbat';

  @override
  String get preparationReminders => 'Preparation reminders';

  @override
  String get skipThisWeek => 'Skip this week';

  @override
  String get restoreThisWeek => 'Restore this week';

  @override
  String get allAlarms => 'All alarms';

  @override
  String get timesAndSound => 'Times & sound';

  @override
  String get changeCity => 'Change city';

  @override
  String get useMyLocation => 'Use my location';

  @override
  String get locationUnavailable => 'Location is temporarily unavailable. Try again or choose a city.';

  @override
  String get locationReview => 'Confirm this location';

  @override
  String get locationDeviceOnly =>
      'This location is saved only on this device. Check the timezone and Israel setting before using these times.';

  @override
  String timesIn(String city, String zone) {
    return '$city · $zone · city time';
  }

  @override
  String get preparationOff => 'Preparation reminders are off. Havdalah and ordinary alarms are unchanged.';

  @override
  String get preparationSkipped =>
      'Preparation reminders are skipped this week. Your weekly settings are kept.';

  @override
  String get shabbatControls => 'Shabbat controls';

  @override
  String get duringAfterShabbat => 'During / after Shabbat';

  @override
  String locationCoordinates(String latitude, String longitude) {
    return 'Latitude $latitude · longitude $longitude';
  }

  @override
  String get currentLocation => 'Current location';

  @override
  String get testPushoverSound => 'Test sound on Pushover';

  @override
  String get pushoverSoundTestHint =>
      'Plays the selected sound on your selected Pushover devices. Silent and quiet-hour settings still apply.';

  @override
  String get pushoverShareDevices => 'Share credentials with my devices';

  @override
  String get pushoverShareHint =>
      'Your Pushover user key and app token can follow your signed-in account across Quando? and Matai?.';

  @override
  String get pushoverShareQueued => 'Credentials queued for your signed-in devices.';

  @override
  String get pushoverShareSignIn =>
      'Sign in to the same app account on each device to share Pushover credentials.';

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
  String get skyTimezone => 'My timezone';

  @override
  String get skyShabbat => 'Shabbat city';

  @override
  String get skyReferenceCity => 'Timezone reference city';

  @override
  String get skyChooseCity => 'Choose sky city';

  @override
  String get skyCityExplain =>
      'Sun and Moon use this city’s coordinates. Your Shabbat city and alarm timezone stay as chosen.';

  @override
  String get skySun => 'Sun today';

  @override
  String get skyMoon => 'Moon today';

  @override
  String get moonAboveHorizon => 'Moon above the horizon';

  @override
  String get moonBelowHorizon => 'Moon below the horizon';

  @override
  String get moonNextNew => 'Next new moon';

  @override
  String get moonNextFull => 'Next full moon';

  @override
  String get locationServicesOff => 'Location Services is off. Turn it on in Settings or choose a city.';

  @override
  String get locationDenied => 'Location access was denied. Allow it in Settings or choose a city.';

  @override
  String get locationTimedOut =>
      'No location fix yet. On Mac, keep Wi-Fi on and try again, or choose a city.';

  @override
  String get locationTimeZoneUnavailable =>
      'Use a city in the selected timezone, or follow your device timezone before using location.';

  @override
  String get locationSettings => 'Open location settings';

  @override
  String get locationLooking => 'Getting a location fix…';

  @override
  String get skyMoonDisplay => 'Show Moon: rise, set and phase';

  @override
  String get tuyaConsumerPending =>
      'Account sign-in isn’t available in this build yet. If you already have a Tuya developer project, use Advanced setup.';

  @override
  String get tuyaAdvanced => 'Advanced setup';

  @override
  String get tuyaSignInTitle => 'Sign in with your Smart Life account';

  @override
  String get tuyaSignInHint =>
      'Use the same country, email or phone and password as in the Smart Life or Tuya Smart app. The account must already be linked to your Tuya project. The password goes only to Tuya and is never saved.';

  @override
  String get tuyaCountryCode => 'Country calling code (Brazil 55, US 1)';

  @override
  String get tuyaAccount => 'Smart Life email or phone';

  @override
  String get tuyaPassword => 'Smart Life password';

  @override
  String get tuyaSignIn => 'Sign in and load scenes';

  @override
  String get tuyaRelayUrl => 'Quando Tuya relay address (https)';

  @override
  String get tuyaRelayHint =>
      'Use the country, email or phone and password of your Smart Life or Tuya Smart account. They go to Quando’s Tuya relay once and are not saved. You need to be signed in to your Quando account.';

  @override
  String get tuyaGoogleHint =>
      'Signed in to Smart Life with Google or Apple? In Smart Life, tap Forgot Password to set a password, then use it here.';

  @override
  String get tuyaLinked => 'Smart Life account linked';

  @override
  String get tuyaUnlink => 'Unlink';

  @override
  String get tuyaNeedsAccount => 'Sign in to your Quando account in Settings first.';

  @override
  String get roshHodeshHeading => 'Rosh Hodesh';

  @override
  String get roshHodeshExplain => 'Show the next Hebrew month’s first day or two days on Home.';

  @override
  String get roshHodeshNext => 'Next Rosh Hodesh';

  @override
  String get roshHodeshBegins => 'Begins at sunset on';

  @override
  String get openParashaSefaria => 'Read this Torah portion on Sefaria';

  @override
  String get skyMyLocation => 'My location';

  @override
  String get skyLocationLocalTimes =>
      'Sky times use this location’s timezone. Your alarm-clock timezone and Shabbat city stay unchanged. Saved only on this device.';

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
}
