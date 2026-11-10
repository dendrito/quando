// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Polish (`pl`).
class AppLocalizationsPl extends AppLocalizations {
  AppLocalizationsPl([String locale = 'pl']) : super(locale);

  @override
  String get undo => 'Cofnij';

  @override
  String duplicatedNamed(String name) {
    return 'Zduplikowano „$name”';
  }

  @override
  String deletedNamed(String name) {
    return 'Usunięto „$name”';
  }

  @override
  String get when => 'Kiedy?';

  @override
  String get newAtTime => 'O określonej godzinie';

  @override
  String get newAtTimeHint => 'W każdy dzień roboczy o 7:00, raz o 15:30…';

  @override
  String get newAroundEvent => 'Wokół wydarzenia';

  @override
  String get newAroundEventHint =>
      'Szukaj w kalendarzach, czasach szabatu i słońca, a potem dzwoń przed, w trakcie lub po';

  @override
  String get editThisAlarm => 'Edytuj ten alarm';

  @override
  String editNamed(String name) {
    return 'Edytuj „$name”';
  }

  @override
  String get preset => 'szablon';

  @override
  String get editThisCalendarRule => 'Edytuj tę regułę kalendarza';

  @override
  String get ringThisOneAfterAll => 'Jednak zadzwoń';

  @override
  String get skipJustThisOne => 'Pomiń tylko ten';

  @override
  String get renameGroup => 'Zmień nazwę grupy';

  @override
  String quickSet(String label, String time) {
    return '$label · dzwoni o $time';
  }

  @override
  String get newAlarm => 'Nowy alarm';

  @override
  String get appName => 'Quando?';

  @override
  String get lockMode => 'Tryb blokady';

  @override
  String get calendars => 'Kalendarze';

  @override
  String get settings => 'Ustawienia';

  @override
  String get nextAlarmHeading => 'NASTĘPNY ALARM';

  @override
  String get nothingSet => 'Nic nie ustawiono';

  @override
  String get tagline => 'Wszystko w swoim czasie.';

  @override
  String sunriseAt(String time) {
    return 'Wschód $time';
  }

  @override
  String sunsetAt(String time) {
    return 'Zachód $time';
  }

  @override
  String get alarmsMayNotRing => 'Twoje alarmy mogą nie zadzwonić';

  @override
  String get tapToFixIt => 'Dotknij, aby naprawić';

  @override
  String inMinutes(int minutes) {
    return 'Za $minutes min';
  }

  @override
  String get atSunset => 'O zachodzie słońca';

  @override
  String get sunset => 'Zachód słońca';

  @override
  String get shabbatModeIsOn => 'TRYB SZABATOWY WŁĄCZONY';

  @override
  String nextInCity(String city) {
    return 'NASTĘPNY · $city';
  }

  @override
  String get candleLighting => 'Zapalanie świec';

  @override
  String get havdalah => 'Hawdala';

  @override
  String get shabbatAndFestivals => 'Szabat i święta';

  @override
  String get yourAlarmsHeading => 'TWOJE ALARMY';

  @override
  String get tapWhenToAdd => 'Dotknij Kiedy?, aby dodać alarm.';

  @override
  String get aroundEventsHeading => 'WOKÓŁ WYDARZEŃ';

  @override
  String searchFor(String words) {
    return 'szukaj: $words';
  }

  @override
  String get thisWeekHeading => 'ALARMY W TYM TYGODNIU';

  @override
  String get noAlarmsThisWeek => 'Brak alarmów w ciągu najbliższych 7 dni.';

  @override
  String get alarmsSetThemselves => 'Alarmy ustawiają się same na tym telefonie przy każdej zmianie.';

  @override
  String cityTime(String city) {
    return 'czas w $city';
  }

  @override
  String get more => 'Więcej';

  @override
  String get turnOff => 'Wyłącz';

  @override
  String get turnOn => 'Włącz';

  @override
  String get duplicate => 'Duplikuj';

  @override
  String get delete => 'Usuń';

  @override
  String get inOneHour => 'Za 1 godzinę';

  @override
  String get logoLabel => 'Logo Quando?';

  @override
  String get noTimesSet => 'Brak ustawionych godzin';

  @override
  String get atTheMoment => 'w tej chwili';

  @override
  String timesRange(int count, String from, String to) {
    return '$count razy · od $from do $to';
  }

