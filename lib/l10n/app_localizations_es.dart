// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get undo => 'Deshacer';

  @override
  String duplicatedNamed(String name) {
    return '“$name” duplicada';
  }

  @override
  String deletedNamed(String name) {
    return '“$name” eliminada';
  }

  @override
  String get when => '¿Cuándo?';

  @override
  String get newAtTime => 'A una hora';

  @override
  String get newAtTimeHint => 'Cada día laborable a las 7:00, una vez a las 15:30…';

  @override
  String get newAroundEvent => 'Alrededor de un evento';

  @override
  String get newAroundEventHint =>
      'Busca en calendarios, Shabat y horas del sol, y suena antes, a la hora o después';

  @override
  String get editThisAlarm => 'Editar esta alarma';

  @override
  String editNamed(String name) {
    return 'Editar “$name”';
  }

  @override
  String get preset => 'plantilla';

  @override
  String get editThisCalendarRule => 'Editar esta regla del calendario';

  @override
  String get ringThisOneAfterAll => 'Que suene esta al final';

  @override
  String get skipJustThisOne => 'Saltar solo esta';

  @override
  String get renameGroup => 'Renombrar grupo';

  @override
  String quickSet(String label, String time) {
    return '$label · suena a las $time';
  }

  @override
  String get newAlarm => 'Nueva alarma';

  @override
  String get appName => 'Quando?';

  @override
  String get lockMode => 'Modo bloqueo';

  @override
  String get calendars => 'Calendarios';

  @override
  String get settings => 'Ajustes';

  @override
  String get nextAlarmHeading => 'PRÓXIMA ALARMA';

  @override
  String get nothingSet => 'Nada programado';

  @override
  String get tagline => 'Todo a su tiempo.';

  @override
  String sunriseAt(String time) {
    return 'Amanecer $time';
  }

  @override
  String sunsetAt(String time) {
    return 'Atardecer $time';
  }

  @override
  String get alarmsMayNotRing => 'Puede que tus alarmas no suenen';

  @override
  String get tapToFixIt => 'Toca para arreglarlo';

  @override
  String inMinutes(int minutes) {
    return 'En $minutes min';
  }

  @override
  String get atSunset => 'Al atardecer';

  @override
  String get sunset => 'Atardecer';

  @override
  String get shabbatModeIsOn => 'MODO SHABAT ACTIVO';

  @override
  String nextInCity(String city) {
    return 'PRÓXIMO · $city';
  }

  @override
  String get candleLighting => 'Encendido de velas';

  @override
  String get havdalah => 'Havdalá';

  @override
  String get shabbatAndFestivals => 'Shabat y festividades';

  @override
  String get yourAlarmsHeading => 'TUS ALARMAS';

  @override
  String get tapWhenToAdd => 'Toca ¿Cuándo? para añadir una alarma.';

  @override
  String get aroundEventsHeading => 'ALREDEDOR DE EVENTOS';

  @override
  String searchFor(String words) {
    return 'búsqueda: $words';
  }

  @override
  String get thisWeekHeading => 'ALARMAS DE ESTA SEMANA';

  @override
  String get noAlarmsThisWeek => 'No hay alarmas en los próximos 7 días.';

  @override
  String get alarmsSetThemselves =>
      'Las alarmas se programan solas en este teléfono cada vez que cambias algo.';

  @override
  String cityTime(String city) {
    return 'hora de $city';
  }

  @override
  String get more => 'Más';

  @override
  String get turnOff => 'Desactivar';

  @override
  String get turnOn => 'Activar';

  @override
  String get duplicate => 'Duplicar';

  @override
  String get delete => 'Eliminar';

  @override
  String get inOneHour => 'En 1 hora';

  @override
  String get logoLabel => 'Logo de Quando?';

  @override
  String get noTimesSet => 'Sin horarios';

  @override
  String get atTheMoment => 'en el momento';

  @override
  String timesRange(int count, String from, String to) {
    return '$count veces · de $from a $to';
  }

  @override
  String spanDays(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n días', one: '1 día');
    return '$_temp0';
  }

  @override
  String spanHours(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n horas', one: '1 hora');
    return '$_temp0';
  }

  @override
  String spanMinutes(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n minutos', one: '1 minuto');
    return '$_temp0';
  }

  @override
  String spanSeconds(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n segundos', one: '1 segundo');
    return '$_temp0';
  }

  @override
  String get now => 'ahora';

  @override
  String spanBefore(String span) {
    return '$span antes';
  }

  @override
  String spanAfter(String span) {
    return '$span después';
  }

  @override
  String alarmCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n alarmas', one: '1 alarma');
    return '$_temp0';
  }

  @override
  String get allOn => 'todas activas';

  @override
  String get allOff => 'todas desactivadas';

  @override
  String someOn(int n) {
    return '$n activas';
  }

  @override
  String skippedBody(String body) {
    return 'Saltada · $body';
  }

  @override
  String timeToTime(String from, String to) {
    return '$from a $to';
  }

  @override
  String skippedCount(int n) {
    return '$n saltadas';
  }

  @override
  String get sunNoRiseSet => 'Hoy el sol no sale ni se pone aquí';

  @override
  String sunProgress(int percent) {
    return 'El sol lleva el $percent% del día';
  }

  @override
  String get sunIsDown => 'El sol ya se puso';

  @override
  String get searchCity => 'Buscar una ciudad';

  @override
  String get tomorrowLower => 'mañana';

  @override
  String get yesterdayLower => 'ayer';

  @override
  String get worldClocksHeading => 'RELOJES DEL MUNDO';

  @override
  String get add => 'Añadir';

  @override
  String cityHere(String city) {
    return '$city · aquí';
  }

  @override
  String get worldClocksHint =>
      'Añade ciudades para ver su hora aquí. Desliza una a la izquierda para quitarla.';

  @override
  String get groupNameHint => 'Trabajo, Niños, Gimnasio…';

  @override
  String get cancel => 'Cancelar';

  @override
  String get ok => 'Aceptar';

  @override
  String get noGroup => 'Sin grupo';

  @override
  String get newGroupEllipsis => 'Nuevo grupo…';

  @override
  String get newGroup => 'Nuevo grupo';

  @override
  String secondsShort(int n) {
    return '$n s';
  }

  @override
  String minutesShort(int n) {
    return '$n min';
  }

  @override
  String get minutes => 'Minutos';

  @override
  String get ringFor => 'Sonar durante';

  @override
  String get seconds => 'Segundos';

  @override
  String get oneSecondLess => '1 segundo menos';

  @override
  String get oneSecondMore => '1 segundo más';

  @override
  String inDays(int d) {
    return 'en $d d';
  }

  @override
  String inDaysHours(int d, int h) {
    return 'en $d d $h h';
  }

  @override
  String inHours(int h) {
    return 'en $h h';
  }

  @override
  String inHoursMinutes(int h, int m) {
    return 'en $h h $m min';
  }

  @override
  String inMins(int m) {
    return 'en $m min';
  }

  @override
  String placeChange(String city, String where) {
    return '$city · $where · cambiar';
  }

  @override
  String get israel => 'Israel';

  @override
  String get outsideIsrael => 'fuera de Israel';

  @override
  String get comingUpHeading => 'PRÓXIMAMENTE';

  @override
  String get lockForShabbat => 'Bloquear el teléfono en Shabat';

  @override
  String get lockForShabbatHint => 'Del encendido de velas a la Havdalá, también en festividades';

  @override
  String get ownShabbatAlarmsHeading => 'TUS ALARMAS DE SHABAT';

  @override
  String get addShabbatAlarm => 'Añadir una alarma de Shabat o festividad';

  @override
  String get readyMadeHeading => 'ALARMAS LISTAS';

  @override
  String bringBackDeleted(int n) {
    return 'Recuperar las eliminadas ($n)';
  }

  @override
  String get presetsHint => 'Toca una para cambiar sus horarios. Desliza para eliminarla.';

  @override
  String get lockSentence =>
      'Deja el teléfono solo con el reloj y tus alarmas, para Shabat o una noche de concentración.';

  @override
  String get lockExplain =>
      'Mientras está bloqueado, Quando? muestra solo la hora, la próxima alarma y cuándo termina el bloqueo. Las alarmas siguen funcionando y no se puede cambiar nada hasta que se desbloquee.';

  @override
  String get lockNowHeading => 'BLOQUEAR AHORA';

  @override
  String get lockAutoHeading => 'BLOQUEAR AUTOMÁTICAMENTE';

  @override
  String get shabbatAndFestivalsLong => 'Shabat y festividades';

  @override
  String get fromCandleToHavdalah => 'Del encendido de velas a la Havdalá';

  @override
  String get lockCalendarWord => 'Durante eventos del calendario con esta palabra';

  @override
  String get lockCalendarWordHint => 'p. ej., bloquear, examen, foco';

  @override
  String get leaveEmptyForNone => 'Déjalo vacío para ninguno';

  @override
  String get connectCalendarsFirst => 'Conecta primero los calendarios (icono de calendario)';

  @override
  String get openWhenLockStarts => 'Abrir Quando? cuando empiece un bloqueo';

  @override
  String get openWhenLockStartsHint =>
      'Un suave tono de 1 segundo trae Quando? al frente para que pueda bloquear';

  @override
  String get pinToScreen => 'Fijar Quando? en la pantalla';

  @override
  String get pinToScreenHint =>
      'No se pueden abrir otras apps mientras está bloqueado. Android pide confirmación la primera vez.';

  @override
  String get noLocksComingUp => 'No hay bloqueos próximos.';

  @override
  String get leaveLockEarly => 'Para salir antes, mantén pulsado “Mantén para desbloquear” 3 segundos.';

  @override
  String get locked => 'Bloqueado';

  @override
  String get shabbatShalom => 'Shabat shalom';

  @override
  String get chagSameach => 'Jag sameaj';

  @override
  String get unlocksHeading => 'SE DESBLOQUEA';

  @override
  String get nowCap => 'Ahora';

  @override
  String get nextAlarm => 'Próxima alarma';

  @override
  String get holdToUnlock => 'Mantén para desbloquear';

  @override
  String get lockSentenceCalm =>
      'Bloquea el teléfono en el reloj y tus alarmas: para un examen, una reunión o una noche tranquila.';

  @override
  String get lockCalendarHeading => 'CON TU CALENDARIO';

  @override
  String get lockCalendarExplain =>
      'Bloquea durante un evento, o desde un evento hasta el siguiente que elijas. Funciona con cualquier calendario elegido, también compartidos.';

  @override
  String get lockAddCalendar => 'Añadir bloqueo por calendario';

  @override
  String get lockEditCalendar => 'Bloqueo por calendario';

  @override
  String get lockDuring => 'Durante un evento';

  @override
  String get lockBetween => 'Entre dos eventos';

  @override
  String get lockStartsAt => 'Eventos llamados…';

  @override
  String get lockStartsAtBetween => 'Empieza en un evento llamado…';

  @override
  String get lockEndsAt => 'Termina en el siguiente evento llamado…';

  @override
  String get lockStartHint => 'p. ej. examen, foco, gimnasio';

  @override
  String get lockEndHint => 'p. ej. en casa';

  @override
  String get lockAnyCalendar => 'Cualquier calendario';

  @override
  String get lockNoMatches => 'Nada en tus calendarios coincide todavía.';

  @override
  String get lockNextTimes => 'PRÓXIMAS VECES';

  @override
  String lockDuringTitle(String a) {
    return 'Durante “$a”';
  }

  @override
  String lockBetweenTitle(String a, String b) {
    return 'De “$a” al siguiente “$b”';
  }

  @override
  String lockShabbatCalendarFound(String name) {
    return '“$name” tiene horarios de Shabat.';
  }

  @override
  String get lockShabbatFromCalendar => 'Bloquear del encendido de velas a Havdalá';

  @override
  String get lockShabbatFromCalendarHint =>
      'Usa los horarios de ese calendario, con velas en la pantalla de bloqueo.';

  @override
  String get lockMoreWays => 'Más formas de bloquear';

  @override
  String get lockQuietTime => 'Momento de calma';

  @override
  String nextCandleLightingFrom(String time, String name) {
    return 'Próximo encendido de velas: $time, de $name';
  }

  @override
  String get calendarAlarm => 'Alarma de calendario';

  @override
  String get connectCalendars => 'Conectar calendarios';

  @override
  String get calendarAlarmsHeading => 'ALARMAS DE CALENDARIO';

  @override
  String get calendarNoneYet => 'Ninguna aún. Empieza con esta y cámbiala a tu gusto:';

  @override
  String get fifteenBeforeEvery => '15 minutos antes de cada evento';

  @override
  String get useTheseCalendarsHeading => 'USAR ESTOS CALENDARIOS';

  @override
  String get noTimedEvents => 'No hay eventos con hora próximos en estos calendarios.';

  @override
  String get atTheStart => 'al empezar';

  @override
  String everyForBefore(String every, String span) {
    return 'cada $every durante $span antes';
  }

  @override
  String spanAfterItEnds(String span) {
    return '$span después de que termine';
  }

  @override
  String get noAlarmsChosen => 'Ninguna alarma elegida';

  @override
  String get gentleWakeUp => 'Despertar suave';

  @override
  String gentleSummary(int minutes, String sound) {
    return '$minutes min antes · $sound';
  }

  @override
  String get off => 'Desactivado';

  @override
  String get gentleSentence =>
      'Un sonido tranquilo empieza bajito antes de tu alarma, para que nunca despiertes de golpe.';

  @override
  String get gentleExplain =>
      'Crece despacio, sacándote del sueño ligero, y se detiene justo antes de que suene la alarma.';

  @override
  String get startsBeforeHeading => 'EMPIEZA ANTES DE LA ALARMA';

  @override
  String get leadUpSoundHeading => 'SONIDO PREVIO';

  @override
  String get listen => 'Escuchar';

  @override
  String get whoRecordedThese => 'Quién grabó estos sonidos';

  @override
  String get done => 'Listo';

  @override
  String get soundCredits => 'Créditos de sonido';

  @override
  String yourTimeCity(String city) {
    return 'Tu hora ($city)';
  }

  @override
  String get anotherCity => 'Otra ciudad…';

  @override
  String get ringingIn5 => 'Sonará en 5 segundos…';

  @override
  String get alarmSaved => 'Alarma guardada.';

  @override
  String alarmSetFor(String span) {
    return 'Alarma programada para dentro de $span.';
  }

  @override
  String hoursMinutesShort(int h, int m) {
    return '$h h $m min';
  }

  @override
  String get editAlarm => 'Editar alarma';

  @override
  String get previewCaps => 'PROBAR';

  @override
  String get saveCaps => 'GUARDAR';

  @override
  String cityTimeForYou(String city, String time) {
    return 'hora de $city · $time para ti';
  }

  @override
  String repeatHeading(String repeat) {
    return 'REPETIR · $repeat';
  }

  @override
  String get labelField => 'Nombre (se lee en voz alta si las alarmas habladas están activas)';

  @override
  String get group => 'Grupo';

  @override
  String ringsForHeading(String span) {
    return 'SUENA DURANTE $span';
  }

  @override
  String useDefault(String value) {
    return 'Usar el predeterminado ($value)';
  }

  @override
  String get save => 'Guardar';

  @override
  String get sameTime => 'misma hora';

  @override
  String get untilYouStopIt => 'Hasta que la detengas';

  @override
  String get alarm => 'Alarma';

  @override
  String get once => 'Una vez';

  @override
  String get everyDay => 'Todos los días';

  @override
  String get weekdays => 'Días laborables';

  @override
  String get weekends => 'Fines de semana';

  @override
  String timeInCity(String time, String city) {
    return '$time hora de $city';
  }

  @override
  String eventsMatching(String words) {
    return 'Eventos con “$words”';
  }

  @override
  String get everyEvent => 'Todos los eventos';

  @override
  String get sunrise => 'Amanecer';

  @override
  String havdalahEndOf(String day) {
    return 'Havdalá · fin de $day';
  }

  @override
  String get yomTov => 'Yom Tov';

  @override
  String get shabbat => 'Shabat';

  @override
  String get presetCountdown => 'Cuenta atrás al encendido de velas';

  @override
  String get presetHourly => 'Cada hora, desde 6 horas antes';

  @override
  String get presetDailyWeek => 'Una vez al día, la semana anterior';

  @override
  String get presetSecondNight => 'Velas de la segunda noche';

  @override
  String get presetFridayReminder => 'Recordatorio 3 horas antes: carga el teléfono';

  @override
  String get presetFridayReminderLabel => 'Carga el teléfono y programa las alarmas de mañana';

  @override
  String get presetSunset => 'Atardecer, y 15 minutos antes';

  @override
  String get pesach => 'Pésaj';

  @override
  String get shavuot => 'Shavuot';

  @override
  String get roshHashanah => 'Rosh Hashaná';

  @override
  String get yomKippur => 'Yom Kipur';

  @override
  String get sukkot => 'Sucot';

  @override
  String get sheminiAtzeret => 'Sheminí Atzeret';

  @override
  String get simchatTorah => 'Simjat Torá';

  @override
  String get readyNotifications => 'Mostrar alarmas';

  @override
  String get readyNotificationsWhy => 'Permite que aparezcan la pantalla de alarma y el botón Detener.';

  @override
  String get readyFullScreen => 'Sonar sobre la pantalla de bloqueo';

  @override
  String get readyFullScreenWhy =>
      'Muestra la alarma a pantalla completa, aunque el teléfono esté bloqueado.';

  @override
  String get readyExact => 'Sonar en el minuto exacto';

  @override
  String get readyExactWhy => 'Sin esto, el teléfono puede hacer sonar las alarmas unos minutos tarde.';

  @override
  String get readyBattery => 'Seguir funcionando con ahorro de batería';

  @override
  String get readyBatteryWhy => 'Evita que el ahorro de batería silencie las alarmas por la noche.';

  @override
  String get tipXiaomi =>
      'Teléfonos Xiaomi: en Ajustes › Aplicaciones › Quando?, activa Inicio automático y pon Ahorro de batería en Sin restricciones.';

  @override
  String get tipSamsung =>
      'Teléfonos Samsung: en Ajustes › Batería › Límites de uso en segundo plano, comprueba que Quando? no esté en suspensión.';

  @override
  String get tipHuawei =>
      'Teléfonos Huawei y Honor: en Ajustes › Batería › Inicio de aplicaciones, pon Quando? en Gestionar manualmente y permítelo todo.';

  @override
  String get tipOther =>
      'En este teléfono: en Ajustes › Batería, permite que Quando? funcione en segundo plano y desactiva su optimización.';

  @override
  String get testRing => 'Prueba de alarma';

  @override
  String get testRingBody => 'Quando? puede despertarte';

  @override
  String get ringsIn20 => 'Suena en 20 segundos. Bloquea el teléfono ahora y espera.';

  @override
  String get readyToRing => 'Listo para sonar';

  @override
  String get checkingPhone => 'Revisando tu teléfono…';

  @override
  String get phoneReady => 'Tu teléfono está listo para hacer sonar cada alarma a tiempo.';

  @override
  String thingsNeedFixing(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'Hay $n cosas que arreglar, o puede que las alarmas no suenen.',
      one: 'Hay 1 cosa que arreglar, o puede que las alarmas no suenen.',
    );
    return '$_temp0';
  }

  @override
  String get fix => 'Arreglar';

  @override
  String get testIn20 => 'Probar: sonar en 20 segundos';

  @override
  String get testIn20Hint =>
      'Bloquea el teléfono y déjalo. Si la alarma suena a pantalla completa, todo está listo.';

  @override
  String get readyToRingHint => 'Comprueba que tu teléfono deja sonar cada alarma a tiempo';

  @override
  String get connections => 'Conexiones';

  @override
  String get timeZoneHeading => 'ZONA HORARIA';

  @override
  String get followPhone => 'Seguir el teléfono';

  @override
  String followPhoneNow(String city) {
    return 'Ahora $city. Cambia sola cuando viajas.';
  }

  @override
  String get zoneFixed => 'Fija. Las alarmas mantienen esta hora aunque viajes.';

  @override
  String get shabbatCityHeading => 'CIUDAD DE SHABAT';

  @override
  String get inIsraelOneDay => 'En Israel (un día de festividad)';

  @override
  String candleMinutesHeading(int n) {
    return 'VELAS: $n MINUTOS ANTES DEL ATARDECER';
  }

  @override
  String get endOfShabbatHeading => 'FIN DE SHABAT Y FESTIVIDADES';

  @override
  String get nightfallGeonim => 'Salida de las estrellas (Gueonim, 8,5°)';

  @override
  String get rabbeinuTam => '72 minutos después del atardecer (Rabenu Tam)';

  @override
  String get whenAlarmRingsHeading => 'CUANDO SUENA UNA ALARMA';

  @override
  String get recordOrAddSounds => 'Grabar o añadir sonidos';

  @override
  String get ringsForThisLong => 'Suena durante este tiempo y luego se detiene sola';

  @override
  String get sameFades => 'Mismas transiciones para todas las alarmas';

  @override
  String get sameFadesOn => 'Reemplaza las transiciones de cada alarma. Cada una conserva su volumen.';

  @override
  String get sameFadesOff => 'Desactivado: cada alarma usa las transiciones de su Volumen.';

  @override
  String get sayItOutLoud => 'Decirlo en voz alta';

  @override
  String get sayItOutLoudHint => 'Lee para qué es la alarma, p. ej., “Encendido de velas, 15 minutos antes”';

  @override
  String get noSnooze => 'Sin posponer';

  @override
  String snoozeUpTo(int times, int minutes) {
    return 'Posponer hasta $times× de $minutes min';
  }

  @override
  String get wakeUpCheck => 'Comprobación de despertar';

  @override
  String get wakeUpCheckHint => 'Tras detenerla, vuelve a sonar en 3 minutos si no tocas “Ya me levanté”';

  @override
  String get solveSum => 'Resolver una suma para detener';

  @override
  String get provesAwake => 'Demuestra que estás despierto';

  @override
  String get shabbatNoTasks =>
      'En Shabat y festividades nada de esto se aplica: las alarmas se detienen solas y nunca te piden tocar el teléfono.';

  @override
  String get testAlarmIn1 => 'Sonar una alarma de prueba en 1 minuto';

  @override
  String get timesDisclaimer =>
      'Los horarios se calculan en tu teléfono. En casos límite, consulta a tu rabino o el calendario de tu comunidad.';

  @override
  String get recommended => 'Recomendado';

  @override
  String get chooseCity => 'Elegir una ciudad';

  @override
  String get testOnlyOnPhone => 'Las alarmas de prueba solo funcionan en un teléfono.';

  @override
  String get testAlarm => 'Alarma de prueba';

  @override
  String get testAlarmBody => 'Así sonarán tus alarmas';

  @override
  String get testAlarmIn1Set => 'Alarma de prueba en 1 minuto. Puedes bloquear el teléfono.';

  @override
  String get presetGone => 'Esta plantilla ya no existe.';

  @override
  String get editPreset => 'Editar plantilla';

  @override
  String get on => 'Activado';

  @override
  String get ringsHeading => 'SUENA';

  @override
  String get noTimesYet => 'Aún sin horarios. Añade uno abajo.';

  @override
  String get atTheMomentItself => 'En el momento exacto';

  @override
  String get remove => 'Quitar';

  @override
  String get addATime => 'Añadir un horario';

  @override
  String get resetPreset => 'Volver a la original';

  @override
  String get skipOneHint =>
      'Para saltar solo una alarma, tócala en “Alarmas de esta semana” en la pantalla de inicio.';

  @override
  String get unitMinutes => 'minutos';

  @override
  String get unitHours => 'horas';

  @override
  String get unitDays => 'días';

  @override
  String get before => 'Antes';

  @override
  String get after => 'Después';

  @override
  String get oneWeek => '1 semana';

  @override
  String daysShort(int n) {
    return '$n d';
  }

  @override
  String hoursShort(int n) {
    return '$n h';
  }

  @override
  String get howToSearch => 'Cómo buscar';

  @override
  String get searchHelpWord => 'El título contiene “dentist”, sin importar mayúsculas';

  @override
  String get searchHelpStar => '* es cualquier grupo de letras: dentist, dentures';

  @override
  String get searchHelpQuestion => '? es una letra: yoga, toga';

  @override
  String get searchHelpPhrase => 'Esta frase exacta';

  @override
  String get searchHelpAnd => 'Ambas palabras (AND)';

  @override
  String get searchHelpOr => 'Cualquiera de las dos. | también vale';

  @override
  String get searchHelpNot => 'Excluir. NOT y ! también valen';

  @override
  String get searchHelpBrackets => 'Los paréntesis agrupan palabras';

  @override
  String get searchHelpEmpty => 'Déjalo vacío para sonar en todos los eventos.';

  @override
  String get customTime => 'Otro tiempo';

  @override
  String get other => 'Otro';

  @override
  String get sun => 'Sol';

  @override
  String get calendar => 'Calendario';

  @override
  String get newEventAlarm => 'Nueva alarma de evento';

  @override
  String get eventAlarm => 'Alarma de evento';

  @override
  String get findEventsHeading => 'ENCUENTRA LOS EVENTOS';

  @override
  String get searchEventsHint => 'Buscar: dentista, gimnasio OR yoga, dent*…';

  @override
  String get alsoBuiltInTimes => 'También horas de Shabat, festividades y sol';

  @override
  String get alsoBuiltInTimesHint => 'p. ej., “velas*”, “havdalá”, “atardecer”';

  @override
  String get allMyCalendars => 'Todos mis calendarios';

  @override
  String get connectToSearch => 'Conecta tus calendarios para buscar en ellos';

  @override
  String get searching => 'Buscando…';

  @override
  String get nothingMatches60 => 'Nada coincide en los próximos 60 días';

  @override
  String eventsIn60(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n eventos en los próximos 60 días',
      one: '1 evento en los próximos 60 días',
    );
    return '$_temp0';
  }

  @override
  String nextRingsAt(String times, String title) {
    return 'Próximo: suena a las $times para “$title”';
  }

  @override
  String showMoreLeft(int n) {
    return 'Mostrar más (quedan $n)';
  }

  @override
  String get ringBeforeStartsHeading => 'SONAR ANTES DE QUE EMPIECE';

  @override
  String get ringWhenStarts => 'Sonar cuando empiece';

  @override
  String get repeatBeforeHeading => 'Y REPETIR ANTES';

  @override
  String get everyPrefix => 'Cada ';

  @override
  String get offLower => 'no';

  @override
  String get forInfix => '  durante ';

  @override
  String get ringAfterEndsHeading => 'SONAR DESPUÉS DE QUE TERMINE';

  @override
  String get nameOptional => 'Nombre (opcional)';

  @override
  String get toppedUp =>
      'Las alarmas se programan para los próximos 7 días y se renuevan cada vez que abres Quando?.';

  @override
  String get back => 'Atrás';

  @override
  String get next => 'Siguiente';

  @override
  String get stepWhichEvents => 'Qué eventos';

  @override
  String get stepWhenToRing => 'Cuándo sonar';

  @override
  String get stepHowItRings => 'Cómo suena';

  @override
  String defaultNamed(String name) {
    return 'Predeterminado ($name)';
  }

  @override
  String get phoneAlarmSound => 'Sonido de alarma del teléfono';

  @override
  String get onlineRadio => 'Radio en línea';

  @override
  String songLinkOpens(String app) {
    return 'Enlace de canción · abre $app';
  }

  @override
  String get builtIn => 'Incluido';

  @override
  String get yourRecording => 'Tu grabación';

  @override
  String get sound => 'Sonido';

  @override
  String get wakeToOwnSound => 'Despierta con tu propio sonido';

  @override
  String get wakeToOwnSoundHint => 'Tu voz, una canción, Spotify o radio en directo';

  @override
  String musicAdded(String name) {
    return '$name añadido. Elígelo como sonido de cualquier alarma.';
  }

  @override
  String get playlists => 'Listas';

  @override
  String get likedSongs => 'Canciones que te gustan';

  @override
  String get noPlaylists => 'Aún no hay listas.';

  @override
  String get noLikedSongs => 'Aún no hay canciones que te gusten.';

  @override
  String get needsMic => 'Quando? necesita el micrófono para grabar.';

  @override
  String recordingN(int n) {
    return 'Grabación $n';
  }

  @override
  String couldNotAddFile(String error) {
    return 'No se pudo añadir ese archivo: $error';
  }

  @override
  String get addSongLink => 'Añadir enlace de canción';

  @override
  String get songLink => 'Enlace de canción';

  @override
  String get songLinkHowTo =>
      'En Spotify, Apple Music, YouTube, YouTube Music o SoundCloud, toca Compartir, luego Copiar enlace, y pégalo aquí.';

  @override
  String get songNameHint => 'Nombre, p. ej., Lista de la mañana';

  @override
  String get whenAlarmGoesOffHeading => 'CUANDO SUENE LA ALARMA';

  @override
  String get playTheSong => 'Reproducir la canción';

  @override
  String get ringThenOpen => 'Sonar y luego abrir';

  @override
  String get playTheSongHint =>
      'Su app se abre y la reproduce. Si sigue en silencio 10 segundos, suena el sonido de respaldo, así siempre te despiertas. Las alarmas con tarea suenan y luego la abren.';

  @override
  String get ringThenOpenHint => 'Suena el sonido de respaldo. Detener abre la canción en su app.';

  @override
  String get playForHeading => 'REPRODUCIR DURANTE';

  @override
  String get pausesAfter =>
      'Quando? pausa la canción después de esto, con el propio botón de pausa del teléfono.';

  @override
  String get backupSoundHeading => 'SONIDO DE RESPALDO';

  @override
  String get notALink => 'Eso no parece un enlace.';

  @override
  String songOn(String app) {
    return 'Canción en $app';
  }

  @override
  String get theWeb => 'la web';

  @override
  String get pickFromYouTube => 'Elegir de mi YouTube';

  @override
  String get youTubeAndMusic => 'YouTube y YouTube Music';

  @override
  String get youTubeOn => 'Conectado · mantén pulsado para salir';

  @override
  String get youTubeSignIn => 'Iniciar sesión con Google';

  @override
  String get addSongLinkInstead => 'Añade un enlace de canción.';

  @override
  String get googleSignInFailed => 'El inicio de sesión de Google no terminó. Inténtalo de nuevo.';

  @override
  String get myYouTube => 'Mi YouTube';

  @override
  String get spotifyDirectOn => 'Reproducción directa de Spotify activada';

  @override
  String get spotifyDirect => 'Reproducción directa de Spotify';

  @override
  String get spotifyDirectOnHint => 'Activado · toca para desactivar';

  @override
  String get spotifyDirectHint => 'Suena la canción exacta. Requiere Premium.';

  @override
  String get spotifyComingSoon => 'Próximamente · requiere Premium';

  @override
  String get spotifyFailed =>
      'Spotify no se conectó. Comprueba que la app de Spotify está instalada, que has iniciado sesión y que tienes Premium.';

  @override
  String get nameThisSound => 'Ponle nombre a este sonido';

  @override
  String get sounds => 'Sonidos';

  @override
  String get soundsSentence => 'Despierta con tu propia voz, una canción, una lista o radio en directo.';

  @override
  String stopTimer(String time) {
    return 'Detener · $time';
  }

  @override
  String get record => 'Grabar';

  @override
  String get addAFile => 'Añadir un archivo';

  @override
  String get addSongLinkLong => 'Añadir enlace de canción (Spotify, Apple Music, YouTube…)';

  @override
  String get musicAppsHeading => 'APPS DE MÚSICA';

  @override
  String get pickFromSpotify => 'Elegir de mi Spotify';

  @override
  String get yourPlaylistsAndLiked => 'Tus listas y canciones que te gustan';

  @override
  String get mySpotify => 'Mi Spotify';

  @override
  String get spotifySignInFailed => 'No se pudo iniciar sesión en Spotify.';

  @override
  String get appleMusicNote =>
      'El inicio de sesión llegará con la versión para iPhone. Por ahora, añade un enlace de canción.';

  @override
  String noSignInNote(String service) {
    return '$service no permite iniciar sesión desde otras apps. Añade un enlace de canción.';
  }

  @override
  String get wakeToRadio => 'Despertar con radio en línea';

  @override
  String get soundsExplain =>
      'Graba hasta 5 minutos, añade un archivo, un enlace o radio en vivo. Si algo falla, suena un sonido de respaldo.';

  @override
  String get yourSoundsHeading => 'TUS SONIDOS';

  @override
  String playsIn(String app) {
    return 'Suena en $app';
  }

  @override
  String opensIn(String app) {
    return 'Se abre en $app';
  }

  @override
  String forSpan(String span) {
    return 'durante $span';
  }

  @override
  String get defaultLabel => 'Predeterminado';

  @override
  String get radioUnreachable => 'No se pudo acceder al directorio de radios. Revisa tu conexión.';

  @override
  String get addStreamAddress => 'Añadir dirección de stream';

  @override
  String get notAStream => 'Eso no parece una dirección de stream (empieza con http).';

  @override
  String get anyGenre => 'Cualquier género';

  @override
  String get stationName => 'Nombre de la emisora';

  @override
  String get closeSearch => 'Cerrar búsqueda';

  @override
  String get searchByName => 'Buscar por nombre';

  @override
  String get anywhere => 'Cualquier lugar';

  @override
  String get noStations => 'No se encontraron emisoras. Prueba otro género o país.';

  @override
  String wakeUpTo(String name) {
    return 'Despertar con $name';
  }

  @override
  String get notQuite => 'Casi. Inténtalo de nuevo.';

  @override
  String shabbatStopsItself(int n) {
    return 'Modo Shabat: se detiene solo en $n segundos. No hace falta tocar el teléfono.';
  }

  @override
  String get solveToSnooze => 'RESUELVE PARA POSPONER';

  @override
  String get solveToStop => 'RESUELVE PARA DETENER';

  @override
  String get answer => 'Respuesta';

  @override
  String get snooze => 'Posponer';

  @override
  String get stop => 'Detener';

  @override
  String get shakeToSnooze => 'AGITA PARA POSPONER';

  @override
  String get shakeToStop => 'AGITA PARA DETENER';

  @override
  String get shakeHard => 'Agita fuerte el teléfono hasta llenar la barra.';

  @override
  String get cantShake => '¿No puedes agitarlo? Resuelve una suma';

  @override
  String get pairsToSnooze => 'ENCUENTRA LAS PAREJAS PARA POSPONER';

  @override
  String get pairsToStop => 'ENCUENTRA LAS PAREJAS PARA DETENER';

  @override
  String get typeToSnooze => 'ESCRIBE ESTO PARA POSPONER';

  @override
  String get typeToStop => 'ESCRIBE ESTO PARA DETENER';

  @override
  String get scanToSnooze => 'ESCANEA TU CÓDIGO PARA POSPONER';

  @override
  String get scanToStop => 'ESCANEA TU CÓDIGO PARA DETENER';

  @override
  String ringAgainUnless(int n) {
    return 'Volveré a sonar en $n minutos si no tocas abajo.';
  }

  @override
  String get imUp => 'Ya me levanté';

  @override
  String snoozeMin(int n) {
    return 'Posponer $n min';
  }

  @override
  String snoozeMinLeft(int n, int left) {
    return 'Posponer $n min · quedan $left';
  }

  @override
  String get noSnoozesLeft => 'No quedan aplazamientos';

  @override
  String get stopThenOpen => 'Detener · y abrir';

  @override
  String get startingSong => 'Iniciando tu canción';

  @override
  String wayToStop(String way) {
    return '$way para detener';
  }

  @override
  String wayToSnooze(String way) {
    return '$way para posponer';
  }

  @override
  String ringsForMore(int n) {
    return 'Suena $n segundos más';
  }

  @override
  String get leftToRing => 'restantes';

  @override
  String get wayVolumeButtons => 'Botones de volumen';

  @override
  String get wayShake => 'Agitar el teléfono';

  @override
  String get taskNothing => 'Nada';

  @override
  String get taskSum => 'Resolver una suma';

  @override
  String get taskShake => 'Agitar 30 veces';

  @override
  String get taskMemory => 'Juego de memoria';

  @override
  String get taskPhrase => 'Escribir una frase';

  @override
  String get taskScan => 'Escanear un código';

  @override
  String get noLimit => 'sin límite';

  @override
  String upToTimes(int n) {
    return 'hasta $n×';
  }

  @override
  String shorterEachTime(int n) {
    return '$n min menos cada vez';
  }

  @override
  String autoSnoozeAfter(int n) {
    return 'se pospone sola tras $n min';
  }

  @override
  String get card => 'Carta';

  @override
  String get hiddenCard => 'Carta oculta';

  @override
  String get phrase1 => 'Estoy despierto y el día es mío';

  @override
  String get phrase2 => 'Si no es ahora, cuándo';

  @override
  String get phrase3 => 'Buenos días a mí y a todos los que quiero';

  @override
  String get phrase4 => 'Tengo los pies en el suelo y estoy en pie';

  @override
  String get phrase5 => 'Hoy empiezo de nuevo';

  @override
  String get notQuiteWords => 'Casi, revisa cada palabra.';

  @override
  String get typeItHere => 'Escríbelo aquí';

  @override
  String get differentCode => 'Ese es otro código.';

  @override
  String get cameraUnavailable => 'La cámara no está disponible.';

  @override
  String get cantScan => '¿No puedes escanear? Resuelve una suma';

  @override
  String get saveCodeToScan => 'Guardar un código para escanear';

  @override
  String get saveCodeHint =>
      'Apunta la cámara a un código de barras o QR en un lugar al que tengas que ir caminando, como una caja en la cocina o la pasta de dientes en el baño. Para detener la alarma, lo escanearás de nuevo.';

  @override
  String get cameraUnavailableSettings =>
      'La cámara no está disponible. Permite el acceso a la cámara en Ajustes.';

  @override
  String gentleToGo(int n) {
    return 'Despertar suave · faltan $n min';
  }

  @override
  String previewBody(String body) {
    return 'Prueba · $body';
  }

  @override
  String snoozedBody(String body) {
    return 'Pospuesta: $body';
  }

  @override
  String get areYouUp => '¿Estás despierto?';

  @override
  String get tapImUp => 'Toca “Ya me levanté” para detener';

  @override
  String get volume => 'Volumen';

  @override
  String get wakeCheckOn => 'Comprobación activada';

  @override
  String get stopsAtOnce => 'Se detiene al instante';

  @override
  String get ringsAgainIfNotUp => 'Vuelve a sonar si no te levantas';

  @override
  String get openAppAfter => 'Abrir una app después';

  @override
  String get noTask => 'Sin tarea';

  @override
  String get codeSaved => 'Código guardado';

  @override
  String get tapToSaveDifferent => 'Toca para guardar otro';

  @override
  String get controlsHeading => 'CONTROLES';

  @override
  String get onScreen => 'En pantalla';

  @override
  String get taskHeading => 'TAREA';

  @override
  String get none => 'Ninguna';

  @override
  String get snoozeSentence => '¿Cinco minutos más? Elige cuánto, cuántas veces y qué hace falta.';

  @override
  String get settingsHeading => 'AJUSTES';

  @override
  String get snoozeTime => 'Tiempo de aplazamiento';

  @override
  String get snoozeTimeHint => 'Cuánto dura el primer aplazamiento';

  @override
  String get shortenSnoozes => 'Acortar los siguientes';

  @override
  String get shortenSnoozesHint => 'Cada aplazamiento después del primero es esto más corto';

  @override
  String get autoSnooze => 'Aplazamiento automático';

  @override
  String get autoSnoozeHint => 'Si no la tocas, se pospone sola después de';

  @override
  String get never => 'Nunca';

  @override
  String get snoozeLimit => 'Límite de aplazamientos';

  @override
  String get snoozeLimitHint => 'Cuántas veces puedes posponer';

  @override
  String get unlimited => 'Sin límite';

  @override
  String get useSnoozeFromSettings => 'Usar el aplazamiento de Ajustes';

  @override
  String get stopSentence => 'Cómo apagas la alarma y qué debes hacer antes.';

  @override
  String get shabbatNoTask =>
      'En Shabat y festividades las alarmas se detienen solas y nunca piden una tarea.';

  @override
  String get volumeSentence => 'Qué tan fuerte suena y con qué suavidad llega.';

  @override
  String get openAfterAlarm => 'Abrir después de la alarma';

  @override
  String get pickAnApp => 'Elegir una app';

  @override
  String get orPasteLink => 'O pega un enlace: https://…';

  @override
  String get useThisLink => 'Usar este enlace';

  @override
  String get noAppsFound => 'No se encontraron apps.';

  @override
  String get weather => 'Tiempo';

  @override
  String get news => 'Noticias';

  @override
  String get usePhoneVolume => 'Usar el volumen de alarma del teléfono';

  @override
  String get setsPhoneVolume =>
      'Ajusta el volumen de alarma del teléfono mientras suena y luego lo restablece.';

  @override
  String get fadeInOff => 'Subida gradual: no, volumen completo de una vez';

  @override
  String fadeInOver(String span) {
    return 'Sube en $span';
  }

  @override
  String get fadeOutOff => 'Bajada gradual: no';

  @override
  String fadeOutOver(String span) {
    return 'Baja en los últimos $span';
  }

  @override
  String get fadesExplain =>
      'La bajada ocurre cuando la alarma se detiene sola. Si las transiciones duran más que la alarma, ambas se acortan para caber.';

  @override
  String get soundSoftChime => 'Campanilla suave';

  @override
  String get soundMorningRise => 'Amanecer';

  @override
  String get soundClassicBeep => 'Pitido clásico';

  @override
  String get calmCity => 'Mañana tranquila en la ciudad';

  @override
  String get calmBirds => 'Pájaros al alba';

  @override
  String get calmWaves => 'Olas en la orilla';

  @override
  String get calmRain => 'Lluvia suave';

  @override
  String get calmStream => 'Arroyo del bosque';

  @override
  String get calmWind => 'Viento suave';

  @override
  String get calmFire => 'Fuego crepitante';

  @override
  String get calmNight => 'Noche de verano';

  @override
  String get publicDomain => 'Dominio público';

  @override
  String get phoneVolume => 'Volumen del teléfono';

  @override
  String fadesIn(String span) {
    return 'sube en $span';
  }

  @override
  String fadesOut(String span) {
    return 'baja en $span';
  }

  @override
  String get noFade => 'sin transición';

  @override
  String minSecShort(int m, int s) {
    return '$m min $s s';
  }

  @override
  String get happensRings => 'Suena';

  @override
  String get happensStopped => 'La detienes';

  @override
  String get happensSnoozed => 'La pospones';

  @override
  String get happensAutoStopped => 'Se detiene sola';

  @override
  String get eventLower => 'evento';

  @override
  String get appTest => 'Prueba de Quando?';

  @override
  String get pushoverConnected => 'Pushover está conectado';

  @override
  String get webhookConnected => 'El webhook está conectado';

  @override
  String pushoverSaid(int code, String body) {
    return 'Pushover respondió $code: $body';
  }

  @override
  String couldNotReachPushover(String error) {
    return 'No se pudo contactar con Pushover ($error)';
  }

  @override
  String itAnswered(int code) {
    return 'Respondió $code';
  }

  @override
  String couldNotReachIt(String error) {
    return 'No se pudo contactar ($error)';
  }

  @override
  String get calendarNotAllowed => 'No se permitió el acceso al calendario.';

  @override
  String get playlist => 'Lista';

  @override
  String songCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n canciones', one: '1 canción');
    return '$_temp0';
  }

  @override
  String get spotifySaidNo =>
      'Spotify lo rechazó. En el panel de Spotify, marca Web API para Quando? y añade tu cuenta en User Management.';

  @override
  String serviceDidntAnswer(String service, int code) {
    return '$service no respondió ($code).';
  }

  @override
  String get youTubeSaidNo =>
      'YouTube lo rechazó. Comprueba que tu cuenta de Google es usuaria de prueba del proyecto Quando.';

  @override
  String get event => 'Evento';

  @override
  String eventEnds(String title) {
    return '$title (fin)';
  }

  @override
  String foundSoundsDevices(int s, int d) {
    return 'Se encontraron $s sonidos y $d dispositivos.';
  }

  @override
  String get sentCheckDevices => 'Enviado. Revisa tus otros dispositivos.';

  @override
  String sentTo(String name) {
    return 'Enviado a $name.';
  }

  @override
  String get zapierHowTo =>
      'En Zapier, crea un Zap que empiece con “Webhooks by Zapier → Catch Hook” y pega aquí su URL.';

  @override
  String get catchHookUrl => 'URL del Catch Hook';

  @override
  String get iftttHowTo =>
      'En IFTTT, crea un applet que empiece con “Webhooks → Receive a web request with a JSON payload”. Usa aquí el mismo nombre de evento. Tu clave está en ifttt.com/maker_webhooks/settings.';

  @override
  String get eventName => 'Nombre del evento';

  @override
  String get webhooksKey => 'Clave de webhooks';

  @override
  String get webhookHowTo => 'Quando? envía un JSON POST a esta dirección.';

  @override
  String get connectionsSentence =>
      'Avisa a tus otras apps y dispositivos cuando una alarma suena, se detiene o se pospone.';

  @override
  String get pushWhenRings => 'Enviar un aviso cuando suene una alarma';

  @override
  String get pushWhenRingsHint => 'A tus otros teléfonos, tableta, reloj u ordenador';

  @override
  String get yourUserKey => 'Tu clave de usuario';

  @override
  String get appToken => 'Token de la app';

  @override
  String get soundAndDevicesHeading => 'SONIDO Y DISPOSITIVOS';

  @override
  String get loading => 'Cargando…';

  @override
  String get loadFromPushover => 'Cargar desde Pushover';

  @override
  String get soundItPlays => 'Sonido que reproduce';

  @override
  String get myPushoverDefault => 'Mi predeterminado de Pushover';

  @override
  String get pushoverOwnSounds =>
      'Tus propios sonidos aparecen aquí después de subirlos en pushover.net/sounds.';

  @override
  String get allMyDevices => 'Todos mis dispositivos';

  @override
  String get pushoverOnThisPhone =>
      'Instala también la app de Pushover en este teléfono y sonará aquí con tu sonido de Pushover.';

  @override
  String get priority => 'Prioridad';

  @override
  String get priorityNormal => 'Normal';

  @override
  String get priorityHigh => 'Alta: atraviesa las horas de silencio';

  @override
  String get priorityEmergency => 'Emergencia: se repite hasta que se confirme';

  @override
  String get sending => 'Enviando…';

  @override
  String get sendATest => 'Enviar una prueba';

  @override
  String get findUserKey => 'Buscar mi clave de usuario';

  @override
  String get makeAppToken => 'Crear un token de app';

  @override
  String get webhooksHeading => 'ZAPIER, IFTTT Y WEBHOOKS';

  @override
  String get webhooksExplain =>
      'Pon en marcha lo que quieras cuando suene una alarma o la detengas: encender luces, registrar tu hora de despertar, escribir a alguien.';

  @override
  String get sendWhenAlarm => 'Enviar cuando la alarma:';

  @override
  String get pauseOnShabbat => 'Pausar en Shabat y festividades';

  @override
  String get pauseOnShabbatHint => 'No se envía nada para alarmas entre el encendido de velas y la Havdalá';

  @override
  String get webhookPayloadNote =>
      'Cada mensaje lleva: event (ring, stopped, snoozed, auto_stopped), title, body, time, shabbat y snoozes. Las claves se quedan en este teléfono.';

  @override
  String get today => 'Hoy';

  @override
  String get tomorrow => 'Mañana';

  @override
  String get notAWebAddress => 'Eso no parece una dirección web que empiece con https://';

  @override
  String get language => 'Idioma';

  @override
  String get phoneLanguage => 'Idioma del teléfono';

  @override
  String get ringQuote => 'Si no es ahora, ¿cuándo?';

  @override
  String get ringQuoteBy => 'Hilel';

  @override
  String get quotesTitle => 'Frases sobre el tiempo';

  @override
  String get quotesHint => 'Elige de dónde vienen. Una para cada parte del día; toca la frase para ver otra.';

  @override
  String get quotesOff => 'Desactivado';

  @override
  String get quoteSongs => 'Canciones';

  @override
  String get quoteMovies => 'Películas';

  @override
  String get quoteLiterature => 'Libros y poemas';

  @override
  String get quoteTanakh => 'Tanaj (Biblia hebrea)';

  @override
  String get quoteSages => 'Talmud y sabios';

  @override
  String get quoteSpeeches => 'Discursos famosos';

  @override
  String get quotePhilosophy => 'Filósofos';

  @override
  String get quoteProverbs => 'Refranes y dichos';

  @override
  String get quotesAlso => 'Mostrar también';

  @override
  String get quoteCarnaval => 'Carnaval';

  @override
  String get quoteCarnavalHint => 'Canciones y dichos durante el Carnaval de Brasil';

  @override
  String get quoteNearMe => 'Cerca de mí';

  @override
  String get quoteNearMeHint =>
      'Poetas y fechas del lugar donde estás, según tu zona horaria y ciudad de Shabat';

  @override
  String get quoteSiddur => 'Sidur (libro de rezos)';

  @override
  String weeklyParasha(String name) {
    return 'Parashá $name';
  }

  @override
  String poweredBy(String name) {
    return 'con tecnología $name';
  }

  @override
  String get syncTitle => 'Sincronizar mis dispositivos';

  @override
  String get syncHint =>
      'Inicia sesión con Google para mantener alarmas y ajustes iguales en todos tus dispositivos.';

  @override
  String syncOn(String email) {
    return 'On · $email';
  }

  @override
  String get syncWorking => 'Connecting…';

  @override
  String get syncNotAllowed => 'This Google account can\'t sync.';

  @override
  String get syncFailed => 'No se pudo conectar. Toca para intentarlo de nuevo.';

  @override
  String get syncStop => 'Stop syncing';

  @override
  String get syncNotSetUp => 'La sincronización aún no está configurada en esta versión.';

  @override
  String get ringTheseAfterAll => 'Que suenen igualmente';

  @override
  String skipTheseDay(int n) {
    return 'Omitir estas $n hoy';
  }

  @override
  String turnOffNamed(String name) {
    return 'Desactivar «$name»';
  }

  @override
  String turnOnNamed(String name) {
    return 'Activar «$name»';
  }

  @override
  String turnedOffNamed(String name) {
    return '«$name» desactivada';
  }

  @override
  String removeTimeFrom(String time, String name) {
    return 'Quitar «$time» de «$name»';
  }

  @override
  String removedTimeFrom(String time, String name) {
    return '«$time» quitada de «$name»';
  }

  @override
  String get moveToGroup => 'Mover a un grupo';

  @override
  String inGroupMove(String group) {
    return 'En «$group», mover';
  }

  @override
  String movedToGroup(String group) {
    return 'Movida a «$group»';
  }

  @override
  String deleteNamed(String name) {
    return 'Eliminar «$name»';
  }

  @override
  String get signInWithGoogle => 'Iniciar sesión con Google';

  @override
  String get signOut => 'Sign out';

  @override
  String get signInWithEmail => 'Iniciar sesión con correo';

  @override
  String get signIn => 'Sign in';

  @override
  String get createAccount => 'Crear cuenta';

  @override
  String get haveAccount => 'Ya tengo una cuenta';

  @override
  String get forgotPassword => '¿Olvidaste la contraseña?';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get passwordResetSent => 'Te enviamos un enlace para elegir una contraseña nueva.';

  @override
  String emailCheckInbox(String email) {
    return 'Enviamos un enlace a $email. Ábrelo, vuelve y toca «Ya confirmé».';
  }

  @override
  String get emailConfirmed => 'Ya confirmé';

  @override
  String get emailNotYet => 'Aún sin confirmar. Abre primero el enlace del correo.';

  @override
  String get emailSendAgain => 'Enviar el correo otra vez';

  @override
  String get emailSentAgain => 'Enviado. Revisa tu bandeja de entrada y el spam.';

  @override
  String get emailInvalid => 'Eso no parece una dirección de correo.';

  @override
  String get emailWrong => 'Correo o contraseña incorrectos.';

  @override
  String get emailInUse =>
      'Ya existe una cuenta con este correo. Inicia sesión, o usa Google si la creaste con Google.';

  @override
  String get passwordWeak => 'Elige una contraseña de al menos 6 caracteres.';

  @override
  String get emailNotSwitchedOn => 'El inicio de sesión con correo aún no está activado.';

  @override
  String get tooManyTries => 'Demasiados intentos. Espera unos minutos.';

  @override
  String get spotifyLibrary => 'Spotify';

  @override
  String get spotifyLibrarySignIn => 'Listas, canciones que te gustan y búsqueda';

  @override
  String get spotifyLibraryOn => 'Conectado · mantén pulsado para salir';

  @override
  String spotifyLoginError(String reason) {
    return 'El inicio de sesión en Spotify no funcionó: $reason';
  }

  @override
  String googleSignInError(String reason) {
    return 'El inicio de sesión en Google no funcionó: $reason';
  }

  @override
  String get searchSongsHint => 'Buscar canciones, artistas, playlists';

  @override
  String nothingFound(String query) {
    return 'No se encontró nada para «$query».';
  }

  @override
  String get deliveryTitle => 'Entrega';

  @override
  String get deliveryLocal => 'Audio local';

  @override
  String get deliveryBoth => 'Ambos';

  @override
  String get deliveryConnect => 'Conectar Pushover';

  @override
  String get deliveryLoadFailed => 'No se pudieron cargar sonidos y dispositivos. Inténtalo de nuevo.';

  @override
  String get deliveryBothHint => 'El audio local suena aunque Pushover falle.';

  @override
  String get deliveryPushHint => 'Solo Pushover. Este dispositivo debe estar conectado al activarse.';

  @override
  String get deliveryFallback => 'Se mantiene el audio local si Pushover está desconectado o en pausa.';

  @override
  String get deliveryReset => 'Usar ajustes existentes';

  @override
  String get beforeShabbat => 'Antes del Shabat';

  @override
  String get preparationReminders => 'Recordatorios de preparación';

  @override
  String get skipThisWeek => 'Omitir esta semana';

  @override
  String get restoreThisWeek => 'Restaurar esta semana';

  @override
  String get allAlarms => 'All alarms';

  @override
  String get timesAndSound => 'Horas y sonido';

  @override
  String get changeCity => 'Change city';

  @override
  String get useMyLocation => 'Usar mi ubicación';

  @override
  String get locationUnavailable =>
      'La ubicación no está disponible por ahora. Inténtalo de nuevo o elige una ciudad.';

  @override
  String get locationReview => 'Confirmar esta ubicación';

  @override
  String get locationDeviceOnly =>
      'Esta ubicación se guarda solo en este dispositivo. Revisa la zona horaria y el ajuste de Israel antes de usar estas horas.';

  @override
  String timesIn(String city, String zone) {
    return '$city · $zone · hora de la ciudad';
  }

  @override
  String get preparationOff =>
      'Los recordatorios de preparación están desactivados. La Havdalá y las alarmas normales no cambian.';

  @override
  String get preparationSkipped =>
      'Los recordatorios de preparación se omiten esta semana. Se conservan tus ajustes semanales.';

  @override
  String get shabbatControls => 'Controles del Shabat';

  @override
  String get duringAfterShabbat => 'Durante / después del Shabat';

  @override
  String locationCoordinates(String latitude, String longitude) {
    return 'Latitud $latitude · longitud $longitude';
  }

  @override
  String get currentLocation => 'Ubicación actual';

  @override
  String get testPushoverSound => 'Probar el sonido en Pushover';

  @override
  String get pushoverSoundTestHint =>
      'Reproduce el sonido elegido en los dispositivos Pushover que seleccionaste. Siguen aplicándose los ajustes de silencio y de horas de descanso.';

  @override
  String get pushoverShareDevices => 'Compartir credenciales con mis dispositivos';

  @override
  String get pushoverShareHint =>
      'Tu clave de usuario de Pushover y tu token de app pueden acompañar a tu cuenta iniciada en Quando? y Matai?.';

  @override
  String get pushoverShareQueued => 'Credenciales en cola para tus dispositivos con sesión iniciada.';

  @override
  String get pushoverShareSignIn =>
      'Inicia sesión con la misma cuenta de la app en cada dispositivo para compartir las credenciales de Pushover.';

  @override
  String get smartHomeHeading => 'Smart home';

  @override
  String get smartHomeHint =>
      'Ejecuta escenas de Tuya directamente, o conecta tus propias automatizaciones de Home Assistant o Node-RED.';

  @override
  String get shareServices => 'Compartir conexiones de servicios';

  @override
  String get shareServicesHint =>
      'Usa la misma cuenta de la app en tus dispositivos para compartir las conexiones de Pushover, Tuya, la biblioteca de Spotify y las automatizaciones. Puede que YouTube y los permisos del dispositivo sigan necesitando aprobación en cada dispositivo.';

  @override
  String get tuyaSetupHint =>
      'Usa tu proyecto de desarrollador de Tuya vinculado. Introduce su centro de datos, Access ID, Access Secret y el UID que aparece en «Link App Account». No se necesita Home Assistant.';

  @override
  String get tuyaDataCenter => 'Data center';

  @override
  String get tuyaUserId => 'UID de la cuenta vinculada';

  @override
  String get tuyaAccessId => 'Access ID / Client ID';

  @override
  String get tuyaAccessSecret => 'Access Secret / Client Secret';

  @override
  String get tuyaLoadScenes => 'Load scenes';

  @override
  String get tuyaNoScenes =>
      'No se encontraron escenas Tap-to-Run disponibles. Revisa la cuenta vinculada, el centro de datos y los permisos de la API de escenas.';

  @override
  String get tuyaRunNow => 'Ejecutar escena ahora';

  @override
  String get tuyaRunConfirm => '¿Ejecutar ahora esta escena en tus dispositivos Tuya?';

  @override
  String get tuyaSent => 'Tuya aceptó el comando de la escena. Revisa tus dispositivos.';

  @override
  String get tuyaFailed =>
      'Tuya no pudo completar la solicitud. Revisa los permisos del proyecto, el centro de datos y la suscripción. Error:';

  @override
  String get tuyaAlarmScene => 'Escena de Tuya cuando suena esta alarma';

  @override
  String get homeAssistantHowTo =>
      'Crea una automatización de Home Assistant con un disparador Webhook que acepte POST y JSON. Pega aquí su URL. Usa el evento de la alarma (ring, stopped, snoozed o auto_stopped) para elegir tus acciones. Los dispositivos nuevos reciben esta conexión desactivada.';

  @override
  String get nodeRedHowTo =>
      'Usa un nodo HTTP In de Node-RED que acepte POST, seguido de tu automatización y un nodo HTTP Response. Pega aquí el endpoint. Se admiten hubs HTTP locales y endpoints HTTPS.';

  @override
  String get smartHomeConnect => 'Conectar un servicio de hogar inteligente';

  @override
  String get automationTestHint => 'Al probar, la automatización conectada se ejecuta de inmediato.';

  @override
  String get smartHomeDeviceOn => 'Ejecutar acciones de alarma del hogar inteligente en este dispositivo';

  @override
  String get smartHomeDeviceHint =>
      'Elige un dispositivo para ejecutar tus automatizaciones. Las conexiones se comparten; este interruptor se queda en este dispositivo.';

  @override
  String get smartHomeDeviceOff =>
      'Las acciones de alarma están desactivadas en este dispositivo. Actívalas en Conexiones; las pruebas manuales de escenas siguen funcionando.';

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
  String get weatherSwipeHint => 'Desliza entre cielo y clima';

  @override
  String get parashaHeading => 'Parashá semanal';

  @override
  String get dailyStudyHeading => 'Estudio diario';

  @override
  String get courseDaf => 'Daf Yomi';

  @override
  String get courseRambam1 => 'Rambam · 1 capítulo/día';

  @override
  String get courseRambam3 => 'Rambam · 3 capítulos/día';

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
  String get moonAlwaysUp => 'Luna sobre el horizonte todo el día';

  @override
  String get moonAlwaysDown => 'Luna bajo el horizonte todo el día';

  @override
  String get noRiseToday => 'Hoy no sale';

  @override
  String get noSetToday => 'No set today';

  @override
  String get moonNew => 'New moon';

  @override
  String get moonWaxingCrescent => 'Luna creciente';

  @override
  String get moonFirstQuarter => 'Cuarto creciente';

  @override
  String get moonWaxingGibbous => 'Gibosa creciente';

  @override
  String get moonFull => 'Full moon';

  @override
  String get moonWaningGibbous => 'Gibosa menguante';

  @override
  String get moonLastQuarter => 'Last quarter';

  @override
  String get moonWaningCrescent => 'Luna menguante';

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
  String get weatherThunder => 'Tormentas';

  @override
  String get weatherUnavailable => 'El clima no está disponible por ahora';

  @override
  String get weatherCached => 'Pronóstico guardado';

  @override
  String get weatherUpdated => 'Updated';

  @override
  String get weatherForecast => 'Forecast';

  @override
  String get weatherThunderExpected => 'Pronóstico de tormentas';

  @override
  String get learningUnavailable => 'Conéctate para cargar el plan de estudio de este mes';

  @override
  String get festivalReading => 'Lectura de la Torá de la fiesta';

  @override
  String get learningCalendarSource => 'Calendario de estudio · Hebcal · CC BY 4.0';

  @override
  String get weatherSource => 'Pronóstico · MET Norway · CC BY 4.0';

  @override
  String get weatherConsent => 'El tiempo de la ciudad elegida. Usa coordenadas redondeadas con MET Norway.';

  @override
  String get learningConsent =>
      'Los calendarios de estudio de Rambam y otros se cargan desde Hebcal y se guardan para usarlos sin conexión.';

  @override
  String get homeRefresh => 'Refresh';

  @override
  String get skyTimezone => 'My timezone';

  @override
  String get skyShabbat => 'Shabbat city';

  @override
  String get skyReferenceCity => 'Ciudad de referencia de la zona horaria';

  @override
  String get skyChooseCity => 'Elegir ciudad del cielo';

  @override
  String get skyCityExplain =>
      'El Sol y la Luna usan las coordenadas de esta ciudad. Tu ciudad de Shabat y la zona horaria de tus alarmas se quedan como las elegiste.';

  @override
  String get skySun => 'Sun today';

  @override
  String get skyMoon => 'Moon today';

  @override
  String get moonAboveHorizon => 'Luna sobre el horizonte';

  @override
  String get moonBelowHorizon => 'Luna bajo el horizonte';

  @override
  String get moonNextNew => 'Próxima luna nueva';

  @override
  String get moonNextFull => 'Próxima luna llena';

  @override
  String get locationServicesOff =>
      'Los servicios de ubicación están desactivados. Actívalos en Ajustes o elige una ciudad.';

  @override
  String get locationDenied => 'Se denegó el acceso a la ubicación. Permítelo en Ajustes o elige una ciudad.';

  @override
  String get locationTimedOut =>
      'Aún sin ubicación. En Mac, deja el Wi-Fi activado e inténtalo de nuevo, o elige una ciudad.';

  @override
  String get locationTimeZoneUnavailable =>
      'Usa una ciudad de la zona horaria elegida, o sigue la zona horaria del dispositivo antes de usar la ubicación.';

  @override
  String get locationSettings => 'Abrir ajustes de ubicación';

  @override
  String get locationLooking => 'Obteniendo la ubicación…';

  @override
  String get skyMoonDisplay => 'Mostrar la Luna: salida, puesta y fase';

  @override
  String get tuyaConsumerPending =>
      'El inicio de sesión de cuenta aún no está disponible en esta versión. Si ya tienes un proyecto de desarrollador de Tuya, usa la configuración avanzada.';

  @override
  String get tuyaAdvanced => 'Configuración avanzada';

  @override
  String get tuyaSignInTitle => 'Inicia sesión con tu cuenta de Smart Life';

  @override
  String get tuyaSignInHint =>
      'Usa el mismo país, correo o teléfono y contraseña que en la app Smart Life o Tuya Smart. La cuenta ya debe estar vinculada a tu proyecto de Tuya. La contraseña solo va a Tuya y nunca se guarda.';

  @override
  String get tuyaCountryCode => 'Prefijo del país (Brasil 55, EE. UU. 1)';

  @override
  String get tuyaAccount => 'Correo o teléfono de Smart Life';

  @override
  String get tuyaPassword => 'Contraseña de Smart Life';

  @override
  String get tuyaSignIn => 'Iniciar sesión y cargar escenas';

  @override
  String get tuyaRelayUrl => 'Dirección del relé de Tuya de Quando (https)';

  @override
  String get tuyaRelayHint =>
      'Usa el país, el correo o teléfono y la contraseña de tu cuenta de Smart Life o Tuya Smart. Se envían una vez al relé de Tuya de Quando y no se guardan. Debes haber iniciado sesión en tu cuenta de Quando.';

  @override
  String get tuyaGoogleHint =>
      '¿Entras en Smart Life con Google o Apple? En Smart Life toca «Olvidé mi contraseña» para crear una contraseña y úsala aquí.';

  @override
  String get tuyaLinked => 'Cuenta de Smart Life vinculada';

  @override
  String get tuyaUnlink => 'Desvincular';

  @override
  String get tuyaNeedsAccount => 'Primero inicia sesión en tu cuenta de Quando en Ajustes.';

  @override
  String get roshHodeshHeading => 'Rosh Hodesh';

  @override
  String get roshHodeshExplain => 'Muestra en Inicio el primer día o los dos días del próximo mes hebreo.';

  @override
  String get roshHodeshNext => 'Próximo Rosh Jódesh';

  @override
  String get roshHodeshBegins => 'Comienza al atardecer del';

  @override
  String get openParashaSefaria => 'Leer esta porción de la Torá en Sefaria';

  @override
  String get skyMyLocation => 'My location';

  @override
  String get skyLocationLocalTimes =>
      'Las horas del cielo usan la zona horaria de esta ubicación. La zona horaria de tus alarmas y tu ciudad de Shabat no cambian. Se guarda solo en este dispositivo.';

  @override
  String get musicRingDurationHint =>
      'La reproducción sigue la duración de este aviso y se detiene con Parar o Posponer.';

  @override
  String get musicBackupPlaying => 'No se pudo iniciar la música. Está sonando el aviso local.';

  @override
  String desktopMusicConnect(String service) {
    return 'Conectar la app $service';
  }

  @override
  String desktopMusicOn(String service) {
    return 'Conectado a $service · mantén pulsado para desconectar';
  }

  @override
  String get musicSongs => 'Canciones';

  @override
  String get noMusicSongs => 'No se encontraron canciones en tu biblioteca de Música.';

  @override
  String serviceConnectUnavailable(String service) {
    return 'Añade un enlace de $service · se abre tras la alarma';
  }

  @override
  String get soundCloudWidgetNote => 'Añade un enlace público';

  @override
  String get youtubePlayerHint =>
      'YouTube reproduce vídeo en un reproductor visible. Si se oculta o no puede reproducir, continúa el aviso local.';

  @override
  String get musicPreviewFailed =>
      'No se pudo reproducir este sonido. Comprueba la conexión o prueba otra canción o emisora.';

  @override
  String get skyMoonPhase => 'Fase lunar';

  @override
  String get skyMoonDetailsDisplay => 'Añadir página de la fase lunar';

  @override
  String get skyMoonDetailsHint => 'Desliza hasta ella o toca la tarjeta de la Luna cuando quieras';

  @override
  String get moonRises => 'Sale';

  @override
  String get moonSets => 'Se pone';

  @override
  String moonLunarDay(int day) {
    return 'Día $day de 29,5 de este mes lunar';
  }

  @override
  String get moonDetailsOpen => 'Abrir fase lunar';

  @override
  String get musicPlaylists => 'Listas de música';

  @override
  String get videoPlaylists => 'Listas de vídeos';

  @override
  String get likedVideos => 'Vídeos que te gustan';

  @override
  String get wholePlaylist => 'Despertar con toda la lista';

  @override
  String get noSongsInPlaylist => 'No hay canciones que se puedan reproducir.';

  @override
  String get hebrewNamesHeading => 'Cómo escribir la parashá y los meses';

  @override
  String get hebrewNamesIsraeli => 'Israelí';

  @override
  String get hebrewNamesAshkenazi => 'Asquenazí';

  @override
  String pickFromService(String service) {
    return 'Elegir de mi $service';
  }

  @override
  String get weatherTonight => 'Esta noche';

  @override
  String get weatherTomorrowMorning => 'Mañana por la mañana';

  @override
  String weatherUntilAbout(String time) {
    return 'hasta cerca de las $time';
  }

  @override
  String get weatherSunBehindClouds => 'Sol tras las nubes';

  @override
  String get keysLockTitle => 'Claves en tus dispositivos';

  @override
  String get keysLockOff =>
      'Tus claves de servicio se quedan en este dispositivo. Elige una frase de sincronización para enviarlas, cifradas, a tus otros dispositivos.';

  @override
  String get keysLockOn =>
      'Tus claves de servicio se cifran con tu frase de sincronización antes de salir de este dispositivo. Nadie más, ni siquiera Google, puede leerlas.';

  @override
  String get keysLockWaiting =>
      'Llegaron aquí claves de tu otro dispositivo, bloqueadas. Escribe tu frase de sincronización para abrirlas.';

  @override
  String get keysSetPassphrase => 'Elegir frase';

  @override
  String get keysChangePassphrase => 'Cambiar frase';

  @override
  String get keysUnlock => 'Desbloquear claves';

  @override
  String get keysStartOver => '¿La olvidaste? Empezar de nuevo';

  @override
  String get keysStartOverHint =>
      'Empezar de nuevo envía las claves de este dispositivo con una frase nueva. Tus otros dispositivos pedirán la nueva.';

  @override
  String get keysPassphrase => 'Frase de sincronización';

  @override
  String get keysPassphraseAgain => 'Escríbela otra vez';

  @override
  String keysPassphraseShort(int count) {
    return 'Usa al menos $count caracteres.';
  }

  @override
  String get keysPassphraseMismatch => 'No coinciden.';

  @override
  String get keysPassphraseWrong => 'Esa frase no abre estas claves.';

  @override
  String get keysPassphraseNote =>
      'Anótala: si la olvidas, nadie puede recuperarla y tendrás que escribir tus claves otra vez.';

  @override
  String get keysShareNeedsPassphrase =>
      'Primero elige una frase de sincronización, en Claves en tus dispositivos.';

  @override
  String get settingsAlarmDefaults => 'Valores de las alarmas';

  @override
  String get settingsPlacesTime => 'Lugares y hora';

  @override
  String get settingsLook => 'Aspecto, idioma y citas';

  @override
  String get settingsAbout => 'About';

  @override
  String get defaultForNewAlarms => 'Valor para alarmas nuevas';

  @override
  String get preview => 'Preview';

  @override
  String atClock(String time) {
    return 'at $time';
  }

  @override
  String get connectACalendar => 'Conectar un calendario';

  @override
  String get newFromReadyMade => 'Desde una lista hecha';

  @override
  String get newFromReadyMadeHint => 'Amanecer, atardecer y otras alarmas ya preparadas para ti';

  @override
  String get calendarSourcesIntro =>
      'Quando? puede sonar antes y después de los eventos de tus calendarios. Elige de dónde vienen.';

  @override
  String get deviceCalendarsHeading => 'EN ESTE DISPOSITIVO';

  @override
  String get deviceCalendarsTitle => 'App de calendario de este dispositivo';

  @override
  String get deviceCalendarsHint =>
      'Todas sus cuentas: Google, Samsung, Outlook, iCloud y calendarios guardados solo aquí.';

  @override
  String get googleCalendarHeading => 'GOOGLE CALENDAR';

  @override
  String get googleCalendarSignIn =>
      'Inicia sesión con Google para leer tus calendarios directamente de Google, aunque tu cuenta de Google no esté en este dispositivo.';

  @override
  String googleCalendarSignedIn(String email) {
    return 'Sesión iniciada como $email';
  }

  @override
  String get googleCalendarSignOut => 'Cerrar sesión';

  @override
  String get googleCalendarNotHere =>
      'El inicio de sesión con Google aún no está disponible en este dispositivo. Añade tu cuenta de Google en los ajustes del dispositivo (Calendario › Cuentas) y sus calendarios aparecerán en este dispositivo.';

  @override
  String get googleCalendarUnreachable =>
      'No se pudo acceder a Google Calendar ahora. Las alarmas ya creadas con él siguen sonando.';

  @override
  String get googleCalendarTwiceHint =>
      'Los calendarios que este dispositivo ya muestra de la misma cuenta de Google empiezan apagados, para que nada suene dos veces.';

  @override
  String get timersTitle => 'Temporizadores';

  @override
  String get timerStopwatch => 'Cronómetro';

  @override
  String get timerCountdown => 'Temporizador';

  @override
  String get timerSequence => 'Prepárate';

  @override
  String get timerStopwatchSub => 'Cuenta hacia arriba, con vueltas';

  @override
  String get timerCountdownSub => 'Cuenta atrás, suena al llegar a cero';

  @override
  String get timerSequenceSub => 'Salida y marcas habladas';

  @override
  String get timerStart => 'Iniciar';

  @override
  String get timerPause => 'Pausar';

  @override
  String get timerResume => 'Reanudar';

  @override
  String get timerReset => 'Reiniciar';

  @override
  String get timerLap => 'Vuelta';

  @override
  String get timerTimesUp => 'Se acabó el tiempo';

  @override
  String get timerSetTime => 'Ajusta el tiempo';

  @override
  String get timerMinutes => 'Minutos';

  @override
  String get timerSeconds => 'Segundos';

  @override
  String get seqOnYourMarks => 'En sus marcas';

  @override
  String get seqGetSet => 'Listos';

  @override
  String get seqGo => '¡Ya!';

  @override
  String get seqFinish => '¡Tiempo!';

  @override
  String get seqReady => 'Listo';

  @override
  String get seqSettings => 'Ajustes';

  @override
  String get seqStartCalls => 'Avisos antes de la salida';

  @override
  String get seqStartCallsHelp =>
      'Se dicen en voz alta antes del ¡Ya!, contando hacia atrás desde la salida.';

  @override
  String seqCallBefore(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n segundos antes',
      one: '1 segundo antes',
    );
    return '$_temp0';
  }

  @override
  String get seqAddCall => 'Añadir un aviso';

  @override
  String get seqCallText => 'Qué decir';

  @override
  String get seqGoText => 'Al empezar, decir';

  @override
  String get seqFinishText => 'Al terminar, decir';

  @override
  String get seqLength => 'Duración';

  @override
  String get seqNoLimit => 'Sin límite';

  @override
  String get seqSayEvery => 'Decir la hora cada';

  @override
  String get seqOff => 'No';

  @override
  String seqEverySeconds(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n segundos', one: '1 segundo');
    return '$_temp0';
  }

  @override
  String seqEveryMinutes(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n minutos', one: '1 minuto');
    return '$_temp0';
  }

  @override
  String get seqFinalCount => 'Cuenta atrás de los últimos';

  @override
  String get seqMarks => 'Tus marcas';

  @override
  String get seqAddMark => 'Añadir una marca';

  @override
  String seqMarkAt(String time) {
    return 'A las $time';
  }

  @override
  String get seqSpeak => 'Hablar en voz alta';

  @override
  String get seqBeeps => 'Pitidos y vibración';

  @override
  String get seqSayRemaining => 'Decir el tiempo restante, no el transcurrido';

  @override
  String get seqPresets => 'Preajustes';

  @override
  String get seqPresetRace => 'Salida de carrera';

  @override
  String get seqPresetSprint => 'Esfuerzo de 30 s';

  @override
  String get seqPresetRound => 'Ronda de 1 min';

  @override
  String get seqHintNoLimit => 'Tras el ¡Ya! cuenta hacia arriba hasta que lo detengas.';

  @override
  String get seqHintLength => 'Tras el ¡Ya! cuenta hacia atrás hasta cero.';

  @override
  String get seqWords => 'Palabras';

  @override
  String get homeEdit => 'Arrange home';

  @override
  String get homeEditHint => 'Arrastra el asa para mover una tarjeta, plegarla o cambiar su tamaño.';

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
  String get homeBlockSky => 'SOL, LUNA Y CLIMA';

  @override
  String get homeBlockQuick => 'QUICK ALARMS';

  @override
  String get homeBlockShabbat => 'SHABAT Y FIESTAS';

  @override
  String get homePlaceTitle => 'Ciudad para el cielo';

  @override
  String nextAlarmLine(String title, String time) {
    return 'Próxima alarma · $title $time';
  }

  @override
  String get showAllAlarms => 'Mostrar todos los días';

  @override
  String get noAlarmsThatDay => 'No suena nada este día';

  @override
  String get homeClockSize => 'Reloj en el inicio';

  @override
  String get sizeSmall => 'Pequeño';

  @override
  String get sizeMedium => 'Mediano';

  @override
  String get sizeLarge => 'Grande';

  @override
  String get homeLayout => 'Diseño de inicio';

  @override
  String get homeLayoutClassic => 'Clásico';

  @override
  String get homeLayoutCards => 'Tarjetas';

  @override
  String get homeCardsHint =>
      'Arrastra una tarjeta para moverla. Arrastra su borde o esquina para cambiar el tamaño, o elige uno.';

  @override
  String get homeAddCard => 'Añadir tarjeta';

  @override
  String get homeOnHome => 'En inicio';

  @override
  String get homeRemoveCard => 'Quitar';

  @override
  String get cardNext => 'Próxima alarma';

  @override
  String get cardClock => 'Reloj y fecha';

  @override
  String get cardSky => 'Sol, luna y clima';

  @override
  String get cardMoon => 'Luna';

  @override
  String get cardWeather => 'Clima';

  @override
  String get cardAlarms => 'Tus alarmas';

  @override
  String get cardQuick => 'Alarmas rápidas';

  @override
  String get cardTools => 'Cronómetro, temporizador y listos';

  @override
  String get cardWorld => 'Relojes mundiales';

  @override
  String get cardWeek => 'Esta semana';

  @override
  String get cardShabbat => 'Shabat y festividades';

  @override
  String get ringAtEventReminders => 'Sonar en los recordatorios del propio evento';

  @override
  String get ringAtEventRemindersHint =>
      'Los recordatorios de tu app de calendario suenan aquí como alarmas fuertes, con el sonido de esta alarma.';

  @override
  String get atEventReminders => 'en los recordatorios del evento';

  @override
  String get everyEventReminderLoud => 'Sonar fuerte en los recordatorios de cada evento';

  @override
  String get loudNotificationsHeading => 'NOTIFICACIONES DE CALENDARIO FUERTES';

  @override
  String get loudNotificationsTitle => 'Hacer sonar fuerte las notificaciones del calendario';

  @override
  String get loudNotificationsHint =>
      'Cuando una app de calendario muestra un recordatorio, Quando? lo hace sonar como alarma, incluso con el teléfono en silencio.';

  @override
  String get loudNotificationsDisclosureTitle =>
      '¿Permitir que Quando? lea las notificaciones del calendario?';

  @override
  String get loudNotificationsDisclosure =>
      'Para hacer sonar tus recordatorios, Quando? necesita acceso a las notificaciones. Solo mira las de las apps de calendario que elijas, lee su título y texto en este teléfono para mostrarlos en la alarma y nunca los guarda ni los envía a ningún lado. Puedes desactivarlo cuando quieras.';

  @override
  String get loudNotificationsAgree => 'Aceptar y continuar';

  @override
  String get loudNotificationsNoAccess =>
      'El acceso a notificaciones está desactivado. Activa Quando? en la lista que se abre.';

  @override
  String get loudNotificationsAllow => 'Permitir';

  @override
  String get loudNotificationsNoApps =>
      'No se encontró ninguna app de calendario compatible en este teléfono.';

  @override
  String get loudNotificationsTwiceNote =>
      'Los eventos que ya tienen una alarma de calendario de Quando? suenan una sola vez.';

  @override
  String get loudNotificationsShabbatNote => 'En silencio durante Shabat y las festividades.';

  @override
  String get busyMode => 'Modo ocupado';

  @override
  String get busyModeSubtitle => 'No molestar y respuestas automáticas mientras estás ocupado';

  @override
  String get busyIntro =>
      'Mientras estás ocupado, Quando? puede silenciar el teléfono y responder mensajes por ti. Las alarmas siguen sonando.';

  @override
  String get busyIosFocus =>
      'En iPhone y iPad, las apps no pueden activar Concentración ni responder mensajes. En la app Atajos, crea una automatización \"Al abrir Quando?\" o a una hora que active una Concentración, y configúrala para responder automáticamente.';

  @override
  String get busyWhileHeading => 'MIENTRAS ESTÁS OCUPADO';

  @override
  String get busyDnd => 'No molestar';

  @override
  String get busyDndHint =>
      'Solo prioridad: llamadas y mensajes en silencio, las alarmas suenan. Vuelve a la normalidad al terminar.';

  @override
  String get busyDndNoAccess => 'Quando? aún no puede cambiar No molestar.';

  @override
  String get busyReplies => 'Responder mensajes';

  @override
  String get busyRepliesHint =>
      'Una vez por persona, con tu texto, mediante el botón Responder de la app. Solo Android.';

  @override
  String get busyRepliesDisclosureTitle => '¿Permitir que Quando? responda mensajes?';

  @override
  String get busyRepliesDisclosure =>
      'Para responder por ti, Quando? necesita acceso a las notificaciones. Solo mientras estás ocupado, mira las notificaciones de mensajes de las apps que elijas, lee el nombre del remitente en este teléfono y envía tu texto una vez mediante el botón Responder de la app. Los mensajes nunca se guardan ni se envían a otro sitio. Los grupos se omiten salvo que lo permitas.';

  @override
  String get busyReplyText => 'Tu respuesta';

  @override
  String busyReplyTextHint(String until) {
    return '$until se convierte en la hora en que termina el modo ocupado.';
  }

  @override
  String busyReplyDefault(String until) {
    return 'Ahora estoy ocupado y responderé después de las $until.';
  }

  @override
  String get busyGroups => 'Responder también en grupos';

  @override
  String get busyGroupsHint => 'Desactivado: los grupos nunca reciben respuesta.';

  @override
  String get busyRepliesOnShabbat => 'Responder durante Shabat y festividades';

  @override
  String get busyAskRabbi => 'Desactivado por defecto. Consulta a tu rabino antes de activarlo en Shabat.';

  @override
  String get busyWhenHeading => 'CUÁNDO ESTÁS OCUPADO';

  @override
  String get busyWhenHint =>
      'Activa \"Ocupado durante estos eventos\" en una alarma de calendario, u \"Ocupado después de sonar\" en una alarma.';

  @override
  String get busyDuringLock => 'Ocupado mientras el modo bloqueo está activo';

  @override
  String get busyNoneComing => 'Nada ocupado en los próximos 7 días.';

  @override
  String get busyDuringEvents => 'Ocupado durante estos eventos';

  @override
  String get busyDuringEventsHint => 'Modo ocupado desde el inicio hasta el final de cada evento.';

  @override
  String get busySettings => 'Ajustes del modo ocupado';

  @override
  String get busyAfterRing => 'Ocupado después de sonar';

  @override
  String get busyAfterRingHint =>
      'No molestar y respuestas automáticas un rato, como un entrenamiento o una siesta.';

  @override
  String get shareCard => 'Comparte tu mañana';

  @override
  String get shareCardSubtitle => 'El cielo y la frase de hoy, o tu foto, para Stories y estados';

  @override
  String get shareAppMissing => 'Esa app no está en este teléfono.';

  @override
  String get shareAsIs => 'Compartir tal cual';

  @override
  String get shareTapQuote => 'Toca la frase para cambiarla.';

  @override
  String get shareStory => 'Historia';

  @override
  String get shareSquare => 'Cuadrado';

  @override
  String get shareYourWords => 'Tus propias palabras (opcional)';

  @override
  String get shareYourWordsHint => 'En lugar de la frase de hoy';

  @override
  String get shareYourPhoto => 'Tu foto';

  @override
  String get shareOtherPhoto => 'Otra foto';

  @override
  String get shareSkyBack => 'El cielo de hoy';

  @override
  String get shareYourVideo => 'Tu video';

  @override
  String get shareInstagramStory => 'Historias de Instagram';

  @override
  String get shareWhatsApp => 'WhatsApp: estado o chat';

  @override
  String get shareMore => 'Más apps';

  @override
  String get shareYouPost => 'Quando? abre la app con tu tarjeta lista. Tú eliges dónde y tocas Publicar.';

  @override
  String get shareAndroidFirst => 'Compartir llegará pronto a iPhone y iPad.';

  @override
  String songSaved(String name) {
    return '“$name” guardado como sonido de alarma';
  }

  @override
  String get shareToQuando => 'Comparte una canción con Quando?';

  @override
  String get shareToQuandoHint =>
      'En YouTube, YouTube Music, Spotify, SoundCloud o Apple Music, toca Compartir y luego Quando?. Se convierte en un sonido de alarma que suena en su app.';

  @override
  String get askOption => 'Dilo o escríbelo';

  @override
  String get askOptionHint => '“Mañana a las 6”, “30 min antes del amanecer”';

  @override
  String get askHint => 'p. ej.: despiértame 30 min antes del amanecer entre semana';

  @override
  String get askListening => 'Escuchando…';

  @override
  String get askNotUnderstood => 'No encontré una hora. Prueba “7 am entre semana” o “en 20 minutos”.';

  @override
  String askAnswerFromCalendar(String name) {
    return 'De tu calendario “$name”';
  }

  @override
  String get askAnswerBuiltIn => 'Horarios propios de Quando? para tu ciudad';

  @override
  String get askNoAnswer => 'Aún no encontré una hora para eso.';

  @override
  String get askNoSpeech => 'La voz no está disponible en este dispositivo. Puedes escribir.';

  @override
  String get askShabbatOff => 'Activa el Shabat en Ajustes para que suenen sus horarios.';

  @override
  String askSaved(String what) {
    return 'Guardado: $what';
  }

  @override
  String get askMic => 'Hablar';

  @override
  String get askMorning => 'Mañana';

  @override
  String get askEvening => 'Noche';

  @override
  String get askUnsure => 'Puede que me haya perdido parte. Revísalo antes de guardar.';

  @override
  String get askTeach => 'Enséñame esto';

  @override
  String askTaught(String phrase, String time) {
    return 'Entendido: “$phrase” ahora significa $time.';
  }

  @override
  String get askSkipAction => 'Saltar';

  @override
  String get askNoMatch => 'Ninguna alarma coincide.';

  @override
  String askTurnedOff(String what) {
    return 'Desactivada: $what';
  }

  @override
  String askSkipped(String what) {
    return 'Saltada: $what';
  }

  @override
  String askEventPlan(String offset, String event) {
    return '$offset “$event” en tu calendario';
  }

  @override
  String askEventNoCalendar(String event) {
    return 'Conecta un calendario para que Quando? encuentre “$event”.';
  }

  @override
  String askSnoozeAll(int minutes) {
    return 'Posponer: $minutes min, para esta alarma';
  }

  @override
  String askWakeWith(String sound) {
    return 'Te despierta con $sound';
  }

  @override
  String get askReadAs => 'Leído como';

  @override
  String get askHelpTitle => 'Ayuda a mejorar las alarmas por voz';

  @override
  String get askHelpBody =>
      'Envía lo que dices o escribes, y lo que hiciste con ello, de forma anónima. Sin cuenta ni ID del dispositivo.';

  @override
  String get askHelpPromptTitle => '¿Ayudar a Quando? a entenderte?';

  @override
  String askHelpPromptBody(String sentence) {
    return 'Enviaríamos lo que dices o escribes, como “$sentence”, y si lo guardaste. Anónimo: sin nombre, cuenta ni ID del dispositivo. Puedes desactivarlo cuando quieras.';
  }

  @override
  String get askHelpYes => 'Sí, ayudar';

  @override
  String get askHelpNo => 'No, gracias';

  @override
  String get askQuoteTranslation =>
      'La vida no es la que uno vivió, sino la que uno recuerda y cómo la recuerda para contarla.';

  @override
  String get askHelpQuote => '';
  String get quickSetups => 'Ajustes rápidos';

  @override
  String get qsMorningTitle => 'Una mañana que funciona';

  @override
  String get qsStartTitle => 'No te pierdas ningún inicio';

  @override
  String get qsStretchTitle => 'Trabaja por tramos';

  @override
  String get qsWillChange => 'Qué cambiará';

  @override
  String get qsAlreadyOn => 'Ya está activado. Nada que cambiar.';

  @override
  String get qsApply => 'Aplicar';

  @override
  String get qsDone => 'Hecho';

  @override
  String get qsUndo => 'Deshacer';

  @override
  String get qsSnoozeTimes => 'Repeticiones permitidas';

  @override
  String get qsSnoozeMinutes => 'Minutos de repetición';

  @override
  String get qsFiveLeft => 'Faltan 5 minutos';

  @override
  String get syncHeading => 'Cuando cambie el calendario';

  @override
  String get syncLive => 'Seguir el calendario';

  @override
  String get syncLiveHint =>
      'Los eventos nuevos tienen alarma. Si un evento se mueve, su alarma también. Si se borra, su alarma desaparece.';

  @override
  String get syncKeepFirst => 'Mantener lo que vi primero';

  @override
  String get syncKeepFirstHint =>
      'Los eventos nuevos siguen teniendo alarma. Una vez puesta, la alarma se queda, aunque el evento se mueva o se borre.';

  @override
  String get syncSnapshot => 'Solo los eventos que existen ahora';

  @override
  String get syncSnapshotHint =>
      'Solo los eventos que están en tu calendario al guardar, tal como están ahora. No se añade nada nuevo después.';

  @override
  String get syncHelpButton => 'Cómo funciona';

  @override
  String get syncHelpTitle => 'Cómo siguen las alarmas tu calendario';

  @override
  String get syncHelpIntro =>
      'Esta regla sigue buscando eventos que coinciden con tu búsqueda. Tú eliges qué pasa cuando cambia tu calendario.';

  @override
  String get syncHelpExampleLive =>
      'Ejemplo: una regla para “dentista”. El dentista pasa la cita del martes al miércoles y tu alarma también pasa al miércoles. Si se cancela la cita, su alarma desaparece.';

  @override
  String get syncHelpExampleKeepFirst =>
      'Misma regla: la cita pasa al miércoles, pero tu alarma se queda el martes, como Quando? la vio primero. Una cita nueva el mes que viene sigue teniendo su alarma.';

  @override
  String get syncHelpExampleSnapshot =>
      'Misma regla: tienes alarmas para las citas que hay hoy en tu calendario, y se quedan como están. Una cita añadida el mes que viene no tiene alarma.';

  @override
  String get syncHelpTip => '¿Dudas? Deja “Seguir el calendario”.';

  @override
  String get syncHelpWhenTitle => '¿Cuándo nota Quando? los cambios?';

  @override
  String get syncHelpWhenOpen =>
      'Con Quando? abierto: en segundos. Google Calendar conectado aquí se revisa cada 2 minutos.';

  @override
  String get syncHelpWhenClosed =>
      'Con Quando? cerrado: la próxima vez que lo abras. Hasta entonces, las alarmas ya puestas suenan a las horas que tenían.';

  @override
  String get syncHelpWhenClosedApple =>
      'iPhone y iPad no dejan que las apps vigilen el calendario en segundo plano, así que los cambios entran al abrir Quando?.';

  @override
  String get tapMiddleToStop => 'Toca el centro para parar';

  @override
  String get uiSimple => 'Simple';

  @override
  String get uiEverything => 'Todo';

  @override
  String get firstRunTitle => '¿Cuánto quieres ver?';

  @override
  String get firstRunSimpleHint => 'Alarmas y lo básico';

  @override
  String get firstRunEverythingHint => 'Calendario, Shabat, temporizadores, clima y más';

  @override
  String get firstRunChangeLater => 'Puedes cambiarlo cuando quieras en Ajustes.';

  @override
  String get continueLabel => 'Continuar';

  @override
  String get everyAlarm => 'Cada alarma';

  @override
  String get wakeMeWith => 'Despertarme con';

  @override
  String get ringOrMusic => 'Tono o música';

  @override
  String get ringsForRow => 'Suena durante';

  @override
  String gentleBeforeValue(int minutes) {
    return '$minutes min antes';
  }

  @override
  String get quandoSounds => 'Sonidos de Quando?';

  @override
  String get aSongApps => 'Una canción (Spotify, YouTube…)';

  @override
  String get myRecording => 'Mi grabación';

  @override
  String get useForNewAlarms => 'Usar en alarmas nuevas';

  @override
  String get iWillLabel => 'Cuando suene, voy a…';

  @override
  String get foldVolume => 'Volumen y fundidos';

  @override
  String get foldSnoozeStop => 'Posponer y detener';

  @override
  String get foldExtras => 'Calendario y extras';

  @override
  String get groupAlarms => 'Alarmas';

  @override
  String get groupCalendarShabbat => 'Calendario y Shabat';

  @override
  String get groupLookQuotes => 'Aspecto y citas';

  @override
  String get groupConnectionsSync => 'Conexiones y sincronización';

  @override
  String qsSummary(int count, int on) {
    return '$count ajustes · $on activo(s)';
  }
}
