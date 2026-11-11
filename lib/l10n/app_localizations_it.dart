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
  String get lockSentenceCalm =>
      'Blocca il telefono su orologio e sveglie: per un esame, una riunione o una serata tranquilla.';

  @override
  String get lockCalendarHeading => 'CON IL TUO CALENDARIO';

  @override
  String get lockCalendarExplain =>
      'Blocca durante un evento, o da un evento fino al prossimo che scegli. Funziona con ogni calendario scelto, anche condiviso.';

  @override
  String get lockAddCalendar => 'Aggiungi blocco da calendario';

  @override
  String get lockEditCalendar => 'Blocco da calendario';

  @override
  String get lockDuring => 'Durante un evento';

  @override
  String get lockBetween => 'Tra due eventi';

  @override
  String get lockStartsAt => 'Eventi chiamati…';

  @override
  String get lockStartsAtBetween => 'Inizia a un evento chiamato…';

  @override
  String get lockEndsAt => 'Finisce al prossimo evento chiamato…';

  @override
  String get lockStartHint => 'es. esame, focus, palestra';

  @override
  String get lockEndHint => 'es. a casa';

  @override
  String get lockAnyCalendar => 'Qualsiasi calendario';

  @override
  String get lockNoMatches => 'Ancora niente nei tuoi calendari corrisponde.';

  @override
  String get lockNextTimes => 'PROSSIME VOLTE';

  @override
  String lockDuringTitle(String a) {
    return 'Durante “$a”';
  }

  @override
  String lockBetweenTitle(String a, String b) {
    return 'Da “$a” al prossimo “$b”';
  }

  @override
  String lockShabbatCalendarFound(String name) {
    return '“$name” ha gli orari dello Shabbat.';
  }

  @override
  String get lockShabbatFromCalendar => 'Blocca dall\'accensione delle candele all\'Havdalà';

  @override
  String get lockShabbatFromCalendarHint => 'Usa gli orari di quel calendario, con le candele sullo schermo.';

  @override
  String get lockMoreWays => 'Altri modi di bloccare';

  @override
  String get lockQuietTime => 'Momento di calma';

  @override
  String nextCandleLightingFrom(String time, String name) {
    return 'Prossima accensione delle candele: $time, da $name';
  }

  @override
  String get calendarAlarm => 'Sveglia del calendario';

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
  String get syncTitle => 'Sincronizza i miei dispositivi';

  @override
  String get syncHint =>
      'Accedi con Google per avere sveglie e impostazioni uguali su tutti i tuoi dispositivi.';

  @override
  String syncOn(String email) {
    return 'On · $email';
  }

  @override
  String get syncWorking => 'Connecting…';

  @override
  String get syncNotAllowed => 'This Google account can\'t sync.';

  @override
  String get syncFailed => 'Impossibile connettersi. Tocca per riprovare.';

  @override
  String get syncStop => 'Stop syncing';

  @override
  String get syncNotSetUp => 'La sincronizzazione non è ancora configurata in questa versione.';

  @override
  String get ringTheseAfterAll => 'Falle suonare comunque';

  @override
  String skipTheseDay(int n) {
    return 'Salta queste $n oggi';
  }

  @override
  String turnOffNamed(String name) {
    return 'Disattiva «$name»';
  }

  @override
  String turnOnNamed(String name) {
    return 'Attiva «$name»';
  }

  @override
  String turnedOffNamed(String name) {
    return '«$name» disattivata';
  }

  @override
  String removeTimeFrom(String time, String name) {
    return 'Rimuovi «$time» da «$name»';
  }

  @override
  String removedTimeFrom(String time, String name) {
    return '«$time» rimossa da «$name»';
  }

  @override
  String get moveToGroup => 'Sposta in un gruppo';

  @override
  String inGroupMove(String group) {
    return 'In «$group», sposta';
  }

  @override
  String movedToGroup(String group) {
    return 'Spostata in «$group»';
  }

  @override
  String deleteNamed(String name) {
    return 'Elimina «$name»';
  }

  @override
  String get signInWithGoogle => 'Accedi con Google';

  @override
  String get signOut => 'Sign out';

  @override
  String get signInWithEmail => 'Accedi con l’email';

  @override
  String get signIn => 'Sign in';

  @override
  String get createAccount => 'Crea account';

  @override
  String get haveAccount => 'Ho già un account';

  @override
  String get forgotPassword => 'Password dimenticata?';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get passwordResetSent => 'Ti abbiamo mandato un link per scegliere una nuova password.';

  @override
  String emailCheckInbox(String email) {
    return 'Abbiamo mandato un link a $email. Aprilo, poi torna qui e tocca «Ho confermato».';
  }

  @override
  String get emailConfirmed => 'Ho confermato';

  @override
  String get emailNotYet => 'Non ancora confermato. Apri prima il link nell’email.';

  @override
  String get emailSendAgain => 'Invia di nuovo l’email';

  @override
  String get emailSentAgain => 'Inviata. Controlla la posta in arrivo e lo spam.';

  @override
  String get emailInvalid => 'Non sembra un indirizzo email.';

  @override
  String get emailWrong => 'Email o password errata.';

  @override
  String get emailInUse =>
      'Esiste già un account con questa email. Accedi, oppure usa Google se l’hai creato con Google.';

  @override
  String get passwordWeak => 'Scegli una password di almeno 6 caratteri.';

  @override
  String get emailNotSwitchedOn => 'L’accesso con email non è ancora attivo.';

  @override
  String get tooManyTries => 'Troppi tentativi. Aspetta qualche minuto.';

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
  String get beforeShabbat => 'Prima di Shabbat';

  @override
  String get preparationReminders => 'Promemoria di preparazione';

  @override
  String get skipThisWeek => 'Salta questa settimana';

  @override
  String get restoreThisWeek => 'Ripristina questa settimana';

  @override
  String get allAlarms => 'All alarms';

  @override
  String get timesAndSound => 'Orari e suono';

  @override
  String get changeCity => 'Change city';

  @override
  String get useMyLocation => 'Usa la mia posizione';

  @override
  String get locationUnavailable => 'La posizione non è disponibile per ora. Riprova o scegli una città.';

  @override
  String get locationReview => 'Conferma questa posizione';

  @override
  String get locationDeviceOnly =>
      'Questa posizione è salvata solo su questo dispositivo. Controlla il fuso orario e l’impostazione Israele prima di usare questi orari.';

  @override
  String timesIn(String city, String zone) {
    return '$city · $zone · ora della città';
  }

  @override
  String get preparationOff =>
      'I promemoria di preparazione sono disattivati. Havdalà e sveglie normali non cambiano.';

  @override
  String get preparationSkipped =>
      'I promemoria di preparazione sono saltati questa settimana. Le tue impostazioni settimanali restano.';

  @override
  String get shabbatControls => 'Controlli di Shabbat';

  @override
  String get duringAfterShabbat => 'Durante / dopo Shabbat';

  @override
  String locationCoordinates(String latitude, String longitude) {
    return 'Latitudine $latitude · longitudine $longitude';
  }

  @override
  String get currentLocation => 'Posizione attuale';

  @override
  String get testPushoverSound => 'Prova il suono su Pushover';

  @override
  String get pushoverSoundTestHint =>
      'Riproduce il suono scelto sui dispositivi Pushover selezionati. Restano valide le impostazioni di silenzio e di ore tranquille.';

  @override
  String get pushoverShareDevices => 'Condividi le credenziali con i miei dispositivi';

  @override
  String get pushoverShareHint =>
      'La tua chiave utente Pushover e il token dell’app possono seguire il tuo account in Quando? e Matai?.';

  @override
  String get pushoverShareQueued => 'Credenziali in coda per i tuoi dispositivi con accesso effettuato.';

  @override
  String get pushoverShareSignIn =>
      'Accedi allo stesso account dell’app su ogni dispositivo per condividere le credenziali Pushover.';

  @override
  String get smartHomeHeading => 'Smart home';

  @override
  String get smartHomeHint =>
      'Esegui direttamente le scene Tuya, oppure collega le tue automazioni Home Assistant o Node-RED.';

  @override
  String get shareServices => 'Condividi i collegamenti ai servizi';

  @override
  String get shareServicesHint =>
      'Usa lo stesso account dell’app sui tuoi dispositivi per condividere i collegamenti a Pushover, Tuya, libreria Spotify e automazioni. YouTube e le autorizzazioni del dispositivo potrebbero richiedere conferma su ogni dispositivo.';

  @override
  String get tuyaSetupHint =>
      'Usa il tuo progetto sviluppatore Tuya collegato. Inserisci il suo data center, Access ID, Access Secret e l’UID mostrato in «Link App Account». Home Assistant non serve.';

  @override
  String get tuyaDataCenter => 'Data center';

  @override
  String get tuyaUserId => 'UID dell’account collegato';

  @override
  String get tuyaAccessId => 'Access ID / Client ID';

  @override
  String get tuyaAccessSecret => 'Access Secret / Client Secret';

  @override
  String get tuyaLoadScenes => 'Load scenes';

  @override
  String get tuyaNoScenes =>
      'Nessuna scena Tap-to-Run disponibile. Controlla l’account collegato, il data center e i permessi dell’API delle scene.';

  @override
  String get tuyaRunNow => 'Esegui la scena ora';

  @override
  String get tuyaRunConfirm => 'Eseguire ora questa scena sui tuoi dispositivi Tuya?';

  @override
  String get tuyaSent => 'Tuya ha accettato il comando della scena. Controlla i tuoi dispositivi.';

  @override
  String get tuyaFailed =>
      'Tuya non ha potuto completare la richiesta. Controlla i permessi del progetto, il data center e l’abbonamento. Errore:';

  @override
  String get tuyaAlarmScene => 'Scena Tuya quando suona questa sveglia';

  @override
  String get homeAssistantHowTo =>
      'Crea un’automazione Home Assistant con un trigger Webhook che accetta POST e JSON. Incolla qui il suo URL. Usa l’evento della sveglia (ring, stopped, snoozed o auto_stopped) per scegliere le azioni. I nuovi dispositivi ricevono questo collegamento disattivato.';

  @override
  String get nodeRedHowTo =>
      'Usa un nodo HTTP In di Node-RED che accetta POST, seguito dalla tua automazione e da un nodo HTTP Response. Incolla qui l’endpoint. Sono supportati hub HTTP locali ed endpoint HTTPS.';

  @override
  String get smartHomeConnect => 'Collega un servizio di casa intelligente';

  @override
  String get automationTestHint => 'Il test esegue subito l’automazione collegata.';

  @override
  String get smartHomeDeviceOn => 'Esegui su questo dispositivo le azioni di casa intelligente delle sveglie';

  @override
  String get smartHomeDeviceHint =>
      'Scegli un dispositivo per eseguire le tue automazioni. I collegamenti sono condivisi; questo interruttore resta su questo dispositivo.';

  @override
  String get smartHomeDeviceOff =>
      'Le azioni delle sveglie sono disattivate su questo dispositivo. Attivale in Collegamenti; i test manuali delle scene funzionano ancora.';

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
  String get weatherSwipeHint => 'Scorri tra cielo e meteo';

  @override
  String get parashaHeading => 'Parashà settimanale';

  @override
  String get dailyStudyHeading => 'Studio quotidiano';

  @override
  String get courseDaf => 'Daf Yomi';

  @override
  String get courseRambam1 => 'Rambam · 1 capitolo al giorno';

  @override
  String get courseRambam3 => 'Rambam · 3 capitoli al giorno';

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
  String get moonAlwaysUp => 'Luna sopra l’orizzonte tutto il giorno';

  @override
  String get moonAlwaysDown => 'Luna sotto l’orizzonte tutto il giorno';

  @override
  String get noRiseToday => 'Oggi non sorge';

  @override
  String get noSetToday => 'No set today';

  @override
  String get moonNew => 'New moon';

  @override
  String get moonWaxingCrescent => 'Luna crescente';

  @override
  String get moonFirstQuarter => 'Primo quarto';

  @override
  String get moonWaxingGibbous => 'Gibbosa crescente';

  @override
  String get moonFull => 'Full moon';

  @override
  String get moonWaningGibbous => 'Gibbosa calante';

  @override
  String get moonLastQuarter => 'Last quarter';

  @override
  String get moonWaningCrescent => 'Luna calante';

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
  String get weatherThunder => 'Temporali';

  @override
  String get weatherUnavailable => 'Meteo non disponibile per ora';

  @override
  String get weatherCached => 'Previsioni salvate';

  @override
  String get weatherUpdated => 'Updated';

  @override
  String get weatherForecast => 'Forecast';

  @override
  String get weatherThunderExpected => 'Previsti temporali';

  @override
  String get learningUnavailable => 'Connettiti per caricare il programma di studio di questo mese';

  @override
  String get festivalReading => 'Lettura della Torà della festa';

  @override
  String get learningCalendarSource => 'Calendario di studio · Hebcal · CC BY 4.0';

  @override
  String get weatherSource => 'Previsioni · MET Norway · CC BY 4.0';

  @override
  String get weatherConsent => 'Il meteo della città scelta. Usa coordinate arrotondate con MET Norway.';

  @override
  String get learningConsent =>
      'I programmi di studio del Rambam e altri vengono caricati da Hebcal e salvati per l’uso offline.';

  @override
  String get homeRefresh => 'Refresh';

  @override
  String get skyTimezone => 'My timezone';

  @override
  String get skyShabbat => 'Shabbat city';

  @override
  String get skyReferenceCity => 'Città di riferimento del fuso orario';

  @override
  String get skyChooseCity => 'Scegli la città del cielo';

  @override
  String get skyCityExplain =>
      'Sole e Luna usano le coordinate di questa città. La tua città di Shabbat e il fuso orario delle sveglie restano come scelti.';

  @override
  String get skySun => 'Sun today';

  @override
  String get skyMoon => 'Moon today';

  @override
  String get moonAboveHorizon => 'Luna sopra l’orizzonte';

  @override
  String get moonBelowHorizon => 'Luna sotto l’orizzonte';

  @override
  String get moonNextNew => 'Prossima luna nuova';

  @override
  String get moonNextFull => 'Prossima luna piena';

  @override
  String get locationServicesOff =>
      'I servizi di localizzazione sono disattivati. Attivali in Impostazioni o scegli una città.';

  @override
  String get locationDenied =>
      'L’accesso alla posizione è stato negato. Consentilo in Impostazioni o scegli una città.';

  @override
  String get locationTimedOut =>
      'Ancora nessuna posizione. Su Mac tieni attivo il Wi-Fi e riprova, oppure scegli una città.';

  @override
  String get locationTimeZoneUnavailable =>
      'Usa una città nel fuso orario scelto, oppure segui il fuso orario del dispositivo prima di usare la posizione.';

  @override
  String get locationSettings => 'Apri le impostazioni di localizzazione';

  @override
  String get locationLooking => 'Ricerca della posizione…';

  @override
  String get skyMoonDisplay => 'Mostra la Luna: sorgere, tramonto e fase';

  @override
  String get tuyaConsumerPending =>
      'L’accesso con account non è ancora disponibile in questa versione. Se hai già un progetto sviluppatore Tuya, usa la configurazione avanzata.';

  @override
  String get tuyaAdvanced => 'Configurazione avanzata';

  @override
  String get tuyaSignInTitle => 'Accedi con il tuo account Smart Life';

  @override
  String get tuyaSignInHint =>
      'Usa lo stesso paese, email o telefono e password dell’app Smart Life o Tuya Smart. L’account deve essere già collegato al tuo progetto Tuya. La password va solo a Tuya e non viene mai salvata.';

  @override
  String get tuyaCountryCode => 'Prefisso del paese (Brasile 55, USA 1)';

  @override
  String get tuyaAccount => 'Email o telefono Smart Life';

  @override
  String get tuyaPassword => 'Password Smart Life';

  @override
  String get tuyaSignIn => 'Accedi e carica le scene';

  @override
  String get tuyaRelayUrl => 'Indirizzo del relay Tuya di Quando (https)';

  @override
  String get tuyaRelayHint =>
      'Usa paese, email o telefono e password del tuo account Smart Life o Tuya Smart. Vengono inviati una volta al relay Tuya di Quando e non vengono salvati. Devi aver effettuato l’accesso al tuo account Quando.';

  @override
  String get tuyaGoogleHint =>
      'Accedi a Smart Life con Google o Apple? In Smart Life tocca «Password dimenticata» per impostarne una, poi usala qui.';

  @override
  String get tuyaLinked => 'Account Smart Life collegato';

  @override
  String get tuyaUnlink => 'Scollega';

  @override
  String get tuyaNeedsAccount => 'Prima accedi al tuo account Quando nelle Impostazioni.';

  @override
  String get roshHodeshHeading => 'Rosh Hodesh';

  @override
  String get roshHodeshExplain =>
      'Mostra nella Home il primo giorno o i due giorni del prossimo mese ebraico.';

  @override
  String get roshHodeshNext => 'Prossimo Rosh Chodesh';

  @override
  String get roshHodeshBegins => 'Inizia al tramonto del';

  @override
  String get openParashaSefaria => 'Leggi questa porzione della Torà su Sefaria';

  @override
  String get skyMyLocation => 'My location';

  @override
  String get skyLocationLocalTimes =>
      'Gli orari del cielo usano il fuso orario di questa posizione. Il fuso orario delle sveglie e la tua città di Shabbat non cambiano. Salvato solo su questo dispositivo.';

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
  String get settingsAlarmDefaults => 'Impostazioni predefinite delle sveglie';

  @override
  String get settingsPlacesTime => 'Luoghi e ora';

  @override
  String get settingsLook => 'Aspetto, lingua e citazioni';

  @override
  String get settingsAbout => 'About';

  @override
  String get defaultForNewAlarms => 'Predefinito per le nuove sveglie';

  @override
  String get preview => 'Preview';

  @override
  String atClock(String time) {
    return 'at $time';
  }

  @override
  String get connectACalendar => 'Collega un calendario';

  @override
  String get newFromReadyMade => 'Da un modello pronto';

  @override
  String get newFromReadyMadeHint => 'Alba, tramonto e altre sveglie già pronte per te';

  @override
  String get calendarSourcesIntro =>
      'Quando? può suonare prima e dopo gli eventi dei tuoi calendari. Scegli da dove arrivano.';

  @override
  String get deviceCalendarsHeading => 'SU QUESTO DISPOSITIVO';

  @override
  String get deviceCalendarsTitle => 'L\'app calendario di questo dispositivo';

  @override
  String get deviceCalendarsHint =>
      'Tutti i suoi account: Google, Samsung, Outlook, iCloud e i calendari tenuti solo qui.';

  @override
  String get googleCalendarHeading => 'GOOGLE CALENDAR';

  @override
  String get googleCalendarSignIn =>
      'Accedi con Google per leggere i tuoi calendari direttamente da Google, anche se il tuo account Google non è su questo dispositivo.';

  @override
  String googleCalendarSignedIn(String email) {
    return 'Accesso come $email';
  }

  @override
  String get googleCalendarSignOut => 'Esci';

  @override
  String get googleCalendarNotHere =>
      'L\'accesso con Google non è ancora disponibile su questo dispositivo. Aggiungi il tuo account Google nelle impostazioni del dispositivo (Calendario › Account) e i suoi calendari compariranno qui.';

  @override
  String get googleCalendarUnreachable =>
      'Google Calendar non è raggiungibile ora. Le sveglie già impostate da lì suonano comunque.';

  @override
  String get googleCalendarTwiceHint =>
      'I calendari dello stesso account Google già presenti su questo dispositivo partono spenti, così niente suona due volte.';

  @override
  String get timersTitle => 'Timer';

  @override
  String get timerStopwatch => 'Cronometro';

  @override
  String get timerCountdown => 'Timer';

  @override
  String get timerSequence => 'Pronti';

  @override
  String get timerStopwatchSub => 'Conta in avanti, con giri';

  @override
  String get timerCountdownSub => 'Conto alla rovescia, suona a zero';

  @override
  String get timerSequenceSub => 'Via e segnali parlati';

  @override
  String get timerStart => 'Avvia';

  @override
  String get timerPause => 'Pausa';

  @override
  String get timerResume => 'Riprendi';

  @override
  String get timerReset => 'Azzera';

  @override
  String get timerLap => 'Giro';

  @override
  String get timerTimesUp => 'Tempo scaduto';

  @override
  String get timerSetTime => 'Imposta il tempo';

  @override
  String get timerMinutes => 'Minuti';

  @override
  String get timerSeconds => 'Secondi';

  @override
  String get seqOnYourMarks => 'Ai vostri posti';

  @override
  String get seqGetSet => 'Pronti';

  @override
  String get seqGo => 'Via!';

  @override
  String get seqFinish => 'Tempo!';

  @override
  String get seqReady => 'Pronto';

  @override
  String get seqSettings => 'Impostazioni';

  @override
  String get seqStartCalls => 'Avvisi prima del via';

  @override
  String get seqStartCallsHelp => 'Detti ad alta voce prima del Via, contando alla rovescia dal via.';

  @override
  String seqCallBefore(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n secondi prima',
      one: '1 secondo prima',
    );
    return '$_temp0';
  }

  @override
  String get seqAddCall => 'Aggiungi un avviso';

  @override
  String get seqCallText => 'Cosa dire';

  @override
  String get seqGoText => 'Al via, dire';

  @override
  String get seqFinishText => 'Alla fine, dire';

  @override
  String get seqLength => 'Durata';

  @override
  String get seqNoLimit => 'Nessun limite';

  @override
  String get seqSayEvery => 'Dì il tempo ogni';

  @override
  String get seqOff => 'No';

  @override
  String seqEverySeconds(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n secondi', one: '1 secondo');
    return '$_temp0';
  }

  @override
  String seqEveryMinutes(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n minuti', one: '1 minuto');
    return '$_temp0';
  }

  @override
  String get seqFinalCount => 'Conto alla rovescia degli ultimi';

  @override
  String get seqMarks => 'I tuoi segnali';

  @override
  String get seqAddMark => 'Aggiungi un segnale';

  @override
  String seqMarkAt(String time) {
    return 'A $time';
  }

  @override
  String get seqSpeak => 'Parla ad alta voce';

  @override
  String get seqBeeps => 'Bip e vibrazione';

  @override
  String get seqSayRemaining => 'Dì il tempo rimasto, non quello trascorso';

  @override
  String get seqPresets => 'Preset';

  @override
  String get seqPresetRace => 'Partenza di gara';

  @override
  String get seqPresetSprint => 'Sforzo di 30 s';

  @override
  String get seqPresetRound => 'Round di 1 min';

  @override
  String get seqHintNoLimit => 'Dopo il Via conta in avanti finché non lo fermi.';

  @override
  String get seqHintLength => 'Dopo il Via conta alla rovescia fino a zero.';

  @override
  String get seqWords => 'Parole';

  @override
  String get homeEdit => 'Arrange home';

  @override
  String get homeEditHint =>
      'Trascina la maniglia per spostare una scheda, comprimerla o cambiarne la dimensione.';

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
  String get homeBlockSky => 'SOLE, LUNA E METEO';

  @override
  String get homeBlockQuick => 'QUICK ALARMS';

  @override
  String get homeBlockShabbat => 'SHABBAT E FESTE';

  @override
  String get homePlaceTitle => 'Città per il cielo';

  @override
  String nextAlarmLine(String title, String time) {
    return 'Prossima sveglia · $title $time';
  }

  @override
  String get showAllAlarms => 'Mostra tutti i giorni';

  @override
  String get noAlarmsThatDay => 'Niente suona in questo giorno';

  @override
  String get homeClockSize => 'Orologio nella home';

  @override
  String get sizeSmall => 'Piccolo';

  @override
  String get sizeMedium => 'Medio';

  @override
  String get sizeLarge => 'Grande';

  @override
  String get homeLayout => 'Layout della home';

  @override
  String get homeLayoutClassic => 'Classico';

  @override
  String get homeLayoutCards => 'Schede';

  @override
  String get homeCardsHint =>
      'Trascina una scheda per spostarla. Trascina il bordo o l\'angolo per ridimensionarla, o scegli una misura.';

  @override
  String get homeAddCard => 'Aggiungi scheda';

  @override
  String get homeOnHome => 'Nella home';

  @override
  String get homeRemoveCard => 'Rimuovi';

  @override
  String get cardNext => 'Prossima sveglia';

  @override
  String get cardClock => 'Orologio e data';

  @override
  String get cardSky => 'Sole, luna e meteo';

  @override
  String get cardMoon => 'Luna';

  @override
  String get cardWeather => 'Meteo';

  @override
  String get cardAlarms => 'Le tue sveglie';

  @override
  String get cardQuick => 'Sveglie rapide';

  @override
  String get cardTools => 'Cronometro, timer e pronti';

  @override
  String get cardWorld => 'Orologi del mondo';

  @override
  String get cardWeek => 'Questa settimana';

  @override
  String get cardShabbat => 'Shabbat e festività';

  @override
  String get ringAtEventReminders => 'Suona ai promemoria dell\'evento';

  @override
  String get ringAtEventRemindersHint =>
      'I promemoria della tua app calendario suonano qui come sveglie forti, con il suono di questa sveglia.';

  @override
  String get atEventReminders => 'ai promemoria dell\'evento';

  @override
  String get everyEventReminderLoud => 'Suona forte ai promemoria di ogni evento';

  @override
  String get loudNotificationsHeading => 'NOTIFICHE DEL CALENDARIO A VOLUME ALTO';

  @override
  String get loudNotificationsTitle => 'Rendi forti le notifiche del calendario';

  @override
  String get loudNotificationsHint =>
      'Quando un\'app calendario mostra un promemoria, Quando? lo fa suonare come sveglia, anche col telefono in silenzioso.';

  @override
  String get loudNotificationsDisclosureTitle =>
      'Consentire a Quando? di leggere le notifiche del calendario?';

  @override
  String get loudNotificationsDisclosure =>
      'Per far suonare i promemoria del calendario, Quando? ha bisogno dell\'accesso alle notifiche. Guarda solo quelle delle app calendario che scegli, ne legge titolo e testo su questo telefono per mostrarli sulla sveglia, e non li salva né li invia mai. Puoi disattivarlo quando vuoi.';

  @override
  String get loudNotificationsAgree => 'Accetta e continua';

  @override
  String get loudNotificationsNoAccess =>
      'L\'accesso alle notifiche è disattivato. Attiva Quando? nell\'elenco che si apre.';

  @override
  String get loudNotificationsAllow => 'Consenti';

  @override
  String get loudNotificationsNoApps => 'Nessuna app calendario supportata su questo telefono.';

  @override
  String get loudNotificationsTwiceNote =>
      'Gli eventi che hanno già una sveglia di calendario Quando? suonano una volta sola.';

  @override
  String get loudNotificationsShabbatNote => 'In silenzio durante lo Shabbat e le feste.';

  @override
  String get busyMode => 'Modalità occupato';

  @override
  String get busyModeSubtitle => 'Non disturbare e risposte automatiche quando sei occupato';

  @override
  String get busyIntro =>
      'Mentre sei occupato, Quando? può silenziare il telefono e rispondere ai messaggi per te. Le sveglie suonano comunque.';

  @override
  String get busyIosFocus =>
      'Su iPhone e iPad le app non possono attivare Full immersion né rispondere ai messaggi. Nell\'app Comandi crea un\'automazione \"Quando si apre Quando?\" o a un orario che attivi una Full immersion, e impostala per rispondere automaticamente.';

  @override
  String get busyWhileHeading => 'MENTRE SEI OCCUPATO';

  @override
  String get busyDnd => 'Non disturbare';

  @override
  String get busyDndHint =>
      'Solo priorità: chiamate e messaggi in silenzio, le sveglie suonano. Torna normale alla fine.';

  @override
  String get busyDndNoAccess => 'Quando? non può ancora cambiare Non disturbare.';

  @override
  String get busyReplies => 'Rispondi ai messaggi';

  @override
  String get busyRepliesHint =>
      'Una volta per persona, col tuo testo, tramite il pulsante Rispondi dell\'app. Solo Android.';

  @override
  String get busyRepliesDisclosureTitle => 'Consentire a Quando? di rispondere ai messaggi?';

  @override
  String get busyRepliesDisclosure =>
      'Per rispondere al posto tuo, Quando? ha bisogno dell\'accesso alle notifiche. Solo mentre sei occupato, guarda le notifiche dei messaggi delle app che scegli, legge il nome del mittente su questo telefono e invia il tuo testo una volta tramite il pulsante Rispondi dell\'app. I messaggi non vengono mai salvati né inviati altrove. I gruppi sono esclusi, se non li consenti.';

  @override
  String get busyReplyText => 'La tua risposta';

  @override
  String busyReplyTextHint(String until) {
    return '$until diventa l\'ora in cui finisce la modalità occupato.';
  }

  @override
  String busyReplyDefault(String until) {
    return 'Ora sono occupato, rispondo dopo le $until.';
  }

  @override
  String get busyGroups => 'Rispondi anche nei gruppi';

  @override
  String get busyGroupsHint => 'Disattivato: i gruppi non ricevono mai risposta.';

  @override
  String get busyRepliesOnShabbat => 'Rispondi durante Shabbat e feste';

  @override
  String get busyAskRabbi => 'Disattivato di default. Chiedi al tuo rabbino prima di attivarlo per Shabbat.';

  @override
  String get busyWhenHeading => 'QUANDO SEI OCCUPATO';

  @override
  String get busyWhenHint =>
      'Attiva \"Occupato durante questi eventi\" su una sveglia di calendario, o \"Occupato dopo che suona\" su una sveglia.';

  @override
  String get busyDuringLock => 'Occupato mentre la modalità blocco è attiva';

  @override
  String get busyNoneComing => 'Niente di occupato nei prossimi 7 giorni.';

  @override
  String get busyDuringEvents => 'Occupato durante questi eventi';

  @override
  String get busyDuringEventsHint => 'Modalità occupato dall\'inizio alla fine di ogni evento.';

  @override
  String get busySettings => 'Impostazioni modalità occupato';

  @override
  String get busyAfterRing => 'Occupato dopo che suona';

  @override
  String get busyAfterRingHint =>
      'Non disturbare e risposte automatiche per un po\', ad es. allenamento o pisolino.';

  @override
  String get shareCard => 'Condividi il tuo mattino';

  @override
  String get shareCardSubtitle => 'Il cielo e la frase di oggi, o la tua foto, per Storie e stati';

  @override
  String get shareAppMissing => 'Quell\'app non è su questo telefono.';

  @override
  String get shareAsIs => 'Condividi così com\'è';

  @override
  String get shareTapQuote => 'Tocca la frase per cambiarla.';

  @override
  String get shareStory => 'Storia';

  @override
  String get shareSquare => 'Quadrato';

  @override
  String get shareYourWords => 'Le tue parole (facoltativo)';

  @override
  String get shareYourWordsHint => 'Al posto della frase di oggi';

  @override
  String get shareYourPhoto => 'La tua foto';

  @override
  String get shareOtherPhoto => 'Un\'altra foto';

  @override
  String get shareSkyBack => 'Il cielo di oggi';

  @override
  String get shareYourVideo => 'Il tuo video';

  @override
  String get shareInstagramStory => 'Storie di Instagram';

  @override
  String get shareWhatsApp => 'WhatsApp: stato o chat';

  @override
  String get shareMore => 'Altre app';

  @override
  String get shareYouPost => 'Quando? apre l\'app con la tua card pronta. Scegli tu dove e tocchi Pubblica.';

  @override
  String get shareAndroidFirst => 'La condivisione arriva presto su iPhone e iPad.';

  @override
  String songSaved(String name) {
    return '“$name” salvato come suono della sveglia';
  }

  @override
  String get shareToQuando => 'Condividi un brano con Quando?';

  @override
  String get shareToQuandoHint =>
      'In YouTube, YouTube Music, Spotify, SoundCloud o Apple Music tocca Condividi e poi Quando?. Diventa un suono della sveglia che parte nella sua app.';

  @override
  String get askOption => 'Dillo o scrivilo';

  @override
  String get askOptionHint => '“Domani alle 6”, “30 min prima dell\'alba”';

  @override
  String get askHint => 'es.: svegliami 30 min prima dell\'alba nei giorni feriali';

  @override
  String get askListening => 'In ascolto…';

  @override
  String get askNotUnderstood =>
      'Non ho trovato un orario. Prova “alle 7 nei giorni feriali” o “tra 20 minuti”.';

  @override
  String askAnswerFromCalendar(String name) {
    return 'Dal tuo calendario “$name”';
  }

  @override
  String get askAnswerBuiltIn => 'Orari di Quando? per la tua città';

  @override
  String get askNoAnswer => 'Nessun orario trovato per ora.';

  @override
  String get askNoSpeech => 'La voce non è disponibile su questo dispositivo. Puoi scrivere.';

  @override
  String get askShabbatOff => 'Attiva lo Shabbat nelle Impostazioni perché i suoi orari suonino.';

  @override
  String askSaved(String what) {
    return 'Salvato: $what';
  }

  @override
  String get askMic => 'Parla';

  @override
  String get askMorning => 'Mattina';

  @override
  String get askEvening => 'Sera';

  @override
  String get askUnsure => 'Forse mi è sfuggito qualcosa. Controlla prima di salvare.';

  @override
  String get askTeach => 'Insegnamelo';

  @override
  String askTaught(String phrase, String time) {
    return 'Capito: “$phrase” ora vuol dire $time.';
  }

  @override
  String get askSkipAction => 'Salta';

  @override
  String get askNoMatch => 'Nessuna sveglia corrisponde.';

  @override
  String askTurnedOff(String what) {
    return 'Disattivata: $what';
  }

  @override
  String askSkipped(String what) {
    return 'Saltata: $what';
  }

  @override
  String askEventPlan(String offset, String event) {
    return '$offset “$event” nel tuo calendario';
  }

  @override
  String askEventNoCalendar(String event) {
    return 'Collega un calendario perché Quando? trovi “$event”.';
  }

  @override
  String askSnoozeAll(int minutes) {
    return 'Posticipa: $minutes min, per tutte le sveglie';
  }

  @override
  String askWakeWith(String sound) {
    return 'Ti sveglia con $sound';
  }

  @override
  String get askReadAs => 'Letto come';

  @override
  String get syncHeading => 'Quando il calendario cambia';

  @override
  String get syncLive => 'Segui il calendario';

  @override
  String get syncLiveHint =>
      'I nuovi eventi hanno una sveglia. Se un evento si sposta, si sposta anche la sveglia. Se viene cancellato, la sveglia sparisce.';

  @override
  String get syncKeepFirst => 'Tieni com\'era all\'inizio';

  @override
  String get syncKeepFirstHint =>
      'I nuovi eventi hanno comunque una sveglia. Una volta impostata, la sveglia resta lì, anche se l\'evento si sposta o viene cancellato.';

  @override
  String get syncSnapshot => 'Solo gli eventi che ci sono ora';

  @override
  String get syncSnapshotHint =>
      'Solo gli eventi nel calendario quando salvi, così come sono ora. Dopo non si aggiunge nulla di nuovo.';

  @override
  String get syncHelpButton => 'Come funziona';

  @override
  String get syncHelpTitle => 'Come le sveglie seguono il calendario';

  @override
  String get syncHelpIntro =>
      'Questa regola continua a cercare gli eventi che corrispondono alla tua ricerca. Scegli tu cosa succede quando il calendario cambia.';

  @override
  String get syncHelpExampleLive =>
      'Esempio: una regola per “dentista”. Il dentista sposta l\'appuntamento da martedì a mercoledì, e anche la sveglia passa a mercoledì. Se l\'appuntamento viene annullato, la sveglia sparisce.';

  @override
  String get syncHelpExampleKeepFirst =>
      'Stessa regola: l\'appuntamento passa a mercoledì, ma la sveglia resta martedì, come Quando? l\'ha visto all\'inizio. Un nuovo appuntamento il mese prossimo ha comunque la sua sveglia.';

  @override
  String get syncHelpExampleSnapshot =>
      'Stessa regola: hai sveglie per gli appuntamenti che ci sono oggi nel calendario, e restano così. Un appuntamento aggiunto il mese prossimo non ha sveglia.';

  @override
  String get syncHelpTip => 'Nel dubbio? Lascia “Segui il calendario”.';

  @override
  String get syncHelpWhenTitle => 'Quando si accorge Quando? dei cambiamenti?';

  @override
  String get syncHelpWhenOpen =>
      'Con Quando? aperta: in pochi secondi. Google Calendar collegato qui viene controllato ogni 2 minuti.';

  @override
  String get syncHelpWhenClosed =>
      'Con Quando? chiusa: la prossima volta che la apri. Fino ad allora, le sveglie già impostate suonano agli orari che avevano.';

  @override
  String get syncHelpWhenClosedApple =>
      'iPhone e iPad non lasciano alle app guardare il calendario in background, quindi i cambiamenti arrivano quando apri Quando?.';

  @override
  String get tapMiddleToStop => 'Tocca il centro per fermare';

  @override
  String get quickSetups => 'Impostazioni rapide';

  @override
  String get qsMorningTitle => 'Una mattina che funziona';

  @override
  String get qsStartTitle => 'Non perdere nessun inizio';

  @override
  String get qsStretchTitle => 'Lavora a tappe';

  @override
  String get qsWillChange => 'Cosa cambierà';

  @override
  String get qsAlreadyOn => 'Già attivo. Niente da cambiare.';

  @override
  String get qsApply => 'Applica';

  @override
  String get qsDone => 'Fatto';

  @override
  String get qsUndo => 'Annulla';

  @override
  String get qsSnoozeTimes => 'Rinvii consentiti';

  @override
  String get qsSnoozeMinutes => 'Minuti di rinvio';

  @override
  String get qsFiveLeft => 'Mancano 5 minuti';

  @override
  String get uiSimple => 'Semplice';

  @override
  String get uiEverything => 'Tutto';

  @override
  String get firstRunTitle => 'Quanto vuoi vedere?';

  @override
  String get firstRunSimpleHint => 'Sveglie e le basi';

  @override
  String get firstRunEverythingHint => 'Calendario, Shabbat, timer, meteo e altro';

  @override
  String get firstRunChangeLater => 'Puoi cambiarlo quando vuoi nelle Impostazioni.';

  @override
  String get continueLabel => 'Continua';

  @override
  String get everyAlarm => 'Ogni sveglia';

  @override
  String get wakeMeWith => 'Svegliami con';

  @override
  String get ringOrMusic => 'Suoneria o musica';

  @override
  String get ringsForRow => 'Suona per';

  @override
  String gentleBeforeValue(int minutes) {
    return '$minutes min prima';
  }

  @override
  String get quandoSounds => 'Suoni di Quando?';

  @override
  String get aSongApps => 'Una canzone (Spotify, YouTube…)';

  @override
  String get myRecording => 'La mia registrazione';

  @override
  String get useForNewAlarms => 'Usa per le nuove sveglie';

  @override
  String get iWillLabel => 'Quando suona, io…';

  @override
  String get foldVolume => 'Volume e dissolvenze';

  @override
  String get foldSnoozeStop => 'Posticipa e ferma';

  @override
  String get foldExtras => 'Calendario e extra';

  @override
  String get groupAlarms => 'Sveglie';

  @override
  String get groupCalendarShabbat => 'Calendario e Shabbat';

  @override
  String get groupLookQuotes => 'Aspetto e citazioni';

  @override
  String get groupConnectionsSync => 'Collegamenti e sincronizzazione';

  @override
  String qsSummary(int count, int on) {
    return '$count impostazioni · $on attiva/e';
  }
}
