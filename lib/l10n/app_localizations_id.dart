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
      one: '1 detik sebelumnya',
      other: '$n detik sebelumnya',
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
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, one: '1 detik', other: '$n detik');
    return '$_temp0';
  }

  @override
  String seqEveryMinutes(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, one: '1 menit', other: '$n menit');
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
  String get homeEditHint => 'Drag the handle to move a card, fold it, or change its size.';

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
}
