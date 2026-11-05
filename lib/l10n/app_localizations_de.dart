// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get undo => 'Rückgängig';

  @override
  String duplicatedNamed(String name) {
    return '„$name“ dupliziert';
  }

  @override
  String deletedNamed(String name) {
    return '„$name“ gelöscht';
  }

  @override
  String get when => 'Wann?';

  @override
  String get newAtTime => 'Zu einer Uhrzeit';

  @override
  String get newAtTimeHint => 'Jeden Werktag um 7:00, einmal um 15:30…';

  @override
  String get newAroundEvent => 'Rund um ein Ereignis';

  @override
  String get newAroundEventHint =>
      'Kalender, Schabbat- und Sonnenzeiten durchsuchen, dann vorher, pünktlich oder danach klingeln';

  @override
  String get editThisAlarm => 'Diesen Wecker bearbeiten';

  @override
  String editNamed(String name) {
    return '„$name“ bearbeiten';
  }

  @override
  String get preset => 'Vorlage';

  @override
  String get editThisCalendarRule => 'Diese Kalenderregel bearbeiten';

  @override
  String get ringThisOneAfterAll => 'Doch klingeln lassen';

  @override
  String get skipJustThisOne => 'Nur diesen überspringen';

  @override
  String get renameGroup => 'Gruppe umbenennen';

  @override
  String quickSet(String label, String time) {
    return '$label · klingelt um $time';
  }

  @override
  String get newAlarm => 'Neuer Wecker';

  @override
  String get appName => 'Quando?';

  @override
  String get lockMode => 'Sperrmodus';

  @override
  String get calendars => 'Kalender';

  @override
  String get settings => 'Einstellungen';

  @override
  String get nextAlarmHeading => 'NÄCHSTER WECKER';

  @override
  String get nothingSet => 'Nichts gestellt';

  @override
  String get tagline => 'Alles zu seiner Zeit.';

  @override
  String sunriseAt(String time) {
    return 'Sonnenaufgang $time';
  }

  @override
  String sunsetAt(String time) {
    return 'Sonnenuntergang $time';
  }

  @override
  String get alarmsMayNotRing => 'Deine Wecker klingeln vielleicht nicht';

  @override
  String get tapToFixIt => 'Zum Beheben tippen';

  @override
  String inMinutes(int minutes) {
    return 'In $minutes Min.';
  }

  @override
  String get atSunset => 'Bei Sonnenuntergang';

  @override
  String get sunset => 'Sonnenuntergang';

  @override
  String get shabbatModeIsOn => 'SCHABBATMODUS AN';

  @override
  String nextInCity(String city) {
    return 'NÄCHSTER · $city';
  }

  @override
  String get candleLighting => 'Kerzenzünden';

  @override
  String get havdalah => 'Hawdala';

  @override
  String get shabbatAndFestivals => 'Schabbat & Feiertage';

  @override
  String get yourAlarmsHeading => 'DEINE WECKER';

  @override
  String get tapWhenToAdd => 'Tippe auf Wann?, um einen Wecker hinzuzufügen.';

  @override
  String get aroundEventsHeading => 'RUND UM EREIGNISSE';

  @override
  String searchFor(String words) {
    return 'Suche: $words';
  }

  @override
  String get thisWeekHeading => 'WECKER DIESE WOCHE';

  @override
  String get noAlarmsThisWeek => 'Keine Wecker in den nächsten 7 Tagen.';

  @override
  String get alarmsSetThemselves =>
      'Die Wecker stellen sich auf diesem Handy selbst, sobald du etwas änderst.';

  @override
  String cityTime(String city) {
    return '$city-Zeit';
  }

  @override
  String get more => 'Mehr';

  @override
  String get turnOff => 'Ausschalten';

  @override
  String get turnOn => 'Einschalten';

  @override
  String get duplicate => 'Duplizieren';

  @override
  String get delete => 'Löschen';

  @override
  String get inOneHour => 'In 1 Stunde';

  @override
  String get logoLabel => 'Quando?-Logo';

  @override
  String get noTimesSet => 'Keine Zeiten';

  @override
  String get atTheMoment => 'zum Zeitpunkt';

  @override
  String timesRange(int count, String from, String to) {
    return '$count-mal · $from bis $to';
  }

  @override
  String spanDays(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n Tage', one: '1 Tag');
    return '$_temp0';
  }

  @override
  String spanHours(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n Stunden', one: '1 Stunde');
    return '$_temp0';
  }

  @override
  String spanMinutes(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n Minuten', one: '1 Minute');
    return '$_temp0';
  }

  @override
  String spanSeconds(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n Sekunden', one: '1 Sekunde');
    return '$_temp0';
  }

  @override
  String get now => 'jetzt';

  @override
  String spanBefore(String span) {
    return '$span vorher';
  }

  @override
  String spanAfter(String span) {
    return '$span danach';
  }

  @override
  String alarmCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n Wecker', one: '1 Wecker');
    return '$_temp0';
  }

  @override
  String get allOn => 'alle an';

  @override
  String get allOff => 'alle aus';

  @override
  String someOn(int n) {
    return '$n an';
  }

  @override
  String skippedBody(String body) {
    return 'Übersprungen · $body';
  }

  @override
  String timeToTime(String from, String to) {
    return '$from bis $to';
  }

  @override
  String skippedCount(int n) {
    return '$n übersprungen';
  }

  @override
  String get sunNoRiseSet => 'Die Sonne geht hier heute weder auf noch unter';

  @override
  String sunProgress(int percent) {
    return 'Die Sonne hat $percent % des Tages hinter sich';
  }

  @override
  String get sunIsDown => 'Die Sonne ist untergegangen';

  @override
  String get searchCity => 'Stadt suchen';

  @override
  String get tomorrowLower => 'morgen';

  @override
  String get yesterdayLower => 'gestern';

  @override
  String get worldClocksHeading => 'WELTUHREN';

  @override
  String get add => 'Hinzufügen';

  @override
  String cityHere(String city) {
    return '$city · hier';
  }

  @override
  String get worldClocksHint =>
      'Füge Städte hinzu, um hier ihre Uhrzeit zu sehen. Nach links wischen zum Entfernen.';

  @override
  String get groupNameHint => 'Arbeit, Kinder, Sport…';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get ok => 'OK';

  @override
  String get noGroup => 'Keine Gruppe';

  @override
  String get newGroupEllipsis => 'Neue Gruppe…';

  @override
  String get newGroup => 'Neue Gruppe';

  @override
  String secondsShort(int n) {
    return '$n s';
  }

  @override
  String minutesShort(int n) {
    return '$n Min.';
  }

  @override
  String get minutes => 'Minuten';

  @override
  String get ringFor => 'Klingeln für';

  @override
  String get seconds => 'Sekunden';

  @override
  String get oneSecondLess => '1 Sekunde weniger';

  @override
  String get oneSecondMore => '1 Sekunde mehr';

  @override
  String inDays(int d) {
    return 'in $d T';
  }

  @override
  String inDaysHours(int d, int h) {
    return 'in $d T $h Std';
  }

  @override
  String inHours(int h) {
    return 'in $h Std';
  }

  @override
  String inHoursMinutes(int h, int m) {
    return 'in $h Std $m Min';
  }

  @override
  String inMins(int m) {
    return 'in $m Min';
  }

  @override
  String placeChange(String city, String where) {
    return '$city · $where · ändern';
  }

  @override
  String get israel => 'Israel';

  @override
  String get outsideIsrael => 'außerhalb Israels';

  @override
  String get comingUpHeading => 'DEMNÄCHST';

  @override
  String get lockForShabbat => 'Handy am Schabbat sperren';

  @override
  String get lockForShabbatHint => 'Vom Kerzenzünden bis zur Hawdala, auch an Feiertagen';

  @override
  String get ownShabbatAlarmsHeading => 'DEINE SCHABBAT-WECKER';

  @override
  String get addShabbatAlarm => 'Schabbat- oder Feiertagswecker hinzufügen';

  @override
  String get readyMadeHeading => 'FERTIGE WECKER';

  @override
  String bringBackDeleted(int n) {
    return 'Gelöschte zurückholen ($n)';
  }

  @override
  String get presetsHint => 'Tippe auf einen, um seine Zeiten zu ändern. Wegwischen zum Löschen.';

  @override
  String get lockSentence =>
      'Beschränke das Handy auf Uhr und Wecker, für Schabbat oder eine konzentrierte Nacht.';

  @override
  String get lockExplain =>
      'Im gesperrten Zustand zeigt Quando? nur die Uhrzeit, den nächsten Wecker und das Ende der Sperre. Wecker funktionieren weiter, und bis zur Entsperrung lässt sich nichts ändern.';

  @override
  String get lockNowHeading => 'JETZT SPERREN';

  @override
  String get lockAutoHeading => 'AUTOMATISCH SPERREN';

  @override
  String get shabbatAndFestivalsLong => 'Schabbat und Feiertage';

  @override
  String get fromCandleToHavdalah => 'Vom Kerzenzünden bis zur Hawdala';

  @override
  String get lockCalendarWord => 'Bei Kalenderereignissen mit diesem Wort';

  @override
  String get lockCalendarWordHint => 'z. B. sperren, Prüfung, Fokus';

  @override
  String get leaveEmptyForNone => 'Leer lassen für keine';

  @override
  String get connectCalendarsFirst => 'Erst Kalender verbinden (Kalendersymbol)';

  @override
  String get openWhenLockStarts => 'Quando? öffnen, wenn eine Sperre beginnt';

  @override
  String get openWhenLockStartsHint =>
      'Ein sanfter 1-Sekunden-Ton holt Quando? nach vorn, damit es sperren kann';

  @override
  String get pinToScreen => 'Quando? am Bildschirm anheften';

  @override
  String get pinToScreenHint =>
      'Andere Apps lassen sich während der Sperre nicht öffnen. Android fragt beim ersten Mal nach.';

  @override
  String get noLocksComingUp => 'Keine Sperren geplant.';

  @override
  String get leaveLockEarly => 'Um früher zu entsperren, halte „Zum Entsperren halten“ 3 Sekunden gedrückt.';

  @override
  String get locked => 'Gesperrt';

  @override
  String get shabbatShalom => 'Schabbat Schalom';

  @override
  String get chagSameach => 'Chag Sameach';

  @override
  String get unlocksHeading => 'ENTSPERRT';

  @override
  String get nowCap => 'Jetzt';

  @override
  String get nextAlarm => 'Nächster Wecker';

  @override
  String get holdToUnlock => 'Zum Entsperren halten';

  @override
  String get calendarAlarm => 'Kalenderwecker';

  @override
  String get calendarIntro =>
      'Quando? kann vor und nach Terminen in den Kalendern deines Handys klingeln. Google Kalender ist dabei, sobald dein Google-Konto auf dem Handy ist.';

  @override
  String get connectCalendars => 'Kalender verbinden';

  @override
  String get calendarAlarmsHeading => 'KALENDERWECKER';

  @override
  String get calendarNoneYet => 'Noch keine. Starte mit diesem und passe ihn an:';

  @override
  String get fifteenBeforeEvery => '15 Minuten vor jedem Termin';

  @override
  String get useTheseCalendarsHeading => 'DIESE KALENDER VERWENDEN';

  @override
  String get noTimedEvents => 'Keine anstehenden Termine mit Uhrzeit in diesen Kalendern.';

  @override
  String get atTheStart => 'zu Beginn';

  @override
  String everyForBefore(String every, String span) {
    return 'alle $every für $span vorher';
  }

  @override
  String spanAfterItEnds(String span) {
    return '$span nach dem Ende';
  }

  @override
  String get noAlarmsChosen => 'Keine Wecker gewählt';

  @override
  String get gentleWakeUp => 'Sanftes Wecken';

  @override
  String gentleSummary(int minutes, String sound) {
    return '$minutes Min. vorher · $sound';
  }

  @override
  String get off => 'Aus';

  @override
  String get gentleSentence =>
      'Ein ruhiger Klang beginnt leise vor deinem Wecker, damit du nie aufschreckst.';

  @override
  String get gentleExplain =>
      'Er wird langsam lauter, holt dich aus dem leichten Schlaf und hört kurz vor dem Wecker auf.';

  @override
  String get startsBeforeHeading => 'BEGINNT VOR DEM WECKER';

  @override
  String get leadUpSoundHeading => 'VORKLANG';

  @override
  String get listen => 'Anhören';

  @override
  String get whoRecordedThese => 'Wer diese aufgenommen hat';

  @override
  String get done => 'Fertig';

  @override
  String get soundCredits => 'Klangnachweise';

  @override
  String yourTimeCity(String city) {
    return 'Deine Zeit ($city)';
  }

  @override
  String get anotherCity => 'Andere Stadt…';

  @override
  String get ringingIn5 => 'Klingelt in 5 Sekunden…';

  @override
  String get alarmSaved => 'Wecker gespeichert.';

  @override
  String alarmSetFor(String span) {
    return 'Wecker in $span gestellt.';
  }

  @override
  String hoursMinutesShort(int h, int m) {
    return '$h Std. $m Min.';
  }

  @override
  String get editAlarm => 'Wecker bearbeiten';

  @override
  String get previewCaps => 'VORSCHAU';

  @override
  String get saveCaps => 'SPEICHERN';

  @override
  String cityTimeForYou(String city, String time) {
    return '$city-Zeit · $time bei dir';
  }

  @override
  String repeatHeading(String repeat) {
    return 'WIEDERHOLEN · $repeat';
  }

  @override
  String get labelField => 'Bezeichnung (wird vorgelesen, wenn Sprachansage an ist)';

  @override
  String get group => 'Gruppe';

  @override
  String ringsForHeading(String span) {
    return 'KLINGELT $span';
  }

  @override
  String useDefault(String value) {
    return 'Standard verwenden ($value)';
  }

  @override
  String get save => 'Speichern';

  @override
  String get sameTime => 'gleiche Zeit';

  @override
  String get untilYouStopIt => 'Bis du ihn stoppst';

  @override
  String get alarm => 'Wecker';

  @override
  String get once => 'Einmal';

  @override
  String get everyDay => 'Täglich';

  @override
  String get weekdays => 'Werktags';

  @override
  String get weekends => 'Am Wochenende';

  @override
  String timeInCity(String time, String city) {
    return '$time $city-Zeit';
  }

  @override
  String eventsMatching(String words) {
    return 'Termine mit „$words“';
  }

  @override
  String get everyEvent => 'Jeder Termin';

  @override
  String get sunrise => 'Sonnenaufgang';

  @override
  String havdalahEndOf(String day) {
    return 'Hawdala · Ende von $day';
  }

  @override
  String get yomTov => 'Jom Tow';

  @override
  String get shabbat => 'Schabbat';

  @override
  String get presetCountdown => 'Countdown bis zum Kerzenzünden';

  @override
  String get presetHourly => 'Stündlich, ab 6 Stunden vorher';

  @override
  String get presetDailyWeek => 'Einmal täglich, in der Woche davor';

  @override
  String get presetSecondNight => 'Kerzen am zweiten Abend';

  @override
  String get presetFridayReminder => 'Erinnerung 3 Stunden vorher: Handy laden';

  @override
  String get presetFridayReminderLabel => 'Lade dein Handy und stelle die Wecker für morgen';

  @override
  String get presetSunset => 'Sonnenuntergang, und 15 Minuten vorher';

  @override
  String get pesach => 'Pessach';

  @override
  String get shavuot => 'Schawuot';

  @override
  String get roshHashanah => 'Rosch Haschana';

  @override
  String get yomKippur => 'Jom Kippur';

  @override
  String get sukkot => 'Sukkot';

  @override
  String get sheminiAtzeret => 'Schemini Azeret';

  @override
  String get simchatTorah => 'Simchat Tora';

  @override
  String get readyNotifications => 'Wecker anzeigen';

  @override
  String get readyNotificationsWhy => 'Damit Weckbildschirm und Stopp-Taste erscheinen.';

  @override
  String get readyFullScreen => 'Über dem Sperrbildschirm klingeln';

  @override
  String get readyFullScreenWhy => 'Zeigt den Wecker im Vollbild, auch bei gesperrtem Handy.';

  @override
  String get readyExact => 'Auf die Minute klingeln';

  @override
  String get readyExactWhy => 'Ohne dies klingeln Wecker eventuell ein paar Minuten zu spät.';

  @override
  String get readyBattery => 'Im Energiesparmodus weiterlaufen';

  @override
  String get readyBatteryWhy => 'Verhindert, dass das Energiesparen Wecker nachts stummschaltet.';

  @override
  String get tipXiaomi =>
      'Xiaomi-Handys: unter Einstellungen › Apps › Quando? Autostart einschalten und Akkusparmodus auf Keine Einschränkungen setzen.';

  @override
  String get tipSamsung =>
      'Samsung-Handys: unter Einstellungen › Akku › Einschränkungen der Hintergrundnutzung prüfen, dass Quando? nicht schläft.';

  @override
  String get tipHuawei =>
      'Huawei- und Honor-Handys: unter Einstellungen › Akku › App-Start Quando? auf Manuell verwalten setzen und alles erlauben.';

  @override
  String get tipOther =>
      'Auf diesem Handy: unter Einstellungen › Akku Quando? im Hintergrund erlauben und die Optimierung dafür ausschalten.';

  @override
  String get testRing => 'Testklingeln';

  @override
  String get testRingBody => 'Quando? kann dich wecken';

  @override
  String get ringsIn20 => 'Klingelt in 20 Sekunden. Sperre jetzt dein Handy und warte.';

  @override
  String get readyToRing => 'Bereit zum Klingeln';

  @override
  String get checkingPhone => 'Handy wird geprüft…';

  @override
  String get phoneReady => 'Dein Handy ist bereit, jeden Wecker pünktlich klingeln zu lassen.';

  @override
  String thingsNeedFixing(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n Punkte müssen behoben werden, sonst klingeln Wecker vielleicht nicht.',
      one: '1 Punkt muss behoben werden, sonst klingeln Wecker vielleicht nicht.',
    );
    return '$_temp0';
  }

  @override
  String get fix => 'Beheben';

  @override
  String get testIn20 => 'Testen: in 20 Sekunden klingeln';

  @override
  String get testIn20Hint =>
      'Sperre das Handy und leg es weg. Klingelt der Wecker im Vollbild, ist alles bereit.';

  @override
  String get readyToRingHint => 'Prüfen, ob dein Handy jeden Wecker pünktlich klingeln lässt';

  @override
  String get connections => 'Verbindungen';

  @override
  String get timeZoneHeading => 'ZEITZONE';

  @override
  String get followPhone => 'Dem Handy folgen';

  @override
  String followPhoneNow(String city) {
    return 'Jetzt $city. Ändert sich auf Reisen von selbst.';
  }

  @override
  String get zoneFixed => 'Fest. Wecker behalten diese Zeit auch auf Reisen.';

  @override
  String get shabbatCityHeading => 'SCHABBAT-STADT';

  @override
  String get inIsraelOneDay => 'In Israel (ein Feiertag)';

  @override
  String candleMinutesHeading(int n) {
    return 'KERZENZÜNDEN: $n MINUTEN VOR SONNENUNTERGANG';
  }

  @override
  String get endOfShabbatHeading => 'ENDE VON SCHABBAT UND FEIERTAGEN';

  @override
  String get nightfallGeonim => 'Nachteinbruch (Geonim, 8,5°)';

  @override
  String get rabbeinuTam => '72 Minuten nach Sonnenuntergang (Rabbenu Tam)';

  @override
  String get whenAlarmRingsHeading => 'WENN EIN WECKER KLINGELT';

  @override
  String get recordOrAddSounds => 'Klänge aufnehmen oder hinzufügen';

  @override
  String get ringsForThisLong => 'Klingelt so lange und hört dann von selbst auf';

  @override
  String get sameFades => 'Gleiche Überblendungen für alle Wecker';

  @override
  String get sameFadesOn => 'Ersetzt die Überblendungen jedes Weckers. Jeder behält seine Lautstärke.';

  @override
  String get sameFadesOff => 'Aus: Jeder Wecker nutzt die Überblendungen unter seiner Lautstärke.';

  @override
  String get sayItOutLoud => 'Laut ansagen';

  @override
  String get sayItOutLoudHint => 'Liest vor, wofür der Wecker ist, z. B. „Kerzenzünden, 15 Minuten vorher“';

  @override
  String get noSnooze => 'Keine Schlummerfunktion';

  @override
  String snoozeUpTo(int times, int minutes) {
    return 'Schlummern bis zu $times× à $minutes Min.';
  }

  @override
  String get wakeUpCheck => 'Wachkontrolle';

  @override
  String get wakeUpCheckHint =>
      'Klingelt nach dem Stoppen in 3 Minuten erneut, wenn du nicht „Bin wach“ tippst';

  @override
  String get solveSum => 'Rechenaufgabe zum Stoppen';

  @override
  String get provesAwake => 'Beweist, dass du wach bist';

  @override
  String get shabbatNoTasks =>
      'Am Schabbat und an Feiertagen gilt nichts davon: Wecker hören von selbst auf und verlangen nie, das Handy zu berühren.';

  @override
  String get testAlarmIn1 => 'Testwecker in 1 Minute';

  @override
  String get timesDisclaimer =>
      'Die Zeiten werden auf deinem Handy berechnet. Im Grenzfall frag deinen Rabbiner oder schau in den Gemeindekalender.';

  @override
  String get recommended => 'Empfohlen';

  @override
  String get chooseCity => 'Stadt wählen';

  @override
  String get testOnlyOnPhone => 'Testwecker funktionieren nur auf einem Handy.';

  @override
  String get testAlarm => 'Testwecker';

  @override
  String get testAlarmBody => 'So klingen deine Wecker';

  @override
  String get testAlarmIn1Set => 'Testwecker in 1 Minute. Du kannst das Handy sperren.';

  @override
  String get presetGone => 'Diese Vorlage gibt es nicht mehr.';

  @override
  String get editPreset => 'Vorlage bearbeiten';

  @override
  String get on => 'An';

  @override
  String get ringsHeading => 'KLINGELT';

  @override
  String get noTimesYet => 'Noch keine Zeiten. Unten hinzufügen.';

  @override
  String get atTheMomentItself => 'Genau zum Zeitpunkt';

  @override
  String get remove => 'Entfernen';

  @override
  String get addATime => 'Zeit hinzufügen';

  @override
  String get resetPreset => 'Auf Original zurücksetzen';

  @override
  String get skipOneHint =>
      'Um nur einen Wecker zu überspringen, tippe ihn unter „Wecker diese Woche“ auf dem Startbildschirm an.';

  @override
  String get unitMinutes => 'Minuten';

  @override
  String get unitHours => 'Stunden';

  @override
  String get unitDays => 'Tage';

  @override
  String get before => 'Vorher';

  @override
  String get after => 'Danach';

  @override
  String get oneWeek => '1 Woche';

  @override
  String daysShort(int n) {
    return '$n T';
  }

  @override
  String hoursShort(int n) {
    return '$n Std';
  }

  @override
  String get howToSearch => 'So suchst du';

  @override
  String get searchHelpWord => 'Der Titel enthält „dentist“, egal ob groß oder klein';

  @override
  String get searchHelpStar => '* steht für beliebige Buchstaben: dentist, dentures';

  @override
  String get searchHelpQuestion => '? steht für einen Buchstaben: yoga, toga';

  @override
  String get searchHelpPhrase => 'Genau diese Wortfolge';

  @override
  String get searchHelpAnd => 'Beide Wörter (AND)';

  @override
  String get searchHelpOr => 'Eins von beiden. | geht auch';

  @override
  String get searchHelpNot => 'Ausschließen. NOT und ! gehen auch';

  @override
  String get searchHelpBrackets => 'Klammern gruppieren Wörter';

  @override
  String get searchHelpEmpty => 'Leer lassen, um bei jedem Termin zu klingeln.';

  @override
  String get customTime => 'Eigene Zeit';

  @override
  String get other => 'Andere';

  @override
  String get sun => 'Sonne';

  @override
  String get calendar => 'Kalender';

  @override
  String get newEventAlarm => 'Neuer Terminwecker';

  @override
  String get eventAlarm => 'Terminwecker';

  @override
  String get findEventsHeading => 'TERMINE FINDEN';

  @override
  String get searchEventsHint => 'Suche: Zahnarzt, Sport OR Yoga, Zahn*…';

  @override
  String get alsoBuiltInTimes => 'Auch Schabbat-, Feiertags- und Sonnenzeiten';

  @override
  String get alsoBuiltInTimesHint => 'z. B. „kerzen*“, „hawdala“, „sonnenuntergang“';

  @override
  String get allMyCalendars => 'Alle meine Kalender';

  @override
  String get connectToSearch => 'Verbinde deine Kalender, um sie zu durchsuchen';

  @override
  String get searching => 'Suche…';

  @override
  String get nothingMatches60 => 'Keine Treffer in den nächsten 60 Tagen';

  @override
  String eventsIn60(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n Termine in den nächsten 60 Tagen',
      one: '1 Termin in den nächsten 60 Tagen',
    );
    return '$_temp0';
  }

  @override
  String nextRingsAt(String times, String title) {
    return 'Nächster: klingelt um $times für „$title“';
  }

  @override
  String showMoreLeft(int n) {
    return 'Mehr zeigen (noch $n)';
  }

  @override
  String get ringBeforeStartsHeading => 'VOR BEGINN KLINGELN';

  @override
  String get ringWhenStarts => 'Bei Beginn klingeln';

  @override
  String get repeatBeforeHeading => 'UND DAVOR WIEDERHOLEN';

  @override
  String get everyPrefix => 'Alle ';

  @override
  String get offLower => 'aus';

  @override
  String get forInfix => '  für ';

  @override
  String get ringAfterEndsHeading => 'NACH DEM ENDE KLINGELN';

  @override
  String get nameOptional => 'Name (optional)';

  @override
  String get toppedUp =>
      'Wecker werden für die nächsten 7 Tage gestellt und bei jedem Öffnen von Quando? ergänzt.';

  @override
  String get back => 'Zurück';

  @override
  String get next => 'Weiter';

  @override
  String get stepWhichEvents => 'Welche Termine';

  @override
  String get stepWhenToRing => 'Wann klingeln';

  @override
  String get stepHowItRings => 'Wie es klingelt';

  @override
  String defaultNamed(String name) {
    return 'Standard ($name)';
  }

  @override
  String get phoneAlarmSound => 'Weckton des Handys';

  @override
  String get onlineRadio => 'Online-Radio';

  @override
  String songLinkOpens(String app) {
    return 'Song-Link · öffnet $app';
  }

  @override
  String get builtIn => 'Eingebaut';

  @override
  String get yourRecording => 'Deine Aufnahme';

  @override
  String get sound => 'Klang';

  @override
  String get wakeToOwnSound => 'Wach auf mit deinem eigenen Klang';

  @override
  String get wakeToOwnSoundHint => 'Deine Stimme, ein Song, Spotify oder Live-Radio';

  @override
  String musicAdded(String name) {
    return '$name hinzugefügt. Wähle es als Klang für jeden Wecker.';
  }

  @override
  String get playlists => 'Playlists';

  @override
  String get likedSongs => 'Lieblingssongs';

  @override
  String get noPlaylists => 'Noch keine Playlists.';

  @override
  String get noLikedSongs => 'Noch keine Lieblingssongs.';

  @override
  String get needsMic => 'Quando? braucht das Mikrofon zum Aufnehmen.';

  @override
  String recordingN(int n) {
    return 'Aufnahme $n';
  }

  @override
  String couldNotAddFile(String error) {
    return 'Datei konnte nicht hinzugefügt werden: $error';
  }

  @override
  String get addSongLink => 'Song-Link hinzufügen';

  @override
  String get songLink => 'Song-Link';

  @override
  String get songLinkHowTo =>
      'Tippe in Spotify, Apple Music, Amazon Music, YouTube, YouTube Music oder SoundCloud auf Teilen, dann auf Link kopieren, und füge ihn hier ein.';

  @override
  String get songNameHint => 'Name, z. B. Morgen-Playlist';

  @override
  String get whenAlarmGoesOffHeading => 'WENN DER WECKER LOSGEHT';

  @override
  String get playTheSong => 'Song abspielen';

  @override
  String get ringThenOpen => 'Klingeln, dann öffnen';

  @override
  String get playTheSongHint =>
      'Seine App öffnet sich und spielt ihn. Bleibt es 10 Sekunden still, klingelt stattdessen der Ersatzklang, damit du immer aufwachst. Wecker mit Aufgabe klingeln und öffnen ihn danach.';

  @override
  String get ringThenOpenHint => 'Der Ersatzklang klingelt. Stopp öffnet den Song in seiner App.';

  @override
  String get playForHeading => 'ABSPIELEN FÜR';

  @override
  String get pausesAfter => 'Quando? pausiert den Song danach mit der Pausetaste des Handys.';

  @override
  String get backupSoundHeading => 'ERSATZKLANG';

  @override
  String get notALink => 'Das sieht nicht wie ein Link aus.';

  @override
  String songOn(String app) {
    return 'Song auf $app';
  }

  @override
  String get theWeb => 'dem Web';

  @override
  String get pickFromYouTube => 'Aus meinem YouTube wählen';

  @override
  String get youTubeAndMusic => 'YouTube und YouTube Music';

  @override
  String get youTubeOn => 'Deine Playlists und Lieblingssongs. Lange drücken zum Abmelden.';

  @override
  String get youTubeSignIn => 'Mit Google anmelden, um aus deinen Playlists und Lieblingssongs zu wählen.';

  @override
  String get addSongLinkInstead => 'Füge stattdessen einen Song-Link hinzu.';

  @override
  String get googleSignInFailed => 'Die Google-Anmeldung wurde nicht abgeschlossen. Versuch es noch mal.';

  @override
  String get myYouTube => 'Mein YouTube';

  @override
  String get spotifyDirectOn => 'Spotify-Direktwiedergabe ist an';

  @override
  String get spotifyDirect => 'Spotify-Direktwiedergabe';

  @override
  String get spotifyDirectOnHint => 'Spotify spielt genau deinen Song als Wecker. Zum Ausschalten tippen.';

  @override
  String get spotifyDirectHint =>
      'Spielt genau deinen Spotify-Song als Wecker, zuverlässiger. Braucht die Spotify-App und Spotify Premium. Zum Anmelden tippen.';

  @override
  String get spotifyComingSoon =>
      'Bald: spielt genau deinen Spotify-Song als Wecker (braucht Spotify Premium).';

  @override
  String get spotifyFailed =>
      'Spotify hat sich nicht verbunden. Prüfe, ob die Spotify-App installiert ist, du angemeldet bist und Premium hast.';

  @override
  String get nameThisSound => 'Klang benennen';

  @override
  String get sounds => 'Klänge';

  @override
  String get soundsSentence =>
      'Wach auf mit deiner eigenen Stimme, einem Song, einer Playlist oder Live-Radio.';

  @override
  String stopTimer(String time) {
    return 'Stopp · $time';
  }

  @override
  String get record => 'Aufnehmen';

  @override
  String get addAFile => 'Datei hinzufügen';

  @override
  String get addSongLinkLong => 'Song-Link hinzufügen (Spotify, Apple Music, YouTube…)';

  @override
  String get musicAppsHeading => 'MUSIK-APPS';

  @override
  String get pickFromSpotify => 'Aus meinem Spotify wählen';

  @override
  String get yourPlaylistsAndLiked => 'Deine Playlists und Lieblingssongs';

  @override
  String get mySpotify => 'Mein Spotify';

  @override
  String get spotifySignInFailed => 'Anmeldung bei Spotify fehlgeschlagen.';

  @override
  String get appleMusicNote =>
      'Die Anmeldung kommt mit der iPhone-Version. Füge bis dahin einen Song-Link hinzu.';

  @override
  String noSignInNote(String service) {
    return '$service erlaubt keine Anmeldung aus anderen Apps. Füge stattdessen einen Song-Link hinzu.';
  }

  @override
  String get wakeToRadio => 'Mit Online-Radio aufwachen';

  @override
  String get soundsExplain =>
      'Nimm deine Stimme, einen Song oder irgendetwas auf, bis zu 5 Minuten. Füge eine MP3-, M4A- oder WAV-Datei vom Handy hinzu. Verlinke einen Song oder eine Playlist: Die App spielt ihn als Wecker, mit Ersatzklang. Oder wähle einen Radiosender: Er läuft live, und klappt die Verbindung nicht, klingelt der Weckton des Handys.';

  @override
  String get yourSoundsHeading => 'DEINE KLÄNGE';

  @override
  String playsIn(String app) {
    return 'Spielt in $app';
  }

  @override
  String opensIn(String app) {
    return 'Öffnet in $app';
  }

  @override
  String forSpan(String span) {
    return 'für $span';
  }

  @override
  String get defaultLabel => 'Standard';

  @override
  String get radioUnreachable => 'Das Radioverzeichnis ist nicht erreichbar. Prüfe deine Verbindung.';

  @override
  String get addStreamAddress => 'Stream-Adresse hinzufügen';

  @override
  String get notAStream => 'Das sieht nicht wie eine Stream-Adresse aus (sie beginnt mit http).';

  @override
  String get anyGenre => 'Jedes Genre';

  @override
  String get stationName => 'Sendername';

  @override
  String get closeSearch => 'Suche schließen';

  @override
  String get searchByName => 'Nach Name suchen';

  @override
  String get anywhere => 'Überall';

  @override
  String get noStations => 'Keine Sender gefunden. Probier ein anderes Genre oder Land.';

  @override
  String wakeUpTo(String name) {
    return 'Aufwachen mit $name';
  }

  @override
  String get notQuite => 'Nicht ganz. Versuch es noch mal.';

  @override
  String shabbatStopsItself(int n) {
    return 'Schabbatmodus: hört in $n Sekunden von selbst auf. Du musst das Handy nicht berühren.';
  }

  @override
  String get solveToSnooze => 'LÖSEN ZUM SCHLUMMERN';

  @override
  String get solveToStop => 'LÖSEN ZUM STOPPEN';

  @override
  String get answer => 'Antwort';

  @override
  String get snooze => 'Schlummern';

  @override
  String get stop => 'Stopp';

  @override
  String get shakeToSnooze => 'SCHÜTTELN ZUM SCHLUMMERN';

  @override
  String get shakeToStop => 'SCHÜTTELN ZUM STOPPEN';

  @override
  String get shakeHard => 'Schüttle das Handy kräftig, bis der Balken voll ist.';

  @override
  String get cantShake => 'Schütteln geht nicht? Löse eine Rechenaufgabe';

  @override
  String get pairsToSnooze => 'FINDE DIE PAARE ZUM SCHLUMMERN';

  @override
  String get pairsToStop => 'FINDE DIE PAARE ZUM STOPPEN';

  @override
  String get typeToSnooze => 'TIPPE DAS ZUM SCHLUMMERN';

  @override
  String get typeToStop => 'TIPPE DAS ZUM STOPPEN';

  @override
  String get scanToSnooze => 'SCANNE DEINEN CODE ZUM SCHLUMMERN';

  @override
  String get scanToStop => 'SCANNE DEINEN CODE ZUM STOPPEN';

  @override
  String ringAgainUnless(int n) {
    return 'Ich klingle in $n Minuten wieder, wenn du nicht unten tippst.';
  }

  @override
  String get imUp => 'Bin wach';

  @override
  String snoozeMin(int n) {
    return 'Schlummern $n Min.';
  }

  @override
  String snoozeMinLeft(int n, int left) {
    return 'Schlummern $n Min. · noch $left';
  }

  @override
  String get noSnoozesLeft => 'Kein Schlummern mehr übrig';

  @override
  String get stopThenOpen => 'Stopp · dann öffnen';

  @override
  String get startingSong => 'Dein Song startet';

  @override
  String wayToStop(String way) {
    return '$way zum Stoppen';
  }

  @override
  String wayToSnooze(String way) {
    return '$way zum Schlummern';
  }

  @override
  String ringsForMore(int n) {
    return 'Klingelt noch $n Sekunden';
  }

  @override
  String get leftToRing => 'verbleibend';

  @override
  String get wayVolumeButtons => 'Lautstärketasten';

  @override
  String get wayShake => 'Handy schütteln';

  @override
  String get taskNothing => 'Nichts';

  @override
  String get taskSum => 'Rechenaufgabe lösen';

  @override
  String get taskShake => '30-mal schütteln';

  @override
  String get taskMemory => 'Memory';

  @override
  String get taskPhrase => 'Satz tippen';

  @override
  String get taskScan => 'Code scannen';

  @override
  String get noLimit => 'unbegrenzt';

  @override
  String upToTimes(int n) {
    return 'bis zu $n×';
  }

  @override
  String shorterEachTime(int n) {
    return 'jedes Mal $n Min. kürzer';
  }

  @override
  String autoSnoozeAfter(int n) {
    return 'schlummert nach $n Min. von selbst';
  }

  @override
  String get card => 'Karte';

  @override
  String get hiddenCard => 'Verdeckte Karte';

  @override
  String get phrase1 => 'Ich bin wach und der Tag gehört mir';

  @override
  String get phrase2 => 'Wenn nicht jetzt, wann dann';

  @override
  String get phrase3 => 'Guten Morgen an mich und alle, die ich liebe';

  @override
  String get phrase4 => 'Meine Füße stehen auf dem Boden und ich bin auf';

  @override
  String get phrase5 => 'Heute fange ich neu an';

  @override
  String get notQuiteWords => 'Nicht ganz, prüfe jedes Wort.';

  @override
  String get typeItHere => 'Hier tippen';

  @override
  String get differentCode => 'Das ist ein anderer Code.';

  @override
  String get cameraUnavailable => 'Die Kamera ist nicht verfügbar.';

  @override
  String get cantScan => 'Scannen geht nicht? Löse eine Rechenaufgabe';

  @override
  String get saveCodeToScan => 'Code zum Scannen speichern';

  @override
  String get saveCodeHint =>
      'Richte die Kamera auf einen Barcode oder QR-Code an einem Ort, zu dem du gehen musst, etwa eine Packung in der Küche oder die Zahnpasta im Bad. Zum Stoppen des Weckers scannst du ihn erneut.';

  @override
  String get cameraUnavailableSettings =>
      'Die Kamera ist nicht verfügbar. Erlaube den Kamerazugriff in den Einstellungen.';

  @override
  String gentleToGo(int n) {
    return 'Sanftes Wecken · noch $n Min.';
  }

  @override
  String previewBody(String body) {
    return 'Vorschau · $body';
  }

  @override
  String snoozedBody(String body) {
    return 'Geschlummert: $body';
  }

  @override
  String get areYouUp => 'Bist du wach?';

  @override
  String get tapImUp => 'Tippe „Bin wach“ zum Stoppen';

  @override
  String get volume => 'Lautstärke';

  @override
  String get wakeCheckOn => 'Wachkontrolle an';

  @override
  String get stopsAtOnce => 'Stoppt sofort';

  @override
  String get ringsAgainIfNotUp => 'Klingelt erneut, wenn du nicht aufstehst';

  @override
  String get openAppAfter => 'Danach eine App öffnen';

  @override
  String get noTask => 'Keine Aufgabe';

  @override
  String get codeSaved => 'Code gespeichert';

  @override
  String get tapToSaveDifferent => 'Tippen, um einen anderen zu speichern';

  @override
  String get controlsHeading => 'STEUERUNG';

  @override
  String get onScreen => 'Auf dem Bildschirm';

  @override
  String get taskHeading => 'AUFGABE';

  @override
  String get none => 'Keine';

  @override
  String get snoozeSentence => 'Noch fünf Minuten? Wähle wie lange, wie oft und was es kostet.';

  @override
  String get settingsHeading => 'EINSTELLUNGEN';

  @override
  String get snoozeTime => 'Schlummerdauer';

  @override
  String get snoozeTimeHint => 'Wie lange das erste Schlummern dauert';

  @override
  String get shortenSnoozes => 'Weiteres Schlummern verkürzen';

  @override
  String get shortenSnoozesHint => 'Jedes Schlummern nach dem ersten ist um so viel kürzer';

  @override
  String get autoSnooze => 'Auto-Schlummern';

  @override
  String get autoSnoozeHint => 'Wenn du ihn nicht berührst, schlummert er von selbst nach';

  @override
  String get never => 'Nie';

  @override
  String get snoozeLimit => 'Schlummerlimit';

  @override
  String get snoozeLimitHint => 'Wie oft du schlummern kannst';

  @override
  String get unlimited => 'Unbegrenzt';

  @override
  String get useSnoozeFromSettings => 'Schlummern aus den Einstellungen verwenden';

  @override
  String get stopSentence => 'Wie du den Wecker ausschaltest und was du vorher tun musst.';

  @override
  String get shabbatNoTask =>
      'Am Schabbat und an Feiertagen hören Wecker von selbst auf und verlangen nie eine Aufgabe.';

  @override
  String get volumeSentence => 'Wie laut er klingelt und wie sanft er dahin kommt.';

  @override
  String get openAfterAlarm => 'Nach dem Wecker öffnen';

  @override
  String get pickAnApp => 'App wählen';

  @override
  String get orPasteLink => 'Oder Link einfügen: https://…';

  @override
  String get useThisLink => 'Diesen Link verwenden';

  @override
  String get noAppsFound => 'Keine Apps gefunden.';

  @override
  String get weather => 'Wetter';

  @override
  String get news => 'Nachrichten';

  @override
  String get usePhoneVolume => 'Wecklautstärke des Handys verwenden';

  @override
  String get setsPhoneVolume => 'Stellt die Wecklautstärke des Handys beim Klingeln ein und danach zurück.';

  @override
  String get fadeInOff => 'Einblenden: aus, sofort volle Lautstärke';

  @override
  String fadeInOver(String span) {
    return 'Einblenden über $span';
  }

  @override
  String get fadeOutOff => 'Ausblenden: aus';

  @override
  String fadeOutOver(String span) {
    return 'Ausblenden über die letzten $span';
  }

  @override
  String get fadesExplain =>
      'Ausgeblendet wird, wenn der Wecker von selbst aufhört. Sind die Überblendungen länger als das Klingeln, werden beide passend gekürzt.';

  @override
  String get soundSoftChime => 'Sanftes Glockenspiel';

  @override
  String get soundMorningRise => 'Morgenröte';

  @override
  String get soundClassicBeep => 'Klassischer Piepton';

  @override
  String get calmCity => 'Ruhiger Stadtmorgen';

  @override
  String get calmBirds => 'Vögel im Morgengrauen';

  @override
  String get calmWaves => 'Wellen am Ufer';

  @override
  String get calmRain => 'Sanfter Regen';

  @override
  String get calmStream => 'Waldbach';

  @override
  String get calmWind => 'Sanfter Wind';

  @override
  String get calmFire => 'Knisterndes Feuer';

  @override
  String get calmNight => 'Sommernacht';

  @override
  String get publicDomain => 'Gemeinfrei';

  @override
  String get phoneVolume => 'Handy-Lautstärke';

  @override
  String fadesIn(String span) {
    return 'blendet in $span ein';
  }

  @override
  String fadesOut(String span) {
    return 'blendet in $span aus';
  }

  @override
  String get noFade => 'ohne Überblendung';

  @override
  String minSecShort(int m, int s) {
    return '$m Min. $s s';
  }

  @override
  String get happensRings => 'Klingelt';

  @override
  String get happensStopped => 'Du stoppst ihn';

  @override
  String get happensSnoozed => 'Du schlummerst';

  @override
  String get happensAutoStopped => 'Er hört von selbst auf';

  @override
  String get eventLower => 'Ereignis';

  @override
  String get appTest => 'Quando?-Test';

  @override
  String get pushoverConnected => 'Pushover ist verbunden';

  @override
  String get webhookConnected => 'Webhook ist verbunden';

  @override
  String pushoverSaid(int code, String body) {
    return 'Pushover meldet $code: $body';
  }

  @override
  String couldNotReachPushover(String error) {
    return 'Pushover nicht erreichbar ($error)';
  }

  @override
  String itAnswered(int code) {
    return 'Antwort $code';
  }

  @override
  String couldNotReachIt(String error) {
    return 'Nicht erreichbar ($error)';
  }

  @override
  String get calendarNotAllowed => 'Der Kalenderzugriff wurde nicht erlaubt.';

  @override
  String get playlist => 'Playlist';

  @override
  String songCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n Songs', one: '1 Song');
    return '$_temp0';
  }

  @override
  String get spotifySaidNo =>
      'Spotify hat abgelehnt. Setze im Spotify-Dashboard für Quando? ein Häkchen bei Web API und füge dein Konto unter User Management hinzu.';

  @override
  String serviceDidntAnswer(String service, int code) {
    return '$service hat nicht geantwortet ($code).';
  }

  @override
  String get youTubeSaidNo =>
      'YouTube hat abgelehnt. Prüfe, ob dein Google-Konto Testnutzer im Projekt Quando ist.';

  @override
  String get event => 'Termin';

  @override
  String eventEnds(String title) {
    return '$title (Ende)';
  }

  @override
  String foundSoundsDevices(int s, int d) {
    return '$s Klänge und $d Geräte gefunden.';
  }

  @override
  String get sentCheckDevices => 'Gesendet. Schau auf deinen anderen Geräten.';

  @override
  String sentTo(String name) {
    return 'An $name gesendet.';
  }

  @override
  String get zapierHowTo =>
      'Erstelle in Zapier einen Zap, der mit „Webhooks by Zapier → Catch Hook“ beginnt, und füge seine URL hier ein.';

  @override
  String get catchHookUrl => 'Catch-Hook-URL';

  @override
  String get iftttHowTo =>
      'Erstelle in IFTTT ein Applet, das mit „Webhooks → Receive a web request with a JSON payload“ beginnt. Verwende hier denselben Ereignisnamen. Dein Schlüssel steht auf ifttt.com/maker_webhooks/settings.';

  @override
  String get eventName => 'Ereignisname';

  @override
  String get webhooksKey => 'Webhooks-Schlüssel';

  @override
  String get webhookHowTo => 'Quando? sendet einen JSON-POST an diese Adresse.';

  @override
  String get connectionsSentence =>
      'Sag deinen anderen Apps und Geräten Bescheid, wenn ein Wecker klingelt, stoppt oder schlummert.';

  @override
  String get pushWhenRings => 'Push senden, wenn ein Wecker klingelt';

  @override
  String get pushWhenRingsHint => 'An deine anderen Handys, Tablet, Uhr oder Computer';

  @override
  String get yourUserKey => 'Dein User Key';

  @override
  String get appToken => 'App-Token';

  @override
  String get soundAndDevicesHeading => 'KLANG UND GERÄTE';

  @override
  String get loading => 'Lädt…';

  @override
  String get loadFromPushover => 'Von Pushover laden';

  @override
  String get soundItPlays => 'Abgespielter Klang';

  @override
  String get myPushoverDefault => 'Mein Pushover-Standard';

  @override
  String get pushoverOwnSounds =>
      'Eigene Klänge erscheinen hier, nachdem du sie auf pushover.net/sounds hochgeladen hast.';

  @override
  String get allMyDevices => 'Alle meine Geräte';

  @override
  String get pushoverOnThisPhone =>
      'Installiere die Pushover-App auch auf diesem Handy, dann klingelt es hier mit deinem Pushover-Klang.';

  @override
  String get priority => 'Priorität';

  @override
  String get priorityNormal => 'Normal';

  @override
  String get priorityHigh => 'Hoch: auch in Ruhezeiten';

  @override
  String get priorityEmergency => 'Notfall: wiederholt bis zur Bestätigung';

  @override
  String get sending => 'Sendet…';

  @override
  String get sendATest => 'Test senden';

  @override
  String get findUserKey => 'Meinen User Key finden';

  @override
  String get makeAppToken => 'App-Token erstellen';

  @override
  String get webhooksHeading => 'ZAPIER, IFTTT UND WEBHOOKS';

  @override
  String get webhooksExplain =>
      'Starte alles Mögliche, wenn ein Wecker klingelt oder du ihn stoppst: Licht an, Aufwachzeit notieren, jemandem schreiben.';

  @override
  String get sendWhenAlarm => 'Senden, wenn der Wecker:';

  @override
  String get pauseOnShabbat => 'An Schabbat und Feiertagen pausieren';

  @override
  String get pauseOnShabbatHint => 'Für Wecker vom Kerzenzünden bis zur Hawdala wird nichts gesendet';

  @override
  String get webhookPayloadNote =>
      'Jede Nachricht enthält: event (ring, stopped, snoozed, auto_stopped), title, body, time, shabbat und snoozes. Schlüssel bleiben auf diesem Handy.';

  @override
  String get today => 'Heute';

  @override
  String get tomorrow => 'Morgen';

  @override
  String get notAWebAddress => 'Das sieht nicht wie eine Webadresse mit https:// aus';

  @override
  String get language => 'Sprache';

  @override
  String get phoneLanguage => 'Sprache des Handys';

  @override
  String get ringQuote => 'Wenn nicht jetzt, wann dann?';

  @override
  String get ringQuoteBy => 'Hillel';

  @override
  String get quotesTitle => 'Zitate über die Zeit';

  @override
  String get quotesHint =>
      'Wähle, woher sie kommen. Eines für jede Tageszeit; tippe auf das Zitat für ein anderes.';

  @override
  String get quotesOff => 'Aus';

  @override
  String get quoteSongs => 'Lieder';

  @override
  String get quoteMovies => 'Filme';

  @override
  String get quoteLiterature => 'Bücher und Gedichte';

  @override
  String get quoteTanakh => 'Tanach (Hebräische Bibel)';

  @override
  String get quoteSages => 'Talmud und Weise';

  @override
  String get quoteSpeeches => 'Berühmte Reden';

  @override
  String get quotePhilosophy => 'Philosophen';

  @override
  String get quoteProverbs => 'Sprichwörter';

  @override
  String get quotesAlso => 'Auch zeigen';

  @override
  String get quoteCarnaval => 'Karneval';

  @override
  String get quoteCarnavalHint => 'Lieder und Sprüche zum Karneval in Brasilien';

  @override
  String get quoteNearMe => 'In meiner Nähe';

  @override
  String get quoteNearMeHint => 'Dichter und Tage deines Ortes, nach Zeitzone und Schabbat-Stadt';

  @override
  String get quoteSiddur => 'Siddur (Gebetbuch)';

  @override
  String weeklyParasha(String name) {
    return 'Parascha $name';
  }

  @override
  String poweredBy(String name) {
    return 'powered by $name';
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
}
