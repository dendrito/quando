// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get undo => 'Geri al';

  @override
  String duplicatedNamed(String name) {
    return '“$name” kopyalandı';
  }

  @override
  String deletedNamed(String name) {
    return '“$name” silindi';
  }

  @override
  String get when => 'Ne zaman?';

  @override
  String get newAtTime => 'Belirli bir saatte';

  @override
  String get newAtTimeHint => 'Her hafta içi 7:00’de, bir kez 15:30’da…';

  @override
  String get newAroundEvent => 'Bir etkinliğe göre';

  @override
  String get newAroundEventHint =>
      'Takvimlerde, Şabat ve güneş saatlerinde ara, sonra önce, tam zamanında veya sonra çal';

  @override
  String get editThisAlarm => 'Bu alarmı düzenle';

  @override
  String editNamed(String name) {
    return '“$name” düzenle';
  }

  @override
  String get preset => 'şablon';

  @override
  String get editThisCalendarRule => 'Bu takvim kuralını düzenle';

  @override
  String get ringThisOneAfterAll => 'Yine de çalsın';

  @override
  String get skipJustThisOne => 'Yalnızca bunu atla';

  @override
  String get renameGroup => 'Grubu yeniden adlandır';

  @override
  String quickSet(String label, String time) {
    return '$label · $time saatinde çalar';
  }

  @override
  String get newAlarm => 'Yeni alarm';

  @override
  String get appName => 'Quando?';

  @override
  String get lockMode => 'Kilit modu';

  @override
  String get calendars => 'Takvimler';

  @override
  String get settings => 'Ayarlar';

  @override
  String get nextAlarmHeading => 'SONRAKİ ALARM';

  @override
  String get nothingSet => 'Hiçbir şey ayarlanmadı';

  @override
  String get tagline => 'Her şey zamanında.';

  @override
  String sunriseAt(String time) {
    return 'Gün doğumu $time';
  }

  @override
  String sunsetAt(String time) {
    return 'Gün batımı $time';
  }

  @override
  String get alarmsMayNotRing => 'Alarmların çalmayabilir';

  @override
  String get tapToFixIt => 'Düzeltmek için dokun';

  @override
  String inMinutes(int minutes) {
    return '$minutes dk sonra';
  }

  @override
  String get atSunset => 'Gün batımında';

  @override
  String get sunset => 'Gün batımı';

  @override
  String get shabbatModeIsOn => 'ŞABAT MODU AÇIK';

  @override
  String nextInCity(String city) {
    return 'SONRAKİ · $city';
  }

  @override
  String get candleLighting => 'Mum yakma';

  @override
  String get havdalah => 'Havdala';

  @override
  String get shabbatAndFestivals => 'Şabat ve bayramlar';

  @override
  String get yourAlarmsHeading => 'ALARMLARIN';

  @override
  String get tapWhenToAdd => 'Alarm eklemek için Ne zaman?’a dokun.';

  @override
  String get aroundEventsHeading => 'ETKİNLİKLERE GÖRE';

  @override
  String searchFor(String words) {
    return 'ara: $words';
  }

  @override
  String get thisWeekHeading => 'BU HAFTANIN ALARMLARI';

  @override
  String get noAlarmsThisWeek => 'Önümüzdeki 7 günde alarm yok.';

  @override
  String get alarmsSetThemselves =>
      'Bir şeyi her değiştirdiğinde alarmlar bu telefonda kendiliğinden kurulur.';

  @override
  String cityTime(String city) {
    return '$city saati';
  }

  @override
  String get more => 'Diğer';

  @override
  String get turnOff => 'Kapat';

  @override
  String get turnOn => 'Aç';

  @override
  String get duplicate => 'Kopyala';

  @override
  String get delete => 'Sil';

  @override
  String get inOneHour => '1 saat sonra';

  @override
  String get logoLabel => 'Quando? logosu';

  @override
  String get noTimesSet => 'Saat ayarlanmadı';

  @override
  String get atTheMoment => 'tam o anda';

  @override
  String timesRange(int count, String from, String to) {
    return '$count kez · $from ile $to arası';
  }

  @override
  String spanDays(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n gün', one: '1 gün');
    return '$_temp0';
  }

  @override
  String spanHours(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n saat', one: '1 saat');
    return '$_temp0';
  }

  @override
  String spanMinutes(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n dakika', one: '1 dakika');
    return '$_temp0';
  }

  @override
  String spanSeconds(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n saniye', one: '1 saniye');
    return '$_temp0';
  }

  @override
  String get now => 'şimdi';

  @override
  String spanBefore(String span) {
    return '$span önce';
  }

  @override
  String spanAfter(String span) {
    return '$span sonra';
  }

  @override
  String alarmCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n alarm', one: '1 alarm');
    return '$_temp0';
  }

  @override
  String get allOn => 'hepsi açık';

  @override
  String get allOff => 'hepsi kapalı';

  @override
  String someOn(int n) {
    return '$n açık';
  }

  @override
  String skippedBody(String body) {
    return 'Atlandı · $body';
  }

  @override
  String timeToTime(String from, String to) {
    return '$from – $to';
  }

  @override
  String skippedCount(int n) {
    return '$n atlandı';
  }

  @override
  String get sunNoRiseSet => 'Bugün burada güneş doğmuyor ya da batmıyor';

  @override
  String sunProgress(int percent) {
    return 'Güneş günün %$percent kadarını geçti';
  }

  @override
  String get sunIsDown => 'Güneş battı';

  @override
  String get searchCity => 'Şehir ara';

  @override
  String get tomorrowLower => 'yarın';

  @override
  String get yesterdayLower => 'dün';

  @override
  String get worldClocksHeading => 'DÜNYA SAATLERİ';

  @override
  String get add => 'Ekle';

  @override
  String cityHere(String city) {
    return '$city · burası';
  }

  @override
  String get worldClocksHint => 'Saatlerini burada görmek için şehir ekle. Kaldırmak için sola kaydır.';

  @override
  String get groupNameHint => 'İş, Çocuklar, Spor salonu…';

  @override
  String get cancel => 'İptal';

  @override
  String get ok => 'Tamam';

  @override
  String get noGroup => 'Grup yok';

  @override
  String get newGroupEllipsis => 'Yeni grup…';

  @override
  String get newGroup => 'Yeni grup';

  @override
  String secondsShort(int n) {
    return '$n sn';
  }

  @override
  String minutesShort(int n) {
    return '$n dk';
  }

  @override
  String get minutes => 'Dakika';

  @override
  String get ringFor => 'Çalma süresi';

  @override
  String get seconds => 'Saniye';

  @override
  String get oneSecondLess => '1 saniye az';

  @override
  String get oneSecondMore => '1 saniye fazla';

  @override
  String inDays(int d) {
    return '$d g sonra';
  }

  @override
  String inDaysHours(int d, int h) {
    return '$d g $h sa sonra';
  }

  @override
  String inHours(int h) {
    return '$h sa sonra';
  }

  @override
  String inHoursMinutes(int h, int m) {
    return '$h sa $m dk sonra';
  }

  @override
  String inMins(int m) {
    return '$m dk sonra';
  }

  @override
  String placeChange(String city, String where) {
    return '$city · $where · değiştir';
  }

  @override
  String get israel => 'İsrail';

  @override
  String get outsideIsrael => 'İsrail dışı';

  @override
  String get comingUpHeading => 'YAKLAŞANLAR';

  @override
  String get lockForShabbat => 'Telefonu Şabat için kilitle';

  @override
  String get lockForShabbatHint => 'Mum yakmadan havdalaya, bayramlarda da';

  @override
  String get ownShabbatAlarmsHeading => 'ŞABAT ALARMLARIN';

  @override
  String get addShabbatAlarm => 'Şabat veya bayram alarmı ekle';

  @override
  String get readyMadeHeading => 'HAZIR ALARMLAR';

  @override
  String bringBackDeleted(int n) {
    return 'Silinenleri geri getir ($n)';
  }

  @override
  String get presetsHint => 'Saatlerini değiştirmek için birine dokun. Silmek için kaydır.';

  @override
  String get lockSentence => 'Telefonu Şabat ya da odaklı bir gece için yalnızca saat ve alarmlara indir.';

  @override
  String get lockExplain =>
      'Kilitliyken Quando? yalnızca saati, sonraki alarmı ve kilidin ne zaman biteceğini gösterir. Alarmlar çalışmaya devam eder ve kilit açılana kadar hiçbir şey değiştirilemez.';

  @override
  String get lockNowHeading => 'ŞİMDİ KİLİTLE';

  @override
  String get lockAutoHeading => 'OTOMATİK KİLİTLE';

  @override
  String get shabbatAndFestivalsLong => 'Şabat ve bayramlar';

  @override
  String get fromCandleToHavdalah => 'Mum yakmadan havdalaya';

  @override
  String get lockCalendarWord => 'Bu kelimeyi içeren takvim etkinliklerinde';

  @override
  String get lockCalendarWordHint => 'örn. kilit, sınav, odak';

  @override
  String get leaveEmptyForNone => 'Kapalı için boş bırak';

  @override
  String get connectCalendarsFirst => 'Önce takvimleri bağla (takvim simgesi)';

  @override
  String get openWhenLockStarts => 'Kilit başlayınca Quando?’yu aç';

  @override
  String get openWhenLockStartsHint => '1 saniyelik sessiz bir ses, kilitlemek için Quando?’yu öne getirir';

  @override
  String get pinToScreen => 'Quando?’yu ekrana sabitle';

  @override
  String get pinToScreenHint => 'Kilitliyken diğer uygulamalar açılmaz. Android ilk seferde onay ister.';

  @override
  String get noLocksComingUp => 'Yaklaşan kilit yok.';

  @override
  String get leaveLockEarly => 'Erken çıkmak için “Kilidi açmak için basılı tut”a 3 saniye basılı tut.';

  @override
  String get locked => 'Kilitli';

  @override
  String get shabbatShalom => 'Şabat şalom';

  @override
  String get chagSameach => 'Hag sameah';

  @override
  String get unlocksHeading => 'KİLİT AÇILIR';

  @override
  String get nowCap => 'Şimdi';

  @override
  String get nextAlarm => 'Sonraki alarm';

  @override
  String get holdToUnlock => 'Kilidi açmak için basılı tut';

  @override
  String get lockSentenceCalm =>
      'Telefonu saate ve alarmlarına kilitle: bir sınav, toplantı ya da sakin bir akşam için.';

  @override
  String get lockCalendarHeading => 'TAKVİMİNLE';

  @override
  String get lockCalendarExplain =>
      'Bir etkinlik boyunca ya da bir etkinlikten seçtiğin bir sonrakine kadar kilitle. Seçtiğin her takvimle, paylaşılanlarla da çalışır.';

  @override
  String get lockAddCalendar => 'Takvim kilidi ekle';

  @override
  String get lockEditCalendar => 'Takvim kilidi';

  @override
  String get lockDuring => 'Bir etkinlik boyunca';

  @override
  String get lockBetween => 'İki etkinlik arasında';

  @override
  String get lockStartsAt => 'Adı şu olan etkinlikler…';

  @override
  String get lockStartsAtBetween => 'Şu adlı bir etkinlikte başlar…';

  @override
  String get lockEndsAt => 'Şu adlı bir sonraki etkinlikte biter…';

  @override
  String get lockStartHint => 'ör. sınav, odak, spor';

  @override
  String get lockEndHint => 'ör. evde';

  @override
  String get lockAnyCalendar => 'Herhangi bir takvim';

  @override
  String get lockNoMatches => 'Takvimlerinde henüz eşleşen yok.';

  @override
  String get lockNextTimes => 'SONRAKİ ZAMANLAR';

  @override
  String lockDuringTitle(String a) {
    return '“$a” boyunca';
  }

  @override
  String lockBetweenTitle(String a, String b) {
    return '“$a” ile bir sonraki “$b” arasında';
  }

  @override
  String lockShabbatCalendarFound(String name) {
    return '“$name” Şabat saatlerini içeriyor.';
  }

  @override
  String get lockShabbatFromCalendar => 'Mum yakmadan Havdala\'ya kadar kilitle';

  @override
  String get lockShabbatFromCalendarHint => 'O takvimin saatlerini kullanır, ekranda mumlarla.';

  @override
  String get lockMoreWays => 'Diğer kilit yolları';

  @override
  String get lockQuietTime => 'Sessiz zaman';

  @override
  String nextCandleLightingFrom(String time, String name) {
    return 'Sonraki mum yakma: $time, $name takviminden';
  }

  @override
  String get calendarAlarm => 'Takvim alarmı';

  @override
  String get connectCalendars => 'Takvimleri bağla';

  @override
  String get calendarAlarmsHeading => 'TAKVİM ALARMLARI';

  @override
  String get calendarNoneYet => 'Henüz yok. Bununla başla, sonra istediğin gibi değiştir:';

  @override
  String get fifteenBeforeEvery => 'Her etkinlikten 15 dakika önce';

  @override
  String get useTheseCalendarsHeading => 'BU TAKVİMLERİ KULLAN';

  @override
  String get noTimedEvents => 'Bu takvimlerde saatli yaklaşan etkinlik yok.';

  @override
  String get atTheStart => 'başlangıçta';

  @override
  String everyForBefore(String every, String span) {
    return '$span öncesinden itibaren her $every';
  }

  @override
  String spanAfterItEnds(String span) {
    return 'bittikten $span sonra';
  }

  @override
  String get noAlarmsChosen => 'Alarm seçilmedi';

  @override
  String get gentleWakeUp => 'Yumuşak uyanış';

  @override
  String gentleSummary(int minutes, String sound) {
    return '$minutes dk önce · $sound';
  }

  @override
  String get off => 'Kapalı';

  @override
  String get gentleSentence =>
      'Alarmından önce sakin bir ses usulca başlar, böylece asla irkilerek uyanmazsın.';

  @override
  String get gentleExplain =>
      'Yavaşça yükselir, seni hafif uykudan çıkarır ve alarm çalmadan hemen önce durur.';

  @override
  String get startsBeforeHeading => 'ALARMDAN ÖNCE BAŞLAR';

  @override
  String get leadUpSoundHeading => 'GİRİŞ SESİ';

  @override
  String get listen => 'Dinle';

  @override
  String get whoRecordedThese => 'Bu sesleri kim kaydetti';

  @override
  String get done => 'Bitti';

  @override
  String get soundCredits => 'Ses künyesi';

  @override
  String yourTimeCity(String city) {
    return 'Senin saatin ($city)';
  }

  @override
  String get anotherCity => 'Başka bir şehir…';

  @override
  String get ringingIn5 => '5 saniye içinde çalıyor…';

  @override
  String get alarmSaved => 'Alarm kaydedildi.';

  @override
  String alarmSetFor(String span) {
    return 'Alarm $span sonra çalacak.';
  }

  @override
  String hoursMinutesShort(int h, int m) {
    return '$h sa $m dk';
  }

  @override
  String get editAlarm => 'Alarmı düzenle';

  @override
  String get previewCaps => 'ÖNİZLE';

  @override
  String get saveCaps => 'KAYDET';

  @override
  String cityTimeForYou(String city, String time) {
    return '$city saati · senin için $time';
  }

  @override
  String repeatHeading(String repeat) {
    return 'TEKRAR · $repeat';
  }

  @override
  String get labelField => 'Etiket (sesli alarmlar açıksa yüksek sesle okunur)';

  @override
  String get group => 'Grup';

  @override
  String ringsForHeading(String span) {
    return '$span ÇALAR';
  }

  @override
  String useDefault(String value) {
    return 'Varsayılanı kullan ($value)';
  }

  @override
  String get save => 'Kaydet';

  @override
  String get sameTime => 'aynı saat';

  @override
  String get untilYouStopIt => 'Sen durdurana kadar';

  @override
  String get alarm => 'Alarm';

  @override
  String get once => 'Bir kez';

  @override
  String get everyDay => 'Her gün';

  @override
  String get weekdays => 'Hafta içi';

  @override
  String get weekends => 'Hafta sonu';

  @override
  String timeInCity(String time, String city) {
    return '$city saatiyle $time';
  }

  @override
  String eventsMatching(String words) {
    return '“$words” içeren etkinlikler';
  }

  @override
  String get everyEvent => 'Her etkinlik';

  @override
  String get sunrise => 'Gün doğumu';

  @override
  String havdalahEndOf(String day) {
    return 'Havdala · $day sonu';
  }

  @override
  String get yomTov => 'Yom tov';

  @override
  String get shabbat => 'Şabat';

  @override
  String get presetCountdown => 'Mum yakmaya geri sayım';

  @override
  String get presetHourly => '6 saat önceden başlayarak her saat';

  @override
  String get presetDailyWeek => 'Önceki hafta, günde bir kez';

  @override
  String get presetSecondNight => 'İkinci gece mumları';

  @override
  String get presetFridayReminder => '3 saat önce hatırlatma: telefonunu şarj et';

  @override
  String get presetFridayReminderLabel => 'Telefonunu şarj et ve yarının alarmlarını kur';

  @override
  String get presetSunset => 'Gün batımı ve 15 dakika öncesi';

  @override
  String get pesach => 'Pesah';

  @override
  String get shavuot => 'Şavuot';

  @override
  String get roshHashanah => 'Roş Aşana';

  @override
  String get yomKippur => 'Yom Kipur';

  @override
  String get sukkot => 'Sukot';

  @override
  String get sheminiAtzeret => 'Şemini Atseret';

  @override
  String get simchatTorah => 'Simhat Tora';

  @override
  String get readyNotifications => 'Alarmları göster';

  @override
  String get readyNotificationsWhy => 'Alarm ekranının ve Durdur düğmesinin görünmesini sağlar.';

  @override
  String get readyFullScreen => 'Kilit ekranının üstünde çal';

  @override
  String get readyFullScreenWhy => 'Telefon kilitliyken bile alarmı tam ekran gösterir.';

  @override
  String get readyExact => 'Tam dakikasında çal';

  @override
  String get readyExactWhy => 'Bu olmadan telefon alarmları birkaç dakika geciktirebilir.';

  @override
  String get readyBattery => 'Pil tasarrufunda çalışmaya devam et';

  @override
  String get readyBatteryWhy => 'Pil tasarrufunun gece alarmları susturmasını önler.';

  @override
  String get tipXiaomi =>
      'Xiaomi telefonlar: Ayarlar › Uygulamalar › Quando? içinde Otomatik başlatmayı aç ve Pil tasarrufunu Kısıtlama yok yap.';

  @override
  String get tipSamsung =>
      'Samsung telefonlar: Ayarlar › Pil › Arka plan kullanım sınırları içinde Quando?’nun uykuya alınmadığından emin ol.';

  @override
  String get tipHuawei =>
      'Huawei ve Honor telefonlar: Ayarlar › Pil › Uygulama başlatma içinde Quando?’yu Manuel yönet yap ve her şeye izin ver.';

  @override
  String get tipOther =>
      'Bu telefonda: Ayarlar › Pil içinde Quando?’nun arka planda çalışmasına izin ver ve optimizasyonu kapat.';

  @override
  String get testRing => 'Deneme çalması';

  @override
  String get testRingBody => 'Quando? seni uyandırabilir';

  @override
  String get ringsIn20 => '20 saniye içinde çalacak. Şimdi telefonunu kilitle ve bekle.';

  @override
  String get readyToRing => 'Çalmaya hazır';

  @override
  String get checkingPhone => 'Telefonun kontrol ediliyor…';

  @override
  String get phoneReady => 'Telefonun her alarmı zamanında çalmaya hazır.';

  @override
  String thingsNeedFixing(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n şeyin düzeltilmesi gerekiyor, yoksa alarmlar çalmayabilir.',
      one: '1 şeyin düzeltilmesi gerekiyor, yoksa alarmlar çalmayabilir.',
    );
    return '$_temp0';
  }

  @override
  String get fix => 'Düzelt';

  @override
  String get testIn20 => 'Dene: 20 saniye içinde çalar';

  @override
  String get testIn20Hint => 'Telefonunu kilitle ve bırak. Alarm tam ekran çalarsa her şey hazır.';

  @override
  String get readyToRingHint => 'Telefonunun her alarmı zamanında çaldığını kontrol et';

  @override
  String get connections => 'Bağlantılar';

  @override
  String get timeZoneHeading => 'SAAT DİLİMİ';

  @override
  String get followPhone => 'Telefonu izle';

  @override
  String followPhoneNow(String city) {
    return 'Şu an $city. Seyahat edince kendisi değişir.';
  }

  @override
  String get zoneFixed => 'Sabit. Seyahat etsen de alarmlar bu saati korur.';

  @override
  String get shabbatCityHeading => 'ŞABAT İÇİN ŞEHİR';

  @override
  String get inIsraelOneDay => 'İsrail’de (bir bayram günü)';

  @override
  String candleMinutesHeading(int n) {
    return 'MUMLAR: GÜN BATIMINDAN $n DAKİKA ÖNCE';
  }

  @override
  String get endOfShabbatHeading => 'ŞABAT VE BAYRAMLARIN SONU';

  @override
  String get nightfallGeonim => 'Yıldızların çıkışı (Geonim, 8,5°)';

  @override
  String get rabbeinuTam => 'Gün batımından 72 dakika sonra (Rabenu Tam)';

  @override
  String get whenAlarmRingsHeading => 'BİR ALARM ÇALDIĞINDA';

  @override
  String get recordOrAddSounds => 'Ses kaydet veya ekle';

  @override
  String get ringsForThisLong => 'Bu kadar çalar, sonra kendisi durur';

  @override
  String get sameFades => 'Tüm alarmlar için aynı geçişler';

  @override
  String get sameFadesOn => 'Her alarmın geçişlerinin yerine geçer. Her biri kendi ses düzeyini korur.';

  @override
  String get sameFadesOff => 'Kapalı: her alarm kendi Ses ayarındaki geçişleri kullanır.';

  @override
  String get sayItOutLoud => 'Yüksek sesle söyle';

  @override
  String get sayItOutLoudHint => 'Alarmın ne için olduğunu okur, örn. “Mum yakma, 15 dakika önce”';

  @override
  String get noSnooze => 'Erteleme yok';

  @override
  String snoozeUpTo(int times, int minutes) {
    return '$minutes dk için en fazla $times× ertele';
  }

  @override
  String get wakeUpCheck => 'Uyanma kontrolü';

  @override
  String get wakeUpCheckHint => 'Durdurduktan sonra “Uyandım”a dokunmazsan 3 dakika sonra yine çalar';

  @override
  String get solveSum => 'Durdurmak için işlem çöz';

  @override
  String get provesAwake => 'Uyanık olduğunu kanıtlar';

  @override
  String get shabbatNoTasks =>
      'Şabat ve bayramlarda bunların hiçbiri geçerli değildir: alarmlar kendiliğinden durur ve asla telefona dokunmanı istemez.';

  @override
  String get testAlarmIn1 => '1 dakika içinde deneme alarmı çal';

  @override
  String get timesDisclaimer =>
      'Saatler telefonda hesaplanır. Sınır durumlarda hahamına danış ya da cemaat takvimine bak.';

  @override
  String get recommended => 'Önerilen';

  @override
  String get chooseCity => 'Bir şehir seç';

  @override
  String get testOnlyOnPhone => 'Deneme alarmları yalnızca telefonda çalışır.';

  @override
  String get testAlarm => 'Deneme alarmı';

  @override
  String get testAlarmBody => 'Alarmların böyle çalacak';

  @override
  String get testAlarmIn1Set => 'Deneme alarmı 1 dakika içinde. Telefonunu kilitleyebilirsin.';

  @override
  String get presetGone => 'Bu şablon artık yok.';

  @override
  String get editPreset => 'Şablonu düzenle';

  @override
  String get on => 'Açık';

  @override
  String get ringsHeading => 'ÇALAR';

  @override
  String get noTimesYet => 'Henüz saat yok. Aşağıdan ekle.';

  @override
  String get atTheMomentItself => 'Tam o anda';

  @override
  String get remove => 'Kaldır';

  @override
  String get addATime => 'Saat ekle';

  @override
  String get resetPreset => 'Orijinaline döndür';

  @override
  String get skipOneHint =>
      'Tek bir alarmı atlamak için ana ekranda “Bu haftanın alarmları” altında ona dokun.';

  @override
  String get unitMinutes => 'dakika';

  @override
  String get unitHours => 'saat';

  @override
  String get unitDays => 'gün';

  @override
  String get before => 'Önce';

  @override
  String get after => 'Sonra';

  @override
  String get oneWeek => '1 hafta';

  @override
  String daysShort(int n) {
    return '$n g';
  }

  @override
  String hoursShort(int n) {
    return '$n sa';
  }

  @override
  String get howToSearch => 'Nasıl aranır';

  @override
  String get searchHelpWord => 'Başlıkta “dentist” geçer, büyük küçük harf fark etmez';

  @override
  String get searchHelpStar => '* herhangi harfler demek: dentist, dentures';

  @override
  String get searchHelpQuestion => '? tek harf demek: yoga, toga';

  @override
  String get searchHelpPhrase => 'Tam olarak bu ifade';

  @override
  String get searchHelpAnd => 'İki kelime de (AND)';

  @override
  String get searchHelpOr => 'Herhangi biri. | da çalışır';

  @override
  String get searchHelpNot => 'Hariç tut. NOT ve ! da çalışır';

  @override
  String get searchHelpBrackets => 'Parantezler kelimeleri gruplar';

  @override
  String get searchHelpEmpty => 'Her etkinlikte çalması için boş bırak.';

  @override
  String get customTime => 'Başka süre';

  @override
  String get other => 'Diğer';

  @override
  String get sun => 'Güneş';

  @override
  String get calendar => 'Takvim';

  @override
  String get newEventAlarm => 'Yeni etkinlik alarmı';

  @override
  String get eventAlarm => 'Etkinlik alarmı';

  @override
  String get findEventsHeading => 'ETKİNLİK BUL';

  @override
  String get searchEventsHint => 'Ara: dişçi, spor OR yoga, diş*…';

  @override
  String get alsoBuiltInTimes => 'Şabat, bayram ve güneş saatleri de';

  @override
  String get alsoBuiltInTimesHint => 'örn. “mum*”, “havdala”, “gün batımı”';

  @override
  String get allMyCalendars => 'Tüm takvimlerim';

  @override
  String get connectToSearch => 'İçinde aramak için takvimleri bağla';

  @override
  String get searching => 'Aranıyor…';

  @override
  String get nothingMatches60 => 'Önümüzdeki 60 günde eşleşen yok';

  @override
  String eventsIn60(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'Önümüzdeki 60 günde $n etkinlik',
      one: 'Önümüzdeki 60 günde 1 etkinlik',
    );
    return '$_temp0';
  }

  @override
  String nextRingsAt(String times, String title) {
    return 'Sonraki: “$title” için $times saatinde çalar';
  }

  @override
  String showMoreLeft(int n) {
    return 'Daha fazla göster ($n kaldı)';
  }

  @override
  String get ringBeforeStartsHeading => 'BAŞLAMADAN ÖNCE ÇAL';

  @override
  String get ringWhenStarts => 'Başladığında çal';

  @override
  String get repeatBeforeHeading => 'VE ÖNCESİNDE TEKRARLA';

  @override
  String get everyPrefix => 'Her ';

  @override
  String get offLower => 'kapalı';

  @override
  String get forInfix => '  süre ';

  @override
  String get ringAfterEndsHeading => 'BİTTİKTEN SONRA ÇAL';

  @override
  String get nameOptional => 'Ad (isteğe bağlı)';

  @override
  String get toppedUp => 'Alarmlar önümüzdeki 7 gün için kurulu ve Quando?’yu her açtığında yenilenir.';

  @override
  String get back => 'Geri';

  @override
  String get next => 'İleri';

  @override
  String get stepWhichEvents => 'Hangi etkinlikler';

  @override
  String get stepWhenToRing => 'Ne zaman çalsın';

  @override
  String get stepHowItRings => 'Nasıl çalsın';

  @override
  String defaultNamed(String name) {
    return 'Varsayılan ($name)';
  }

  @override
  String get phoneAlarmSound => 'Telefonun alarm sesi';

  @override
  String get onlineRadio => 'Çevrimiçi radyo';

  @override
  String songLinkOpens(String app) {
    return 'Şarkı bağlantısı · $app açılır';
  }

  @override
  String get builtIn => 'Yerleşik';

  @override
  String get yourRecording => 'Kaydın';

  @override
  String get sound => 'Ses';

  @override
  String get wakeToOwnSound => 'Kendi sesinle uyan';

  @override
  String get wakeToOwnSoundHint => 'Kendi sesin, bir şarkı, Spotify veya canlı radyo';

  @override
  String musicAdded(String name) {
    return '$name eklendi. Herhangi bir alarmın sesi olarak seç.';
  }

  @override
  String get playlists => 'Çalma listeleri';

  @override
  String get likedSongs => 'Beğenilen şarkılar';

  @override
  String get noPlaylists => 'Henüz çalma listesi yok.';

  @override
  String get noLikedSongs => 'Henüz beğenilen şarkı yok.';

  @override
  String get needsMic => 'Quando? kayıt için mikrofona ihtiyaç duyar.';

  @override
  String recordingN(int n) {
    return 'Kayıt $n';
  }

  @override
  String couldNotAddFile(String error) {
    return 'Dosya eklenemedi: $error';
  }

  @override
  String get addSongLink => 'Şarkı bağlantısı ekle';

  @override
  String get songLink => 'Şarkı bağlantısı';

  @override
  String get songLinkHowTo =>
      'Spotify, Apple Music, YouTube, YouTube Music veya SoundCloud’da Paylaş’a, sonra Bağlantıyı kopyala’ya dokun ve buraya yapıştır.';

  @override
  String get songNameHint => 'Ad, örn. Sabah listesi';

  @override
  String get whenAlarmGoesOffHeading => 'ALARM ÇALDIĞINDA';

  @override
  String get playTheSong => 'Şarkıyı çal';

  @override
  String get ringThenOpen => 'Çal, sonra aç';

  @override
  String get playTheSongHint =>
      'Uygulaması açılır ve çalar. 10 saniye sessiz kalırsa yedek ses çalar, böylece hep uyanırsın. Görevli alarmlar önce çalar, sonra açar.';

  @override
  String get ringThenOpenHint => 'Yedek ses çalar. Durdur, şarkıyı kendi uygulamasında açar.';

  @override
  String get playForHeading => 'ÇALMA SÜRESİ';

  @override
  String get pausesAfter => 'Quando? bu süreden sonra telefonun duraklat tuşuyla şarkıyı duraklatır.';

  @override
  String get backupSoundHeading => 'YEDEK SES';

  @override
  String get notALink => 'Bu bir bağlantıya benzemiyor.';

  @override
  String songOn(String app) {
    return '$app üzerinde şarkı';
  }

  @override
  String get theWeb => 'web';

  @override
  String get pickFromYouTube => 'YouTube’umdan seç';

  @override
  String get youTubeAndMusic => 'YouTube ve YouTube Music';

  @override
  String get youTubeOn => 'Bağlı · çıkmak için basılı tutun';

  @override
  String get youTubeSignIn => 'Google ile giriş yap';

  @override
  String get addSongLinkInstead => 'Bunun yerine şarkı bağlantısı ekle.';

  @override
  String get googleSignInFailed => 'Google girişi tamamlanmadı. Tekrar dene.';

  @override
  String get myYouTube => 'YouTube’um';

  @override
  String get spotifyDirectOn => 'Spotify doğrudan çalma açık';

  @override
  String get spotifyDirect => 'Spotify doğrudan çalma';

  @override
  String get spotifyDirectOnHint => 'Açık · kapatmak için dokunun';

  @override
  String get spotifyDirectHint => 'Tam o şarkıyı çalar. Premium gerekir.';

  @override
  String get spotifyComingSoon => 'Yakında · Premium gerekir';

  @override
  String get spotifyFailed =>
      'Spotify bağlanmadı. Spotify uygulamasının yüklü olduğunu, giriş yaptığını ve Premium olduğunu kontrol et.';

  @override
  String get nameThisSound => 'Bu sese ad ver';

  @override
  String get sounds => 'Sesler';

  @override
  String get soundsSentence => 'Kendi sesinle, bir şarkıyla, çalma listesiyle veya canlı radyoyla uyan.';

  @override
  String stopTimer(String time) {
    return 'Durdur · $time';
  }

  @override
  String get record => 'Kaydet';

  @override
  String get addAFile => 'Dosya ekle';

  @override
  String get addSongLinkLong => 'Şarkı bağlantısı ekle (Spotify, Apple Music, YouTube…)';

  @override
  String get musicAppsHeading => 'MÜZİK UYGULAMALARI';

  @override
  String get pickFromSpotify => 'Spotify’ımdan seç';

  @override
  String get yourPlaylistsAndLiked => 'Çalma listelerin ve beğendiğin şarkılar';

  @override
  String get mySpotify => 'Spotify’ım';

  @override
  String get spotifySignInFailed => 'Spotify’a giriş yapılamadı.';

  @override
  String get appleMusicNote => 'Giriş iPhone sürümüyle gelecek. Şimdilik bir şarkı bağlantısı ekle.';

  @override
  String noSignInNote(String service) {
    return '$service diğer uygulamaların giriş yapmasına izin vermiyor. Bunun yerine şarkı bağlantısı ekle.';
  }

  @override
  String get wakeToRadio => 'Çevrimiçi radyoyla uyan';

  @override
  String get soundsExplain =>
      '5 dakikaya kadar kayıt yapın, dosya, şarkı bağlantısı veya canlı radyo ekleyin. Bir sorun olursa yedek ses çalar.';

  @override
  String get yourSoundsHeading => 'SESLERİN';

  @override
  String playsIn(String app) {
    return '$app içinde çalar';
  }

  @override
  String opensIn(String app) {
    return '$app içinde açılır';
  }

  @override
  String forSpan(String span) {
    return '$span boyunca';
  }

  @override
  String get defaultLabel => 'Varsayılan';

  @override
  String get radioUnreachable => 'İstasyon listesine ulaşılamadı. Bağlantını kontrol et.';

  @override
  String get addStreamAddress => 'Yayın adresi ekle';

  @override
  String get notAStream => 'Bu bir yayın adresine benzemiyor (http ile başlar).';

  @override
  String get anyGenre => 'Herhangi bir tür';

  @override
  String get stationName => 'İstasyon adı';

  @override
  String get closeSearch => 'Aramayı kapat';

  @override
  String get searchByName => 'Ada göre ara';

  @override
  String get anywhere => 'Her yerde';

  @override
  String get noStations => 'İstasyon bulunamadı. Başka bir tür ya da ülke dene.';

  @override
  String wakeUpTo(String name) {
    return '$name ile uyan';
  }

  @override
  String get notQuite => 'Neredeyse. Tekrar dene.';

  @override
  String shabbatStopsItself(int n) {
    return 'Şabat modu: $n saniye içinde kendisi durur. Telefona dokunmana gerek yok.';
  }

  @override
  String get solveToSnooze => 'ERTELEMEK İÇİN ÇÖZ';

  @override
  String get solveToStop => 'DURDURMAK İÇİN ÇÖZ';

  @override
  String get answer => 'Cevap';

  @override
  String get snooze => 'Ertele';

  @override
  String get stop => 'Durdur';

  @override
  String get shakeToSnooze => 'ERTELEMEK İÇİN SALLA';

  @override
  String get shakeToStop => 'DURDURMAK İÇİN SALLA';

  @override
  String get shakeHard => 'Çubuk dolana kadar telefonu sertçe salla.';

  @override
  String get cantShake => 'Sallayamıyor musun? İşlem çöz';

  @override
  String get pairsToSnooze => 'ERTELEMEK İÇİN EŞLERİ BUL';

  @override
  String get pairsToStop => 'DURDURMAK İÇİN EŞLERİ BUL';

  @override
  String get typeToSnooze => 'ERTELEMEK İÇİN BUNU YAZ';

  @override
  String get typeToStop => 'DURDURMAK İÇİN BUNU YAZ';

  @override
  String get scanToSnooze => 'ERTELEMEK İÇİN KODUNU TARA';

  @override
  String get scanToStop => 'DURDURMAK İÇİN KODUNU TARA';

  @override
  String ringAgainUnless(int n) {
    return 'Aşağıya dokunmazsan $n dakika sonra yine çalacağım.';
  }

  @override
  String get imUp => 'Uyandım';

  @override
  String snoozeMin(int n) {
    return '$n dk ertele';
  }

  @override
  String snoozeMinLeft(int n, int left) {
    return '$n dk ertele · $left kaldı';
  }

  @override
  String get noSnoozesLeft => 'Erteleme hakkı kalmadı';

  @override
  String get stopThenOpen => 'Durdur · sonra aç';

  @override
  String get startingSong => 'Şarkın başlatılıyor';

  @override
  String wayToStop(String way) {
    return 'Durdurmak için $way';
  }

  @override
  String wayToSnooze(String way) {
    return 'Ertelemek için $way';
  }

  @override
  String ringsForMore(int n) {
    return '$n saniye daha çalar';
  }

  @override
  String get leftToRing => 'kaldı';

  @override
  String get wayVolumeButtons => 'Ses tuşları';

  @override
  String get wayShake => 'Telefonu salla';

  @override
  String get taskNothing => 'Hiçbir şey';

  @override
  String get taskSum => 'İşlem çöz';

  @override
  String get taskShake => '30 kez salla';

  @override
  String get taskMemory => 'Hafıza oyunu';

  @override
  String get taskPhrase => 'Bir cümle yaz';

  @override
  String get taskScan => 'Kod tara';

  @override
  String get noLimit => 'sınırsız';

  @override
  String upToTimes(int n) {
    return 'en fazla $n×';
  }

  @override
  String shorterEachTime(int n) {
    return 'her seferinde $n dk daha kısa';
  }

  @override
  String autoSnoozeAfter(int n) {
    return '$n dk sonra kendisi erteler';
  }

  @override
  String get card => 'Kart';

  @override
  String get hiddenCard => 'Gizli kart';

  @override
  String get phrase1 => 'Uyandım ve bu gün benim';

  @override
  String get phrase2 => 'Şimdi değilse ne zaman';

  @override
  String get phrase3 => 'Bana ve sevdiğim herkese günaydın';

  @override
  String get phrase4 => 'Ayaklarım yerde ve kalktım';

  @override
  String get phrase5 => 'Bugün yeniden başlıyorum';

  @override
  String get notQuiteWords => 'Neredeyse, her kelimeyi kontrol et.';

  @override
  String get typeItHere => 'Buraya yaz';

  @override
  String get differentCode => 'Bu farklı bir kod.';

  @override
  String get cameraUnavailable => 'Kamera kullanılamıyor.';

  @override
  String get cantScan => 'Tarayamıyor musun? İşlem çöz';

  @override
  String get saveCodeToScan => 'Taranacak bir kod kaydet';

  @override
  String get saveCodeHint =>
      'Yürüyerek gitmen gereken bir yerdeki barkod veya QR koda tut, mutfaktaki bir kutu ya da banyodaki diş macunu gibi. Alarmı durdurmak için onu yeniden tarayacaksın.';

  @override
  String get cameraUnavailableSettings => 'Kamera kullanılamıyor. Ayarlar’da kamera erişimine izin ver.';

  @override
  String gentleToGo(int n) {
    return 'Yumuşak uyanış · $n dk kaldı';
  }

  @override
  String previewBody(String body) {
    return 'Önizleme · $body';
  }

  @override
  String snoozedBody(String body) {
    return 'Ertelendi: $body';
  }

  @override
  String get areYouUp => 'Uyandın mı?';

  @override
  String get tapImUp => 'Durdurmak için “Uyandım”a dokun';

  @override
  String get volume => 'Ses';

  @override
  String get wakeCheckOn => 'Uyanma kontrolü açık';

  @override
  String get stopsAtOnce => 'Hemen durur';

  @override
  String get ringsAgainIfNotUp => 'Kalkmazsan yine çalar';

  @override
  String get openAppAfter => 'Sonra bir uygulama aç';

  @override
  String get noTask => 'Görev yok';

  @override
  String get codeSaved => 'Kod kaydedildi';

  @override
  String get tapToSaveDifferent => 'Başkasını kaydetmek için dokun';

  @override
  String get controlsHeading => 'KONTROLLER';

  @override
  String get onScreen => 'Ekranda';

  @override
  String get taskHeading => 'GÖREV';

  @override
  String get none => 'Yok';

  @override
  String get snoozeSentence => 'Beş dakika daha mı? Ne kadar, kaç kez ve ne gerektiğini seç.';

  @override
  String get settingsHeading => 'AYARLAR';

  @override
  String get snoozeTime => 'Erteleme süresi';

  @override
  String get snoozeTimeHint => 'İlk ertelemenin uzunluğu';

  @override
  String get shortenSnoozes => 'Sonraki ertelemeleri kısalt';

  @override
  String get shortenSnoozesHint => 'İlkinden sonraki her erteleme bu kadar kısalır';

  @override
  String get autoSnooze => 'Otomatik erteleme';

  @override
  String get autoSnoozeHint => 'Dokunmazsan şu süreden sonra kendisi erteler';

  @override
  String get never => 'Asla';

  @override
  String get snoozeLimit => 'Erteleme sınırı';

  @override
  String get snoozeLimitHint => 'Kaç kez erteleyebilirsin';

  @override
  String get unlimited => 'Sınırsız';

  @override
  String get useSnoozeFromSettings => 'Ayarlar’daki ertelemeyi kullan';

  @override
  String get stopSentence => 'Alarmı nasıl kapatacağın ve önce ne yapman gerektiği.';

  @override
  String get shabbatNoTask => 'Şabat ve bayramlarda alarmlar kendiliğinden durur ve asla görev istemez.';

  @override
  String get volumeSentence => 'Ne kadar yüksek çaldığı ve oraya ne kadar yumuşak ulaştığı.';

  @override
  String get openAfterAlarm => 'Alarmdan sonra aç';

  @override
  String get pickAnApp => 'Bir uygulama seç';

  @override
  String get orPasteLink => 'Ya da bağlantı yapıştır: https://…';

  @override
  String get useThisLink => 'Bu bağlantıyı kullan';

  @override
  String get noAppsFound => 'Uygulama bulunamadı.';

  @override
  String get weather => 'Hava durumu';

  @override
  String get news => 'Haberler';

  @override
  String get usePhoneVolume => 'Telefonun alarm sesini kullan';

  @override
  String get setsPhoneVolume => 'Çalarken telefonun alarm sesini ayarlar, sonra geri getirir.';

  @override
  String get fadeInOff => 'Yükselme kapalı, hemen tam ses';

  @override
  String fadeInOver(String span) {
    return '$span içinde yükselir';
  }

  @override
  String get fadeOutOff => 'Alçalma kapalı';

  @override
  String fadeOutOver(String span) {
    return 'Son $span içinde alçalır';
  }

  @override
  String get fadesExplain =>
      'Alçalma, alarm kendisi durduğunda olur. Geçişler çalma süresinden uzunsa ikisi de kısalır.';

  @override
  String get soundSoftChime => 'Yumuşak çan';

  @override
  String get soundMorningRise => 'Sabah doğuşu';

  @override
  String get soundClassicBeep => 'Klasik bip';

  @override
  String get calmCity => 'Sakin şehir sabahı';

  @override
  String get calmBirds => 'Şafakta kuşlar';

  @override
  String get calmWaves => 'Kıyıda dalgalar';

  @override
  String get calmRain => 'Hafif yağmur';

  @override
  String get calmStream => 'Orman deresi';

  @override
  String get calmWind => 'Hafif rüzgâr';

  @override
  String get calmFire => 'Çıtırdayan ateş';

  @override
  String get calmNight => 'Yaz gecesi';

  @override
  String get publicDomain => 'Kamu malı';

  @override
  String get phoneVolume => 'Telefon sesi';

  @override
  String fadesIn(String span) {
    return '$span içinde yükselir';
  }

  @override
  String fadesOut(String span) {
    return '$span içinde alçalır';
  }

  @override
  String get noFade => 'geçiş yok';

  @override
  String minSecShort(int m, int s) {
    return '$m dk $s sn';
  }

  @override
  String get happensRings => 'Çalar';

  @override
  String get happensStopped => 'Sen durdurursun';

  @override
  String get happensSnoozed => 'Sen ertelersin';

  @override
  String get happensAutoStopped => 'Kendisi durur';

  @override
  String get eventLower => 'etkinlik';

  @override
  String get appTest => 'Quando? testi';

  @override
  String get pushoverConnected => 'Pushover bağlı';

  @override
  String get webhookConnected => 'Webhook bağlı';

  @override
  String pushoverSaid(int code, String body) {
    return 'Pushover $code dedi: $body';
  }

  @override
  String couldNotReachPushover(String error) {
    return 'Pushover’a ulaşılamadı ($error)';
  }

  @override
  String itAnswered(int code) {
    return 'Yanıt: $code';
  }

  @override
  String couldNotReachIt(String error) {
    return 'Ulaşılamadı ($error)';
  }

  @override
  String get calendarNotAllowed => 'Takvim erişimine izin verilmedi.';

  @override
  String get playlist => 'Çalma listesi';

  @override
  String songCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n şarkı', one: '1 şarkı');
    return '$_temp0';
  }

  @override
  String get spotifySaidNo =>
      'Spotify reddetti. Spotify panosunda Quando? için Web API’yi işaretle ve hesabını User Management’a ekle.';

  @override
  String serviceDidntAnswer(String service, int code) {
    return '$service yanıt vermedi ($code).';
  }

  @override
  String get youTubeSaidNo =>
      'YouTube reddetti. Google hesabının Quando projesinin test kullanıcısı olduğunu kontrol et.';

  @override
  String get event => 'Etkinlik';

  @override
  String eventEnds(String title) {
    return '$title (bitiş)';
  }

  @override
  String foundSoundsDevices(int s, int d) {
    return '$s ses ve $d cihaz bulundu.';
  }

  @override
  String get sentCheckDevices => 'Gönderildi. Diğer cihazlarına bak.';

  @override
  String sentTo(String name) {
    return '$name cihazına gönderildi.';
  }

  @override
  String get zapierHowTo =>
      'Zapier’de “Webhooks by Zapier → Catch Hook” ile başlayan bir Zap oluştur ve URL’sini buraya yapıştır.';

  @override
  String get catchHookUrl => 'Catch Hook URL’si';

  @override
  String get iftttHowTo =>
      'IFTTT’de “Webhooks → Receive a web request with a JSON payload” ile başlayan bir applet oluştur. Burada aynı etkinlik adını kullan. Anahtarın ifttt.com/maker_webhooks/settings adresinde.';

  @override
  String get eventName => 'Etkinlik adı';

  @override
  String get webhooksKey => 'Webhooks anahtarı';

  @override
  String get webhookHowTo => 'Quando? bu adrese bir JSON POST gönderir.';

  @override
  String get connectionsSentence =>
      'Bir alarm çaldığında, durdurulduğunda veya ertelendiğinde diğer uygulama ve cihazlara haber ver.';

  @override
  String get pushWhenRings => 'Alarm çalınca bildirim gönder';

  @override
  String get pushWhenRingsHint => 'Diğer telefonlarına, tabletlerine, saatine veya bilgisayarına';

  @override
  String get yourUserKey => 'Kullanıcı anahtarın';

  @override
  String get appToken => 'Uygulama belirteci';

  @override
  String get soundAndDevicesHeading => 'SES VE CİHAZLAR';

  @override
  String get loading => 'Yükleniyor…';

  @override
  String get loadFromPushover => 'Pushover’dan yükle';

  @override
  String get soundItPlays => 'Çalacak ses';

  @override
  String get myPushoverDefault => 'Pushover varsayılanım';

  @override
  String get pushoverOwnSounds => 'Kendi seslerin pushover.net/sounds’a yükledikten sonra burada görünür.';

  @override
  String get allMyDevices => 'Tüm cihazlarım';

  @override
  String get pushoverOnThisPhone =>
      'Pushover uygulamasını bu telefona da kur, burada da Pushover sesinle çalsın.';

  @override
  String get priority => 'Öncelik';

  @override
  String get priorityNormal => 'Normal';

  @override
  String get priorityHigh => 'Yüksek: sessiz saatleri atlar';

  @override
  String get priorityEmergency => 'Acil: onaylanana kadar tekrarlar';

  @override
  String get sending => 'Gönderiliyor…';

  @override
  String get sendATest => 'Test gönder';

  @override
  String get findUserKey => 'Kullanıcı anahtarımı bul';

  @override
  String get makeAppToken => 'Uygulama belirteci oluştur';

  @override
  String get webhooksHeading => 'ZAPIER, IFTTT VE WEBHOOK’LAR';

  @override
  String get webhooksExplain =>
      'Bir alarm çaldığında veya onu durdurduğunda her şeyi başlat: ışıkları aç, uyanma saatini kaydet, birine mesaj at.';

  @override
  String get sendWhenAlarm => 'Alarm şunu yaptığında gönder:';

  @override
  String get pauseOnShabbat => 'Şabat ve bayramlarda duraklat';

  @override
  String get pauseOnShabbatHint => 'Mum yakma ile havdala arasındaki alarmlar için hiçbir şey gönderilmez';

  @override
  String get webhookPayloadNote =>
      'Her mesaj şunları içerir: event (ring, stopped, snoozed, auto_stopped), title, body, time, shabbat ve snoozes. Anahtarlar bu telefonda kalır.';

  @override
  String get today => 'Bugün';

  @override
  String get tomorrow => 'Yarın';

  @override
  String get notAWebAddress => 'Bu https:// ile başlayan bir web adresine benzemiyor';

  @override
  String get language => 'Dil';

  @override
  String get phoneLanguage => 'Telefonun dili';

  @override
  String get ringQuote => 'Şimdi değilse, ne zaman?';

  @override
  String get ringQuoteBy => 'Hillel';

  @override
  String get quotesTitle => 'Zaman üzerine sözler';

  @override
  String get quotesHint =>
      'Nereden geleceklerini seç. Günün her bölümü için bir tane; başka bir söz için dokun.';

  @override
  String get quotesOff => 'Kapalı';

  @override
  String get quoteSongs => 'Şarkılar';

  @override
  String get quoteMovies => 'Filmler';

  @override
  String get quoteLiterature => 'Kitaplar ve şiirler';

  @override
  String get quoteTanakh => 'Tanah (İbranice Kutsal Kitap)';

  @override
  String get quoteSages => 'Talmud ve bilgeler';

  @override
  String get quoteSpeeches => 'Ünlü konuşmalar';

  @override
  String get quotePhilosophy => 'Filozoflar';

  @override
  String get quoteProverbs => 'Atasözleri ve deyişler';

  @override
  String get quotesAlso => 'Ayrıca göster';

  @override
  String get quoteCarnaval => 'Karnaval';

  @override
  String get quoteCarnavalHint => 'Brezilya Karnavalı boyunca şarkılar ve sözler';

  @override
  String get quoteNearMe => 'Yakınımda';

  @override
  String get quoteNearMeHint => 'Bulunduğun yerin şairleri ve günleri; saat dilimine ve Şabat şehrine göre';

  @override
  String get quoteSiddur => 'Sidur (dua kitabı)';

  @override
  String weeklyParasha(String name) {
    return 'Paraşa $name';
  }

  @override
  String poweredBy(String name) {
    return '$name altyapısıyla';
  }

  @override
  String get syncTitle => 'Cihazlarımı eşitle';

  @override
  String get syncHint => 'Alarmların ve ayarların tüm cihazlarında aynı kalması için Google ile giriş yap.';

  @override
  String syncOn(String email) {
    return 'On · $email';
  }

  @override
  String get syncWorking => 'Connecting…';

  @override
  String get syncNotAllowed => 'This Google account can\'t sync.';

  @override
  String get syncFailed => 'Bağlanılamadı. Tekrar denemek için dokun.';

  @override
  String get syncStop => 'Stop syncing';

  @override
  String get syncNotSetUp => 'Eşitleme bu sürümde henüz kurulmadı.';

  @override
  String get ringTheseAfterAll => 'Yine de çalsın';

  @override
  String skipTheseDay(int n) {
    return 'Bugün bu $n alarmı atla';
  }

  @override
  String turnOffNamed(String name) {
    return '“$name” alarmını kapat';
  }

  @override
  String turnOnNamed(String name) {
    return '“$name” alarmını aç';
  }

  @override
  String turnedOffNamed(String name) {
    return '“$name” kapatıldı';
  }

  @override
  String removeTimeFrom(String time, String name) {
    return '“$time” saatini “$name” alarmından kaldır';
  }

  @override
  String removedTimeFrom(String time, String name) {
    return '“$time” saati “$name” alarmından kaldırıldı';
  }

  @override
  String get moveToGroup => 'Bir gruba taşı';

  @override
  String inGroupMove(String group) {
    return '“$group” grubunda, taşı';
  }

  @override
  String movedToGroup(String group) {
    return '“$group” grubuna taşındı';
  }

  @override
  String deleteNamed(String name) {
    return '“$name” alarmını sil';
  }

  @override
  String get signInWithGoogle => 'Google ile giriş yap';

  @override
  String get signOut => 'Sign out';

  @override
  String get signInWithEmail => 'E-posta ile giriş yap';

  @override
  String get signIn => 'Sign in';

  @override
  String get createAccount => 'Hesap oluştur';

  @override
  String get haveAccount => 'Hesabım var';

  @override
  String get forgotPassword => 'Şifreni mi unuttun?';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get passwordResetSent => 'Yeni şifre seçmen için sana bir bağlantı gönderdik.';

  @override
  String emailCheckInbox(String email) {
    return '$email adresine bir bağlantı gönderdik. Bağlantıyı aç, sonra geri dönüp “Onayladım”a dokun.';
  }

  @override
  String get emailConfirmed => 'Onayladım';

  @override
  String get emailNotYet => 'Henüz onaylanmadı. Önce e-postadaki bağlantıyı aç.';

  @override
  String get emailSendAgain => 'E-postayı tekrar gönder';

  @override
  String get emailSentAgain => 'Gönderildi. Gelen kutunu ve spam klasörünü kontrol et.';

  @override
  String get emailInvalid => 'Bu bir e-posta adresine benzemiyor.';

  @override
  String get emailWrong => 'E-posta veya şifre yanlış.';

  @override
  String get emailInUse =>
      'Bu e-posta ile zaten bir hesap var. Giriş yap veya hesabı Google ile oluşturduysan Google’ı kullan.';

  @override
  String get passwordWeak => 'En az 6 karakterlik bir şifre seç.';

  @override
  String get emailNotSwitchedOn => 'E-posta ile giriş henüz açılmadı.';

  @override
  String get tooManyTries => 'Çok fazla deneme. Birkaç dakika bekle.';

  @override
  String get spotifyLibrary => 'Spotify';

  @override
  String get spotifyLibrarySignIn => 'Çalma listeleri, beğenilenler ve arama';

  @override
  String get spotifyLibraryOn => 'Bağlı · çıkmak için basılı tutun';

  @override
  String spotifyLoginError(String reason) {
    return 'Spotify girişi olmadı: $reason';
  }

  @override
  String googleSignInError(String reason) {
    return 'Google girişi olmadı: $reason';
  }

  @override
  String get searchSongsHint => 'Şarkı, sanatçı, çalma listesi ara';

  @override
  String nothingFound(String query) {
    return '“$query” için sonuç yok.';
  }

  @override
  String get deliveryTitle => 'Bildirim biçimi';

  @override
  String get deliveryLocal => 'Yerel ses';

  @override
  String get deliveryBoth => 'İkisi de';

  @override
  String get deliveryConnect => 'Pushover bağla';

  @override
  String get deliveryLoadFailed => 'Sesler ve cihazlar yüklenemedi. Tekrar deneyin.';

  @override
  String get deliveryBothHint => 'Pushover başarısız olsa da yerel ses çalar.';

  @override
  String get deliveryPushHint => 'Yalnızca Pushover. Bildirim anında bu cihaz çevrimiçi olmalıdır.';

  @override
  String get deliveryFallback => 'Pushover bağlantısı kesildiğinde veya duraklatıldığında yerel ses korunur.';

  @override
  String get deliveryReset => 'Mevcut ayarları kullan';

  @override
  String get beforeShabbat => 'Şabat öncesi';

  @override
  String get preparationReminders => 'Hazırlık hatırlatmaları';

  @override
  String get skipThisWeek => 'Bu haftayı atla';

  @override
  String get restoreThisWeek => 'Bu haftayı geri yükle';

  @override
  String get allAlarms => 'All alarms';

  @override
  String get timesAndSound => 'Saatler ve ses';

  @override
  String get changeCity => 'Change city';

  @override
  String get useMyLocation => 'Konumumu kullan';

  @override
  String get locationUnavailable => 'Konum geçici olarak kullanılamıyor. Tekrar dene veya bir şehir seç.';

  @override
  String get locationReview => 'Bu konumu onayla';

  @override
  String get locationDeviceOnly =>
      'Bu konum yalnızca bu cihazda saklanır. Bu saatleri kullanmadan önce saat dilimini ve İsrail ayarını kontrol et.';

  @override
  String timesIn(String city, String zone) {
    return '$city · $zone · şehir saati';
  }

  @override
  String get preparationOff => 'Hazırlık hatırlatmaları kapalı. Havdala ve normal alarmlar değişmez.';

  @override
  String get preparationSkipped => 'Hazırlık hatırlatmaları bu hafta atlandı. Haftalık ayarların korunur.';

  @override
  String get shabbatControls => 'Şabat denetimleri';

  @override
  String get duringAfterShabbat => 'Şabat sırasında / sonrasında';

  @override
  String locationCoordinates(String latitude, String longitude) {
    return 'Enlem $latitude · boylam $longitude';
  }

  @override
  String get currentLocation => 'Geçerli konum';

  @override
  String get testPushoverSound => 'Pushover’da sesi dene';

  @override
  String get pushoverSoundTestHint =>
      'Seçtiğin sesi seçtiğin Pushover cihazlarında çalar. Sessiz ve sessiz saat ayarları yine geçerlidir.';

  @override
  String get pushoverShareDevices => 'Kimlik bilgilerini cihazlarımla paylaş';

  @override
  String get pushoverShareHint =>
      'Pushover kullanıcı anahtarın ve uygulama jetonun, giriş yapmış hesabını Quando? ve Matai? arasında takip edebilir.';

  @override
  String get pushoverShareQueued => 'Kimlik bilgileri giriş yapmış cihazların için sıraya alındı.';

  @override
  String get pushoverShareSignIn =>
      'Pushover kimlik bilgilerini paylaşmak için her cihazda aynı uygulama hesabıyla giriş yap.';

  @override
  String get smartHomeHeading => 'Smart home';

  @override
  String get smartHomeHint =>
      'Tuya senaryolarını doğrudan çalıştır veya kendi Home Assistant ya da Node-RED otomasyonlarını bağla.';

  @override
  String get shareServices => 'Servis bağlantılarını paylaş';

  @override
  String get shareServicesHint =>
      'Pushover, Tuya, Spotify kitaplığı ve otomasyon bağlantılarını paylaşmak için cihazlarında aynı uygulama hesabını kullan. YouTube ve cihaz izinleri her cihazda yine onay gerektirebilir.';

  @override
  String get tuyaSetupHint =>
      'Bağlı Tuya geliştirici projeni kullan. Veri merkezini, Access ID’yi, Access Secret’ı ve “Link App Account” altında görünen UID’yi gir. Home Assistant gerekmez.';

  @override
  String get tuyaDataCenter => 'Data center';

  @override
  String get tuyaUserId => 'Bağlı hesap UID’si';

  @override
  String get tuyaAccessId => 'Access ID / Client ID';

  @override
  String get tuyaAccessSecret => 'Access Secret / Client Secret';

  @override
  String get tuyaLoadScenes => 'Load scenes';

  @override
  String get tuyaNoScenes =>
      'Kullanılabilir Tap-to-Run senaryosu bulunamadı. Bağlı hesabı, veri merkezini ve senaryo API izinlerini kontrol et.';

  @override
  String get tuyaRunNow => 'Senaryoyu şimdi çalıştır';

  @override
  String get tuyaRunConfirm => 'Bu senaryo şimdi Tuya cihazlarında çalıştırılsın mı?';

  @override
  String get tuyaSent => 'Tuya senaryo komutunu kabul etti. Cihazlarını kontrol et.';

  @override
  String get tuyaFailed =>
      'Tuya isteği tamamlayamadı. Proje izinlerini, veri merkezini ve aboneliği kontrol et. Hata:';

  @override
  String get tuyaAlarmScene => 'Bu alarm çaldığında Tuya senaryosu';

  @override
  String get homeAssistantHowTo =>
      'POST ve JSON kabul eden bir Webhook tetikleyicisiyle Home Assistant otomasyonu oluştur. URL’sini buraya yapıştır. Eylemlerini seçmek için alarm olayını (ring, stopped, snoozed veya auto_stopped) kullan. Yeni cihazlara bu bağlantı kapalı gelir.';

  @override
  String get nodeRedHowTo =>
      'POST kabul eden bir Node-RED HTTP In düğümü, ardından otomasyonun ve bir HTTP Response düğümü kullan. Uç noktayı buraya yapıştır. Yerel HTTP merkezleri ve HTTPS uç noktaları desteklenir.';

  @override
  String get smartHomeConnect => 'Akıllı ev servisi bağla';

  @override
  String get automationTestHint => 'Test, bağlı otomasyonu hemen çalıştırır.';

  @override
  String get smartHomeDeviceOn => 'Akıllı ev alarm eylemlerini bu cihazda çalıştır';

  @override
  String get smartHomeDeviceHint =>
      'Otomasyonlarını çalıştıracak tek bir cihaz seç. Bağlantılar paylaşılır; bu anahtar yalnızca bu cihazda geçerlidir.';

  @override
  String get smartHomeDeviceOff =>
      'Alarm eylemleri bu cihazda kapalı. Bağlantılar’dan aç; elle senaryo testleri yine çalışır.';

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
  String get weatherSwipeHint => 'Gökyüzü ile hava durumu arasında kaydır';

  @override
  String get parashaHeading => 'Haftalık parşa';

  @override
  String get dailyStudyHeading => 'Günlük öğrenme';

  @override
  String get courseDaf => 'Daf Yomi';

  @override
  String get courseRambam1 => 'Rambam · günde 1 bölüm';

  @override
  String get courseRambam3 => 'Rambam · günde 3 bölüm';

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
  String get moonAlwaysUp => 'Ay gün boyu ufkun üstünde';

  @override
  String get moonAlwaysDown => 'Ay gün boyu ufkun altında';

  @override
  String get noRiseToday => 'Bugün doğuş yok';

  @override
  String get noSetToday => 'No set today';

  @override
  String get moonNew => 'New moon';

  @override
  String get moonWaxingCrescent => 'Hilal (büyüyen)';

  @override
  String get moonFirstQuarter => 'İlk dördün';

  @override
  String get moonWaxingGibbous => 'Şişkin ay (büyüyen)';

  @override
  String get moonFull => 'Full moon';

  @override
  String get moonWaningGibbous => 'Şişkin ay (küçülen)';

  @override
  String get moonLastQuarter => 'Last quarter';

  @override
  String get moonWaningCrescent => 'Hilal (küçülen)';

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
  String get weatherThunder => 'Gök gürültülü fırtınalar';

  @override
  String get weatherUnavailable => 'Hava durumu geçici olarak kullanılamıyor';

  @override
  String get weatherCached => 'Kayıtlı tahmin';

  @override
  String get weatherUpdated => 'Updated';

  @override
  String get weatherForecast => 'Forecast';

  @override
  String get weatherThunderExpected => 'Gök gürültülü fırtına bekleniyor';

  @override
  String get learningUnavailable => 'Bu ayın öğrenme programını yüklemek için bağlan';

  @override
  String get festivalReading => 'Bayram Tora okuması';

  @override
  String get learningCalendarSource => 'Öğrenme takvimi · Hebcal · CC BY 4.0';

  @override
  String get weatherSource => 'Tahmin · MET Norway · CC BY 4.0';

  @override
  String get weatherConsent =>
      'Seçtiğiniz şehrin hava durumu. MET Norway ile yuvarlanmış koordinatlar kullanır.';

  @override
  String get learningConsent =>
      'Rambam ve diğer çalışma programları Hebcal’den yüklenir ve çevrimdışı kullanım için kaydedilir.';

  @override
  String get homeRefresh => 'Refresh';

  @override
  String get skyTimezone => 'My timezone';

  @override
  String get skyShabbat => 'Shabbat city';

  @override
  String get skyReferenceCity => 'Saat dilimi referans şehri';

  @override
  String get skyChooseCity => 'Gökyüzü şehrini seç';

  @override
  String get skyCityExplain =>
      'Güneş ve Ay bu şehrin koordinatlarını kullanır. Şabat şehrin ve alarm saat dilimin seçtiğin gibi kalır.';

  @override
  String get skySun => 'Sun today';

  @override
  String get skyMoon => 'Moon today';

  @override
  String get moonAboveHorizon => 'Ay ufkun üstünde';

  @override
  String get moonBelowHorizon => 'Ay ufkun altında';

  @override
  String get moonNextNew => 'Sonraki yeni ay';

  @override
  String get moonNextFull => 'Sonraki dolunay';

  @override
  String get locationServicesOff => 'Konum Servisleri kapalı. Ayarlar’dan aç veya bir şehir seç.';

  @override
  String get locationDenied => 'Konum erişimi reddedildi. Ayarlar’dan izin ver veya bir şehir seç.';

  @override
  String get locationTimedOut =>
      'Henüz konum alınamadı. Mac’te Wi-Fi’yi açık tut ve tekrar dene veya bir şehir seç.';

  @override
  String get locationTimeZoneUnavailable =>
      'Konumu kullanmadan önce seçili saat dilimindeki bir şehri kullan veya cihazının saat dilimini izle.';

  @override
  String get locationSettings => 'Konum ayarlarını aç';

  @override
  String get locationLooking => 'Konum alınıyor…';

  @override
  String get skyMoonDisplay => 'Ay’ı göster: doğuş, batış ve evre';

  @override
  String get tuyaConsumerPending =>
      'Hesapla giriş bu sürümde henüz kullanılamıyor. Zaten bir Tuya geliştirici projen varsa gelişmiş kurulumu kullan.';

  @override
  String get tuyaAdvanced => 'Gelişmiş kurulum';

  @override
  String get tuyaSignInTitle => 'Smart Life hesabınla giriş yap';

  @override
  String get tuyaSignInHint =>
      'Smart Life veya Tuya Smart uygulamasındaki ülke, e-posta ya da telefon ve şifrenin aynısını kullan. Hesap Tuya projene önceden bağlı olmalı. Şifre yalnızca Tuya’ya gider ve hiç kaydedilmez.';

  @override
  String get tuyaCountryCode => 'Ülke kodu (Brezilya 55, ABD 1)';

  @override
  String get tuyaAccount => 'Smart Life e-postası veya telefonu';

  @override
  String get tuyaPassword => 'Smart Life şifresi';

  @override
  String get tuyaSignIn => 'Giriş yap ve sahneleri yükle';

  @override
  String get tuyaRelayUrl => 'Quando Tuya aktarıcı adresi (https)';

  @override
  String get tuyaRelayHint =>
      'Smart Life veya Tuya Smart hesabının ülkesini, e-postasını ya da telefonunu ve şifresini kullan. Bunlar Quando’nun Tuya aktarıcısına bir kez gider ve kaydedilmez. Quando hesabında oturum açmış olmalısın.';

  @override
  String get tuyaGoogleHint =>
      'Smart Life’a Google veya Apple ile mi giriyorsun? Smart Life’ta “Şifremi unuttum”a dokunup bir şifre belirle ve burada kullan.';

  @override
  String get tuyaLinked => 'Smart Life hesabı bağlandı';

  @override
  String get tuyaUnlink => 'Bağlantıyı kes';

  @override
  String get tuyaNeedsAccount => 'Önce Ayarlar’dan Quando hesabında oturum aç.';

  @override
  String get roshHodeshHeading => 'Rosh Hodesh';

  @override
  String get roshHodeshExplain => 'Ana ekranda sonraki İbrani ayının ilk gününü veya iki gününü gösterir.';

  @override
  String get roshHodeshNext => 'Sonraki Roş Hodeş';

  @override
  String get roshHodeshBegins => 'Gün batımında başlar:';

  @override
  String get openParashaSefaria => 'Bu Tora bölümünü Sefaria’da oku';

  @override
  String get skyMyLocation => 'My location';

  @override
  String get skyLocationLocalTimes =>
      'Gökyüzü saatleri bu konumun saat dilimini kullanır. Alarm saat diliminin ve Şabat şehrin değişmez. Yalnızca bu cihazda saklanır.';

  @override
  String get musicRingDurationHint =>
      'Oynatma bu alarmın çalma süresini izler; Durdur veya Ertele ile sona erer.';

  @override
  String get musicBackupPlaying => 'Müzik başlatılamadı. Yerel alarm sesi çalıyor.';

  @override
  String desktopMusicConnect(String service) {
    return '$service uygulamasını bağla';
  }

  @override
  String desktopMusicOn(String service) {
    return '$service bağlı · ayırmak için basılı tutun';
  }

  @override
  String get musicSongs => 'Şarkılar';

  @override
  String get noMusicSongs => 'Müzik arşivinizde şarkı bulunamadı.';

  @override
  String serviceConnectUnavailable(String service) {
    return '$service bağlantısı ekleyin · alarmdan sonra açılır';
  }

  @override
  String get soundCloudWidgetNote => 'Herkese açık bir bağlantı ekleyin';

  @override
  String get youtubePlayerHint =>
      'YouTube, videoyu görünür bir oynatıcıda oynatır. Gizlenirse veya oynatamazsa yerel alarm devam eder.';

  @override
  String get musicPreviewFailed =>
      'Bu ses çalınamadı. Bağlantınızı kontrol edin veya başka bir parça ya da istasyon deneyin.';

  @override
  String get skyMoonPhase => 'Ay evresi';

  @override
  String get skyMoonDetailsDisplay => 'Ay evresi sayfası ekle';

  @override
  String get skyMoonDetailsHint => 'Kaydırarak geçin veya istediğiniz zaman Ay kartına dokunun';

  @override
  String get moonRises => 'Doğuş';

  @override
  String get moonSets => 'Batış';

  @override
  String moonLunarDay(int day) {
    return 'Bu ay döngüsünün 29,5 gününden $day. gün';
  }

  @override
  String get moonDetailsOpen => 'Ay evresini aç';

  @override
  String get musicPlaylists => 'Müzik çalma listeleri';

  @override
  String get videoPlaylists => 'Video çalma listeleri';

  @override
  String get likedVideos => 'Beğenilen videolar';

  @override
  String get wholePlaylist => 'Tüm listeyle uyan';

  @override
  String get noSongsInPlaylist => 'Burada çalınabilecek şarkı yok.';

  @override
  String get hebrewNamesHeading => 'Paraşa ve ay adlarının yazılışı';

  @override
  String get hebrewNamesIsraeli => 'İsrail';

  @override
  String get hebrewNamesAshkenazi => 'Aşkenaz';

  @override
  String pickFromService(String service) {
    return '$service’ımdan seç';
  }

  @override
  String get weatherTonight => 'Bu gece';

  @override
  String get weatherTomorrowMorning => 'Yarın sabah';

  @override
  String weatherUntilAbout(String time) {
    return '$time civarına kadar';
  }

  @override
  String get weatherSunBehindClouds => 'Güneş bulutların ardında';

  @override
  String get keysLockTitle => 'Cihazlarındaki anahtarlar';

  @override
  String get keysLockOff =>
      'Hizmet anahtarların bu cihazda kalır. Diğer cihazlarına şifreli göndermek için bir eşitleme parolası seç.';

  @override
  String get keysLockOn =>
      'Hizmet anahtarların bu cihazdan çıkmadan önce eşitleme parolanla şifrelenir. Başka kimse, Google bile, okuyamaz.';

  @override
  String get keysLockWaiting =>
      'Diğer cihazından anahtarlar kilitli olarak geldi. Açmak için eşitleme parolanı yaz.';

  @override
  String get keysSetPassphrase => 'Parola seç';

  @override
  String get keysChangePassphrase => 'Parolayı değiştir';

  @override
  String get keysUnlock => 'Anahtarları aç';

  @override
  String get keysStartOver => 'Unuttun mu? Baştan başla';

  @override
  String get keysStartOverHint =>
      'Baştan başlamak bu cihazın anahtarlarını yeni bir parolayla gönderir. Diğer cihazların yenisini soracak.';

  @override
  String get keysPassphrase => 'Eşitleme parolası';

  @override
  String get keysPassphraseAgain => 'Tekrar yaz';

  @override
  String keysPassphraseShort(int count) {
    return 'En az $count karakter kullan.';
  }

  @override
  String get keysPassphraseMismatch => 'İkisi eşleşmiyor.';

  @override
  String get keysPassphraseWrong => 'Bu parola bu anahtarları açmıyor.';

  @override
  String get keysPassphraseNote =>
      'Bir yere yaz: unutursan kimse kurtaramaz ve anahtarlarını yeniden girersin.';

  @override
  String get keysShareNeedsPassphrase =>
      'Önce Cihazlarındaki anahtarlar bölümünde bir eşitleme parolası seç.';

  @override
  String get settingsAlarmDefaults => 'Alarm varsayılanları';

  @override
  String get settingsPlacesTime => 'Yerler ve saat';

  @override
  String get settingsLook => 'Görünüm, dil ve alıntılar';

  @override
  String get settingsAbout => 'About';

  @override
  String get defaultForNewAlarms => 'Yeni alarmlar için varsayılan';

  @override
  String get preview => 'Preview';

  @override
  String atClock(String time) {
    return 'at $time';
  }

  @override
  String get connectACalendar => 'Takvim bağla';

  @override
  String get newFromReadyMade => 'Hazır bir alarmdan';

  @override
  String get newFromReadyMadeHint => 'Gün doğumu, gün batımı ve senin için zaten hazırlanmış diğer alarmlar';

  @override
  String get calendarSourcesIntro =>
      'Quando? takvimlerindeki etkinliklerden önce ve sonra çalabilir. Nereden geleceklerini seç.';

  @override
  String get deviceCalendarsHeading => 'BU CİHAZDA';

  @override
  String get deviceCalendarsTitle => 'Bu cihazın takvim uygulaması';

  @override
  String get deviceCalendarsHint =>
      'Üzerindeki tüm hesaplar: Google, Samsung, Outlook, iCloud ve yalnızca burada tutulan takvimler.';

  @override
  String get googleCalendarHeading => 'GOOGLE TAKVİM';

  @override
  String get googleCalendarSignIn =>
      'Google hesabın bu cihazda olmasa bile takvimlerini doğrudan Google\'dan okumak için Google ile giriş yap.';

  @override
  String googleCalendarSignedIn(String email) {
    return '$email olarak giriş yapıldı';
  }

  @override
  String get googleCalendarSignOut => 'Çıkış yap';

  @override
  String get googleCalendarNotHere =>
      'Google ile giriş bu cihazda henüz yok. Google hesabını cihaz ayarlarından ekle (Takvim › Hesaplar), takvimleri bu cihazın altında görünür.';

  @override
  String get googleCalendarUnreachable =>
      'Google Takvim\'e şu an ulaşılamadı. Ondan kurulmuş alarmlar yine de çalar.';

  @override
  String get googleCalendarTwiceHint =>
      'Bu cihazın aynı Google hesabından zaten gösterdiği takvimler kapalı başlar, böylece hiçbir şey iki kez çalmaz.';

  @override
  String get timersTitle => 'Zamanlayıcılar';

  @override
  String get timerStopwatch => 'Kronometre';

  @override
  String get timerCountdown => 'Zamanlayıcı';

  @override
  String get timerSequence => 'Hazır';

  @override
  String get timerStopwatchSub => 'Yukarı sayar, tur kaydıyla';

  @override
  String get timerCountdownSub => 'Geri sayar, sıfırda çalar';

  @override
  String get timerSequenceSub => 'Sesli başlangıç ve işaretler';

  @override
  String get timerStart => 'Başlat';

  @override
  String get timerPause => 'Duraklat';

  @override
  String get timerResume => 'Devam et';

  @override
  String get timerReset => 'Sıfırla';

  @override
  String get timerLap => 'Tur';

  @override
  String get timerTimesUp => 'Süre doldu';

  @override
  String get timerSetTime => 'Süreyi ayarla';

  @override
  String get timerMinutes => 'Dakika';

  @override
  String get timerSeconds => 'Saniye';

  @override
  String get seqOnYourMarks => 'Yerlerinize';

  @override
  String get seqGetSet => 'Hazır';

  @override
  String get seqGo => 'Başla!';

  @override
  String get seqFinish => 'Süre!';

  @override
  String get seqReady => 'Hazır';

  @override
  String get seqSettings => 'Ayarlar';

  @override
  String get seqStartCalls => 'Başlangıçtan önceki seslenişler';

  @override
  String get seqStartCallsHelp => 'Başla\'dan önce yüksek sesle söylenir, başlangıçtan geriye sayılır.';

  @override
  String seqCallBefore(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n saniye önce',
      one: '1 saniye önce',
    );
    return '$_temp0';
  }

  @override
  String get seqAddCall => 'Seslenme ekle';

  @override
  String get seqCallText => 'Ne söylenecek';

  @override
  String get seqGoText => 'Başlangıçta şunu söyle';

  @override
  String get seqFinishText => 'Bitişte şunu söyle';

  @override
  String get seqLength => 'Süre';

  @override
  String get seqNoLimit => 'Sınırsız';

  @override
  String get seqSayEvery => 'Zamanı şu aralıkla söyle';

  @override
  String get seqOff => 'Kapalı';

  @override
  String seqEverySeconds(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n saniye', one: '1 saniye');
    return '$_temp0';
  }

  @override
  String seqEveryMinutes(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n dakika', one: '1 dakika');
    return '$_temp0';
  }

  @override
  String get seqFinalCount => 'Son kısmı geri say';

  @override
  String get seqMarks => 'İşaretlerin';

  @override
  String get seqAddMark => 'İşaret ekle';

  @override
  String seqMarkAt(String time) {
    return '$time anında';
  }

  @override
  String get seqSpeak => 'Yüksek sesle söyle';

  @override
  String get seqBeeps => 'Bip sesi ve titreşim';

  @override
  String get seqSayRemaining => 'Geçen süreyi değil, kalan süreyi söyle';

  @override
  String get seqPresets => 'Hazır ayarlar';

  @override
  String get seqPresetRace => 'Yarış başlangıcı';

  @override
  String get seqPresetSprint => '30 sn efor';

  @override
  String get seqPresetRound => '1 dk tur';

  @override
  String get seqHintNoLimit => 'Başla\'dan sonra siz durdurana kadar yukarı sayar.';

  @override
  String get seqHintLength => 'Başla\'dan sonra sıfıra kadar geri sayar.';

  @override
  String get seqWords => 'Sözler';

  @override
  String get homeEdit => 'Arrange home';

  @override
  String get homeEditHint => 'Bir kartı taşımak, katlamak veya boyutunu değiştirmek için tutamacı sürükle.';

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
  String get homeBlockSky => 'GÜNEŞ, AY VE HAVA DURUMU';

  @override
  String get homeBlockQuick => 'QUICK ALARMS';

  @override
  String get homeBlockShabbat => 'ŞABAT VE BAYRAMLAR';

  @override
  String get homePlaceTitle => 'Gökyüzü için şehir';

  @override
  String nextAlarmLine(String title, String time) {
    return 'Sonraki alarm · $title $time';
  }

  @override
  String get showAllAlarms => 'Tüm günleri göster';

  @override
  String get noAlarmsThatDay => 'Bu gün hiçbir şey çalmıyor';

  @override
  String get homeClockSize => 'Ana ekranda saat';

  @override
  String get sizeSmall => 'Küçük';

  @override
  String get sizeMedium => 'Orta';

  @override
  String get sizeLarge => 'Büyük';

  @override
  String get homeLayout => 'Ana ekran düzeni';

  @override
  String get homeLayoutClassic => 'Klasik';

  @override
  String get homeLayoutCards => 'Kartlar';

  @override
  String get homeCardsHint =>
      'Taşımak için bir kartı sürükleyin. Boyutunu değiştirmek için kenarını ya da köşesini sürükleyin veya bir boyut seçin.';

  @override
  String get homeAddCard => 'Kart ekle';

  @override
  String get homeOnHome => 'Ana ekranda';

  @override
  String get homeRemoveCard => 'Kaldır';

  @override
  String get cardNext => 'Sonraki alarm';

  @override
  String get cardClock => 'Saat ve tarih';

  @override
  String get cardSky => 'Güneş, ay ve hava';

  @override
  String get cardMoon => 'Ay';

  @override
  String get cardWeather => 'Hava durumu';

  @override
  String get cardAlarms => 'Alarmlarınız';

  @override
  String get cardQuick => 'Hızlı alarmlar';

  @override
  String get cardTools => 'Kronometre, geri sayım ve hazır ol';

  @override
  String get cardWorld => 'Dünya saatleri';

  @override
  String get cardWeek => 'Bu hafta';

  @override
  String get cardShabbat => 'Şabat ve bayramlar';

  @override
  String get ringAtEventReminders => 'Etkinliğin kendi hatırlatıcılarında çal';

  @override
  String get ringAtEventRemindersHint =>
      'Takvim uygulamanızdaki hatırlatıcılar burada bu alarmın sesiyle yüksek alarm olarak çalar.';

  @override
  String get atEventReminders => 'etkinliğin hatırlatıcılarında';

  @override
  String get everyEventReminderLoud => 'Her etkinliğin hatırlatıcılarında yüksek sesle çal';

  @override
  String get loudNotificationsHeading => 'YÜKSEK SESLİ TAKVİM BİLDİRİMLERİ';

  @override
  String get loudNotificationsTitle => 'Takvim bildirimlerini yüksek sesli yap';

  @override
  String get loudNotificationsHint =>
      'Bir takvim uygulaması hatırlatıcı gösterdiğinde Quando? onu telefon sessizdeyken bile alarm olarak çalar.';

  @override
  String get loudNotificationsDisclosureTitle => 'Quando? takvim bildirimlerini okuyabilsin mi?';

  @override
  String get loudNotificationsDisclosure =>
      'Takvim hatırlatıcılarınızı yüksek sesle çalmak için Quando? bildirim erişimine ihtiyaç duyar. Yalnızca seçtiğiniz takvim uygulamalarının bildirimlerine bakar, alarmda göstermek için başlık ve metni bu telefonda okur ve bunları asla saklamaz ya da bir yere göndermez. İstediğiniz zaman kapatabilirsiniz.';

  @override
  String get loudNotificationsAgree => 'Kabul et ve devam et';

  @override
  String get loudNotificationsNoAccess => 'Bildirim erişimi kapalı. Açılan listede Quando?\'yu açın.';

  @override
  String get loudNotificationsAllow => 'İzin ver';

  @override
  String get loudNotificationsNoApps => 'Bu telefonda desteklenen takvim uygulaması bulunamadı.';

  @override
  String get loudNotificationsTwiceNote =>
      'Zaten bir Quando? takvim alarmı olan etkinlikler yalnızca bir kez çalar.';

  @override
  String get loudNotificationsShabbatNote => 'Şabat ve bayramlarda sessiz.';

  @override
  String get busyMode => 'Meşgul modu';

  @override
  String get busyModeSubtitle => 'Meşgulken Rahatsız Etmeyin ve otomatik yanıtlar';

  @override
  String get busyIntro =>
      'Siz meşgulken Quando? telefonu sessize alıp mesajlara sizin yerinize yanıt verebilir. Alarmlar yine çalar.';

  @override
  String get busyIosFocus =>
      'iPhone ve iPad\'de uygulamalar Odak açamaz veya mesajlara yanıt veremez. Kestirmeler uygulamasında \"Quando? açıldığında\" ya da bir saatte Odak açan bir otomasyon ekleyin ve Odak\'ı otomatik yanıt verecek şekilde ayarlayın.';

  @override
  String get busyWhileHeading => 'MEŞGULKEN';

  @override
  String get busyDnd => 'Rahatsız Etmeyin';

  @override
  String get busyDndHint =>
      'Yalnızca öncelikli: aramalar ve mesajlar sessiz, alarmlar çalar. Bitince normale döner.';

  @override
  String get busyDndNoAccess => 'Quando?\'nun henüz Rahatsız Etmeyin\'i değiştirme izni yok.';

  @override
  String get busyReplies => 'Mesajlara yanıt ver';

  @override
  String get busyRepliesHint =>
      'Kişi başına bir kez, sizin metninizle, uygulamanın kendi Yanıtla düğmesiyle. Yalnızca Android.';

  @override
  String get busyRepliesDisclosureTitle => 'Quando? mesajlara yanıt verebilsin mi?';

  @override
  String get busyRepliesDisclosure =>
      'Sizin yerinize yanıt vermek için Quando? bildirim erişimine ihtiyaç duyar. Yalnızca siz meşgulken, seçtiğiniz uygulamaların mesaj bildirimlerine bakar, gönderenin adını bu telefonda okur ve metninizi uygulamanın kendi Yanıtla düğmesiyle bir kez gönderir. Mesajlar asla saklanmaz veya başka yere gönderilmez. İzin vermedikçe gruplar atlanır.';

  @override
  String get busyReplyText => 'Yanıtınız';

  @override
  String busyReplyTextHint(String until) {
    return '$until, meşgul modunun bittiği saate dönüşür.';
  }

  @override
  String busyReplyDefault(String until) {
    return 'Şu an meşgulüm, $until sonrasında yanıtlayacağım.';
  }

  @override
  String get busyGroups => 'Gruplarda da yanıt ver';

  @override
  String get busyGroupsHint => 'Kapalı: gruplara asla yanıt verilmez.';

  @override
  String get busyRepliesOnShabbat => 'Şabat ve bayramlarda da yanıt ver';

  @override
  String get busyAskRabbi => 'Varsayılan olarak kapalı. Şabat için açmadan önce hahamınıza danışın.';

  @override
  String get busyWhenHeading => 'NE ZAMAN MEŞGULSÜNÜZ';

  @override
  String get busyWhenHint =>
      'Bir takvim alarmında \"Bu etkinlikler sırasında meşgul\" ya da bir alarmda \"Çaldıktan sonra meşgul\" seçeneğini açın.';

  @override
  String get busyDuringLock => 'Kilit modu açıkken meşgul';

  @override
  String get busyNoneComing => 'Önümüzdeki 7 günde meşgul bir şey yok.';

  @override
  String get busyDuringEvents => 'Bu etkinlikler sırasında meşgul';

  @override
  String get busyDuringEventsHint => 'Her etkinliğin başından sonuna meşgul modu.';

  @override
  String get busySettings => 'Meşgul modu ayarları';

  @override
  String get busyAfterRing => 'Çaldıktan sonra meşgul';

  @override
  String get busyAfterRingHint =>
      'Bir süre Rahatsız Etmeyin ve otomatik yanıt, ör. antrenman veya şekerleme.';

  @override
  String get shareCard => 'Sabahını paylaş';

  @override
  String get shareCardSubtitle => 'Bugünün gökyüzü ve sözü ya da kendi fotoğrafın, Hikâyeler ve durum için';

  @override
  String get shareAppMissing => 'Bu uygulama telefonda yok.';

  @override
  String get shareAsIs => 'Olduğu gibi paylaş';

  @override
  String get shareTapQuote => 'Başka bir söz için söze dokun.';

  @override
  String get shareStory => 'Hikâye';

  @override
  String get shareSquare => 'Kare';

  @override
  String get shareYourWords => 'Kendi sözlerin (isteğe bağlı)';

  @override
  String get shareYourWordsHint => 'Bugünün sözü yerine';

  @override
  String get shareYourPhoto => 'Fotoğrafın';

  @override
  String get shareOtherPhoto => 'Başka fotoğraf';

  @override
  String get shareSkyBack => 'Bugünün gökyüzü';

  @override
  String get shareYourVideo => 'Videon';

  @override
  String get shareInstagramStory => 'Instagram Hikâyeleri';

  @override
  String get shareWhatsApp => 'WhatsApp: durum veya sohbet';

  @override
  String get shareMore => 'Diğer uygulamalar';

  @override
  String get shareYouPost =>
      'Quando? uygulamayı kartınla açar. Nereye gideceğini sen seçer, Paylaş\'a sen dokunursun.';

  @override
  String get shareAndroidFirst => 'Paylaşım yakında iPhone ve iPad\'de.';

  @override
  String songSaved(String name) {
    return '“$name” alarm sesi olarak kaydedildi';
  }

  @override
  String get shareToQuando => 'Quando?\'ya şarkı paylaş';

  @override
  String get shareToQuandoHint =>
      'YouTube, YouTube Music, Spotify, SoundCloud veya Apple Music\'te Paylaş\'a, sonra Quando?\'ya dokun. Kendi uygulamasında çalan bir alarm sesi olur.';

  @override
  String get askOption => 'Söyle veya yaz';

  @override
  String get askOptionHint => '“Yarın 6\'da”, “gün doğumundan 30 dk önce”';

  @override
  String get askHint => 'ör. hafta içi gün doğumundan 30 dk önce uyandır';

  @override
  String get askListening => 'Dinliyorum…';

  @override
  String get askNotUnderstood => 'Bir saat bulamadım. “Hafta içi 7\'de” veya “20 dakika sonra” deneyin.';

  @override
  String askAnswerFromCalendar(String name) {
    return '“$name” takviminden';
  }

  @override
  String get askAnswerBuiltIn => 'Quando?\'nun şehrin için kendi saatleri';

  @override
  String get askNoAnswer => 'Henüz bir saat bulunamadı.';

  @override
  String get askNoSpeech => 'Bu cihazda ses kullanılamıyor. Yazabilirsiniz.';

  @override
  String get askShabbatOff => 'Şabat saatlerinin çalması için Ayarlar\'dan Şabat\'ı açın.';

  @override
  String askSaved(String what) {
    return 'Kaydedildi: $what';
  }

  @override
  String get askMic => 'Konuş';

  @override
  String get askMorning => 'Sabah';

  @override
  String get askEvening => 'Akşam';

  @override
  String get askUnsure => 'Bir kısmını kaçırmış olabilirim. Kaydetmeden önce kontrol edin.';

  @override
  String get askTeach => 'Bunu bana öğret';

  @override
  String askTaught(String phrase, String time) {
    return 'Anladım: “$phrase” artık $time demek.';
  }

  @override
  String get askSkipAction => 'Atla';

  @override
  String get askNoMatch => 'Buna uyan alarm yok.';

  @override
  String askTurnedOff(String what) {
    return 'Kapatıldı: $what';
  }

  @override
  String askSkipped(String what) {
    return 'Atlandı: $what';
  }

  @override
  String askEventPlan(String offset, String event) {
    return 'Takviminizdeki “$event” etkinliğinden $offset';
  }

  @override
  String askEventNoCalendar(String event) {
    return 'Quando?\'nun “$event” etkinliğini bulması için bir takvim bağlayın.';
  }

  @override
  String askSnoozeAll(int minutes) {
    return 'Erteleme: $minutes dk, tüm alarmlar için';
  }

  @override
  String askWakeWith(String sound) {
    return 'Sizi $sound ile uyandırır';
  }

  @override
  String get askReadAs => 'Şöyle okundu';

  @override
  String get quickSetups => 'Hızlı kurulumlar';

  @override
  String get qsMorningTitle => 'İşe yarayan sabah';

  @override
  String get qsStartTitle => 'Hiçbir başlangıcı kaçırma';

  @override
  String get qsStretchTitle => 'Bölümler halinde çalış';

  @override
  String get qsWillChange => 'Neler değişecek';

  @override
  String get qsAlreadyOn => 'Zaten açık. Değişecek bir şey yok.';

  @override
  String get qsApply => 'Uygula';

  @override
  String get qsDone => 'Tamam';

  @override
  String get qsUndo => 'Geri al';

  @override
  String get qsSnoozeTimes => 'İzin verilen erteleme';

  @override
  String get qsSnoozeMinutes => 'Erteleme dakikası';

  @override
  String get qsFiveLeft => '5 dakika kaldı';

  @override
  String get syncHeading => 'Takvim değişince';

  @override
  String get syncLive => 'Takvimi takip et';

  @override
  String get syncLiveHint =>
      'Yeni etkinlikler alarm alır. Taşınan etkinlik alarmını da taşır. Silinen etkinliğin alarmı kalkar.';

  @override
  String get syncKeepFirst => 'İlk gördüğüm gibi kalsın';

  @override
  String get syncKeepFirstHint =>
      'Yeni etkinlikler yine alarm alır. Kurulan alarm, etkinlik taşınsa ya da silinse bile yerinde kalır.';

  @override
  String get syncSnapshot => 'Yalnızca şu an olan etkinlikler';

  @override
  String get syncSnapshotHint =>
      'Yalnızca kaydettiğin anda takviminde olan etkinlikler, şu anki halleriyle. Sonra yeni bir şey eklenmez.';

  @override
  String get syncHelpButton => 'Nasıl çalışır';

  @override
  String get syncHelpTitle => 'Alarmlar takvimini nasıl takip eder';

  @override
  String get syncHelpIntro =>
      'Bu kural aramanla eşleşen etkinlikleri aramaya devam eder. Takvimin değişince ne olacağını sen seçersin.';

  @override
  String get syncHelpExampleLive =>
      'Örnek: “dişçi” için bir kural. Dişçi salı randevusunu çarşambaya alır, alarmın da çarşambaya geçer. Randevu iptal olursa alarmı da kalkar.';

  @override
  String get syncHelpExampleKeepFirst =>
      'Aynı kural: randevu çarşambaya geçer ama alarmın Quando?\'nun ilk gördüğü gibi salıda kalır. Gelecek ay yeni bir randevu yine kendi alarmını alır.';

  @override
  String get syncHelpExampleSnapshot =>
      'Aynı kural: bugün takviminde olan randevular için alarm alırsın ve olduğu gibi kalırlar. Gelecek ay eklenen randevu alarm almaz.';

  @override
  String get syncHelpTip => 'Emin değil misin? “Takvimi takip et”i bırak.';

  @override
  String get syncHelpWhenTitle => 'Quando? değişiklikleri ne zaman fark eder?';

  @override
  String get syncHelpWhenOpen =>
      'Quando? açıkken: saniyeler içinde. Burada bağlı Google Takvim her 2 dakikada bir kontrol edilir.';

  @override
  String get syncHelpWhenClosed =>
      'Quando? kapalıyken: bir sonraki açışında. O zamana kadar kurulu alarmlar eski saatlerinde çalar.';

  @override
  String get syncHelpWhenClosedApple =>
      'iPhone ve iPad uygulamaların takvimi arka planda izlemesine izin vermez, bu yüzden değişiklikler Quando? açılınca alınır.';

  @override
  String get tapMiddleToStop => 'Durdurmak için ortaya dokun';
}
