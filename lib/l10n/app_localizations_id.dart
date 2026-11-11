// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class AppLocalizationsId extends AppLocalizations {
  AppLocalizationsId([String locale = 'id']) : super(locale);

  @override
  String get undo => 'Urungkan';

  @override
  String duplicatedNamed(String name) {
    return '“$name” diduplikasi';
  }

  @override
  String deletedNamed(String name) {
    return '“$name” dihapus';
  }

  @override
  String get when => 'Kapan?';

  @override
  String get newAtTime => 'Pada jam tertentu';

  @override
  String get newAtTimeHint => 'Setiap hari kerja pukul 7.00, sekali pukul 15.30…';

  @override
  String get newAroundEvent => 'Di sekitar acara';

  @override
  String get newAroundEventHint =>
      'Cari di kalender, waktu Sabat dan matahari, lalu bunyikan sebelum, saat, atau sesudahnya';

  @override
  String get editThisAlarm => 'Edit alarm ini';

  @override
  String editNamed(String name) {
    return 'Edit “$name”';
  }

  @override
  String get preset => 'templat';

  @override
  String get editThisCalendarRule => 'Edit aturan kalender ini';

  @override
  String get ringThisOneAfterAll => 'Tetap bunyikan yang ini';

  @override
  String get skipJustThisOne => 'Lewati yang ini saja';

  @override
  String get renameGroup => 'Ganti nama grup';

  @override
  String quickSet(String label, String time) {
    return '$label · berbunyi pukul $time';
  }

  @override
  String get newAlarm => 'Alarm baru';

  @override
  String get appName => 'Quando?';

  @override
  String get lockMode => 'Mode kunci';

  @override
  String get calendars => 'Kalender';

  @override
  String get settings => 'Pengaturan';

  @override
  String get nextAlarmHeading => 'ALARM BERIKUTNYA';

  @override
  String get nothingSet => 'Belum ada yang diatur';

  @override
  String get tagline => 'Semua ada waktunya.';

  @override
  String sunriseAt(String time) {
    return 'Matahari terbit $time';
  }

  @override
  String sunsetAt(String time) {
    return 'Matahari terbenam $time';
  }

  @override
  String get alarmsMayNotRing => 'Alarmmu mungkin tidak berbunyi';

  @override
  String get tapToFixIt => 'Ketuk untuk memperbaiki';

  @override
  String inMinutes(int minutes) {
    return '$minutes mnt lagi';
  }

  @override
  String get atSunset => 'Saat matahari terbenam';

  @override
  String get sunset => 'Matahari terbenam';

  @override
  String get shabbatModeIsOn => 'MODE SABAT AKTIF';

  @override
  String nextInCity(String city) {
    return 'BERIKUTNYA · $city';
  }

  @override
  String get candleLighting => 'Menyalakan lilin';

  @override
  String get havdalah => 'Havdalah';

  @override
  String get shabbatAndFestivals => 'Sabat & hari raya';

  @override
  String get yourAlarmsHeading => 'ALARMMU';

  @override
  String get tapWhenToAdd => 'Ketuk Kapan? untuk menambah alarm.';

  @override
  String get aroundEventsHeading => 'DI SEKITAR ACARA';

  @override
  String searchFor(String words) {
    return 'cari: $words';
  }

  @override
  String get thisWeekHeading => 'ALARM MINGGU INI';

  @override
  String get noAlarmsThisWeek => 'Tidak ada alarm dalam 7 hari ke depan.';

  @override
  String get alarmsSetThemselves =>
      'Alarm mengatur dirinya sendiri di ponsel ini setiap kali kamu mengubah sesuatu.';

  @override
  String cityTime(String city) {
    return 'waktu $city';
  }

  @override
  String get more => 'Lainnya';

  @override
  String get turnOff => 'Matikan';

  @override
  String get turnOn => 'Nyalakan';

  @override
  String get duplicate => 'Duplikat';

  @override
  String get delete => 'Hapus';

  @override
  String get inOneHour => '1 jam lagi';

  @override
  String get logoLabel => 'Logo Quando?';

  @override
  String get noTimesSet => 'Belum ada waktu';

  @override
  String get atTheMoment => 'tepat pada saatnya';

  @override
  String timesRange(int count, String from, String to) {
    return '$count kali · $from sampai $to';
  }

  @override
  String spanDays(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n hari');
    return '$_temp0';
  }

  @override
  String spanHours(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n jam');
    return '$_temp0';
  }

  @override
  String spanMinutes(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n menit');
    return '$_temp0';
  }

  @override
  String spanSeconds(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n detik');
    return '$_temp0';
  }

  @override
  String get now => 'sekarang';

  @override
  String spanBefore(String span) {
    return '$span sebelumnya';
  }

  @override
  String spanAfter(String span) {
    return '$span sesudahnya';
  }

  @override
  String alarmCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n alarm');
    return '$_temp0';
  }

  @override
  String get allOn => 'semua aktif';

  @override
  String get allOff => 'semua mati';

  @override
  String someOn(int n) {
    return '$n aktif';
  }

  @override
  String skippedBody(String body) {
    return 'Dilewati · $body';
  }

  @override
  String timeToTime(String from, String to) {
    return '$from – $to';
  }

  @override
  String skippedCount(int n) {
    return '$n dilewati';
  }

  @override
  String get sunNoRiseSet => 'Matahari tidak terbit atau terbenam di sini hari ini';

  @override
  String sunProgress(int percent) {
    return 'Matahari sudah melewati $percent% hari';
  }

  @override
  String get sunIsDown => 'Matahari sudah terbenam';

  @override
  String get searchCity => 'Cari kota';

  @override
  String get tomorrowLower => 'besok';

  @override
  String get yesterdayLower => 'kemarin';

  @override
  String get worldClocksHeading => 'JAM DUNIA';

  @override
  String get add => 'Tambah';

  @override
  String cityHere(String city) {
    return '$city · di sini';
  }

  @override
  String get worldClocksHint =>
      'Tambahkan kota untuk melihat waktunya di sini. Geser ke kiri untuk menghapus.';

  @override
  String get groupNameHint => 'Kerja, Anak, Gym…';

  @override
  String get cancel => 'Batal';

  @override
  String get ok => 'OK';

  @override
  String get noGroup => 'Tanpa grup';

  @override
  String get newGroupEllipsis => 'Grup baru…';

  @override
  String get newGroup => 'Grup baru';

  @override
  String secondsShort(int n) {
    return '$n dtk';
  }

  @override
  String minutesShort(int n) {
    return '$n mnt';
  }

  @override
  String get minutes => 'Menit';

  @override
  String get ringFor => 'Berbunyi selama';

  @override
  String get seconds => 'Detik';

  @override
  String get oneSecondLess => 'Kurang 1 detik';

  @override
  String get oneSecondMore => 'Tambah 1 detik';

  @override
  String inDays(int d) {
    return '$d hr lagi';
  }

  @override
  String inDaysHours(int d, int h) {
    return '$d hr $h j lagi';
  }

  @override
  String inHours(int h) {
    return '$h j lagi';
  }

  @override
  String inHoursMinutes(int h, int m) {
    return '$h j $m mnt lagi';
  }

  @override
  String inMins(int m) {
    return '$m mnt lagi';
  }

  @override
  String placeChange(String city, String where) {
    return '$city · $where · ubah';
  }

  @override
  String get israel => 'Israel';

  @override
  String get outsideIsrael => 'di luar Israel';

  @override
  String get comingUpHeading => 'AKAN DATANG';

  @override
  String get lockForShabbat => 'Kunci ponsel untuk Sabat';

  @override
  String get lockForShabbatHint => 'Dari menyalakan lilin sampai havdalah, juga di hari raya';

  @override
  String get ownShabbatAlarmsHeading => 'ALARM SABATMU';

  @override
  String get addShabbatAlarm => 'Tambah alarm Sabat atau hari raya';

  @override
  String get readyMadeHeading => 'ALARM SIAP PAKAI';

  @override
  String bringBackDeleted(int n) {
    return 'Kembalikan yang dihapus ($n)';
  }

  @override
  String get presetsHint => 'Ketuk salah satu untuk mengubah waktunya. Geser untuk menghapus.';

  @override
  String get lockSentence => 'Jadikan ponsel hanya jam dan alarm, untuk Sabat atau malam yang fokus.';

  @override
  String get lockExplain =>
      'Saat terkunci, Quando? hanya menampilkan waktu, alarm berikutnya, dan kapan kunci berakhir. Alarm tetap berjalan dan tidak ada yang bisa diubah sampai terbuka.';

  @override
  String get lockNowHeading => 'KUNCI SEKARANG';

  @override
  String get lockAutoHeading => 'KUNCI OTOMATIS';

  @override
  String get shabbatAndFestivalsLong => 'Sabat dan hari raya';

  @override
  String get fromCandleToHavdalah => 'Dari menyalakan lilin sampai havdalah';

  @override
  String get lockCalendarWord => 'Selama acara kalender dengan kata ini';

  @override
  String get lockCalendarWordHint => 'mis. kunci, ujian, fokus';

  @override
  String get leaveEmptyForNone => 'Kosongkan untuk tidak ada';

  @override
  String get connectCalendarsFirst => 'Hubungkan kalender dulu (ikon kalender)';

  @override
  String get openWhenLockStarts => 'Buka Quando? saat kunci dimulai';

  @override
  String get openWhenLockStartsHint => 'Bunyi pelan 1 detik membawa Quando? ke depan untuk mengunci';

  @override
  String get pinToScreen => 'Sematkan Quando? ke layar';

  @override
  String get pinToScreenHint =>
      'Aplikasi lain tidak terbuka selama kunci. Android meminta konfirmasi pertama kali.';

  @override
  String get noLocksComingUp => 'Tidak ada kunci yang akan datang.';

  @override
  String get leaveLockEarly => 'Untuk keluar lebih awal, tahan “Tahan untuk membuka” selama 3 detik.';

  @override
  String get locked => 'Terkunci';

  @override
  String get shabbatShalom => 'Shabbat shalom';

  @override
  String get chagSameach => 'Chag sameach';

  @override
  String get unlocksHeading => 'TERBUKA';

  @override
  String get nowCap => 'Sekarang';

  @override
  String get nextAlarm => 'Alarm berikutnya';

  @override
  String get holdToUnlock => 'Tahan untuk membuka';

  @override
  String get lockSentenceCalm => 'Kunci ponsel ke jam dan alarm: untuk ujian, rapat, atau malam yang tenang.';

  @override
  String get lockCalendarHeading => 'DENGAN KALENDERMU';

  @override
  String get lockCalendarExplain =>
      'Kunci selama acara, atau dari satu acara sampai acara berikutnya yang kamu pilih. Bisa dengan kalender apa pun yang dipilih, termasuk yang dibagikan.';

  @override
  String get lockAddCalendar => 'Tambah kunci kalender';

  @override
  String get lockEditCalendar => 'Kunci kalender';

  @override
  String get lockDuring => 'Selama acara';

  @override
  String get lockBetween => 'Di antara dua acara';

  @override
  String get lockStartsAt => 'Acara bernama…';

  @override
  String get lockStartsAtBetween => 'Mulai di acara bernama…';

  @override
  String get lockEndsAt => 'Selesai di acara berikutnya bernama…';

  @override
  String get lockStartHint => 'mis. ujian, fokus, gym';

  @override
  String get lockEndHint => 'mis. di rumah';

  @override
  String get lockAnyCalendar => 'Kalender mana pun';

  @override
  String get lockNoMatches => 'Belum ada yang cocok di kalendermu.';

  @override
  String get lockNextTimes => 'BERIKUTNYA';

  @override
  String lockDuringTitle(String a) {
    return 'Selama “$a”';
  }

  @override
  String lockBetweenTitle(String a, String b) {
    return 'Dari “$a” sampai “$b” berikutnya';
  }

  @override
  String lockShabbatCalendarFound(String name) {
    return '“$name” berisi waktu Shabbat.';
  }

  @override
  String get lockShabbatFromCalendar => 'Kunci dari menyalakan lilin sampai Havdalah';

  @override
  String get lockShabbatFromCalendarHint => 'Memakai waktu dari kalender itu, dengan lilin di layar.';

  @override
  String get lockMoreWays => 'Cara lain mengunci';

  @override
  String get lockQuietTime => 'Waktu tenang';

  @override
  String nextCandleLightingFrom(String time, String name) {
    return 'Menyalakan lilin berikutnya: $time, dari $name';
  }

  @override
  String get calendarAlarm => 'Alarm kalender';

  @override
  String get connectCalendars => 'Hubungkan kalender';

  @override
  String get calendarAlarmsHeading => 'ALARM KALENDER';

  @override
  String get calendarNoneYet => 'Belum ada. Mulai dengan ini, lalu ubah sesukamu:';

  @override
  String get fifteenBeforeEvery => '15 menit sebelum setiap acara';

  @override
  String get useTheseCalendarsHeading => 'GUNAKAN KALENDER INI';

  @override
  String get noTimedEvents => 'Tidak ada acara berjam yang akan datang di kalender ini.';

  @override
  String get atTheStart => 'saat dimulai';

  @override
  String everyForBefore(String every, String span) {
    return 'setiap $every selama $span sebelumnya';
  }

  @override
  String spanAfterItEnds(String span) {
    return '$span setelah selesai';
  }

  @override
  String get noAlarmsChosen => 'Tidak ada alarm dipilih';

  @override
  String get gentleWakeUp => 'Bangun perlahan';

  @override
  String gentleSummary(int minutes, String sound) {
    return '$minutes mnt sebelumnya · $sound';
  }

  @override
  String get off => 'Mati';

  @override
  String get gentleSentence =>
      'Suara tenang mulai pelan sebelum alarmmu, jadi kamu tak pernah terbangun kaget.';

  @override
  String get gentleExplain =>
      'Suaranya naik perlahan, membawamu keluar dari tidur ringan, dan berhenti tepat sebelum alarm berbunyi.';

  @override
  String get startsBeforeHeading => 'MULAI SEBELUM ALARM';

  @override
  String get leadUpSoundHeading => 'SUARA PEMBUKA';

  @override
  String get listen => 'Dengarkan';

  @override
  String get whoRecordedThese => 'Siapa yang merekam suara ini';

  @override
  String get done => 'Selesai';

  @override
  String get soundCredits => 'Kredit suara';

  @override
  String yourTimeCity(String city) {
    return 'Waktumu ($city)';
  }

  @override
  String get anotherCity => 'Kota lain…';

  @override
  String get ringingIn5 => 'Berbunyi dalam 5 detik…';

  @override
  String get alarmSaved => 'Alarm disimpan.';

  @override
  String alarmSetFor(String span) {
    return 'Alarm berbunyi $span lagi.';
  }

  @override
  String hoursMinutesShort(int h, int m) {
    return '$h j $m mnt';
  }

  @override
  String get editAlarm => 'Edit alarm';

  @override
  String get previewCaps => 'PRATINJAU';

  @override
  String get saveCaps => 'SIMPAN';

  @override
  String cityTimeForYou(String city, String time) {
    return 'waktu $city · $time bagimu';
  }

  @override
  String repeatHeading(String repeat) {
    return 'ULANGI · $repeat';
  }

  @override
  String get labelField => 'Label (dibacakan jika alarm bersuara aktif)';

  @override
  String get group => 'Grup';

  @override
  String ringsForHeading(String span) {
    return 'BERBUNYI SELAMA $span';
  }

  @override
  String useDefault(String value) {
    return 'Pakai bawaan ($value)';
  }

  @override
  String get save => 'Simpan';

  @override
  String get sameTime => 'waktu yang sama';

  @override
  String get untilYouStopIt => 'Sampai kamu menghentikannya';

  @override
  String get alarm => 'Alarm';

  @override
  String get once => 'Sekali';

  @override
  String get everyDay => 'Setiap hari';

  @override
  String get weekdays => 'Hari kerja';

  @override
  String get weekends => 'Akhir pekan';

  @override
  String timeInCity(String time, String city) {
    return '$time waktu $city';
  }

  @override
  String eventsMatching(String words) {
    return 'Acara dengan “$words”';
  }

  @override
  String get everyEvent => 'Setiap acara';

  @override
  String get sunrise => 'Matahari terbit';

  @override
  String havdalahEndOf(String day) {
    return 'Havdalah · akhir $day';
  }

  @override
  String get yomTov => 'Yom tov';

  @override
  String get shabbat => 'Sabat';

  @override
  String get presetCountdown => 'Hitung mundur menyalakan lilin';

  @override
  String get presetHourly => 'Setiap jam, mulai 6 jam sebelumnya';

  @override
  String get presetDailyWeek => 'Sekali sehari, di minggu sebelumnya';

  @override
  String get presetSecondNight => 'Lilin malam kedua';

  @override
  String get presetFridayReminder => 'Pengingat 3 jam sebelumnya: isi daya ponsel';

  @override
  String get presetFridayReminderLabel => 'Isi daya ponsel dan atur alarm untuk besok';

  @override
  String get presetSunset => 'Matahari terbenam, dan 15 menit sebelumnya';

  @override
  String get pesach => 'Pesakh';

  @override
  String get shavuot => 'Shavuot';

  @override
  String get roshHashanah => 'Rosh Hashanah';

  @override
  String get yomKippur => 'Yom Kippur';

  @override
  String get sukkot => 'Sukkot';

  @override
  String get sheminiAtzeret => 'Shemini Atzeret';

  @override
  String get simchatTorah => 'Simchat Torah';

  @override
  String get readyNotifications => 'Tampilkan alarm';

  @override
  String get readyNotificationsWhy => 'Membuat layar alarm dan tombol Berhenti bisa muncul.';

  @override
  String get readyFullScreen => 'Berbunyi di atas layar kunci';

  @override
  String get readyFullScreenWhy => 'Menampilkan alarm layar penuh, bahkan saat ponsel terkunci.';

  @override
  String get readyExact => 'Berbunyi tepat pada menitnya';

  @override
  String get readyExactWhy => 'Tanpa ini, ponsel bisa menunda alarm beberapa menit.';

  @override
  String get readyBattery => 'Tetap berjalan saat hemat baterai';

  @override
  String get readyBatteryWhy => 'Mencegah penghemat baterai membisukan alarm di malam hari.';

  @override
  String get tipXiaomi =>
      'Ponsel Xiaomi: di Pengaturan › Aplikasi › Quando?, aktifkan Mulai otomatis dan setel Penghemat baterai ke Tanpa batasan.';

  @override
  String get tipSamsung =>
      'Ponsel Samsung: di Pengaturan › Baterai › Batas penggunaan latar belakang, pastikan Quando? tidak ditidurkan.';

  @override
  String get tipHuawei =>
      'Ponsel Huawei dan Honor: di Pengaturan › Baterai › Peluncuran aplikasi, setel Quando? ke Kelola manual dan izinkan semuanya.';

  @override
  String get tipOther =>
      'Di ponsel ini: di Pengaturan › Baterai, izinkan Quando? berjalan di latar belakang dan matikan pengoptimalan.';

  @override
  String get testRing => 'Uji bunyi';

  @override
  String get testRingBody => 'Quando? bisa membangunkanmu';

  @override
  String get ringsIn20 => 'Berbunyi dalam 20 detik. Kunci ponselmu sekarang dan tunggu.';

  @override
  String get readyToRing => 'Siap berbunyi';

  @override
  String get checkingPhone => 'Memeriksa ponselmu…';

  @override
  String get phoneReady => 'Ponselmu siap membunyikan setiap alarm tepat waktu.';

  @override
  String thingsNeedFixing(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n hal perlu diperbaiki, atau alarm mungkin tidak berbunyi.',
    );
    return '$_temp0';
  }

  @override
  String get fix => 'Perbaiki';

  @override
  String get testIn20 => 'Uji: berbunyi dalam 20 detik';

  @override
  String get testIn20Hint => 'Kunci ponselmu dan letakkan. Jika alarm berbunyi layar penuh, semuanya siap.';

  @override
  String get readyToRingHint => 'Periksa bahwa ponselmu membunyikan setiap alarm tepat waktu';

  @override
  String get connections => 'Koneksi';

  @override
  String get timeZoneHeading => 'ZONA WAKTU';

  @override
  String get followPhone => 'Ikuti ponsel';

  @override
  String followPhoneNow(String city) {
    return 'Sekarang $city. Berubah sendiri saat bepergian.';
  }

  @override
  String get zoneFixed => 'Tetap. Alarm mempertahankan waktu ini meski bepergian.';

  @override
  String get shabbatCityHeading => 'KOTA UNTUK SABAT';

  @override
  String get inIsraelOneDay => 'Di Israel (satu hari raya)';

  @override
  String candleMinutesHeading(int n) {
    return 'LILIN: $n MENIT SEBELUM MATAHARI TERBENAM';
  }

  @override
  String get endOfShabbatHeading => 'AKHIR SABAT & HARI RAYA';

  @override
  String get nightfallGeonim => 'Munculnya bintang (Geonim, 8,5°)';

  @override
  String get rabbeinuTam => '72 menit setelah matahari terbenam (Rabbeinu Tam)';

  @override
  String get whenAlarmRingsHeading => 'SAAT ALARM BERBUNYI';

  @override
  String get recordOrAddSounds => 'Rekam atau tambah suara';

  @override
  String get ringsForThisLong => 'Berbunyi selama ini, lalu berhenti sendiri';

  @override
  String get sameFades => 'Fade sama untuk semua alarm';

  @override
  String get sameFadesOn => 'Menggantikan fade setiap alarm. Masing-masing tetap memakai volumenya.';

  @override
  String get sameFadesOff => 'Mati: setiap alarm memakai fade yang diatur di Volume-nya.';

  @override
  String get sayItOutLoud => 'Ucapkan dengan suara';

  @override
  String get sayItOutLoudHint =>
      'Membacakan untuk apa alarmnya, mis. “Menyalakan lilin, 15 menit sebelumnya”';

  @override
  String get noSnooze => 'Tanpa tunda';

  @override
  String snoozeUpTo(int times, int minutes) {
    return 'Tunda hingga $times× selama $minutes mnt';
  }

  @override
  String get wakeUpCheck => 'Cek bangun';

  @override
  String get wakeUpCheckHint =>
      'Setelah dihentikan, berbunyi lagi 3 menit kemudian jika kamu tidak mengetuk “Aku sudah bangun”';

  @override
  String get solveSum => 'Selesaikan soal untuk berhenti';

  @override
  String get provesAwake => 'Membuktikan kamu sudah bangun';

  @override
  String get shabbatNoTasks =>
      'Di Sabat dan hari raya semua ini tidak berlaku: alarm berhenti sendiri dan tidak pernah meminta menyentuh ponsel.';

  @override
  String get testAlarmIn1 => 'Bunyikan alarm uji dalam 1 menit';

  @override
  String get timesDisclaimer =>
      'Waktu dihitung di ponsel. Untuk kasus yang meragukan, tanyakan rabimu atau lihat kalender komunitas.';

  @override
  String get recommended => 'Disarankan';

  @override
  String get chooseCity => 'Pilih kota';

  @override
  String get testOnlyOnPhone => 'Alarm uji hanya berfungsi di ponsel.';

  @override
  String get testAlarm => 'Alarm uji';

  @override
  String get testAlarmBody => 'Beginilah alarmmu akan berbunyi';

  @override
  String get testAlarmIn1Set => 'Alarm uji dalam 1 menit. Kamu bisa mengunci ponsel.';

  @override
  String get presetGone => 'Templat ini sudah tidak ada.';

  @override
  String get editPreset => 'Edit templat';

  @override
  String get on => 'Aktif';

  @override
  String get ringsHeading => 'BERBUNYI';

  @override
  String get noTimesYet => 'Belum ada waktu. Tambahkan di bawah.';

  @override
  String get atTheMomentItself => 'Tepat pada saatnya';

  @override
  String get remove => 'Hapus';

  @override
  String get addATime => 'Tambah waktu';

  @override
  String get resetPreset => 'Kembalikan ke asli';

  @override
  String get skipOneHint => 'Untuk melewati satu alarm, ketuk di “Alarm minggu ini” di layar utama.';

  @override
  String get unitMinutes => 'menit';

  @override
  String get unitHours => 'jam';

  @override
  String get unitDays => 'hari';

  @override
  String get before => 'Sebelum';

  @override
  String get after => 'Sesudah';

  @override
  String get oneWeek => '1 minggu';

  @override
  String daysShort(int n) {
    return '$n hr';
  }

  @override
  String hoursShort(int n) {
    return '$n j';
  }

  @override
  String get howToSearch => 'Cara mencari';

  @override
  String get searchHelpWord => 'Judul berisi “dentist”, huruf besar atau kecil';

  @override
  String get searchHelpStar => '* berarti huruf apa saja: dentist, dentures';

  @override
  String get searchHelpQuestion => '? berarti satu huruf: yoga, toga';

  @override
  String get searchHelpPhrase => 'Frasa persis ini';

  @override
  String get searchHelpAnd => 'Kedua kata (AND)';

  @override
  String get searchHelpOr => 'Salah satunya. | juga bisa';

  @override
  String get searchHelpNot => 'Kecualikan. NOT dan ! juga bisa';

  @override
  String get searchHelpBrackets => 'Tanda kurung mengelompokkan kata';

  @override
  String get searchHelpEmpty => 'Kosongkan untuk berbunyi di setiap acara.';

  @override
  String get customTime => 'Waktu lain';

  @override
  String get other => 'Lainnya';

  @override
  String get sun => 'Matahari';

  @override
  String get calendar => 'Kalender';

  @override
  String get newEventAlarm => 'Alarm acara baru';

  @override
  String get eventAlarm => 'Alarm acara';

  @override
  String get findEventsHeading => 'CARI ACARA';

  @override
  String get searchEventsHint => 'Cari: dokter gigi, gym OR yoga, gigi*…';

  @override
  String get alsoBuiltInTimes => 'Juga waktu Sabat, hari raya, dan matahari';

  @override
  String get alsoBuiltInTimesHint => 'mis. “lilin*”, “havdalah”, “terbenam”';

  @override
  String get allMyCalendars => 'Semua kalenderku';

  @override
  String get connectToSearch => 'Hubungkan kalender untuk mencari di dalamnya';

  @override
  String get searching => 'Mencari…';

  @override
  String get nothingMatches60 => 'Tidak ada yang cocok dalam 60 hari ke depan';

  @override
  String eventsIn60(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n acara dalam 60 hari ke depan');
    return '$_temp0';
  }

  @override
  String nextRingsAt(String times, String title) {
    return 'Berikutnya: berbunyi pukul $times untuk “$title”';
  }

  @override
  String showMoreLeft(int n) {
    return 'Tampilkan lagi ($n tersisa)';
  }

  @override
  String get ringBeforeStartsHeading => 'BUNYIKAN SEBELUM DIMULAI';

  @override
  String get ringWhenStarts => 'Bunyikan saat dimulai';

  @override
  String get repeatBeforeHeading => 'DAN ULANGI SEBELUMNYA';

  @override
  String get everyPrefix => 'Setiap ';

  @override
  String get offLower => 'mati';

  @override
  String get forInfix => '  selama ';

  @override
  String get ringAfterEndsHeading => 'BUNYIKAN SETELAH SELESAI';

  @override
  String get nameOptional => 'Nama (opsional)';

  @override
  String get toppedUp =>
      'Alarm diatur untuk 7 hari ke depan dan diisi ulang setiap kali kamu membuka Quando?.';

  @override
  String get back => 'Kembali';

  @override
  String get next => 'Berikutnya';

  @override
  String get stepWhichEvents => 'Acara mana';

  @override
  String get stepWhenToRing => 'Kapan berbunyi';

  @override
  String get stepHowItRings => 'Bagaimana berbunyi';

  @override
  String defaultNamed(String name) {
    return 'Bawaan ($name)';
  }

  @override
  String get phoneAlarmSound => 'Suara alarm ponsel';

  @override
  String get onlineRadio => 'Radio online';

  @override
  String songLinkOpens(String app) {
    return 'Tautan lagu · membuka $app';
  }

  @override
  String get builtIn => 'Bawaan';

  @override
  String get yourRecording => 'Rekamanmu';

  @override
  String get sound => 'Suara';

  @override
  String get wakeToOwnSound => 'Bangun dengan suaramu sendiri';

  @override
  String get wakeToOwnSoundHint => 'Suaramu, lagu, Spotify, atau radio langsung';

  @override
  String musicAdded(String name) {
    return '$name ditambahkan. Pilih sebagai suara untuk alarm mana pun.';
  }

  @override
  String get playlists => 'Playlist';

  @override
  String get likedSongs => 'Lagu yang disukai';

  @override
  String get noPlaylists => 'Belum ada playlist.';

  @override
  String get noLikedSongs => 'Belum ada lagu yang disukai.';

  @override
  String get needsMic => 'Quando? memerlukan mikrofon untuk merekam.';

  @override
  String recordingN(int n) {
    return 'Rekaman $n';
  }

  @override
  String couldNotAddFile(String error) {
    return 'Tidak bisa menambahkan file itu: $error';
  }

  @override
  String get addSongLink => 'Tambah tautan lagu';

  @override
  String get songLink => 'Tautan lagu';

  @override
  String get songLinkHowTo =>
      'Di Spotify, Apple Music, YouTube, YouTube Music, atau SoundCloud, ketuk Bagikan, lalu Salin tautan, dan tempel di sini.';

  @override
  String get songNameHint => 'Nama, mis. Playlist pagi';

  @override
  String get whenAlarmGoesOffHeading => 'SAAT ALARM BERBUNYI';

  @override
  String get playTheSong => 'Putar lagunya';

  @override
  String get ringThenOpen => 'Bunyikan, lalu buka';

  @override
  String get playTheSongHint =>
      'Aplikasinya terbuka dan memutarnya. Jika diam selama 10 detik, suara cadangan berbunyi, jadi kamu selalu bangun. Alarm dengan tugas berbunyi dulu, lalu membukanya.';

  @override
  String get ringThenOpenHint => 'Suara cadangan berbunyi. Berhenti membuka lagu di aplikasinya.';

  @override
  String get playForHeading => 'PUTAR SELAMA';

  @override
  String get pausesAfter => 'Quando? menjeda lagu setelah waktu ini, dengan tombol jeda ponsel.';

  @override
  String get backupSoundHeading => 'SUARA CADANGAN';

  @override
  String get notALink => 'Itu tidak terlihat seperti tautan.';

  @override
  String songOn(String app) {
    return 'Lagu di $app';
  }

  @override
  String get theWeb => 'web';

  @override
  String get pickFromYouTube => 'Pilih dari YouTube-ku';

  @override
  String get youTubeAndMusic => 'YouTube dan YouTube Music';

  @override
  String get youTubeOn => 'Terhubung · tahan untuk keluar';

  @override
  String get youTubeSignIn => 'Masuk dengan Google';

  @override
  String get addSongLinkInstead => 'Tambahkan tautan lagu saja.';

  @override
  String get googleSignInFailed => 'Masuk Google tidak selesai. Coba lagi.';

  @override
  String get myYouTube => 'YouTube-ku';

  @override
  String get spotifyDirectOn => 'Pemutaran langsung Spotify aktif';

  @override
  String get spotifyDirect => 'Pemutaran langsung Spotify';

  @override
  String get spotifyDirectOnHint => 'Aktif · ketuk untuk mematikan';

  @override
  String get spotifyDirectHint => 'Memutar lagu yang persis. Perlu Premium.';

  @override
  String get spotifyComingSoon => 'Segera hadir · perlu Premium';

  @override
  String get spotifyFailed =>
      'Spotify tidak terhubung. Pastikan aplikasi Spotify terpasang, kamu sudah masuk, dan punya Premium.';

  @override
  String get nameThisSound => 'Beri nama suara ini';

  @override
  String get sounds => 'Suara';

  @override
  String get soundsSentence => 'Bangun dengan suaramu sendiri, lagu, playlist, atau radio langsung.';

  @override
  String stopTimer(String time) {
    return 'Berhenti · $time';
  }

  @override
  String get record => 'Rekam';

  @override
  String get addAFile => 'Tambah file';

  @override
  String get addSongLinkLong => 'Tambah tautan lagu (Spotify, Apple Music, YouTube…)';

  @override
  String get musicAppsHeading => 'APLIKASI MUSIK';

  @override
  String get pickFromSpotify => 'Pilih dari Spotify-ku';

  @override
  String get yourPlaylistsAndLiked => 'Playlist dan lagu yang kamu sukai';

  @override
  String get mySpotify => 'Spotify-ku';

  @override
  String get spotifySignInFailed => 'Tidak bisa masuk ke Spotify.';

  @override
  String get appleMusicNote => 'Masuk akan hadir di versi iPhone. Untuk sekarang, tambahkan tautan lagu.';

  @override
  String noSignInNote(String service) {
    return '$service tidak mengizinkan aplikasi lain masuk. Tambahkan tautan lagu saja.';
  }

  @override
  String get wakeToRadio => 'Bangun dengan radio online';

  @override
  String get soundsExplain =>
      'Rekam hingga 5 menit, tambahkan file, tautan lagu, atau radio langsung. Suara cadangan berbunyi jika ada yang gagal.';

  @override
  String get yourSoundsHeading => 'SUARAMU';

  @override
  String playsIn(String app) {
    return 'Diputar di $app';
  }

  @override
  String opensIn(String app) {
    return 'Dibuka di $app';
  }

  @override
  String forSpan(String span) {
    return 'selama $span';
  }

  @override
  String get defaultLabel => 'Bawaan';

  @override
  String get radioUnreachable => 'Tidak bisa menjangkau daftar stasiun. Periksa koneksimu.';

  @override
  String get addStreamAddress => 'Tambah alamat stream';

  @override
  String get notAStream => 'Itu tidak terlihat seperti alamat stream (diawali http).';

  @override
  String get anyGenre => 'Semua genre';

  @override
  String get stationName => 'Nama stasiun';

  @override
  String get closeSearch => 'Tutup pencarian';

  @override
  String get searchByName => 'Cari berdasarkan nama';

  @override
  String get anywhere => 'Di mana saja';

  @override
  String get noStations => 'Tidak ada stasiun. Coba genre atau negara lain.';

  @override
  String wakeUpTo(String name) {
    return 'Bangun dengan $name';
  }

  @override
  String get notQuite => 'Hampir. Coba lagi.';

  @override
  String shabbatStopsItself(int n) {
    return 'Mode Sabat: berhenti sendiri dalam $n detik. Tidak perlu menyentuh ponsel.';
  }

  @override
  String get solveToSnooze => 'SELESAIKAN UNTUK MENUNDA';

  @override
  String get solveToStop => 'SELESAIKAN UNTUK BERHENTI';

  @override
  String get answer => 'Jawaban';

  @override
  String get snooze => 'Tunda';

  @override
  String get stop => 'Berhenti';

  @override
  String get shakeToSnooze => 'GONCANG UNTUK MENUNDA';

  @override
  String get shakeToStop => 'GONCANG UNTUK BERHENTI';

  @override
  String get shakeHard => 'Goncang ponsel kuat-kuat sampai bilahnya penuh.';

  @override
  String get cantShake => 'Tidak bisa menggoncang? Selesaikan soal';

  @override
  String get pairsToSnooze => 'COCOKKAN PASANGAN UNTUK MENUNDA';

  @override
  String get pairsToStop => 'COCOKKAN PASANGAN UNTUK BERHENTI';

  @override
  String get typeToSnooze => 'KETIK INI UNTUK MENUNDA';

  @override
  String get typeToStop => 'KETIK INI UNTUK BERHENTI';

  @override
  String get scanToSnooze => 'PINDAI KODEMU UNTUK MENUNDA';

  @override
  String get scanToStop => 'PINDAI KODEMU UNTUK BERHENTI';

  @override
  String ringAgainUnless(int n) {
    return 'Aku akan berbunyi lagi dalam $n menit kecuali kamu mengetuk di bawah.';
  }

  @override
  String get imUp => 'Aku sudah bangun';

  @override
  String snoozeMin(int n) {
    return 'Tunda $n mnt';
  }

  @override
  String snoozeMinLeft(int n, int left) {
    return 'Tunda $n mnt · sisa $left';
  }

  @override
  String get noSnoozesLeft => 'Jatah tunda habis';

  @override
  String get stopThenOpen => 'Berhenti · lalu buka';

  @override
  String get startingSong => 'Memulai lagumu';

  @override
  String wayToStop(String way) {
    return '$way untuk berhenti';
  }

  @override
  String wayToSnooze(String way) {
    return '$way untuk menunda';
  }

  @override
  String ringsForMore(int n) {
    return 'Berbunyi $n detik lagi';
  }

  @override
  String get leftToRing => 'tersisa';

  @override
  String get wayVolumeButtons => 'Tombol volume';

  @override
  String get wayShake => 'Goncang ponsel';

  @override
  String get taskNothing => 'Tidak ada';

  @override
  String get taskSum => 'Selesaikan soal';

  @override
  String get taskShake => 'Goncang 30 kali';

  @override
  String get taskMemory => 'Permainan memori';

  @override
  String get taskPhrase => 'Ketik kalimat';

  @override
  String get taskScan => 'Pindai kode';

  @override
  String get noLimit => 'tanpa batas';

  @override
  String upToTimes(int n) {
    return 'hingga $n×';
  }

  @override
  String shorterEachTime(int n) {
    return '$n mnt lebih singkat tiap kali';
  }

  @override
  String autoSnoozeAfter(int n) {
    return 'tunda otomatis setelah $n mnt';
  }

  @override
  String get card => 'Kartu';

  @override
  String get hiddenCard => 'Kartu tertutup';

  @override
  String get phrase1 => 'Aku sudah bangun dan hari ini milikku';

  @override
  String get phrase2 => 'Kalau bukan sekarang kapan lagi';

  @override
  String get phrase3 => 'Selamat pagi untukku dan semua yang kucintai';

  @override
  String get phrase4 => 'Kakiku di lantai dan aku sudah bangun';

  @override
  String get phrase5 => 'Hari ini aku mulai lagi';

  @override
  String get notQuiteWords => 'Hampir, periksa setiap kata.';

  @override
  String get typeItHere => 'Ketik di sini';

  @override
  String get differentCode => 'Itu kode yang berbeda.';

  @override
  String get cameraUnavailable => 'Kamera tidak tersedia.';

  @override
  String get cantScan => 'Tidak bisa memindai? Selesaikan soal';

  @override
  String get saveCodeToScan => 'Simpan kode untuk dipindai';

  @override
  String get saveCodeHint =>
      'Arahkan ke barcode atau kode QR di tempat yang harus kamu datangi, seperti kotak di dapur atau pasta gigi di kamar mandi. Untuk menghentikan alarm, kamu akan memindainya lagi.';

  @override
  String get cameraUnavailableSettings => 'Kamera tidak tersedia. Izinkan akses kamera di Pengaturan.';

  @override
  String gentleToGo(int n) {
    return 'Bangun perlahan · $n mnt lagi';
  }

  @override
  String previewBody(String body) {
    return 'Pratinjau · $body';
  }

  @override
  String snoozedBody(String body) {
    return 'Ditunda: $body';
  }

  @override
  String get areYouUp => 'Sudah bangun?';

  @override
  String get tapImUp => 'Ketuk “Aku sudah bangun” untuk berhenti';

  @override
  String get volume => 'Volume';

  @override
  String get wakeCheckOn => 'Cek bangun aktif';

  @override
  String get stopsAtOnce => 'Langsung berhenti';

  @override
  String get ringsAgainIfNotUp => 'Berbunyi lagi jika kamu belum bangun';

  @override
  String get openAppAfter => 'Buka aplikasi setelahnya';

  @override
  String get noTask => 'Tanpa tugas';

  @override
  String get codeSaved => 'Kode disimpan';

  @override
  String get tapToSaveDifferent => 'Ketuk untuk menyimpan yang lain';

  @override
  String get controlsHeading => 'KONTROL';

  @override
  String get onScreen => 'Di layar';

  @override
  String get taskHeading => 'TUGAS';

  @override
  String get none => 'Tidak ada';

  @override
  String get snoozeSentence => 'Lima menit lagi? Pilih berapa lama, berapa kali, dan apa yang diperlukan.';

  @override
  String get settingsHeading => 'PENGATURAN';

  @override
  String get snoozeTime => 'Waktu tunda';

  @override
  String get snoozeTimeHint => 'Lama tunda pertama';

  @override
  String get shortenSnoozes => 'Persingkat tunda berikutnya';

  @override
  String get shortenSnoozesHint => 'Setiap tunda setelah yang pertama lebih singkat sebanyak ini';

  @override
  String get autoSnooze => 'Tunda otomatis';

  @override
  String get autoSnoozeHint => 'Jika tidak kamu sentuh, menunda sendiri setelah';

  @override
  String get never => 'Tidak pernah';

  @override
  String get snoozeLimit => 'Batas tunda';

  @override
  String get snoozeLimitHint => 'Berapa kali kamu bisa menunda';

  @override
  String get unlimited => 'Tanpa batas';

  @override
  String get useSnoozeFromSettings => 'Pakai tunda dari Pengaturan';

  @override
  String get stopSentence => 'Cara mematikan alarm dan apa yang harus dilakukan dulu.';

  @override
  String get shabbatNoTask => 'Di Sabat dan hari raya alarm berhenti sendiri dan tidak pernah meminta tugas.';

  @override
  String get volumeSentence => 'Seberapa keras berbunyi dan seberapa lembut ia sampai ke sana.';

  @override
  String get openAfterAlarm => 'Buka setelah alarm';

  @override
  String get pickAnApp => 'Pilih aplikasi';

  @override
  String get orPasteLink => 'Atau tempel tautan: https://…';

  @override
  String get useThisLink => 'Pakai tautan ini';

  @override
  String get noAppsFound => 'Tidak ada aplikasi.';

  @override
  String get weather => 'Cuaca';

  @override
  String get news => 'Berita';

  @override
  String get usePhoneVolume => 'Pakai volume alarm ponsel';

  @override
  String get setsPhoneVolume => 'Mengatur volume alarm ponsel saat berbunyi, lalu mengembalikannya.';

  @override
  String get fadeInOff => 'Tanpa fade in, langsung volume penuh';

  @override
  String fadeInOver(String span) {
    return 'Naik selama $span';
  }

  @override
  String get fadeOutOff => 'Tanpa fade out';

  @override
  String fadeOutOver(String span) {
    return 'Turun di $span terakhir';
  }

  @override
  String get fadesExplain =>
      'Fade out terjadi saat alarm berhenti sendiri. Jika fade lebih panjang dari waktu bunyi, keduanya dipersingkat.';

  @override
  String get soundSoftChime => 'Lonceng lembut';

  @override
  String get soundMorningRise => 'Fajar pagi';

  @override
  String get soundClassicBeep => 'Bip klasik';

  @override
  String get calmCity => 'Pagi kota yang tenang';

  @override
  String get calmBirds => 'Burung di waktu fajar';

  @override
  String get calmWaves => 'Ombak di pantai';

  @override
  String get calmRain => 'Hujan rintik';

  @override
  String get calmStream => 'Sungai di hutan';

  @override
  String get calmWind => 'Angin sepoi';

  @override
  String get calmFire => 'Api berderak';

  @override
  String get calmNight => 'Malam musim panas';

  @override
  String get publicDomain => 'Domain publik';

  @override
  String get phoneVolume => 'Volume ponsel';

  @override
  String fadesIn(String span) {
    return 'naik selama $span';
  }

  @override
  String fadesOut(String span) {
    return 'turun selama $span';
  }

  @override
  String get noFade => 'tanpa fade';

  @override
  String minSecShort(int m, int s) {
    return '$m mnt $s dtk';
  }

  @override
  String get happensRings => 'Berbunyi';

  @override
  String get happensStopped => 'Kamu menghentikannya';

  @override
  String get happensSnoozed => 'Kamu menundanya';

  @override
  String get happensAutoStopped => 'Berhenti sendiri';

  @override
  String get eventLower => 'acara';

  @override
  String get appTest => 'Uji Quando?';

  @override
  String get pushoverConnected => 'Pushover terhubung';

  @override
  String get webhookConnected => 'Webhook terhubung';

  @override
  String pushoverSaid(int code, String body) {
    return 'Pushover menjawab $code: $body';
  }

  @override
  String couldNotReachPushover(String error) {
    return 'Tidak bisa menjangkau Pushover ($error)';
  }

  @override
  String itAnswered(int code) {
    return 'Jawaban: $code';
  }

  @override
  String couldNotReachIt(String error) {
    return 'Tidak bisa menjangkaunya ($error)';
  }

  @override
  String get calendarNotAllowed => 'Akses kalender tidak diizinkan.';

  @override
  String get playlist => 'Playlist';

  @override
  String songCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n lagu');
    return '$_temp0';
  }

  @override
  String get spotifySaidNo =>
      'Spotify menolak. Di dasbor Spotify, centang Web API untuk Quando? dan tambahkan akunmu di User Management.';

  @override
  String serviceDidntAnswer(String service, int code) {
    return '$service tidak menjawab ($code).';
  }

  @override
  String get youTubeSaidNo => 'YouTube menolak. Pastikan akun Google-mu adalah pengguna uji proyek Quando.';

  @override
  String get event => 'Acara';

  @override
  String eventEnds(String title) {
    return '$title (selesai)';
  }

  @override
  String foundSoundsDevices(int s, int d) {
    return 'Ditemukan $s suara dan $d perangkat.';
  }

  @override
  String get sentCheckDevices => 'Terkirim. Periksa perangkatmu yang lain.';

  @override
  String sentTo(String name) {
    return 'Terkirim ke $name.';
  }

  @override
  String get zapierHowTo =>
      'Di Zapier, buat Zap yang dimulai dengan “Webhooks by Zapier → Catch Hook”, lalu tempel URL-nya di sini.';

  @override
  String get catchHookUrl => 'URL Catch Hook';

  @override
  String get iftttHowTo =>
      'Di IFTTT, buat applet yang dimulai dengan “Webhooks → Receive a web request with a JSON payload”. Gunakan nama acara yang sama di sini. Kuncimu ada di ifttt.com/maker_webhooks/settings.';

  @override
  String get eventName => 'Nama acara';

  @override
  String get webhooksKey => 'Kunci Webhooks';

  @override
  String get webhookHowTo => 'Quando? mengirim JSON POST ke alamat ini.';

  @override
  String get connectionsSentence =>
      'Beri tahu aplikasi dan perangkat lain saat alarm berbunyi, dihentikan, atau ditunda.';

  @override
  String get pushWhenRings => 'Kirim notifikasi saat alarm berbunyi';

  @override
  String get pushWhenRingsHint => 'Ke ponsel, tablet, jam tangan, atau komputermu yang lain';

  @override
  String get yourUserKey => 'Kunci penggunamu';

  @override
  String get appToken => 'Token aplikasi';

  @override
  String get soundAndDevicesHeading => 'SUARA DAN PERANGKAT';

  @override
  String get loading => 'Memuat…';

  @override
  String get loadFromPushover => 'Muat dari Pushover';

  @override
  String get soundItPlays => 'Suara yang diputar';

  @override
  String get myPushoverDefault => 'Bawaan Pushover-ku';

  @override
  String get pushoverOwnSounds =>
      'Suaramu sendiri muncul di sini setelah kamu mengunggahnya di pushover.net/sounds.';

  @override
  String get allMyDevices => 'Semua perangkatku';

  @override
  String get pushoverOnThisPhone =>
      'Pasang aplikasi Pushover di ponsel ini juga, maka ia akan berbunyi di sini dengan suara Pushover-mu.';

  @override
  String get priority => 'Prioritas';

  @override
  String get priorityNormal => 'Normal';

  @override
  String get priorityHigh => 'Tinggi: menembus jam tenang';

  @override
  String get priorityEmergency => 'Darurat: berulang sampai dikonfirmasi';

  @override
  String get sending => 'Mengirim…';

  @override
  String get sendATest => 'Kirim uji';

  @override
  String get findUserKey => 'Cari kunci penggunaku';

  @override
  String get makeAppToken => 'Buat token aplikasi';

  @override
  String get webhooksHeading => 'ZAPIER, IFTTT & WEBHOOK';

  @override
  String get webhooksExplain =>
      'Mulai apa saja saat alarm berbunyi atau kamu menghentikannya: nyalakan lampu, catat waktu bangun, kirim pesan ke seseorang.';

  @override
  String get sendWhenAlarm => 'Kirim saat alarm:';

  @override
  String get pauseOnShabbat => 'Jeda di Sabat dan hari raya';

  @override
  String get pauseOnShabbatHint => 'Tidak ada yang dikirim untuk alarm antara menyalakan lilin dan havdalah';

  @override
  String get webhookPayloadNote =>
      'Setiap pesan berisi: event (ring, stopped, snoozed, auto_stopped), title, body, time, shabbat, dan snoozes. Kunci tetap di ponsel ini.';

  @override
  String get today => 'Hari ini';

  @override
  String get tomorrow => 'Besok';

  @override
  String get notAWebAddress => 'Itu tidak terlihat seperti alamat web yang diawali https://';

  @override
  String get language => 'Bahasa';

  @override
  String get phoneLanguage => 'Bahasa ponsel';

  @override
  String get ringQuote => 'Kalau bukan sekarang, kapan?';

  @override
  String get ringQuoteBy => 'Hillel';

  @override
  String get quotesTitle => 'Kutipan tentang waktu';

  @override
  String get quotesHint =>
      'Pilih sumbernya. Satu untuk tiap bagian hari; ketuk kutipan untuk melihat yang lain.';

  @override
  String get quotesOff => 'Mati';

  @override
  String get quoteSongs => 'Lagu';

  @override
  String get quoteMovies => 'Film';

  @override
  String get quoteLiterature => 'Buku dan puisi';

  @override
  String get quoteTanakh => 'Tanakh (Alkitab Ibrani)';

  @override
  String get quoteSages => 'Talmud dan orang bijak';

  @override
  String get quoteSpeeches => 'Pidato terkenal';

  @override
  String get quotePhilosophy => 'Filsuf';

  @override
  String get quoteProverbs => 'Peribahasa dan ungkapan';

  @override
  String get quotesAlso => 'Tampilkan juga';

  @override
  String get quoteCarnaval => 'Karnaval';

  @override
  String get quoteCarnavalHint => 'Lagu dan ungkapan selama Karnaval Brasil';

  @override
  String get quoteNearMe => 'Di dekat saya';

  @override
  String get quoteNearMeHint => 'Penyair dan hari lokal tempatmu, dari zona waktu dan kota Shabbat';

  @override
  String get quoteSiddur => 'Siddur (buku doa)';

  @override
  String weeklyParasha(String name) {
    return 'Parasyah $name';
  }

  @override
  String poweredBy(String name) {
    return 'didukung $name';
  }

  @override
  String get syncTitle => 'Sinkronkan perangkat saya';

  @override
  String get syncHint => 'Masuk dengan Google agar alarm dan pengaturan tetap sama di semua perangkatmu.';

  @override
  String syncOn(String email) {
    return 'On · $email';
  }

  @override
  String get syncWorking => 'Connecting…';

  @override
  String get syncNotAllowed => 'This Google account can\'t sync.';

  @override
  String get syncFailed => 'Tidak dapat terhubung. Ketuk untuk mencoba lagi.';

  @override
  String get syncStop => 'Stop syncing';

  @override
  String get syncNotSetUp => 'Sinkronisasi belum disiapkan di versi ini.';

  @override
  String get ringTheseAfterAll => 'Tetap bunyikan';

  @override
  String skipTheseDay(int n) {
    return 'Lewati $n alarm ini hari ini';
  }

  @override
  String turnOffNamed(String name) {
    return 'Matikan “$name”';
  }

  @override
  String turnOnNamed(String name) {
    return 'Nyalakan “$name”';
  }

  @override
  String turnedOffNamed(String name) {
    return '“$name” dimatikan';
  }

  @override
  String removeTimeFrom(String time, String name) {
    return 'Hapus “$time” dari “$name”';
  }

  @override
  String removedTimeFrom(String time, String name) {
    return '“$time” dihapus dari “$name”';
  }

  @override
  String get moveToGroup => 'Pindahkan ke grup';

  @override
  String inGroupMove(String group) {
    return 'Di “$group”, pindahkan';
  }

  @override
  String movedToGroup(String group) {
    return 'Dipindahkan ke “$group”';
  }

  @override
  String deleteNamed(String name) {
    return 'Hapus “$name”';
  }

  @override
  String get signInWithGoogle => 'Masuk dengan Google';

  @override
  String get signOut => 'Sign out';

  @override
  String get signInWithEmail => 'Masuk dengan email';

  @override
  String get signIn => 'Sign in';

  @override
  String get createAccount => 'Buat akun';

  @override
  String get haveAccount => 'Saya sudah punya akun';

  @override
  String get forgotPassword => 'Lupa kata sandi?';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get passwordResetSent => 'Kami mengirimkan tautan untuk memilih kata sandi baru.';

  @override
  String emailCheckInbox(String email) {
    return 'Kami mengirim tautan ke $email. Buka tautannya, lalu kembali dan ketuk “Sudah saya konfirmasi”.';
  }

  @override
  String get emailConfirmed => 'Sudah saya konfirmasi';

  @override
  String get emailNotYet => 'Belum dikonfirmasi. Buka dulu tautan di email.';

  @override
  String get emailSendAgain => 'Kirim ulang email';

  @override
  String get emailSentAgain => 'Terkirim. Periksa kotak masuk dan spam.';

  @override
  String get emailInvalid => 'Itu tidak terlihat seperti alamat email.';

  @override
  String get emailWrong => 'Email atau kata sandi salah.';

  @override
  String get emailInUse =>
      'Sudah ada akun dengan email ini. Masuk saja, atau gunakan Google jika kamu membuatnya dengan Google.';

  @override
  String get passwordWeak => 'Pilih kata sandi minimal 6 karakter.';

  @override
  String get emailNotSwitchedOn => 'Masuk dengan email belum diaktifkan.';

  @override
  String get tooManyTries => 'Terlalu banyak percobaan. Tunggu beberapa menit.';

  @override
  String get spotifyLibrary => 'Spotify';

  @override
  String get spotifyLibrarySignIn => 'Playlist, lagu yang disukai, dan pencarian';

  @override
  String get spotifyLibraryOn => 'Terhubung · tahan untuk keluar';

  @override
  String spotifyLoginError(String reason) {
    return 'Masuk ke Spotify gagal: $reason';
  }

  @override
  String googleSignInError(String reason) {
    return 'Masuk ke Google gagal: $reason';
  }

  @override
  String get searchSongsHint => 'Cari lagu, artis, playlist';

  @override
  String nothingFound(String query) {
    return 'Tidak ada hasil untuk “$query”.';
  }

  @override
  String get deliveryTitle => 'Pengiriman';

  @override
  String get deliveryLocal => 'Audio lokal';

  @override
  String get deliveryBoth => 'Keduanya';

  @override
  String get deliveryConnect => 'Hubungkan Pushover';

  @override
  String get deliveryLoadFailed => 'Suara dan perangkat tidak dapat dimuat. Coba lagi.';

  @override
  String get deliveryBothHint => 'Audio lokal tetap berbunyi jika Pushover gagal.';

  @override
  String get deliveryPushHint => 'Hanya Pushover. Perangkat ini harus online saat alarm berbunyi.';

  @override
  String get deliveryFallback => 'Audio lokal tetap aktif jika Pushover terputus atau dijeda.';

  @override
  String get deliveryReset => 'Gunakan pengaturan yang ada';

  @override
  String get beforeShabbat => 'Sebelum Sabat';

  @override
  String get preparationReminders => 'Pengingat persiapan';

  @override
  String get skipThisWeek => 'Lewati minggu ini';

  @override
  String get restoreThisWeek => 'Pulihkan minggu ini';

  @override
  String get allAlarms => 'All alarms';

  @override
  String get timesAndSound => 'Waktu & suara';

  @override
  String get changeCity => 'Change city';

  @override
  String get useMyLocation => 'Gunakan lokasiku';

  @override
  String get locationUnavailable => 'Lokasi sementara tidak tersedia. Coba lagi atau pilih kota.';

  @override
  String get locationReview => 'Konfirmasi lokasi ini';

  @override
  String get locationDeviceOnly =>
      'Lokasi ini hanya disimpan di perangkat ini. Periksa zona waktu dan pengaturan Israel sebelum memakai waktu-waktu ini.';

  @override
  String timesIn(String city, String zone) {
    return '$city · $zone · waktu kota';
  }

  @override
  String get preparationOff => 'Pengingat persiapan mati. Havdalah dan alarm biasa tidak berubah.';

  @override
  String get preparationSkipped =>
      'Pengingat persiapan dilewati minggu ini. Pengaturan mingguanmu tetap tersimpan.';

  @override
  String get shabbatControls => 'Kontrol Sabat';

  @override
  String get duringAfterShabbat => 'Selama / setelah Sabat';

  @override
  String locationCoordinates(String latitude, String longitude) {
    return 'Lintang $latitude · bujur $longitude';
  }

  @override
  String get currentLocation => 'Lokasi saat ini';

  @override
  String get testPushoverSound => 'Uji suara di Pushover';

  @override
  String get pushoverSoundTestHint =>
      'Memutar suara yang dipilih di perangkat Pushover yang kamu pilih. Pengaturan senyap dan jam tenang tetap berlaku.';

  @override
  String get pushoverShareDevices => 'Bagikan kredensial ke perangkatku';

  @override
  String get pushoverShareHint =>
      'Kunci pengguna Pushover dan token aplikasimu dapat mengikuti akunmu yang sudah masuk di Quando? dan Matai?.';

  @override
  String get pushoverShareQueued => 'Kredensial antre untuk perangkatmu yang sudah masuk.';

  @override
  String get pushoverShareSignIn =>
      'Masuk ke akun aplikasi yang sama di setiap perangkat untuk membagikan kredensial Pushover.';

  @override
  String get smartHomeHeading => 'Smart home';

  @override
  String get smartHomeHint =>
      'Jalankan skena Tuya langsung, atau hubungkan otomasi Home Assistant atau Node-RED milikmu.';

  @override
  String get shareServices => 'Bagikan koneksi layanan';

  @override
  String get shareServicesHint =>
      'Gunakan akun aplikasi yang sama di perangkatmu untuk membagikan koneksi Pushover, Tuya, pustaka Spotify, dan otomasi. YouTube dan izin perangkat mungkin masih perlu disetujui di setiap perangkat.';

  @override
  String get tuyaSetupHint =>
      'Gunakan proyek pengembang Tuya yang tertaut. Masukkan pusat datanya, Access ID, Access Secret, dan UID yang tampil di “Link App Account”. Home Assistant tidak diperlukan.';

  @override
  String get tuyaDataCenter => 'Data center';

  @override
  String get tuyaUserId => 'UID akun tertaut';

  @override
  String get tuyaAccessId => 'Access ID / Client ID';

  @override
  String get tuyaAccessSecret => 'Access Secret / Client Secret';

  @override
  String get tuyaLoadScenes => 'Load scenes';

  @override
  String get tuyaNoScenes =>
      'Tidak ada skena Tap-to-Run yang tersedia. Periksa akun tertaut, pusat data, dan izin API skena.';

  @override
  String get tuyaRunNow => 'Jalankan skena sekarang';

  @override
  String get tuyaRunConfirm => 'Jalankan skena ini di perangkat Tuya-mu sekarang?';

  @override
  String get tuyaSent => 'Tuya menerima perintah skena. Periksa perangkatmu.';

  @override
  String get tuyaFailed =>
      'Tuya tidak dapat menyelesaikan permintaan. Periksa izin proyek, pusat data, dan langganan. Kesalahan:';

  @override
  String get tuyaAlarmScene => 'Skena Tuya saat alarm ini berbunyi';

  @override
  String get homeAssistantHowTo =>
      'Buat otomasi Home Assistant dengan pemicu Webhook yang menerima POST dan JSON. Tempel URL-nya di sini. Gunakan kejadian alarm (ring, stopped, snoozed, atau auto_stopped) untuk memilih tindakanmu. Perangkat baru menerima koneksi ini dalam keadaan mati.';

  @override
  String get nodeRedHowTo =>
      'Gunakan node HTTP In Node-RED yang menerima POST, diikuti otomasimu dan node HTTP Response. Tempel endpoint di sini. Hub HTTP lokal dan endpoint HTTPS didukung.';

  @override
  String get smartHomeConnect => 'Hubungkan layanan rumah pintar';

  @override
  String get automationTestHint => 'Pengujian langsung menjalankan otomasi yang terhubung.';

  @override
  String get smartHomeDeviceOn => 'Jalankan aksi alarm rumah pintar di perangkat ini';

  @override
  String get smartHomeDeviceHint =>
      'Pilih satu perangkat untuk menjalankan otomasimu. Koneksi dibagikan; sakelar ini hanya berlaku di perangkat ini.';

  @override
  String get smartHomeDeviceOff =>
      'Aksi alarm mati di perangkat ini. Aktifkan di Koneksi; uji skena manual tetap berfungsi.';

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
  String get weatherSwipeHint => 'Geser antara langit dan cuaca';

  @override
  String get parashaHeading => 'Parasyah mingguan';

  @override
  String get dailyStudyHeading => 'Belajar harian';

  @override
  String get courseDaf => 'Daf Yomi';

  @override
  String get courseRambam1 => 'Rambam · 1 pasal per hari';

  @override
  String get courseRambam3 => 'Rambam · 3 pasal per hari';

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
  String get moonAlwaysUp => 'Bulan di atas cakrawala sepanjang hari';

  @override
  String get moonAlwaysDown => 'Bulan di bawah cakrawala sepanjang hari';

  @override
  String get noRiseToday => 'Tidak terbit hari ini';

  @override
  String get noSetToday => 'No set today';

  @override
  String get moonNew => 'New moon';

  @override
  String get moonWaxingCrescent => 'Sabit awal';

  @override
  String get moonFirstQuarter => 'Kuartal pertama';

  @override
  String get moonWaxingGibbous => 'Cembung awal';

  @override
  String get moonFull => 'Full moon';

  @override
  String get moonWaningGibbous => 'Cembung akhir';

  @override
  String get moonLastQuarter => 'Last quarter';

  @override
  String get moonWaningCrescent => 'Sabit akhir';

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
  String get weatherThunder => 'Badai petir';

  @override
  String get weatherUnavailable => 'Cuaca sementara tidak tersedia';

  @override
  String get weatherCached => 'Prakiraan tersimpan';

  @override
  String get weatherUpdated => 'Updated';

  @override
  String get weatherForecast => 'Forecast';

  @override
  String get weatherThunderExpected => 'Prakiraan badai petir';

  @override
  String get learningUnavailable => 'Hubungkan untuk memuat jadwal belajar bulan ini';

  @override
  String get festivalReading => 'Pembacaan Taurat hari raya';

  @override
  String get learningCalendarSource => 'Kalender belajar · Hebcal · CC BY 4.0';

  @override
  String get weatherSource => 'Prakiraan · MET Norway · CC BY 4.0';

  @override
  String get weatherConsent =>
      'Cuaca untuk kota yang Anda pilih. Menggunakan koordinat yang dibulatkan dengan MET Norway.';

  @override
  String get learningConsent =>
      'Jadwal belajar Rambam dan lainnya dimuat dari Hebcal dan disimpan untuk penggunaan offline.';

  @override
  String get homeRefresh => 'Refresh';

  @override
  String get skyTimezone => 'My timezone';

  @override
  String get skyShabbat => 'Shabbat city';

  @override
  String get skyReferenceCity => 'Kota acuan zona waktu';

  @override
  String get skyChooseCity => 'Pilih kota langit';

  @override
  String get skyCityExplain =>
      'Matahari dan Bulan memakai koordinat kota ini. Kota Sabat dan zona waktu alarm tetap seperti yang kamu pilih.';

  @override
  String get skySun => 'Sun today';

  @override
  String get skyMoon => 'Moon today';

  @override
  String get moonAboveHorizon => 'Bulan di atas cakrawala';

  @override
  String get moonBelowHorizon => 'Bulan di bawah cakrawala';

  @override
  String get moonNextNew => 'Bulan baru berikutnya';

  @override
  String get moonNextFull => 'Bulan purnama berikutnya';

  @override
  String get locationServicesOff => 'Layanan Lokasi mati. Nyalakan di Pengaturan atau pilih kota.';

  @override
  String get locationDenied => 'Akses lokasi ditolak. Izinkan di Pengaturan atau pilih kota.';

  @override
  String get locationTimedOut =>
      'Lokasi belum didapat. Di Mac, biarkan Wi-Fi menyala dan coba lagi, atau pilih kota.';

  @override
  String get locationTimeZoneUnavailable =>
      'Gunakan kota di zona waktu yang dipilih, atau ikuti zona waktu perangkatmu sebelum memakai lokasi.';

  @override
  String get locationSettings => 'Buka pengaturan lokasi';

  @override
  String get locationLooking => 'Mencari lokasi…';

  @override
  String get skyMoonDisplay => 'Tampilkan Bulan: terbit, terbenam, dan fase';

  @override
  String get tuyaConsumerPending =>
      'Masuk dengan akun belum tersedia di versi ini. Jika kamu sudah punya proyek pengembang Tuya, gunakan penyiapan lanjutan.';

  @override
  String get tuyaAdvanced => 'Penyiapan lanjutan';

  @override
  String get tuyaSignInTitle => 'Masuk dengan akun Smart Life';

  @override
  String get tuyaSignInHint =>
      'Gunakan negara, email atau telepon, dan kata sandi yang sama seperti di aplikasi Smart Life atau Tuya Smart. Akun harus sudah tertaut ke proyek Tuya Anda. Kata sandi hanya dikirim ke Tuya dan tidak pernah disimpan.';

  @override
  String get tuyaCountryCode => 'Kode negara (Brasil 55, AS 1)';

  @override
  String get tuyaAccount => 'Email atau telepon Smart Life';

  @override
  String get tuyaPassword => 'Kata sandi Smart Life';

  @override
  String get tuyaSignIn => 'Masuk dan muat skenario';

  @override
  String get tuyaRelayUrl => 'Alamat relay Tuya Quando (https)';

  @override
  String get tuyaRelayHint =>
      'Gunakan negara, email atau telepon, dan kata sandi akun Smart Life atau Tuya Smart Anda. Semuanya dikirim sekali ke relay Tuya Quando dan tidak disimpan. Anda harus masuk ke akun Quando.';

  @override
  String get tuyaGoogleHint =>
      'Masuk Smart Life dengan Google atau Apple? Di Smart Life, ketuk “Lupa Kata Sandi” untuk membuat kata sandi, lalu gunakan di sini.';

  @override
  String get tuyaLinked => 'Akun Smart Life tertaut';

  @override
  String get tuyaUnlink => 'Putuskan tautan';

  @override
  String get tuyaNeedsAccount => 'Masuk dulu ke akun Quando di Pengaturan.';

  @override
  String get roshHodeshHeading => 'Rosh Hodesh';

  @override
  String get roshHodeshExplain =>
      'Menampilkan hari pertama atau dua hari pertama bulan Ibrani berikutnya di Beranda.';

  @override
  String get roshHodeshNext => 'Rosh Hodesh berikutnya';

  @override
  String get roshHodeshBegins => 'Dimulai saat matahari terbenam pada';

  @override
  String get openParashaSefaria => 'Baca bagian Taurat ini di Sefaria';

  @override
  String get skyMyLocation => 'My location';

  @override
  String get skyLocationLocalTimes =>
      'Waktu langit memakai zona waktu lokasi ini. Zona waktu alarm dan kota Sabat tidak berubah. Hanya disimpan di perangkat ini.';

  @override
  String get musicRingDurationHint =>
      'Pemutaran mengikuti durasi dering alarm ini dan berhenti dengan Hentikan atau Tunda.';

  @override
  String get musicBackupPlaying => 'Musik tidak dapat dimulai. Suara alarm lokal sedang diputar.';

  @override
  String desktopMusicConnect(String service) {
    return 'Hubungkan aplikasi $service';
  }

  @override
  String desktopMusicOn(String service) {
    return 'Terhubung ke $service · tahan untuk memutus';
  }

  @override
  String get musicSongs => 'Lagu';

  @override
  String get noMusicSongs => 'Tidak ada lagu ditemukan di perpustakaan Musik.';

  @override
  String serviceConnectUnavailable(String service) {
    return 'Tambahkan tautan $service · terbuka setelah alarm';
  }

  @override
  String get soundCloudWidgetNote => 'Tambahkan tautan publik';

  @override
  String get youtubePlayerHint =>
      'YouTube memutar video di pemutar yang terlihat. Jika disembunyikan atau tidak dapat memutar, alarm lokal berlanjut.';

  @override
  String get musicPreviewFailed =>
      'Suara ini tidak dapat diputar. Periksa koneksi atau coba lagu atau stasiun lain.';

  @override
  String get skyMoonPhase => 'Fase Bulan';

  @override
  String get skyMoonDetailsDisplay => 'Tambahkan halaman fase Bulan';

  @override
  String get skyMoonDetailsHint => 'Geser ke sana, atau ketuk kartu Bulan kapan saja';

  @override
  String get moonRises => 'Terbit';

  @override
  String get moonSets => 'Terbenam';

  @override
  String moonLunarDay(int day) {
    return 'Hari $day dari 29,5 di bulan lunar ini';
  }

  @override
  String get moonDetailsOpen => 'Buka fase Bulan';

  @override
  String get musicPlaylists => 'Playlist musik';

  @override
  String get videoPlaylists => 'Playlist video';

  @override
  String get likedVideos => 'Video yang disukai';

  @override
  String get wholePlaylist => 'Bangun dengan seluruh playlist';

  @override
  String get noSongsInPlaylist => 'Tidak ada lagu yang bisa diputar di sini.';

  @override
  String get hebrewNamesHeading => 'Ejaan nama parasha dan bulan';

  @override
  String get hebrewNamesIsraeli => 'Israel';

  @override
  String get hebrewNamesAshkenazi => 'Ashkenazi';

  @override
  String pickFromService(String service) {
    return 'Pilih dari $service-ku';
  }

  @override
  String get weatherTonight => 'Malam ini';

  @override
  String get weatherTomorrowMorning => 'Besok pagi';

  @override
  String weatherUntilAbout(String time) {
    return 'sampai sekitar $time';
  }

  @override
  String get weatherSunBehindClouds => 'Matahari di balik awan';

  @override
  String get keysLockTitle => 'Kunci di perangkat Anda';

  @override
  String get keysLockOff =>
      'Kunci layanan Anda tetap di perangkat ini. Pilih frasa sinkronisasi untuk mengirimnya, terenkripsi, ke perangkat Anda yang lain.';

  @override
  String get keysLockOn =>
      'Kunci layanan Anda dienkripsi dengan frasa sinkronisasi sebelum meninggalkan perangkat ini. Tidak ada orang lain, bahkan Google, yang bisa membacanya.';

  @override
  String get keysLockWaiting =>
      'Kunci dari perangkat Anda yang lain sudah tiba di sini, terkunci. Ketik frasa sinkronisasi untuk membukanya.';

  @override
  String get keysSetPassphrase => 'Pilih frasa';

  @override
  String get keysChangePassphrase => 'Ubah frasa';

  @override
  String get keysUnlock => 'Buka kunci';

  @override
  String get keysStartOver => 'Lupa? Mulai ulang';

  @override
  String get keysStartOverHint =>
      'Mulai ulang mengirim kunci perangkat ini dengan frasa baru. Perangkat lain akan meminta frasa baru.';

  @override
  String get keysPassphrase => 'Frasa sinkronisasi';

  @override
  String get keysPassphraseAgain => 'Ketik sekali lagi';

  @override
  String keysPassphraseShort(int count) {
    return 'Gunakan minimal $count karakter.';
  }

  @override
  String get keysPassphraseMismatch => 'Keduanya tidak sama.';

  @override
  String get keysPassphraseWrong => 'Frasa itu tidak membuka kunci ini.';

  @override
  String get keysPassphraseNote =>
      'Catat baik-baik: jika lupa, tidak ada yang bisa memulihkannya dan Anda harus mengetik kunci lagi.';

  @override
  String get keysShareNeedsPassphrase => 'Pilih frasa sinkronisasi dulu, di Kunci di perangkat Anda.';

  @override
  String get settingsAlarmDefaults => 'Pengaturan bawaan alarm';

  @override
  String get settingsPlacesTime => 'Tempat & waktu';

  @override
  String get settingsLook => 'Tampilan, bahasa & kutipan';

  @override
  String get settingsAbout => 'About';

  @override
  String get defaultForNewAlarms => 'Bawaan untuk alarm baru';

  @override
  String get preview => 'Preview';

  @override
  String atClock(String time) {
    return 'at $time';
  }

  @override
  String get connectACalendar => 'Hubungkan kalender';

  @override
  String get newFromReadyMade => 'Dari yang sudah siap';

  @override
  String get newFromReadyMadeHint => 'Matahari terbit, terbenam, dan alarm lain yang sudah disiapkan untukmu';

  @override
  String get calendarSourcesIntro =>
      'Quando? bisa berbunyi sebelum dan sesudah acara di kalendermu. Pilih dari mana asalnya.';

  @override
  String get deviceCalendarsHeading => 'DI PERANGKAT INI';

  @override
  String get deviceCalendarsTitle => 'Aplikasi kalender perangkat ini';

  @override
  String get deviceCalendarsHint =>
      'Semua akun di dalamnya: Google, Samsung, Outlook, iCloud, dan kalender yang hanya disimpan di sini.';

  @override
  String get googleCalendarHeading => 'GOOGLE KALENDER';

  @override
  String get googleCalendarSignIn =>
      'Masuk dengan Google untuk membaca kalendermu langsung dari Google, meski akun Google-mu tidak ada di perangkat ini.';

  @override
  String googleCalendarSignedIn(String email) {
    return 'Masuk sebagai $email';
  }

  @override
  String get googleCalendarSignOut => 'Keluar';

  @override
  String get googleCalendarNotHere =>
      'Masuk dengan Google belum tersedia di perangkat ini. Tambahkan akun Google di pengaturan perangkat (Kalender › Akun) dan kalendernya muncul di perangkat ini.';

  @override
  String get googleCalendarUnreachable =>
      'Google Kalender tidak bisa dijangkau sekarang. Alarm yang sudah dipasang darinya tetap berbunyi.';

  @override
  String get googleCalendarTwiceHint =>
      'Kalender dari akun Google yang sama yang sudah tampil di perangkat ini mulai dalam keadaan mati, agar tidak ada yang berbunyi dua kali.';

  @override
  String get timersTitle => 'Pengatur waktu';

  @override
  String get timerStopwatch => 'Stopwatch';

  @override
  String get timerCountdown => 'Timer';

  @override
  String get timerSequence => 'Siap';

  @override
  String get timerStopwatchSub => 'Hitung maju, dengan putaran';

  @override
  String get timerCountdownSub => 'Hitung mundur, berdering di nol';

  @override
  String get timerSequenceSub => 'Aba-aba dan penanda lisan';

  @override
  String get timerStart => 'Mulai';

  @override
  String get timerPause => 'Jeda';

  @override
  String get timerResume => 'Lanjutkan';

  @override
  String get timerReset => 'Atur ulang';

  @override
  String get timerLap => 'Putaran';

  @override
  String get timerTimesUp => 'Waktu habis';

  @override
  String get timerSetTime => 'Atur waktu';

  @override
  String get timerMinutes => 'Menit';

  @override
  String get timerSeconds => 'Detik';

  @override
  String get seqOnYourMarks => 'Pada tempat';

  @override
  String get seqGetSet => 'Siap';

  @override
  String get seqGo => 'Mulai!';

  @override
  String get seqFinish => 'Waktu!';

  @override
  String get seqReady => 'Siap';

  @override
  String get seqSettings => 'Pengaturan';

  @override
  String get seqStartCalls => 'Aba-aba sebelum mulai';

  @override
  String get seqStartCallsHelp => 'Diucapkan sebelum Mulai, dihitung mundur dari awal.';

  @override
  String seqCallBefore(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n detik sebelumnya',
      one: '1 detik sebelumnya',
    );
    return '$_temp0';
  }

  @override
  String get seqAddCall => 'Tambah aba-aba';

  @override
  String get seqCallText => 'Apa yang diucapkan';

  @override
  String get seqGoText => 'Saat mulai, ucapkan';

  @override
  String get seqFinishText => 'Saat selesai, ucapkan';

  @override
  String get seqLength => 'Durasi';

  @override
  String get seqNoLimit => 'Tanpa batas';

  @override
  String get seqSayEvery => 'Ucapkan waktu setiap';

  @override
  String get seqOff => 'Mati';

  @override
  String seqEverySeconds(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n detik', one: '1 detik');
    return '$_temp0';
  }

  @override
  String seqEveryMinutes(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n menit', one: '1 menit');
    return '$_temp0';
  }

  @override
  String get seqFinalCount => 'Hitung mundur yang terakhir';

  @override
  String get seqMarks => 'Penanda Anda';

  @override
  String get seqAddMark => 'Tambah penanda';

  @override
  String seqMarkAt(String time) {
    return 'Pada $time';
  }

  @override
  String get seqSpeak => 'Ucapkan dengan suara';

  @override
  String get seqBeeps => 'Bunyi bip dan getar';

  @override
  String get seqSayRemaining => 'Ucapkan sisa waktu, bukan waktu yang berlalu';

  @override
  String get seqPresets => 'Preset';

  @override
  String get seqPresetRace => 'Start balapan';

  @override
  String get seqPresetSprint => 'Usaha 30 dtk';

  @override
  String get seqPresetRound => 'Ronde 1 mnt';

  @override
  String get seqHintNoLimit => 'Setelah Mulai, hitung maju sampai Anda menghentikannya.';

  @override
  String get seqHintLength => 'Setelah Mulai, hitung mundur sampai nol.';

  @override
  String get seqWords => 'Kata';

  @override
  String get homeEdit => 'Arrange home';

  @override
  String get homeEditHint => 'Seret gagang untuk memindahkan kartu, melipatnya, atau mengubah ukurannya.';

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
  String get homeBlockSky => 'MATAHARI, BULAN, DAN CUACA';

  @override
  String get homeBlockQuick => 'QUICK ALARMS';

  @override
  String get homeBlockShabbat => 'SABAT DAN HARI RAYA';

  @override
  String get homePlaceTitle => 'Kota untuk langit';

  @override
  String nextAlarmLine(String title, String time) {
    return 'Alarm berikutnya · $title $time';
  }

  @override
  String get showAllAlarms => 'Tampilkan semua hari';

  @override
  String get noAlarmsThatDay => 'Tidak ada yang berbunyi hari ini';

  @override
  String get homeClockSize => 'Jam di beranda';

  @override
  String get sizeSmall => 'Kecil';

  @override
  String get sizeMedium => 'Sedang';

  @override
  String get sizeLarge => 'Besar';

  @override
  String get homeLayout => 'Tata letak beranda';

  @override
  String get homeLayoutClassic => 'Klasik';

  @override
  String get homeLayoutCards => 'Kartu';

  @override
  String get homeCardsHint =>
      'Seret kartu untuk memindahkannya. Seret tepi atau sudutnya untuk mengubah ukuran, atau pilih ukuran.';

  @override
  String get homeAddCard => 'Tambah kartu';

  @override
  String get homeOnHome => 'Di beranda';

  @override
  String get homeRemoveCard => 'Hapus';

  @override
  String get cardNext => 'Alarm berikutnya';

  @override
  String get cardClock => 'Jam dan tanggal';

  @override
  String get cardSky => 'Matahari, bulan, dan cuaca';

  @override
  String get cardMoon => 'Bulan';

  @override
  String get cardWeather => 'Cuaca';

  @override
  String get cardAlarms => 'Alarm Anda';

  @override
  String get cardQuick => 'Alarm cepat';

  @override
  String get cardTools => 'Stopwatch, hitung mundur, dan bersiap';

  @override
  String get cardWorld => 'Jam dunia';

  @override
  String get cardWeek => 'Minggu ini';

  @override
  String get cardShabbat => 'Shabbat dan hari raya';

  @override
  String get ringAtEventReminders => 'Berbunyi di pengingat acara itu sendiri';

  @override
  String get ringAtEventRemindersHint =>
      'Pengingat di aplikasi kalender Anda berbunyi di sini sebagai alarm keras, dengan suara alarm ini.';

  @override
  String get atEventReminders => 'di pengingat acara';

  @override
  String get everyEventReminderLoud => 'Berbunyi keras di pengingat setiap acara';

  @override
  String get loudNotificationsHeading => 'NOTIFIKASI KALENDER KERAS';

  @override
  String get loudNotificationsTitle => 'Buat notifikasi kalender berbunyi keras';

  @override
  String get loudNotificationsHint =>
      'Saat aplikasi kalender menampilkan pengingat, Quando? membunyikannya sebagai alarm, bahkan saat ponsel senyap.';

  @override
  String get loudNotificationsDisclosureTitle => 'Izinkan Quando? membaca notifikasi kalender?';

  @override
  String get loudNotificationsDisclosure =>
      'Untuk membunyikan pengingat kalender dengan keras, Quando? memerlukan akses notifikasi. Ia hanya melihat notifikasi dari aplikasi kalender yang Anda pilih, membaca judul dan teksnya di ponsel ini untuk ditampilkan di alarm, dan tidak pernah menyimpan atau mengirimnya ke mana pun. Anda bisa mematikannya kapan saja.';

  @override
  String get loudNotificationsAgree => 'Setuju dan lanjutkan';

  @override
  String get loudNotificationsNoAccess => 'Akses notifikasi mati. Aktifkan Quando? di daftar yang terbuka.';

  @override
  String get loudNotificationsAllow => 'Izinkan';

  @override
  String get loudNotificationsNoApps => 'Tidak ada aplikasi kalender yang didukung di ponsel ini.';

  @override
  String get loudNotificationsTwiceNote =>
      'Acara yang sudah punya alarm kalender Quando? hanya berbunyi sekali.';

  @override
  String get loudNotificationsShabbatNote => 'Senyap selama Shabbat dan hari raya.';

  @override
  String get busyMode => 'Mode sibuk';

  @override
  String get busyModeSubtitle => 'Jangan Ganggu dan balasan otomatis saat Anda sibuk';

  @override
  String get busyIntro =>
      'Saat Anda sibuk, Quando? bisa menyenyapkan ponsel dan membalas pesan untuk Anda. Alarm tetap berbunyi.';

  @override
  String get busyIosFocus =>
      'Di iPhone dan iPad, aplikasi tidak bisa menyalakan Fokus atau membalas pesan. Di app Pintasan, tambahkan otomatisasi \"Saat Quando? dibuka\" atau pada jam tertentu yang menyalakan Fokus, lalu atur Fokus untuk membalas otomatis.';

  @override
  String get busyWhileHeading => 'SAAT ANDA SIBUK';

  @override
  String get busyDnd => 'Jangan Ganggu';

  @override
  String get busyDndHint =>
      'Hanya prioritas: panggilan dan pesan senyap, alarm tetap berbunyi. Kembali normal setelahnya.';

  @override
  String get busyDndNoAccess => 'Quando? belum diizinkan mengubah Jangan Ganggu.';

  @override
  String get busyReplies => 'Balas pesan';

  @override
  String get busyRepliesHint =>
      'Sekali per orang, dengan teks Anda, lewat tombol Balas aplikasi itu. Hanya Android.';

  @override
  String get busyRepliesDisclosureTitle => 'Izinkan Quando? membalas pesan?';

  @override
  String get busyRepliesDisclosure =>
      'Untuk membalas atas nama Anda, Quando? memerlukan akses notifikasi. Hanya saat Anda sibuk, ia melihat notifikasi pesan dari aplikasi yang Anda pilih, membaca nama pengirim di ponsel ini, dan mengirim teks Anda sekali lewat tombol Balas aplikasi itu. Pesan tidak pernah disimpan atau dikirim ke tempat lain. Grup dilewati kecuali Anda mengizinkannya.';

  @override
  String get busyReplyText => 'Jawaban Anda';

  @override
  String busyReplyTextHint(String until) {
    return '$until menjadi jam berakhirnya mode sibuk.';
  }

  @override
  String busyReplyDefault(String until) {
    return 'Saya sedang sibuk, akan membalas setelah $until.';
  }

  @override
  String get busyGroups => 'Balas juga di grup';

  @override
  String get busyGroupsHint => 'Mati: grup tidak pernah dibalas.';

  @override
  String get busyRepliesOnShabbat => 'Balas juga saat Shabbat dan hari raya';

  @override
  String get busyAskRabbi => 'Mati secara bawaan. Tanya rabi Anda sebelum menyalakannya untuk Shabbat.';

  @override
  String get busyWhenHeading => 'KAPAN ANDA SIBUK';

  @override
  String get busyWhenHint =>
      'Nyalakan \"Sibuk selama acara ini\" pada alarm kalender, atau \"Sibuk setelah berbunyi\" pada alarm.';

  @override
  String get busyDuringLock => 'Sibuk saat mode kunci menyala';

  @override
  String get busyNoneComing => 'Tidak ada waktu sibuk dalam 7 hari ke depan.';

  @override
  String get busyDuringEvents => 'Sibuk selama acara ini';

  @override
  String get busyDuringEventsHint => 'Mode sibuk dari awal hingga akhir setiap acara.';

  @override
  String get busySettings => 'Pengaturan mode sibuk';

  @override
  String get busyAfterRing => 'Sibuk setelah berbunyi';

  @override
  String get busyAfterRingHint =>
      'Jangan Ganggu dan balasan otomatis sebentar, mis. olahraga atau tidur siang.';

  @override
  String get shareCard => 'Bagikan pagimu';

  @override
  String get shareCardSubtitle => 'Langit dan kutipan hari ini, atau fotomu, untuk Stories dan status';

  @override
  String get shareAppMissing => 'Aplikasi itu tidak ada di ponsel ini.';

  @override
  String get shareAsIs => 'Bagikan apa adanya';

  @override
  String get shareTapQuote => 'Ketuk kutipan untuk menggantinya.';

  @override
  String get shareStory => 'Story';

  @override
  String get shareSquare => 'Persegi';

  @override
  String get shareYourWords => 'Kata-katamu sendiri (opsional)';

  @override
  String get shareYourWordsHint => 'Sebagai ganti kutipan hari ini';

  @override
  String get shareYourPhoto => 'Fotomu';

  @override
  String get shareOtherPhoto => 'Foto lain';

  @override
  String get shareSkyBack => 'Langit hari ini saja';

  @override
  String get shareYourVideo => 'Videomu';

  @override
  String get shareInstagramStory => 'Instagram Stories';

  @override
  String get shareWhatsApp => 'WhatsApp: status atau chat';

  @override
  String get shareMore => 'Aplikasi lain';

  @override
  String get shareYouPost =>
      'Quando? membuka aplikasi dengan kartumu siap. Kamu yang memilih tujuan dan mengetuk Posting.';

  @override
  String get shareAndroidFirst => 'Berbagi segera hadir di iPhone dan iPad.';

  @override
  String songSaved(String name) {
    return '“$name” disimpan sebagai suara alarm';
  }

  @override
  String get shareToQuando => 'Bagikan lagu ke Quando?';

  @override
  String get shareToQuandoHint =>
      'Di YouTube, YouTube Music, Spotify, SoundCloud, atau Apple Music, ketuk Bagikan lalu Quando?. Lagu jadi suara alarm yang diputar di aplikasinya.';

  @override
  String get askOption => 'Ucapkan atau ketik';

  @override
  String get askOptionHint => '“Besok jam 6”, “30 menit sebelum matahari terbit”';

  @override
  String get askHint => 'mis.: bangunkan aku 30 menit sebelum matahari terbit di hari kerja';

  @override
  String get askListening => 'Mendengarkan…';

  @override
  String get askNotUnderstood =>
      'Saya tidak menemukan waktu. Coba “jam 7 di hari kerja” atau “dalam 20 menit”.';

  @override
  String askAnswerFromCalendar(String name) {
    return 'Dari kalendermu “$name”';
  }

  @override
  String get askAnswerBuiltIn => 'Waktu Quando? untuk kotamu';

  @override
  String get askNoAnswer => 'Belum ada waktu untuk itu.';

  @override
  String get askNoSpeech => 'Suara tidak tersedia di perangkat ini. Anda bisa mengetik.';

  @override
  String get askShabbatOff => 'Aktifkan Sabat di Pengaturan agar waktu Sabat berbunyi.';

  @override
  String askSaved(String what) {
    return 'Tersimpan: $what';
  }

  @override
  String get askMic => 'Bicara';

  @override
  String get askMorning => 'Pagi';

  @override
  String get askEvening => 'Malam';

  @override
  String get askUnsure => 'Mungkin ada yang terlewat. Periksa sebelum menyimpan.';

  @override
  String get askTeach => 'Ajari aku ini';

  @override
  String askTaught(String phrase, String time) {
    return 'Mengerti: “$phrase” sekarang berarti $time.';
  }

  @override
  String get askSkipAction => 'Lewati';

  @override
  String get askNoMatch => 'Tidak ada alarm yang cocok.';

  @override
  String askTurnedOff(String what) {
    return 'Dimatikan: $what';
  }

  @override
  String askSkipped(String what) {
    return 'Dilewati: $what';
  }

  @override
  String askEventPlan(String offset, String event) {
    return '$offset “$event” di kalender Anda';
  }

  @override
  String askEventNoCalendar(String event) {
    return 'Hubungkan kalender agar Quando? bisa menemukan “$event”.';
  }

  @override
  String askSnoozeAll(int minutes) {
    return 'Tunda: $minutes mnt, untuk semua alarm';
  }

  @override
  String askWakeWith(String sound) {
    return 'Membangunkan Anda dengan $sound';
  }

  @override
  String get askReadAs => 'Dibaca sebagai';

  @override
  String get syncHeading => 'Saat kalender berubah';

  @override
  String get syncLive => 'Ikuti kalender';

  @override
  String get syncLiveHint =>
      'Acara baru dapat alarm. Acara yang dipindah ikut memindah alarmnya. Acara yang dihapus kehilangan alarmnya.';

  @override
  String get syncKeepFirst => 'Simpan seperti yang pertama kulihat';

  @override
  String get syncKeepFirstHint =>
      'Acara baru tetap dapat alarm. Setelah dipasang, alarm tetap di tempatnya, walau acaranya dipindah atau dihapus.';

  @override
  String get syncSnapshot => 'Hanya acara yang ada sekarang';

  @override
  String get syncSnapshotHint =>
      'Hanya acara di kalendermu saat kamu menyimpan, seperti apa adanya sekarang. Tidak ada yang baru ditambahkan nanti.';

  @override
  String get syncHelpButton => 'Cara kerjanya';

  @override
  String get syncHelpTitle => 'Cara alarm mengikuti kalendermu';

  @override
  String get syncHelpIntro =>
      'Aturan ini terus mencari acara yang cocok dengan pencarianmu. Kamu yang memilih apa yang terjadi saat kalendermu berubah.';

  @override
  String get syncHelpExampleLive =>
      'Contoh: aturan untuk “dokter gigi”. Dokter gigi memindah janji dari Selasa ke Rabu, dan alarmmu ikut pindah ke Rabu. Kalau janjinya batal, alarmnya hilang.';

  @override
  String get syncHelpExampleKeepFirst =>
      'Aturan yang sama: janji pindah ke Rabu, tapi alarmmu tetap di Selasa, seperti yang pertama dilihat Quando?. Janji baru bulan depan tetap dapat alarm sendiri.';

  @override
  String get syncHelpExampleSnapshot =>
      'Aturan yang sama: kamu dapat alarm untuk janji yang ada di kalender hari ini, dan tetap seperti itu. Janji yang ditambahkan bulan depan tidak dapat alarm.';

  @override
  String get syncHelpTip => 'Ragu? Biarkan “Ikuti kalender”.';

  @override
  String get syncHelpWhenTitle => 'Kapan Quando? melihat perubahan?';

  @override
  String get syncHelpWhenOpen =>
      'Saat Quando? terbuka: dalam hitungan detik. Google Kalender yang tersambung di sini dicek tiap 2 menit.';

  @override
  String get syncHelpWhenClosed =>
      'Saat Quando? tertutup: saat kamu membukanya lagi. Sampai saat itu, alarm yang sudah dipasang berbunyi di waktu lamanya.';

  @override
  String get syncHelpWhenClosedApple =>
      'iPhone dan iPad tidak mengizinkan aplikasi memantau kalender di latar belakang, jadi perubahan masuk saat Quando? dibuka.';

  @override
  String get tapMiddleToStop => 'Ketuk bagian tengah untuk berhenti';

  @override
  String get quickSetups => 'Pengaturan cepat';

  @override
  String get qsMorningTitle => 'Pagi yang berhasil';

  @override
  String get qsStartTitle => 'Jangan lewatkan awal';

  @override
  String get qsStretchTitle => 'Bekerja per sesi';

  @override
  String get qsWillChange => 'Yang akan berubah';

  @override
  String get qsAlreadyOn => 'Sudah aktif. Tidak ada yang diubah.';

  @override
  String get qsApply => 'Terapkan';

  @override
  String get qsDone => 'Selesai';

  @override
  String get qsUndo => 'Urungkan';

  @override
  String get qsSnoozeTimes => 'Tunda yang diizinkan';

  @override
  String get qsSnoozeMinutes => 'Menit tunda';

  @override
  String get qsFiveLeft => 'Sisa 5 menit';
}
