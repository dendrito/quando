// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get undo => 'Annuler';

  @override
  String duplicatedNamed(String name) {
    return '« $name » dupliquée';
  }

  @override
  String deletedNamed(String name) {
    return '« $name » supprimée';
  }

  @override
  String get when => 'Quand ?';

  @override
  String get newAtTime => 'À une heure';

  @override
  String get newAtTimeHint => 'Chaque jour de semaine à 7:00, une fois à 15:30…';

  @override
  String get newAroundEvent => 'Autour d’un événement';

  @override
  String get newAroundEventHint =>
      'Cherchez dans les agendas, le Chabbat et le soleil, puis sonnez avant, à l’heure ou après';

  @override
  String get editThisAlarm => 'Modifier cette alarme';

  @override
  String editNamed(String name) {
    return 'Modifier « $name »';
  }

  @override
  String get preset => 'modèle';

  @override
  String get editThisCalendarRule => 'Modifier cette règle d’agenda';

  @override
  String get ringThisOneAfterAll => 'Faire sonner celle-ci finalement';

  @override
  String get skipJustThisOne => 'Sauter seulement celle-ci';

  @override
  String get renameGroup => 'Renommer le groupe';

  @override
  String quickSet(String label, String time) {
    return '$label · sonne à $time';
  }

  @override
  String get newAlarm => 'Nouvelle alarme';

  @override
  String get appName => 'Quando?';

  @override
  String get lockMode => 'Mode verrouillage';

  @override
  String get calendars => 'Agendas';

  @override
  String get settings => 'Réglages';

  @override
  String get nextAlarmHeading => 'PROCHAINE ALARME';

  @override
  String get nothingSet => 'Rien de prévu';

  @override
  String get tagline => 'Chaque chose en son temps.';

  @override
  String sunriseAt(String time) {
    return 'Lever du soleil $time';
  }

  @override
  String sunsetAt(String time) {
    return 'Coucher du soleil $time';
  }

  @override
  String get alarmsMayNotRing => 'Vos alarmes risquent de ne pas sonner';

  @override
  String get tapToFixIt => 'Touchez pour corriger';

  @override
  String inMinutes(int minutes) {
    return 'Dans $minutes min';
  }

  @override
  String get atSunset => 'Au coucher du soleil';

  @override
  String get sunset => 'Coucher du soleil';

  @override
  String get shabbatModeIsOn => 'MODE CHABBAT ACTIVÉ';

  @override
  String nextInCity(String city) {
    return 'PROCHAIN · $city';
  }

  @override
  String get candleLighting => 'Allumage des bougies';

  @override
  String get havdalah => 'Havdala';

  @override
  String get shabbatAndFestivals => 'Chabbat et fêtes';

  @override
  String get yourAlarmsHeading => 'VOS ALARMES';

  @override
  String get tapWhenToAdd => 'Touchez Quand ? pour ajouter une alarme.';

  @override
  String get aroundEventsHeading => 'AUTOUR D’ÉVÉNEMENTS';

  @override
  String searchFor(String words) {
    return 'recherche : $words';
  }

  @override
  String get thisWeekHeading => 'ALARMES DE LA SEMAINE';

  @override
  String get noAlarmsThisWeek => 'Aucune alarme dans les 7 prochains jours.';

  @override
  String get alarmsSetThemselves =>
      'Les alarmes se règlent toutes seules sur ce téléphone dès que vous changez quelque chose.';

  @override
  String cityTime(String city) {
    return 'heure de $city';
  }

  @override
  String get more => 'Plus';

  @override
  String get turnOff => 'Désactiver';

  @override
  String get turnOn => 'Activer';

  @override
  String get duplicate => 'Dupliquer';

  @override
  String get delete => 'Supprimer';

  @override
  String get inOneHour => 'Dans 1 heure';

  @override
  String get logoLabel => 'Logo de Quando?';

  @override
  String get noTimesSet => 'Aucun horaire';

  @override
  String get atTheMoment => 'au moment même';

  @override
  String timesRange(int count, String from, String to) {
    return '$count fois · de $from à $to';
  }

  @override
  String spanDays(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n jours', one: '1 jour');
    return '$_temp0';
  }

  @override
  String spanHours(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n heures', one: '1 heure');
    return '$_temp0';
  }

  @override
  String spanMinutes(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n minutes', one: '1 minute');
    return '$_temp0';
  }

  @override
  String spanSeconds(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n secondes', one: '1 seconde');
    return '$_temp0';
  }

  @override
  String get now => 'maintenant';

  @override
  String spanBefore(String span) {
    return '$span avant';
  }

  @override
  String spanAfter(String span) {
    return '$span après';
  }

  @override
  String alarmCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n alarmes', one: '1 alarme');
    return '$_temp0';
  }

  @override
  String get allOn => 'toutes activées';

  @override
  String get allOff => 'toutes désactivées';

  @override
  String someOn(int n) {
    return '$n activées';
  }

  @override
  String skippedBody(String body) {
    return 'Sautée · $body';
  }

  @override
  String timeToTime(String from, String to) {
    return '$from à $to';
  }

  @override
  String skippedCount(int n) {
    return '$n sautées';
  }

  @override
  String get sunNoRiseSet => 'Le soleil ne se lève ni ne se couche ici aujourd’hui';

  @override
  String sunProgress(int percent) {
    return 'Le soleil a parcouru $percent % de la journée';
  }

  @override
  String get sunIsDown => 'Le soleil est couché';

  @override
  String get searchCity => 'Chercher une ville';

  @override
  String get tomorrowLower => 'demain';

  @override
  String get yesterdayLower => 'hier';

  @override
  String get worldClocksHeading => 'HORLOGES DU MONDE';

  @override
  String get add => 'Ajouter';

  @override
  String cityHere(String city) {
    return '$city · ici';
  }

  @override
  String get worldClocksHint =>
      'Ajoutez des villes pour voir leur heure ici. Glissez vers la gauche pour en retirer une.';

  @override
  String get groupNameHint => 'Travail, Enfants, Sport…';

  @override
  String get cancel => 'Annuler';

  @override
  String get ok => 'OK';

  @override
  String get noGroup => 'Aucun groupe';

  @override
  String get newGroupEllipsis => 'Nouveau groupe…';

  @override
  String get newGroup => 'Nouveau groupe';

  @override
  String secondsShort(int n) {
    return '$n s';
  }

  @override
  String minutesShort(int n) {
    return '$n min';
  }

  @override
  String get minutes => 'Minutes';

  @override
  String get ringFor => 'Sonner pendant';

  @override
  String get seconds => 'Secondes';

  @override
  String get oneSecondLess => '1 seconde de moins';

  @override
  String get oneSecondMore => '1 seconde de plus';

  @override
  String inDays(int d) {
    return 'dans $d j';
  }

  @override
  String inDaysHours(int d, int h) {
    return 'dans $d j $h h';
  }

  @override
  String inHours(int h) {
    return 'dans $h h';
  }

  @override
  String inHoursMinutes(int h, int m) {
    return 'dans $h h $m min';
  }

  @override
  String inMins(int m) {
    return 'dans $m min';
  }

  @override
  String placeChange(String city, String where) {
    return '$city · $where · changer';
  }

  @override
  String get israel => 'Israël';

  @override
  String get outsideIsrael => 'hors d’Israël';

  @override
  String get comingUpHeading => 'À VENIR';

  @override
  String get lockForShabbat => 'Verrouiller le téléphone pendant Chabbat';

  @override
  String get lockForShabbatHint => 'De l’allumage des bougies à la Havdala, fêtes comprises';

  @override
  String get ownShabbatAlarmsHeading => 'VOS ALARMES DE CHABBAT';

  @override
  String get addShabbatAlarm => 'Ajouter une alarme de Chabbat ou de fête';

  @override
  String get readyMadeHeading => 'ALARMES PRÊTES';

  @override
  String bringBackDeleted(int n) {
    return 'Récupérer les supprimées ($n)';
  }

  @override
  String get presetsHint => 'Touchez-en une pour changer ses horaires. Glissez pour la supprimer.';

  @override
  String get lockSentence =>
      'Réduisez le téléphone à l’horloge et à vos alarmes, pour Chabbat ou une nuit de concentration.';

  @override
  String get lockExplain =>
      'Une fois verrouillé, Quando? n’affiche que l’heure, la prochaine alarme et la fin du verrouillage. Les alarmes continuent de fonctionner et rien ne peut être modifié avant le déverrouillage.';

  @override
  String get lockNowHeading => 'VERROUILLER MAINTENANT';

  @override
  String get lockAutoHeading => 'VERROUILLER AUTOMATIQUEMENT';

  @override
  String get shabbatAndFestivalsLong => 'Chabbat et fêtes';

  @override
  String get fromCandleToHavdalah => 'De l’allumage des bougies à la Havdala';

  @override
  String get lockCalendarWord => 'Pendant les événements d’agenda contenant ce mot';

  @override
  String get lockCalendarWordHint => 'ex. verrou, examen, concentration';

  @override
  String get leaveEmptyForNone => 'Laisser vide pour aucun';

  @override
  String get connectCalendarsFirst => 'Connectez d’abord les agendas (icône agenda)';

  @override
  String get openWhenLockStarts => 'Ouvrir Quando? au début d’un verrouillage';

  @override
  String get openWhenLockStartsHint =>
      'Un léger carillon d’1 seconde ramène Quando? au premier plan pour verrouiller';

  @override
  String get pinToScreen => 'Épingler Quando? à l’écran';

  @override
  String get pinToScreenHint =>
      'Les autres applis ne s’ouvrent pas pendant le verrouillage. Android demande une confirmation la première fois.';

  @override
  String get noLocksComingUp => 'Aucun verrouillage à venir.';

  @override
  String get leaveLockEarly => 'Pour sortir plus tôt, maintenez « Maintenir pour déverrouiller » 3 secondes.';

  @override
  String get locked => 'Verrouillé';

  @override
  String get shabbatShalom => 'Chabbat chalom';

  @override
  String get chagSameach => 'Hag saméah';

  @override
  String get unlocksHeading => 'SE DÉVERROUILLE';

  @override
  String get nowCap => 'Maintenant';

  @override
  String get nextAlarm => 'Prochaine alarme';

  @override
  String get holdToUnlock => 'Maintenir pour déverrouiller';

  @override
  String get calendarAlarm => 'Alarme d’agenda';

  @override
  String get calendarIntro =>
      'Quando? peut sonner avant et après les événements des agendas de votre téléphone. Google Agenda est inclus dès que votre compte Google est sur le téléphone.';

  @override
  String get connectCalendars => 'Connecter les agendas';

  @override
  String get calendarAlarmsHeading => 'ALARMES D’AGENDA';

  @override
  String get calendarNoneYet => 'Aucune pour l’instant. Commencez par celle-ci, puis ajustez-la :';

  @override
  String get fifteenBeforeEvery => '15 minutes avant chaque événement';

  @override
  String get useTheseCalendarsHeading => 'UTILISER CES AGENDAS';

  @override
  String get noTimedEvents => 'Aucun événement horaire à venir dans ces agendas.';

  @override
  String get atTheStart => 'au début';

  @override
  String everyForBefore(String every, String span) {
    return 'toutes les $every pendant $span avant';
  }

  @override
  String spanAfterItEnds(String span) {
    return '$span après la fin';
  }

  @override
  String get noAlarmsChosen => 'Aucune alarme choisie';

  @override
  String get gentleWakeUp => 'Réveil en douceur';

  @override
  String gentleSummary(int minutes, String sound) {
    return '$minutes min avant · $sound';
  }

  @override
  String get off => 'Désactivé';

  @override
  String get gentleSentence =>
      'Un son apaisant commence doucement avant votre alarme, pour ne jamais vous réveiller en sursaut.';

  @override
  String get gentleExplain =>
      'Il monte lentement, vous sort du sommeil léger, et s’arrête juste avant que l’alarme sonne.';

  @override
  String get startsBeforeHeading => 'COMMENCE AVANT L’ALARME';

  @override
  String get leadUpSoundHeading => 'SON D’APPROCHE';

  @override
  String get listen => 'Écouter';

  @override
  String get whoRecordedThese => 'Qui a enregistré ces sons';

  @override
  String get done => 'Terminé';

  @override
  String get soundCredits => 'Crédits sonores';

  @override
  String yourTimeCity(String city) {
    return 'Votre heure ($city)';
  }

  @override
  String get anotherCity => 'Une autre ville…';

  @override
  String get ringingIn5 => 'Sonnerie dans 5 secondes…';

  @override
  String get alarmSaved => 'Alarme enregistrée.';

  @override
  String alarmSetFor(String span) {
    return 'Alarme réglée dans $span.';
  }

  @override
  String hoursMinutesShort(int h, int m) {
    return '$h h $m min';
  }

  @override
  String get editAlarm => 'Modifier l’alarme';

  @override
  String get previewCaps => 'ESSAYER';

  @override
  String get saveCaps => 'ENREGISTRER';

  @override
  String cityTimeForYou(String city, String time) {
    return 'heure de $city · $time pour vous';
  }

  @override
  String repeatHeading(String repeat) {
    return 'RÉPÉTER · $repeat';
  }

  @override
  String get labelField => 'Libellé (lu à voix haute si les alarmes parlées sont activées)';

  @override
  String get group => 'Groupe';

  @override
  String ringsForHeading(String span) {
    return 'SONNE PENDANT $span';
  }

  @override
  String useDefault(String value) {
    return 'Utiliser la valeur par défaut ($value)';
  }

  @override
  String get save => 'Enregistrer';

  @override
  String get sameTime => 'même heure';

  @override
  String get untilYouStopIt => 'Jusqu’à l’arrêt';

  @override
  String get alarm => 'Alarme';

  @override
  String get once => 'Une fois';

  @override
  String get everyDay => 'Tous les jours';

  @override
  String get weekdays => 'En semaine';

  @override
  String get weekends => 'Le week-end';

  @override
  String timeInCity(String time, String city) {
    return '$time heure de $city';
  }

  @override
  String eventsMatching(String words) {
    return 'Événements contenant « $words »';
  }

  @override
  String get everyEvent => 'Tous les événements';

  @override
  String get sunrise => 'Lever du soleil';

  @override
  String havdalahEndOf(String day) {
    return 'Havdala · fin de $day';
  }

  @override
  String get yomTov => 'Yom Tov';

  @override
  String get shabbat => 'Chabbat';

  @override
  String get presetCountdown => 'Compte à rebours jusqu’à l’allumage des bougies';

  @override
  String get presetHourly => 'Toutes les heures, dès 6 heures avant';

  @override
  String get presetDailyWeek => 'Une fois par jour, la semaine d’avant';

  @override
  String get presetSecondNight => 'Bougies du second soir';

  @override
  String get presetFridayReminder => 'Rappel 3 heures avant : chargez votre téléphone';

  @override
  String get presetFridayReminderLabel => 'Chargez votre téléphone et réglez les alarmes de demain';

  @override
  String get presetSunset => 'Coucher du soleil, et 15 minutes avant';

  @override
  String get pesach => 'Pessah';

  @override
  String get shavuot => 'Chavouot';

  @override
  String get roshHashanah => 'Roch Hachana';

  @override
  String get yomKippur => 'Yom Kippour';

  @override
  String get sukkot => 'Souccot';

  @override
  String get sheminiAtzeret => 'Chemini Atseret';

  @override
  String get simchatTorah => 'Simhat Torah';

  @override
  String get readyNotifications => 'Afficher les alarmes';

  @override
  String get readyNotificationsWhy => 'Permet d’afficher l’écran de sonnerie et le bouton Arrêter.';

  @override
  String get readyFullScreen => 'Sonner par-dessus l’écran verrouillé';

  @override
  String get readyFullScreenWhy => 'Affiche l’alarme en plein écran, même téléphone verrouillé.';

  @override
  String get readyExact => 'Sonner à la minute près';

  @override
  String get readyExactWhy =>
      'Sans cela, le téléphone peut faire sonner les alarmes avec quelques minutes de retard.';

  @override
  String get readyBattery => 'Continuer en économie de batterie';

  @override
  String get readyBatteryWhy => 'Empêche l’économie de batterie de couper les alarmes la nuit.';

  @override
  String get tipXiaomi =>
      'Téléphones Xiaomi : dans Paramètres › Applis › Quando?, activez Démarrage auto et réglez Économiseur de batterie sur Aucune restriction.';

  @override
  String get tipSamsung =>
      'Téléphones Samsung : dans Paramètres › Batterie › Limites d’utilisation en arrière-plan, vérifiez que Quando? n’est pas en veille.';

  @override
  String get tipHuawei =>
      'Téléphones Huawei et Honor : dans Paramètres › Batterie › Lancement d’applis, réglez Quando? sur Gérer manuellement et autorisez tout.';

  @override
  String get tipOther =>
      'Sur ce téléphone : dans Paramètres › Batterie, autorisez Quando? en arrière-plan et désactivez son optimisation.';

  @override
  String get testRing => 'Sonnerie test';

  @override
  String get testRingBody => 'Quando? peut vous réveiller';

  @override
  String get ringsIn20 => 'Sonne dans 20 secondes. Verrouillez le téléphone et attendez.';

  @override
  String get readyToRing => 'Prêt à sonner';

  @override
  String get checkingPhone => 'Vérification du téléphone…';

  @override
  String get phoneReady => 'Votre téléphone est prêt à faire sonner chaque alarme à l’heure.';

  @override
  String thingsNeedFixing(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n points à corriger, sinon les alarmes risquent de ne pas sonner.',
      one: '1 point à corriger, sinon les alarmes risquent de ne pas sonner.',
    );
    return '$_temp0';
  }

  @override
  String get fix => 'Corriger';

  @override
  String get testIn20 => 'Tester : sonner dans 20 secondes';

  @override
  String get testIn20Hint =>
      'Verrouillez le téléphone et posez-le. Si l’alarme sonne en plein écran, tout est prêt.';

  @override
  String get readyToRingHint => 'Vérifiez que votre téléphone laisse chaque alarme sonner à l’heure';

  @override
  String get connections => 'Connexions';

  @override
  String get timeZoneHeading => 'FUSEAU HORAIRE';

  @override
  String get followPhone => 'Suivre le téléphone';

  @override
  String followPhoneNow(String city) {
    return 'Actuellement $city. Change tout seul en voyage.';
  }

  @override
  String get zoneFixed => 'Fixe. Les alarmes gardent cette heure même en voyage.';

  @override
  String get shabbatCityHeading => 'VILLE POUR CHABBAT';

  @override
  String get inIsraelOneDay => 'En Israël (un jour de fête)';

  @override
  String candleMinutesHeading(int n) {
    return 'BOUGIES : $n MINUTES AVANT LE COUCHER DU SOLEIL';
  }

  @override
  String get endOfShabbatHeading => 'FIN DE CHABBAT ET DES FÊTES';

  @override
  String get nightfallGeonim => 'Tombée de la nuit (Guéonim, 8,5°)';

  @override
  String get rabbeinuTam => '72 minutes après le coucher du soleil (Rabbénou Tam)';

  @override
  String get whenAlarmRingsHeading => 'QUAND UNE ALARME SONNE';

  @override
  String get recordOrAddSounds => 'Enregistrer ou ajouter des sons';

  @override
  String get ringsForThisLong => 'Sonne pendant cette durée, puis s’arrête toute seule';

  @override
  String get sameFades => 'Mêmes fondus pour toutes les alarmes';

  @override
  String get sameFadesOn => 'Remplace les fondus de chaque alarme. Chacune garde son volume.';

  @override
  String get sameFadesOff => 'Désactivé : chaque alarme utilise les fondus réglés dans son Volume.';

  @override
  String get sayItOutLoud => 'Le dire à voix haute';

  @override
  String get sayItOutLoudHint => 'Lit à quoi sert l’alarme, ex. « Allumage des bougies, 15 minutes avant »';

  @override
  String get noSnooze => 'Pas de répétition';

  @override
  String snoozeUpTo(int times, int minutes) {
    return 'Répéter jusqu’à $times× de $minutes min';
  }

  @override
  String get wakeUpCheck => 'Vérification du réveil';

  @override
  String get wakeUpCheckHint =>
      'Après l’arrêt, resonne dans 3 minutes si vous ne touchez pas « Je suis levé »';

  @override
  String get solveSum => 'Résoudre un calcul pour arrêter';

  @override
  String get provesAwake => 'Prouve que vous êtes réveillé';

  @override
  String get shabbatNoTasks =>
      'Pendant Chabbat et les fêtes, rien de tout cela ne s’applique : les alarmes s’arrêtent seules et ne demandent jamais de toucher le téléphone.';

  @override
  String get testAlarmIn1 => 'Faire sonner une alarme test dans 1 minute';

  @override
  String get timesDisclaimer =>
      'Les horaires sont calculés sur votre téléphone. Dans les cas limites, consultez votre rabbin ou le calendrier de votre communauté.';

  @override
  String get recommended => 'Recommandé';

  @override
  String get chooseCity => 'Choisir une ville';

  @override
  String get testOnlyOnPhone => 'Les alarmes test ne fonctionnent que sur un téléphone.';

  @override
  String get testAlarm => 'Alarme test';

  @override
  String get testAlarmBody => 'Voici comment vos alarmes sonneront';

  @override
  String get testAlarmIn1Set => 'Alarme test dans 1 minute. Vous pouvez verrouiller le téléphone.';

  @override
  String get presetGone => 'Ce modèle n’existe plus.';

  @override
  String get editPreset => 'Modifier le modèle';

  @override
  String get on => 'Activé';

  @override
  String get ringsHeading => 'SONNE';

  @override
  String get noTimesYet => 'Aucun horaire. Ajoutez-en un ci-dessous.';

  @override
  String get atTheMomentItself => 'Au moment même';

  @override
  String get remove => 'Retirer';

  @override
  String get addATime => 'Ajouter un horaire';

  @override
  String get resetPreset => 'Revenir à l’original';

  @override
  String get skipOneHint =>
      'Pour sauter une seule alarme, touchez-la dans « Alarmes de la semaine » sur l’écran d’accueil.';

  @override
  String get unitMinutes => 'minutes';

  @override
  String get unitHours => 'heures';

  @override
  String get unitDays => 'jours';

  @override
  String get before => 'Avant';

  @override
  String get after => 'Après';

  @override
  String get oneWeek => '1 semaine';

  @override
  String daysShort(int n) {
    return '$n j';
  }

  @override
  String hoursShort(int n) {
    return '$n h';
  }

  @override
  String get howToSearch => 'Comment chercher';

  @override
  String get searchHelpWord => 'Le titre contient « dentist », majuscules ou non';

  @override
  String get searchHelpStar => '* remplace des lettres : dentist, dentures';

  @override
  String get searchHelpQuestion => '? remplace une lettre : yoga, toga';

  @override
  String get searchHelpPhrase => 'Cette expression exacte';

  @override
  String get searchHelpAnd => 'Les deux mots (AND)';

  @override
  String get searchHelpOr => 'L’un ou l’autre. | marche aussi';

  @override
  String get searchHelpNot => 'Exclure. NOT et ! marchent aussi';

  @override
  String get searchHelpBrackets => 'Les parenthèses regroupent les mots';

  @override
  String get searchHelpEmpty => 'Laissez vide pour sonner à chaque événement.';

  @override
  String get customTime => 'Autre durée';

  @override
  String get other => 'Autre';

  @override
  String get sun => 'Soleil';

  @override
  String get calendar => 'Agenda';

  @override
  String get newEventAlarm => 'Nouvelle alarme d’événement';

  @override
  String get eventAlarm => 'Alarme d’événement';

  @override
  String get findEventsHeading => 'TROUVER LES ÉVÉNEMENTS';

  @override
  String get searchEventsHint => 'Chercher : dentiste, sport OR yoga, dent*…';

  @override
  String get alsoBuiltInTimes => 'Aussi les horaires de Chabbat, des fêtes et du soleil';

  @override
  String get alsoBuiltInTimesHint => 'ex. « allumage* », « havdala », « coucher »';

  @override
  String get allMyCalendars => 'Tous mes agendas';

  @override
  String get connectToSearch => 'Connectez vos agendas pour y chercher';

  @override
  String get searching => 'Recherche…';

  @override
  String get nothingMatches60 => 'Rien ne correspond dans les 60 prochains jours';

  @override
  String eventsIn60(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n événements dans les 60 prochains jours',
      one: '1 événement dans les 60 prochains jours',
    );
    return '$_temp0';
  }

  @override
  String nextRingsAt(String times, String title) {
    return 'Prochain : sonne à $times pour « $title »';
  }

  @override
  String showMoreLeft(int n) {
    return 'Voir plus ($n restants)';
  }

  @override
  String get ringBeforeStartsHeading => 'SONNER AVANT LE DÉBUT';

  @override
  String get ringWhenStarts => 'Sonner au début';

  @override
  String get repeatBeforeHeading => 'ET RÉPÉTER AVANT';

  @override
  String get everyPrefix => 'Toutes les ';

  @override
  String get offLower => 'non';

  @override
  String get forInfix => '  pendant ';

  @override
  String get ringAfterEndsHeading => 'SONNER APRÈS LA FIN';

  @override
  String get nameOptional => 'Nom (facultatif)';

  @override
  String get toppedUp =>
      'Les alarmes sont réglées pour les 7 prochains jours et complétées à chaque ouverture de Quando?.';

  @override
  String get back => 'Retour';

  @override
  String get next => 'Suivant';

  @override
  String get stepWhichEvents => 'Quels événements';

  @override
  String get stepWhenToRing => 'Quand sonner';

  @override
  String get stepHowItRings => 'Comment ça sonne';

  @override
  String defaultNamed(String name) {
    return 'Par défaut ($name)';
  }

  @override
  String get phoneAlarmSound => 'Son d’alarme du téléphone';

  @override
  String get onlineRadio => 'Radio en ligne';

  @override
  String songLinkOpens(String app) {
    return 'Lien de morceau · ouvre $app';
  }

  @override
  String get builtIn => 'Intégré';

  @override
  String get yourRecording => 'Votre enregistrement';

  @override
  String get sound => 'Son';

  @override
  String get wakeToOwnSound => 'Réveillez-vous avec votre son';

  @override
  String get wakeToOwnSoundHint => 'Votre voix, un morceau, Spotify ou la radio en direct';

  @override
  String musicAdded(String name) {
    return '$name ajouté. Choisissez-le comme son pour n’importe quelle alarme.';
  }

  @override
  String get playlists => 'Playlists';

  @override
  String get likedSongs => 'Titres likés';

  @override
  String get noPlaylists => 'Aucune playlist pour l’instant.';

  @override
  String get noLikedSongs => 'Aucun titre liké pour l’instant.';

  @override
  String get needsMic => 'Quando? a besoin du micro pour enregistrer.';

  @override
  String recordingN(int n) {
    return 'Enregistrement $n';
  }

  @override
  String couldNotAddFile(String error) {
    return 'Impossible d’ajouter ce fichier : $error';
  }

  @override
  String get addSongLink => 'Ajouter un lien de morceau';

  @override
  String get songLink => 'Lien de morceau';

  @override
  String get songLinkHowTo =>
      'Dans Spotify, Apple Music, Amazon Music, YouTube, YouTube Music ou SoundCloud, touchez Partager, puis Copier le lien, et collez-le ici.';

  @override
  String get songNameHint => 'Nom, ex. Playlist du matin';

  @override
  String get whenAlarmGoesOffHeading => 'QUAND L’ALARME SONNE';

  @override
  String get playTheSong => 'Jouer le morceau';

  @override
  String get ringThenOpen => 'Sonner, puis ouvrir';

  @override
  String get playTheSongHint =>
      'Son appli s’ouvre et le joue. S’il reste silencieux 10 secondes, le son de secours sonne à la place, pour toujours vous réveiller. Les alarmes avec tâche sonnent, puis l’ouvrent.';

  @override
  String get ringThenOpenHint => 'Le son de secours sonne. Arrêter ouvre le morceau dans son appli.';

  @override
  String get playForHeading => 'JOUER PENDANT';

  @override
  String get pausesAfter =>
      'Quando? met le morceau en pause après cette durée, avec le bouton pause du téléphone.';

  @override
  String get backupSoundHeading => 'SON DE SECOURS';

  @override
  String get notALink => 'Ça ne ressemble pas à un lien.';

  @override
  String songOn(String app) {
    return 'Morceau sur $app';
  }

  @override
  String get theWeb => 'le web';

  @override
  String get pickFromYouTube => 'Choisir dans mon YouTube';

  @override
  String get youTubeAndMusic => 'YouTube et YouTube Music';

  @override
  String get youTubeOn => 'Vos playlists et titres likés. Appui long pour se déconnecter.';

  @override
  String get youTubeSignIn => 'Connectez-vous avec Google pour choisir dans vos playlists et titres likés.';

  @override
  String get addSongLinkInstead => 'Ajoutez plutôt un lien de morceau.';

  @override
  String get googleSignInFailed => 'La connexion Google n’a pas abouti. Réessayez.';

  @override
  String get myYouTube => 'Mon YouTube';

  @override
  String get spotifyDirectOn => 'Lecture directe Spotify activée';

  @override
  String get spotifyDirect => 'Lecture directe Spotify';

  @override
  String get spotifyDirectOnHint =>
      'Spotify joue exactement votre morceau comme alarme. Touchez pour désactiver.';

  @override
  String get spotifyDirectHint =>
      'Joue exactement votre morceau Spotify comme alarme, de façon plus fiable. Nécessite l’appli Spotify et Spotify Premium. Touchez pour vous connecter.';

  @override
  String get spotifyComingSoon =>
      'Bientôt : jouer exactement votre morceau Spotify comme alarme (Spotify Premium requis).';

  @override
  String get spotifyFailed =>
      'Spotify ne s’est pas connecté. Vérifiez que l’appli Spotify est installée, que vous êtes connecté et que vous avez Premium.';

  @override
  String get nameThisSound => 'Nommer ce son';

  @override
  String get sounds => 'Sons';

  @override
  String get soundsSentence =>
      'Réveillez-vous avec votre voix, un morceau, une playlist ou la radio en direct.';

  @override
  String stopTimer(String time) {
    return 'Arrêter · $time';
  }

  @override
  String get record => 'Enregistrer';

  @override
  String get addAFile => 'Ajouter un fichier';

  @override
  String get addSongLinkLong => 'Ajouter un lien de morceau (Spotify, Apple Music, YouTube…)';

  @override
  String get musicAppsHeading => 'APPLIS DE MUSIQUE';

  @override
  String get pickFromSpotify => 'Choisir dans mon Spotify';

  @override
  String get yourPlaylistsAndLiked => 'Vos playlists et titres likés';

  @override
  String get mySpotify => 'Mon Spotify';

  @override
  String get spotifySignInFailed => 'Impossible de se connecter à Spotify.';

  @override
  String get appleMusicNote =>
      'La connexion arrivera avec la version iPhone. En attendant, ajoutez un lien de morceau.';

  @override
  String noSignInNote(String service) {
    return '$service ne permet pas la connexion depuis d’autres applis. Ajoutez plutôt un lien de morceau.';
  }

  @override
  String get wakeToRadio => 'Se réveiller avec la radio en ligne';

  @override
  String get soundsExplain =>
      'Enregistrez votre voix, un morceau ou autre chose, jusqu’à 5 minutes. Ajoutez un MP3, M4A ou WAV depuis votre téléphone. Liez un morceau ou une playlist : son appli le joue comme alarme, avec un son de secours. Ou choisissez une radio : elle joue en direct et, si elle ne se connecte pas, l’alarme du téléphone sonne à la place.';

  @override
  String get yourSoundsHeading => 'VOS SONS';

  @override
  String playsIn(String app) {
    return 'Joue dans $app';
  }

  @override
  String opensIn(String app) {
    return 'S’ouvre dans $app';
  }

  @override
  String forSpan(String span) {
    return 'pendant $span';
  }

  @override
  String get defaultLabel => 'Par défaut';

  @override
  String get radioUnreachable => 'Impossible de joindre l’annuaire des radios. Vérifiez votre connexion.';

  @override
  String get addStreamAddress => 'Ajouter une adresse de flux';

  @override
  String get notAStream => 'Ça ne ressemble pas à une adresse de flux (elle commence par http).';

  @override
  String get anyGenre => 'Tous les genres';

  @override
  String get stationName => 'Nom de la station';

  @override
  String get closeSearch => 'Fermer la recherche';

  @override
  String get searchByName => 'Chercher par nom';

  @override
  String get anywhere => 'Partout';

  @override
  String get noStations => 'Aucune station trouvée. Essayez un autre genre ou pays.';

  @override
  String wakeUpTo(String name) {
    return 'Se réveiller avec $name';
  }

  @override
  String get notQuite => 'Presque. Réessayez.';

  @override
  String shabbatStopsItself(int n) {
    return 'Mode Chabbat : s’arrête tout seul dans $n secondes. Inutile de toucher le téléphone.';
  }

  @override
  String get solveToSnooze => 'RÉSOLVEZ POUR RÉPÉTER';

  @override
  String get solveToStop => 'RÉSOLVEZ POUR ARRÊTER';

  @override
  String get answer => 'Réponse';

  @override
  String get snooze => 'Répéter';

  @override
  String get stop => 'Arrêter';

  @override
  String get shakeToSnooze => 'SECOUEZ POUR RÉPÉTER';

  @override
  String get shakeToStop => 'SECOUEZ POUR ARRÊTER';

  @override
  String get shakeHard => 'Secouez fort le téléphone jusqu’à remplir la barre.';

  @override
  String get cantShake => 'Impossible de secouer ? Résolvez un calcul';

  @override
  String get pairsToSnooze => 'TROUVEZ LES PAIRES POUR RÉPÉTER';

  @override
  String get pairsToStop => 'TROUVEZ LES PAIRES POUR ARRÊTER';

  @override
  String get typeToSnooze => 'TAPEZ CECI POUR RÉPÉTER';

  @override
  String get typeToStop => 'TAPEZ CECI POUR ARRÊTER';

  @override
  String get scanToSnooze => 'SCANNEZ VOTRE CODE POUR RÉPÉTER';

  @override
  String get scanToStop => 'SCANNEZ VOTRE CODE POUR ARRÊTER';

  @override
  String ringAgainUnless(int n) {
    return 'Je resonnerai dans $n minutes si vous ne touchez pas ci-dessous.';
  }

  @override
  String get imUp => 'Je suis levé';

  @override
  String snoozeMin(int n) {
    return 'Répéter $n min';
  }

  @override
  String snoozeMinLeft(int n, int left) {
    return 'Répéter $n min · encore $left';
  }

  @override
  String get noSnoozesLeft => 'Plus de répétitions';

  @override
  String get stopThenOpen => 'Arrêter · puis ouvrir';

  @override
  String get startingSong => 'Lancement de votre morceau';

  @override
  String wayToStop(String way) {
    return '$way pour arrêter';
  }

  @override
  String wayToSnooze(String way) {
    return '$way pour répéter';
  }

  @override
  String ringsForMore(int n) {
    return 'Sonne encore $n secondes';
  }

  @override
  String get leftToRing => 'restantes';

  @override
  String get wayVolumeButtons => 'Boutons de volume';

  @override
  String get wayShake => 'Secouer le téléphone';

  @override
  String get taskNothing => 'Rien';

  @override
  String get taskSum => 'Résoudre un calcul';

  @override
  String get taskShake => 'Secouer 30 fois';

  @override
  String get taskMemory => 'Jeu de mémoire';

  @override
  String get taskPhrase => 'Taper une phrase';

  @override
  String get taskScan => 'Scanner un code';

  @override
  String get noLimit => 'sans limite';

  @override
  String upToTimes(int n) {
    return 'jusqu’à $n×';
  }

  @override
  String shorterEachTime(int n) {
    return '$n min de moins à chaque fois';
  }

  @override
  String autoSnoozeAfter(int n) {
    return 'se répète seule après $n min';
  }

  @override
  String get card => 'Carte';

  @override
  String get hiddenCard => 'Carte cachée';

  @override
  String get phrase1 => 'Je suis réveillé et la journée est à moi';

  @override
  String get phrase2 => 'Si ce n’est pas maintenant, quand';

  @override
  String get phrase3 => 'Bonjour à moi et à tous ceux que j’aime';

  @override
  String get phrase4 => 'J’ai les pieds par terre et je suis debout';

  @override
  String get phrase5 => 'Aujourd’hui je recommence';

  @override
  String get notQuiteWords => 'Presque, vérifiez chaque mot.';

  @override
  String get typeItHere => 'Tapez-le ici';

  @override
  String get differentCode => 'C’est un autre code.';

  @override
  String get cameraUnavailable => 'L’appareil photo n’est pas disponible.';

  @override
  String get cantScan => 'Impossible de scanner ? Résolvez un calcul';

  @override
  String get saveCodeToScan => 'Enregistrer un code à scanner';

  @override
  String get saveCodeHint =>
      'Visez un code-barres ou un QR code à un endroit où vous devez marcher, comme une boîte dans la cuisine ou le dentifrice dans la salle de bain. Pour arrêter l’alarme, vous le scannerez à nouveau.';

  @override
  String get cameraUnavailableSettings =>
      'L’appareil photo n’est pas disponible. Autorisez l’accès dans les Réglages.';

  @override
  String gentleToGo(int n) {
    return 'Réveil en douceur · encore $n min';
  }

  @override
  String previewBody(String body) {
    return 'Essai · $body';
  }

  @override
  String snoozedBody(String body) {
    return 'Répétée : $body';
  }

  @override
  String get areYouUp => 'Êtes-vous levé ?';

  @override
  String get tapImUp => 'Touchez « Je suis levé » pour arrêter';

  @override
  String get volume => 'Volume';

  @override
  String get wakeCheckOn => 'Vérification activée';

  @override
  String get stopsAtOnce => 'S’arrête aussitôt';

  @override
  String get ringsAgainIfNotUp => 'Resonne si vous n’êtes pas levé';

  @override
  String get openAppAfter => 'Ouvrir une appli après';

  @override
  String get noTask => 'Aucune tâche';

  @override
  String get codeSaved => 'Code enregistré';

  @override
  String get tapToSaveDifferent => 'Touchez pour en enregistrer un autre';

  @override
  String get controlsHeading => 'COMMANDES';

  @override
  String get onScreen => 'À l’écran';

  @override
  String get taskHeading => 'TÂCHE';

  @override
  String get none => 'Aucune';

  @override
  String get snoozeSentence =>
      'Encore cinq minutes ? Choisissez combien de temps, combien de fois et à quel prix.';

  @override
  String get settingsHeading => 'RÉGLAGES';

  @override
  String get snoozeTime => 'Durée de répétition';

  @override
  String get snoozeTimeHint => 'Durée de la première répétition';

  @override
  String get shortenSnoozes => 'Raccourcir les suivantes';

  @override
  String get shortenSnoozesHint => 'Chaque répétition après la première est plus courte d’autant';

  @override
  String get autoSnooze => 'Répétition automatique';

  @override
  String get autoSnoozeHint => 'Si vous n’y touchez pas, elle se répète seule après';

  @override
  String get never => 'Jamais';

  @override
  String get snoozeLimit => 'Limite de répétitions';

  @override
  String get snoozeLimitHint => 'Combien de fois vous pouvez répéter';

  @override
  String get unlimited => 'Illimité';

  @override
  String get useSnoozeFromSettings => 'Utiliser la répétition des Réglages';

  @override
  String get stopSentence => 'Comment vous arrêtez l’alarme, et ce qu’il faut faire avant.';

  @override
  String get shabbatNoTask =>
      'Pendant Chabbat et les fêtes, les alarmes s’arrêtent seules et ne demandent jamais de tâche.';

  @override
  String get volumeSentence => 'À quel volume elle sonne, et avec quelle douceur elle y arrive.';

  @override
  String get openAfterAlarm => 'Ouvrir après l’alarme';

  @override
  String get pickAnApp => 'Choisir une appli';

  @override
  String get orPasteLink => 'Ou collez un lien : https://…';

  @override
  String get useThisLink => 'Utiliser ce lien';

  @override
  String get noAppsFound => 'Aucune appli trouvée.';

  @override
  String get weather => 'Météo';

  @override
  String get news => 'Actualités';

  @override
  String get usePhoneVolume => 'Utiliser le volume d’alarme du téléphone';

  @override
  String get setsPhoneVolume => 'Règle le volume d’alarme du téléphone pendant la sonnerie, puis le remet.';

  @override
  String get fadeInOff => 'Fondu d’entrée : non, plein volume tout de suite';

  @override
  String fadeInOver(String span) {
    return 'Monte en $span';
  }

  @override
  String get fadeOutOff => 'Fondu de sortie : non';

  @override
  String fadeOutOver(String span) {
    return 'Baisse sur les dernières $span';
  }

  @override
  String get fadesExplain =>
      'Le fondu de sortie a lieu quand l’alarme s’arrête seule. Si les fondus sont plus longs que la sonnerie, ils raccourcissent tous les deux.';

  @override
  String get soundSoftChime => 'Carillon doux';

  @override
  String get soundMorningRise => 'Lever du jour';

  @override
  String get soundClassicBeep => 'Bip classique';

  @override
  String get calmCity => 'Matin calme en ville';

  @override
  String get calmBirds => 'Oiseaux à l’aube';

  @override
  String get calmWaves => 'Vagues sur le rivage';

  @override
  String get calmRain => 'Pluie douce';

  @override
  String get calmStream => 'Ruisseau en forêt';

  @override
  String get calmWind => 'Vent léger';

  @override
  String get calmFire => 'Feu qui crépite';

  @override
  String get calmNight => 'Nuit d’été';

  @override
  String get publicDomain => 'Domaine public';

  @override
  String get phoneVolume => 'Volume du téléphone';

  @override
  String fadesIn(String span) {
    return 'monte en $span';
  }

  @override
  String fadesOut(String span) {
    return 'baisse en $span';
  }

  @override
  String get noFade => 'sans fondu';

  @override
  String minSecShort(int m, int s) {
    return '$m min $s s';
  }

  @override
  String get happensRings => 'Sonne';

  @override
  String get happensStopped => 'Vous l’arrêtez';

  @override
  String get happensSnoozed => 'Vous la répétez';

  @override
  String get happensAutoStopped => 'Elle s’arrête seule';

  @override
  String get eventLower => 'événement';

  @override
  String get appTest => 'Test Quando?';

  @override
  String get pushoverConnected => 'Pushover est connecté';

  @override
  String get webhookConnected => 'Le webhook est connecté';

  @override
  String pushoverSaid(int code, String body) {
    return 'Pushover a répondu $code : $body';
  }

  @override
  String couldNotReachPushover(String error) {
    return 'Impossible de joindre Pushover ($error)';
  }

  @override
  String itAnswered(int code) {
    return 'Réponse $code';
  }

  @override
  String couldNotReachIt(String error) {
    return 'Impossible de le joindre ($error)';
  }

  @override
  String get calendarNotAllowed => 'L’accès à l’agenda n’a pas été autorisé.';

  @override
  String get playlist => 'Playlist';

  @override
  String songCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n titres', one: '1 titre');
    return '$_temp0';
  }

  @override
  String get spotifySaidNo =>
      'Spotify a refusé. Dans le tableau de bord Spotify, cochez Web API pour Quando? et ajoutez votre compte dans User Management.';

  @override
  String serviceDidntAnswer(String service, int code) {
    return '$service n’a pas répondu ($code).';
  }

  @override
  String get youTubeSaidNo =>
      'YouTube a refusé. Vérifiez que votre compte Google est utilisateur test du projet Quando.';

  @override
  String get event => 'Événement';

  @override
  String eventEnds(String title) {
    return '$title (fin)';
  }

  @override
  String foundSoundsDevices(int s, int d) {
    return '$s sons et $d appareils trouvés.';
  }

  @override
  String get sentCheckDevices => 'Envoyé. Vérifiez vos autres appareils.';

  @override
  String sentTo(String name) {
    return 'Envoyé à $name.';
  }

  @override
  String get zapierHowTo =>
      'Dans Zapier, créez un Zap qui commence par « Webhooks by Zapier → Catch Hook », puis collez son URL ici.';

  @override
  String get catchHookUrl => 'URL du Catch Hook';

  @override
  String get iftttHowTo =>
      'Dans IFTTT, créez une applet qui commence par « Webhooks → Receive a web request with a JSON payload ». Utilisez ici le même nom d’événement. Votre clé est sur ifttt.com/maker_webhooks/settings.';

  @override
  String get eventName => 'Nom de l’événement';

  @override
  String get webhooksKey => 'Clé Webhooks';

  @override
  String get webhookHowTo => 'Quando? envoie un JSON POST à cette adresse.';

  @override
  String get connectionsSentence =>
      'Prévenez vos autres applis et appareils quand une alarme sonne, s’arrête ou se répète.';

  @override
  String get pushWhenRings => 'Envoyer une notification quand une alarme sonne';

  @override
  String get pushWhenRingsHint => 'Vers vos autres téléphones, tablette, montre ou ordinateur';

  @override
  String get yourUserKey => 'Votre clé utilisateur';

  @override
  String get appToken => 'Jeton d’appli';

  @override
  String get soundAndDevicesHeading => 'SON ET APPAREILS';

  @override
  String get loading => 'Chargement…';

  @override
  String get loadFromPushover => 'Charger depuis Pushover';

  @override
  String get soundItPlays => 'Son joué';

  @override
  String get myPushoverDefault => 'Mon son Pushover par défaut';

  @override
  String get pushoverOwnSounds =>
      'Vos propres sons apparaissent ici après les avoir envoyés sur pushover.net/sounds.';

  @override
  String get allMyDevices => 'Tous mes appareils';

  @override
  String get pushoverOnThisPhone =>
      'Installez aussi l’appli Pushover sur ce téléphone et il sonnera ici avec votre son Pushover.';

  @override
  String get priority => 'Priorité';

  @override
  String get priorityNormal => 'Normale';

  @override
  String get priorityHigh => 'Haute : passe les heures calmes';

  @override
  String get priorityEmergency => 'Urgence : se répète jusqu’à confirmation';

  @override
  String get sending => 'Envoi…';

  @override
  String get sendATest => 'Envoyer un test';

  @override
  String get findUserKey => 'Trouver ma clé utilisateur';

  @override
  String get makeAppToken => 'Créer un jeton d’appli';

  @override
  String get webhooksHeading => 'ZAPIER, IFTTT ET WEBHOOKS';

  @override
  String get webhooksExplain =>
      'Déclenchez n’importe quoi quand une alarme sonne ou que vous l’arrêtez : allumer les lumières, noter votre heure de réveil, écrire à quelqu’un.';

  @override
  String get sendWhenAlarm => 'Envoyer quand l’alarme :';

  @override
  String get pauseOnShabbat => 'Pause pendant Chabbat et les fêtes';

  @override
  String get pauseOnShabbatHint =>
      'Rien n’est envoyé pour les alarmes entre l’allumage des bougies et la Havdala';

  @override
  String get webhookPayloadNote =>
      'Chaque message contient : event (ring, stopped, snoozed, auto_stopped), title, body, time, shabbat et snoozes. Les clés restent sur ce téléphone.';

  @override
  String get today => 'Aujourd’hui';

  @override
  String get tomorrow => 'Demain';

  @override
  String get notAWebAddress => 'Ça ne ressemble pas à une adresse web commençant par https://';

  @override
  String get language => 'Langue';

  @override
  String get phoneLanguage => 'Langue du téléphone';

  @override
  String get ringQuote => 'Si ce n’est pas maintenant, quand ?';

  @override
  String get ringQuoteBy => 'Hillel';

  @override
  String get quotesTitle => 'Citations sur le temps';

  @override
  String get quotesHint =>
      'Choisissez d’où elles viennent. Une pour chaque moment de la journée ; touchez la citation pour en voir une autre.';

  @override
  String get quotesOff => 'Désactivé';

  @override
  String get quoteSongs => 'Chansons';

  @override
  String get quoteMovies => 'Films';

  @override
  String get quoteLiterature => 'Livres et poèmes';

  @override
  String get quoteTanakh => 'Tanakh (Bible hébraïque)';

  @override
  String get quoteSages => 'Talmud et sages';

  @override
  String get quoteSpeeches => 'Discours célèbres';

  @override
  String get quotePhilosophy => 'Philosophes';

  @override
  String get quoteProverbs => 'Proverbes et dictons';

  @override
  String get quotesAlso => 'Afficher aussi';

  @override
  String get quoteCarnaval => 'Carnaval';

  @override
  String get quoteCarnavalHint => 'Chansons et dictons pendant le Carnaval du Brésil';

  @override
  String get quoteNearMe => 'Près de moi';

  @override
  String get quoteNearMeHint =>
      'Poètes et dates de l’endroit où vous êtes, d’après votre fuseau horaire et votre ville de Chabbat';

  @override
  String get quoteSiddur => 'Siddour (livre de prières)';
}
