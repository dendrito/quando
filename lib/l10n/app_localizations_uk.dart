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
      'У Spotify, Apple Music, Amazon Music, YouTube, YouTube Music чи SoundCloud натисніть «Поділитися», потім «Копіювати посилання» й вставте його сюди.';

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
  String get youTubeOn => 'Ваші плейлисти й улюблені треки. Утримуйте, щоб вийти.';

  @override
  String get youTubeSignIn => 'Увійдіть через Google, щоб вибирати з плейлистів і улюблених треків.';

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
  String get spotifyDirectOnHint => 'Spotify грає саме ваш трек як будильник. Торкніться, щоб вимкнути.';

  @override
  String get spotifyDirectHint =>
      'Грає саме ваш трек Spotify як будильник, надійніше. Потрібні застосунок Spotify і Spotify Premium. Торкніться, щоб увійти.';

  @override
  String get spotifyComingSoon => 'Незабаром: ваш трек Spotify як будильник (потрібен Spotify Premium).';

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
      'Запишіть свій голос, пісню чи будь-що, до 5 хвилин. Додайте MP3, M4A чи WAV з телефона. Дайте посилання на трек чи плейлист: його застосунок зіграє його як будильник, із запасним звуком. Або виберіть радіостанцію: вона грає наживо, а якщо не підключиться, дзвонить будильник телефона.';

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
}
