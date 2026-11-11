// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Ukrainian (`uk`).
class AppLocalizationsUk extends AppLocalizations {
  AppLocalizationsUk([String locale = 'uk']) : super(locale);

  @override
  String get undo => 'Скасувати';

  @override
  String duplicatedNamed(String name) {
    return '«$name» скопійовано';
  }

  @override
  String deletedNamed(String name) {
    return '«$name» видалено';
  }

  @override
  String get when => 'Коли?';

  @override
  String get newAtTime => 'У певний час';

  @override
  String get newAtTimeHint => 'У будні о 7:00, один раз о 15:30…';

  @override
  String get newAroundEvent => 'Навколо події';

  @override
  String get newAroundEventHint =>
      'Шукайте в календарях, часі шабату й сонця та дзвоніть до, під час або після';

  @override
  String get editThisAlarm => 'Змінити цей будильник';

  @override
  String editNamed(String name) {
    return 'Змінити «$name»';
  }

  @override
  String get preset => 'шаблон';

  @override
  String get editThisCalendarRule => 'Змінити це правило календаря';

  @override
  String get ringThisOneAfterAll => 'Все ж задзвонити';

  @override
  String get skipJustThisOne => 'Пропустити лише цей';

  @override
  String get renameGroup => 'Перейменувати групу';

  @override
  String quickSet(String label, String time) {
    return '$label · задзвонить о $time';
  }

  @override
  String get newAlarm => 'Новий будильник';

  @override
  String get appName => 'Quando?';

  @override
  String get lockMode => 'Режим блокування';

  @override
  String get calendars => 'Календарі';

  @override
  String get settings => 'Налаштування';

  @override
  String get nextAlarmHeading => 'НАСТУПНИЙ БУДИЛЬНИК';

  @override
  String get nothingSet => 'Нічого не задано';

  @override
  String get tagline => 'Усьому свій час.';

  @override
  String sunriseAt(String time) {
    return 'Схід $time';
  }

  @override
  String sunsetAt(String time) {
    return 'Захід $time';
  }

  @override
  String get alarmsMayNotRing => 'Будильники можуть не задзвонити';

  @override
  String get tapToFixIt => 'Торкніться, щоб виправити';

  @override
  String inMinutes(int minutes) {
    return 'За $minutes хв';
  }

  @override
  String get atSunset => 'На заході сонця';

  @override
  String get sunset => 'Захід сонця';

  @override
  String get shabbatModeIsOn => 'РЕЖИМ ШАБАТУ УВІМКНЕНО';

  @override
  String nextInCity(String city) {
    return 'ДАЛІ · $city';
  }

  @override
  String get candleLighting => 'Запалювання свічок';

  @override
  String get havdalah => 'Авдала';

  @override
  String get shabbatAndFestivals => 'Шабат і свята';

  @override
  String get yourAlarmsHeading => 'ВАШІ БУДИЛЬНИКИ';

  @override
  String get tapWhenToAdd => 'Торкніться «Коли?», щоб додати будильник.';

  @override
  String get aroundEventsHeading => 'НАВКОЛО ПОДІЙ';

  @override
  String searchFor(String words) {
    return 'пошук: $words';
  }

  @override
  String get thisWeekHeading => 'БУДИЛЬНИКИ ЦЬОГО ТИЖНЯ';

  @override
  String get noAlarmsThisWeek => 'Немає будильників у найближчі 7 днів.';

  @override
  String get alarmsSetThemselves => 'Будильники самі налаштовуються на цьому телефоні після кожної зміни.';

  @override
  String cityTime(String city) {
    return 'час $city';
  }

  @override
  String get more => 'Ще';

  @override
  String get turnOff => 'Вимкнути';

  @override
  String get turnOn => 'Увімкнути';

  @override
  String get duplicate => 'Копіювати';

  @override
  String get delete => 'Видалити';

  @override
  String get inOneHour => 'За 1 годину';

  @override
  String get logoLabel => 'Логотип Quando?';

  @override
  String get noTimesSet => 'Час не задано';

  @override
  String get atTheMoment => 'у момент події';

  @override
  String timesRange(int count, String from, String to) {
    return '$count разів · з $from до $to';
  }

