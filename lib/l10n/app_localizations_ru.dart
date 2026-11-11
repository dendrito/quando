// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get undo => 'Отменить';

  @override
  String duplicatedNamed(String name) {
    return '«$name» скопирован';
  }

  @override
  String deletedNamed(String name) {
    return '«$name» удалён';
  }

  @override
  String get when => 'Когда?';

  @override
  String get newAtTime => 'В определённое время';

  @override
  String get newAtTimeHint => 'По будням в 7:00, один раз в 15:30…';

  @override
  String get newAroundEvent => 'Вокруг события';

  @override
  String get newAroundEventHint =>
      'Ищите в календарях, времени шаббата и солнца и звоните до, во время или после';

  @override
  String get editThisAlarm => 'Изменить этот будильник';

  @override
  String editNamed(String name) {
    return 'Изменить «$name»';
  }

  @override
  String get preset => 'шаблон';

  @override
  String get editThisCalendarRule => 'Изменить это правило календаря';

  @override
  String get ringThisOneAfterAll => 'Всё-таки позвонить';

  @override
  String get skipJustThisOne => 'Пропустить только этот';

  @override
  String get renameGroup => 'Переименовать группу';

  @override
  String quickSet(String label, String time) {
    return '$label · зазвонит в $time';
  }

  @override
  String get newAlarm => 'Новый будильник';

  @override
  String get appName => 'Quando?';

  @override
  String get lockMode => 'Режим блокировки';

  @override
  String get calendars => 'Календари';

  @override
  String get settings => 'Настройки';

  @override
  String get nextAlarmHeading => 'СЛЕДУЮЩИЙ БУДИЛЬНИК';

  @override
  String get nothingSet => 'Ничего не задано';

  @override
  String get tagline => 'Всему своё время.';

  @override
  String sunriseAt(String time) {
    return 'Восход $time';
  }

  @override
  String sunsetAt(String time) {
    return 'Закат $time';
  }

  @override
  String get alarmsMayNotRing => 'Будильники могут не зазвонить';

  @override
  String get tapToFixIt => 'Нажмите, чтобы исправить';

  @override
  String inMinutes(int minutes) {
    return 'Через $minutes мин';
  }

  @override
  String get atSunset => 'На закате';

  @override
  String get sunset => 'Закат';

  @override
  String get shabbatModeIsOn => 'РЕЖИМ ШАББАТА ВКЛЮЧЁН';

  @override
  String nextInCity(String city) {
    return 'ДАЛЕЕ · $city';
  }

  @override
  String get candleLighting => 'Зажигание свечей';

  @override
  String get havdalah => 'Авдала';

  @override
  String get shabbatAndFestivals => 'Шаббат и праздники';

  @override
  String get yourAlarmsHeading => 'ВАШИ БУДИЛЬНИКИ';

  @override
  String get tapWhenToAdd => 'Нажмите «Когда?», чтобы добавить будильник.';

  @override
  String get aroundEventsHeading => 'ВОКРУГ СОБЫТИЙ';

  @override
  String searchFor(String words) {
    return 'поиск: $words';
  }

  @override
  String get thisWeekHeading => 'БУДИЛЬНИКИ НА ЭТОЙ НЕДЕЛЕ';

  @override
  String get noAlarmsThisWeek => 'Нет будильников в ближайшие 7 дней.';

  @override
  String get alarmsSetThemselves => 'Будильники сами настраиваются на этом телефоне при каждом изменении.';

  @override
  String cityTime(String city) {
    return 'время $city';
  }

  @override
  String get more => 'Ещё';

  @override
  String get turnOff => 'Выключить';

  @override
  String get turnOn => 'Включить';

  @override
  String get duplicate => 'Копировать';

  @override
  String get delete => 'Удалить';

  @override
  String get inOneHour => 'Через 1 час';

  @override
  String get logoLabel => 'Логотип Quando?';

  @override
  String get noTimesSet => 'Время не задано';

  @override
  String get atTheMoment => 'в момент события';

  @override
  String timesRange(int count, String from, String to) {
    return '$count раз · с $from до $to';
  }

  @override
  String spanDays(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n дня',
      many: '$n дней',
      few: '$n дня',
      one: '$n день',
    );
    return '$_temp0';
  }

  @override
  String spanHours(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n часа',
      many: '$n часов',
      few: '$n часа',
      one: '$n час',
    );
    return '$_temp0';
  }

  @override
  String spanMinutes(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n минуты',
      many: '$n минут',
      few: '$n минуты',
      one: '$n минута',
    );
    return '$_temp0';
  }

  @override
  String spanSeconds(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n секунды',
      many: '$n секунд',
      few: '$n секунды',
      one: '$n секунда',
    );
    return '$_temp0';
  }

  @override
  String get now => 'сейчас';

  @override
  String spanBefore(String span) {
    return 'за $span до';
  }

  @override
  String spanAfter(String span) {
    return 'через $span после';
  }

  @override
  String alarmCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n будильника',
      many: '$n будильников',
      few: '$n будильника',
      one: '$n будильник',
    );
    return '$_temp0';
  }

  @override
  String get allOn => 'все включены';

  @override
  String get allOff => 'все выключены';

  @override
  String someOn(int n) {
    return 'включено: $n';
  }

  @override
  String skippedBody(String body) {
    return 'Пропущен · $body';
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
  String get sunNoRiseSet => 'Сегодня здесь солнце не восходит и не заходит';

  @override
  String sunProgress(int percent) {
    return 'Солнце прошло $percent% дня';
  }

  @override
  String get sunIsDown => 'Солнце зашло';

  @override
  String get searchCity => 'Найти город';

  @override
  String get tomorrowLower => 'завтра';

  @override
  String get yesterdayLower => 'вчера';

  @override
  String get worldClocksHeading => 'МИРОВЫЕ ЧАСЫ';

  @override
  String get add => 'Добавить';

  @override
  String cityHere(String city) {
    return '$city · здесь';
  }

  @override
  String get worldClocksHint =>
      'Добавьте города, чтобы видеть здесь их время. Смахните влево, чтобы удалить.';

  @override
  String get groupNameHint => 'Работа, Дети, Спортзал…';

  @override
  String get cancel => 'Отмена';

  @override
  String get ok => 'ОК';

  @override
  String get noGroup => 'Без группы';

  @override
  String get newGroupEllipsis => 'Новая группа…';

  @override
  String get newGroup => 'Новая группа';

  @override
  String secondsShort(int n) {
    return '$n с';
  }

  @override
  String minutesShort(int n) {
    return '$n мин';
  }

  @override
  String get minutes => 'Минуты';

  @override
  String get ringFor => 'Звонить';

  @override
  String get seconds => 'Секунды';

  @override
  String get oneSecondLess => 'На 1 секунду меньше';

  @override
  String get oneSecondMore => 'На 1 секунду больше';

  @override
  String inDays(int d) {
    return 'через $d д';
  }

  @override
  String inDaysHours(int d, int h) {
    return 'через $d д $h ч';
  }

  @override
  String inHours(int h) {
    return 'через $h ч';
  }

  @override
  String inHoursMinutes(int h, int m) {
    return 'через $h ч $m мин';
  }

  @override
  String inMins(int m) {
    return 'через $m мин';
  }

  @override
  String placeChange(String city, String where) {
    return '$city · $where · изменить';
  }

  @override
  String get israel => 'Израиль';

  @override
  String get outsideIsrael => 'вне Израиля';

  @override
  String get comingUpHeading => 'СКОРО';

  @override
  String get lockForShabbat => 'Блокировать телефон на шаббат';

  @override
  String get lockForShabbatHint => 'От зажигания свечей до авдалы, и в праздники тоже';

  @override
  String get ownShabbatAlarmsHeading => 'ВАШИ БУДИЛЬНИКИ НА ШАББАТ';

  @override
  String get addShabbatAlarm => 'Добавить будильник на шаббат или праздник';

  @override
  String get readyMadeHeading => 'ГОТОВЫЕ БУДИЛЬНИКИ';

  @override
  String bringBackDeleted(int n) {
    return 'Вернуть удалённые ($n)';
  }

  @override
  String get presetsHint => 'Нажмите, чтобы изменить время. Смахните, чтобы удалить.';

  @override
  String get lockSentence =>
      'Оставьте на телефоне только часы и будильники — на шаббат или ночь без отвлечений.';

  @override
  String get lockExplain =>
      'Во время блокировки Quando? показывает только время, следующий будильник и конец блокировки. Будильники работают, а изменить ничего нельзя до разблокировки.';

  @override
  String get lockNowHeading => 'ЗАБЛОКИРОВАТЬ СЕЙЧАС';

  @override
  String get lockAutoHeading => 'БЛОКИРОВАТЬ АВТОМАТИЧЕСКИ';

  @override
  String get shabbatAndFestivalsLong => 'Шаббат и праздники';

  @override
  String get fromCandleToHavdalah => 'От зажигания свечей до авдалы';

  @override
  String get lockCalendarWord => 'Во время событий календаря с этим словом';

  @override
  String get lockCalendarWordHint => 'напр. блокировка, экзамен, фокус';

  @override
  String get leaveEmptyForNone => 'Оставьте пустым, чтобы отключить';

  @override
  String get connectCalendarsFirst => 'Сначала подключите календари (значок календаря)';

  @override
  String get openWhenLockStarts => 'Открывать Quando? при начале блокировки';

  @override
  String get openWhenLockStartsHint => 'Тихий звук на 1 секунду выводит Quando? на экран для блокировки';

  @override
  String get pinToScreen => 'Закрепить Quando? на экране';

  @override
  String get pinToScreenHint =>
      'Другие приложения не откроются во время блокировки. В первый раз Android попросит подтвердить.';

  @override
  String get noLocksComingUp => 'Блокировок не запланировано.';

  @override
  String get leaveLockEarly => 'Чтобы выйти раньше, удерживайте «Удерживайте для разблокировки» 3 секунды.';

  @override
  String get locked => 'Заблокировано';

  @override
  String get shabbatShalom => 'Шаббат шалом';

  @override
  String get chagSameach => 'Хаг самеах';

  @override
  String get unlocksHeading => 'РАЗБЛОКИРУЕТСЯ';

  @override
  String get nowCap => 'Сейчас';

  @override
  String get nextAlarm => 'Следующий будильник';

  @override
  String get holdToUnlock => 'Удерживайте для разблокировки';

  @override
  String get lockSentenceCalm =>
      'Заблокируйте телефон на часах и будильниках: на экзамен, встречу или тихий вечер.';

  @override
  String get lockCalendarHeading => 'ПО КАЛЕНДАРЮ';

  @override
  String get lockCalendarExplain =>
      'Блокировка во время события или от одного события до следующего, которое вы укажете. Работает с любым выбранным календарём, и с общими тоже.';

  @override
  String get lockAddCalendar => 'Добавить блокировку по календарю';

  @override
  String get lockEditCalendar => 'Блокировка по календарю';

  @override
  String get lockDuring => 'Во время события';

  @override
  String get lockBetween => 'Между двумя событиями';

  @override
  String get lockStartsAt => 'События с названием…';

  @override
  String get lockStartsAtBetween => 'Начинается с события…';

  @override
  String get lockEndsAt => 'Заканчивается на следующем событии…';

  @override
  String get lockStartHint => 'напр. экзамен, фокус, спорт';

  @override
  String get lockEndHint => 'напр. дома';

  @override
  String get lockAnyCalendar => 'Любой календарь';

  @override
  String get lockNoMatches => 'В календарях пока ничего не подходит.';

  @override
  String get lockNextTimes => 'СЛЕДУЮЩИЕ РАЗЫ';

  @override
  String lockDuringTitle(String a) {
    return 'Во время «$a»';
  }

  @override
  String lockBetweenTitle(String a, String b) {
    return 'От «$a» до следующего «$b»';
  }

  @override
  String lockShabbatCalendarFound(String name) {
    return 'В «$name» есть время шаббата.';
  }

  @override
  String get lockShabbatFromCalendar => 'Блокировать от зажигания свечей до авдалы';

  @override
  String get lockShabbatFromCalendarHint => 'Берёт время из этого календаря, со свечами на экране.';

  @override
  String get lockMoreWays => 'Другие способы блокировки';

  @override
  String get lockQuietTime => 'Время тишины';

  @override
  String nextCandleLightingFrom(String time, String name) {
    return 'Следующее зажигание свечей: $time, из $name';
  }

  @override
  String get calendarAlarm => 'Будильник календаря';

  @override
  String get connectCalendars => 'Подключить календари';

  @override
  String get calendarAlarmsHeading => 'БУДИЛЬНИКИ КАЛЕНДАРЯ';

  @override
  String get calendarNoneYet => 'Пока нет. Начните с этого и измените как угодно:';

  @override
  String get fifteenBeforeEvery => 'За 15 минут до каждого события';

  @override
  String get useTheseCalendarsHeading => 'ИСПОЛЬЗОВАТЬ ЭТИ КАЛЕНДАРИ';

  @override
  String get noTimedEvents => 'В этих календарях нет предстоящих событий со временем.';

  @override
  String get atTheStart => 'в начале';

  @override
  String everyForBefore(String every, String span) {
    return 'каждые $every в течение $span до';
  }

  @override
  String spanAfterItEnds(String span) {
    return 'через $span после окончания';
  }

  @override
  String get noAlarmsChosen => 'Будильники не выбраны';

  @override
  String get gentleWakeUp => 'Мягкое пробуждение';

  @override
  String gentleSummary(int minutes, String sound) {
    return 'за $minutes мин · $sound';
  }

  @override
  String get off => 'Выкл.';

  @override
  String get gentleSentence => 'Спокойный звук тихо начинается до будильника, чтобы вы не просыпались резко.';

  @override
  String get gentleExplain =>
      'Он медленно нарастает, выводит из лёгкого сна и затихает прямо перед будильником.';

  @override
  String get startsBeforeHeading => 'НАЧИНАЕТСЯ ДО БУДИЛЬНИКА';

  @override
  String get leadUpSoundHeading => 'ВСТУПИТЕЛЬНЫЙ ЗВУК';

  @override
  String get listen => 'Послушать';

  @override
  String get whoRecordedThese => 'Кто записал эти звуки';

  @override
  String get done => 'Готово';

  @override
  String get soundCredits => 'Авторы звуков';

  @override
  String yourTimeCity(String city) {
    return 'Ваше время ($city)';
  }

  @override
  String get anotherCity => 'Другой город…';

  @override
  String get ringingIn5 => 'Зазвонит через 5 секунд…';

  @override
  String get alarmSaved => 'Будильник сохранён.';

  @override
  String alarmSetFor(String span) {
    return 'Будильник зазвонит через $span.';
  }

  @override
  String hoursMinutesShort(int h, int m) {
    return '$h ч $m мин';
  }

  @override
  String get editAlarm => 'Изменить будильник';

  @override
  String get previewCaps => 'ПРОСЛУШАТЬ';

  @override
  String get saveCaps => 'СОХРАНИТЬ';

  @override
  String cityTimeForYou(String city, String time) {
    return 'время $city · у вас $time';
  }

  @override
  String repeatHeading(String repeat) {
    return 'ПОВТОР · $repeat';
  }

  @override
  String get labelField => 'Метка (читается вслух, если включены голосовые будильники)';

  @override
  String get group => 'Группа';

  @override
  String ringsForHeading(String span) {
    return 'ЗВОНИТ $span';
  }

  @override
  String useDefault(String value) {
    return 'По умолчанию ($value)';
  }

  @override
  String get save => 'Сохранить';

  @override
  String get sameTime => 'то же время';

  @override
  String get untilYouStopIt => 'Пока не остановите';

  @override
  String get alarm => 'Будильник';

  @override
  String get once => 'Один раз';

  @override
  String get everyDay => 'Каждый день';

  @override
  String get weekdays => 'Будни';

  @override
  String get weekends => 'Выходные';

  @override
  String timeInCity(String time, String city) {
    return '$time по времени $city';
  }

  @override
  String eventsMatching(String words) {
    return 'События с «$words»';
  }

  @override
  String get everyEvent => 'Каждое событие';

  @override
  String get sunrise => 'Восход';

  @override
  String havdalahEndOf(String day) {
    return 'Авдала · конец: $day';
  }

  @override
  String get yomTov => 'Йом-тов';

  @override
  String get shabbat => 'Шаббат';

  @override
  String get presetCountdown => 'Отсчёт до зажигания свечей';

  @override
  String get presetHourly => 'Каждый час, начиная за 6 часов';

  @override
  String get presetDailyWeek => 'Раз в день, за неделю до';

  @override
  String get presetSecondNight => 'Свечи второго вечера';

  @override
  String get presetFridayReminder => 'Напоминание за 3 часа: зарядите телефон';

  @override
  String get presetFridayReminderLabel => 'Зарядите телефон и поставьте будильники на завтра';

  @override
  String get presetSunset => 'Закат и за 15 минут до него';

  @override
  String get pesach => 'Песах';

  @override
  String get shavuot => 'Шавуот';

  @override
  String get roshHashanah => 'Рош ха-Шана';

  @override
  String get yomKippur => 'Йом-Кипур';

  @override
  String get sukkot => 'Суккот';

  @override
  String get sheminiAtzeret => 'Шмини Ацерет';

  @override
  String get simchatTorah => 'Симхат Тора';

  @override
  String get readyNotifications => 'Показывать будильники';

  @override
  String get readyNotificationsWhy => 'Позволяет показать экран будильника и кнопку «Стоп».';

  @override
  String get readyFullScreen => 'Звонить поверх экрана блокировки';

  @override
  String get readyFullScreenWhy => 'Показывает будильник на весь экран, даже если телефон заблокирован.';

  @override
  String get readyExact => 'Звонить точно в минуту';

  @override
  String get readyExactWhy => 'Без этого телефон может задерживать будильники на несколько минут.';

  @override
  String get readyBattery => 'Работать при экономии батареи';

  @override
  String get readyBatteryWhy => 'Не даёт экономии батареи заглушить будильники ночью.';

  @override
  String get tipXiaomi =>
      'Телефоны Xiaomi: в Настройки › Приложения › Quando? включите Автозапуск и выберите для экономии батареи «Нет ограничений».';

  @override
  String get tipSamsung =>
      'Телефоны Samsung: в Настройки › Батарея › Ограничения фонового использования проверьте, что Quando? не в спящем режиме.';

  @override
  String get tipHuawei =>
      'Телефоны Huawei и Honor: в Настройки › Батарея › Запуск приложений переключите Quando? на ручное управление и разрешите всё.';

  @override
  String get tipOther =>
      'На этом телефоне: в Настройки › Батарея разрешите Quando? работать в фоне и отключите оптимизацию.';

  @override
  String get testRing => 'Тестовый звонок';

  @override
  String get testRingBody => 'Quando? может вас разбудить';

  @override
  String get ringsIn20 => 'Зазвонит через 20 секунд. Заблокируйте телефон и подождите.';

  @override
  String get readyToRing => 'Готовность к звонку';

  @override
  String get checkingPhone => 'Проверяем телефон…';

  @override
  String get phoneReady => 'Телефон готов звонить каждым будильником вовремя.';

  @override
  String thingsNeedFixing(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'Нужно исправить $n пункта, иначе будильники могут не зазвонить.',
      many: 'Нужно исправить $n пунктов, иначе будильники могут не зазвонить.',
      few: 'Нужно исправить $n пункта, иначе будильники могут не зазвонить.',
      one: 'Нужно исправить $n пункт, иначе будильники могут не зазвонить.',
    );
    return '$_temp0';
  }

  @override
  String get fix => 'Исправить';

  @override
  String get testIn20 => 'Тест: звонок через 20 секунд';

  @override
  String get testIn20Hint =>
      'Заблокируйте телефон и отложите. Если будильник зазвонит на весь экран, всё готово.';

  @override
  String get readyToRingHint => 'Проверьте, что телефон звонит каждым будильником вовремя';

  @override
  String get connections => 'Подключения';

  @override
  String get timeZoneHeading => 'ЧАСОВОЙ ПОЯС';

  @override
  String get followPhone => 'Как на телефоне';

  @override
  String followPhoneNow(String city) {
    return 'Сейчас $city. Меняется сам в поездках.';
  }

  @override
  String get zoneFixed => 'Фиксированный. Будильники держат это время и в поездках.';

  @override
  String get shabbatCityHeading => 'ГОРОД ДЛЯ ШАББАТА';

  @override
  String get inIsraelOneDay => 'В Израиле (один день праздника)';

  @override
  String candleMinutesHeading(int n) {
    return 'СВЕЧИ: ЗА $n МИНУТ ДО ЗАКАТА';
  }

  @override
  String get endOfShabbatHeading => 'КОНЕЦ ШАББАТА И ПРАЗДНИКОВ';

  @override
  String get nightfallGeonim => 'Выход звёзд (Гаоним, 8,5°)';

  @override
  String get rabbeinuTam => '72 минуты после заката (Рабейну Там)';

  @override
  String get whenAlarmRingsHeading => 'КОГДА ЗВОНИТ БУДИЛЬНИК';

  @override
  String get recordOrAddSounds => 'Записать или добавить звуки';

  @override
  String get ringsForThisLong => 'Звонит столько, затем сам останавливается';

  @override
  String get sameFades => 'Одинаковые затухания для всех будильников';

  @override
  String get sameFadesOn => 'Заменяет затухания каждого будильника. Громкость у каждого своя.';

  @override
  String get sameFadesOff => 'Выкл.: каждый будильник использует затухания из своей «Громкости».';

  @override
  String get sayItOutLoud => 'Произносить вслух';

  @override
  String get sayItOutLoudHint => 'Читает, для чего будильник, напр. «Зажигание свечей, за 15 минут»';

  @override
  String get noSnooze => 'Без повтора';

  @override
  String snoozeUpTo(int times, int minutes) {
    return 'Повтор до $times× по $minutes мин';
  }

  @override
  String get wakeUpCheck => 'Проверка пробуждения';

  @override
  String get wakeUpCheckHint => 'После остановки снова звонит через 3 минуты, если не нажать «Я встал»';

  @override
  String get solveSum => 'Решите пример, чтобы остановить';

  @override
  String get provesAwake => 'Доказывает, что вы проснулись';

  @override
  String get shabbatNoTasks =>
      'В шаббат и праздники ничего из этого не действует: будильники останавливаются сами и никогда не просят трогать телефон.';

  @override
  String get testAlarmIn1 => 'Тестовый будильник через 1 минуту';

  @override
  String get timesDisclaimer =>
      'Время рассчитывается на телефоне. В спорных случаях спросите раввина или сверьтесь с календарём общины.';

  @override
  String get recommended => 'Рекомендуется';

  @override
  String get chooseCity => 'Выберите город';

  @override
  String get testOnlyOnPhone => 'Тестовые будильники работают только на телефоне.';

  @override
  String get testAlarm => 'Тестовый будильник';

  @override
  String get testAlarmBody => 'Так будут звучать ваши будильники';

  @override
  String get testAlarmIn1Set => 'Тестовый будильник через 1 минуту. Можно заблокировать телефон.';

  @override
  String get presetGone => 'Этого шаблона больше нет.';

  @override
  String get editPreset => 'Изменить шаблон';

  @override
  String get on => 'Вкл.';

  @override
  String get ringsHeading => 'ЗВОНИТ';

  @override
  String get noTimesYet => 'Пока нет времени. Добавьте ниже.';

  @override
  String get atTheMomentItself => 'Точно в момент события';

  @override
  String get remove => 'Удалить';

  @override
  String get addATime => 'Добавить время';

  @override
  String get resetPreset => 'Вернуть исходный';

  @override
  String get skipOneHint =>
      'Чтобы пропустить один будильник, нажмите на него в «Будильники на этой неделе» на главном экране.';

  @override
  String get unitMinutes => 'минуты';

  @override
  String get unitHours => 'часы';

  @override
  String get unitDays => 'дни';

  @override
  String get before => 'До';

  @override
  String get after => 'После';

  @override
  String get oneWeek => '1 неделя';

  @override
  String daysShort(int n) {
    return '$n д';
  }

  @override
  String hoursShort(int n) {
    return '$n ч';
  }

  @override
  String get howToSearch => 'Как искать';

  @override
  String get searchHelpWord => 'В названии есть «dentist», регистр не важен';

  @override
  String get searchHelpStar => '* — любые буквы: dentist, dentures';

  @override
  String get searchHelpQuestion => '? — одна буква: yoga, toga';

  @override
  String get searchHelpPhrase => 'Точно эта фраза';

  @override
  String get searchHelpAnd => 'Оба слова (AND)';

  @override
  String get searchHelpOr => 'Любое из них. Также работает |';

  @override
  String get searchHelpNot => 'Исключить. Также работают NOT и !';

  @override
  String get searchHelpBrackets => 'Скобки группируют слова';

  @override
  String get searchHelpEmpty => 'Оставьте пустым, чтобы звонить на каждое событие.';

  @override
  String get customTime => 'Другое время';

  @override
  String get other => 'Другое';

  @override
  String get sun => 'Солнце';

  @override
  String get calendar => 'Календарь';

  @override
  String get newEventAlarm => 'Новый будильник события';

  @override
  String get eventAlarm => 'Будильник события';

  @override
  String get findEventsHeading => 'НАЙТИ СОБЫТИЯ';

  @override
  String get searchEventsHint => 'Поиск: стоматолог, спортзал OR йога, стом*…';

  @override
  String get alsoBuiltInTimes => 'Также время шаббата, праздников и солнца';

  @override
  String get alsoBuiltInTimesHint => 'напр. «свеч*», «авдала», «закат»';

  @override
  String get allMyCalendars => 'Все мои календари';

  @override
  String get connectToSearch => 'Подключите календари, чтобы искать в них';

  @override
  String get searching => 'Поиск…';

  @override
  String get nothingMatches60 => 'Ничего не найдено в ближайшие 60 дней';

  @override
  String eventsIn60(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n события за 60 дней',
      many: '$n событий за 60 дней',
      few: '$n события за 60 дней',
      one: '$n событие за 60 дней',
    );
    return '$_temp0';
  }

  @override
  String nextRingsAt(String times, String title) {
    return 'Далее: звонит в $times для «$title»';
  }

  @override
  String showMoreLeft(int n) {
    return 'Показать ещё (осталось $n)';
  }

  @override
  String get ringBeforeStartsHeading => 'ЗВОНИТЬ ДО НАЧАЛА';

  @override
  String get ringWhenStarts => 'Звонить в начале';

  @override
  String get repeatBeforeHeading => 'И ПОВТОРЯТЬ ДО';

  @override
  String get everyPrefix => 'Каждые ';

  @override
  String get offLower => 'выкл.';

  @override
  String get forInfix => '  в течение ';

  @override
  String get ringAfterEndsHeading => 'ЗВОНИТЬ ПОСЛЕ ОКОНЧАНИЯ';

  @override
  String get nameOptional => 'Название (необязательно)';

  @override
  String get toppedUp => 'Будильники заданы на 7 дней вперёд и пополняются при каждом открытии Quando?.';

  @override
  String get back => 'Назад';

  @override
  String get next => 'Далее';

  @override
  String get stepWhichEvents => 'Какие события';

  @override
  String get stepWhenToRing => 'Когда звонить';

  @override
  String get stepHowItRings => 'Как звонит';

  @override
  String defaultNamed(String name) {
    return 'По умолчанию ($name)';
  }

  @override
  String get phoneAlarmSound => 'Звук будильника телефона';

  @override
  String get onlineRadio => 'Интернет-радио';

  @override
  String songLinkOpens(String app) {
    return 'Ссылка на трек · откроет $app';
  }

  @override
  String get builtIn => 'Встроенный';

  @override
  String get yourRecording => 'Ваша запись';

  @override
  String get sound => 'Звук';

  @override
  String get wakeToOwnSound => 'Просыпайтесь под свой звук';

  @override
  String get wakeToOwnSoundHint => 'Ваш голос, песня, Spotify или радио в прямом эфире';

  @override
  String musicAdded(String name) {
    return '$name добавлен. Выберите его звуком любого будильника.';
  }

  @override
  String get playlists => 'Плейлисты';

  @override
  String get likedSongs => 'Любимые треки';

  @override
  String get noPlaylists => 'Плейлистов пока нет.';

  @override
  String get noLikedSongs => 'Любимых треков пока нет.';

  @override
  String get needsMic => 'Quando? нужен микрофон для записи.';

  @override
  String recordingN(int n) {
    return 'Запись $n';
  }

  @override
  String couldNotAddFile(String error) {
    return 'Не удалось добавить файл: $error';
  }

  @override
  String get addSongLink => 'Добавить ссылку на трек';

  @override
  String get songLink => 'Ссылка на трек';

  @override
  String get songLinkHowTo =>
      'В Spotify, Apple Music, YouTube, YouTube Music или SoundCloud нажмите «Поделиться», затем «Копировать ссылку» и вставьте её сюда.';

  @override
  String get songNameHint => 'Название, напр. Утренний плейлист';

  @override
  String get whenAlarmGoesOffHeading => 'КОГДА ЗВОНИТ БУДИЛЬНИК';

  @override
  String get playTheSong => 'Включить трек';

  @override
  String get ringThenOpen => 'Позвонить, затем открыть';

  @override
  String get playTheSongHint =>
      'Откроется его приложение и включит трек. Если 10 секунд тишина, зазвонит запасной звук, так что вы точно проснётесь. Будильники с заданием сначала звонят, потом открывают трек.';

  @override
  String get ringThenOpenHint => 'Звонит запасной звук. «Стоп» открывает трек в его приложении.';

  @override
  String get playForHeading => 'ИГРАТЬ';

  @override
  String get pausesAfter => 'Quando? ставит трек на паузу после этого времени кнопкой паузы телефона.';

  @override
  String get backupSoundHeading => 'ЗАПАСНОЙ ЗВУК';

  @override
  String get notALink => 'Это не похоже на ссылку.';

  @override
  String songOn(String app) {
    return 'Трек в $app';
  }

  @override
  String get theWeb => 'интернете';

  @override
  String get pickFromYouTube => 'Выбрать из моего YouTube';

  @override
  String get youTubeAndMusic => 'YouTube и YouTube Music';

  @override
  String get youTubeOn => 'Подключено · удерживайте, чтобы выйти';

  @override
  String get youTubeSignIn => 'Войти через Google';

  @override
  String get addSongLinkInstead => 'Добавьте вместо этого ссылку на трек.';

  @override
  String get googleSignInFailed => 'Вход в Google не завершён. Попробуйте ещё раз.';

  @override
  String get myYouTube => 'Мой YouTube';

  @override
  String get spotifyDirectOn => 'Прямое воспроизведение Spotify включено';

  @override
  String get spotifyDirect => 'Прямое воспроизведение Spotify';

  @override
  String get spotifyDirectOnHint => 'Вкл. · нажмите, чтобы выключить';

  @override
  String get spotifyDirectHint => 'Играет именно эту песню. Нужен Premium.';

  @override
  String get spotifyComingSoon => 'Скоро · нужен Premium';

  @override
  String get spotifyFailed =>
      'Spotify не подключился. Проверьте, что приложение Spotify установлено, вы вошли и у вас Premium.';

  @override
  String get nameThisSound => 'Назовите этот звук';

  @override
  String get sounds => 'Звуки';

  @override
  String get soundsSentence => 'Просыпайтесь под свой голос, песню, плейлист или радио.';

  @override
  String stopTimer(String time) {
    return 'Стоп · $time';
  }

  @override
  String get record => 'Записать';

  @override
  String get addAFile => 'Добавить файл';

  @override
  String get addSongLinkLong => 'Добавить ссылку на трек (Spotify, Apple Music, YouTube…)';

  @override
  String get musicAppsHeading => 'МУЗЫКАЛЬНЫЕ ПРИЛОЖЕНИЯ';

  @override
  String get pickFromSpotify => 'Выбрать из моего Spotify';

  @override
  String get yourPlaylistsAndLiked => 'Ваши плейлисты и любимые треки';

  @override
  String get mySpotify => 'Мой Spotify';

  @override
  String get spotifySignInFailed => 'Не удалось войти в Spotify.';

  @override
  String get appleMusicNote => 'Вход появится в версии для iPhone. Пока добавьте ссылку на трек.';

  @override
  String noSignInNote(String service) {
    return '$service не разрешает вход из других приложений. Добавьте вместо этого ссылку на трек.';
  }

  @override
  String get wakeToRadio => 'Просыпайтесь под интернет-радио';

  @override
  String get soundsExplain =>
      'Запишите до 5 минут, добавьте файл, ссылку на песню или радио. Если что-то не сработает, зазвучит запасной звук.';

  @override
  String get yourSoundsHeading => 'ВАШИ ЗВУКИ';

  @override
  String playsIn(String app) {
    return 'Играет в $app';
  }

  @override
  String opensIn(String app) {
    return 'Открывается в $app';
  }

  @override
  String forSpan(String span) {
    return 'в течение $span';
  }

  @override
  String get defaultLabel => 'По умолчанию';

  @override
  String get radioUnreachable => 'Не удалось загрузить список станций. Проверьте подключение.';

  @override
  String get addStreamAddress => 'Добавить адрес потока';

  @override
  String get notAStream => 'Это не похоже на адрес потока (начинается с http).';

  @override
  String get anyGenre => 'Любой жанр';

  @override
  String get stationName => 'Название станции';

  @override
  String get closeSearch => 'Закрыть поиск';

  @override
  String get searchByName => 'Поиск по названию';

  @override
  String get anywhere => 'Везде';

  @override
  String get noStations => 'Станции не найдены. Попробуйте другой жанр или страну.';

  @override
  String wakeUpTo(String name) {
    return 'Просыпайтесь под $name';
  }

  @override
  String get notQuite => 'Почти. Попробуйте ещё.';

  @override
  String shabbatStopsItself(int n) {
    return 'Режим шаббата: остановится сам через $n с. Трогать телефон не нужно.';
  }

  @override
  String get solveToSnooze => 'РЕШИТЕ, ЧТОБЫ ОТЛОЖИТЬ';

  @override
  String get solveToStop => 'РЕШИТЕ, ЧТОБЫ ОСТАНОВИТЬ';

  @override
  String get answer => 'Ответ';

  @override
  String get snooze => 'Отложить';

  @override
  String get stop => 'Стоп';

  @override
  String get shakeToSnooze => 'ВСТРЯХНИТЕ, ЧТОБЫ ОТЛОЖИТЬ';

  @override
  String get shakeToStop => 'ВСТРЯХНИТЕ, ЧТОБЫ ОСТАНОВИТЬ';

  @override
  String get shakeHard => 'Сильно трясите телефон, пока полоса не заполнится.';

  @override
  String get cantShake => 'Не можете трясти? Решите пример';

  @override
  String get pairsToSnooze => 'НАЙДИТЕ ПАРЫ, ЧТОБЫ ОТЛОЖИТЬ';

  @override
  String get pairsToStop => 'НАЙДИТЕ ПАРЫ, ЧТОБЫ ОСТАНОВИТЬ';

  @override
  String get typeToSnooze => 'НАПЕЧАТАЙТЕ ЭТО, ЧТОБЫ ОТЛОЖИТЬ';

  @override
  String get typeToStop => 'НАПЕЧАТАЙТЕ ЭТО, ЧТОБЫ ОСТАНОВИТЬ';

  @override
  String get scanToSnooze => 'СКАНИРУЙТЕ КОД, ЧТОБЫ ОТЛОЖИТЬ';

  @override
  String get scanToStop => 'СКАНИРУЙТЕ КОД, ЧТОБЫ ОСТАНОВИТЬ';

  @override
  String ringAgainUnless(int n) {
    return 'Зазвоню снова через $n мин, если не нажмёте ниже.';
  }

  @override
  String get imUp => 'Я встал';

  @override
  String snoozeMin(int n) {
    return 'Отложить на $n мин';
  }

  @override
  String snoozeMinLeft(int n, int left) {
    return 'Отложить на $n мин · осталось $left';
  }

  @override
  String get noSnoozesLeft => 'Повторов больше нет';

  @override
  String get stopThenOpen => 'Стоп · затем открыть';

  @override
  String get startingSong => 'Запускаем ваш трек';

  @override
  String wayToStop(String way) {
    return '$way, чтобы остановить';
  }

  @override
  String wayToSnooze(String way) {
    return '$way, чтобы отложить';
  }

  @override
  String ringsForMore(int n) {
    return 'Звонит ещё $n с';
  }

  @override
  String get leftToRing => 'осталось';

  @override
  String get wayVolumeButtons => 'Кнопки громкости';

  @override
  String get wayShake => 'Встряхнуть телефон';

  @override
  String get taskNothing => 'Ничего';

  @override
  String get taskSum => 'Решить пример';

  @override
  String get taskShake => 'Встряхнуть 30 раз';

  @override
  String get taskMemory => 'Игра на память';

  @override
  String get taskPhrase => 'Напечатать фразу';

  @override
  String get taskScan => 'Сканировать код';

  @override
  String get noLimit => 'без ограничений';

  @override
  String upToTimes(int n) {
    return 'до $n×';
  }

  @override
  String shorterEachTime(int n) {
    return 'каждый раз на $n мин короче';
  }

  @override
  String autoSnoozeAfter(int n) {
    return 'откладывается сам через $n мин';
  }

  @override
  String get card => 'Карта';

  @override
  String get hiddenCard => 'Скрытая карта';

  @override
  String get phrase1 => 'Я проснулся и этот день мой';

  @override
  String get phrase2 => 'Если не сейчас то когда';

  @override
  String get phrase3 => 'Доброе утро мне и всем кого я люблю';

  @override
  String get phrase4 => 'Мои ноги на полу и я встал';

  @override
  String get phrase5 => 'Сегодня я начинаю заново';

  @override
  String get notQuiteWords => 'Почти, проверьте каждое слово.';

  @override
  String get typeItHere => 'Напечатайте здесь';

  @override
  String get differentCode => 'Это другой код.';

  @override
  String get cameraUnavailable => 'Камера недоступна.';

  @override
  String get cantScan => 'Не можете сканировать? Решите пример';

  @override
  String get saveCodeToScan => 'Сохраните код для сканирования';

  @override
  String get saveCodeHint =>
      'Наведите на штрих- или QR-код там, куда нужно дойти, например коробку на кухне или зубную пасту в ванной. Чтобы остановить будильник, отсканируете его снова.';

  @override
  String get cameraUnavailableSettings => 'Камера недоступна. Разрешите доступ к камере в Настройках.';

  @override
  String gentleToGo(int n) {
    return 'Мягкое пробуждение · осталось $n мин';
  }

  @override
  String previewBody(String body) {
    return 'Прослушивание · $body';
  }

  @override
  String snoozedBody(String body) {
    return 'Отложен: $body';
  }

  @override
  String get areYouUp => 'Вы встали?';

  @override
  String get tapImUp => 'Нажмите «Я встал», чтобы остановить';

  @override
  String get volume => 'Громкость';

  @override
  String get wakeCheckOn => 'Проверка пробуждения включена';

  @override
  String get stopsAtOnce => 'Сразу останавливается';

  @override
  String get ringsAgainIfNotUp => 'Звонит снова, если вы не встали';

  @override
  String get openAppAfter => 'Потом открыть приложение';

  @override
  String get noTask => 'Без задания';

  @override
  String get codeSaved => 'Код сохранён';

  @override
  String get tapToSaveDifferent => 'Нажмите, чтобы сохранить другой';

  @override
  String get controlsHeading => 'УПРАВЛЕНИЕ';

  @override
  String get onScreen => 'На экране';

  @override
  String get taskHeading => 'ЗАДАНИЕ';

  @override
  String get none => 'Нет';

  @override
  String get snoozeSentence => 'Ещё пять минут? Выберите, на сколько, сколько раз и что для этого нужно.';

  @override
  String get settingsHeading => 'НАСТРОЙКИ';

  @override
  String get snoozeTime => 'Время повтора';

  @override
  String get snoozeTimeHint => 'Длина первого повтора';

  @override
  String get shortenSnoozes => 'Сокращать следующие повторы';

  @override
  String get shortenSnoozesHint => 'Каждый повтор после первого короче на столько';

  @override
  String get autoSnooze => 'Автоповтор';

  @override
  String get autoSnoozeHint => 'Если не трогать, будильник сам отложится через';

  @override
  String get never => 'Никогда';

  @override
  String get snoozeLimit => 'Лимит повторов';

  @override
  String get snoozeLimitHint => 'Сколько раз можно отложить';

  @override
  String get unlimited => 'Без ограничений';

  @override
  String get useSnoozeFromSettings => 'Повтор из Настроек';

  @override
  String get stopSentence => 'Как выключить будильник и что нужно сделать сначала.';

  @override
  String get shabbatNoTask =>
      'В шаббат и праздники будильники останавливаются сами и никогда не требуют задания.';

  @override
  String get volumeSentence => 'Насколько громко звонит и как плавно к этому приходит.';

  @override
  String get openAfterAlarm => 'Открыть после будильника';

  @override
  String get pickAnApp => 'Выберите приложение';

  @override
  String get orPasteLink => 'Или вставьте ссылку: https://…';

  @override
  String get useThisLink => 'Использовать эту ссылку';

  @override
  String get noAppsFound => 'Приложения не найдены.';

  @override
  String get weather => 'Погода';

  @override
  String get news => 'Новости';

  @override
  String get usePhoneVolume => 'Громкость будильника телефона';

  @override
  String get setsPhoneVolume => 'Задаёт громкость будильника телефона на время звонка, затем возвращает её.';

  @override
  String get fadeInOff => 'Без нарастания, сразу полная громкость';

  @override
  String fadeInOver(String span) {
    return 'Нарастает за $span';
  }

  @override
  String get fadeOutOff => 'Без затухания';

  @override
  String fadeOutOver(String span) {
    return 'Затихает за последние $span';
  }

  @override
  String get fadesExplain =>
      'Затухание срабатывает, когда будильник останавливается сам. Если переходы длиннее звонка, оба сокращаются.';

  @override
  String get soundSoftChime => 'Мягкий колокольчик';

  @override
  String get soundMorningRise => 'Утренний подъём';

  @override
  String get soundClassicBeep => 'Классический сигнал';

  @override
  String get calmCity => 'Тихое утро в городе';

  @override
  String get calmBirds => 'Птицы на рассвете';

  @override
  String get calmWaves => 'Волны на берегу';

  @override
  String get calmRain => 'Тихий дождь';

  @override
  String get calmStream => 'Лесной ручей';

  @override
  String get calmWind => 'Лёгкий ветер';

  @override
  String get calmFire => 'Потрескивающий костёр';

  @override
  String get calmNight => 'Летняя ночь';

  @override
  String get publicDomain => 'Общественное достояние';

  @override
  String get phoneVolume => 'Громкость телефона';

  @override
  String fadesIn(String span) {
    return 'нарастает за $span';
  }

  @override
  String fadesOut(String span) {
    return 'затихает за $span';
  }

  @override
  String get noFade => 'без переходов';

  @override
  String minSecShort(int m, int s) {
    return '$m мин $s с';
  }

  @override
  String get happensRings => 'Звонит';

  @override
  String get happensStopped => 'Вы останавливаете';

  @override
  String get happensSnoozed => 'Вы откладываете';

  @override
  String get happensAutoStopped => 'Останавливается сам';

  @override
  String get eventLower => 'событие';

  @override
  String get appTest => 'Тест Quando?';

  @override
  String get pushoverConnected => 'Pushover подключён';

  @override
  String get webhookConnected => 'Вебхук подключён';

  @override
  String pushoverSaid(int code, String body) {
    return 'Pushover ответил $code: $body';
  }

  @override
  String couldNotReachPushover(String error) {
    return 'Не удалось связаться с Pushover ($error)';
  }

  @override
  String itAnswered(int code) {
    return 'Ответ: $code';
  }

  @override
  String couldNotReachIt(String error) {
    return 'Не удалось связаться ($error)';
  }

  @override
  String get calendarNotAllowed => 'Доступ к календарю не разрешён.';

  @override
  String get playlist => 'Плейлист';

  @override
  String songCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n трека',
      many: '$n треков',
      few: '$n трека',
      one: '$n трек',
    );
    return '$_temp0';
  }

  @override
  String get spotifySaidNo =>
      'Spotify отказал. В панели Spotify отметьте Web API для Quando? и добавьте свой аккаунт в User Management.';

  @override
  String serviceDidntAnswer(String service, int code) {
    return '$service не ответил ($code).';
  }

  @override
  String get youTubeSaidNo =>
      'YouTube отказал. Проверьте, что ваш аккаунт Google — тестовый пользователь проекта Quando.';

  @override
  String get event => 'Событие';

  @override
  String eventEnds(String title) {
    return '$title (конец)';
  }

  @override
  String foundSoundsDevices(int s, int d) {
    return 'Найдено звуков: $s, устройств: $d.';
  }

  @override
  String get sentCheckDevices => 'Отправлено. Проверьте другие устройства.';

  @override
  String sentTo(String name) {
    return 'Отправлено на $name.';
  }

  @override
  String get zapierHowTo =>
      'В Zapier создайте Zap, начинающийся с «Webhooks by Zapier → Catch Hook», и вставьте сюда его URL.';

  @override
  String get catchHookUrl => 'URL Catch Hook';

  @override
  String get iftttHowTo =>
      'В IFTTT создайте апплет, начинающийся с «Webhooks → Receive a web request with a JSON payload». Используйте здесь то же имя события. Ваш ключ на ifttt.com/maker_webhooks/settings.';

  @override
  String get eventName => 'Имя события';

  @override
  String get webhooksKey => 'Ключ Webhooks';

  @override
  String get webhookHowTo => 'Quando? отправляет JSON POST на этот адрес.';

  @override
  String get connectionsSentence =>
      'Сообщайте другим приложениям и устройствам, когда будильник звонит, остановлен или отложен.';

  @override
  String get pushWhenRings => 'Отправлять уведомление, когда звонит будильник';

  @override
  String get pushWhenRingsHint => 'На другие телефоны, планшеты, часы или компьютер';

  @override
  String get yourUserKey => 'Ваш ключ пользователя';

  @override
  String get appToken => 'Токен приложения';

  @override
  String get soundAndDevicesHeading => 'ЗВУК И УСТРОЙСТВА';

  @override
  String get loading => 'Загрузка…';

  @override
  String get loadFromPushover => 'Загрузить из Pushover';

  @override
  String get soundItPlays => 'Звук уведомления';

  @override
  String get myPushoverDefault => 'Мой звук Pushover по умолчанию';

  @override
  String get pushoverOwnSounds => 'Свои звуки появятся здесь после загрузки на pushover.net/sounds.';

  @override
  String get allMyDevices => 'Все мои устройства';

  @override
  String get pushoverOnThisPhone =>
      'Установите Pushover и на этот телефон, и он будет звонить здесь вашим звуком Pushover.';

  @override
  String get priority => 'Приоритет';

  @override
  String get priorityNormal => 'Обычный';

  @override
  String get priorityHigh => 'Высокий: игнорирует тихие часы';

  @override
  String get priorityEmergency => 'Экстренный: повторяется до подтверждения';

  @override
  String get sending => 'Отправка…';

  @override
  String get sendATest => 'Отправить тест';

  @override
  String get findUserKey => 'Найти мой ключ пользователя';

  @override
  String get makeAppToken => 'Создать токен приложения';

  @override
  String get webhooksHeading => 'ZAPIER, IFTTT И ВЕБХУКИ';

  @override
  String get webhooksExplain =>
      'Запускайте что угодно, когда будильник звонит или вы его останавливаете: включить свет, записать время подъёма, написать кому-то.';

  @override
  String get sendWhenAlarm => 'Отправлять, когда будильник:';

  @override
  String get pauseOnShabbat => 'Пауза в шаббат и праздники';

  @override
  String get pauseOnShabbatHint => 'Ничего не отправляется для будильников между зажиганием свечей и авдалой';

  @override
  String get webhookPayloadNote =>
      'Каждое сообщение содержит: event (ring, stopped, snoozed, auto_stopped), title, body, time, shabbat и snoozes. Ключи остаются на этом телефоне.';

  @override
  String get today => 'Сегодня';

  @override
  String get tomorrow => 'Завтра';

  @override
  String get notAWebAddress => 'Это не похоже на адрес, начинающийся с https://';

  @override
  String get language => 'Язык';

  @override
  String get phoneLanguage => 'Язык телефона';

  @override
  String get ringQuote => 'Если не сейчас, то когда?';

  @override
  String get ringQuoteBy => 'Гилель';

  @override
  String get quotesTitle => 'Цитаты о времени';

  @override
  String get quotesHint =>
      'Выберите, откуда они берутся. Одна на каждую часть дня; нажмите на цитату, чтобы увидеть другую.';

  @override
  String get quotesOff => 'Выкл.';

  @override
  String get quoteSongs => 'Песни';

  @override
  String get quoteMovies => 'Фильмы';

  @override
  String get quoteLiterature => 'Книги и стихи';

  @override
  String get quoteTanakh => 'Танах (Еврейская Библия)';

  @override
  String get quoteSages => 'Талмуд и мудрецы';

  @override
  String get quoteSpeeches => 'Знаменитые речи';

  @override
  String get quotePhilosophy => 'Философы';

  @override
  String get quoteProverbs => 'Пословицы и поговорки';

  @override
  String get quotesAlso => 'Также показывать';

  @override
  String get quoteCarnaval => 'Карнавал';

  @override
  String get quoteCarnavalHint => 'Песни и поговорки во время бразильского карнавала';

  @override
  String get quoteNearMe => 'Рядом со мной';

  @override
  String get quoteNearMeHint => 'Поэты и даты вашего места — по часовому поясу и городу для шаббата';

  @override
  String get quoteSiddur => 'Сидур (молитвенник)';

  @override
  String weeklyParasha(String name) {
    return 'Недельная глава $name';
  }

  @override
  String poweredBy(String name) {
    return 'на базе $name';
  }

  @override
  String get syncTitle => 'Синхронизировать мои устройства';

  @override
  String get syncHint =>
      'Войдите через Google, чтобы будильники и настройки были одинаковыми на всех ваших устройствах.';

  @override
  String syncOn(String email) {
    return 'On · $email';
  }

  @override
  String get syncWorking => 'Connecting…';

  @override
  String get syncNotAllowed => 'This Google account can\'t sync.';

  @override
  String get syncFailed => 'Не удалось подключиться. Нажмите, чтобы повторить.';

  @override
  String get syncStop => 'Stop syncing';

  @override
  String get syncNotSetUp => 'Синхронизация в этой версии ещё не настроена.';

  @override
  String get ringTheseAfterAll => 'Всё же звонить';

  @override
  String skipTheseDay(int n) {
    return 'Пропустить эти $n сегодня';
  }

  @override
  String turnOffNamed(String name) {
    return 'Выключить «$name»';
  }

  @override
  String turnOnNamed(String name) {
    return 'Включить «$name»';
  }

  @override
  String turnedOffNamed(String name) {
    return '«$name» выключен';
  }

  @override
  String removeTimeFrom(String time, String name) {
    return 'Убрать «$time» из «$name»';
  }

  @override
  String removedTimeFrom(String time, String name) {
    return '«$time» убрано из «$name»';
  }

  @override
  String get moveToGroup => 'Переместить в группу';

  @override
  String inGroupMove(String group) {
    return 'В «$group», переместить';
  }

  @override
  String movedToGroup(String group) {
    return 'Перемещено в «$group»';
  }

  @override
  String deleteNamed(String name) {
    return 'Удалить «$name»';
  }

  @override
  String get signInWithGoogle => 'Войти через Google';

  @override
  String get signOut => 'Sign out';

  @override
  String get signInWithEmail => 'Войти по почте';

  @override
  String get signIn => 'Sign in';

  @override
  String get createAccount => 'Создать аккаунт';

  @override
  String get haveAccount => 'У меня есть аккаунт';

  @override
  String get forgotPassword => 'Забыли пароль?';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get passwordResetSent => 'Мы отправили вам ссылку для выбора нового пароля.';

  @override
  String emailCheckInbox(String email) {
    return 'Мы отправили ссылку на $email. Откройте её, вернитесь и нажмите «Я подтвердил».';
  }

  @override
  String get emailConfirmed => 'Я подтвердил';

  @override
  String get emailNotYet => 'Пока не подтверждено. Сначала откройте ссылку в письме.';

  @override
  String get emailSendAgain => 'Отправить письмо ещё раз';

  @override
  String get emailSentAgain => 'Отправлено. Проверьте входящие и спам.';

  @override
  String get emailInvalid => 'Это не похоже на адрес электронной почты.';

  @override
  String get emailWrong => 'Неверная почта или пароль.';

  @override
  String get emailInUse =>
      'Аккаунт с этой почтой уже существует. Войдите или используйте Google, если создавали его через Google.';

  @override
  String get passwordWeak => 'Выберите пароль не короче 6 символов.';

  @override
  String get emailNotSwitchedOn => 'Вход по почте ещё не включён.';

  @override
  String get tooManyTries => 'Слишком много попыток. Подождите несколько минут.';

  @override
  String get spotifyLibrary => 'Spotify';

  @override
  String get spotifyLibrarySignIn => 'Плейлисты, любимые треки и поиск';

  @override
  String get spotifyLibraryOn => 'Подключено · удерживайте, чтобы выйти';

  @override
  String spotifyLoginError(String reason) {
    return 'Не удалось войти в Spotify: $reason';
  }

  @override
  String googleSignInError(String reason) {
    return 'Не удалось войти в Google: $reason';
  }

  @override
  String get searchSongsHint => 'Искать песни, исполнителей, плейлисты';

  @override
  String nothingFound(String query) {
    return 'По запросу «$query» ничего не найдено.';
  }

  @override
  String get deliveryTitle => 'Оповещение';

  @override
  String get deliveryLocal => 'Местный звук';

  @override
  String get deliveryBoth => 'Оба';

  @override
  String get deliveryConnect => 'Подключить Pushover';

  @override
  String get deliveryLoadFailed => 'Не удалось загрузить звуки и устройства. Повторите попытку.';

  @override
  String get deliveryBothHint => 'Местный звук прозвучит, даже если Pushover не сработает.';

  @override
  String get deliveryPushHint => 'Только Pushover. В момент сигнала устройство должно быть в сети.';

  @override
  String get deliveryFallback => 'Местный звук сохраняется, если Pushover отключён или приостановлен.';

  @override
  String get deliveryReset => 'Использовать текущие настройки';

  @override
  String get beforeShabbat => 'Before Shabbat';

  @override
  String get preparationReminders => 'Preparation reminders';

  @override
  String get skipThisWeek => 'Пропустить эту неделю';

  @override
  String get restoreThisWeek => 'Вернуть эту неделю';

  @override
  String get allAlarms => 'All alarms';

  @override
  String get timesAndSound => 'Times & sound';

  @override
  String get changeCity => 'Change city';

  @override
  String get useMyLocation => 'Использовать моё местоположение';

  @override
  String get locationUnavailable =>
      'Местоположение временно недоступно. Повторите попытку или выберите город.';

  @override
  String get locationReview => 'Подтвердить это местоположение';

  @override
  String get locationDeviceOnly =>
      'Это местоположение хранится только на этом устройстве. Проверьте часовой пояс и настройку Израиля, прежде чем использовать это время.';

  @override
  String timesIn(String city, String zone) {
    return '$city · $zone · время города';
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
    return 'Широта $latitude · долгота $longitude';
  }

  @override
  String get currentLocation => 'Текущее местоположение';

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
  String get weatherSwipeHint => 'Листайте между небом и погодой';

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
  String get moonAlwaysUp => 'Луна над горизонтом весь день';

  @override
  String get moonAlwaysDown => 'Луна под горизонтом весь день';

  @override
  String get noRiseToday => 'Сегодня без восхода';

  @override
  String get noSetToday => 'No set today';

  @override
  String get moonNew => 'New moon';

  @override
  String get moonWaxingCrescent => 'Растущий серп';

  @override
  String get moonFirstQuarter => 'Первая четверть';

  @override
  String get moonWaxingGibbous => 'Растущая Луна';

  @override
  String get moonFull => 'Full moon';

  @override
  String get moonWaningGibbous => 'Убывающая Луна';

  @override
  String get moonLastQuarter => 'Last quarter';

  @override
  String get moonWaningCrescent => 'Убывающий серп';

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
  String get weatherThunder => 'Грозы';

  @override
  String get weatherUnavailable => 'Погода временно недоступна';

  @override
  String get weatherCached => 'Сохранённый прогноз';

  @override
  String get weatherUpdated => 'Updated';

  @override
  String get weatherForecast => 'Forecast';

  @override
  String get weatherThunderExpected => 'Ожидаются грозы';

  @override
  String get learningUnavailable => 'Connect to load this month’s learning schedule';

  @override
  String get festivalReading => 'Festival Torah reading';

  @override
  String get learningCalendarSource => 'Learning calendar · Hebcal · CC BY 4.0';

  @override
  String get weatherSource => 'Forecast · MET Norway · CC BY 4.0';

  @override
  String get weatherConsent =>
      'Погода для выбранного города. Использует округлённые координаты с MET Norway.';

  @override
  String get learningConsent =>
      'Расписания учёбы Рамбама и другие загружаются из Hebcal и сохраняются для использования офлайн.';

  @override
  String get homeRefresh => 'Refresh';

  @override
  String get skyTimezone => 'My timezone';

  @override
  String get skyShabbat => 'Shabbat city';

  @override
  String get skyReferenceCity => 'Опорный город часового пояса';

  @override
  String get skyChooseCity => 'Выбрать город для неба';

  @override
  String get skyCityExplain =>
      'Солнце и Луна используют координаты этого города. Ваш город для Шаббата и часовой пояс будильников остаются как выбраны.';

  @override
  String get skySun => 'Sun today';

  @override
  String get skyMoon => 'Moon today';

  @override
  String get moonAboveHorizon => 'Луна над горизонтом';

  @override
  String get moonBelowHorizon => 'Луна под горизонтом';

  @override
  String get moonNextNew => 'Следующее новолуние';

  @override
  String get moonNextFull => 'Следующее полнолуние';

  @override
  String get locationServicesOff =>
      'Службы геолокации выключены. Включите их в Настройках или выберите город.';

  @override
  String get locationDenied =>
      'Доступ к местоположению запрещён. Разрешите его в Настройках или выберите город.';

  @override
  String get locationTimedOut =>
      'Местоположение пока не определено. На Mac оставьте Wi-Fi включённым и повторите попытку или выберите город.';

  @override
  String get locationTimeZoneUnavailable =>
      'Выберите город в нужном часовом поясе или используйте часовой пояс устройства, прежде чем применять местоположение.';

  @override
  String get locationSettings => 'Открыть настройки геолокации';

  @override
  String get locationLooking => 'Определяем местоположение…';

  @override
  String get skyMoonDisplay => 'Показывать Луну: восход, закат и фазу';

  @override
  String get tuyaConsumerPending =>
      'Account sign-in isn’t available in this build yet. If you already have a Tuya developer project, use Advanced setup.';

  @override
  String get tuyaAdvanced => 'Advanced setup';

  @override
  String get tuyaSignInTitle => 'Войти с аккаунтом Smart Life';

  @override
  String get tuyaSignInHint =>
      'Используйте ту же страну, почту или телефон и пароль, что и в приложении Smart Life или Tuya Smart. Аккаунт уже должен быть привязан к вашему проекту Tuya. Пароль уходит только в Tuya и нигде не сохраняется.';

  @override
  String get tuyaCountryCode => 'Телефонный код страны (Бразилия 55, США 1)';

  @override
  String get tuyaAccount => 'Почта или телефон Smart Life';

  @override
  String get tuyaPassword => 'Пароль Smart Life';

  @override
  String get tuyaSignIn => 'Войти и загрузить сценарии';

  @override
  String get tuyaRelayUrl => 'Адрес реле Tuya для Quando (https)';

  @override
  String get tuyaRelayHint =>
      'Используйте страну, почту или телефон и пароль аккаунта Smart Life или Tuya Smart. Они один раз передаются реле Tuya для Quando и не сохраняются. Нужно войти в аккаунт Quando.';

  @override
  String get tuyaGoogleHint =>
      'Входите в Smart Life через Google или Apple? В Smart Life нажмите «Забыли пароль», задайте пароль и используйте его здесь.';

  @override
  String get tuyaLinked => 'Аккаунт Smart Life привязан';

  @override
  String get tuyaUnlink => 'Отвязать';

  @override
  String get tuyaNeedsAccount => 'Сначала войдите в аккаунт Quando в настройках.';

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
      'Время неба использует часовой пояс этого места. Часовой пояс будильников и город для Шаббата не меняются. Хранится только на этом устройстве.';

  @override
  String get musicRingDurationHint =>
      'Воспроизведение следует длительности звонка будильника и прекращается при остановке или откладывании.';

  @override
  String get musicBackupPlaying => 'Не удалось включить музыку. Звучит локальный сигнал будильника.';

  @override
  String desktopMusicConnect(String service) {
    return 'Подключить приложение $service';
  }

  @override
  String desktopMusicOn(String service) {
    return 'Подключено к $service · удерживайте, чтобы отключить';
  }

  @override
  String get musicSongs => 'Песни';

  @override
  String get noMusicSongs => 'В медиатеке Музыки песни не найдены.';

  @override
  String serviceConnectUnavailable(String service) {
    return 'Добавьте ссылку $service · откроется после будильника';
  }

  @override
  String get soundCloudWidgetNote => 'Добавьте публичную ссылку';

  @override
  String get youtubePlayerHint =>
      'YouTube воспроизводит видео в видимом плеере. Если он скрыт или не может воспроизводить, локальный сигнал продолжается.';

  @override
  String get musicPreviewFailed =>
      'Не удалось воспроизвести звук. Проверьте подключение или попробуйте другой трек или станцию.';

  @override
  String get skyMoonPhase => 'Фаза Луны';

  @override
  String get skyMoonDetailsDisplay => 'Добавить страницу фазы Луны';

  @override
  String get skyMoonDetailsHint => 'Пролистайте к ней или нажмите на карточку Луны в любой момент';

  @override
  String get moonRises => 'Восход';

  @override
  String get moonSets => 'Заход';

  @override
  String moonLunarDay(int day) {
    return 'День $day из 29,5 в этом лунном месяце';
  }

  @override
  String get moonDetailsOpen => 'Открыть фазу Луны';

  @override
  String get musicPlaylists => 'Музыкальные плейлисты';

  @override
  String get videoPlaylists => 'Плейлисты с видео';

  @override
  String get likedVideos => 'Понравившиеся видео';

  @override
  String get wholePlaylist => 'Просыпаться под весь плейлист';

  @override
  String get noSongsInPlaylist => 'Здесь нет треков, которые можно воспроизвести.';

  @override
  String get hebrewNamesHeading => 'Написание недельной главы и месяцев';

  @override
  String get hebrewNamesIsraeli => 'Израильское';

  @override
  String get hebrewNamesAshkenazi => 'Ашкеназское';

  @override
  String pickFromService(String service) {
    return 'Выбрать из моего $service';
  }

  @override
  String get weatherTonight => 'Вечером';

  @override
  String get weatherTomorrowMorning => 'Завтра утром';

  @override
  String weatherUntilAbout(String time) {
    return 'примерно до $time';
  }

  @override
  String get weatherSunBehindClouds => 'Солнце за облаками';

  @override
  String get keysLockTitle => 'Ключи на ваших устройствах';

  @override
  String get keysLockOff =>
      'Ключи сервисов остаются на этом устройстве. Выберите фразу синхронизации, чтобы отправлять их в зашифрованном виде на другие устройства.';

  @override
  String get keysLockOn =>
      'Ключи сервисов шифруются вашей фразой синхронизации, прежде чем покинуть это устройство. Никто другой, даже Google, не может их прочитать.';

  @override
  String get keysLockWaiting =>
      'Сюда пришли ключи с другого устройства, они заперты. Введите фразу синхронизации, чтобы открыть их.';

  @override
  String get keysSetPassphrase => 'Выбрать фразу';

  @override
  String get keysChangePassphrase => 'Сменить фразу';

  @override
  String get keysUnlock => 'Открыть ключи';

  @override
  String get keysStartOver => 'Забыли? Начать заново';

  @override
  String get keysStartOverHint =>
      'Если начать заново, ключи этого устройства отправятся с новой фразой. Другие устройства попросят новую.';

  @override
  String get keysPassphrase => 'Фраза синхронизации';

  @override
  String get keysPassphraseAgain => 'Введите ещё раз';

  @override
  String keysPassphraseShort(int count) {
    return 'Не меньше $count символов.';
  }

  @override
  String get keysPassphraseMismatch => 'Фразы не совпадают.';

  @override
  String get keysPassphraseWrong => 'Эта фраза не открывает эти ключи.';

  @override
  String get keysPassphraseNote =>
      'Запишите её: если забудете, восстановить её нельзя, и ключи придётся ввести заново.';

  @override
  String get keysShareNeedsPassphrase =>
      'Сначала выберите фразу синхронизации в разделе «Ключи на ваших устройствах».';

  @override
  String get settingsAlarmDefaults => 'Настройки будильников по умолчанию';

  @override
  String get settingsPlacesTime => 'Места и время';

  @override
  String get settingsLook => 'Оформление, язык и цитаты';

  @override
  String get settingsAbout => 'About';

  @override
  String get defaultForNewAlarms => 'По умолчанию для новых будильников';

  @override
  String get preview => 'Preview';

  @override
  String atClock(String time) {
    return 'at $time';
  }

  @override
  String get connectACalendar => 'Подключить календарь';

  @override
  String get newFromReadyMade => 'Из готового набора';

  @override
  String get newFromReadyMadeHint => 'Восход, закат и другие будильники, которые уже настроены для вас';

  @override
  String get calendarSourcesIntro =>
      'Quando? может звонить до и после событий в ваших календарях. Выберите, откуда они берутся.';

  @override
  String get deviceCalendarsHeading => 'НА ЭТОМ УСТРОЙСТВЕ';

  @override
  String get deviceCalendarsTitle => 'Календарь этого устройства';

  @override
  String get deviceCalendarsHint =>
      'Все аккаунты на нём: Google, Samsung, Outlook, iCloud и календари, которые хранятся только здесь.';

  @override
  String get googleCalendarHeading => 'GOOGLE КАЛЕНДАРЬ';

  @override
  String get googleCalendarSignIn =>
      'Войдите через Google, чтобы читать календари прямо из Google, даже если вашего аккаунта Google нет на этом устройстве.';

  @override
  String googleCalendarSignedIn(String email) {
    return 'Вход выполнен: $email';
  }

  @override
  String get googleCalendarSignOut => 'Выйти';

  @override
  String get googleCalendarNotHere =>
      'Вход через Google на этом устройстве пока недоступен. Добавьте аккаунт Google в настройках устройства (Календарь › Учётные записи), и его календари появятся здесь.';

  @override
  String get googleCalendarUnreachable =>
      'Сейчас не удалось связаться с Google Календарём. Будильники, уже поставленные по нему, всё равно зазвонят.';

  @override
  String get googleCalendarTwiceHint =>
      'Календари того же аккаунта Google, которые это устройство уже показывает, сначала выключены, чтобы ничего не звонило дважды.';

  @override
  String get timersTitle => 'Таймеры';

  @override
  String get timerStopwatch => 'Секундомер';

  @override
  String get timerCountdown => 'Таймер';

  @override
  String get timerSequence => 'Внимание';

  @override
  String get timerStopwatchSub => 'Счёт вперёд, с кругами';

  @override
  String get timerCountdownSub => 'Обратный отсчёт, звонит на нуле';

  @override
  String get timerSequenceSub => 'Голосовой старт и отметки';

  @override
  String get timerStart => 'Старт';

  @override
  String get timerPause => 'Пауза';

  @override
  String get timerResume => 'Продолжить';

  @override
  String get timerReset => 'Сбросить';

  @override
  String get timerLap => 'Круг';

  @override
  String get timerTimesUp => 'Время вышло';

  @override
  String get timerSetTime => 'Установите время';

  @override
  String get timerMinutes => 'Минуты';

  @override
  String get timerSeconds => 'Секунды';

  @override
  String get seqOnYourMarks => 'На старт';

  @override
  String get seqGetSet => 'Внимание';

  @override
  String get seqGo => 'Марш!';

  @override
  String get seqFinish => 'Время!';

  @override
  String get seqReady => 'Готово';

  @override
  String get seqSettings => 'Настройки';

  @override
  String get seqStartCalls => 'Подсказки перед стартом';

  @override
  String get seqStartCallsHelp => 'Произносятся вслух перед «Марш», отсчёт назад от старта.';

  @override
  String seqCallBefore(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'За $n секунды',
      many: 'За $n секунд',
      few: 'За $n секунды',
      one: 'За 1 секунду',
    );
    return '$_temp0';
  }

  @override
  String get seqAddCall => 'Добавить подсказку';

  @override
  String get seqCallText => 'Что сказать';

  @override
  String get seqGoText => 'На старте сказать';

  @override
  String get seqFinishText => 'В конце сказать';

  @override
  String get seqLength => 'Длительность';

  @override
  String get seqNoLimit => 'Без ограничения';

  @override
  String get seqSayEvery => 'Называть время каждые';

  @override
  String get seqOff => 'Выкл.';

  @override
  String seqEverySeconds(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n секунды',
      many: '$n секунд',
      few: '$n секунды',
      one: '1 секунда',
    );
    return '$_temp0';
  }

  @override
  String seqEveryMinutes(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n минуты',
      many: '$n минут',
      few: '$n минуты',
      one: '1 минута',
    );
    return '$_temp0';
  }

  @override
  String get seqFinalCount => 'Отсчитывать последние';

  @override
  String get seqMarks => 'Ваши отметки';

  @override
  String get seqAddMark => 'Добавить отметку';

  @override
  String seqMarkAt(String time) {
    return 'В $time';
  }

  @override
  String get seqSpeak => 'Говорить вслух';

  @override
  String get seqBeeps => 'Сигналы и вибрация';

  @override
  String get seqSayRemaining => 'Называть оставшееся время, а не прошедшее';

  @override
  String get seqPresets => 'Шаблоны';

  @override
  String get seqPresetRace => 'Старт гонки';

  @override
  String get seqPresetSprint => 'Усилие 30 с';

  @override
  String get seqPresetRound => 'Раунд 1 мин';

  @override
  String get seqHintNoLimit => 'После «Марш» считает вперёд, пока вы не остановите.';

  @override
  String get seqHintLength => 'После «Марш» считает назад до нуля.';

  @override
  String get seqWords => 'Слова';

  @override
  String get homeEdit => 'Arrange home';

  @override
  String get homeEditHint =>
      'Потяните за ручку, чтобы переместить карточку, свернуть её или изменить размер.';

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
  String get homeBlockSky => 'СОЛНЦЕ, ЛУНА И ПОГОДА';

  @override
  String get homeBlockQuick => 'QUICK ALARMS';

  @override
  String get homeBlockShabbat => 'ШАББАТ И ПРАЗДНИКИ';

  @override
  String get homePlaceTitle => 'Город для неба';

  @override
  String nextAlarmLine(String title, String time) {
    return 'Следующий будильник · $title $time';
  }

  @override
  String get showAllAlarms => 'Показать все дни';

  @override
  String get noAlarmsThatDay => 'В этот день ничего не звонит';

  @override
  String get homeClockSize => 'Часы на главном экране';

  @override
  String get sizeSmall => 'Маленькие';

  @override
  String get sizeMedium => 'Средние';

  @override
  String get sizeLarge => 'Большие';

  @override
  String get homeLayout => 'Вид главного экрана';

  @override
  String get homeLayoutClassic => 'Классический';

  @override
  String get homeLayoutCards => 'Карточки';

  @override
  String get homeCardsHint =>
      'Перетащите карточку, чтобы переместить. Потяните за край или угол, чтобы изменить размер, или выберите размер.';

  @override
  String get homeAddCard => 'Добавить карточку';

  @override
  String get homeOnHome => 'На экране';

  @override
  String get homeRemoveCard => 'Убрать';

  @override
  String get cardNext => 'Следующий будильник';

  @override
  String get cardClock => 'Часы и дата';

  @override
  String get cardSky => 'Солнце, луна и погода';

  @override
  String get cardMoon => 'Луна';

  @override
  String get cardWeather => 'Погода';

  @override
  String get cardAlarms => 'Ваши будильники';

  @override
  String get cardQuick => 'Быстрые будильники';

  @override
  String get cardTools => 'Секундомер, таймер и «внимание»';

  @override
  String get cardWorld => 'Мировое время';

  @override
  String get cardWeek => 'Эта неделя';

  @override
  String get cardShabbat => 'Шаббат и праздники';

  @override
  String get ringAtEventReminders => 'Звонить по напоминаниям самого события';

  @override
  String get ringAtEventRemindersHint =>
      'Напоминания из вашего календаря звонят здесь как громкие будильники, со звуком этого будильника.';

  @override
  String get atEventReminders => 'по напоминаниям события';

  @override
  String get everyEventReminderLoud => 'Громко звонить по напоминаниям каждого события';

  @override
  String get loudNotificationsHeading => 'ГРОМКИЕ УВЕДОМЛЕНИЯ КАЛЕНДАРЯ';

  @override
  String get loudNotificationsTitle => 'Сделать уведомления календаря громкими';

  @override
  String get loudNotificationsHint =>
      'Когда календарь показывает напоминание, Quando? звонит им как будильником, даже в беззвучном режиме.';

  @override
  String get loudNotificationsDisclosureTitle => 'Разрешить Quando? читать уведомления календаря?';

  @override
  String get loudNotificationsDisclosure =>
      'Чтобы громко звонить напоминаниями календаря, Quando? нужен доступ к уведомлениям. Он смотрит только уведомления выбранных вами календарей, читает их заголовок и текст на этом телефоне, чтобы показать на будильнике, и никогда их не хранит и никуда не отправляет. Это можно выключить в любой момент.';

  @override
  String get loudNotificationsAgree => 'Согласиться и продолжить';

  @override
  String get loudNotificationsNoAccess =>
      'Доступ к уведомлениям выключен. Включите Quando? в открывшемся списке.';

  @override
  String get loudNotificationsAllow => 'Разрешить';

  @override
  String get loudNotificationsNoApps => 'На этом телефоне нет поддерживаемого календаря.';

  @override
  String get loudNotificationsTwiceNote =>
      'События, у которых уже есть будильник Quando?, звонят только один раз.';

  @override
  String get loudNotificationsShabbatNote => 'Тихо в Шаббат и праздники.';

  @override
  String get busyMode => 'Режим «Занят»';

  @override
  String get busyModeSubtitle => '«Не беспокоить» и автоответы, пока вы заняты';

  @override
  String get busyIntro =>
      'Пока вы заняты, Quando? может приглушить телефон и отвечать на сообщения за вас. Будильники по-прежнему звонят.';

  @override
  String get busyIosFocus =>
      'На iPhone и iPad приложения не могут включать фокусирование и отвечать на сообщения. В приложении «Команды» создайте автоматизацию «При открытии Quando?» или по времени, которая включает фокусирование, и настройте в нём автоответ.';

  @override
  String get busyWhileHeading => 'ПОКА ВЫ ЗАНЯТЫ';

  @override
  String get busyDnd => 'Не беспокоить';

  @override
  String get busyDndHint =>
      'Только важные: звонки и сообщения беззвучны, будильники звонят. Потом всё как было.';

  @override
  String get busyDndNoAccess => 'Quando? пока не может менять «Не беспокоить».';

  @override
  String get busyReplies => 'Отвечать на сообщения';

  @override
  String get busyRepliesHint =>
      'Один раз каждому, вашим текстом, через кнопку «Ответить» самого приложения. Только Android.';

  @override
  String get busyRepliesDisclosureTitle => 'Разрешить Quando? отвечать на сообщения?';

  @override
  String get busyRepliesDisclosure =>
      'Чтобы отвечать за вас, Quando? нужен доступ к уведомлениям. Только пока вы заняты, он смотрит уведомления о сообщениях выбранных приложений, читает имя отправителя на этом телефоне и один раз отправляет ваш текст через кнопку «Ответить» самого приложения. Сообщения никогда не сохраняются и никуда больше не отправляются. Группы пропускаются, если вы их не разрешите.';

  @override
  String get busyReplyText => 'Ваш ответ';

  @override
  String busyReplyTextHint(String until) {
    return '$until заменится временем окончания режима.';
  }

  @override
  String busyReplyDefault(String until) {
    return 'Сейчас занят, отвечу после $until.';
  }

  @override
  String get busyGroups => 'Отвечать и в группах';

  @override
  String get busyGroupsHint => 'Выключено: группам никогда не отвечаем.';

  @override
  String get busyRepliesOnShabbat => 'Отвечать в Шаббат и праздники';

  @override
  String get busyAskRabbi =>
      'По умолчанию выключено. Спросите своего раввина, прежде чем включать на Шаббат.';

  @override
  String get busyWhenHeading => 'КОГДА ВЫ ЗАНЯТЫ';

  @override
  String get busyWhenHint =>
      'Включите «Занят во время этих событий» в будильнике календаря или «Занят после звонка» в будильнике.';

  @override
  String get busyDuringLock => 'Занят, пока включён режим блокировки';

  @override
  String get busyNoneComing => 'В ближайшие 7 дней вы не заняты.';

  @override
  String get busyDuringEvents => 'Занят во время этих событий';

  @override
  String get busyDuringEventsHint => 'Режим «Занят» от начала до конца каждого события.';

  @override
  String get busySettings => 'Настройки режима «Занят»';

  @override
  String get busyAfterRing => 'Занят после звонка';

  @override
  String get busyAfterRingHint => '«Не беспокоить» и автоответы на время, например тренировка или сон днём.';

  @override
  String get shareCard => 'Поделиться утром';

  @override
  String get shareCardSubtitle => 'Сегодняшнее небо и цитата или ваше фото для историй и статуса';

  @override
  String get shareAppMissing => 'Этого приложения нет на телефоне.';

  @override
  String get shareAsIs => 'Поделиться как есть';

  @override
  String get shareTapQuote => 'Нажмите на цитату, чтобы сменить.';

  @override
  String get shareStory => 'История';

  @override
  String get shareSquare => 'Квадрат';

  @override
  String get shareYourWords => 'Свои слова (необязательно)';

  @override
  String get shareYourWordsHint => 'Вместо сегодняшней цитаты';

  @override
  String get shareYourPhoto => 'Своё фото';

  @override
  String get shareOtherPhoto => 'Другое фото';

  @override
  String get shareSkyBack => 'Сегодняшнее небо';

  @override
  String get shareYourVideo => 'Своё видео';

  @override
  String get shareInstagramStory => 'Истории Instagram';

  @override
  String get shareWhatsApp => 'WhatsApp: статус или чат';

  @override
  String get shareMore => 'Другие приложения';

  @override
  String get shareYouPost =>
      'Quando? открывает приложение с готовой карточкой. Вы сами выбираете, куда, и публикуете.';

  @override
  String get shareAndroidFirst => 'Скоро и на iPhone и iPad.';

  @override
  String songSaved(String name) {
    return '«$name» сохранено как звук будильника';
  }

  @override
  String get shareToQuando => 'Поделитесь песней с Quando?';

  @override
  String get shareToQuandoHint =>
      'В YouTube, YouTube Music, Spotify, SoundCloud или Apple Music нажмите «Поделиться», затем Quando?. Это станет звуком будильника, который играет в своём приложении.';

  @override
  String get askOption => 'Скажите или напишите';

  @override
  String get askOptionHint => '«Завтра в 6», «за 30 мин до восхода»';

  @override
  String get askHint => 'напр.: разбуди меня по будням за 30 мин до восхода';

  @override
  String get askListening => 'Слушаю…';

  @override
  String get askNotUnderstood => 'Не нашёл время. Попробуйте «в 7 по будням» или «через 20 минут».';

  @override
  String askAnswerFromCalendar(String name) {
    return 'Из вашего календаря «$name»';
  }

  @override
  String get askAnswerBuiltIn => 'Время Quando? для вашего города';

  @override
  String get askNoAnswer => 'Пока время не найдено.';

  @override
  String get askNoSpeech => 'Голос недоступен на этом устройстве. Можно ввести текст.';

  @override
  String get askShabbatOff => 'Включите Шаббат в настройках, чтобы звонили времена Шаббата.';

  @override
  String askSaved(String what) {
    return 'Сохранено: $what';
  }

  @override
  String get askMic => 'Говорить';

  @override
  String get askMorning => 'Утро';

  @override
  String get askEvening => 'Вечер';

  @override
  String get askUnsure => 'Возможно, я что-то упустил. Проверьте перед сохранением.';

  @override
  String get askTeach => 'Научи меня';

  @override
  String askTaught(String phrase, String time) {
    return 'Понял: «$phrase» теперь значит $time.';
  }

  @override
  String get askSkipAction => 'Пропустить';

  @override
  String get askNoMatch => 'Нет подходящего будильника.';

  @override
  String askTurnedOff(String what) {
    return 'Выключен: $what';
  }

  @override
  String askSkipped(String what) {
    return 'Пропущен: $what';
  }

  @override
  String askEventPlan(String offset, String event) {
    return '$offset «$event» в вашем календаре';
  }

  @override
  String askEventNoCalendar(String event) {
    return 'Подключите календарь, чтобы Quando? нашёл «$event».';
  }

  @override
  String askSnoozeAll(int minutes) {
    return 'Повтор: $minutes мин, для всех будильников';
  }

  @override
  String askWakeWith(String sound) {
    return 'Будит вас: $sound';
  }

  @override
  String get askReadAs => 'Прочитано как';
}
