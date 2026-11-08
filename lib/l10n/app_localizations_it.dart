// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get undo => 'Annulla';

  @override
  String duplicatedNamed(String name) {
    return '“$name” duplicata';
  }

  @override
  String deletedNamed(String name) {
    return '“$name” eliminata';
  }

  @override
  String get when => 'Quando?';

  @override
  String get newAtTime => 'A un orario';

  @override
  String get newAtTimeHint => 'Ogni giorno feriale alle 7:00, una volta alle 15:30…';

  @override
  String get newAroundEvent => 'Intorno a un evento';

  @override
  String get newAroundEventHint =>
      'Cerca nei calendari, nello Shabbat e negli orari del sole, poi suona prima, all’ora o dopo';

  @override
  String get editThisAlarm => 'Modifica questa sveglia';

  @override
  String editNamed(String name) {
    return 'Modifica “$name”';
  }

  @override
  String get preset => 'modello';

  @override
  String get editThisCalendarRule => 'Modifica questa regola del calendario';

  @override
  String get ringThisOneAfterAll => 'Falla suonare comunque';

  @override
  String get skipJustThisOne => 'Salta solo questa';

  @override
  String get renameGroup => 'Rinomina gruppo';

  @override
  String quickSet(String label, String time) {
    return '$label · suona alle $time';
  }

  @override
  String get newAlarm => 'Nuova sveglia';

  @override
  String get appName => 'Quando?';

  @override
  String get lockMode => 'Modalità blocco';

  @override
  String get calendars => 'Calendari';

  @override
  String get settings => 'Impostazioni';

  @override
  String get nextAlarmHeading => 'PROSSIMA SVEGLIA';

  @override
  String get nothingSet => 'Niente impostato';

  @override
  String get tagline => 'Ogni cosa a suo tempo.';

  @override
  String sunriseAt(String time) {
    return 'Alba $time';
  }

  @override
  String sunsetAt(String time) {
    return 'Tramonto $time';
  }

  @override
  String get alarmsMayNotRing => 'Le tue sveglie potrebbero non suonare';

  @override
  String get tapToFixIt => 'Tocca per risolvere';

  @override
  String inMinutes(int minutes) {
    return 'Tra $minutes min';
  }

  @override
  String get atSunset => 'Al tramonto';

  @override
  String get sunset => 'Tramonto';

  @override
  String get shabbatModeIsOn => 'MODALITÀ SHABBAT ATTIVA';

  @override
  String nextInCity(String city) {
    return 'PROSSIMO · $city';
  }

  @override
  String get candleLighting => 'Accensione delle candele';

  @override
  String get havdalah => 'Havdalà';

  @override
  String get shabbatAndFestivals => 'Shabbat e feste';

  @override
  String get yourAlarmsHeading => 'LE TUE SVEGLIE';

  @override
  String get tapWhenToAdd => 'Tocca Quando? per aggiungere una sveglia.';

  @override
  String get aroundEventsHeading => 'INTORNO AGLI EVENTI';

  @override
  String searchFor(String words) {
    return 'ricerca: $words';
  }

  @override
  String get thisWeekHeading => 'SVEGLIE DI QUESTA SETTIMANA';

  @override
  String get noAlarmsThisWeek => 'Nessuna sveglia nei prossimi 7 giorni.';

  @override
  String get alarmsSetThemselves =>
      'Le sveglie si impostano da sole su questo telefono ogni volta che cambi qualcosa.';

  @override
  String cityTime(String city) {
    return 'ora di $city';
  }

  @override
  String get more => 'Altro';

  @override
  String get turnOff => 'Disattiva';

  @override
  String get turnOn => 'Attiva';

  @override
  String get duplicate => 'Duplica';

  @override
  String get delete => 'Elimina';

  @override
  String get inOneHour => 'Tra 1 ora';

  @override
  String get logoLabel => 'Logo di Quando?';

  @override
  String get noTimesSet => 'Nessun orario';

  @override
  String get atTheMoment => 'al momento';

  @override
  String timesRange(int count, String from, String to) {
    return '$count volte · da $from a $to';
  }

  @override
  String spanDays(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n giorni', one: '1 giorno');
    return '$_temp0';
  }

  @override
  String spanHours(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n ore', one: '1 ora');
    return '$_temp0';
  }

  @override
  String spanMinutes(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n minuti', one: '1 minuto');
    return '$_temp0';
  }

  @override
  String spanSeconds(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n secondi', one: '1 secondo');
    return '$_temp0';
  }

  @override
  String get now => 'ora';

  @override
  String spanBefore(String span) {
    return '$span prima';
  }

  @override
  String spanAfter(String span) {
    return '$span dopo';
  }

  @override
  String alarmCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n sveglie', one: '1 sveglia');
    return '$_temp0';
  }

  @override
  String get allOn => 'tutte attive';

  @override
  String get allOff => 'tutte disattivate';

  @override
  String someOn(int n) {
    return '$n attive';
  }

  @override
  String skippedBody(String body) {
    return 'Saltata · $body';
  }

  @override
  String timeToTime(String from, String to) {
    return '$from – $to';
  }

  @override
  String skippedCount(int n) {
    return '$n saltate';
  }

  @override
  String get sunNoRiseSet => 'Oggi qui il sole non sorge né tramonta';

  @override
  String sunProgress(int percent) {
    return 'Il sole ha percorso il $percent% della giornata';
  }

  @override
  String get sunIsDown => 'Il sole è tramontato';

  @override
  String get searchCity => 'Cerca una città';

  @override
  String get tomorrowLower => 'domani';

  @override
  String get yesterdayLower => 'ieri';

  @override
  String get worldClocksHeading => 'OROLOGI DEL MONDO';

  @override
  String get add => 'Aggiungi';

  @override
  String cityHere(String city) {
    return '$city · qui';
  }

  @override
  String get worldClocksHint =>
      'Aggiungi città per vedere qui la loro ora. Scorri a sinistra per rimuoverne una.';

  @override
  String get groupNameHint => 'Lavoro, Figli, Palestra…';

  @override
  String get cancel => 'Annulla';

  @override
  String get ok => 'OK';

  @override
  String get noGroup => 'Nessun gruppo';

  @override
  String get newGroupEllipsis => 'Nuovo gruppo…';

  @override
  String get newGroup => 'Nuovo gruppo';

  @override
  String secondsShort(int n) {
    return '$n s';
  }

  @override
  String minutesShort(int n) {
    return '$n min';
  }

  @override
  String get minutes => 'Minuti';

  @override
  String get ringFor => 'Suona per';

  @override
  String get seconds => 'Secondi';

  @override
  String get oneSecondLess => '1 secondo in meno';

  @override
  String get oneSecondMore => '1 secondo in più';

  @override
  String inDays(int d) {
    return 'tra $d g';
  }

  @override
  String inDaysHours(int d, int h) {
    return 'tra $d g $h h';
  }

  @override
  String inHours(int h) {
    return 'tra $h h';
  }

  @override
  String inHoursMinutes(int h, int m) {
    return 'tra $h h $m min';
  }

  @override
  String inMins(int m) {
    return 'tra $m min';
  }

  @override
  String placeChange(String city, String where) {
    return '$city · $where · cambia';
  }

  @override
  String get israel => 'Israele';

  @override
  String get outsideIsrael => 'fuori da Israele';

  @override
  String get comingUpHeading => 'IN ARRIVO';

  @override
  String get lockForShabbat => 'Blocca il telefono di Shabbat';

  @override
  String get lockForShabbatHint => 'Dall’accensione delle candele alla Havdalà, anche nelle feste';

  @override
  String get ownShabbatAlarmsHeading => 'LE TUE SVEGLIE DI SHABBAT';

  @override
  String get addShabbatAlarm => 'Aggiungi una sveglia di Shabbat o festa';

  @override
  String get readyMadeHeading => 'SVEGLIE PRONTE';

  @override
  String bringBackDeleted(int n) {
    return 'Recupera le eliminate ($n)';
  }

  @override
  String get presetsHint => 'Toccane una per cambiarne gli orari. Scorri per eliminarla.';

  @override
  String get lockSentence =>
      'Riduci il telefono all’orologio e alle sveglie, per lo Shabbat o una notte concentrata.';

  @override
  String get lockExplain =>
      'Mentre è bloccato, Quando? mostra solo l’ora, la prossima sveglia e la fine del blocco. Le sveglie continuano a funzionare e non si può cambiare nulla fino allo sblocco.';

  @override
  String get lockNowHeading => 'BLOCCA ORA';

  @override
  String get lockAutoHeading => 'BLOCCA AUTOMATICAMENTE';

  @override
  String get shabbatAndFestivalsLong => 'Shabbat e feste';

  @override
  String get fromCandleToHavdalah => 'Dall’accensione delle candele alla Havdalà';

  @override
  String get lockCalendarWord => 'Durante eventi del calendario con questa parola';

  @override
  String get lockCalendarWordHint => 'es. blocco, esame, concentrazione';

  @override
  String get leaveEmptyForNone => 'Lascia vuoto per nessuno';

  @override
  String get connectCalendarsFirst => 'Collega prima i calendari (icona calendario)';

  @override
  String get openWhenLockStarts => 'Apri Quando? quando inizia un blocco';

  @override
  String get openWhenLockStartsHint =>
      'Un leggero suono di 1 secondo porta Quando? in primo piano per bloccare';

  @override
  String get pinToScreen => 'Fissa Quando? sullo schermo';

  @override
  String get pinToScreenHint =>
      'Le altre app non si aprono durante il blocco. Android chiede conferma la prima volta.';

  @override
  String get noLocksComingUp => 'Nessun blocco in arrivo.';

  @override
  String get leaveLockEarly => 'Per uscire prima, tieni premuto “Tieni premuto per sbloccare” per 3 secondi.';

  @override
  String get locked => 'Bloccato';

  @override
  String get shabbatShalom => 'Shabbat shalom';

  @override
  String get chagSameach => 'Chag sameach';

  @override
  String get unlocksHeading => 'SI SBLOCCA';

  @override
  String get nowCap => 'Ora';

  @override
  String get nextAlarm => 'Prossima sveglia';

  @override
  String get holdToUnlock => 'Tieni premuto per sbloccare';

  @override
  String get calendarAlarm => 'Sveglia del calendario';

  @override
  String get calendarIntro =>
      'Quando? può suonare prima e dopo gli eventi nei calendari del telefono. Google Calendar è incluso appena il tuo account Google è sul telefono.';

  @override
  String get connectCalendars => 'Collega i calendari';

  @override
  String get calendarAlarmsHeading => 'SVEGLIE DEL CALENDARIO';

  @override
  String get calendarNoneYet => 'Ancora nessuna. Inizia con questa, poi cambiala come vuoi:';

  @override
  String get fifteenBeforeEvery => '15 minuti prima di ogni evento';

  @override
  String get useTheseCalendarsHeading => 'USA QUESTI CALENDARI';

  @override
  String get noTimedEvents => 'Nessun evento con orario in arrivo in questi calendari.';

  @override
  String get atTheStart => 'all’inizio';

  @override
  String everyForBefore(String every, String span) {
    return 'ogni $every per $span prima';
  }

  @override
  String spanAfterItEnds(String span) {
    return '$span dopo la fine';
  }

  @override
  String get noAlarmsChosen => 'Nessuna sveglia scelta';

  @override
  String get gentleWakeUp => 'Risveglio dolce';

  @override
  String gentleSummary(int minutes, String sound) {
    return '$minutes min prima · $sound';
  }

  @override
  String get off => 'Disattivato';

  @override
  String get gentleSentence =>
      'Un suono calmo inizia piano prima della sveglia, così non ti svegli mai di soprassalto.';

  @override
  String get gentleExplain =>
      'Cresce lentamente, ti porta fuori dal sonno leggero e si ferma poco prima che suoni la sveglia.';

  @override
  String get startsBeforeHeading => 'INIZIA PRIMA DELLA SVEGLIA';

  @override
  String get leadUpSoundHeading => 'SUONO DI AVVIO';

  @override
  String get listen => 'Ascolta';

  @override
  String get whoRecordedThese => 'Chi ha registrato questi suoni';

  @override
  String get done => 'Fatto';

  @override
  String get soundCredits => 'Crediti dei suoni';

  @override
  String yourTimeCity(String city) {
    return 'La tua ora ($city)';
  }

  @override
  String get anotherCity => 'Un’altra città…';

  @override
  String get ringingIn5 => 'Suona tra 5 secondi…';

  @override
  String get alarmSaved => 'Sveglia salvata.';

  @override
  String alarmSetFor(String span) {
    return 'Sveglia impostata tra $span.';
  }

  @override
  String hoursMinutesShort(int h, int m) {
    return '$h h $m min';
  }

  @override
  String get editAlarm => 'Modifica sveglia';

  @override
  String get previewCaps => 'PROVA';

  @override
  String get saveCaps => 'SALVA';

  @override
  String cityTimeForYou(String city, String time) {
    return 'ora di $city · $time per te';
  }

  @override
  String repeatHeading(String repeat) {
    return 'RIPETI · $repeat';
  }

  @override
  String get labelField => 'Etichetta (letta ad alta voce se le sveglie parlate sono attive)';

  @override
  String get group => 'Gruppo';

  @override
  String ringsForHeading(String span) {
    return 'SUONA PER $span';
  }

  @override
  String useDefault(String value) {
    return 'Usa il predefinito ($value)';
  }

  @override
  String get save => 'Salva';

  @override
  String get sameTime => 'stessa ora';

  @override
  String get untilYouStopIt => 'Finché non la fermi';

  @override
  String get alarm => 'Sveglia';

  @override
  String get once => 'Una volta';

  @override
  String get everyDay => 'Ogni giorno';

  @override
  String get weekdays => 'Giorni feriali';

  @override
  String get weekends => 'Fine settimana';

  @override
  String timeInCity(String time, String city) {
    return '$time ora di $city';
  }

  @override
  String eventsMatching(String words) {
    return 'Eventi con “$words”';
  }

  @override
  String get everyEvent => 'Ogni evento';

  @override
  String get sunrise => 'Alba';

  @override
  String havdalahEndOf(String day) {
    return 'Havdalà · fine di $day';
  }

  @override
  String get yomTov => 'Yom Tov';

  @override
  String get shabbat => 'Shabbat';

  @override
  String get presetCountdown => 'Conto alla rovescia all’accensione delle candele';

  @override
  String get presetHourly => 'Ogni ora, da 6 ore prima';

  @override
  String get presetDailyWeek => 'Una volta al giorno, nella settimana prima';

  @override
  String get presetSecondNight => 'Candele della seconda sera';

  @override
  String get presetFridayReminder => 'Promemoria 3 ore prima: ricarica il telefono';

  @override
  String get presetFridayReminderLabel => 'Ricarica il telefono e imposta le sveglie per domani';

  @override
  String get presetSunset => 'Tramonto, e 15 minuti prima';

  @override
  String get pesach => 'Pesach';

  @override
  String get shavuot => 'Shavuot';

  @override
  String get roshHashanah => 'Rosh Hashanà';

  @override
  String get yomKippur => 'Yom Kippur';

  @override
  String get sukkot => 'Sukkot';

  @override
  String get sheminiAtzeret => 'Sheminì Atzeret';

  @override
  String get simchatTorah => 'Simchat Torà';

  @override
  String get readyNotifications => 'Mostra le sveglie';

  @override
  String get readyNotificationsWhy => 'Fa comparire la schermata della sveglia e il pulsante Ferma.';

  @override
  String get readyFullScreen => 'Suona sopra la schermata di blocco';

  @override
  String get readyFullScreenWhy => 'Mostra la sveglia a schermo intero, anche col telefono bloccato.';

  @override
  String get readyExact => 'Suona al minuto esatto';

  @override
  String get readyExactWhy =>
      'Senza questo, il telefono potrebbe far suonare le sveglie con qualche minuto di ritardo.';

  @override
  String get readyBattery => 'Resta attivo col risparmio batteria';

  @override
  String get readyBatteryWhy => 'Impedisce al risparmio batteria di silenziare le sveglie di notte.';

  @override
  String get tipXiaomi =>
      'Telefoni Xiaomi: in Impostazioni › App › Quando?, attiva Avvio automatico e imposta Risparmio batteria su Nessuna restrizione.';

  @override
  String get tipSamsung =>
      'Telefoni Samsung: in Impostazioni › Batteria › Limiti di utilizzo in background, verifica che Quando? non sia in sospensione.';

  @override
  String get tipHuawei =>
      'Telefoni Huawei e Honor: in Impostazioni › Batteria › Avvio app, imposta Quando? su Gestisci manualmente e consenti tutto.';

  @override
  String get tipOther =>
      'Su questo telefono: in Impostazioni › Batteria, consenti a Quando? di funzionare in background e disattiva l’ottimizzazione.';

  @override
  String get testRing => 'Squillo di prova';

  @override
  String get testRingBody => 'Quando? può svegliarti';

  @override
  String get ringsIn20 => 'Suona tra 20 secondi. Blocca il telefono ora e aspetta.';

  @override
  String get readyToRing => 'Pronto a suonare';

  @override
  String get checkingPhone => 'Controllo del telefono…';

  @override
  String get phoneReady => 'Il tuo telefono è pronto a far suonare ogni sveglia in orario.';

  @override
  String thingsNeedFixing(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'Ci sono $n cose da sistemare, altrimenti le sveglie potrebbero non suonare.',
      one: 'C’è 1 cosa da sistemare, altrimenti le sveglie potrebbero non suonare.',
    );
    return '$_temp0';
  }

  @override
  String get fix => 'Sistema';

  @override
  String get testIn20 => 'Prova: suona tra 20 secondi';

  @override
  String get testIn20Hint =>
      'Blocca il telefono e appoggialo. Se la sveglia suona a schermo intero, è tutto pronto.';

  @override
  String get readyToRingHint => 'Verifica che il telefono faccia suonare ogni sveglia in orario';

  @override
  String get connections => 'Collegamenti';

  @override
  String get timeZoneHeading => 'FUSO ORARIO';

  @override
  String get followPhone => 'Segui il telefono';

  @override
  String followPhoneNow(String city) {
    return 'Ora $city. Cambia da solo quando viaggi.';
  }

  @override
  String get zoneFixed => 'Fisso. Le sveglie mantengono quest’ora anche in viaggio.';

  @override
  String get shabbatCityHeading => 'CITTÀ PER LO SHABBAT';

  @override
  String get inIsraelOneDay => 'In Israele (un giorno di festa)';

  @override
  String candleMinutesHeading(int n) {
    return 'CANDELE: $n MINUTI PRIMA DEL TRAMONTO';
  }

  @override
  String get endOfShabbatHeading => 'FINE DELLO SHABBAT E DELLE FESTE';

  @override
  String get nightfallGeonim => 'Uscita delle stelle (Gheonim, 8,5°)';

  @override
  String get rabbeinuTam => '72 minuti dopo il tramonto (Rabbenu Tam)';

  @override
  String get whenAlarmRingsHeading => 'QUANDO SUONA UNA SVEGLIA';

  @override
  String get recordOrAddSounds => 'Registra o aggiungi suoni';

  @override
  String get ringsForThisLong => 'Suona per questo tempo, poi si ferma da sola';

  @override
  String get sameFades => 'Stesse dissolvenze per tutte le sveglie';

  @override
  String get sameFadesOn => 'Sostituisce le dissolvenze di ogni sveglia. Ognuna mantiene il suo volume.';

  @override
  String get sameFadesOff => 'Disattivato: ogni sveglia usa le dissolvenze impostate nel suo Volume.';

  @override
  String get sayItOutLoud => 'Dillo ad alta voce';

  @override
  String get sayItOutLoudHint =>
      'Legge a cosa serve la sveglia, es. “Accensione delle candele, 15 minuti prima”';

  @override
  String get noSnooze => 'Niente posticipo';

  @override
  String snoozeUpTo(int times, int minutes) {
    return 'Posticipa fino a $times× da $minutes min';
  }

  @override
  String get wakeUpCheck => 'Controllo risveglio';

  @override
  String get wakeUpCheckHint =>
      'Dopo averla fermata, suona di nuovo tra 3 minuti se non tocchi “Sono sveglio”';

  @override
  String get solveSum => 'Risolvi un calcolo per fermarla';

  @override
  String get provesAwake => 'Dimostra che sei sveglio';

  @override
  String get shabbatNoTasks =>
      'Di Shabbat e nelle feste niente di tutto questo vale: le sveglie si fermano da sole e non chiedono mai di toccare il telefono.';

  @override
  String get testAlarmIn1 => 'Fai suonare una sveglia di prova tra 1 minuto';

  @override
  String get timesDisclaimer =>
      'Gli orari sono calcolati sul telefono. Nei casi limite, chiedi al tuo rabbino o consulta il calendario della comunità.';

  @override
  String get recommended => 'Consigliato';

  @override
  String get chooseCity => 'Scegli una città';

  @override
  String get testOnlyOnPhone => 'Le sveglie di prova funzionano solo su un telefono.';

  @override
  String get testAlarm => 'Sveglia di prova';

  @override
  String get testAlarmBody => 'Ecco come suoneranno le tue sveglie';

  @override
  String get testAlarmIn1Set => 'Sveglia di prova tra 1 minuto. Puoi bloccare il telefono.';

  @override
  String get presetGone => 'Questo modello non esiste più.';

  @override
  String get editPreset => 'Modifica modello';

  @override
  String get on => 'Attivo';

  @override
  String get ringsHeading => 'SUONA';

  @override
  String get noTimesYet => 'Ancora nessun orario. Aggiungine uno sotto.';

  @override
  String get atTheMomentItself => 'Nel momento esatto';

  @override
  String get remove => 'Rimuovi';

  @override
  String get addATime => 'Aggiungi un orario';

  @override
  String get resetPreset => 'Torna all’originale';

  @override
  String get skipOneHint =>
      'Per saltare una sola sveglia, toccala in “Sveglie di questa settimana” nella schermata principale.';

  @override
  String get unitMinutes => 'minuti';

  @override
  String get unitHours => 'ore';

  @override
  String get unitDays => 'giorni';

  @override
  String get before => 'Prima';

  @override
  String get after => 'Dopo';

  @override
  String get oneWeek => '1 settimana';

  @override
  String daysShort(int n) {
    return '$n g';
  }

  @override
  String hoursShort(int n) {
    return '$n h';
  }

  @override
  String get howToSearch => 'Come cercare';

  @override
  String get searchHelpWord => 'Il titolo contiene “dentist”, maiuscole o no';

  @override
  String get searchHelpStar => '* sta per lettere qualsiasi: dentist, dentures';

  @override
  String get searchHelpQuestion => '? sta per una lettera: yoga, toga';

  @override
  String get searchHelpPhrase => 'Questa frase esatta';

  @override
  String get searchHelpAnd => 'Entrambe le parole (AND)';

  @override
  String get searchHelpOr => 'L’una o l’altra. Va bene anche |';

  @override
  String get searchHelpNot => 'Escludi. Vanno bene anche NOT e !';

  @override
  String get searchHelpBrackets => 'Le parentesi raggruppano le parole';

  @override
  String get searchHelpEmpty => 'Lascia vuoto per suonare a ogni evento.';

  @override
  String get customTime => 'Altro tempo';

  @override
  String get other => 'Altro';

  @override
  String get sun => 'Sole';

  @override
  String get calendar => 'Calendario';

  @override
  String get newEventAlarm => 'Nuova sveglia evento';

  @override
  String get eventAlarm => 'Sveglia evento';

  @override
  String get findEventsHeading => 'TROVA GLI EVENTI';

  @override
  String get searchEventsHint => 'Cerca: dentista, palestra OR yoga, dent*…';

  @override
  String get alsoBuiltInTimes => 'Anche orari di Shabbat, feste e sole';

  @override
  String get alsoBuiltInTimesHint => 'es. “candel*”, “havdalà”, “tramonto”';

  @override
  String get allMyCalendars => 'Tutti i miei calendari';

  @override
  String get connectToSearch => 'Collega i calendari per cercarci dentro';

  @override
  String get searching => 'Ricerca…';

  @override
  String get nothingMatches60 => 'Nessun risultato nei prossimi 60 giorni';

  @override
  String eventsIn60(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n eventi nei prossimi 60 giorni',
      one: '1 evento nei prossimi 60 giorni',
    );
    return '$_temp0';
  }

  @override
  String nextRingsAt(String times, String title) {
    return 'Prossimo: suona alle $times per “$title”';
  }

  @override
  String showMoreLeft(int n) {
    return 'Mostra altri (ne restano $n)';
  }

  @override
  String get ringBeforeStartsHeading => 'SUONA PRIMA CHE INIZI';

  @override
  String get ringWhenStarts => 'Suona quando inizia';

  @override
  String get repeatBeforeHeading => 'E RIPETI PRIMA';

  @override
  String get everyPrefix => 'Ogni ';

  @override
  String get offLower => 'no';

  @override
  String get forInfix => '  per ';

  @override
  String get ringAfterEndsHeading => 'SUONA DOPO CHE FINISCE';

  @override
  String get nameOptional => 'Nome (facoltativo)';

  @override
  String get toppedUp =>
      'Le sveglie sono impostate per i prossimi 7 giorni e rinnovate ogni volta che apri Quando?.';

  @override
  String get back => 'Indietro';

  @override
  String get next => 'Avanti';

  @override
  String get stepWhichEvents => 'Quali eventi';

  @override
  String get stepWhenToRing => 'Quando suonare';

  @override
  String get stepHowItRings => 'Come suona';

  @override
  String defaultNamed(String name) {
    return 'Predefinito ($name)';
  }

  @override
  String get phoneAlarmSound => 'Suono sveglia del telefono';

  @override
  String get onlineRadio => 'Radio online';

  @override
  String songLinkOpens(String app) {
    return 'Link brano · apre $app';
  }

  @override
  String get builtIn => 'Incluso';

  @override
  String get yourRecording => 'La tua registrazione';

  @override
  String get sound => 'Suono';

  @override
  String get wakeToOwnSound => 'Svegliati con il tuo suono';

  @override
  String get wakeToOwnSoundHint => 'La tua voce, un brano, Spotify o la radio in diretta';

  @override
  String musicAdded(String name) {
    return '$name aggiunto. Sceglilo come suono per qualsiasi sveglia.';
  }

  @override
  String get playlists => 'Playlist';

  @override
  String get likedSongs => 'Brani che ti piacciono';

  @override
  String get noPlaylists => 'Ancora nessuna playlist.';

  @override
  String get noLikedSongs => 'Ancora nessun brano che ti piace.';

  @override
  String get needsMic => 'Quando? ha bisogno del microfono per registrare.';

  @override
  String recordingN(int n) {
    return 'Registrazione $n';
  }

  @override
  String couldNotAddFile(String error) {
    return 'Impossibile aggiungere il file: $error';
  }

  @override
  String get addSongLink => 'Aggiungi link a un brano';

  @override
  String get songLink => 'Link al brano';

  @override
  String get songLinkHowTo =>
      'In Spotify, Apple Music, YouTube, YouTube Music o SoundCloud, tocca Condividi, poi Copia link, e incollalo qui.';

  @override
  String get songNameHint => 'Nome, es. Playlist del mattino';

  @override
  String get whenAlarmGoesOffHeading => 'QUANDO SUONA LA SVEGLIA';

  @override
  String get playTheSong => 'Riproduci il brano';

  @override
  String get ringThenOpen => 'Suona, poi apri';

  @override
  String get playTheSongHint =>
      'La sua app si apre e lo riproduce. Se resta in silenzio per 10 secondi, suona il suono di riserva, così ti svegli sempre. Le sveglie con un compito suonano e poi lo aprono.';

  @override
  String get ringThenOpenHint => 'Suona il suono di riserva. Ferma apre il brano nella sua app.';

  @override
  String get playForHeading => 'RIPRODUCI PER';

  @override
  String get pausesAfter =>
      'Quando? mette in pausa il brano dopo questo tempo, con il tasto pausa del telefono.';

  @override
  String get backupSoundHeading => 'SUONO DI RISERVA';

  @override
  String get notALink => 'Non sembra un link.';

  @override
  String songOn(String app) {
    return 'Brano su $app';
  }

  @override
  String get theWeb => 'il web';

  @override
  String get pickFromYouTube => 'Scegli dal mio YouTube';

  @override
  String get youTubeAndMusic => 'YouTube e YouTube Music';

  @override
  String get youTubeOn => 'Connesso · tieni premuto per uscire';

  @override
  String get youTubeSignIn => 'Accedi con Google';

  @override
  String get addSongLinkInstead => 'Aggiungi invece un link a un brano.';

  @override
  String get googleSignInFailed => 'L’accesso a Google non è terminato. Riprova.';

  @override
  String get myYouTube => 'Il mio YouTube';

  @override
  String get spotifyDirectOn => 'Riproduzione diretta Spotify attiva';

  @override
  String get spotifyDirect => 'Riproduzione diretta Spotify';

  @override
  String get spotifyDirectOnHint => 'Attivo · tocca per disattivare';

  @override
  String get spotifyDirectHint => 'Riproduce il brano esatto. Serve Premium.';

  @override
  String get spotifyComingSoon => 'In arrivo · serve Premium';

  @override
  String get spotifyFailed =>
      'Spotify non si è collegato. Verifica che l’app Spotify sia installata, che tu abbia effettuato l’accesso e che tu abbia Premium.';

  @override
  String get nameThisSound => 'Dai un nome a questo suono';

  @override
  String get sounds => 'Suoni';

  @override
  String get soundsSentence => 'Svegliati con la tua voce, un brano, una playlist o la radio in diretta.';

  @override
  String stopTimer(String time) {
    return 'Ferma · $time';
  }

  @override
  String get record => 'Registra';

  @override
  String get addAFile => 'Aggiungi un file';

  @override
  String get addSongLinkLong => 'Aggiungi link a un brano (Spotify, Apple Music, YouTube…)';

  @override
  String get musicAppsHeading => 'APP DI MUSICA';

  @override
  String get pickFromSpotify => 'Scegli dal mio Spotify';

  @override
  String get yourPlaylistsAndLiked => 'Le tue playlist e i brani che ti piacciono';

  @override
  String get mySpotify => 'Il mio Spotify';

  @override
  String get spotifySignInFailed => 'Impossibile accedere a Spotify.';

  @override
  String get appleMusicNote =>
      'L’accesso arriverà con la versione per iPhone. Per ora, aggiungi un link a un brano.';

  @override
  String noSignInNote(String service) {
    return '$service non consente l’accesso da altre app. Aggiungi invece un link a un brano.';
  }

  @override
  String get wakeToRadio => 'Svegliati con la radio online';

  @override
  String get soundsExplain =>
      'Registra fino a 5 minuti, aggiungi un file, un link o la radio in diretta. Se qualcosa non va, suona un suono di riserva.';

  @override
  String get yourSoundsHeading => 'I TUOI SUONI';

  @override
  String playsIn(String app) {
    return 'Suona in $app';
  }

  @override
  String opensIn(String app) {
    return 'Si apre in $app';
  }

  @override
  String forSpan(String span) {
    return 'per $span';
  }

  @override
  String get defaultLabel => 'Predefinito';

  @override
  String get radioUnreachable => 'Impossibile raggiungere l’elenco delle radio. Controlla la connessione.';

  @override
  String get addStreamAddress => 'Aggiungi indirizzo stream';

  @override
  String get notAStream => 'Non sembra un indirizzo stream (inizia con http).';

  @override
  String get anyGenre => 'Qualsiasi genere';

  @override
  String get stationName => 'Nome della stazione';

  @override
  String get closeSearch => 'Chiudi ricerca';

  @override
  String get searchByName => 'Cerca per nome';

  @override
  String get anywhere => 'Ovunque';

  @override
  String get noStations => 'Nessuna stazione trovata. Prova un altro genere o paese.';

  @override
  String wakeUpTo(String name) {
    return 'Svegliati con $name';
  }

  @override
  String get notQuite => 'Quasi. Riprova.';

  @override
  String shabbatStopsItself(int n) {
    return 'Modalità Shabbat: si ferma da sola tra $n secondi. Non serve toccare il telefono.';
  }

  @override
  String get solveToSnooze => 'RISOLVI PER POSTICIPARE';

  @override
  String get solveToStop => 'RISOLVI PER FERMARE';

  @override
  String get answer => 'Risposta';

  @override
  String get snooze => 'Posticipa';

  @override
  String get stop => 'Ferma';

  @override
  String get shakeToSnooze => 'SCUOTI PER POSTICIPARE';

  @override
  String get shakeToStop => 'SCUOTI PER FERMARE';

  @override
  String get shakeHard => 'Scuoti forte il telefono finché la barra non si riempie.';

  @override
  String get cantShake => 'Non puoi scuoterlo? Risolvi un calcolo';

  @override
  String get pairsToSnooze => 'TROVA LE COPPIE PER POSTICIPARE';

  @override
  String get pairsToStop => 'TROVA LE COPPIE PER FERMARE';

  @override
  String get typeToSnooze => 'SCRIVI QUESTO PER POSTICIPARE';

  @override
  String get typeToStop => 'SCRIVI QUESTO PER FERMARE';

  @override
  String get scanToSnooze => 'SCANSIONA IL TUO CODICE PER POSTICIPARE';

  @override
  String get scanToStop => 'SCANSIONA IL TUO CODICE PER FERMARE';

  @override
  String ringAgainUnless(int n) {
    return 'Suonerò di nuovo tra $n minuti se non tocchi qui sotto.';
  }

  @override
  String get imUp => 'Sono sveglio';

  @override
  String snoozeMin(int n) {
    return 'Posticipa $n min';
  }

  @override
  String snoozeMinLeft(int n, int left) {
    return 'Posticipa $n min · ne restano $left';
  }

  @override
  String get noSnoozesLeft => 'Posticipi esauriti';

  @override
  String get stopThenOpen => 'Ferma · poi apri';

  @override
  String get startingSong => 'Avvio del tuo brano';

  @override
  String wayToStop(String way) {
    return '$way per fermare';
  }

  @override
  String wayToSnooze(String way) {
    return '$way per posticipare';
  }

  @override
  String ringsForMore(int n) {
    return 'Suona ancora $n secondi';
  }

  @override
  String get leftToRing => 'rimanenti';

  @override
  String get wayVolumeButtons => 'Tasti del volume';

  @override
  String get wayShake => 'Scuoti il telefono';

  @override
  String get taskNothing => 'Niente';

  @override
  String get taskSum => 'Risolvi un calcolo';

  @override
  String get taskShake => 'Scuoti 30 volte';

  @override
  String get taskMemory => 'Gioco di memoria';

  @override
  String get taskPhrase => 'Scrivi una frase';

  @override
  String get taskScan => 'Scansiona un codice';

  @override
  String get noLimit => 'senza limite';

  @override
  String upToTimes(int n) {
    return 'fino a $n×';
  }

  @override
  String shorterEachTime(int n) {
    return '$n min in meno ogni volta';
  }

  @override
  String autoSnoozeAfter(int n) {
    return 'si posticipa da sola dopo $n min';
  }

  @override
  String get card => 'Carta';

  @override
  String get hiddenCard => 'Carta coperta';

  @override
  String get phrase1 => 'Sono sveglio e la giornata è mia';

  @override
  String get phrase2 => 'Se non ora, quando';

  @override
  String get phrase3 => 'Buongiorno a me e a tutti quelli che amo';

  @override
  String get phrase4 => 'Ho i piedi per terra e sono in piedi';

  @override
  String get phrase5 => 'Oggi ricomincio';

  @override
  String get notQuiteWords => 'Quasi, controlla ogni parola.';

  @override
  String get typeItHere => 'Scrivilo qui';

  @override
  String get differentCode => 'È un altro codice.';

  @override
  String get cameraUnavailable => 'La fotocamera non è disponibile.';

  @override
  String get cantScan => 'Non puoi scansionare? Risolvi un calcolo';

  @override
  String get saveCodeToScan => 'Salva un codice da scansionare';

  @override
  String get saveCodeHint =>
      'Inquadra un codice a barre o QR in un posto dove devi andare a piedi, come una scatola in cucina o il dentifricio in bagno. Per fermare la sveglia, lo scansionerai di nuovo.';

  @override
  String get cameraUnavailableSettings =>
      'La fotocamera non è disponibile. Consenti l’accesso alla fotocamera nelle Impostazioni.';

  @override
  String gentleToGo(int n) {
    return 'Risveglio dolce · mancano $n min';
  }

  @override
  String previewBody(String body) {
    return 'Prova · $body';
  }

  @override
  String snoozedBody(String body) {
    return 'Posticipata: $body';
  }

  @override
  String get areYouUp => 'Sei sveglio?';

  @override
  String get tapImUp => 'Tocca “Sono sveglio” per fermare';

  @override
  String get volume => 'Volume';

  @override
  String get wakeCheckOn => 'Controllo risveglio attivo';

  @override
  String get stopsAtOnce => 'Si ferma subito';

  @override
  String get ringsAgainIfNotUp => 'Suona di nuovo se non ti alzi';

  @override
  String get openAppAfter => 'Apri un’app dopo';

  @override
  String get noTask => 'Nessun compito';

  @override
  String get codeSaved => 'Codice salvato';

  @override
  String get tapToSaveDifferent => 'Tocca per salvarne un altro';

  @override
  String get controlsHeading => 'COMANDI';

  @override
  String get onScreen => 'Sullo schermo';

  @override
  String get taskHeading => 'COMPITO';

  @override
  String get none => 'Nessuno';

  @override
  String get snoozeSentence => 'Altri cinque minuti? Scegli quanto, quante volte e cosa serve.';

  @override
  String get settingsHeading => 'IMPOSTAZIONI';

  @override
  String get snoozeTime => 'Durata posticipo';

  @override
  String get snoozeTimeHint => 'Quanto dura il primo posticipo';

  @override
  String get shortenSnoozes => 'Accorcia i posticipi successivi';

  @override
  String get shortenSnoozesHint => 'Ogni posticipo dopo il primo è più corto di tanto';

  @override
  String get autoSnooze => 'Posticipo automatico';

  @override
  String get autoSnoozeHint => 'Se non la tocchi, si posticipa da sola dopo';

  @override
  String get never => 'Mai';

  @override
  String get snoozeLimit => 'Limite di posticipi';

  @override
  String get snoozeLimitHint => 'Quante volte puoi posticipare';

  @override
  String get unlimited => 'Illimitato';

  @override
  String get useSnoozeFromSettings => 'Usa il posticipo delle Impostazioni';

  @override
  String get stopSentence => 'Come spegni la sveglia e cosa devi fare prima.';

  @override
  String get shabbatNoTask =>
      'Di Shabbat e nelle feste le sveglie si fermano da sole e non chiedono mai un compito.';

  @override
  String get volumeSentence => 'Quanto forte suona e con quanta dolcezza ci arriva.';

  @override
  String get openAfterAlarm => 'Apri dopo la sveglia';

  @override
  String get pickAnApp => 'Scegli un’app';

  @override
  String get orPasteLink => 'Oppure incolla un link: https://…';

  @override
  String get useThisLink => 'Usa questo link';

  @override
  String get noAppsFound => 'Nessuna app trovata.';

  @override
  String get weather => 'Meteo';

  @override
  String get news => 'Notizie';

  @override
  String get usePhoneVolume => 'Usa il volume sveglia del telefono';

  @override
  String get setsPhoneVolume => 'Imposta il volume sveglia del telefono mentre suona, poi lo ripristina.';

  @override
  String get fadeInOff => 'Dissolvenza in entrata: no, volume pieno subito';

  @override
  String fadeInOver(String span) {
    return 'Sale in $span';
  }

  @override
  String get fadeOutOff => 'Dissolvenza in uscita: no';

  @override
  String fadeOutOver(String span) {
    return 'Scende negli ultimi $span';
  }

  @override
  String get fadesExplain =>
      'La dissolvenza in uscita avviene quando la sveglia si ferma da sola. Se le dissolvenze sono più lunghe della suoneria, si accorciano entrambe.';

  @override
  String get soundSoftChime => 'Campanella dolce';

  @override
  String get soundMorningRise => 'Risveglio del mattino';

  @override
  String get soundClassicBeep => 'Bip classico';

  @override
  String get calmCity => 'Mattina tranquilla in città';

  @override
  String get calmBirds => 'Uccelli all’alba';

  @override
  String get calmWaves => 'Onde sulla riva';

  @override
  String get calmRain => 'Pioggia leggera';

  @override
  String get calmStream => 'Ruscello nel bosco';

  @override
  String get calmWind => 'Vento leggero';

  @override
  String get calmFire => 'Fuoco scoppiettante';

  @override
  String get calmNight => 'Notte d’estate';

  @override
  String get publicDomain => 'Pubblico dominio';

  @override
  String get phoneVolume => 'Volume del telefono';

  @override
  String fadesIn(String span) {
    return 'sale in $span';
  }

  @override
  String fadesOut(String span) {
    return 'scende in $span';
  }

  @override
  String get noFade => 'senza dissolvenza';

  @override
  String minSecShort(int m, int s) {
    return '$m min $s s';
  }

  @override
  String get happensRings => 'Suona';

  @override
  String get happensStopped => 'La fermi';

  @override
  String get happensSnoozed => 'La posticipi';

  @override
  String get happensAutoStopped => 'Si ferma da sola';

  @override
  String get eventLower => 'evento';

  @override
  String get appTest => 'Prova di Quando?';

  @override
  String get pushoverConnected => 'Pushover è collegato';

  @override
  String get webhookConnected => 'Il webhook è collegato';

  @override
  String pushoverSaid(int code, String body) {
    return 'Pushover ha risposto $code: $body';
  }

  @override
  String couldNotReachPushover(String error) {
    return 'Impossibile raggiungere Pushover ($error)';
  }

  @override
  String itAnswered(int code) {
    return 'Ha risposto $code';
  }

  @override
  String couldNotReachIt(String error) {
    return 'Impossibile raggiungerlo ($error)';
  }

  @override
  String get calendarNotAllowed => 'L’accesso al calendario non è stato consentito.';

  @override
  String get playlist => 'Playlist';

  @override
  String songCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n brani', one: '1 brano');
    return '$_temp0';
  }

  @override
  String get spotifySaidNo =>
      'Spotify ha rifiutato. Nella dashboard di Spotify, spunta Web API per Quando? e aggiungi il tuo account in User Management.';

  @override
  String serviceDidntAnswer(String service, int code) {
    return '$service non ha risposto ($code).';
  }

  @override
  String get youTubeSaidNo =>
      'YouTube ha rifiutato. Verifica che il tuo account Google sia un utente di prova del progetto Quando.';

  @override
  String get event => 'Evento';

  @override
  String eventEnds(String title) {
    return '$title (fine)';
  }

  @override
  String foundSoundsDevices(int s, int d) {
    return 'Trovati $s suoni e $d dispositivi.';
  }

  @override
  String get sentCheckDevices => 'Inviato. Controlla gli altri dispositivi.';

  @override
  String sentTo(String name) {
    return 'Inviato a $name.';
  }

  @override
  String get zapierHowTo =>
      'In Zapier, crea uno Zap che inizia con “Webhooks by Zapier → Catch Hook”, poi incolla qui il suo URL.';

  @override
  String get catchHookUrl => 'URL del Catch Hook';

  @override
  String get iftttHowTo =>
      'In IFTTT, crea un applet che inizia con “Webhooks → Receive a web request with a JSON payload”. Usa qui lo stesso nome evento. La tua chiave è su ifttt.com/maker_webhooks/settings.';

  @override
  String get eventName => 'Nome evento';

  @override
  String get webhooksKey => 'Chiave Webhooks';

  @override
  String get webhookHowTo => 'Quando? invia un JSON POST a questo indirizzo.';

  @override
  String get connectionsSentence =>
      'Avvisa le altre app e dispositivi quando una sveglia suona, si ferma o viene posticipata.';

  @override
  String get pushWhenRings => 'Invia una notifica quando suona una sveglia';

  @override
  String get pushWhenRingsHint => 'Agli altri telefoni, tablet, orologio o computer';

  @override
  String get yourUserKey => 'La tua chiave utente';

  @override
  String get appToken => 'Token dell’app';

  @override
  String get soundAndDevicesHeading => 'SUONO E DISPOSITIVI';

  @override
  String get loading => 'Caricamento…';

  @override
  String get loadFromPushover => 'Carica da Pushover';

  @override
  String get soundItPlays => 'Suono riprodotto';

  @override
  String get myPushoverDefault => 'Il mio predefinito Pushover';

  @override
  String get pushoverOwnSounds => 'I tuoi suoni compaiono qui dopo averli caricati su pushover.net/sounds.';

  @override
  String get allMyDevices => 'Tutti i miei dispositivi';

  @override
  String get pushoverOnThisPhone =>
      'Installa l’app Pushover anche su questo telefono e suonerà qui con il tuo suono Pushover.';

  @override
  String get priority => 'Priorità';

  @override
  String get priorityNormal => 'Normale';

  @override
  String get priorityHigh => 'Alta: supera le ore di silenzio';

  @override
  String get priorityEmergency => 'Emergenza: si ripete fino alla conferma';

  @override
  String get sending => 'Invio…';

  @override
  String get sendATest => 'Invia una prova';

  @override
  String get findUserKey => 'Trova la mia chiave utente';

  @override
  String get makeAppToken => 'Crea un token app';

  @override
  String get webhooksHeading => 'ZAPIER, IFTTT E WEBHOOK';

  @override
  String get webhooksExplain =>
      'Avvia qualsiasi cosa quando una sveglia suona o la fermi: accendere le luci, registrare l’ora del risveglio, scrivere a qualcuno.';

  @override
  String get sendWhenAlarm => 'Invia quando la sveglia:';

  @override
  String get pauseOnShabbat => 'Pausa di Shabbat e nelle feste';

  @override
  String get pauseOnShabbatHint =>
      'Non viene inviato nulla per le sveglie tra l’accensione delle candele e la Havdalà';

  @override
  String get webhookPayloadNote =>
      'Ogni messaggio contiene: event (ring, stopped, snoozed, auto_stopped), title, body, time, shabbat e snoozes. Le chiavi restano su questo telefono.';

  @override
  String get today => 'Oggi';

  @override
  String get tomorrow => 'Domani';

  @override
  String get notAWebAddress => 'Non sembra un indirizzo web che inizia con https://';

  @override
  String get language => 'Lingua';

  @override
  String get phoneLanguage => 'Lingua del telefono';

  @override
  String get ringQuote => 'Se non ora, quando?';

  @override
  String get ringQuoteBy => 'Hillel';

  @override
  String get quotesTitle => 'Citazioni sul tempo';

  @override
  String get quotesHint =>
      'Scegli da dove vengono. Una per ogni momento della giornata; tocca la citazione per vederne un’altra.';

  @override
  String get quotesOff => 'Disattivate';

  @override
  String get quoteSongs => 'Canzoni';

  @override
  String get quoteMovies => 'Film';

  @override
  String get quoteLiterature => 'Libri e poesie';

  @override
  String get quoteTanakh => 'Tanakh (Bibbia ebraica)';

  @override
  String get quoteSages => 'Talmud e saggi';

  @override
  String get quoteSpeeches => 'Discorsi famosi';

  @override
  String get quotePhilosophy => 'Filosofi';

  @override
  String get quoteProverbs => 'Proverbi e detti';

  @override
  String get quotesAlso => 'Mostra anche';

  @override
  String get quoteCarnaval => 'Carnevale';

  @override
  String get quoteCarnavalHint => 'Canzoni e detti durante il Carnevale brasiliano';

  @override
  String get quoteNearMe => 'Vicino a me';

  @override
  String get quoteNearMeHint =>
      'Poeti e date del luogo in cui sei, dal fuso orario e dalla città dello Shabbat';

  @override
  String get quoteSiddur => 'Siddur (libro di preghiere)';

  @override
  String weeklyParasha(String name) {
    return 'Parashà $name';
  }

  @override
  String poweredBy(String name) {
    return 'realizzato con $name';
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
  String get spotifyLibrarySignIn => 'Playlist, brani che ti piacciono e ricerca';

  @override
  String get spotifyLibraryOn => 'Connesso · tieni premuto per uscire';

  @override
  String spotifyLoginError(String reason) {
    return 'L\'accesso a Spotify non è riuscito: $reason';
  }

  @override
  String googleSignInError(String reason) {
    return 'L\'accesso a Google non è riuscito: $reason';
  }

  @override
  String get searchSongsHint => 'Cerca brani, artisti, playlist';

  @override
  String nothingFound(String query) {
    return 'Nessun risultato per “$query”.';
  }

  @override
  String get deliveryTitle => 'Avviso';

  @override
  String get deliveryLocal => 'Audio locale';

  @override
  String get deliveryBoth => 'Entrambi';

  @override
  String get deliveryConnect => 'Collega Pushover';

  @override
  String get deliveryLoadFailed => 'Impossibile caricare suoni e dispositivi. Riprova.';

  @override
  String get deliveryBothHint => 'L’audio locale suona anche se Pushover non funziona.';

  @override
  String get deliveryPushHint =>
      'Solo Pushover. Questo dispositivo deve essere online al momento dell’avviso.';

  @override
  String get deliveryFallback => 'L’audio locale resta attivo se Pushover è scollegato o in pausa.';

  @override
  String get deliveryReset => 'Usa le impostazioni esistenti';

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
      'La riproduzione segue la durata di questa sveglia e si ferma con Stop o Posticipa.';

  @override
  String get musicBackupPlaying =>
      'Impossibile avviare la musica. Sta suonando il tono locale della sveglia.';

  @override
  String desktopMusicConnect(String service) {
    return 'Collega l’app $service';
  }

  @override
  String desktopMusicOn(String service) {
    return 'Connesso a $service · tieni premuto per scollegare';
  }

  @override
  String get musicSongs => 'Brani';

  @override
  String get noMusicSongs => 'Nessun brano trovato nella libreria di Musica.';

  @override
  String serviceConnectUnavailable(String service) {
    return 'Aggiungi un link $service · si apre dopo la sveglia';
  }

  @override
  String get soundCloudWidgetNote => 'Aggiungi un link pubblico';

  @override
  String get youtubePlayerHint =>
      'YouTube riproduce video in un lettore visibile. Se viene nascosto o non può riprodurre, continua il tono locale.';

  @override
  String get musicPreviewFailed =>
      'Impossibile riprodurre questo suono. Controlla la connessione o prova un altro brano o stazione.';

  @override
  String get skyMoonPhase => 'Fase lunare';

  @override
  String get skyMoonDetailsDisplay => 'Aggiungi la pagina della fase lunare';

  @override
  String get skyMoonDetailsHint => 'Scorri fino a lì o tocca la scheda della Luna quando vuoi';

  @override
  String get moonRises => 'Sorge';

  @override
  String get moonSets => 'Tramonta';

  @override
  String moonLunarDay(int day) {
    return 'Giorno $day di 29,5 di questo mese lunare';
  }

  @override
  String get moonDetailsOpen => 'Apri la fase lunare';

  @override
  String get musicPlaylists => 'Playlist musicali';

  @override
  String get videoPlaylists => 'Playlist video';

  @override
  String get likedVideos => 'Video che ti piacciono';

  @override
  String get wholePlaylist => 'Svegliati con tutta la playlist';

  @override
  String get noSongsInPlaylist => 'Nessun brano riproducibile qui.';

  @override
  String get hebrewNamesHeading => 'Grafia di parashà e mesi';

  @override
  String get hebrewNamesIsraeli => 'Israeliana';

  @override
  String get hebrewNamesAshkenazi => 'Ashkenazita';

  @override
  String pickFromService(String service) {
    return 'Scegli dal mio $service';
  }

  @override
  String get weatherTonight => 'Stasera';

  @override
  String get weatherTomorrowMorning => 'Domani mattina';

  @override
  String weatherUntilAbout(String time) {
    return 'fino alle $time circa';
  }

  @override
  String get weatherSunBehindClouds => 'Sole dietro le nuvole';

  @override
  String get keysLockTitle => 'Chiavi sui tuoi dispositivi';

  @override
  String get keysLockOff =>
      'Le tue chiavi dei servizi restano su questo dispositivo. Scegli una frase di sincronizzazione per inviarle, cifrate, agli altri dispositivi.';

  @override
  String get keysLockOn =>
      'Le tue chiavi dei servizi vengono cifrate con la frase di sincronizzazione prima di lasciare questo dispositivo. Nessun altro, nemmeno Google, può leggerle.';

  @override
  String get keysLockWaiting =>
      'Sono arrivate qui le chiavi dell\'altro dispositivo, bloccate. Scrivi la frase di sincronizzazione per aprirle.';

  @override
  String get keysSetPassphrase => 'Scegli la frase';

  @override
  String get keysChangePassphrase => 'Cambia la frase';

  @override
  String get keysUnlock => 'Sblocca le chiavi';

  @override
  String get keysStartOver => 'Dimenticata? Ricomincia';

  @override
  String get keysStartOverHint =>
      'Ricominciare invia le chiavi di questo dispositivo con una nuova frase. Gli altri dispositivi chiederanno quella nuova.';

  @override
  String get keysPassphrase => 'Frase di sincronizzazione';

  @override
  String get keysPassphraseAgain => 'Scrivila di nuovo';

  @override
  String keysPassphraseShort(int count) {
    return 'Usa almeno $count caratteri.';
  }

  @override
  String get keysPassphraseMismatch => 'Le due non coincidono.';

  @override
  String get keysPassphraseWrong => 'Questa frase non apre queste chiavi.';

  @override
  String get keysPassphraseNote =>
      'Annotala: se la dimentichi nessuno può recuperarla e dovrai reinserire le chiavi.';

  @override
  String get keysShareNeedsPassphrase =>
      'Scegli prima una frase di sincronizzazione, in Chiavi sui tuoi dispositivi.';

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
}
