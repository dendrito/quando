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
  String get calendarAlarm => 'Takvim alarmı';

  @override
  String get calendarIntro =>
      'Quando? telefonundaki takvimlerin etkinliklerinden önce ve sonra çalabilir. Google hesabın telefondaysa Google Takvim de dahildir.';

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
}
