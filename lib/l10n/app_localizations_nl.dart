// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Dutch Flemish (`nl`).
class AppLocalizationsNl extends AppLocalizations {
  AppLocalizationsNl([String locale = 'nl']) : super(locale);

  @override
  String get undo => 'Ongedaan maken';

  @override
  String duplicatedNamed(String name) {
    return '“$name” gedupliceerd';
  }

  @override
  String deletedNamed(String name) {
    return '“$name” verwijderd';
  }

  @override
  String get when => 'Wanneer?';

  @override
  String get newAtTime => 'Op een tijdstip';

  @override
  String get newAtTimeHint => 'Elke werkdag om 7:00, eenmalig om 15:30…';

  @override
  String get newAroundEvent => 'Rond een gebeurtenis';

  @override
  String get newAroundEventHint =>
      'Zoek in agenda’s, sjabbat- en zontijden en laat dan vóór, op of na het moment afgaan';

  @override
  String get editThisAlarm => 'Deze wekker bewerken';

  @override
  String editNamed(String name) {
    return '“$name” bewerken';
  }

  @override
  String get preset => 'sjabloon';

  @override
  String get editThisCalendarRule => 'Deze agendaregel bewerken';

  @override
  String get ringThisOneAfterAll => 'Deze toch laten afgaan';

  @override
  String get skipJustThisOne => 'Alleen deze overslaan';

  @override
  String get renameGroup => 'Groep hernoemen';

  @override
  String quickSet(String label, String time) {
    return '$label · gaat af om $time';
  }

  @override
  String get newAlarm => 'Nieuwe wekker';

  @override
  String get appName => 'Quando?';

  @override
  String get lockMode => 'Vergrendelmodus';

  @override
  String get calendars => 'Agenda’s';

  @override
  String get settings => 'Instellingen';

  @override
  String get nextAlarmHeading => 'VOLGENDE WEKKER';

  @override
  String get nothingSet => 'Niets ingesteld';

  @override
  String get tagline => 'Alles op zijn tijd.';

  @override
  String sunriseAt(String time) {
    return 'Zonsopgang $time';
  }

  @override
  String sunsetAt(String time) {
    return 'Zonsondergang $time';
  }

  @override
  String get alarmsMayNotRing => 'Je wekkers gaan misschien niet af';

  @override
  String get tapToFixIt => 'Tik om het op te lossen';

  @override
  String inMinutes(int minutes) {
    return 'Over $minutes min';
  }

  @override
  String get atSunset => 'Bij zonsondergang';

  @override
  String get sunset => 'Zonsondergang';

  @override
  String get shabbatModeIsOn => 'SJABBATMODUS STAAT AAN';

  @override
  String nextInCity(String city) {
    return 'VOLGENDE · $city';
  }

  @override
  String get candleLighting => 'Kaarsen aansteken';

  @override
  String get havdalah => 'Havdala';

  @override
  String get shabbatAndFestivals => 'Sjabbat en feestdagen';

  @override
  String get yourAlarmsHeading => 'JOUW WEKKERS';

  @override
  String get tapWhenToAdd => 'Tik op Wanneer? om een wekker toe te voegen.';

  @override
  String get aroundEventsHeading => 'ROND GEBEURTENISSEN';

  @override
  String searchFor(String words) {
    return 'zoeken: $words';
  }

  @override
  String get thisWeekHeading => 'WEKKERS DEZE WEEK';

  @override
  String get noAlarmsThisWeek => 'Geen wekkers in de komende 7 dagen.';

  @override
  String get alarmsSetThemselves => 'Wekkers stellen zichzelf in op deze telefoon zodra je iets wijzigt.';

  @override
  String cityTime(String city) {
    return 'tijd in $city';
  }

  @override
  String get more => 'Meer';

  @override
  String get turnOff => 'Uitzetten';

  @override
  String get turnOn => 'Aanzetten';

  @override
  String get duplicate => 'Dupliceren';

  @override
  String get delete => 'Verwijderen';

  @override
  String get inOneHour => 'Over 1 uur';

  @override
  String get logoLabel => 'Quando?-logo';

  @override
  String get noTimesSet => 'Geen tijden ingesteld';

  @override
  String get atTheMoment => 'op het moment';

  @override
  String timesRange(int count, String from, String to) {
    return '$count keer · $from tot $to';
  }

  @override
  String spanDays(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n dagen', one: '1 dag');
    return '$_temp0';
  }

  @override
  String spanHours(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n uur', one: '1 uur');
    return '$_temp0';
  }

  @override
  String spanMinutes(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n minuten', one: '1 minuut');
    return '$_temp0';
  }

  @override
  String spanSeconds(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n seconden', one: '1 seconde');
    return '$_temp0';
  }

  @override
  String get now => 'nu';

  @override
  String spanBefore(String span) {
    return '$span ervoor';
  }

  @override
  String spanAfter(String span) {
    return '$span erna';
  }

