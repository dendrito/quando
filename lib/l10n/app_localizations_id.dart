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
  String get calendarAlarm => 'Alarm kalender';

  @override
  String get calendarIntro =>
      'Quando? bisa berbunyi sebelum dan sesudah acara di kalender ponselmu. Google Kalender ikut setelah akun Google-mu ada di ponsel.';

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
      'Di Spotify, Apple Music, Amazon Music, YouTube, YouTube Music, atau SoundCloud, ketuk Bagikan, lalu Salin tautan, dan tempel di sini.';

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
  String get youTubeOn => 'Playlist dan lagu yang kamu sukai. Tekan lama untuk keluar.';

  @override
  String get youTubeSignIn => 'Masuk dengan Google untuk memilih dari playlist dan lagu yang kamu sukai.';

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
  String get spotifyDirectOnHint => 'Spotify memutar lagumu persis sebagai alarm. Ketuk untuk mematikan.';

  @override
  String get spotifyDirectHint =>
      'Memutar lagu Spotify-mu persis sebagai alarm, lebih andal. Perlu aplikasi Spotify dan Spotify Premium. Ketuk untuk masuk.';

  @override
  String get spotifyComingSoon =>
      'Segera hadir: putar lagu Spotify-mu persis sebagai alarm (perlu Spotify Premium).';

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
      'Rekam suaramu, lagu, atau apa pun, hingga 5 menit. Tambahkan MP3, M4A, atau WAV dari ponselmu. Tautkan lagu atau playlist: aplikasinya memutarnya sebagai alarm, dengan suara cadangan. Atau pilih stasiun radio: diputar langsung, dan jika tidak terhubung, alarm ponsel berbunyi.';

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