  @override
  String spanDays(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n дня',
      many: '$n днів',
      few: '$n дні',
      one: '$n день',
    );
    return '$_temp0';
  }

  @override
  String spanHours(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n години',
      many: '$n годин',
      few: '$n години',
      one: '$n година',
    );
    return '$_temp0';
  }

  @override
  String spanMinutes(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n хвилини',
      many: '$n хвилин',
      few: '$n хвилини',
      one: '$n хвилина',
    );
    return '$_temp0';
  }

  @override
  String spanSeconds(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n секунди',
      many: '$n секунд',
      few: '$n секунди',
      one: '$n секунда',
    );
    return '$_temp0';
  }

  @override
  String get now => 'зараз';

  @override
  String spanBefore(String span) {
    return 'за $span до';
  }

  @override
  String spanAfter(String span) {
    return 'через $span після';
  }

  @override
  String alarmCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n будильника',
      many: '$n будильників',
      few: '$n будильники',
      one: '$n будильник',
    );
    return '$_temp0';
  }

  @override
  String get allOn => 'усі увімкнені';

  @override
  String get allOff => 'усі вимкнені';

  @override
  String someOn(int n) {
    return 'увімкнено: $n';
  }

  @override
  String skippedBody(String body) {
    return 'Пропущено · $body';
  }

  @override
  String timeToTime(String from, String to) {
    return '$from – $to';
  }

  @override
  String skippedCount(int n) {
    return 'пропущено: $n';
  }

  @override
  String get sunNoRiseSet => 'Сьогодні тут сонце не сходить і не заходить';

  @override
  String sunProgress(int percent) {
    return 'Сонце пройшло $percent% дня';
  }

  @override
  String get sunIsDown => 'Сонце зайшло';

  @override
  String get searchCity => 'Знайти місто';

  @override
  String get tomorrowLower => 'завтра';

  @override
  String get yesterdayLower => 'учора';

  @override
  String get worldClocksHeading => 'СВІТОВИЙ ЧАС';

  @override
  String get add => 'Додати';

  @override
  String cityHere(String city) {
    return '$city · тут';
  }

  @override
  String get worldClocksHint => 'Додайте міста, щоб бачити тут їхній час. Проведіть ліворуч, щоб видалити.';

  @override
  String get groupNameHint => 'Робота, Діти, Спортзал…';

  @override
  String get cancel => 'Скасувати';

  @override
  String get ok => 'OK';

  @override
  String get noGroup => 'Без групи';

  @override
  String get newGroupEllipsis => 'Нова група…';

  @override
  String get newGroup => 'Нова група';

  @override
  String secondsShort(int n) {
    return '$n с';
  }

  @override
  String minutesShort(int n) {
    return '$n хв';
  }

  @override
  String get minutes => 'Хвилини';

  @override
  String get ringFor => 'Дзвонити';

  @override
  String get seconds => 'Секунди';

  @override
  String get oneSecondLess => 'На 1 секунду менше';

  @override
  String get oneSecondMore => 'На 1 секунду більше';

  @override
  String inDays(int d) {
    return 'за $d д';
  }

  @override
  String inDaysHours(int d, int h) {
    return 'за $d д $h год';
  }

  @override
  String inHours(int h) {
    return 'за $h год';
  }

  @override
  String inHoursMinutes(int h, int m) {
    return 'за $h год $m хв';
  }

  @override
  String inMins(int m) {
    return 'за $m хв';
  }

  @override
  String placeChange(String city, String where) {
    return '$city · $where · змінити';
  }

  @override
  String get israel => 'Ізраїль';

  @override
  String get outsideIsrael => 'поза Ізраїлем';

  @override
  String get comingUpHeading => 'НЕЗАБАРОМ';

  @override
  String get lockForShabbat => 'Блокувати телефон на шабат';

  @override
  String get lockForShabbatHint => 'Від запалювання свічок до авдали, і у свята теж';

  @override
  String get ownShabbatAlarmsHeading => 'ВАШІ БУДИЛЬНИКИ НА ШАБАТ';

  @override
  String get addShabbatAlarm => 'Додати будильник на шабат чи свято';

  @override
  String get readyMadeHeading => 'ГОТОВІ БУДИЛЬНИКИ';

  @override
  String bringBackDeleted(int n) {
    return 'Повернути видалені ($n)';
  }

  @override
  String get presetsHint => 'Торкніться, щоб змінити час. Проведіть, щоб видалити.';

  @override
  String get lockSentence =>
      'Залиште на телефоні лише годинник і будильники — на шабат або ніч без відволікань.';

  @override
  String get lockExplain =>
      'Під час блокування Quando? показує лише час, наступний будильник і кінець блокування. Будильники працюють, а змінити нічого не можна до розблокування.';

  @override
  String get lockNowHeading => 'ЗАБЛОКУВАТИ ЗАРАЗ';

  @override
  String get lockAutoHeading => 'БЛОКУВАТИ АВТОМАТИЧНО';

  @override
  String get shabbatAndFestivalsLong => 'Шабат і свята';

  @override
  String get fromCandleToHavdalah => 'Від запалювання свічок до авдали';

  @override
  String get lockCalendarWord => 'Під час подій календаря з цим словом';

  @override
  String get lockCalendarWordHint => 'напр. блокування, іспит, фокус';

  @override
  String get leaveEmptyForNone => 'Залиште порожнім, щоб вимкнути';

  @override
  String get connectCalendarsFirst => 'Спочатку підключіть календарі (значок календаря)';

  @override
  String get openWhenLockStarts => 'Відкривати Quando? на початку блокування';

  @override
  String get openWhenLockStartsHint => 'Тихий звук на 1 секунду виводить Quando? на екран для блокування';

  @override
  String get pinToScreen => 'Закріпити Quando? на екрані';

  @override
  String get pinToScreenHint =>
      'Інші застосунки не відкриються під час блокування. Першого разу Android попросить підтвердити.';

  @override
  String get noLocksComingUp => 'Блокувань не заплановано.';

  @override
  String get leaveLockEarly => 'Щоб вийти раніше, утримуйте «Утримуйте для розблокування» 3 секунди.';

  @override
  String get locked => 'Заблоковано';

  @override
  String get shabbatShalom => 'Шабат шалом';

  @override
  String get chagSameach => 'Хаг самеах';

  @override
  String get unlocksHeading => 'РОЗБЛОКУЄТЬСЯ';

  @override
  String get nowCap => 'Зараз';

  @override
  String get nextAlarm => 'Наступний будильник';

  @override
  String get holdToUnlock => 'Утримуйте для розблокування';

  @override
  String get lockSentenceCalm =>
      'Заблокуйте телефон на годиннику й будильниках: на іспит, зустріч чи тихий вечір.';

  @override
  String get lockCalendarHeading => 'ЗА КАЛЕНДАРЕМ';

  @override
  String get lockCalendarExplain =>
      'Блокування під час події або від однієї події до наступної, яку ви вкажете. Працює з будь-яким вибраним календарем, і зі спільними теж.';

  @override
  String get lockAddCalendar => 'Додати блокування за календарем';

  @override
  String get lockEditCalendar => 'Блокування за календарем';

  @override
  String get lockDuring => 'Під час події';

  @override
  String get lockBetween => 'Між двома подіями';

  @override
  String get lockStartsAt => 'Події з назвою…';

  @override
  String get lockStartsAtBetween => 'Починається з події…';

  @override
  String get lockEndsAt => 'Закінчується на наступній події…';

  @override
  String get lockStartHint => 'напр. іспит, фокус, спорт';

  @override
  String get lockEndHint => 'напр. вдома';

  @override
  String get lockAnyCalendar => 'Будь-який календар';

  @override
  String get lockNoMatches => 'У календарях поки нічого не підходить.';

  @override
  String get lockNextTimes => 'НАСТУПНІ РАЗИ';

  @override
  String lockDuringTitle(String a) {
    return 'Під час «$a»';
  }

  @override
  String lockBetweenTitle(String a, String b) {
    return 'Від «$a» до наступної «$b»';
  }

  @override
  String lockShabbatCalendarFound(String name) {
    return 'У «$name» є час шабату.';
  }

  @override
  String get lockShabbatFromCalendar => 'Блокувати від запалення свічок до авдали';

  @override
  String get lockShabbatFromCalendarHint => 'Бере час із цього календаря, зі свічками на екрані.';

  @override
  String get lockMoreWays => 'Інші способи блокування';

  @override
  String get lockQuietTime => 'Час тиші';

  @override
  String nextCandleLightingFrom(String time, String name) {
    return 'Наступне запалення свічок: $time, з $name';
  }

  @override
  String get calendarAlarm => 'Будильник календаря';

  @override
  String get connectCalendars => 'Підключити календарі';

  @override
  String get calendarAlarmsHeading => 'БУДИЛЬНИКИ КАЛЕНДАРЯ';

  @override
  String get calendarNoneYet => 'Поки немає. Почніть із цього й змініть як завгодно:';

  @override
  String get fifteenBeforeEvery => 'За 15 хвилин до кожної події';

  @override
  String get useTheseCalendarsHeading => 'ВИКОРИСТОВУВАТИ ЦІ КАЛЕНДАРІ';

  @override
  String get noTimedEvents => 'У цих календарях немає майбутніх подій із часом.';

  @override
  String get atTheStart => 'на початку';

  @override
  String everyForBefore(String every, String span) {
    return 'кожні $every протягом $span до';
  }

  @override
  String spanAfterItEnds(String span) {
    return 'через $span після завершення';
  }

  @override
  String get noAlarmsChosen => 'Будильники не вибрано';

  @override
  String get gentleWakeUp => 'М’яке пробудження';

  @override
  String gentleSummary(int minutes, String sound) {
    return 'за $minutes хв · $sound';
  }

  @override
  String get off => 'Вимк.';

  @override
  String get gentleSentence =>
      'Спокійний звук тихо починається до будильника, тож ви ніколи не прокидаєтеся різко.';

  @override
  String get gentleExplain =>
      'Він повільно наростає, виводить із легкого сну й затихає перед самим будильником.';

  @override
  String get startsBeforeHeading => 'ПОЧИНАЄТЬСЯ ДО БУДИЛЬНИКА';

  @override
  String get leadUpSoundHeading => 'ВСТУПНИЙ ЗВУК';

  @override
  String get listen => 'Послухати';

  @override
  String get whoRecordedThese => 'Хто записав ці звуки';

  @override
  String get done => 'Готово';

  @override
  String get soundCredits => 'Автори звуків';

  @override
  String yourTimeCity(String city) {
    return 'Ваш час ($city)';
  }

  @override
  String get anotherCity => 'Інше місто…';

  @override
  String get ringingIn5 => 'Задзвонить за 5 секунд…';

  @override
  String get alarmSaved => 'Будильник збережено.';

  @override
  String alarmSetFor(String span) {
    return 'Будильник задзвонить через $span.';
  }

  @override
  String hoursMinutesShort(int h, int m) {
    return '$h год $m хв';
  }

  @override
  String get editAlarm => 'Змінити будильник';

  @override
  String get previewCaps => 'ПРОСЛУХАТИ';

  @override
  String get saveCaps => 'ЗБЕРЕГТИ';

  @override
  String cityTimeForYou(String city, String time) {
    return 'час $city · у вас $time';
  }

  @override
  String repeatHeading(String repeat) {
    return 'ПОВТОР · $repeat';
  }

  @override
  String get labelField => 'Мітка (читається вголос, якщо увімкнено голосові будильники)';

  @override
  String get group => 'Група';

  @override
  String ringsForHeading(String span) {
    return 'ДЗВОНИТЬ $span';
  }

  @override
  String useDefault(String value) {
    return 'За замовчуванням ($value)';
  }

  @override
  String get save => 'Зберегти';

  @override
  String get sameTime => 'той самий час';

  @override
  String get untilYouStopIt => 'Доки не зупините';

  @override
  String get alarm => 'Будильник';

  @override
  String get once => 'Один раз';

  @override
  String get everyDay => 'Щодня';

  @override
  String get weekdays => 'Будні';

  @override
  String get weekends => 'Вихідні';

  @override
  String timeInCity(String time, String city) {
    return '$time за часом $city';
  }

  @override
  String eventsMatching(String words) {
    return 'Події з «$words»';
  }

  @override
  String get everyEvent => 'Кожна подія';

  @override
  String get sunrise => 'Схід сонця';

  @override
  String havdalahEndOf(String day) {
    return 'Авдала · кінець: $day';
  }

  @override
  String get yomTov => 'Йом-тов';

  @override
  String get shabbat => 'Шабат';

  @override
  String get presetCountdown => 'Відлік до запалювання свічок';

  @override
  String get presetHourly => 'Щогодини, починаючи за 6 годин';

  @override
  String get presetDailyWeek => 'Раз на день, за тиждень до';

  @override
  String get presetSecondNight => 'Свічки другого вечора';

  @override
  String get presetFridayReminder => 'Нагадування за 3 години: зарядіть телефон';

  @override
  String get presetFridayReminderLabel => 'Зарядіть телефон і поставте будильники на завтра';

  @override
  String get presetSunset => 'Захід сонця і за 15 хвилин до нього';

  @override
  String get pesach => 'Песах';

  @override
  String get shavuot => 'Шавуот';

  @override
  String get roshHashanah => 'Рош га-Шана';

  @override
  String get yomKippur => 'Йом-Кіпур';

  @override
  String get sukkot => 'Суккот';

  @override
  String get sheminiAtzeret => 'Шміні Ацерет';

  @override
  String get simchatTorah => 'Сімхат Тора';

  @override
  String get readyNotifications => 'Показувати будильники';

  @override
  String get readyNotificationsWhy => 'Дозволяє показати екран будильника й кнопку «Стоп».';

  @override
  String get readyFullScreen => 'Дзвонити поверх екрана блокування';

  @override
  String get readyFullScreenWhy => 'Показує будильник на весь екран, навіть якщо телефон заблоковано.';

  @override
  String get readyExact => 'Дзвонити точно в хвилину';

  @override
  String get readyExactWhy => 'Без цього телефон може затримувати будильники на кілька хвилин.';

  @override
  String get readyBattery => 'Працювати в режимі економії батареї';

  @override
  String get readyBatteryWhy => 'Не дає економії батареї заглушити будильники вночі.';

  @override
  String get tipXiaomi =>
      'Телефони Xiaomi: у Налаштування › Застосунки › Quando? увімкніть Автозапуск і виберіть для економії батареї «Без обмежень».';

  @override
  String get tipSamsung =>
      'Телефони Samsung: у Налаштування › Батарея › Обмеження фонового використання перевірте, що Quando? не в режимі сну.';

  @override
  String get tipHuawei =>
      'Телефони Huawei та Honor: у Налаштування › Батарея › Запуск застосунків переведіть Quando? на ручне керування й дозвольте все.';

  @override
  String get tipOther =>
      'На цьому телефоні: у Налаштування › Батарея дозвольте Quando? працювати у фоні й вимкніть оптимізацію.';

  @override
  String get testRing => 'Тестовий дзвінок';

  @override
  String get testRingBody => 'Quando? може вас розбудити';

  @override
  String get ringsIn20 => 'Задзвонить за 20 секунд. Заблокуйте телефон і зачекайте.';

  @override
  String get readyToRing => 'Готовність до дзвінка';

  @override
  String get checkingPhone => 'Перевіряємо телефон…';

  @override
  String get phoneReady => 'Телефон готовий дзвонити кожним будильником вчасно.';

  @override
  String thingsNeedFixing(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'Треба виправити $n пункту, інакше будильники можуть не задзвонити.',
      many: 'Треба виправити $n пунктів, інакше будильники можуть не задзвонити.',
      few: 'Треба виправити $n пункти, інакше будильники можуть не задзвонити.',
      one: 'Треба виправити $n пункт, інакше будильники можуть не задзвонити.',
    );
    return '$_temp0';
  }

  @override
  String get fix => 'Виправити';

  @override
  String get testIn20 => 'Тест: дзвінок за 20 секунд';

  @override
  String get testIn20Hint =>
      'Заблокуйте телефон і відкладіть. Якщо будильник задзвонить на весь екран, усе готово.';

  @override
  String get readyToRingHint => 'Перевірте, що телефон дзвонить кожним будильником вчасно';

  @override
  String get connections => 'Підключення';

  @override
  String get timeZoneHeading => 'ЧАСОВИЙ ПОЯС';

  @override
  String get followPhone => 'Як на телефоні';

  @override
  String followPhoneNow(String city) {
    return 'Зараз $city. Змінюється сам у подорожах.';
  }

  @override
  String get zoneFixed => 'Фіксований. Будильники тримають цей час і в подорожах.';

  @override
  String get shabbatCityHeading => 'МІСТО ДЛЯ ШАБАТУ';

  @override
  String get inIsraelOneDay => 'В Ізраїлі (один день свята)';

  @override
  String candleMinutesHeading(int n) {
    return 'СВІЧКИ: ЗА $n ХВИЛИН ДО ЗАХОДУ';
  }

  @override
  String get endOfShabbatHeading => 'КІНЕЦЬ ШАБАТУ Й СВЯТ';

  @override
  String get nightfallGeonim => 'Поява зірок (Гаонім, 8,5°)';

  @override
  String get rabbeinuTam => '72 хвилини після заходу (Рабейну Там)';

  @override
  String get whenAlarmRingsHeading => 'КОЛИ ДЗВОНИТЬ БУДИЛЬНИК';

  @override
  String get recordOrAddSounds => 'Записати чи додати звуки';

  @override
  String get ringsForThisLong => 'Дзвонить стільки, потім сам зупиняється';

  @override
  String get sameFades => 'Однакові затухання для всіх будильників';

  @override
  String get sameFadesOn => 'Замінює затухання кожного будильника. Гучність у кожного своя.';

  @override
  String get sameFadesOff => 'Вимк.: кожен будильник використовує затухання зі своєї «Гучності».';

  @override
  String get sayItOutLoud => 'Промовляти вголос';

  @override
  String get sayItOutLoudHint => 'Читає, для чого будильник, напр. «Запалювання свічок, за 15 хвилин»';

  @override
  String get noSnooze => 'Без повтору';

  @override
  String snoozeUpTo(int times, int minutes) {
    return 'Повтор до $times× по $minutes хв';
  }

  @override
  String get wakeUpCheck => 'Перевірка пробудження';

  @override
  String get wakeUpCheckHint => 'Після зупинки знову дзвонить за 3 хвилини, якщо не натиснути «Я встав»';

  @override
  String get solveSum => 'Розв’яжіть приклад, щоб зупинити';

  @override
  String get provesAwake => 'Доводить, що ви прокинулися';

  @override
  String get shabbatNoTasks =>
      'У шабат і свята нічого з цього не діє: будильники зупиняються самі й ніколи не просять торкатися телефона.';

  @override
  String get testAlarmIn1 => 'Тестовий будильник за 1 хвилину';

  @override
  String get timesDisclaimer =>
      'Час обчислюється на телефоні. У спірних випадках запитайте рабина чи звіртеся з календарем громади.';

  @override
  String get recommended => 'Рекомендовано';

  @override
  String get chooseCity => 'Виберіть місто';

  @override
  String get testOnlyOnPhone => 'Тестові будильники працюють лише на телефоні.';

  @override
  String get testAlarm => 'Тестовий будильник';

  @override
  String get testAlarmBody => 'Так звучатимуть ваші будильники';

  @override
  String get testAlarmIn1Set => 'Тестовий будильник за 1 хвилину. Можна заблокувати телефон.';

  @override
  String get presetGone => 'Цього шаблону більше немає.';

  @override
  String get editPreset => 'Змінити шаблон';

  @override
  String get on => 'Увімк.';

  @override
  String get ringsHeading => 'ДЗВОНИТЬ';

  @override
  String get noTimesYet => 'Поки немає часу. Додайте нижче.';

  @override
  String get atTheMomentItself => 'Точно в момент події';

  @override
  String get remove => 'Видалити';

  @override
  String get addATime => 'Додати час';

  @override
  String get resetPreset => 'Повернути початковий';

  @override
  String get skipOneHint =>
      'Щоб пропустити один будильник, торкніться його в «Будильники цього тижня» на головному екрані.';

  @override
  String get unitMinutes => 'хвилини';

  @override
  String get unitHours => 'години';

  @override
  String get unitDays => 'дні';

  @override
  String get before => 'До';

  @override
  String get after => 'Після';

  @override
  String get oneWeek => '1 тиждень';

  @override
  String daysShort(int n) {
    return '$n д';
  }

  @override
  String hoursShort(int n) {
    return '$n год';
  }

  @override
  String get howToSearch => 'Як шукати';

  @override
  String get searchHelpWord => 'У назві є «dentist», регістр не важливий';

  @override
  String get searchHelpStar => '* — будь-які літери: dentist, dentures';

  @override
  String get searchHelpQuestion => '? — одна літера: yoga, toga';

  @override
  String get searchHelpPhrase => 'Саме ця фраза';

  @override
  String get searchHelpAnd => 'Обидва слова (AND)';

  @override
  String get searchHelpOr => 'Будь-яке з них. Також працює |';

  @override
  String get searchHelpNot => 'Виключити. Також працюють NOT і !';

  @override
  String get searchHelpBrackets => 'Дужки групують слова';

  @override
  String get searchHelpEmpty => 'Залиште порожнім, щоб дзвонити на кожну подію.';

  @override
  String get customTime => 'Інший час';

  @override
  String get other => 'Інше';

  @override
  String get sun => 'Сонце';

  @override
  String get calendar => 'Календар';

  @override
  String get newEventAlarm => 'Новий будильник події';

  @override
  String get eventAlarm => 'Будильник події';

  @override
  String get findEventsHeading => 'ЗНАЙТИ ПОДІЇ';

  @override
  String get searchEventsHint => 'Пошук: стоматолог, спортзал OR йога, стом*…';

  @override
  String get alsoBuiltInTimes => 'Також час шабату, свят і сонця';

  @override
  String get alsoBuiltInTimesHint => 'напр. «свіч*», «авдала», «захід»';

  @override
  String get allMyCalendars => 'Усі мої календарі';

  @override
  String get connectToSearch => 'Підключіть календарі, щоб шукати в них';

  @override
  String get searching => 'Пошук…';

  @override
  String get nothingMatches60 => 'Нічого не знайдено за 60 днів';

  @override
  String eventsIn60(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n події за 60 днів',
      many: '$n подій за 60 днів',
      few: '$n події за 60 днів',
      one: '$n подія за 60 днів',
    );
    return '$_temp0';
  }

  @override
  String nextRingsAt(String times, String title) {
    return 'Далі: дзвонить о $times для «$title»';
  }

  @override
  String showMoreLeft(int n) {
    return 'Показати ще (залишилося $n)';
  }

  @override
  String get ringBeforeStartsHeading => 'ДЗВОНИТИ ДО ПОЧАТКУ';

  @override
  String get ringWhenStarts => 'Дзвонити на початку';

  @override
  String get repeatBeforeHeading => 'І ПОВТОРЮВАТИ ДО';

  @override
  String get everyPrefix => 'Кожні ';

  @override
  String get offLower => 'вимк.';

  @override
  String get forInfix => '  протягом ';

  @override
  String get ringAfterEndsHeading => 'ДЗВОНИТИ ПІСЛЯ ЗАВЕРШЕННЯ';

  @override
  String get nameOptional => 'Назва (необов’язково)';

  @override
  String get toppedUp =>
      'Будильники задано на 7 днів наперед і поповнюються щоразу, коли ви відкриваєте Quando?.';

  @override
  String get back => 'Назад';

  @override
  String get next => 'Далі';

  @override
  String get stepWhichEvents => 'Які події';

  @override
  String get stepWhenToRing => 'Коли дзвонити';

  @override
  String get stepHowItRings => 'Як дзвонить';

  @override
  String defaultNamed(String name) {
    return 'За замовчуванням ($name)';
  }

  @override
  String get phoneAlarmSound => 'Звук будильника телефона';

  @override
  String get onlineRadio => 'Інтернет-радіо';

  @override
  String songLinkOpens(String app) {
    return 'Посилання на трек · відкриє $app';
  }

  @override
  String get builtIn => 'Вбудований';

  @override
  String get yourRecording => 'Ваш запис';

  @override
  String get sound => 'Звук';

  @override
  String get wakeToOwnSound => 'Прокидайтеся під свій звук';

  @override
  String get wakeToOwnSoundHint => 'Ваш голос, пісня, Spotify чи радіо наживо';

  @override
  String musicAdded(String name) {
    return '$name додано. Виберіть його звуком будь-якого будильника.';
  }

  @override
  String get playlists => 'Плейлисти';

  @override
  String get likedSongs => 'Улюблені треки';

  @override
  String get noPlaylists => 'Плейлистів поки немає.';

  @override
  String get noLikedSongs => 'Улюблених треків поки немає.';

  @override
  String get needsMic => 'Quando? потрібен мікрофон для запису.';

  @override
  String recordingN(int n) {
    return 'Запис $n';
  }

  @override
  String couldNotAddFile(String error) {
    return 'Не вдалося додати файл: $error';
  }

  @override
  String get addSongLink => 'Додати посилання на трек';

  @override
  String get songLink => 'Посилання на трек';

  @override
  String get songLinkHowTo =>
      'У Spotify, Apple Music, YouTube, YouTube Music чи SoundCloud натисніть «Поділитися», потім «Копіювати посилання» й вставте його сюди.';

  @override
  String get songNameHint => 'Назва, напр. Ранковий плейлист';

  @override
  String get whenAlarmGoesOffHeading => 'КОЛИ ДЗВОНИТЬ БУДИЛЬНИК';

  @override
  String get playTheSong => 'Увімкнути трек';

  @override
  String get ringThenOpen => 'Задзвонити, потім відкрити';

  @override
  String get playTheSongHint =>
      'Відкриється його застосунок і ввімкне трек. Якщо 10 секунд тиша, задзвонить запасний звук, тож ви точно прокинетеся. Будильники із завданням спершу дзвонять, потім відкривають трек.';

  @override
  String get ringThenOpenHint => 'Дзвонить запасний звук. «Стоп» відкриває трек у його застосунку.';

  @override
  String get playForHeading => 'ГРАТИ';

  @override
  String get pausesAfter => 'Quando? ставить трек на паузу після цього часу кнопкою паузи телефона.';

  @override
  String get backupSoundHeading => 'ЗАПАСНИЙ ЗВУК';

  @override
  String get notALink => 'Це не схоже на посилання.';

  @override
  String songOn(String app) {
    return 'Трек у $app';
  }

  @override
  String get theWeb => 'інтернеті';

  @override
  String get pickFromYouTube => 'Вибрати з мого YouTube';

  @override
  String get youTubeAndMusic => 'YouTube і YouTube Music';

  @override
  String get youTubeOn => 'Підключено · утримуйте, щоб вийти';

  @override
  String get youTubeSignIn => 'Увійти через Google';

  @override
  String get addSongLinkInstead => 'Натомість додайте посилання на трек.';

  @override
  String get googleSignInFailed => 'Вхід у Google не завершено. Спробуйте ще раз.';

  @override
  String get myYouTube => 'Мій YouTube';

  @override
  String get spotifyDirectOn => 'Пряме відтворення Spotify увімкнено';

  @override
  String get spotifyDirect => 'Пряме відтворення Spotify';

  @override
  String get spotifyDirectOnHint => 'Увімк. · торкніться, щоб вимкнути';

  @override
  String get spotifyDirectHint => 'Грає саме цю пісню. Потрібен Premium.';

  @override
  String get spotifyComingSoon => 'Незабаром · потрібен Premium';

  @override
  String get spotifyFailed =>
      'Spotify не підключився. Перевірте, що застосунок Spotify встановлено, ви ввійшли й маєте Premium.';

  @override
  String get nameThisSound => 'Назвіть цей звук';

  @override
  String get sounds => 'Звуки';

  @override
  String get soundsSentence => 'Прокидайтеся під свій голос, пісню, плейлист чи радіо.';

  @override
  String stopTimer(String time) {
    return 'Стоп · $time';
  }

  @override
  String get record => 'Записати';

  @override
  String get addAFile => 'Додати файл';

  @override
  String get addSongLinkLong => 'Додати посилання на трек (Spotify, Apple Music, YouTube…)';

  @override
  String get musicAppsHeading => 'МУЗИЧНІ ЗАСТОСУНКИ';

  @override
  String get pickFromSpotify => 'Вибрати з мого Spotify';

  @override
  String get yourPlaylistsAndLiked => 'Ваші плейлисти й улюблені треки';

  @override
  String get mySpotify => 'Мій Spotify';

  @override
  String get spotifySignInFailed => 'Не вдалося увійти в Spotify.';

  @override
  String get appleMusicNote => 'Вхід з’явиться у версії для iPhone. Поки що додайте посилання на трек.';

  @override
  String noSignInNote(String service) {
    return '$service не дозволяє вхід з інших застосунків. Натомість додайте посилання на трек.';
  }

  @override
  String get wakeToRadio => 'Прокидайтеся під інтернет-радіо';

  @override
  String get soundsExplain =>
      'Запишіть до 5 хвилин, додайте файл, посилання на пісню чи радіо. Якщо щось не спрацює, пролунає запасний звук.';

  @override
  String get yourSoundsHeading => 'ВАШІ ЗВУКИ';

  @override
  String playsIn(String app) {
    return 'Грає в $app';
  }

  @override
  String opensIn(String app) {
    return 'Відкривається в $app';
  }

  @override
  String forSpan(String span) {
    return 'протягом $span';
  }

  @override
  String get defaultLabel => 'За замовчуванням';

  @override
  String get radioUnreachable => 'Не вдалося завантажити список станцій. Перевірте з’єднання.';

  @override
  String get addStreamAddress => 'Додати адресу потоку';

  @override
  String get notAStream => 'Це не схоже на адресу потоку (починається з http).';

  @override
  String get anyGenre => 'Будь-який жанр';

  @override
  String get stationName => 'Назва станції';

  @override
  String get closeSearch => 'Закрити пошук';

  @override
  String get searchByName => 'Пошук за назвою';

  @override
  String get anywhere => 'Усюди';

  @override
  String get noStations => 'Станцій не знайдено. Спробуйте інший жанр чи країну.';

  @override
  String wakeUpTo(String name) {
    return 'Прокидайтеся під $name';
  }

  @override
  String get notQuite => 'Майже. Спробуйте ще.';

  @override
  String shabbatStopsItself(int n) {
    return 'Режим шабату: зупиниться сам за $n с. Торкатися телефона не треба.';
  }

  @override
  String get solveToSnooze => 'РОЗВ’ЯЖІТЬ, ЩОБ ВІДКЛАСТИ';

  @override
  String get solveToStop => 'РОЗВ’ЯЖІТЬ, ЩОБ ЗУПИНИТИ';

  @override
  String get answer => 'Відповідь';

  @override
  String get snooze => 'Відкласти';

  @override
  String get stop => 'Стоп';

  @override
  String get shakeToSnooze => 'ПОТРУСІТЬ, ЩОБ ВІДКЛАСТИ';

  @override
  String get shakeToStop => 'ПОТРУСІТЬ, ЩОБ ЗУПИНИТИ';

  @override
  String get shakeHard => 'Сильно трусіть телефон, доки смуга не заповниться.';

  @override
  String get cantShake => 'Не можете трусити? Розв’яжіть приклад';

  @override
  String get pairsToSnooze => 'ЗНАЙДІТЬ ПАРИ, ЩОБ ВІДКЛАСТИ';

  @override
  String get pairsToStop => 'ЗНАЙДІТЬ ПАРИ, ЩОБ ЗУПИНИТИ';

  @override
  String get typeToSnooze => 'НАДРУКУЙТЕ ЦЕ, ЩОБ ВІДКЛАСТИ';

  @override
  String get typeToStop => 'НАДРУКУЙТЕ ЦЕ, ЩОБ ЗУПИНИТИ';

  @override
  String get scanToSnooze => 'СКАНУЙТЕ КОД, ЩОБ ВІДКЛАСТИ';

  @override
  String get scanToStop => 'СКАНУЙТЕ КОД, ЩОБ ЗУПИНИТИ';

  @override
  String ringAgainUnless(int n) {
    return 'Задзвоню знову за $n хв, якщо не натиснете нижче.';
  }

  @override
  String get imUp => 'Я встав';

  @override
  String snoozeMin(int n) {
    return 'Відкласти на $n хв';
  }

  @override
  String snoozeMinLeft(int n, int left) {
    return 'Відкласти на $n хв · залишилося $left';
  }

  @override
  String get noSnoozesLeft => 'Повторів більше немає';

  @override
  String get stopThenOpen => 'Стоп · потім відкрити';

  @override
  String get startingSong => 'Запускаємо ваш трек';

  @override
  String wayToStop(String way) {
    return '$way, щоб зупинити';
  }

  @override
  String wayToSnooze(String way) {
    return '$way, щоб відкласти';
  }

  @override
  String ringsForMore(int n) {
    return 'Дзвонить ще $n с';
  }

  @override
  String get leftToRing => 'залишилося';

  @override
  String get wayVolumeButtons => 'Кнопки гучності';

  @override
  String get wayShake => 'Потрусити телефон';

  @override
  String get taskNothing => 'Нічого';

  @override
  String get taskSum => 'Розв’язати приклад';

  @override
  String get taskShake => 'Потрусити 30 разів';

  @override
  String get taskMemory => 'Гра на пам’ять';

  @override
  String get taskPhrase => 'Надрукувати фразу';

  @override
  String get taskScan => 'Сканувати код';

  @override
  String get noLimit => 'без обмежень';

  @override
  String upToTimes(int n) {
    return 'до $n×';
  }

  @override
  String shorterEachTime(int n) {
    return 'щоразу на $n хв коротше';
  }

  @override
  String autoSnoozeAfter(int n) {
    return 'відкладається сам за $n хв';
  }

  @override
  String get card => 'Карта';

  @override
  String get hiddenCard => 'Прихована карта';

  @override
  String get phrase1 => 'Я прокинувся і цей день мій';

  @override
  String get phrase2 => 'Якщо не зараз то коли';

  @override
  String get phrase3 => 'Доброго ранку мені й усім кого я люблю';

  @override
  String get phrase4 => 'Мої ноги на підлозі і я встав';

  @override
  String get phrase5 => 'Сьогодні я починаю знову';

  @override
  String get notQuiteWords => 'Майже, перевірте кожне слово.';

  @override
  String get typeItHere => 'Надрукуйте тут';

  @override
  String get differentCode => 'Це інший код.';

  @override
  String get cameraUnavailable => 'Камера недоступна.';

  @override
  String get cantScan => 'Не можете сканувати? Розв’яжіть приклад';

  @override
  String get saveCodeToScan => 'Збережіть код для сканування';

  @override
  String get saveCodeHint =>
      'Наведіть на штрих- чи QR-код там, куди треба дійти, наприклад коробку на кухні чи зубну пасту у ванній. Щоб зупинити будильник, відскануєте його знову.';

  @override
  String get cameraUnavailableSettings => 'Камера недоступна. Дозвольте доступ до камери в Налаштуваннях.';

  @override
  String gentleToGo(int n) {
    return 'М’яке пробудження · залишилося $n хв';
  }

  @override
  String previewBody(String body) {
    return 'Прослуховування · $body';
  }

  @override
  String snoozedBody(String body) {
    return 'Відкладено: $body';
  }

  @override
  String get areYouUp => 'Ви встали?';

  @override
  String get tapImUp => 'Натисніть «Я встав», щоб зупинити';

  @override
  String get volume => 'Гучність';

  @override
  String get wakeCheckOn => 'Перевірку пробудження увімкнено';

  @override
  String get stopsAtOnce => 'Одразу зупиняється';

  @override
  String get ringsAgainIfNotUp => 'Дзвонить знову, якщо ви не встали';

  @override
  String get openAppAfter => 'Потім відкрити застосунок';

  @override
  String get noTask => 'Без завдання';

  @override
  String get codeSaved => 'Код збережено';

  @override
  String get tapToSaveDifferent => 'Торкніться, щоб зберегти інший';

  @override
  String get controlsHeading => 'КЕРУВАННЯ';

  @override
  String get onScreen => 'На екрані';

  @override
  String get taskHeading => 'ЗАВДАННЯ';

  @override
  String get none => 'Немає';

  @override
  String get snoozeSentence => 'Ще п’ять хвилин? Виберіть, на скільки, скільки разів і що для цього треба.';

  @override
  String get settingsHeading => 'НАЛАШТУВАННЯ';

  @override
  String get snoozeTime => 'Час повтору';

  @override
  String get snoozeTimeHint => 'Тривалість першого повтору';

  @override
  String get shortenSnoozes => 'Скорочувати наступні повтори';

  @override
  String get shortenSnoozesHint => 'Кожен повтор після першого коротший на стільки';

  @override
  String get autoSnooze => 'Автоповтор';

  @override
  String get autoSnoozeHint => 'Якщо не торкатися, будильник сам відкладеться через';

  @override
  String get never => 'Ніколи';

  @override
  String get snoozeLimit => 'Ліміт повторів';

  @override
  String get snoozeLimitHint => 'Скільки разів можна відкласти';

  @override
  String get unlimited => 'Без обмежень';

  @override
  String get useSnoozeFromSettings => 'Повтор із Налаштувань';

  @override
  String get stopSentence => 'Як вимкнути будильник і що треба зробити спершу.';

  @override
  String get shabbatNoTask => 'У шабат і свята будильники зупиняються самі й ніколи не вимагають завдання.';

  @override
  String get volumeSentence => 'Наскільки гучно дзвонить і як плавно до цього доходить.';

  @override
  String get openAfterAlarm => 'Відкрити після будильника';

  @override
  String get pickAnApp => 'Виберіть застосунок';

  @override
  String get orPasteLink => 'Або вставте посилання: https://…';

  @override
  String get useThisLink => 'Використати це посилання';

  @override
  String get noAppsFound => 'Застосунків не знайдено.';

  @override
  String get weather => 'Погода';

  @override
  String get news => 'Новини';

  @override
  String get usePhoneVolume => 'Гучність будильника телефона';

  @override
  String get setsPhoneVolume => 'Задає гучність будильника телефона на час дзвінка, потім повертає її.';

  @override
  String get fadeInOff => 'Без наростання, одразу повна гучність';

  @override
  String fadeInOver(String span) {
    return 'Наростає за $span';
  }

  @override
  String get fadeOutOff => 'Без затухання';

  @override
  String fadeOutOver(String span) {
    return 'Затихає за останні $span';
  }

  @override
  String get fadesExplain =>
      'Затухання спрацьовує, коли будильник зупиняється сам. Якщо переходи довші за дзвінок, обидва скорочуються.';

  @override
  String get soundSoftChime => 'М’який дзвіночок';

  @override
  String get soundMorningRise => 'Ранковий підйом';

  @override
  String get soundClassicBeep => 'Класичний сигнал';

  @override
  String get calmCity => 'Тихий ранок у місті';

  @override
  String get calmBirds => 'Птахи на світанку';

  @override
  String get calmWaves => 'Хвилі на березі';

  @override
  String get calmRain => 'Тихий дощ';

  @override
  String get calmStream => 'Лісовий струмок';

  @override
  String get calmWind => 'Легкий вітер';

  @override
  String get calmFire => 'Потріскування вогню';

  @override
  String get calmNight => 'Літня ніч';

  @override
  String get publicDomain => 'Суспільне надбання';

  @override
  String get phoneVolume => 'Гучність телефона';

  @override
  String fadesIn(String span) {
    return 'наростає за $span';
  }

  @override
  String fadesOut(String span) {
    return 'затихає за $span';
  }

  @override
  String get noFade => 'без переходів';

  @override
  String minSecShort(int m, int s) {
    return '$m хв $s с';
  }

  @override
  String get happensRings => 'Дзвонить';

  @override
  String get happensStopped => 'Ви зупиняєте';

  @override
  String get happensSnoozed => 'Ви відкладаєте';

  @override
  String get happensAutoStopped => 'Зупиняється сам';

  @override
  String get eventLower => 'подія';

  @override
  String get appTest => 'Тест Quando?';

  @override
  String get pushoverConnected => 'Pushover підключено';

  @override
  String get webhookConnected => 'Вебхук підключено';

  @override
  String pushoverSaid(int code, String body) {
    return 'Pushover відповів $code: $body';
  }

  @override
  String couldNotReachPushover(String error) {
    return 'Не вдалося зв’язатися з Pushover ($error)';
  }

  @override
  String itAnswered(int code) {
    return 'Відповідь: $code';
  }

  @override
  String couldNotReachIt(String error) {
    return 'Не вдалося зв’язатися ($error)';
  }

  @override
  String get calendarNotAllowed => 'Доступ до календаря не дозволено.';

  @override
  String get playlist => 'Плейлист';

  @override
  String songCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n трека',
      many: '$n треків',
      few: '$n треки',
      one: '$n трек',
    );
    return '$_temp0';
  }

  @override
  String get spotifySaidNo =>
      'Spotify відмовив. У панелі Spotify позначте Web API для Quando? і додайте свій обліковий запис у User Management.';

  @override
  String serviceDidntAnswer(String service, int code) {
    return '$service не відповів ($code).';
  }

  @override
  String get youTubeSaidNo =>
      'YouTube відмовив. Перевірте, що ваш обліковий запис Google — тестовий користувач проєкту Quando.';

  @override
  String get event => 'Подія';

  @override
  String eventEnds(String title) {
    return '$title (кінець)';
  }

  @override
  String foundSoundsDevices(int s, int d) {
    return 'Знайдено звуків: $s, пристроїв: $d.';
  }

  @override
  String get sentCheckDevices => 'Надіслано. Перевірте інші пристрої.';

  @override
  String sentTo(String name) {
    return 'Надіслано на $name.';
  }

  @override
  String get zapierHowTo =>
      'У Zapier створіть Zap, що починається з «Webhooks by Zapier → Catch Hook», і вставте сюди його URL.';

  @override
  String get catchHookUrl => 'URL Catch Hook';

  @override
  String get iftttHowTo =>
      'В IFTTT створіть аплет, що починається з «Webhooks → Receive a web request with a JSON payload». Використайте тут ту саму назву події. Ваш ключ на ifttt.com/maker_webhooks/settings.';

  @override
  String get eventName => 'Назва події';

  @override
  String get webhooksKey => 'Ключ Webhooks';

  @override
  String get webhookHowTo => 'Quando? надсилає JSON POST на цю адресу.';

  @override
  String get connectionsSentence =>
      'Повідомляйте іншим застосункам і пристроям, коли будильник дзвонить, зупинений чи відкладений.';

  @override
  String get pushWhenRings => 'Надсилати сповіщення, коли дзвонить будильник';

  @override
  String get pushWhenRingsHint => 'На інші телефони, планшети, годинник чи комп’ютер';

  @override
  String get yourUserKey => 'Ваш ключ користувача';

  @override
  String get appToken => 'Токен застосунку';

  @override
  String get soundAndDevicesHeading => 'ЗВУК І ПРИСТРОЇ';

  @override
  String get loading => 'Завантаження…';

  @override
  String get loadFromPushover => 'Завантажити з Pushover';

  @override
  String get soundItPlays => 'Звук сповіщення';

  @override
  String get myPushoverDefault => 'Мій звук Pushover за замовчуванням';

  @override
  String get pushoverOwnSounds => 'Власні звуки з’являться тут після завантаження на pushover.net/sounds.';

  @override
  String get allMyDevices => 'Усі мої пристрої';

  @override
  String get pushoverOnThisPhone =>
      'Установіть Pushover і на цей телефон, і він дзвонитиме тут вашим звуком Pushover.';

  @override
  String get priority => 'Пріоритет';

  @override
  String get priorityNormal => 'Звичайний';

  @override
  String get priorityHigh => 'Високий: ігнорує тихі години';

  @override
  String get priorityEmergency => 'Екстрений: повторюється до підтвердження';

  @override
  String get sending => 'Надсилання…';

  @override
  String get sendATest => 'Надіслати тест';

  @override
  String get findUserKey => 'Знайти мій ключ користувача';

  @override
  String get makeAppToken => 'Створити токен застосунку';

  @override
  String get webhooksHeading => 'ZAPIER, IFTTT І ВЕБХУКИ';

  @override
  String get webhooksExplain =>
      'Запускайте що завгодно, коли будильник дзвонить або ви його зупиняєте: увімкнути світло, записати час підйому, написати комусь.';

  @override
  String get sendWhenAlarm => 'Надсилати, коли будильник:';

  @override
  String get pauseOnShabbat => 'Пауза в шабат і свята';

  @override
  String get pauseOnShabbatHint => 'Нічого не надсилається для будильників між запалюванням свічок і авдалою';

  @override
  String get webhookPayloadNote =>
      'Кожне повідомлення містить: event (ring, stopped, snoozed, auto_stopped), title, body, time, shabbat і snoozes. Ключі залишаються на цьому телефоні.';

  @override
  String get today => 'Сьогодні';

  @override
  String get tomorrow => 'Завтра';

  @override
  String get notAWebAddress => 'Це не схоже на адресу, що починається з https://';

  @override
  String get language => 'Мова';

  @override
  String get phoneLanguage => 'Мова телефона';

  @override
  String get ringQuote => 'Якщо не зараз, то коли?';

  @override
  String get ringQuoteBy => 'Гілель';

  @override
  String get quotesTitle => 'Цитати про час';

  @override
  String get quotesHint =>
      'Виберіть, звідки вони беруться. Одна на кожну частину дня; торкніться цитати, щоб побачити іншу.';

  @override
  String get quotesOff => 'Вимкнено';

  @override
  String get quoteSongs => 'Пісні';

  @override
  String get quoteMovies => 'Фільми';

  @override
  String get quoteLiterature => 'Книги й вірші';

  @override
  String get quoteTanakh => 'Танах (Єврейська Біблія)';

  @override
  String get quoteSages => 'Талмуд і мудреці';

  @override
  String get quoteSpeeches => 'Відомі промови';

  @override
  String get quotePhilosophy => 'Філософи';

  @override
  String get quoteProverbs => 'Прислів’я та приказки';

  @override
  String get quotesAlso => 'Також показувати';

  @override
  String get quoteCarnaval => 'Карнавал';

  @override
  String get quoteCarnavalHint => 'Пісні й приказки під час бразильського карнавалу';

  @override
  String get quoteNearMe => 'Поруч зі мною';

  @override
  String get quoteNearMeHint => 'Поети й дати вашого місця — за часовим поясом і містом для шабату';

  @override
  String get quoteSiddur => 'Сидур (молитовник)';

  @override
  String weeklyParasha(String name) {
    return 'Тижнева глава $name';
  }

  @override
  String poweredBy(String name) {
    return 'на основі $name';
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
  String get spotifyLibrarySignIn => 'Плейлисти, улюблені треки й пошук';

  @override
  String get spotifyLibraryOn => 'Підключено · утримуйте, щоб вийти';

  @override
  String spotifyLoginError(String reason) {
    return 'Не вдалося увійти в Spotify: $reason';
  }

  @override
  String googleSignInError(String reason) {
    return 'Не вдалося увійти в Google: $reason';
  }

  @override
  String get searchSongsHint => 'Шукати пісні, виконавців, плейлисти';

  @override
  String nothingFound(String query) {
    return 'За запитом «$query» нічого не знайдено.';
  }

  @override
  String get deliveryTitle => 'Сповіщення';

  @override
  String get deliveryLocal => 'Місцевий звук';

  @override
  String get deliveryBoth => 'Обидва';

  @override
  String get deliveryConnect => 'Підключити Pushover';

  @override
  String get deliveryLoadFailed => 'Не вдалося завантажити звуки та пристрої. Спробуйте ще раз.';

  @override
  String get deliveryBothHint => 'Місцевий звук лунає навіть у разі збою Pushover.';

  @override
  String get deliveryPushHint => 'Лише Pushover. У момент сигналу пристрій має бути в мережі.';

  @override
  String get deliveryFallback => 'Місцевий звук зберігається, якщо Pushover відключено або призупинено.';

  @override
  String get deliveryReset => 'Використати поточні налаштування';

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
  String get tuyaSignInTitle => 'Увійти з обліковим записом Smart Life';

  @override
  String get tuyaSignInHint =>
      'Використайте ту саму країну, пошту чи телефон і пароль, що й у застосунку Smart Life або Tuya Smart. Обліковий запис уже має бути прив’язаний до вашого проєкту Tuya. Пароль іде лише до Tuya і ніде не зберігається.';

  @override
  String get tuyaCountryCode => 'Телефонний код країни (Бразилія 55, США 1)';

  @override
  String get tuyaAccount => 'Пошта або телефон Smart Life';

  @override
  String get tuyaPassword => 'Пароль Smart Life';

  @override
  String get tuyaSignIn => 'Увійти й завантажити сценарії';

  @override
  String get tuyaRelayUrl => 'Адреса реле Tuya для Quando (https)';

  @override
  String get tuyaRelayHint =>
      'Використайте країну, пошту чи телефон і пароль облікового запису Smart Life або Tuya Smart. Вони один раз передаються реле Tuya для Quando і не зберігаються. Потрібно ввійти в обліковий запис Quando.';

  @override
  String get tuyaGoogleHint =>
      'Входите в Smart Life через Google або Apple? У Smart Life натисніть «Забули пароль», задайте пароль і використайте його тут.';

  @override
  String get tuyaLinked => 'Обліковий запис Smart Life прив’язано';

  @override
  String get tuyaUnlink => 'Відв’язати';

  @override
  String get tuyaNeedsAccount => 'Спершу увійдіть в обліковий запис Quando в налаштуваннях.';

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
      'Відтворення триває відповідно до тривалості дзвінка будильника й припиняється після зупинки або відкладання.';

  @override
  String get musicBackupPlaying => 'Не вдалося ввімкнути музику. Лунає локальний сигнал будильника.';

  @override
  String desktopMusicConnect(String service) {
    return 'Підключити застосунок $service';
  }

  @override
  String desktopMusicOn(String service) {
    return 'Підключено до $service · утримуйте, щоб від’єднати';
  }

  @override
  String get musicSongs => 'Пісні';

  @override
  String get noMusicSongs => 'У бібліотеці Музики пісень не знайдено.';

  @override
  String serviceConnectUnavailable(String service) {
    return 'Додайте посилання $service · відкриється після будильника';
  }

  @override
  String get soundCloudWidgetNote => 'Додайте публічне посилання';

  @override
  String get youtubePlayerHint =>
      'YouTube відтворює відео у видимому програвачі. Якщо його приховано або відтворення неможливе, локальний сигнал триває.';

  @override
  String get musicPreviewFailed =>
      'Не вдалося відтворити звук. Перевірте з’єднання або спробуйте інший трек чи станцію.';

  @override
  String get skyMoonPhase => 'Фаза Місяця';

  @override
  String get skyMoonDetailsDisplay => 'Додати сторінку фази Місяця';

  @override
  String get skyMoonDetailsHint => 'Перегорніть до неї або торкніться картки Місяця будь-коли';

  @override
  String get moonRises => 'Схід';

  @override
  String get moonSets => 'Захід';

  @override
  String moonLunarDay(int day) {
    return 'День $day з 29,5 у цьому місячному місяці';
  }

  @override
  String get moonDetailsOpen => 'Відкрити фазу Місяця';

  @override
  String get musicPlaylists => 'Музичні плейлисти';

  @override
  String get videoPlaylists => 'Плейлисти з відео';

  @override
  String get likedVideos => 'Улюблені відео';

  @override
  String get wholePlaylist => 'Прокидатися під увесь плейлист';

  @override
  String get noSongsInPlaylist => 'Тут немає треків, які можна відтворити.';

  @override
  String get hebrewNamesHeading => 'Написання тижневої глави та місяців';

  @override
  String get hebrewNamesIsraeli => 'Ізраїльське';

  @override
  String get hebrewNamesAshkenazi => 'Ашкеназьке';

  @override
  String pickFromService(String service) {
    return 'Вибрати з мого $service';
  }

  @override
  String get weatherTonight => 'Увечері';

  @override
  String get weatherTomorrowMorning => 'Завтра вранці';

  @override
  String weatherUntilAbout(String time) {
    return 'приблизно до $time';
  }

  @override
  String get weatherSunBehindClouds => 'Сонце за хмарами';

  @override
  String get keysLockTitle => 'Ключі на ваших пристроях';

  @override
  String get keysLockOff =>
      'Ключі сервісів залишаються на цьому пристрої. Виберіть фразу синхронізації, щоб надсилати їх зашифрованими на інші пристрої.';

  @override
  String get keysLockOn =>
      'Ключі сервісів шифруються вашою фразою синхронізації, перш ніж залишити цей пристрій. Ніхто інший, навіть Google, не може їх прочитати.';

  @override
  String get keysLockWaiting =>
      'Сюди надійшли ключі з іншого пристрою, вони замкнені. Введіть фразу синхронізації, щоб відкрити їх.';

  @override
  String get keysSetPassphrase => 'Вибрати фразу';

  @override
  String get keysChangePassphrase => 'Змінити фразу';

  @override
  String get keysUnlock => 'Відкрити ключі';

  @override
  String get keysStartOver => 'Забули? Почати знову';

  @override
  String get keysStartOverHint =>
      'Якщо почати знову, ключі цього пристрою надійдуть із новою фразою. Інші пристрої попросять нову.';

  @override
  String get keysPassphrase => 'Фраза синхронізації';

  @override
  String get keysPassphraseAgain => 'Введіть ще раз';

  @override
  String keysPassphraseShort(int count) {
    return 'Щонайменше $count символів.';
  }

  @override
  String get keysPassphraseMismatch => 'Фрази не збігаються.';

  @override
  String get keysPassphraseWrong => 'Ця фраза не відкриває ці ключі.';

  @override
  String get keysPassphraseNote =>
      'Запишіть її: якщо забудете, відновити її неможливо, і ключі доведеться ввести знову.';

  @override
  String get keysShareNeedsPassphrase =>
      'Спершу виберіть фразу синхронізації в розділі «Ключі на ваших пристроях».';

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
      'Quando? може дзвонити до і після подій у ваших календарях. Виберіть, звідки вони беруться.';

  @override
  String get deviceCalendarsHeading => 'НА ЦЬОМУ ПРИСТРОЇ';

  @override
  String get deviceCalendarsTitle => 'Календар цього пристрою';

  @override
  String get deviceCalendarsHint =>
      'Усі акаунти на ньому: Google, Samsung, Outlook, iCloud і календарі, що зберігаються лише тут.';

  @override
  String get googleCalendarHeading => 'GOOGLE КАЛЕНДАР';

  @override
  String get googleCalendarSignIn =>
      'Увійдіть через Google, щоб читати календарі прямо з Google, навіть якщо вашого акаунта Google немає на цьому пристрої.';

  @override
  String googleCalendarSignedIn(String email) {
    return 'Ви ввійшли як $email';
  }

  @override
  String get googleCalendarSignOut => 'Вийти';

  @override
  String get googleCalendarNotHere =>
      'Вхід через Google на цьому пристрої поки недоступний. Додайте акаунт Google у налаштуваннях пристрою (Календар › Облікові записи), і його календарі з\'являться тут.';

  @override
  String get googleCalendarUnreachable =>
      'Зараз не вдалося зв\'язатися з Google Календарем. Будильники, вже поставлені за ним, все одно задзвонять.';

  @override
  String get googleCalendarTwiceHint =>
      'Календарі того самого акаунта Google, які цей пристрій уже показує, спершу вимкнені, щоб ніщо не дзвонило двічі.';

  @override
  String get timersTitle => 'Таймери';

  @override
  String get timerStopwatch => 'Секундомір';

  @override
  String get timerCountdown => 'Таймер';

  @override
  String get timerSequence => 'Увага';

  @override
  String get timerStopwatchSub => 'Відлік уперед, з колами';

  @override
  String get timerCountdownSub => 'Зворотний відлік, дзвонить на нулі';

  @override
  String get timerSequenceSub => 'Голосовий старт і позначки';

  @override
  String get timerStart => 'Старт';

  @override
  String get timerPause => 'Пауза';

  @override
  String get timerResume => 'Продовжити';

  @override
  String get timerReset => 'Скинути';

  @override
  String get timerLap => 'Коло';

  @override
  String get timerTimesUp => 'Час вийшов';

  @override
  String get timerSetTime => 'Встановіть час';

  @override
  String get timerMinutes => 'Хвилини';

  @override
  String get timerSeconds => 'Секунди';

  @override
  String get seqOnYourMarks => 'На старт';

  @override
  String get seqGetSet => 'Увага';

  @override
  String get seqGo => 'Руш!';

  @override
  String get seqFinish => 'Час!';

  @override
  String get seqReady => 'Готово';

  @override
  String get seqSettings => 'Налаштування';

  @override
  String get seqStartCalls => 'Підказки перед стартом';

  @override
  String get seqStartCallsHelp => 'Вимовляються вголос перед «Руш», відлік назад від старту.';

  @override
  String seqCallBefore(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'За $n секунди',
      many: 'За $n секунд',
      few: 'За $n секунди',
      one: 'За 1 секунду',
    );
    return '$_temp0';
  }

  @override
  String get seqAddCall => 'Додати підказку';

  @override
  String get seqCallText => 'Що сказати';

  @override
  String get seqGoText => 'На старті сказати';

  @override
  String get seqFinishText => 'В кінці сказати';

  @override
  String get seqLength => 'Тривалість';

  @override
  String get seqNoLimit => 'Без обмеження';

  @override
  String get seqSayEvery => 'Називати час кожні';

  @override
  String get seqOff => 'Вимк.';

  @override
  String seqEverySeconds(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n секунди',
      many: '$n секунд',
      few: '$n секунди',
      one: '1 секунда',
    );
    return '$_temp0';
  }

  @override
  String seqEveryMinutes(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n хвилини',
      many: '$n хвилин',
      few: '$n хвилини',
      one: '1 хвилина',
    );
    return '$_temp0';
  }

  @override
  String get seqFinalCount => 'Відлічувати останні';

  @override
  String get seqMarks => 'Ваші позначки';

  @override
  String get seqAddMark => 'Додати позначку';

  @override
  String seqMarkAt(String time) {
    return 'О $time';
  }

  @override
  String get seqSpeak => 'Говорити вголос';

  @override
  String get seqBeeps => 'Сигнали та вібрація';

  @override
  String get seqSayRemaining => 'Називати час, що залишився, а не минулий';

  @override
  String get seqPresets => 'Шаблони';

  @override
  String get seqPresetRace => 'Старт перегонів';

  @override
  String get seqPresetSprint => 'Зусилля 30 с';

  @override
  String get seqPresetRound => 'Раунд 1 хв';

  @override
  String get seqHintNoLimit => 'Після «Руш» рахує вперед, доки ви не зупините.';

  @override
  String get seqHintLength => 'Після «Руш» рахує назад до нуля.';

  @override
  String get seqWords => 'Слова';

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
  String get homeClockSize => 'Годинник на головному екрані';

  @override
  String get sizeSmall => 'Малий';

  @override
  String get sizeMedium => 'Середній';

  @override
  String get sizeLarge => 'Великий';

  @override
  String get homeLayout => 'Вигляд головного екрана';

  @override
  String get homeLayoutClassic => 'Класичний';

  @override
  String get homeLayoutCards => 'Картки';

  @override
  String get homeCardsHint =>
      'Перетягніть картку, щоб перемістити. Потягніть за край або кут, щоб змінити розмір, або виберіть розмір.';

  @override
  String get homeAddCard => 'Додати картку';

  @override
  String get homeOnHome => 'На екрані';

  @override
  String get homeRemoveCard => 'Прибрати';

  @override
  String get cardNext => 'Наступний будильник';

  @override
  String get cardClock => 'Годинник і дата';

  @override
  String get cardSky => 'Сонце, місяць і погода';

  @override
  String get cardMoon => 'Місяць';

  @override
  String get cardWeather => 'Погода';

  @override
  String get cardAlarms => 'Ваші будильники';

  @override
  String get cardQuick => 'Швидкі будильники';

  @override
  String get cardTools => 'Секундомір, таймер і «увага»';

  @override
  String get cardWorld => 'Світовий час';

  @override
  String get cardWeek => 'Цей тиждень';

  @override
  String get cardShabbat => 'Шабат і свята';

  @override
  String get ringAtEventReminders => 'Дзвонити за нагадуваннями самої події';

  @override
  String get ringAtEventRemindersHint =>
      'Нагадування з вашого календаря дзвонять тут як гучні будильники, зі звуком цього будильника.';

  @override
  String get atEventReminders => 'за нагадуваннями події';

  @override
  String get everyEventReminderLoud => 'Гучно дзвонити за нагадуваннями кожної події';

  @override
  String get loudNotificationsHeading => 'ГУЧНІ СПОВІЩЕННЯ КАЛЕНДАРЯ';

  @override
  String get loudNotificationsTitle => 'Зробити сповіщення календаря гучними';

  @override
  String get loudNotificationsHint =>
      'Коли календар показує нагадування, Quando? дзвонить ним як будильником, навіть у беззвучному режимі.';

  @override
  String get loudNotificationsDisclosureTitle => 'Дозволити Quando? читати сповіщення календаря?';

  @override
  String get loudNotificationsDisclosure =>
      'Щоб гучно дзвонити нагадуваннями календаря, Quando? потрібен доступ до сповіщень. Він дивиться лише сповіщення вибраних вами календарів, читає їхній заголовок і текст на цьому телефоні, щоб показати на будильнику, і ніколи їх не зберігає й нікуди не надсилає. Це можна вимкнути будь-коли.';

  @override
  String get loudNotificationsAgree => 'Погодитися й продовжити';

  @override
  String get loudNotificationsNoAccess =>
      'Доступ до сповіщень вимкнено. Увімкніть Quando? у списку, що відкриється.';

  @override
  String get loudNotificationsAllow => 'Дозволити';

  @override
  String get loudNotificationsNoApps => 'На цьому телефоні немає підтримуваного календаря.';

  @override
  String get loudNotificationsTwiceNote => 'Події, які вже мають будильник Quando?, дзвонять лише раз.';

  @override
  String get loudNotificationsShabbatNote => 'Тихо в Шабат і свята.';

  @override
  String get busyMode => 'Режим «Зайнятий»';

  @override
  String get busyModeSubtitle => '«Не турбувати» й автовідповіді, поки ви зайняті';

  @override
  String get busyIntro =>
      'Поки ви зайняті, Quando? може приглушити телефон і відповідати на повідомлення за вас. Будильники й далі дзвонять.';

  @override
  String get busyIosFocus =>
      'На iPhone та iPad застосунки не можуть вмикати фокусування й відповідати на повідомлення. У застосунку «Швидкі команди» створіть автоматизацію «Коли відкривається Quando?» або за часом, яка вмикає фокусування, і налаштуйте в ньому автовідповідь.';

  @override
  String get busyWhileHeading => 'ПОКИ ВИ ЗАЙНЯТІ';

  @override
  String get busyDnd => 'Не турбувати';

  @override
  String get busyDndHint =>
      'Лише важливі: дзвінки й повідомлення беззвучні, будильники дзвонять. Потім усе як було.';

  @override
  String get busyDndNoAccess => 'Quando? поки не може змінювати «Не турбувати».';

  @override
  String get busyReplies => 'Відповідати на повідомлення';

  @override
  String get busyRepliesHint =>
      'Один раз кожному, вашим текстом, через кнопку «Відповісти» самого застосунку. Лише Android.';

  @override
  String get busyRepliesDisclosureTitle => 'Дозволити Quando? відповідати на повідомлення?';

  @override
  String get busyRepliesDisclosure =>
      'Щоб відповідати за вас, Quando? потрібен доступ до сповіщень. Лише поки ви зайняті, він дивиться сповіщення про повідомлення вибраних застосунків, читає ім\'я відправника на цьому телефоні й один раз надсилає ваш текст через кнопку «Відповісти» самого застосунку. Повідомлення ніколи не зберігаються й нікуди більше не надсилаються. Групи пропускаються, якщо ви їх не дозволите.';

  @override
  String get busyReplyText => 'Ваша відповідь';

  @override
  String busyReplyTextHint(String until) {
    return '$until заміниться часом завершення режиму.';
  }

  @override
  String busyReplyDefault(String until) {
    return 'Зараз зайнятий, відповім після $until.';
  }

  @override
  String get busyGroups => 'Відповідати й у групах';

  @override
  String get busyGroupsHint => 'Вимкнено: групам ніколи не відповідаємо.';

  @override
  String get busyRepliesOnShabbat => 'Відповідати в Шабат і свята';

  @override
  String get busyAskRabbi => 'Типово вимкнено. Запитайте свого рабина, перш ніж вмикати на Шабат.';

  @override
  String get busyWhenHeading => 'КОЛИ ВИ ЗАЙНЯТІ';

  @override
  String get busyWhenHint =>
      'Увімкніть «Зайнятий під час цих подій» у будильнику календаря або «Зайнятий після дзвінка» в будильнику.';

  @override
  String get busyDuringLock => 'Зайнятий, поки ввімкнено режим блокування';

  @override
  String get busyNoneComing => 'У найближчі 7 днів ви не зайняті.';

  @override
  String get busyDuringEvents => 'Зайнятий під час цих подій';

  @override
  String get busyDuringEventsHint => 'Режим «Зайнятий» від початку до кінця кожної події.';

  @override
  String get busySettings => 'Налаштування режиму «Зайнятий»';

  @override
  String get busyAfterRing => 'Зайнятий після дзвінка';

  @override
  String get busyAfterRingHint =>
      '«Не турбувати» й автовідповіді на певний час, наприклад тренування чи денний сон.';

  @override
  String get shareCard => 'Поділитися ранком';

  @override
  String get shareCardSubtitle => 'Сьогоднішнє небо й цитата або ваше фото для історій і статусу';

  @override
  String get shareAppMissing => 'Цього застосунку немає на телефоні.';

  @override
  String get shareAsIs => 'Поділитися як є';

  @override
  String get shareTapQuote => 'Торкніться цитати, щоб змінити.';

  @override
  String get shareStory => 'Історія';

  @override
  String get shareSquare => 'Квадрат';

  @override
  String get shareYourWords => 'Власні слова (необов\'язково)';

  @override
  String get shareYourWordsHint => 'Замість сьогоднішньої цитати';

  @override
  String get shareYourPhoto => 'Своє фото';

  @override
  String get shareOtherPhoto => 'Інше фото';

  @override
  String get shareSkyBack => 'Сьогоднішнє небо';

  @override
  String get shareYourVideo => 'Своє відео';

  @override
  String get shareInstagramStory => 'Історії Instagram';

  @override
  String get shareWhatsApp => 'WhatsApp: статус або чат';

  @override
  String get shareMore => 'Інші застосунки';

  @override
  String get shareYouPost =>
      'Quando? відкриває застосунок із готовою карткою. Ви самі обираєте, куди, і публікуєте.';

  @override
  String get shareAndroidFirst => 'Незабаром і на iPhone та iPad.';

  @override
  String songSaved(String name) {
    return '«$name» збережено як звук будильника';
  }

  @override
  String get shareToQuando => 'Поділіться піснею з Quando?';

  @override
  String get shareToQuandoHint =>
      'У YouTube, YouTube Music, Spotify, SoundCloud або Apple Music натисніть «Поділитися», потім Quando?. Це стане звуком будильника, що грає у своєму застосунку.';

  @override
  String get askOption => 'Скажіть або напишіть';

  @override
  String get askOptionHint => '«Завтра о 6», «за 30 хв до сходу сонця»';

  @override
  String get askHint => 'напр.: розбуди мене в будні за 30 хв до сходу сонця';

  @override
  String get askListening => 'Слухаю…';

  @override
  String get askNotUnderstood => 'Не знайшов час. Спробуйте «о 7 в будні» або «через 20 хвилин».';

  @override
  String askAnswerFromCalendar(String name) {
    return 'З вашого календаря «$name»';
  }

  @override
  String get askAnswerBuiltIn => 'Час Quando? для вашого міста';

  @override
  String get askNoAnswer => 'Поки час не знайдено.';

  @override
  String get askNoSpeech => 'Голос недоступний на цьому пристрої. Можна ввести текст.';

  @override
  String get askShabbatOff => 'Увімкніть Шабат у налаштуваннях, щоб дзвонили часи Шабату.';

  @override
  String askSaved(String what) {
    return 'Збережено: $what';
  }

  @override
  String get askMic => 'Говорити';

  @override
  String get askMorning => 'Ранок';

  @override
  String get askEvening => 'Вечір';

  @override
  String get askUnsure => 'Можливо, я щось пропустив. Перевірте перед збереженням.';

  @override
  String get askTeach => 'Навчи мене';

  @override
  String askTaught(String phrase, String time) {
    return 'Зрозумів: «$phrase» тепер означає $time.';
  }

  @override
  String get askSkipAction => 'Пропустити';

  @override
  String get askNoMatch => 'Немає відповідного будильника.';

  @override
  String askTurnedOff(String what) {
    return 'Вимкнено: $what';
  }

  @override
  String askSkipped(String what) {
    return 'Пропущено: $what';
  }

  @override
  String askEventPlan(String offset, String event) {
    return '$offset «$event» у вашому календарі';
  }

  @override
  String askEventNoCalendar(String event) {
    return 'Під’єднайте календар, щоб Quando? знайшов «$event».';
  }

  @override
  String askSnoozeAll(int minutes) {
    return 'Повтор: $minutes хв, для всіх будильників';
  }

  @override
  String askWakeWith(String sound) {
    return 'Будить вас: $sound';
  }

  @override
  String get askReadAs => 'Прочитано як';
}