  @override
  String alarmCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n wekkers', one: '1 wekker');
    return '$_temp0';
  }

  @override
  String get allOn => 'allemaal aan';

  @override
  String get allOff => 'allemaal uit';

  @override
  String someOn(int n) {
    return '$n aan';
  }

  @override
  String skippedBody(String body) {
    return 'Overgeslagen · $body';
  }

  @override
  String timeToTime(String from, String to) {
    return '$from – $to';
  }

  @override
  String skippedCount(int n) {
    return '$n overgeslagen';
  }

  @override
  String get sunNoRiseSet => 'De zon komt hier vandaag niet op of gaat niet onder';

  @override
  String sunProgress(int percent) {
    return 'De zon heeft $percent% van de dag afgelegd';
  }

  @override
  String get sunIsDown => 'De zon is onder';

  @override
  String get searchCity => 'Zoek een stad';

  @override
  String get tomorrowLower => 'morgen';

  @override
  String get yesterdayLower => 'gisteren';

  @override
  String get worldClocksHeading => 'WERELDKLOKKEN';

  @override
  String get add => 'Toevoegen';

  @override
  String cityHere(String city) {
    return '$city · hier';
  }

  @override
  String get worldClocksHint =>
      'Voeg steden toe om hier hun tijd te zien. Veeg naar links om er een te verwijderen.';

  @override
  String get groupNameHint => 'Werk, Kinderen, Sportschool…';

  @override
  String get cancel => 'Annuleren';

  @override
  String get ok => 'OK';

  @override
  String get noGroup => 'Geen groep';

  @override
  String get newGroupEllipsis => 'Nieuwe groep…';

  @override
  String get newGroup => 'Nieuwe groep';

  @override
  String secondsShort(int n) {
    return '$n s';
  }

  @override
  String minutesShort(int n) {
    return '$n min';
  }

  @override
  String get minutes => 'Minuten';

  @override
  String get ringFor => 'Afgaan gedurende';

  @override
  String get seconds => 'Seconden';

  @override
  String get oneSecondLess => '1 seconde minder';

  @override
  String get oneSecondMore => '1 seconde meer';

  @override
  String inDays(int d) {
    return 'over $d d';
  }

  @override
  String inDaysHours(int d, int h) {
    return 'over $d d $h u';
  }

  @override
  String inHours(int h) {
    return 'over $h u';
  }

  @override
  String inHoursMinutes(int h, int m) {
    return 'over $h u $m min';
  }

  @override
  String inMins(int m) {
    return 'over $m min';
  }

  @override
  String placeChange(String city, String where) {
    return '$city · $where · wijzigen';
  }

  @override
  String get israel => 'Israël';

  @override
  String get outsideIsrael => 'buiten Israël';

  @override
  String get comingUpHeading => 'BINNENKORT';

  @override
  String get lockForShabbat => 'Vergrendel de telefoon voor sjabbat';

  @override
  String get lockForShabbatHint => 'Van kaarsen aansteken tot havdala, ook op feestdagen';

  @override
  String get ownShabbatAlarmsHeading => 'JOUW SJABBATWEKKERS';

  @override
  String get addShabbatAlarm => 'Sjabbat- of feestdagwekker toevoegen';

  @override
  String get readyMadeHeading => 'KANT-EN-KLARE WEKKERS';

  @override
  String bringBackDeleted(int n) {
    return 'Verwijderde terughalen ($n)';
  }

  @override
  String get presetsHint => 'Tik op een wekker om de tijden te wijzigen. Veeg om te verwijderen.';

  @override
  String get lockSentence => 'Beperk de telefoon tot klok en wekkers, voor sjabbat of een gefocuste nacht.';

  @override
  String get lockExplain =>
      'Tijdens het vergrendelen toont Quando? alleen de tijd, je volgende wekker en wanneer het slot eindigt. Wekkers blijven werken en niets kan worden gewijzigd tot het ontgrendeld is.';

  @override
  String get lockNowHeading => 'NU VERGRENDELEN';

  @override
  String get lockAutoHeading => 'AUTOMATISCH VERGRENDELEN';

  @override
  String get shabbatAndFestivalsLong => 'Sjabbat en feestdagen';

  @override
  String get fromCandleToHavdalah => 'Van kaarsen aansteken tot havdala';

  @override
  String get lockCalendarWord => 'Tijdens agenda-afspraken met dit woord';

  @override
  String get lockCalendarWordHint => 'bijv. slot, examen, focus';

  @override
  String get leaveEmptyForNone => 'Leeg laten voor geen';

  @override
  String get connectCalendarsFirst => 'Koppel eerst agenda’s (agenda-icoon)';

  @override
  String get openWhenLockStarts => 'Quando? openen als een slot begint';

  @override
  String get openWhenLockStartsHint =>
      'Een zacht geluid van 1 seconde brengt Quando? naar voren om te vergrendelen';

  @override
  String get pinToScreen => 'Quando? op het scherm vastzetten';

  @override
  String get pinToScreenHint =>
      'Andere apps openen niet tijdens het slot. Android vraagt de eerste keer om bevestiging.';

  @override
  String get noLocksComingUp => 'Geen sloten gepland.';

  @override
  String get leaveLockEarly =>
      'Wil je eerder stoppen? Houd “Vasthouden om te ontgrendelen” 3 seconden ingedrukt.';

  @override
  String get locked => 'Vergrendeld';

  @override
  String get shabbatShalom => 'Sjabbat sjalom';

  @override
  String get chagSameach => 'Chag sameach';

  @override
  String get unlocksHeading => 'ONTGRENDELT';

  @override
  String get nowCap => 'Nu';

  @override
  String get nextAlarm => 'Volgende wekker';

  @override
  String get holdToUnlock => 'Vasthouden om te ontgrendelen';

  @override
  String get lockSentenceCalm =>
      'Vergrendel de telefoon op de klok en je wekkers: voor een examen, een vergadering of een rustige avond.';

  @override
  String get lockCalendarHeading => 'MET JE AGENDA';

  @override
  String get lockCalendarExplain =>
      'Vergrendel tijdens een afspraak, of van een afspraak tot de volgende die je noemt. Werkt met elke gekozen agenda, ook gedeelde.';

  @override
  String get lockAddCalendar => 'Agendavergrendeling toevoegen';

  @override
  String get lockEditCalendar => 'Agendavergrendeling';

  @override
  String get lockDuring => 'Tijdens een afspraak';

  @override
  String get lockBetween => 'Tussen twee afspraken';

  @override
  String get lockStartsAt => 'Afspraken met de naam…';

  @override
  String get lockStartsAtBetween => 'Begint bij een afspraak met de naam…';

  @override
  String get lockEndsAt => 'Eindigt bij de volgende afspraak met de naam…';

  @override
  String get lockStartHint => 'bijv. examen, focus, sport';

  @override
  String get lockEndHint => 'bijv. thuis';

  @override
  String get lockAnyCalendar => 'Elke agenda';

  @override
  String get lockNoMatches => 'Nog niets in je agenda\'s past.';

  @override
  String get lockNextTimes => 'VOLGENDE KEREN';

  @override
  String lockDuringTitle(String a) {
    return 'Tijdens ‘$a’';
  }

  @override
  String lockBetweenTitle(String a, String b) {
    return 'Van ‘$a’ tot de volgende ‘$b’';
  }

  @override
  String lockShabbatCalendarFound(String name) {
    return '‘$name’ bevat sjabbattijden.';
  }

  @override
  String get lockShabbatFromCalendar => 'Vergrendel van kaarsen aansteken tot havdala';

  @override
  String get lockShabbatFromCalendarHint => 'Gebruikt de tijden uit die agenda, met kaarsen op het scherm.';

  @override
  String get lockMoreWays => 'Meer manieren om te vergrendelen';

  @override
  String get lockQuietTime => 'Rustmoment';

  @override
  String nextCandleLightingFrom(String time, String name) {
    return 'Volgende kaarsen aansteken: $time, uit $name';
  }

  @override
  String get calendarAlarm => 'Agendawekker';

  @override
  String get connectCalendars => 'Agenda’s koppelen';

  @override
  String get calendarAlarmsHeading => 'AGENDAWEKKERS';

  @override
  String get calendarNoneYet => 'Nog geen. Begin hiermee en pas het daarna aan:';

  @override
  String get fifteenBeforeEvery => '15 minuten voor elke afspraak';

  @override
  String get useTheseCalendarsHeading => 'GEBRUIK DEZE AGENDA’S';

  @override
  String get noTimedEvents => 'Geen komende afspraken met tijd in deze agenda’s.';

  @override
  String get atTheStart => 'bij het begin';

  @override
  String everyForBefore(String every, String span) {
    return 'elke $every gedurende $span ervoor';
  }

  @override
  String spanAfterItEnds(String span) {
    return '$span na het einde';
  }

  @override
  String get noAlarmsChosen => 'Geen wekkers gekozen';

  @override
  String get gentleWakeUp => 'Zacht wakker worden';

  @override
  String gentleSummary(int minutes, String sound) {
    return '$minutes min ervoor · $sound';
  }

  @override
  String get off => 'Uit';

  @override
  String get gentleSentence =>
      'Een rustig geluid begint zacht vóór je wekker, zodat je nooit met een schok wakker wordt.';

  @override
  String get gentleExplain =>
      'Het wordt langzaam luider, haalt je uit je lichte slaap en stopt net voordat je wekker afgaat.';

  @override
  String get startsBeforeHeading => 'BEGINT VOOR JE WEKKER';

  @override
  String get leadUpSoundHeading => 'AANLOOPGELUID';

  @override
  String get listen => 'Luisteren';

  @override
  String get whoRecordedThese => 'Wie deze geluiden opnam';

  @override
  String get done => 'Klaar';

  @override
  String get soundCredits => 'Geluidsvermeldingen';

  @override
  String yourTimeCity(String city) {
    return 'Jouw tijd ($city)';
  }

  @override
  String get anotherCity => 'Andere stad…';

  @override
  String get ringingIn5 => 'Gaat af over 5 seconden…';

  @override
  String get alarmSaved => 'Wekker opgeslagen.';

  @override
  String alarmSetFor(String span) {
    return 'Wekker gaat af over $span.';
  }

  @override
  String hoursMinutesShort(int h, int m) {
    return '$h u $m min';
  }

  @override
  String get editAlarm => 'Wekker bewerken';

  @override
  String get previewCaps => 'VOORBEELD';

  @override
  String get saveCaps => 'OPSLAAN';

  @override
  String cityTimeForYou(String city, String time) {
    return 'tijd in $city · $time voor jou';
  }

  @override
  String repeatHeading(String repeat) {
    return 'HERHALEN · $repeat';
  }

  @override
  String get labelField => 'Label (hardop voorgelezen als gesproken wekkers aan staan)';

  @override
  String get group => 'Groep';

  @override
  String ringsForHeading(String span) {
    return 'GAAT AF GEDURENDE $span';
  }

  @override
  String useDefault(String value) {
    return 'Standaard gebruiken ($value)';
  }

  @override
  String get save => 'Opslaan';

  @override
  String get sameTime => 'zelfde tijd';

  @override
  String get untilYouStopIt => 'Tot je hem stopt';

  @override
  String get alarm => 'Wekker';

  @override
  String get once => 'Eenmalig';

  @override
  String get everyDay => 'Elke dag';

  @override
  String get weekdays => 'Werkdagen';

  @override
  String get weekends => 'Weekenden';

  @override
  String timeInCity(String time, String city) {
    return '$time tijd in $city';
  }

  @override
  String eventsMatching(String words) {
    return 'Afspraken met “$words”';
  }

  @override
  String get everyEvent => 'Elke afspraak';

  @override
  String get sunrise => 'Zonsopgang';

  @override
  String havdalahEndOf(String day) {
    return 'Havdala · einde van $day';
  }

  @override
  String get yomTov => 'Jom tov';

  @override
  String get shabbat => 'Sjabbat';

  @override
  String get presetCountdown => 'Aftellen tot kaarsen aansteken';

  @override
  String get presetHourly => 'Elk uur, vanaf 6 uur ervoor';

  @override
  String get presetDailyWeek => 'Eens per dag, in de week ervoor';

  @override
  String get presetSecondNight => 'Kaarsen van de tweede avond';

  @override
  String get presetFridayReminder => 'Herinnering 3 uur ervoor: laad je telefoon op';

  @override
  String get presetFridayReminderLabel => 'Laad je telefoon op en zet wekkers voor morgen';

  @override
  String get presetSunset => 'Zonsondergang, en 15 minuten ervoor';

  @override
  String get pesach => 'Pesach';

  @override
  String get shavuot => 'Sjavoeot';

  @override
  String get roshHashanah => 'Rosj hasjana';

  @override
  String get yomKippur => 'Jom kipoer';

  @override
  String get sukkot => 'Soekot';

  @override
  String get sheminiAtzeret => 'Sjemini atseret';

  @override
  String get simchatTorah => 'Simchat tora';

  @override
  String get readyNotifications => 'Wekkers tonen';

  @override
  String get readyNotificationsWhy => 'Laat het wekkerscherm en de stopknop verschijnen.';

  @override
  String get readyFullScreen => 'Afgaan over het vergrendelscherm';

  @override
  String get readyFullScreenWhy => 'Toont de wekker op volledig scherm, ook als de telefoon vergrendeld is.';

  @override
  String get readyExact => 'Op de minuut afgaan';

  @override
  String get readyExactWhy => 'Zonder dit kan de telefoon wekkers een paar minuten te laat laten afgaan.';

  @override
  String get readyBattery => 'Blijven draaien bij batterijbesparing';

  @override
  String get readyBatteryWhy => 'Voorkomt dat batterijbesparing wekkers ’s nachts dempt.';

  @override
  String get tipXiaomi =>
      'Xiaomi-telefoons: ga naar Instellingen › Apps › Quando?, zet Autostart aan en stel Batterijbesparing in op Geen beperkingen.';

  @override
  String get tipSamsung =>
      'Samsung-telefoons: controleer onder Instellingen › Batterij › Achtergrondgebruiklimieten dat Quando? niet in slaapstand staat.';

  @override
  String get tipHuawei =>
      'Huawei- en Honor-telefoons: zet onder Instellingen › Batterij › App-start Quando? op Handmatig beheren en sta alles toe.';

  @override
  String get tipOther =>
      'Op deze telefoon: sta onder Instellingen › Batterij Quando? toe op de achtergrond te draaien en zet optimalisatie uit.';

  @override
  String get testRing => 'Testwekker';

  @override
  String get testRingBody => 'Quando? kan je wekken';

  @override
  String get ringsIn20 => 'Gaat af over 20 seconden. Vergrendel nu je telefoon en wacht.';

  @override
  String get readyToRing => 'Klaar om af te gaan';

  @override
  String get checkingPhone => 'Je telefoon wordt gecontroleerd…';

  @override
  String get phoneReady => 'Je telefoon is klaar om elke wekker op tijd te laten afgaan.';

  @override
  String thingsNeedFixing(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n dingen moeten worden opgelost, anders gaan wekkers misschien niet af.',
      one: '1 ding moet worden opgelost, anders gaan wekkers misschien niet af.',
    );
    return '$_temp0';
  }

  @override
  String get fix => 'Oplossen';

  @override
  String get testIn20 => 'Test: gaat af over 20 seconden';

  @override
  String get testIn20Hint =>
      'Vergrendel je telefoon en leg hem neer. Gaat de wekker op volledig scherm af, dan is alles klaar.';

  @override
  String get readyToRingHint => 'Controleer of je telefoon elke wekker op tijd laat afgaan';

  @override
  String get connections => 'Koppelingen';

  @override
  String get timeZoneHeading => 'TIJDZONE';

  @override
  String get followPhone => 'Telefoon volgen';

  @override
  String followPhoneNow(String city) {
    return 'Nu $city. Past zich aan als je reist.';
  }

  @override
  String get zoneFixed => 'Vast. Wekkers houden deze tijd aan, ook als je reist.';

  @override
  String get shabbatCityHeading => 'STAD VOOR SJABBAT';

  @override
  String get inIsraelOneDay => 'In Israël (één feestdag)';

  @override
  String candleMinutesHeading(int n) {
    return 'KAARSEN: $n MINUTEN VOOR ZONSONDERGANG';
  }

  @override
  String get endOfShabbatHeading => 'EINDE VAN SJABBAT EN FEESTDAGEN';

  @override
  String get nightfallGeonim => 'Vallen van de avond (Geoniem, 8,5°)';

  @override
  String get rabbeinuTam => '72 minuten na zonsondergang (Rabbeinoe Tam)';

  @override
  String get whenAlarmRingsHeading => 'ALS EEN WEKKER AFGAAT';

  @override
  String get recordOrAddSounds => 'Geluiden opnemen of toevoegen';

  @override
  String get ringsForThisLong => 'Gaat zo lang af en stopt dan vanzelf';

  @override
  String get sameFades => 'Dezelfde fades voor alle wekkers';

  @override
  String get sameFadesOn => 'Vervangt de fades van elke wekker. Elke wekker houdt zijn eigen volume.';

  @override
  String get sameFadesOff => 'Uit: elke wekker gebruikt de fades die bij zijn Volume zijn ingesteld.';

  @override
  String get sayItOutLoud => 'Hardop zeggen';

  @override
  String get sayItOutLoudHint =>
      'Leest voor waarvoor de wekker is, bijv. “Kaarsen aansteken, 15 minuten ervoor”';

  @override
  String get noSnooze => 'Geen snooze';

  @override
  String snoozeUpTo(int times, int minutes) {
    return 'Snooze tot $times× voor $minutes min';
  }

  @override
  String get wakeUpCheck => 'Wakker-check';

  @override
  String get wakeUpCheckHint =>
      'Gaat na het stoppen over 3 minuten opnieuw af als je niet op “Ik ben wakker” tikt';

  @override
  String get solveSum => 'Los een som op om te stoppen';

  @override
  String get provesAwake => 'Bewijst dat je wakker bent';

  @override
  String get shabbatNoTasks =>
      'Op sjabbat en feestdagen geldt hiervan niets: wekkers stoppen vanzelf en vragen nooit om de telefoon aan te raken.';

  @override
  String get testAlarmIn1 => 'Over 1 minuut een testwekker laten afgaan';

  @override
  String get timesDisclaimer =>
      'Tijden worden op de telefoon berekend. Vraag bij twijfelgevallen je rabbijn of kijk in de gemeentekalender.';

  @override
  String get recommended => 'Aanbevolen';

  @override
  String get chooseCity => 'Kies een stad';

  @override
  String get testOnlyOnPhone => 'Testwekkers werken alleen op een telefoon.';

  @override
  String get testAlarm => 'Testwekker';

  @override
  String get testAlarmBody => 'Zo klinken je wekkers';

  @override
  String get testAlarmIn1Set => 'Testwekker over 1 minuut. Je kunt je telefoon vergrendelen.';

  @override
  String get presetGone => 'Dit sjabloon bestaat niet meer.';

  @override
  String get editPreset => 'Sjabloon bewerken';

  @override
  String get on => 'Aan';

  @override
  String get ringsHeading => 'GAAT AF';

  @override
  String get noTimesYet => 'Nog geen tijden. Voeg er hieronder een toe.';

  @override
  String get atTheMomentItself => 'Op het moment zelf';

  @override
  String get remove => 'Verwijderen';

  @override
  String get addATime => 'Tijd toevoegen';

  @override
  String get resetPreset => 'Terugzetten naar origineel';

  @override
  String get skipOneHint =>
      'Om één wekker over te slaan, tik je erop onder “Wekkers deze week” op het startscherm.';

  @override
  String get unitMinutes => 'minuten';

  @override
  String get unitHours => 'uur';

  @override
  String get unitDays => 'dagen';

  @override
  String get before => 'Ervoor';

  @override
  String get after => 'Erna';

  @override
  String get oneWeek => '1 week';

  @override
  String daysShort(int n) {
    return '$n d';
  }

  @override
  String hoursShort(int n) {
    return '$n u';
  }

  @override
  String get howToSearch => 'Hoe zoeken';

  @override
  String get searchHelpWord => 'Titel bevat “dentist”, hoofdletters of niet';

  @override
  String get searchHelpStar => '* staat voor willekeurige letters: dentist, dentures';

  @override
  String get searchHelpQuestion => '? staat voor één letter: yoga, toga';

  @override
  String get searchHelpPhrase => 'Precies deze zin';

  @override
  String get searchHelpAnd => 'Beide woorden (AND)';

  @override
  String get searchHelpOr => 'Een van beide. | werkt ook';

  @override
  String get searchHelpNot => 'Uitsluiten. NOT en ! werken ook';

  @override
  String get searchHelpBrackets => 'Haakjes groeperen woorden';

  @override
  String get searchHelpEmpty => 'Leeg laten om bij elke afspraak af te gaan.';

  @override
  String get customTime => 'Andere tijd';

  @override
  String get other => 'Anders';

  @override
  String get sun => 'Zon';

  @override
  String get calendar => 'Agenda';

  @override
  String get newEventAlarm => 'Nieuwe afsprakenwekker';

  @override
  String get eventAlarm => 'Afsprakenwekker';

  @override
  String get findEventsHeading => 'AFSPRAKEN ZOEKEN';

  @override
  String get searchEventsHint => 'Zoek: tandarts, sport OR yoga, tand*…';

  @override
  String get alsoBuiltInTimes => 'Ook sjabbat-, feestdag- en zontijden';

  @override
  String get alsoBuiltInTimesHint => 'bijv. “kaars*”, “havdala”, “zonsondergang”';

  @override
  String get allMyCalendars => 'Al mijn agenda’s';

  @override
  String get connectToSearch => 'Koppel agenda’s om erin te zoeken';

  @override
  String get searching => 'Zoeken…';

  @override
  String get nothingMatches60 => 'Niets gevonden in de komende 60 dagen';

  @override
  String eventsIn60(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n afspraken in de komende 60 dagen',
      one: '1 afspraak in de komende 60 dagen',
    );
    return '$_temp0';
  }

  @override
  String nextRingsAt(String times, String title) {
    return 'Volgende: gaat af om $times voor “$title”';
  }

  @override
  String showMoreLeft(int n) {
    return 'Meer tonen (nog $n)';
  }

  @override
  String get ringBeforeStartsHeading => 'AFGAAN VOOR HET BEGIN';

  @override
  String get ringWhenStarts => 'Afgaan als het begint';

  @override
  String get repeatBeforeHeading => 'EN ERVOOR HERHALEN';

  @override
  String get everyPrefix => 'Elke ';

  @override
  String get offLower => 'uit';

  @override
  String get forInfix => '  gedurende ';

  @override
  String get ringAfterEndsHeading => 'AFGAAN NA HET EINDE';

  @override
  String get nameOptional => 'Naam (optioneel)';

  @override
  String get toppedUp =>
      'Wekkers staan klaar voor de komende 7 dagen en worden aangevuld als je Quando? opent.';

  @override
  String get back => 'Terug';

  @override
  String get next => 'Volgende';

  @override
  String get stepWhichEvents => 'Welke afspraken';

  @override
  String get stepWhenToRing => 'Wanneer afgaan';

  @override
  String get stepHowItRings => 'Hoe hij afgaat';

  @override
  String defaultNamed(String name) {
    return 'Standaard ($name)';
  }

  @override
  String get phoneAlarmSound => 'Wekkergeluid van de telefoon';

  @override
  String get onlineRadio => 'Online radio';

  @override
  String songLinkOpens(String app) {
    return 'Nummerlink · opent $app';
  }

  @override
  String get builtIn => 'Ingebouwd';

  @override
  String get yourRecording => 'Jouw opname';

  @override
  String get sound => 'Geluid';

  @override
  String get wakeToOwnSound => 'Word wakker met je eigen geluid';

  @override
  String get wakeToOwnSoundHint => 'Je stem, een nummer, Spotify of live radio';

  @override
  String musicAdded(String name) {
    return '$name toegevoegd. Kies het als geluid voor elke wekker.';
  }

  @override
  String get playlists => 'Afspeellijsten';

  @override
  String get likedSongs => 'Leuke nummers';

  @override
  String get noPlaylists => 'Nog geen afspeellijsten.';

  @override
  String get noLikedSongs => 'Nog geen leuke nummers.';

  @override
  String get needsMic => 'Quando? heeft de microfoon nodig om op te nemen.';

  @override
  String recordingN(int n) {
    return 'Opname $n';
  }

  @override
  String couldNotAddFile(String error) {
    return 'Kon dat bestand niet toevoegen: $error';
  }

  @override
  String get addSongLink => 'Nummerlink toevoegen';

  @override
  String get songLink => 'Nummerlink';

  @override
  String get songLinkHowTo =>
      'Tik in Spotify, Apple Music, YouTube, YouTube Music of SoundCloud op Delen, dan Link kopiëren, en plak hem hier.';

  @override
  String get songNameHint => 'Naam, bijv. Ochtendlijst';

  @override
  String get whenAlarmGoesOffHeading => 'ALS DE WEKKER AFGAAT';

  @override
  String get playTheSong => 'Nummer afspelen';

  @override
  String get ringThenOpen => 'Afgaan, dan openen';

  @override
  String get playTheSongHint =>
      'De app ervan opent en speelt het. Blijft het 10 seconden stil, dan gaat het reservegeluid af, zodat je altijd wakker wordt. Wekkers met een taak gaan eerst af en openen het daarna.';

  @override
  String get ringThenOpenHint => 'Het reservegeluid gaat af. Stop opent het nummer in zijn app.';

  @override
  String get playForHeading => 'AFSPELEN GEDURENDE';

  @override
  String get pausesAfter => 'Quando? pauzeert het nummer na deze tijd, met de pauzetoets van de telefoon.';

  @override
  String get backupSoundHeading => 'RESERVEGELUID';

  @override
  String get notALink => 'Dat lijkt geen link.';

  @override
  String songOn(String app) {
    return 'Nummer op $app';
  }

  @override
  String get theWeb => 'het web';

  @override
  String get pickFromYouTube => 'Kiezen uit mijn YouTube';

  @override
  String get youTubeAndMusic => 'YouTube en YouTube Music';

  @override
  String get youTubeOn => 'Verbonden · houd vast om uit te loggen';

  @override
  String get youTubeSignIn => 'Inloggen met Google';

  @override
  String get addSongLinkInstead => 'Voeg in plaats daarvan een nummerlink toe.';

  @override
  String get googleSignInFailed => 'Inloggen bij Google is niet gelukt. Probeer het opnieuw.';

  @override
  String get myYouTube => 'Mijn YouTube';

  @override
  String get spotifyDirectOn => 'Spotify direct afspelen staat aan';

  @override
  String get spotifyDirect => 'Spotify direct afspelen';

  @override
  String get spotifyDirectOnHint => 'Aan · tik om uit te zetten';

  @override
  String get spotifyDirectHint => 'Speelt precies het nummer. Premium nodig.';

  @override
  String get spotifyComingSoon => 'Binnenkort · Premium nodig';

  @override
  String get spotifyFailed =>
      'Spotify maakte geen verbinding. Controleer of de Spotify-app geïnstalleerd is, je ingelogd bent en Premium hebt.';

  @override
  String get nameThisSound => 'Geef dit geluid een naam';

  @override
  String get sounds => 'Geluiden';

  @override
  String get soundsSentence => 'Word wakker met je eigen stem, een nummer, een afspeellijst of live radio.';

  @override
  String stopTimer(String time) {
    return 'Stop · $time';
  }

  @override
  String get record => 'Opnemen';

  @override
  String get addAFile => 'Bestand toevoegen';

  @override
  String get addSongLinkLong => 'Nummerlink toevoegen (Spotify, Apple Music, YouTube…)';

  @override
  String get musicAppsHeading => 'MUZIEKAPPS';

  @override
  String get pickFromSpotify => 'Kiezen uit mijn Spotify';

  @override
  String get yourPlaylistsAndLiked => 'Je afspeellijsten en leuke nummers';

  @override
  String get mySpotify => 'Mijn Spotify';

  @override
  String get spotifySignInFailed => 'Kon niet inloggen bij Spotify.';

  @override
  String get appleMusicNote => 'Inloggen komt met de iPhone-versie. Voeg voorlopig een nummerlink toe.';

  @override
  String noSignInNote(String service) {
    return '$service laat andere apps niet inloggen. Voeg in plaats daarvan een nummerlink toe.';
  }

  @override
  String get wakeToRadio => 'Word wakker met online radio';

  @override
  String get soundsExplain =>
      'Neem tot 5 minuten op, voeg een bestand, songlink of live radio toe. Gaat er iets mis, dan klinkt een reservegeluid.';

  @override
  String get yourSoundsHeading => 'JOUW GELUIDEN';

  @override
  String playsIn(String app) {
    return 'Speelt in $app';
  }

  @override
  String opensIn(String app) {
    return 'Opent in $app';
  }

  @override
  String forSpan(String span) {
    return 'gedurende $span';
  }

  @override
  String get defaultLabel => 'Standaard';

  @override
  String get radioUnreachable => 'Kon de zenderlijst niet bereiken. Controleer je verbinding.';

  @override
  String get addStreamAddress => 'Streamadres toevoegen';

  @override
  String get notAStream => 'Dat lijkt geen streamadres (begint met http).';

  @override
  String get anyGenre => 'Elk genre';

  @override
  String get stationName => 'Naam van de zender';

  @override
  String get closeSearch => 'Zoeken sluiten';

  @override
  String get searchByName => 'Zoeken op naam';

  @override
  String get anywhere => 'Overal';

  @override
  String get noStations => 'Geen zenders gevonden. Probeer een ander genre of land.';

  @override
  String wakeUpTo(String name) {
    return 'Word wakker met $name';
  }

  @override
  String get notQuite => 'Bijna. Probeer opnieuw.';

  @override
  String shabbatStopsItself(int n) {
    return 'Sjabbatmodus: stopt vanzelf over $n seconden. Je hoeft de telefoon niet aan te raken.';
  }

  @override
  String get solveToSnooze => 'LOS OP OM TE SNOOZEN';

  @override
  String get solveToStop => 'LOS OP OM TE STOPPEN';

  @override
  String get answer => 'Antwoord';

  @override
  String get snooze => 'Snooze';

  @override
  String get stop => 'Stop';

  @override
  String get shakeToSnooze => 'SCHUD OM TE SNOOZEN';

  @override
  String get shakeToStop => 'SCHUD OM TE STOPPEN';

  @override
  String get shakeHard => 'Schud de telefoon flink tot de balk vol is.';

  @override
  String get cantShake => 'Kun je niet schudden? Los een som op';

  @override
  String get pairsToSnooze => 'ZOEK DE PAREN OM TE SNOOZEN';

  @override
  String get pairsToStop => 'ZOEK DE PAREN OM TE STOPPEN';

  @override
  String get typeToSnooze => 'TYP DIT OM TE SNOOZEN';

  @override
  String get typeToStop => 'TYP DIT OM TE STOPPEN';

  @override
  String get scanToSnooze => 'SCAN JE CODE OM TE SNOOZEN';

  @override
  String get scanToStop => 'SCAN JE CODE OM TE STOPPEN';

  @override
  String ringAgainUnless(int n) {
    return 'Ik ga over $n minuten opnieuw af, tenzij je hieronder tikt.';
  }

  @override
  String get imUp => 'Ik ben wakker';

  @override
  String snoozeMin(int n) {
    return 'Snooze $n min';
  }

  @override
  String snoozeMinLeft(int n, int left) {
    return 'Snooze $n min · nog $left';
  }

  @override
  String get noSnoozesLeft => 'Geen snoozes meer';

  @override
  String get stopThenOpen => 'Stop · dan openen';

  @override
  String get startingSong => 'Je nummer wordt gestart';

  @override
  String wayToStop(String way) {
    return '$way om te stoppen';
  }

  @override
  String wayToSnooze(String way) {
    return '$way om te snoozen';
  }

  @override
  String ringsForMore(int n) {
    return 'Gaat nog $n seconden af';
  }

  @override
  String get leftToRing => 'te gaan';

  @override
  String get wayVolumeButtons => 'Volumeknoppen';

  @override
  String get wayShake => 'Telefoon schudden';

  @override
  String get taskNothing => 'Niets';

  @override
  String get taskSum => 'Los een som op';

  @override
  String get taskShake => '30 keer schudden';

  @override
  String get taskMemory => 'Geheugenspel';

  @override
  String get taskPhrase => 'Typ een zin';

  @override
  String get taskScan => 'Scan een code';

  @override
  String get noLimit => 'geen limiet';

  @override
  String upToTimes(int n) {
    return 'tot $n×';
  }

  @override
  String shorterEachTime(int n) {
    return 'elke keer $n min korter';
  }

  @override
  String autoSnoozeAfter(int n) {
    return 'snoozet vanzelf na $n min';
  }

  @override
  String get card => 'Kaart';

  @override
  String get hiddenCard => 'Verborgen kaart';

  @override
  String get phrase1 => 'Ik ben wakker en de dag is van mij';

  @override
  String get phrase2 => 'Als niet nu, wanneer dan';

  @override
  String get phrase3 => 'Goedemorgen aan mij en iedereen van wie ik hou';

  @override
  String get phrase4 => 'Mijn voeten staan op de vloer en ik ben op';

  @override
  String get phrase5 => 'Vandaag begin ik opnieuw';

  @override
  String get notQuiteWords => 'Bijna, controleer elk woord.';

  @override
  String get typeItHere => 'Typ het hier';

  @override
  String get differentCode => 'Dat is een andere code.';

  @override
  String get cameraUnavailable => 'De camera is niet beschikbaar.';

  @override
  String get cantScan => 'Kun je niet scannen? Los een som op';

  @override
  String get saveCodeToScan => 'Sla een code op om te scannen';

  @override
  String get saveCodeHint =>
      'Richt op een streepjes- of QR-code ergens waar je heen moet lopen, zoals een doos in de keuken of tandpasta in de badkamer. Om de wekker te stoppen scan je hem opnieuw.';

  @override
  String get cameraUnavailableSettings =>
      'De camera is niet beschikbaar. Sta cameratoegang toe in Instellingen.';

  @override
  String gentleToGo(int n) {
    return 'Zacht wakker worden · nog $n min';
  }

  @override
  String previewBody(String body) {
    return 'Voorbeeld · $body';
  }

  @override
  String snoozedBody(String body) {
    return 'Gesnoozed: $body';
  }

  @override
  String get areYouUp => 'Ben je wakker?';

  @override
  String get tapImUp => 'Tik op “Ik ben wakker” om te stoppen';

  @override
  String get volume => 'Volume';

  @override
  String get wakeCheckOn => 'Wakker-check aan';

  @override
  String get stopsAtOnce => 'Stopt meteen';

  @override
  String get ringsAgainIfNotUp => 'Gaat opnieuw af als je niet op bent';

  @override
  String get openAppAfter => 'Daarna een app openen';

  @override
  String get noTask => 'Geen taak';

  @override
  String get codeSaved => 'Code opgeslagen';

  @override
  String get tapToSaveDifferent => 'Tik om een andere op te slaan';

  @override
  String get controlsHeading => 'BEDIENING';

  @override
  String get onScreen => 'Op het scherm';

  @override
  String get taskHeading => 'TAAK';

  @override
  String get none => 'Geen';

  @override
  String get snoozeSentence => 'Nog vijf minuutjes? Kies hoe lang, hoe vaak en wat ervoor nodig is.';

  @override
  String get settingsHeading => 'INSTELLINGEN';

  @override
  String get snoozeTime => 'Snoozetijd';

  @override
  String get snoozeTimeHint => 'Hoe lang de eerste snooze duurt';

  @override
  String get shortenSnoozes => 'Latere snoozes korter maken';

  @override
  String get shortenSnoozesHint => 'Elke snooze na de eerste is zoveel korter';

  @override
  String get autoSnooze => 'Automatisch snoozen';

  @override
  String get autoSnoozeHint => 'Als je hem niet aanraakt, snoozet hij vanzelf na';

  @override
  String get never => 'Nooit';

  @override
  String get snoozeLimit => 'Snoozelimiet';

  @override
  String get snoozeLimitHint => 'Hoe vaak je kunt snoozen';

  @override
  String get unlimited => 'Onbeperkt';

  @override
  String get useSnoozeFromSettings => 'Snooze uit Instellingen gebruiken';

  @override
  String get stopSentence => 'Hoe je de wekker uitzet en wat je eerst moet doen.';

  @override
  String get shabbatNoTask =>
      'Op sjabbat en feestdagen stoppen wekkers vanzelf en vragen ze nooit om een taak.';

  @override
  String get volumeSentence => 'Hoe hard hij afgaat en hoe zacht hij daar komt.';

  @override
  String get openAfterAlarm => 'Openen na de wekker';

  @override
  String get pickAnApp => 'Kies een app';

  @override
  String get orPasteLink => 'Of plak een link: https://…';

  @override
  String get useThisLink => 'Deze link gebruiken';

  @override
  String get noAppsFound => 'Geen apps gevonden.';

  @override
  String get weather => 'Weer';

  @override
  String get news => 'Nieuws';

  @override
  String get usePhoneVolume => 'Wekkervolume van de telefoon gebruiken';

  @override
  String get setsPhoneVolume =>
      'Stelt het wekkervolume van de telefoon in tijdens het afgaan en zet het daarna terug.';

  @override
  String get fadeInOff => 'Infaden uit, meteen vol volume';

  @override
  String fadeInOver(String span) {
    return 'Wordt luider in $span';
  }

  @override
  String get fadeOutOff => 'Uitfaden uit';

  @override
  String fadeOutOver(String span) {
    return 'Wordt zachter in de laatste $span';
  }

  @override
  String get fadesExplain =>
      'Uitfaden gebeurt als de wekker vanzelf stopt. Zijn de fades langer dan de wektijd, dan worden beide korter.';

  @override
  String get soundSoftChime => 'Zacht belletje';

  @override
  String get soundMorningRise => 'Ochtendgloren';

  @override
  String get soundClassicBeep => 'Klassieke piep';

  @override
  String get calmCity => 'Rustige stadsochtend';

  @override
  String get calmBirds => 'Vogels bij zonsopgang';

  @override
  String get calmWaves => 'Golven op het strand';

  @override
  String get calmRain => 'Zachte regen';

  @override
  String get calmStream => 'Bosbeekje';

  @override
  String get calmWind => 'Zachte wind';

  @override
  String get calmFire => 'Knisperend vuur';

  @override
  String get calmNight => 'Zomernacht';

  @override
  String get publicDomain => 'Publiek domein';

  @override
  String get phoneVolume => 'Telefoonvolume';

  @override
  String fadesIn(String span) {
    return 'wordt luider in $span';
  }

  @override
  String fadesOut(String span) {
    return 'wordt zachter in $span';
  }

  @override
  String get noFade => 'geen fade';

  @override
  String minSecShort(int m, int s) {
    return '$m min $s s';
  }

  @override
  String get happensRings => 'Gaat af';

  @override
  String get happensStopped => 'Je stopt hem';

  @override
  String get happensSnoozed => 'Je snoozet hem';

  @override
  String get happensAutoStopped => 'Stopt vanzelf';

  @override
  String get eventLower => 'afspraak';

  @override
  String get appTest => 'Quando?-test';

  @override
  String get pushoverConnected => 'Pushover is gekoppeld';

  @override
  String get webhookConnected => 'De webhook is gekoppeld';

  @override
  String pushoverSaid(int code, String body) {
    return 'Pushover zei $code: $body';
  }

  @override
  String couldNotReachPushover(String error) {
    return 'Kon Pushover niet bereiken ($error)';
  }

  @override
  String itAnswered(int code) {
    return 'Antwoord: $code';
  }

  @override
  String couldNotReachIt(String error) {
    return 'Kon het niet bereiken ($error)';
  }

  @override
  String get calendarNotAllowed => 'Agendatoegang is niet toegestaan.';

  @override
  String get playlist => 'Afspeellijst';

  @override
  String songCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n nummers', one: '1 nummer');
    return '$_temp0';
  }

  @override
  String get spotifySaidNo =>
      'Spotify weigerde. Vink in het Spotify-dashboard Web API aan voor Quando? en voeg je account toe onder User Management.';

  @override
  String serviceDidntAnswer(String service, int code) {
    return '$service antwoordde niet ($code).';
  }

  @override
  String get youTubeSaidNo =>
      'YouTube weigerde. Controleer of je Google-account een testgebruiker is van het Quando-project.';

  @override
  String get event => 'Afspraak';

  @override
  String eventEnds(String title) {
    return '$title (einde)';
  }

  @override
  String foundSoundsDevices(int s, int d) {
    return '$s geluiden en $d apparaten gevonden.';
  }

  @override
  String get sentCheckDevices => 'Verzonden. Kijk op je andere apparaten.';

  @override
  String sentTo(String name) {
    return 'Verzonden naar $name.';
  }

  @override
  String get zapierHowTo =>
      'Maak in Zapier een Zap die begint met “Webhooks by Zapier → Catch Hook” en plak de URL hier.';

  @override
  String get catchHookUrl => 'Catch Hook-URL';

  @override
  String get iftttHowTo =>
      'Maak in IFTTT een applet die begint met “Webhooks → Receive a web request with a JSON payload”. Gebruik hier dezelfde gebeurtenisnaam. Je sleutel staat op ifttt.com/maker_webhooks/settings.';

  @override
  String get eventName => 'Gebeurtenisnaam';

  @override
  String get webhooksKey => 'Webhooks-sleutel';

  @override
  String get webhookHowTo => 'Quando? stuurt een JSON POST naar dit adres.';

  @override
  String get connectionsSentence =>
      'Laat andere apps en apparaten weten wanneer een wekker afgaat, stopt of snoozet.';

  @override
  String get pushWhenRings => 'Melding sturen als een wekker afgaat';

  @override
  String get pushWhenRingsHint => 'Naar je andere telefoons, tablets, horloge of computer';

  @override
  String get yourUserKey => 'Je gebruikerssleutel';

  @override
  String get appToken => 'App-token';

  @override
  String get soundAndDevicesHeading => 'GELUID EN APPARATEN';

  @override
  String get loading => 'Laden…';

  @override
  String get loadFromPushover => 'Laden uit Pushover';

  @override
  String get soundItPlays => 'Geluid dat speelt';

  @override
  String get myPushoverDefault => 'Mijn Pushover-standaard';

  @override
  String get pushoverOwnSounds =>
      'Je eigen geluiden verschijnen hier nadat je ze uploadt op pushover.net/sounds.';

  @override
  String get allMyDevices => 'Al mijn apparaten';

  @override
  String get pushoverOnThisPhone =>
      'Installeer de Pushover-app ook op deze telefoon, dan gaat hij hier af met je Pushover-geluid.';

  @override
  String get priority => 'Prioriteit';

  @override
  String get priorityNormal => 'Normaal';

  @override
  String get priorityHigh => 'Hoog: negeert stille uren';

  @override
  String get priorityEmergency => 'Noodgeval: herhaalt tot bevestigd';

  @override
  String get sending => 'Versturen…';

  @override
  String get sendATest => 'Test versturen';

  @override
  String get findUserKey => 'Mijn gebruikerssleutel vinden';

  @override
  String get makeAppToken => 'App-token maken';

  @override
  String get webhooksHeading => 'ZAPIER, IFTTT EN WEBHOOKS';

  @override
  String get webhooksExplain =>
      'Start van alles als een wekker afgaat of je hem stopt: lampen aan, je wektijd bijhouden, iemand een bericht sturen.';

  @override
  String get sendWhenAlarm => 'Versturen als de wekker:';

  @override
  String get pauseOnShabbat => 'Pauzeren op sjabbat en feestdagen';

  @override
  String get pauseOnShabbatHint =>
      'Er wordt niets verstuurd voor wekkers tussen kaarsen aansteken en havdala';

  @override
  String get webhookPayloadNote =>
      'Elk bericht bevat: event (ring, stopped, snoozed, auto_stopped), title, body, time, shabbat en snoozes. Sleutels blijven op deze telefoon.';

  @override
  String get today => 'Vandaag';

  @override
  String get tomorrow => 'Morgen';

  @override
  String get notAWebAddress => 'Dat lijkt geen webadres dat begint met https://';

  @override
  String get language => 'Taal';

  @override
  String get phoneLanguage => 'Taal van de telefoon';

  @override
  String get ringQuote => 'Als niet nu, wanneer dan?';

  @override
  String get ringQuoteBy => 'Hillel';

  @override
  String get quotesTitle => 'Citaten over tijd';

  @override
  String get quotesHint =>
      'Kies waar ze vandaan komen. Eén voor elk deel van de dag; tik op het citaat voor een ander.';

  @override
  String get quotesOff => 'Uit';

  @override
  String get quoteSongs => 'Liedjes';

  @override
  String get quoteMovies => 'Films';

  @override
  String get quoteLiterature => 'Boeken en gedichten';

  @override
  String get quoteTanakh => 'Tenach (Hebreeuwse Bijbel)';

  @override
  String get quoteSages => 'Talmoed en wijzen';

  @override
  String get quoteSpeeches => 'Beroemde toespraken';

  @override
  String get quotePhilosophy => 'Filosofen';

  @override
  String get quoteProverbs => 'Spreekwoorden en gezegden';

  @override
  String get quotesAlso => 'Ook tonen';

  @override
  String get quoteCarnaval => 'Carnaval';

  @override
  String get quoteCarnavalHint => 'Liedjes en gezegden tijdens het Braziliaanse carnaval';

  @override
  String get quoteNearMe => 'Bij mij in de buurt';

  @override
  String get quoteNearMeHint => 'Dichters en dagen van waar je bent, op basis van je tijdzone en sjabbatstad';

  @override
  String get quoteSiddur => 'Siddoer (gebedenboek)';

  @override
  String weeklyParasha(String name) {
    return 'Parasja $name';
  }

  @override
  String poweredBy(String name) {
    return 'mogelijk gemaakt door $name';
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
  String get spotifyLibrarySignIn => 'Afspeellijsten, leuke nummers en zoeken';

  @override
  String get spotifyLibraryOn => 'Verbonden · houd vast om uit te loggen';

  @override
  String spotifyLoginError(String reason) {
    return 'Inloggen bij Spotify lukte niet: $reason';
  }

  @override
  String googleSignInError(String reason) {
    return 'Inloggen bij Google lukte niet: $reason';
  }

  @override
  String get searchSongsHint => 'Zoek nummers, artiesten, playlists';

  @override
  String nothingFound(String query) {
    return 'Niets gevonden voor ‘$query’.';
  }

  @override
  String get deliveryTitle => 'Melding';

  @override
  String get deliveryLocal => 'Lokaal geluid';

  @override
  String get deliveryBoth => 'Beide';

  @override
  String get deliveryConnect => 'Pushover verbinden';

  @override
  String get deliveryLoadFailed => 'Geluiden en apparaten laden mislukt. Probeer opnieuw.';

  @override
  String get deliveryBothHint => 'Het lokale geluid klinkt ook als Pushover niet werkt.';

  @override
  String get deliveryPushHint => 'Alleen Pushover. Dit apparaat moet online zijn als de melding afgaat.';

  @override
  String get deliveryFallback => 'Lokaal geluid blijft actief als Pushover is losgekoppeld of gepauzeerd.';

  @override
  String get deliveryReset => 'Bestaande instellingen gebruiken';

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
  String get tuyaSignInTitle => 'Inloggen met je Smart Life-account';

  @override
  String get tuyaSignInHint =>
      'Gebruik hetzelfde land, e-mailadres of telefoonnummer en wachtwoord als in de Smart Life- of Tuya Smart-app. Het account moet al aan je Tuya-project gekoppeld zijn. Het wachtwoord gaat alleen naar Tuya en wordt nooit opgeslagen.';

  @override
  String get tuyaCountryCode => 'Landnummer (Brazilië 55, VS 1)';

  @override
  String get tuyaAccount => 'Smart Life-e-mail of -telefoonnummer';

  @override
  String get tuyaPassword => 'Smart Life-wachtwoord';

  @override
  String get tuyaSignIn => 'Inloggen en scènes laden';

  @override
  String get tuyaRelayUrl => 'Adres van het Quando Tuya-relay (https)';

  @override
  String get tuyaRelayHint =>
      'Gebruik land, e-mailadres of telefoonnummer en wachtwoord van je Smart Life- of Tuya Smart-account. Ze gaan eenmaal naar het Tuya-relay van Quando en worden niet opgeslagen. Je moet ingelogd zijn op je Quando-account.';

  @override
  String get tuyaGoogleHint =>
      'Log je in bij Smart Life met Google of Apple? Tik in Smart Life op ‘Wachtwoord vergeten’ om een wachtwoord in te stellen en gebruik dat hier.';

  @override
  String get tuyaLinked => 'Smart Life-account gekoppeld';

  @override
  String get tuyaUnlink => 'Ontkoppelen';

  @override
  String get tuyaNeedsAccount => 'Log eerst in op je Quando-account bij Instellingen.';

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
      'Afspelen volgt de belduur van deze wekker en stopt met Stoppen of Sluimeren.';

  @override
  String get musicBackupPlaying => 'De muziek kon niet starten. Het lokale wekkergeluid speelt.';

  @override
  String desktopMusicConnect(String service) {
    return 'Koppel de $service-app';
  }

  @override
  String desktopMusicOn(String service) {
    return 'Verbonden met $service · houd vast om te ontkoppelen';
  }

  @override
  String get musicSongs => 'Nummers';

  @override
  String get noMusicSongs => 'Geen nummers gevonden in je Muziek-bibliotheek.';

  @override
  String serviceConnectUnavailable(String service) {
    return 'Voeg een $service-link toe · opent na het alarm';
  }

  @override
  String get soundCloudWidgetNote => 'Voeg een openbare link toe';

  @override
  String get youtubePlayerHint =>
      'YouTube speelt video af in een zichtbare speler. Als deze verborgen is of niet kan afspelen, gaat het lokale wekkergeluid door.';

  @override
  String get musicPreviewFailed =>
      'Dit geluid kon niet worden afgespeeld. Controleer je verbinding of probeer een ander nummer of station.';

  @override
  String get skyMoonPhase => 'Maanfase';

  @override
  String get skyMoonDetailsDisplay => 'Pagina met maanfase toevoegen';

  @override
  String get skyMoonDetailsHint => 'Veeg ernaartoe of tik op elk moment op de maankaart';

  @override
  String get moonRises => 'Opkomst';

  @override
  String get moonSets => 'Ondergang';

  @override
  String moonLunarDay(int day) {
    return 'Dag $day van 29,5 in deze maanmaand';
  }

  @override
  String get moonDetailsOpen => 'Maanfase openen';

  @override
  String get musicPlaylists => 'Muziekafspeellijsten';

  @override
  String get videoPlaylists => 'Video-afspeellijsten';

  @override
  String get likedVideos => 'Leuke video\'s';

  @override
  String get wholePlaylist => 'Wakker worden met de hele lijst';

  @override
  String get noSongsInPlaylist => 'Geen afspeelbare nummers hier.';

  @override
  String get hebrewNamesHeading => 'Spelling van parasja en maanden';

  @override
  String get hebrewNamesIsraeli => 'Israëlisch';

  @override
  String get hebrewNamesAshkenazi => 'Asjkenazisch';

  @override
  String pickFromService(String service) {
    return 'Kiezen uit mijn $service';
  }

  @override
  String get weatherTonight => 'Vanavond';

  @override
  String get weatherTomorrowMorning => 'Morgenochtend';

  @override
  String weatherUntilAbout(String time) {
    return 'tot ongeveer $time';
  }

  @override
  String get weatherSunBehindClouds => 'Zon achter de wolken';

  @override
  String get keysLockTitle => 'Sleutels op je apparaten';

  @override
  String get keysLockOff =>
      'Je dienstsleutels blijven op dit apparaat. Kies een sync-wachtzin om ze versleuteld naar je andere apparaten te sturen.';

  @override
  String get keysLockOn =>
      'Je dienstsleutels worden met je sync-wachtzin versleuteld voordat ze dit apparaat verlaten. Niemand anders, zelfs Google niet, kan ze lezen.';

  @override
  String get keysLockWaiting =>
      'Sleutels van je andere apparaat zijn hier vergrendeld aangekomen. Typ je sync-wachtzin om ze te openen.';

  @override
  String get keysSetPassphrase => 'Wachtzin kiezen';

  @override
  String get keysChangePassphrase => 'Wachtzin wijzigen';

  @override
  String get keysUnlock => 'Sleutels ontgrendelen';

  @override
  String get keysStartOver => 'Vergeten? Opnieuw beginnen';

  @override
  String get keysStartOverHint =>
      'Opnieuw beginnen stuurt de sleutels van dit apparaat met een nieuwe wachtzin. Je andere apparaten vragen om de nieuwe.';

  @override
  String get keysPassphrase => 'Sync-wachtzin';

  @override
  String get keysPassphraseAgain => 'Typ hem nog eens';

  @override
  String keysPassphraseShort(int count) {
    return 'Gebruik minstens $count tekens.';
  }

  @override
  String get keysPassphraseMismatch => 'Ze komen niet overeen.';

  @override
  String get keysPassphraseWrong => 'Die wachtzin opent deze sleutels niet.';

  @override
  String get keysPassphraseNote =>
      'Schrijf hem op: als je hem vergeet, kan niemand hem herstellen en typ je je sleutels opnieuw.';

  @override
  String get keysShareNeedsPassphrase => 'Kies eerst een sync-wachtzin, onder Sleutels op je apparaten.';

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
      'Quando? kan voor en na afspraken in je agenda\'s afgaan. Kies waar ze vandaan komen.';

  @override
  String get deviceCalendarsHeading => 'OP DIT APPARAAT';

  @override
  String get deviceCalendarsTitle => 'Agenda-app van dit apparaat';

  @override
  String get deviceCalendarsHint =>
      'Alle accounts erop: Google, Samsung, Outlook, iCloud en agenda\'s die alleen hier staan.';

  @override
  String get googleCalendarHeading => 'GOOGLE AGENDA';

  @override
  String get googleCalendarSignIn =>
      'Log in met Google om je agenda\'s rechtstreeks bij Google te lezen, ook als je Google-account niet op dit apparaat staat.';

  @override
  String googleCalendarSignedIn(String email) {
    return 'Ingelogd als $email';
  }

  @override
  String get googleCalendarSignOut => 'Uitloggen';

  @override
  String get googleCalendarNotHere =>
      'Inloggen met Google kan nog niet op dit apparaat. Voeg je Google-account toe in de instellingen van het apparaat (Agenda › Accounts) en de agenda\'s verschijnen onder dit apparaat.';

  @override
  String get googleCalendarUnreachable =>
      'Google Agenda is nu niet bereikbaar. Wekkers die er al uit zijn gezet, gaan gewoon af.';

  @override
  String get googleCalendarTwiceHint =>
      'Agenda\'s van hetzelfde Google-account die dit apparaat al toont, staan eerst uit, zodat niets twee keer afgaat.';

  @override
  String get timersTitle => 'Timers';

  @override
  String get timerStopwatch => 'Stopwatch';

  @override
  String get timerCountdown => 'Timer';

  @override
  String get timerSequence => 'Klaar';

  @override
  String get timerStopwatchSub => 'Telt op, met rondes';

  @override
  String get timerCountdownSub => 'Telt af, gaat af bij nul';

  @override
  String get timerSequenceSub => 'Gesproken start en markeringen';

  @override
  String get timerStart => 'Start';

  @override
  String get timerPause => 'Pauze';

  @override
  String get timerResume => 'Hervatten';

  @override
  String get timerReset => 'Resetten';

  @override
  String get timerLap => 'Ronde';

  @override
  String get timerTimesUp => 'De tijd is om';

  @override
  String get timerSetTime => 'Stel de tijd in';

  @override
  String get timerMinutes => 'Minuten';

  @override
  String get timerSeconds => 'Seconden';

  @override
  String get seqOnYourMarks => 'Op uw plaatsen';

  @override
  String get seqGetSet => 'Klaar';

  @override
  String get seqGo => 'Af!';

  @override
  String get seqFinish => 'Tijd!';

  @override
  String get seqReady => 'Gereed';

  @override
  String get seqSettings => 'Instellingen';

  @override
  String get seqStartCalls => 'Aanroepen voor de start';

  @override
  String get seqStartCallsHelp => 'Hardop gezegd vóór Af, teruggeteld vanaf de start.';

  @override
  String seqCallBefore(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n seconden ervoor',
      one: '1 seconde ervoor',
    );
    return '$_temp0';
  }

  @override
  String get seqAddCall => 'Aanroep toevoegen';

  @override
  String get seqCallText => 'Wat te zeggen';

  @override
  String get seqGoText => 'Bij de start zeggen';

  @override
  String get seqFinishText => 'Aan het einde zeggen';

  @override
  String get seqLength => 'Duur';

  @override
  String get seqNoLimit => 'Geen limiet';

  @override
  String get seqSayEvery => 'Zeg de tijd elke';

  @override
  String get seqOff => 'Uit';

  @override
  String seqEverySeconds(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n seconden', one: '1 seconde');
    return '$_temp0';
  }

  @override
  String seqEveryMinutes(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n minuten', one: '1 minuut');
    return '$_temp0';
  }

  @override
  String get seqFinalCount => 'Tel de laatste af';

  @override
  String get seqMarks => 'Jouw markeringen';

  @override
  String get seqAddMark => 'Markering toevoegen';

  @override
  String seqMarkAt(String time) {
    return 'Om $time';
  }

  @override
  String get seqSpeak => 'Hardop spreken';

  @override
  String get seqBeeps => 'Pieptonen en trilling';

  @override
  String get seqSayRemaining => 'Zeg de resterende tijd, niet de verstreken tijd';

  @override
  String get seqPresets => 'Voorinstellingen';

  @override
  String get seqPresetRace => 'Racestart';

  @override
  String get seqPresetSprint => 'Inspanning van 30 s';

  @override
  String get seqPresetRound => 'Ronde van 1 min';

  @override
  String get seqHintNoLimit => 'Na Af telt hij op tot je stopt.';

  @override
  String get seqHintLength => 'Na Af telt hij af tot nul.';

  @override
  String get seqWords => 'Woorden';

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
  String get homeClockSize => 'Klok op het beginscherm';

  @override
  String get sizeSmall => 'Klein';

  @override
  String get sizeMedium => 'Middel';

  @override
  String get sizeLarge => 'Groot';

  @override
  String get homeLayout => 'Indeling startscherm';

  @override
  String get homeLayoutClassic => 'Klassiek';

  @override
  String get homeLayoutCards => 'Kaarten';

  @override
  String get homeCardsHint =>
      'Sleep een kaart om hem te verplaatsen. Sleep de rand of hoek om de grootte te wijzigen, of kies een maat.';

  @override
  String get homeAddCard => 'Kaart toevoegen';

  @override
  String get homeOnHome => 'Op startscherm';

  @override
  String get homeRemoveCard => 'Verwijderen';

  @override
  String get cardNext => 'Volgende wekker';

  @override
  String get cardClock => 'Klok en datum';

  @override
  String get cardSky => 'Zon, maan en weer';

  @override
  String get cardMoon => 'Maan';

  @override
  String get cardWeather => 'Weer';

  @override
  String get cardAlarms => 'Je wekkers';

  @override
  String get cardQuick => 'Snelle wekkers';

  @override
  String get cardTools => 'Stopwatch, timer en klaar';

  @override
  String get cardWorld => 'Wereldklokken';

  @override
  String get cardWeek => 'Deze week';

  @override
  String get cardShabbat => 'Sjabbat en feestdagen';

  @override
  String get ringAtEventReminders => 'Afgaan bij de eigen herinneringen van het afspraak';

  @override
  String get ringAtEventRemindersHint =>
      'De herinneringen uit je agenda-app gaan hier af als luide wekkers, met het geluid van deze wekker.';

  @override
  String get atEventReminders => 'bij de herinneringen van de afspraak';

  @override
  String get everyEventReminderLoud => 'Luid afgaan bij de herinneringen van elke afspraak';

  @override
  String get loudNotificationsHeading => 'LUIDE AGENDAMELDINGEN';

  @override
  String get loudNotificationsTitle => 'Agendameldingen luid maken';

  @override
  String get loudNotificationsHint =>
      'Toont een agenda-app een herinnering, dan laat Quando? die afgaan als wekker, ook als je telefoon op stil staat.';

  @override
  String get loudNotificationsDisclosureTitle => 'Quando? agendameldingen laten lezen?';

  @override
  String get loudNotificationsDisclosure =>
      'Om je agendaherinneringen luid te laten afgaan, heeft Quando? toegang tot meldingen nodig. Het kijkt alleen naar meldingen van de agenda-apps die je kiest, leest titel en tekst op deze telefoon om ze bij de wekker te tonen, en bewaart of verstuurt ze nooit. Je kunt dit altijd uitzetten.';

  @override
  String get loudNotificationsAgree => 'Akkoord en doorgaan';

  @override
  String get loudNotificationsNoAccess =>
      'Toegang tot meldingen staat uit. Zet Quando? aan in de lijst die opent.';

  @override
  String get loudNotificationsAllow => 'Toestaan';

  @override
  String get loudNotificationsNoApps => 'Geen ondersteunde agenda-app gevonden op deze telefoon.';

  @override
  String get loudNotificationsTwiceNote => 'Afspraken met al een Quando?-agendawekker gaan maar één keer af.';

  @override
  String get loudNotificationsShabbatNote => 'Stil tijdens sjabbat en feestdagen.';

  @override
  String get busyMode => 'Bezet-modus';

  @override
  String get busyModeSubtitle => 'Niet storen en automatische antwoorden als je bezet bent';

  @override
  String get busyIntro =>
      'Terwijl je bezet bent, kan Quando? je telefoon stil zetten en berichten voor je beantwoorden. Wekkers gaan gewoon af.';

  @override
  String get busyIosFocus =>
      'Op iPhone en iPad kunnen apps geen focus aanzetten of berichten beantwoorden. Maak in de Opdrachten-app een automatisering \"Als Quando? opent\" of op een tijdstip die een focus aanzet, en laat die focus automatisch antwoorden.';

  @override
  String get busyWhileHeading => 'TERWIJL JE BEZET BENT';

  @override
  String get busyDnd => 'Niet storen';

  @override
  String get busyDndHint =>
      'Alleen prioriteit: oproepen en berichten stil, wekkers gaan af. Daarna weer normaal.';

  @override
  String get busyDndNoAccess => 'Quando? mag Niet storen nog niet wijzigen.';

  @override
  String get busyReplies => 'Berichten beantwoorden';

  @override
  String get busyRepliesHint =>
      'Eén keer per persoon, met jouw tekst, via de Beantwoorden-knop van de app. Alleen Android.';

  @override
  String get busyRepliesDisclosureTitle => 'Quando? berichten laten beantwoorden?';

  @override
  String get busyRepliesDisclosure =>
      'Om voor je te antwoorden, heeft Quando? toegang tot meldingen nodig. Alleen terwijl je bezet bent, kijkt het naar berichtmeldingen van de gekozen apps, leest de naam van de afzender op deze telefoon en stuurt je tekst één keer via de Beantwoorden-knop van de app. Berichten worden nooit bewaard of ergens anders heen gestuurd. Groepen worden overgeslagen, tenzij je ze toestaat.';

  @override
  String get busyReplyText => 'Je antwoord';

  @override
  String busyReplyTextHint(String until) {
    return '$until wordt de tijd waarop bezet-modus eindigt.';
  }

  @override
  String busyReplyDefault(String until) {
    return 'Ik ben nu bezet en antwoord na $until.';
  }

  @override
  String get busyGroups => 'Ook in groepen antwoorden';

  @override
  String get busyGroupsHint => 'Uit: groepen krijgen nooit antwoord.';

  @override
  String get busyRepliesOnShabbat => 'Ook op sjabbat en feestdagen antwoorden';

  @override
  String get busyAskRabbi => 'Standaard uit. Vraag je rabbijn voor je dit voor sjabbat aanzet.';

  @override
  String get busyWhenHeading => 'WANNEER JE BEZET BENT';

  @override
  String get busyWhenHint =>
      'Zet \"Bezet tijdens deze afspraken\" aan bij een agendawekker, of \"Bezet nadat hij afgaat\" bij een wekker.';

  @override
  String get busyDuringLock => 'Bezet zolang vergrendelmodus aan staat';

  @override
  String get busyNoneComing => 'Niets bezet in de komende 7 dagen.';

  @override
  String get busyDuringEvents => 'Bezet tijdens deze afspraken';

  @override
  String get busyDuringEventsHint => 'Bezet-modus van begin tot eind van elke afspraak.';

  @override
  String get busySettings => 'Instellingen bezet-modus';

  @override
  String get busyAfterRing => 'Bezet nadat hij afgaat';

  @override
  String get busyAfterRingHint =>
      'Niet storen en automatische antwoorden voor even, bijv. sporten of een dutje.';

  @override
  String get shareCard => 'Deel je ochtend';

  @override
  String get shareCardSubtitle =>
      'De lucht en het citaat van vandaag, of je eigen foto, voor Stories en status';

  @override
  String get shareAppMissing => 'Die app staat niet op deze telefoon.';

  @override
  String get shareAsIs => 'Delen zoals het is';

  @override
  String get shareTapQuote => 'Tik op het citaat voor een ander.';

  @override
  String get shareStory => 'Story';

  @override
  String get shareSquare => 'Vierkant';

  @override
  String get shareYourWords => 'Je eigen woorden (optioneel)';

  @override
  String get shareYourWordsHint => 'In plaats van het citaat van vandaag';

  @override
  String get shareYourPhoto => 'Je foto';

  @override
  String get shareOtherPhoto => 'Andere foto';

  @override
  String get shareSkyBack => 'Toch de lucht van vandaag';

  @override
  String get shareYourVideo => 'Je video';

  @override
  String get shareInstagramStory => 'Instagram Stories';

  @override
  String get shareWhatsApp => 'WhatsApp: status of chat';

  @override
  String get shareMore => 'Meer apps';

  @override
  String get shareYouPost =>
      'Quando? opent de app met je kaart klaar. Jij kiest waar en tikt zelf op Plaatsen.';

  @override
  String get shareAndroidFirst => 'Delen komt binnenkort naar iPhone en iPad.';

  @override
  String songSaved(String name) {
    return '“$name” bewaard als wekgeluid';
  }

  @override
  String get shareToQuando => 'Deel een nummer met Quando?';

  @override
  String get shareToQuandoHint =>
      'Tik in YouTube, YouTube Music, Spotify, SoundCloud of Apple Music op Delen en dan op Quando?. Het wordt een wekgeluid dat in zijn eigen app speelt.';

  @override
  String get askOption => 'Zeg of typ het';

  @override
  String get askOptionHint => '‘Morgen om 6 uur’, ‘30 min voor zonsopgang’';

  @override
  String get askHint => 'bijv. maak me op werkdagen 30 min voor zonsopgang wakker';

  @override
  String get askListening => 'Aan het luisteren…';

  @override
  String get askNotUnderstood => 'Ik vond geen tijd. Probeer ‘7 uur op werkdagen’ of ‘over 20 minuten’.';

  @override
  String askAnswerFromCalendar(String name) {
    return 'Uit je agenda ‘$name’';
  }

  @override
  String get askAnswerBuiltIn => 'Quando?\'s eigen tijden voor je stad';

  @override
  String get askNoAnswer => 'Nog geen tijd gevonden.';

  @override
  String get askNoSpeech => 'Spraak is niet beschikbaar op dit apparaat. Je kunt typen.';

  @override
  String get askShabbatOff => 'Zet Sjabbat aan in Instellingen zodat sjabbattijden afgaan.';

  @override
  String askSaved(String what) {
    return 'Bewaard: $what';
  }

  @override
  String get askMic => 'Spreek';

  @override
  String get askMorning => 'Ochtend';

  @override
  String get askEvening => 'Avond';

  @override
  String get askUnsure => 'Misschien heb ik iets gemist. Controleer het voor je opslaat.';

  @override
  String get askTeach => 'Leer me dit';

  @override
  String askTaught(String phrase, String time) {
    return 'Begrepen: ‘$phrase’ betekent nu $time.';
  }

  @override
  String get askSkipAction => 'Overslaan';

  @override
  String get askNoMatch => 'Geen wekker past daarbij.';

  @override
  String askTurnedOff(String what) {
    return 'Uitgezet: $what';
  }

  @override
  String askSkipped(String what) {
    return 'Overgeslagen: $what';
  }

  @override
  String askEventPlan(String offset, String event) {
    return '$offset ‘$event’ in je agenda';
  }

  @override
  String askEventNoCalendar(String event) {
    return 'Koppel een agenda zodat Quando? ‘$event’ kan vinden.';
  }

  @override
  String askSnoozeAll(int minutes) {
    return 'Snooze: $minutes min, voor alle wekkers';
  }

  @override
  String askWakeWith(String sound) {
    return 'Wekt je met $sound';
  }

  @override
  String get askReadAs => 'Gelezen als';
}