  @override
  String spanDays(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n dnia',
      many: '$n dni',
      few: '$n dni',
      one: '1 dzień',
    );
    return '$_temp0';
  }

  @override
  String spanHours(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n godziny',
      many: '$n godzin',
      few: '$n godziny',
      one: '1 godzina',
    );
    return '$_temp0';
  }

  @override
  String spanMinutes(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n minuty',
      many: '$n minut',
      few: '$n minuty',
      one: '1 minuta',
    );
    return '$_temp0';
  }

  @override
  String spanSeconds(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n sekundy',
      many: '$n sekund',
      few: '$n sekundy',
      one: '1 sekunda',
    );
    return '$_temp0';
  }

  @override
  String get now => 'teraz';

  @override
  String spanBefore(String span) {
    return '$span przed';
  }

  @override
  String spanAfter(String span) {
    return '$span po';
  }

  @override
  String alarmCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n alarmu',
      many: '$n alarmów',
      few: '$n alarmy',
      one: '1 alarm',
    );
    return '$_temp0';
  }

  @override
  String get allOn => 'wszystkie włączone';

  @override
  String get allOff => 'wszystkie wyłączone';

  @override
  String someOn(int n) {
    return 'włączone: $n';
  }

  @override
  String skippedBody(String body) {
    return 'Pominięty · $body';
  }

  @override
  String timeToTime(String from, String to) {
    return '$from – $to';
  }

  @override
  String skippedCount(int n) {
    return 'pominięte: $n';
  }

  @override
  String get sunNoRiseSet => 'Słońce dziś tu nie wschodzi ani nie zachodzi';

  @override
  String sunProgress(int percent) {
    return 'Słońce przeszło $percent% dnia';
  }

  @override
  String get sunIsDown => 'Słońce zaszło';

  @override
  String get searchCity => 'Szukaj miasta';

  @override
  String get tomorrowLower => 'jutro';

  @override
  String get yesterdayLower => 'wczoraj';

  @override
  String get worldClocksHeading => 'ZEGARY ŚWIATOWE';

  @override
  String get add => 'Dodaj';

  @override
  String cityHere(String city) {
    return '$city · tutaj';
  }

  @override
  String get worldClocksHint => 'Dodaj miasta, aby widzieć tu ich czas. Przesuń w lewo, aby usunąć.';

  @override
  String get groupNameHint => 'Praca, Dzieci, Siłownia…';

  @override
  String get cancel => 'Anuluj';

  @override
  String get ok => 'OK';

  @override
  String get noGroup => 'Bez grupy';

  @override
  String get newGroupEllipsis => 'Nowa grupa…';

  @override
  String get newGroup => 'Nowa grupa';

  @override
  String secondsShort(int n) {
    return '$n s';
  }

  @override
  String minutesShort(int n) {
    return '$n min';
  }

  @override
  String get minutes => 'Minuty';

  @override
  String get ringFor => 'Dzwoń przez';

  @override
  String get seconds => 'Sekundy';

  @override
  String get oneSecondLess => '1 sekunda mniej';

  @override
  String get oneSecondMore => '1 sekunda więcej';

  @override
  String inDays(int d) {
    return 'za $d d';
  }

  @override
  String inDaysHours(int d, int h) {
    return 'za $d d $h godz.';
  }

  @override
  String inHours(int h) {
    return 'za $h godz.';
  }

  @override
  String inHoursMinutes(int h, int m) {
    return 'za $h godz. $m min';
  }

  @override
  String inMins(int m) {
    return 'za $m min';
  }

  @override
  String placeChange(String city, String where) {
    return '$city · $where · zmień';
  }

  @override
  String get israel => 'Izrael';

  @override
  String get outsideIsrael => 'poza Izraelem';

  @override
  String get comingUpHeading => 'WKRÓTCE';

  @override
  String get lockForShabbat => 'Zablokuj telefon na szabat';

  @override
  String get lockForShabbatHint => 'Od zapalenia świec do hawdali, także w święta';

  @override
  String get ownShabbatAlarmsHeading => 'TWOJE ALARMY SZABATOWE';

  @override
  String get addShabbatAlarm => 'Dodaj alarm na szabat lub święto';

  @override
  String get readyMadeHeading => 'GOTOWE ALARMY';

  @override
  String bringBackDeleted(int n) {
    return 'Przywróć usunięte ($n)';
  }

  @override
  String get presetsHint => 'Dotknij alarmu, aby zmienić godziny. Przesuń, aby usunąć.';

  @override
  String get lockSentence => 'Ogranicz telefon do zegara i alarmów, na szabat lub skupioną noc.';

  @override
  String get lockExplain =>
      'Podczas blokady Quando? pokazuje tylko godzinę, następny alarm i koniec blokady. Alarmy działają dalej, a nic nie da się zmienić do odblokowania.';

  @override
  String get lockNowHeading => 'ZABLOKUJ TERAZ';

  @override
  String get lockAutoHeading => 'BLOKUJ AUTOMATYCZNIE';

  @override
  String get shabbatAndFestivalsLong => 'Szabat i święta';

  @override
  String get fromCandleToHavdalah => 'Od zapalenia świec do hawdali';

  @override
  String get lockCalendarWord => 'Podczas wydarzeń z tym słowem';

  @override
  String get lockCalendarWordHint => 'np. blokada, egzamin, skupienie';

  @override
  String get leaveEmptyForNone => 'Zostaw puste, aby wyłączyć';

  @override
  String get connectCalendarsFirst => 'Najpierw połącz kalendarze (ikona kalendarza)';

  @override
  String get openWhenLockStarts => 'Otwórz Quando?, gdy zaczyna się blokada';

  @override
  String get openWhenLockStartsHint =>
      'Cichy dźwięk trwający 1 sekundę wyciąga Quando? na wierzch, aby zablokować';

  @override
  String get pinToScreen => 'Przypnij Quando? do ekranu';

  @override
  String get pinToScreenHint =>
      'Inne aplikacje nie otworzą się podczas blokady. Android za pierwszym razem prosi o potwierdzenie.';

  @override
  String get noLocksComingUp => 'Brak nadchodzących blokad.';

  @override
  String get leaveLockEarly =>
      'Aby wyjść wcześniej, przytrzymaj „Przytrzymaj, aby odblokować” przez 3 sekundy.';

  @override
  String get locked => 'Zablokowane';

  @override
  String get shabbatShalom => 'Szabat szalom';

  @override
  String get chagSameach => 'Chag sameach';

  @override
  String get unlocksHeading => 'ODBLOKOWANIE';

  @override
  String get nowCap => 'Teraz';

  @override
  String get nextAlarm => 'Następny alarm';

  @override
  String get holdToUnlock => 'Przytrzymaj, aby odblokować';

  @override
  String get calendarAlarm => 'Alarm z kalendarza';

  @override
  String get connectCalendars => 'Połącz kalendarze';

  @override
  String get calendarAlarmsHeading => 'ALARMY Z KALENDARZA';

  @override
  String get calendarNoneYet => 'Jeszcze brak. Zacznij od tego i zmień jak chcesz:';

  @override
  String get fifteenBeforeEvery => '15 minut przed każdym wydarzeniem';

  @override
  String get useTheseCalendarsHeading => 'UŻYJ TYCH KALENDARZY';

  @override
  String get noTimedEvents => 'Brak nadchodzących wydarzeń z godziną w tych kalendarzach.';

  @override
  String get atTheStart => 'na początku';

  @override
  String everyForBefore(String every, String span) {
    return 'co $every przez $span przed';
  }

  @override
  String spanAfterItEnds(String span) {
    return '$span po zakończeniu';
  }

  @override
  String get noAlarmsChosen => 'Nie wybrano alarmów';

  @override
  String get gentleWakeUp => 'Łagodne budzenie';

  @override
  String gentleSummary(int minutes, String sound) {
    return '$minutes min wcześniej · $sound';
  }

  @override
  String get off => 'Wył.';

  @override
  String get gentleSentence =>
      'Spokojny dźwięk zaczyna cicho grać przed alarmem, więc nigdy nie budzisz się gwałtownie.';

  @override
  String get gentleExplain => 'Narasta powoli, wyciąga Cię z płytkiego snu i milknie tuż przed alarmem.';

  @override
  String get startsBeforeHeading => 'ZACZYNA SIĘ PRZED ALARMEM';

  @override
  String get leadUpSoundHeading => 'DŹWIĘK WSTĘPNY';

  @override
  String get listen => 'Posłuchaj';

  @override
  String get whoRecordedThese => 'Kto nagrał te dźwięki';

  @override
  String get done => 'Gotowe';

  @override
  String get soundCredits => 'Autorzy dźwięków';

  @override
  String yourTimeCity(String city) {
    return 'Twój czas ($city)';
  }

  @override
  String get anotherCity => 'Inne miasto…';

  @override
  String get ringingIn5 => 'Zadzwoni za 5 sekund…';

  @override
  String get alarmSaved => 'Alarm zapisany.';

  @override
  String alarmSetFor(String span) {
    return 'Alarm za $span.';
  }

  @override
  String hoursMinutesShort(int h, int m) {
    return '$h godz. $m min';
  }

  @override
  String get editAlarm => 'Edytuj alarm';

  @override
  String get previewCaps => 'PODGLĄD';

  @override
  String get saveCaps => 'ZAPISZ';

  @override
  String cityTimeForYou(String city, String time) {
    return 'czas w $city · u Ciebie $time';
  }

  @override
  String repeatHeading(String repeat) {
    return 'POWTARZAJ · $repeat';
  }

  @override
  String get labelField => 'Etykieta (czytana na głos, gdy alarmy mówione są włączone)';

  @override
  String get group => 'Grupa';

  @override
  String ringsForHeading(String span) {
    return 'DZWONI PRZEZ $span';
  }

  @override
  String useDefault(String value) {
    return 'Użyj domyślnego ($value)';
  }

  @override
  String get save => 'Zapisz';

  @override
  String get sameTime => 'ta sama godzina';

  @override
  String get untilYouStopIt => 'Aż go zatrzymasz';

  @override
  String get alarm => 'Alarm';

  @override
  String get once => 'Raz';

  @override
  String get everyDay => 'Codziennie';

  @override
  String get weekdays => 'Dni robocze';

  @override
  String get weekends => 'Weekendy';

  @override
  String timeInCity(String time, String city) {
    return '$time czasu $city';
  }

  @override
  String eventsMatching(String words) {
    return 'Wydarzenia z „$words”';
  }

  @override
  String get everyEvent => 'Każde wydarzenie';

  @override
  String get sunrise => 'Wschód słońca';

  @override
  String havdalahEndOf(String day) {
    return 'Hawdala · koniec $day';
  }

  @override
  String get yomTov => 'Jom tow';

  @override
  String get shabbat => 'Szabat';

  @override
  String get presetCountdown => 'Odliczanie do zapalenia świec';

  @override
  String get presetHourly => 'Co godzinę, od 6 godzin wcześniej';

  @override
  String get presetDailyWeek => 'Raz dziennie, w tygodniu przed';

  @override
  String get presetSecondNight => 'Świece drugiego wieczoru';

  @override
  String get presetFridayReminder => 'Przypomnienie 3 godziny wcześniej: naładuj telefon';

  @override
  String get presetFridayReminderLabel => 'Naładuj telefon i ustaw alarmy na jutro';

  @override
  String get presetSunset => 'Zachód słońca i 15 minut wcześniej';

  @override
  String get pesach => 'Pesach';

  @override
  String get shavuot => 'Szawuot';

  @override
  String get roshHashanah => 'Rosz ha-Szana';

  @override
  String get yomKippur => 'Jom Kipur';

  @override
  String get sukkot => 'Sukot';

  @override
  String get sheminiAtzeret => 'Szemini Aceret';

  @override
  String get simchatTorah => 'Simchat Tora';

  @override
  String get readyNotifications => 'Pokazuj alarmy';

  @override
  String get readyNotificationsWhy => 'Pozwala wyświetlić ekran alarmu i przycisk Stop.';

  @override
  String get readyFullScreen => 'Dzwoń na ekranie blokady';

  @override
  String get readyFullScreenWhy => 'Pokazuje alarm na pełnym ekranie, nawet gdy telefon jest zablokowany.';

  @override
  String get readyExact => 'Dzwoń co do minuty';

  @override
  String get readyExactWhy => 'Bez tego telefon może opóźnić alarmy o kilka minut.';

  @override
  String get readyBattery => 'Działaj przy oszczędzaniu baterii';

  @override
  String get readyBatteryWhy => 'Zapobiega wyciszaniu alarmów w nocy przez oszczędzanie baterii.';

  @override
  String get tipXiaomi =>
      'Telefony Xiaomi: w Ustawienia › Aplikacje › Quando? włącz Autostart i ustaw Oszczędzanie baterii na Bez ograniczeń.';

  @override
  String get tipSamsung =>
      'Telefony Samsung: w Ustawienia › Bateria › Limity użycia w tle upewnij się, że Quando? nie jest uśpione.';

  @override
  String get tipHuawei =>
      'Telefony Huawei i Honor: w Ustawienia › Bateria › Uruchamianie aplikacji ustaw Quando? na Zarządzaj ręcznie i zezwól na wszystko.';

  @override
  String get tipOther =>
      'Na tym telefonie: w Ustawienia › Bateria pozwól Quando? działać w tle i wyłącz optymalizację.';

  @override
  String get testRing => 'Testowy dzwonek';

  @override
  String get testRingBody => 'Quando? może Cię obudzić';

  @override
  String get ringsIn20 => 'Zadzwoni za 20 sekund. Zablokuj teraz telefon i czekaj.';

  @override
  String get readyToRing => 'Gotowy do dzwonienia';

  @override
  String get checkingPhone => 'Sprawdzanie telefonu…';

  @override
  String get phoneReady => 'Twój telefon jest gotowy, by każdy alarm zadzwonił na czas.';

  @override
  String thingsNeedFixing(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n rzeczy wymaga naprawy, inaczej alarmy mogą nie zadzwonić.',
      many: '$n rzeczy wymaga naprawy, inaczej alarmy mogą nie zadzwonić.',
      few: '$n rzeczy wymagają naprawy, inaczej alarmy mogą nie zadzwonić.',
      one: '1 rzecz wymaga naprawy, inaczej alarmy mogą nie zadzwonić.',
    );
    return '$_temp0';
  }

  @override
  String get fix => 'Napraw';

  @override
  String get testIn20 => 'Test: dzwoni za 20 sekund';

  @override
  String get testIn20Hint =>
      'Zablokuj telefon i odłóż go. Jeśli alarm zadzwoni na pełnym ekranie, wszystko gotowe.';

  @override
  String get readyToRingHint => 'Sprawdź, czy telefon dzwoni każdym alarmem na czas';

  @override
  String get connections => 'Połączenia';

  @override
  String get timeZoneHeading => 'STREFA CZASOWA';

  @override
  String get followPhone => 'Jak w telefonie';

  @override
  String followPhoneNow(String city) {
    return 'Teraz $city. Zmienia się sama w podróży.';
  }

  @override
  String get zoneFixed => 'Stała. Alarmy trzymają tę godzinę także w podróży.';

  @override
  String get shabbatCityHeading => 'MIASTO DLA SZABATU';

  @override
  String get inIsraelOneDay => 'W Izraelu (jeden dzień święta)';

  @override
  String candleMinutesHeading(int n) {
    return 'ŚWIECE: $n MINUT PRZED ZACHODEM';
  }

  @override
  String get endOfShabbatHeading => 'KONIEC SZABATU I ŚWIĄT';

  @override
  String get nightfallGeonim => 'Zmrok (Geonim, 8,5°)';

  @override
  String get rabbeinuTam => '72 minuty po zachodzie (Rabejnu Tam)';

  @override
  String get whenAlarmRingsHeading => 'GDY ALARM DZWONI';

  @override
  String get recordOrAddSounds => 'Nagraj lub dodaj dźwięki';

  @override
  String get ringsForThisLong => 'Dzwoni tak długo, potem sam się wyłącza';

  @override
  String get sameFades => 'Te same wyciszenia dla wszystkich alarmów';

  @override
  String get sameFadesOn => 'Zastępuje wyciszenia każdego alarmu. Każdy zachowuje swoją głośność.';

  @override
  String get sameFadesOff => 'Wył.: każdy alarm używa wyciszeń ustawionych w swojej Głośności.';

  @override
  String get sayItOutLoud => 'Powiedz na głos';

  @override
  String get sayItOutLoudHint => 'Czyta, do czego jest alarm, np. „Zapalanie świec, 15 minut wcześniej”';

  @override
  String get noSnooze => 'Bez drzemki';

  @override
  String snoozeUpTo(int times, int minutes) {
    return 'Drzemka do $times× po $minutes min';
  }

  @override
  String get wakeUpCheck => 'Kontrola pobudki';

  @override
  String get wakeUpCheckHint => 'Po zatrzymaniu dzwoni znów za 3 minuty, jeśli nie dotkniesz „Wstałem”';

  @override
  String get solveSum => 'Rozwiąż działanie, aby zatrzymać';

  @override
  String get provesAwake => 'Dowodzi, że nie śpisz';

  @override
  String get shabbatNoTasks =>
      'W szabat i święta nic z tego nie obowiązuje: alarmy same się wyłączają i nigdy nie wymagają dotykania telefonu.';

  @override
  String get testAlarmIn1 => 'Testowy alarm za 1 minutę';

  @override
  String get timesDisclaimer =>
      'Godziny są liczone na telefonie. W wątpliwych przypadkach zapytaj rabina lub sprawdź kalendarz gminy.';

  @override
  String get recommended => 'Zalecane';

  @override
  String get chooseCity => 'Wybierz miasto';

  @override
  String get testOnlyOnPhone => 'Testowe alarmy działają tylko na telefonie.';

  @override
  String get testAlarm => 'Testowy alarm';

  @override
  String get testAlarmBody => 'Tak będą brzmieć Twoje alarmy';

  @override
  String get testAlarmIn1Set => 'Testowy alarm za 1 minutę. Możesz zablokować telefon.';

  @override
  String get presetGone => 'Ten szablon już nie istnieje.';

  @override
  String get editPreset => 'Edytuj szablon';

  @override
  String get on => 'Wł.';

  @override
  String get ringsHeading => 'DZWONI';

  @override
  String get noTimesYet => 'Brak godzin. Dodaj poniżej.';

  @override
  String get atTheMomentItself => 'Dokładnie w tej chwili';

  @override
  String get remove => 'Usuń';

  @override
  String get addATime => 'Dodaj godzinę';

  @override
  String get resetPreset => 'Przywróć oryginał';

  @override
  String get skipOneHint =>
      'Aby pominąć jeden alarm, dotknij go w „Alarmy w tym tygodniu” na ekranie głównym.';

  @override
  String get unitMinutes => 'minuty';

  @override
  String get unitHours => 'godziny';

  @override
  String get unitDays => 'dni';

  @override
  String get before => 'Przed';

  @override
  String get after => 'Po';

  @override
  String get oneWeek => '1 tydzień';

  @override
  String daysShort(int n) {
    return '$n d';
  }

  @override
  String hoursShort(int n) {
    return '$n godz.';
  }

  @override
  String get howToSearch => 'Jak szukać';

  @override
  String get searchHelpWord => 'Tytuł zawiera „dentist”, bez względu na wielkość liter';

  @override
  String get searchHelpStar => '* oznacza dowolne litery: dentist, dentures';

  @override
  String get searchHelpQuestion => '? oznacza jedną literę: yoga, toga';

  @override
  String get searchHelpPhrase => 'Dokładnie ta fraza';

  @override
  String get searchHelpAnd => 'Oba słowa (AND)';

  @override
  String get searchHelpOr => 'Którekolwiek. Działa też |';

  @override
  String get searchHelpNot => 'Wyklucz. Działają też NOT i !';

  @override
  String get searchHelpBrackets => 'Nawiasy grupują słowa';

  @override
  String get searchHelpEmpty => 'Zostaw puste, aby dzwonić przy każdym wydarzeniu.';

  @override
  String get customTime => 'Inny czas';

  @override
  String get other => 'Inne';

  @override
  String get sun => 'Słońce';

  @override
  String get calendar => 'Kalendarz';

  @override
  String get newEventAlarm => 'Nowy alarm wydarzenia';

  @override
  String get eventAlarm => 'Alarm wydarzenia';

  @override
  String get findEventsHeading => 'ZNAJDŹ WYDARZENIA';

  @override
  String get searchEventsHint => 'Szukaj: dentysta, siłownia OR joga, dent*…';

  @override
  String get alsoBuiltInTimes => 'Także czasy szabatu, świąt i słońca';

  @override
  String get alsoBuiltInTimesHint => 'np. „świec*”, „hawdala”, „zachód”';

  @override
  String get allMyCalendars => 'Wszystkie moje kalendarze';

  @override
  String get connectToSearch => 'Połącz kalendarze, aby w nich szukać';

  @override
  String get searching => 'Szukanie…';

  @override
  String get nothingMatches60 => 'Nic nie pasuje w ciągu 60 dni';

  @override
  String eventsIn60(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n wydarzenia w ciągu 60 dni',
      many: '$n wydarzeń w ciągu 60 dni',
      few: '$n wydarzenia w ciągu 60 dni',
      one: '1 wydarzenie w ciągu 60 dni',
    );
    return '$_temp0';
  }

  @override
  String nextRingsAt(String times, String title) {
    return 'Następny: dzwoni o $times dla „$title”';
  }

  @override
  String showMoreLeft(int n) {
    return 'Pokaż więcej (zostało $n)';
  }

  @override
  String get ringBeforeStartsHeading => 'DZWOŃ PRZED POCZĄTKIEM';

  @override
  String get ringWhenStarts => 'Dzwoń, gdy się zacznie';

  @override
  String get repeatBeforeHeading => 'I POWTARZAJ PRZED';

  @override
  String get everyPrefix => 'Co ';

  @override
  String get offLower => 'wył.';

  @override
  String get forInfix => '  przez ';

  @override
  String get ringAfterEndsHeading => 'DZWOŃ PO ZAKOŃCZENIU';

  @override
  String get nameOptional => 'Nazwa (opcjonalnie)';

  @override
  String get toppedUp => 'Alarmy są ustawione na 7 dni i uzupełniane przy każdym otwarciu Quando?.';

  @override
  String get back => 'Wstecz';

  @override
  String get next => 'Dalej';

  @override
  String get stepWhichEvents => 'Które wydarzenia';

  @override
  String get stepWhenToRing => 'Kiedy dzwonić';

  @override
  String get stepHowItRings => 'Jak dzwoni';

  @override
  String defaultNamed(String name) {
    return 'Domyślny ($name)';
  }

  @override
  String get phoneAlarmSound => 'Dźwięk alarmu telefonu';

  @override
  String get onlineRadio => 'Radio internetowe';

  @override
  String songLinkOpens(String app) {
    return 'Link do utworu · otwiera $app';
  }

  @override
  String get builtIn => 'Wbudowany';

  @override
  String get yourRecording => 'Twoje nagranie';

  @override
  String get sound => 'Dźwięk';

  @override
  String get wakeToOwnSound => 'Budź się przy własnym dźwięku';

  @override
  String get wakeToOwnSoundHint => 'Twój głos, utwór, Spotify lub radio na żywo';

  @override
  String musicAdded(String name) {
    return 'Dodano $name. Wybierz go jako dźwięk dowolnego alarmu.';
  }

  @override
  String get playlists => 'Playlisty';

  @override
  String get likedSongs => 'Polubione utwory';

  @override
  String get noPlaylists => 'Brak playlist.';

  @override
  String get noLikedSongs => 'Brak polubionych utworów.';

  @override
  String get needsMic => 'Quando? potrzebuje mikrofonu do nagrywania.';

  @override
  String recordingN(int n) {
    return 'Nagranie $n';
  }

  @override
  String couldNotAddFile(String error) {
    return 'Nie udało się dodać pliku: $error';
  }

  @override
  String get addSongLink => 'Dodaj link do utworu';

  @override
  String get songLink => 'Link do utworu';

  @override
  String get songLinkHowTo =>
      'W Spotify, Apple Music, YouTube, YouTube Music lub SoundCloud dotknij Udostępnij, potem Kopiuj link, i wklej go tutaj.';

  @override
  String get songNameHint => 'Nazwa, np. Poranna playlista';

  @override
  String get whenAlarmGoesOffHeading => 'GDY ALARM DZWONI';

  @override
  String get playTheSong => 'Odtwórz utwór';

  @override
  String get ringThenOpen => 'Zadzwoń, potem otwórz';

  @override
  String get playTheSongHint =>
      'Otwiera się jego aplikacja i go odtwarza. Jeśli przez 10 sekund jest cicho, dzwoni dźwięk zapasowy, więc zawsze się obudzisz. Alarmy z zadaniem najpierw dzwonią, a potem go otwierają.';

  @override
  String get ringThenOpenHint => 'Dzwoni dźwięk zapasowy. Stop otwiera utwór w jego aplikacji.';

  @override
  String get playForHeading => 'ODTWARZAJ PRZEZ';

  @override
  String get pausesAfter => 'Quando? wstrzymuje utwór po tym czasie przyciskiem pauzy telefonu.';

  @override
  String get backupSoundHeading => 'DŹWIĘK ZAPASOWY';

  @override
  String get notALink => 'To nie wygląda na link.';

  @override
  String songOn(String app) {
    return 'Utwór w $app';
  }

  @override
  String get theWeb => 'sieci';

  @override
  String get pickFromYouTube => 'Wybierz z mojego YouTube';

  @override
  String get youTubeAndMusic => 'YouTube i YouTube Music';

  @override
  String get youTubeOn => 'Połączono · przytrzymaj, by się wylogować';

  @override
  String get youTubeSignIn => 'Zaloguj się przez Google';

  @override
  String get addSongLinkInstead => 'Zamiast tego dodaj link do utworu.';

  @override
  String get googleSignInFailed => 'Logowanie Google nie zostało ukończone. Spróbuj ponownie.';

  @override
  String get myYouTube => 'Mój YouTube';

  @override
  String get spotifyDirectOn => 'Bezpośrednie odtwarzanie Spotify włączone';

  @override
  String get spotifyDirect => 'Bezpośrednie odtwarzanie Spotify';

  @override
  String get spotifyDirectOnHint => 'Włączone · dotknij, by wyłączyć';

  @override
  String get spotifyDirectHint => 'Odtwarza dokładnie ten utwór. Wymaga Premium.';

  @override
  String get spotifyComingSoon => 'Wkrótce · wymaga Premium';

  @override
  String get spotifyFailed =>
      'Spotify się nie połączyło. Sprawdź, czy aplikacja Spotify jest zainstalowana, jesteś zalogowany i masz Premium.';

  @override
  String get nameThisSound => 'Nazwij ten dźwięk';

  @override
  String get sounds => 'Dźwięki';

  @override
  String get soundsSentence => 'Budź się przy własnym głosie, utworze, playliście lub radiu na żywo.';

  @override
  String stopTimer(String time) {
    return 'Stop · $time';
  }

  @override
  String get record => 'Nagraj';

  @override
  String get addAFile => 'Dodaj plik';

  @override
  String get addSongLinkLong => 'Dodaj link do utworu (Spotify, Apple Music, YouTube…)';

  @override
  String get musicAppsHeading => 'APLIKACJE MUZYCZNE';

  @override
  String get pickFromSpotify => 'Wybierz z mojego Spotify';

  @override
  String get yourPlaylistsAndLiked => 'Twoje playlisty i polubione utwory';

  @override
  String get mySpotify => 'Moje Spotify';

  @override
  String get spotifySignInFailed => 'Nie udało się zalogować do Spotify.';

  @override
  String get appleMusicNote => 'Logowanie pojawi się w wersji na iPhone’a. Na razie dodaj link do utworu.';

  @override
  String noSignInNote(String service) {
    return '$service nie pozwala innym aplikacjom się logować. Zamiast tego dodaj link do utworu.';
  }

  @override
  String get wakeToRadio => 'Budź się przy radiu internetowym';

  @override
  String get soundsExplain =>
      'Nagraj do 5 minut, dodaj plik, link do utworu lub radio na żywo. Gdy coś zawiedzie, zadzwoni dźwięk zapasowy.';

  @override
  String get yourSoundsHeading => 'TWOJE DŹWIĘKI';

  @override
  String playsIn(String app) {
    return 'Gra w $app';
  }

  @override
  String opensIn(String app) {
    return 'Otwiera się w $app';
  }

  @override
  String forSpan(String span) {
    return 'przez $span';
  }

  @override
  String get defaultLabel => 'Domyślny';

  @override
  String get radioUnreachable => 'Nie udało się połączyć z listą stacji. Sprawdź połączenie.';

  @override
  String get addStreamAddress => 'Dodaj adres strumienia';

  @override
  String get notAStream => 'To nie wygląda na adres strumienia (zaczyna się od http).';

  @override
  String get anyGenre => 'Dowolny gatunek';

  @override
  String get stationName => 'Nazwa stacji';

  @override
  String get closeSearch => 'Zamknij wyszukiwanie';

  @override
  String get searchByName => 'Szukaj po nazwie';

  @override
  String get anywhere => 'Wszędzie';

  @override
  String get noStations => 'Nie znaleziono stacji. Spróbuj innego gatunku lub kraju.';

  @override
  String wakeUpTo(String name) {
    return 'Budź się przy $name';
  }

  @override
  String get notQuite => 'Prawie. Spróbuj ponownie.';

  @override
  String shabbatStopsItself(int n) {
    return 'Tryb szabatowy: sam się wyłączy za $n sekund. Nie musisz dotykać telefonu.';
  }

  @override
  String get solveToSnooze => 'ROZWIĄŻ, ABY DRZEMAĆ';

  @override
  String get solveToStop => 'ROZWIĄŻ, ABY ZATRZYMAĆ';

  @override
  String get answer => 'Odpowiedź';

  @override
  String get snooze => 'Drzemka';

  @override
  String get stop => 'Stop';

  @override
  String get shakeToSnooze => 'POTRZĄŚNIJ, ABY DRZEMAĆ';

  @override
  String get shakeToStop => 'POTRZĄŚNIJ, ABY ZATRZYMAĆ';

  @override
  String get shakeHard => 'Mocno potrząsaj telefonem, aż pasek się zapełni.';

  @override
  String get cantShake => 'Nie możesz potrząsać? Rozwiąż działanie';

  @override
  String get pairsToSnooze => 'ZNAJDŹ PARY, ABY DRZEMAĆ';

  @override
  String get pairsToStop => 'ZNAJDŹ PARY, ABY ZATRZYMAĆ';

  @override
  String get typeToSnooze => 'WPISZ TO, ABY DRZEMAĆ';

  @override
  String get typeToStop => 'WPISZ TO, ABY ZATRZYMAĆ';

  @override
  String get scanToSnooze => 'ZESKANUJ KOD, ABY DRZEMAĆ';

  @override
  String get scanToStop => 'ZESKANUJ KOD, ABY ZATRZYMAĆ';

  @override
  String ringAgainUnless(int n) {
    return 'Zadzwonię znów za $n min, jeśli nie dotkniesz poniżej.';
  }

  @override
  String get imUp => 'Wstałem';

  @override
  String snoozeMin(int n) {
    return 'Drzemka $n min';
  }

  @override
  String snoozeMinLeft(int n, int left) {
    return 'Drzemka $n min · zostało $left';
  }

  @override
  String get noSnoozesLeft => 'Brak drzemek';

  @override
  String get stopThenOpen => 'Stop · potem otwórz';

  @override
  String get startingSong => 'Uruchamianie utworu';

  @override
  String wayToStop(String way) {
    return '$way, aby zatrzymać';
  }

  @override
  String wayToSnooze(String way) {
    return '$way, aby drzemać';
  }

  @override
  String ringsForMore(int n) {
    return 'Dzwoni jeszcze $n s';
  }

  @override
  String get leftToRing => 'zostało';

  @override
  String get wayVolumeButtons => 'Przyciski głośności';

  @override
  String get wayShake => 'Potrząśnij telefonem';

  @override
  String get taskNothing => 'Nic';

  @override
  String get taskSum => 'Rozwiąż działanie';

  @override
  String get taskShake => 'Potrząśnij 30 razy';

  @override
  String get taskMemory => 'Gra pamięciowa';

  @override
  String get taskPhrase => 'Wpisz zdanie';

  @override
  String get taskScan => 'Zeskanuj kod';

  @override
  String get noLimit => 'bez limitu';

  @override
  String upToTimes(int n) {
    return 'do $n×';
  }

  @override
  String shorterEachTime(int n) {
    return 'za każdym razem o $n min krócej';
  }

  @override
  String autoSnoozeAfter(int n) {
    return 'sama drzemka po $n min';
  }

  @override
  String get card => 'Karta';

  @override
  String get hiddenCard => 'Zakryta karta';

  @override
  String get phrase1 => 'Nie śpię i ten dzień jest mój';

  @override
  String get phrase2 => 'Jeśli nie teraz, to kiedy';

  @override
  String get phrase3 => 'Dzień dobry mnie i wszystkim, których kocham';

  @override
  String get phrase4 => 'Stoję na nogach i jestem gotów';

  @override
  String get phrase5 => 'Dziś zaczynam od nowa';

  @override
  String get notQuiteWords => 'Prawie, sprawdź każde słowo.';

  @override
  String get typeItHere => 'Wpisz tutaj';

  @override
  String get differentCode => 'To inny kod.';

  @override
  String get cameraUnavailable => 'Aparat jest niedostępny.';

  @override
  String get cantScan => 'Nie możesz skanować? Rozwiąż działanie';

  @override
  String get saveCodeToScan => 'Zapisz kod do skanowania';

  @override
  String get saveCodeHint =>
      'Wyceluj w kod kreskowy lub QR w miejscu, do którego trzeba dojść, np. pudełko w kuchni lub pastę w łazience. Aby zatrzymać alarm, zeskanujesz go ponownie.';

  @override
  String get cameraUnavailableSettings =>
      'Aparat jest niedostępny. Zezwól na dostęp do aparatu w Ustawieniach.';

  @override
  String gentleToGo(int n) {
    return 'Łagodne budzenie · zostało $n min';
  }

  @override
  String previewBody(String body) {
    return 'Podgląd · $body';
  }

  @override
  String snoozedBody(String body) {
    return 'Drzemka: $body';
  }

  @override
  String get areYouUp => 'Wstałeś?';

  @override
  String get tapImUp => 'Dotknij „Wstałem”, aby zatrzymać';

  @override
  String get volume => 'Głośność';

  @override
  String get wakeCheckOn => 'Kontrola pobudki włączona';

  @override
  String get stopsAtOnce => 'Zatrzymuje się od razu';

  @override
  String get ringsAgainIfNotUp => 'Dzwoni znów, jeśli nie wstaniesz';

  @override
  String get openAppAfter => 'Potem otwórz aplikację';

  @override
  String get noTask => 'Bez zadania';

  @override
  String get codeSaved => 'Kod zapisany';

  @override
  String get tapToSaveDifferent => 'Dotknij, aby zapisać inny';

  @override
  String get controlsHeading => 'STEROWANIE';

  @override
  String get onScreen => 'Na ekranie';

  @override
  String get taskHeading => 'ZADANIE';

  @override
  String get none => 'Brak';

  @override
  String get snoozeSentence => 'Jeszcze pięć minut? Wybierz, jak długo, ile razy i co trzeba zrobić.';

  @override
  String get settingsHeading => 'USTAWIENIA';

  @override
  String get snoozeTime => 'Czas drzemki';

  @override
  String get snoozeTimeHint => 'Jak długo trwa pierwsza drzemka';

  @override
  String get shortenSnoozes => 'Skracaj kolejne drzemki';

  @override
  String get shortenSnoozesHint => 'Każda drzemka po pierwszej jest o tyle krótsza';

  @override
  String get autoSnooze => 'Automatyczna drzemka';

  @override
  String get autoSnoozeHint => 'Jeśli go nie dotkniesz, sam przejdzie w drzemkę po';

  @override
  String get never => 'Nigdy';

  @override
  String get snoozeLimit => 'Limit drzemek';

  @override
  String get snoozeLimitHint => 'Ile razy możesz drzemać';

  @override
  String get unlimited => 'Bez limitu';

  @override
  String get useSnoozeFromSettings => 'Użyj drzemki z Ustawień';

  @override
  String get stopSentence => 'Jak wyłączasz alarm i co musisz zrobić najpierw.';

  @override
  String get shabbatNoTask => 'W szabat i święta alarmy same się wyłączają i nigdy nie wymagają zadania.';

  @override
  String get volumeSentence => 'Jak głośno dzwoni i jak łagodnie do tego dochodzi.';

  @override
  String get openAfterAlarm => 'Otwórz po alarmie';

  @override
  String get pickAnApp => 'Wybierz aplikację';

  @override
  String get orPasteLink => 'Lub wklej link: https://…';

  @override
  String get useThisLink => 'Użyj tego linku';

  @override
  String get noAppsFound => 'Nie znaleziono aplikacji.';

  @override
  String get weather => 'Pogoda';

  @override
  String get news => 'Wiadomości';

  @override
  String get usePhoneVolume => 'Użyj głośności alarmu telefonu';

  @override
  String get setsPhoneVolume => 'Ustawia głośność alarmu telefonu podczas dzwonienia, a potem ją przywraca.';

  @override
  String get fadeInOff => 'Bez narastania, od razu pełna głośność';

  @override
  String fadeInOver(String span) {
    return 'Narasta przez $span';
  }

  @override
  String get fadeOutOff => 'Bez wyciszania';

  @override
  String fadeOutOver(String span) {
    return 'Cichnie przez ostatnie $span';
  }

  @override
  String get fadesExplain =>
      'Wyciszanie działa, gdy alarm sam się wyłącza. Jeśli przejścia są dłuższe niż dzwonienie, oba się skracają.';

  @override
  String get soundSoftChime => 'Delikatny dzwonek';

  @override
  String get soundMorningRise => 'Poranny wschód';

  @override
  String get soundClassicBeep => 'Klasyczny sygnał';

  @override
  String get calmCity => 'Spokojny poranek w mieście';

  @override
  String get calmBirds => 'Ptaki o świcie';

  @override
  String get calmWaves => 'Fale na brzegu';

  @override
  String get calmRain => 'Delikatny deszcz';

  @override
  String get calmStream => 'Leśny strumień';

  @override
  String get calmWind => 'Łagodny wiatr';

  @override
  String get calmFire => 'Trzaskający ogień';

  @override
  String get calmNight => 'Letnia noc';

  @override
  String get publicDomain => 'Domena publiczna';

  @override
  String get phoneVolume => 'Głośność telefonu';

  @override
  String fadesIn(String span) {
    return 'narasta przez $span';
  }

  @override
  String fadesOut(String span) {
    return 'cichnie przez $span';
  }

  @override
  String get noFade => 'bez przejść';

  @override
  String minSecShort(int m, int s) {
    return '$m min $s s';
  }

  @override
  String get happensRings => 'Dzwoni';

  @override
  String get happensStopped => 'Zatrzymujesz go';

  @override
  String get happensSnoozed => 'Odkładasz drzemką';

  @override
  String get happensAutoStopped => 'Sam się wyłącza';

  @override
  String get eventLower => 'wydarzenie';

  @override
  String get appTest => 'Test Quando?';

  @override
  String get pushoverConnected => 'Pushover jest połączony';

  @override
  String get webhookConnected => 'Webhook jest połączony';

  @override
  String pushoverSaid(int code, String body) {
    return 'Pushover odpowiedział $code: $body';
  }

  @override
  String couldNotReachPushover(String error) {
    return 'Nie udało się połączyć z Pushover ($error)';
  }

  @override
  String itAnswered(int code) {
    return 'Odpowiedź: $code';
  }

  @override
  String couldNotReachIt(String error) {
    return 'Nie udało się połączyć ($error)';
  }

  @override
  String get calendarNotAllowed => 'Nie zezwolono na dostęp do kalendarza.';

  @override
  String get playlist => 'Playlista';

  @override
  String songCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n utworu',
      many: '$n utworów',
      few: '$n utwory',
      one: '1 utwór',
    );
    return '$_temp0';
  }

  @override
  String get spotifySaidNo =>
      'Spotify odmówiło. W panelu Spotify zaznacz Web API dla Quando? i dodaj swoje konto w User Management.';

  @override
  String serviceDidntAnswer(String service, int code) {
    return '$service nie odpowiedział ($code).';
  }

  @override
  String get youTubeSaidNo =>
      'YouTube odmówił. Sprawdź, czy Twoje konto Google jest użytkownikiem testowym projektu Quando.';

  @override
  String get event => 'Wydarzenie';

  @override
  String eventEnds(String title) {
    return '$title (koniec)';
  }

  @override
  String foundSoundsDevices(int s, int d) {
    return 'Znaleziono dźwięki: $s i urządzenia: $d.';
  }

  @override
  String get sentCheckDevices => 'Wysłano. Sprawdź inne urządzenia.';

  @override
  String sentTo(String name) {
    return 'Wysłano do $name.';
  }

  @override
  String get zapierHowTo =>
      'W Zapier utwórz Zap zaczynający się od „Webhooks by Zapier → Catch Hook” i wklej tu jego URL.';

  @override
  String get catchHookUrl => 'URL Catch Hook';

  @override
  String get iftttHowTo =>
      'W IFTTT utwórz aplet zaczynający się od „Webhooks → Receive a web request with a JSON payload”. Użyj tu tej samej nazwy zdarzenia. Twój klucz jest na ifttt.com/maker_webhooks/settings.';

  @override
  String get eventName => 'Nazwa zdarzenia';

  @override
  String get webhooksKey => 'Klucz Webhooks';

  @override
  String get webhookHowTo => 'Quando? wysyła JSON POST na ten adres.';

  @override
  String get connectionsSentence =>
      'Daj znać innym aplikacjom i urządzeniom, gdy alarm dzwoni, zostaje zatrzymany lub odłożony.';

  @override
  String get pushWhenRings => 'Wyślij powiadomienie, gdy alarm dzwoni';

  @override
  String get pushWhenRingsHint => 'Na inne telefony, tablety, zegarek lub komputer';

  @override
  String get yourUserKey => 'Twój klucz użytkownika';

  @override
  String get appToken => 'Token aplikacji';

  @override
  String get soundAndDevicesHeading => 'DŹWIĘK I URZĄDZENIA';

  @override
  String get loading => 'Ładowanie…';

  @override
  String get loadFromPushover => 'Wczytaj z Pushover';

  @override
  String get soundItPlays => 'Odtwarzany dźwięk';

  @override
  String get myPushoverDefault => 'Mój domyślny w Pushover';

  @override
  String get pushoverOwnSounds => 'Własne dźwięki pojawią się tu po przesłaniu ich na pushover.net/sounds.';

  @override
  String get allMyDevices => 'Wszystkie moje urządzenia';

  @override
  String get pushoverOnThisPhone =>
      'Zainstaluj aplikację Pushover też na tym telefonie, a zadzwoni tu Twoim dźwiękiem Pushover.';

  @override
  String get priority => 'Priorytet';

  @override
  String get priorityNormal => 'Normalny';

  @override
  String get priorityHigh => 'Wysoki: omija godziny ciszy';

  @override
  String get priorityEmergency => 'Alarmowy: powtarza do potwierdzenia';

  @override
  String get sending => 'Wysyłanie…';

  @override
  String get sendATest => 'Wyślij test';

  @override
  String get findUserKey => 'Znajdź mój klucz użytkownika';

  @override
  String get makeAppToken => 'Utwórz token aplikacji';

  @override
  String get webhooksHeading => 'ZAPIER, IFTTT I WEBHOOKI';

  @override
  String get webhooksExplain =>
      'Uruchom cokolwiek, gdy alarm dzwoni lub go zatrzymasz: włącz światła, zapisz godzinę pobudki, napisz do kogoś.';

  @override
  String get sendWhenAlarm => 'Wyślij, gdy alarm:';

  @override
  String get pauseOnShabbat => 'Wstrzymaj w szabat i święta';

  @override
  String get pauseOnShabbatHint => 'Nic nie jest wysyłane dla alarmów między zapaleniem świec a hawdalą';

  @override
  String get webhookPayloadNote =>
      'Każda wiadomość zawiera: event (ring, stopped, snoozed, auto_stopped), title, body, time, shabbat i snoozes. Klucze zostają na tym telefonie.';

  @override
  String get today => 'Dziś';

  @override
  String get tomorrow => 'Jutro';

  @override
  String get notAWebAddress => 'To nie wygląda na adres zaczynający się od https://';

  @override
  String get language => 'Język';

  @override
  String get phoneLanguage => 'Język telefonu';

  @override
  String get ringQuote => 'Jeśli nie teraz, to kiedy?';

  @override
  String get ringQuoteBy => 'Hillel';

  @override
  String get quotesTitle => 'Cytaty o czasie';

  @override
  String get quotesHint =>
      'Wybierz, skąd mają pochodzić. Jeden na każdą porę dnia; dotknij cytatu, by zobaczyć inny.';

  @override
  String get quotesOff => 'Wyłączone';

  @override
  String get quoteSongs => 'Piosenki';

  @override
  String get quoteMovies => 'Filmy';

  @override
  String get quoteLiterature => 'Książki i wiersze';

  @override
  String get quoteTanakh => 'Tanach (Biblia hebrajska)';

  @override
  String get quoteSages => 'Talmud i mędrcy';

  @override
  String get quoteSpeeches => 'Słynne przemówienia';

  @override
  String get quotePhilosophy => 'Filozofowie';

  @override
  String get quoteProverbs => 'Przysłowia i powiedzenia';

  @override
  String get quotesAlso => 'Pokazuj też';

  @override
  String get quoteCarnaval => 'Karnawał';

  @override
  String get quoteCarnavalHint => 'Piosenki i powiedzenia w czasie brazylijskiego karnawału';

  @override
  String get quoteNearMe => 'W pobliżu';

  @override
  String get quoteNearMeHint =>
      'Poeci i dni miejsca, w którym jesteś, według strefy czasowej i miasta szabatu';

  @override
  String get quoteSiddur => 'Sidur (modlitewnik)';

  @override
  String weeklyParasha(String name) {
    return 'Parsza $name';
  }

  @override
  String poweredBy(String name) {
    return 'napędzane przez $name';
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
  String get spotifyLibrarySignIn => 'Playlisty, polubione utwory i wyszukiwanie';

  @override
  String get spotifyLibraryOn => 'Połączono · przytrzymaj, by się wylogować';

  @override
  String spotifyLoginError(String reason) {
    return 'Logowanie do Spotify nie powiodło się: $reason';
  }

  @override
  String googleSignInError(String reason) {
    return 'Logowanie do Google nie powiodło się: $reason';
  }

  @override
  String get searchSongsHint => 'Szukaj utworów, wykonawców, playlist';

  @override
  String nothingFound(String query) {
    return 'Nic nie znaleziono dla „$query”.';
  }

  @override
  String get deliveryTitle => 'Powiadomienie';

  @override
  String get deliveryLocal => 'Dźwięk lokalny';

  @override
  String get deliveryBoth => 'Oba';

  @override
  String get deliveryConnect => 'Połącz Pushover';

  @override
  String get deliveryLoadFailed => 'Nie udało się wczytać dźwięków i urządzeń. Spróbuj ponownie.';

  @override
  String get deliveryBothHint => 'Dźwięk lokalny działa także przy awarii Pushover.';

  @override
  String get deliveryPushHint => 'Tylko Pushover. Urządzenie musi być wtedy online.';

  @override
  String get deliveryFallback =>
      'Dźwięk lokalny pozostaje aktywny, gdy Pushover jest rozłączony lub wstrzymany.';

  @override
  String get deliveryReset => 'Użyj istniejących ustawień';

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
  String get tuyaSignInTitle => 'Zaloguj się kontem Smart Life';

  @override
  String get tuyaSignInHint =>
      'Użyj tego samego kraju, adresu e-mail lub numeru telefonu i hasła co w aplikacji Smart Life lub Tuya Smart. Konto musi być już powiązane z Twoim projektem Tuya. Hasło trafia tylko do Tuya i nigdy nie jest zapisywane.';

  @override
  String get tuyaCountryCode => 'Numer kierunkowy kraju (Brazylia 55, USA 1)';

  @override
  String get tuyaAccount => 'E-mail lub telefon Smart Life';

  @override
  String get tuyaPassword => 'Hasło Smart Life';

  @override
  String get tuyaSignIn => 'Zaloguj i wczytaj sceny';

  @override
  String get tuyaRelayUrl => 'Adres przekaźnika Tuya Quando (https)';

  @override
  String get tuyaRelayHint =>
      'Użyj kraju, adresu e-mail lub telefonu i hasła konta Smart Life lub Tuya Smart. Trafiają raz do przekaźnika Tuya Quando i nie są zapisywane. Musisz być zalogowany na konto Quando.';

  @override
  String get tuyaGoogleHint =>
      'Logujesz się do Smart Life przez Google lub Apple? W Smart Life stuknij „Nie pamiętam hasła”, ustaw hasło i użyj go tutaj.';

  @override
  String get tuyaLinked => 'Konto Smart Life powiązane';

  @override
  String get tuyaUnlink => 'Odłącz';

  @override
  String get tuyaNeedsAccount => 'Najpierw zaloguj się na konto Quando w Ustawieniach.';

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
      'Odtwarzanie trwa zgodnie z czasem dzwonienia alarmu i kończy się po zatrzymaniu lub włączeniu drzemki.';

  @override
  String get musicBackupPlaying => 'Nie udało się uruchomić muzyki. Odtwarzany jest lokalny dźwięk alarmu.';

  @override
  String desktopMusicConnect(String service) {
    return 'Połącz aplikację $service';
  }

  @override
  String desktopMusicOn(String service) {
    return 'Połączono z $service · przytrzymaj, by rozłączyć';
  }

  @override
  String get musicSongs => 'Utwory';

  @override
  String get noMusicSongs => 'Nie znaleziono utworów w bibliotece Muzyka.';

  @override
  String serviceConnectUnavailable(String service) {
    return 'Dodaj link $service · otworzy się po alarmie';
  }

  @override
  String get soundCloudWidgetNote => 'Dodaj publiczny link';

  @override
  String get youtubePlayerHint =>
      'YouTube odtwarza wideo w widocznym odtwarzaczu. Gdy jest ukryty lub nie może odtwarzać, lokalny alarm działa dalej.';

  @override
  String get musicPreviewFailed =>
      'Nie można odtworzyć dźwięku. Sprawdź połączenie lub spróbuj innego utworu albo stacji.';

  @override
  String get skyMoonPhase => 'Faza Księżyca';

  @override
  String get skyMoonDetailsDisplay => 'Dodaj stronę fazy Księżyca';

  @override
  String get skyMoonDetailsHint => 'Przesuń do niej lub dotknij karty Księżyca w dowolnej chwili';

  @override
  String get moonRises => 'Wschód';

  @override
  String get moonSets => 'Zachód';

  @override
  String moonLunarDay(int day) {
    return 'Dzień $day z 29,5 w tym miesiącu księżycowym';
  }

  @override
  String get moonDetailsOpen => 'Otwórz fazę Księżyca';

  @override
  String get musicPlaylists => 'Playlisty muzyczne';

  @override
  String get videoPlaylists => 'Playlisty wideo';

  @override
  String get likedVideos => 'Polubione filmy';

  @override
  String get wholePlaylist => 'Obudź się przy całej playliście';

  @override
  String get noSongsInPlaylist => 'Brak utworów do odtworzenia.';

  @override
  String get hebrewNamesHeading => 'Pisownia paraszy i miesięcy';

  @override
  String get hebrewNamesIsraeli => 'Izraelska';

  @override
  String get hebrewNamesAshkenazi => 'Aszkenazyjska';

  @override
  String pickFromService(String service) {
    return 'Wybierz z mojego $service';
  }

  @override
  String get weatherTonight => 'Dziś wieczorem';

  @override
  String get weatherTomorrowMorning => 'Jutro rano';

  @override
  String weatherUntilAbout(String time) {
    return 'do około $time';
  }

  @override
  String get weatherSunBehindClouds => 'Słońce za chmurami';

  @override
  String get keysLockTitle => 'Klucze na Twoich urządzeniach';

  @override
  String get keysLockOff =>
      'Twoje klucze usług zostają na tym urządzeniu. Wybierz hasło synchronizacji, aby wysłać je zaszyfrowane na inne urządzenia.';

  @override
  String get keysLockOn =>
      'Twoje klucze usług są szyfrowane hasłem synchronizacji, zanim opuszczą to urządzenie. Nikt inny, nawet Google, nie może ich odczytać.';

  @override
  String get keysLockWaiting =>
      'Dotarły tu zablokowane klucze z innego urządzenia. Wpisz hasło synchronizacji, aby je otworzyć.';

  @override
  String get keysSetPassphrase => 'Wybierz hasło';

  @override
  String get keysChangePassphrase => 'Zmień hasło';

  @override
  String get keysUnlock => 'Odblokuj klucze';

  @override
  String get keysStartOver => 'Nie pamiętasz? Zacznij od nowa';

  @override
  String get keysStartOverHint =>
      'Zaczęcie od nowa wysyła klucze z tego urządzenia z nowym hasłem. Inne urządzenia poproszą o nowe.';

  @override
  String get keysPassphrase => 'Hasło synchronizacji';

  @override
  String get keysPassphraseAgain => 'Wpisz ponownie';

  @override
  String keysPassphraseShort(int count) {
    return 'Użyj co najmniej $count znaków.';
  }

  @override
  String get keysPassphraseMismatch => 'Hasła się nie zgadzają.';

  @override
  String get keysPassphraseWrong => 'To hasło nie otwiera tych kluczy.';

  @override
  String get keysPassphraseNote =>
      'Zapisz je: jeśli je zapomnisz, nikt go nie odzyska i wpiszesz klucze ponownie.';

  @override
  String get keysShareNeedsPassphrase =>
      'Najpierw wybierz hasło synchronizacji w sekcji Klucze na Twoich urządzeniach.';

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
      'Quando? może dzwonić przed wydarzeniami z twoich kalendarzy i po nich. Wybierz, skąd pochodzą.';

  @override
  String get deviceCalendarsHeading => 'NA TYM URZĄDZENIU';

  @override
  String get deviceCalendarsTitle => 'Aplikacja kalendarza tego urządzenia';

  @override
  String get deviceCalendarsHint =>
      'Wszystkie konta na nim: Google, Samsung, Outlook, iCloud i kalendarze trzymane tylko tutaj.';

  @override
  String get googleCalendarHeading => 'KALENDARZ GOOGLE';

  @override
  String get googleCalendarSignIn =>
      'Zaloguj się przez Google, aby czytać kalendarze prosto z Google, nawet gdy twojego konta Google nie ma na tym urządzeniu.';

  @override
  String googleCalendarSignedIn(String email) {
    return 'Zalogowano jako $email';
  }

  @override
  String get googleCalendarSignOut => 'Wyloguj';

  @override
  String get googleCalendarNotHere =>
      'Logowanie przez Google nie jest jeszcze dostępne na tym urządzeniu. Dodaj konto Google w ustawieniach urządzenia (Kalendarz › Konta), a jego kalendarze pojawią się przy tym urządzeniu.';

  @override
  String get googleCalendarUnreachable =>
      'Nie udało się teraz połączyć z Kalendarzem Google. Alarmy już z niego ustawione nadal zadzwonią.';

  @override
  String get googleCalendarTwiceHint =>
      'Kalendarze tego samego konta Google, które urządzenie już pokazuje, są na start wyłączone, żeby nic nie dzwoniło dwa razy.';

  @override
  String get timersTitle => 'Minutniki';

  @override
  String get timerStopwatch => 'Stoper';

  @override
  String get timerCountdown => 'Minutnik';

  @override
  String get timerSequence => 'Gotowi';

  @override
  String get timerStopwatchSub => 'Liczy w górę, z okrążeniami';

  @override
  String get timerCountdownSub => 'Odlicza w dół, dzwoni przy zerze';

  @override
  String get timerSequenceSub => 'Mówiony start i znaczniki';

  @override
  String get timerStart => 'Start';

  @override
  String get timerPause => 'Pauza';

  @override
  String get timerResume => 'Wznów';

  @override
  String get timerReset => 'Resetuj';

  @override
  String get timerLap => 'Okrążenie';

  @override
  String get timerTimesUp => 'Czas minął';

  @override
  String get timerSetTime => 'Ustaw czas';

  @override
  String get timerMinutes => 'Minuty';

  @override
  String get timerSeconds => 'Sekundy';

  @override
  String get seqOnYourMarks => 'Na miejsca';

  @override
  String get seqGetSet => 'Gotowi';

  @override
  String get seqGo => 'Start!';

  @override
  String get seqFinish => 'Czas!';

  @override
  String get seqReady => 'Gotowy';

  @override
  String get seqSettings => 'Ustawienia';

  @override
  String get seqStartCalls => 'Komunikaty przed startem';

  @override
  String get seqStartCallsHelp => 'Mówione na głos przed Startem, odliczane od startu wstecz.';

  @override
  String seqCallBefore(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n sekundy przed',
      many: '$n sekund przed',
      few: '$n sekundy przed',
      one: '1 sekunda przed',
    );
    return '$_temp0';
  }

  @override
  String get seqAddCall => 'Dodaj komunikat';

  @override
  String get seqCallText => 'Co powiedzieć';

  @override
  String get seqGoText => 'Na starcie powiedz';

  @override
  String get seqFinishText => 'Na końcu powiedz';

  @override
  String get seqLength => 'Długość';

  @override
  String get seqNoLimit => 'Bez limitu';

  @override
  String get seqSayEvery => 'Mów czas co';

  @override
  String get seqOff => 'Wyłączone';

  @override
  String seqEverySeconds(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n sekundy',
      many: '$n sekund',
      few: '$n sekundy',
      one: '1 sekunda',
    );
    return '$_temp0';
  }

  @override
  String seqEveryMinutes(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n minuty',
      many: '$n minut',
      few: '$n minuty',
      one: '1 minuta',
    );
    return '$_temp0';
  }

  @override
  String get seqFinalCount => 'Odliczaj ostatnie';

  @override
  String get seqMarks => 'Twoje znaczniki';

  @override
  String get seqAddMark => 'Dodaj znacznik';

  @override
  String seqMarkAt(String time) {
    return 'O $time';
  }

  @override
  String get seqSpeak => 'Mów na głos';

  @override
  String get seqBeeps => 'Sygnały i wibracje';

  @override
  String get seqSayRemaining => 'Mów czas pozostały, nie upłynięty';

  @override
  String get seqPresets => 'Ustawienia wstępne';

  @override
  String get seqPresetRace => 'Start wyścigu';

  @override
  String get seqPresetSprint => 'Wysiłek 30 s';

  @override
  String get seqPresetRound => 'Runda 1 min';

  @override
  String get seqHintNoLimit => 'Po Starcie liczy w górę, aż go zatrzymasz.';

  @override
  String get seqHintLength => 'Po Starcie odlicza w dół do zera.';

  @override
  String get seqWords => 'Słowa';

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

  @override
  String get ringAtEventReminders => 'Dzwoń przy przypomnieniach wydarzenia';

  @override
  String get ringAtEventRemindersHint =>
      'Przypomnienia z aplikacji kalendarza dzwonią tu jak głośne alarmy, z dźwiękiem tego alarmu.';

  @override
  String get atEventReminders => 'przy przypomnieniach wydarzenia';

  @override
  String get everyEventReminderLoud => 'Dzwoń głośno przy przypomnieniach każdego wydarzenia';

  @override
  String get loudNotificationsHeading => 'GŁOŚNE POWIADOMIENIA KALENDARZA';

  @override
  String get loudNotificationsTitle => 'Głośne powiadomienia kalendarza';

  @override
  String get loudNotificationsHint =>
      'Gdy aplikacja kalendarza pokaże przypomnienie, Quando? zadzwoni nim jak alarmem, nawet przy wyciszonym telefonie.';

  @override
  String get loudNotificationsDisclosureTitle => 'Pozwolić Quando? czytać powiadomienia kalendarza?';

  @override
  String get loudNotificationsDisclosure =>
      'Aby głośno dzwonić przypomnieniami z kalendarza, Quando? potrzebuje dostępu do powiadomień. Patrzy tylko na powiadomienia z wybranych aplikacji kalendarza, odczytuje ich tytuł i tekst na tym telefonie, by pokazać je przy alarmie, i nigdy ich nie zapisuje ani nie wysyła. Możesz to wyłączyć w każdej chwili.';

  @override
  String get loudNotificationsAgree => 'Zgadzam się, dalej';

  @override
  String get loudNotificationsNoAccess =>
      'Dostęp do powiadomień jest wyłączony. Włącz Quando? na liście, która się otworzy.';

  @override
  String get loudNotificationsAllow => 'Zezwól';

  @override
  String get loudNotificationsNoApps => 'Nie znaleziono obsługiwanej aplikacji kalendarza.';

  @override
  String get loudNotificationsTwiceNote =>
      'Wydarzenia, które mają już alarm kalendarza Quando?, dzwonią tylko raz.';

  @override
  String get loudNotificationsShabbatNote => 'Cisza w szabat i święta.';

  @override
  String get busyMode => 'Tryb zajęty';

  @override
  String get busyModeSubtitle => 'Nie przeszkadzać i autoodpowiedzi, gdy jesteś zajęty';

  @override
  String get busyIntro =>
      'Gdy jesteś zajęty, Quando? może wyciszyć telefon i odpowiadać na wiadomości za ciebie. Alarmy nadal dzwonią.';

  @override
  String get busyIosFocus =>
      'Na iPhonie i iPadzie aplikacje nie mogą włączyć trybu Skupienie ani odpowiadać na wiadomości. W aplikacji Skróty dodaj automatyzację „Gdy Quando? się otworzy” lub o danej godzinie, która włącza Skupienie, i ustaw w nim autoodpowiedź.';

  @override
  String get busyWhileHeading => 'GDY JESTEŚ ZAJĘTY';

  @override
  String get busyDnd => 'Nie przeszkadzać';

  @override
  String get busyDndHint =>
      'Tylko priorytetowe: połączenia i wiadomości wyciszone, alarmy dzwonią. Potem wszystko wraca do normy.';

  @override
  String get busyDndNoAccess => 'Quando? nie może jeszcze zmieniać trybu Nie przeszkadzać.';

  @override
  String get busyReplies => 'Odpowiadaj na wiadomości';

  @override
  String get busyRepliesHint =>
      'Raz na osobę, twoim tekstem, przez przycisk Odpowiedz w aplikacji. Tylko Android.';

  @override
  String get busyRepliesDisclosureTitle => 'Pozwolić Quando? odpowiadać na wiadomości?';

  @override
  String get busyRepliesDisclosure =>
      'Aby odpowiadać za ciebie, Quando? potrzebuje dostępu do powiadomień. Tylko gdy jesteś zajęty, patrzy na powiadomienia wiadomości z wybranych aplikacji, odczytuje na tym telefonie nazwę nadawcy i wysyła twój tekst raz przez przycisk Odpowiedz w aplikacji. Wiadomości nigdy nie są zapisywane ani wysyłane gdzie indziej. Grupy są pomijane, chyba że na nie pozwolisz.';

  @override
  String get busyReplyText => 'Twoja odpowiedź';

  @override
  String busyReplyTextHint(String until) {
    return '$until zamieni się w godzinę końca trybu zajęty.';
  }

  @override
  String busyReplyDefault(String until) {
    return 'Jestem teraz zajęty, odpowiem po $until.';
  }

  @override
  String get busyGroups => 'Odpowiadaj też w grupach';

  @override
  String get busyGroupsHint => 'Wyłączone: grupy nigdy nie dostają odpowiedzi.';

  @override
  String get busyRepliesOnShabbat => 'Odpowiadaj w szabat i święta';

  @override
  String get busyAskRabbi => 'Domyślnie wyłączone. Zapytaj rabina, zanim włączysz to na szabat.';

  @override
  String get busyWhenHeading => 'KIEDY JESTEŚ ZAJĘTY';

  @override
  String get busyWhenHint =>
      'Włącz „Zajęty podczas tych wydarzeń” w alarmie kalendarza lub „Zajęty po dzwonku” w alarmie.';

  @override
  String get busyDuringLock => 'Zajęty, gdy włączony jest tryb blokady';

  @override
  String get busyNoneComing => 'Nic zajętego w ciągu 7 dni.';

  @override
  String get busyDuringEvents => 'Zajęty podczas tych wydarzeń';

  @override
  String get busyDuringEventsHint => 'Tryb zajęty od początku do końca każdego wydarzenia.';

  @override
  String get busySettings => 'Ustawienia trybu zajęty';

  @override
  String get busyAfterRing => 'Zajęty po dzwonku';

  @override
  String get busyAfterRingHint => 'Nie przeszkadzać i autoodpowiedzi na chwilę, np. trening lub drzemka.';

  @override
  String get shareCard => 'Udostępnij swój poranek';

  @override
  String get shareCardSubtitle => 'Dzisiejsze niebo i cytat albo twoje zdjęcie, do Relacji i statusu';

  @override
  String get shareAppMissing => 'Tej aplikacji nie ma na telefonie.';

  @override
  String get shareAsIs => 'Udostępnij bez zmian';

  @override
  String get shareTapQuote => 'Dotknij cytatu, by zmienić.';

  @override
  String get shareStory => 'Relacja';

  @override
  String get shareSquare => 'Kwadrat';

  @override
  String get shareYourWords => 'Twoje słowa (opcjonalnie)';

  @override
  String get shareYourWordsHint => 'Zamiast dzisiejszego cytatu';

  @override
  String get shareYourPhoto => 'Twoje zdjęcie';

  @override
  String get shareOtherPhoto => 'Inne zdjęcie';

  @override
  String get shareSkyBack => 'Dzisiejsze niebo';

  @override
  String get shareYourVideo => 'Twój film';

  @override
  String get shareInstagramStory => 'Relacje na Instagramie';

  @override
  String get shareWhatsApp => 'WhatsApp: status lub czat';

  @override
  String get shareMore => 'Więcej aplikacji';

  @override
  String get shareYouPost =>
      'Quando? otwiera aplikację z gotową kartą. Ty wybierasz, gdzie, i sam publikujesz.';

  @override
  String get shareAndroidFirst => 'Udostępnianie wkrótce na iPhonie i iPadzie.';

  @override
  String songSaved(String name) {
    return '„$name” zapisano jako dźwięk alarmu';
  }

  @override
  String get shareToQuando => 'Udostępnij utwór do Quando?';

  @override
  String get shareToQuandoHint =>
      'W YouTube, YouTube Music, Spotify, SoundCloud lub Apple Music dotknij Udostępnij, potem Quando?. Stanie się dźwiękiem alarmu odtwarzanym w swojej aplikacji.';
}
