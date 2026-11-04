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
  String get tagline => 'Если не сейчас, то когда?';

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
  String get calendarAlarm => 'Будильник календаря';

  @override
  String get calendarIntro =>
      'Quando? может звонить до и после событий в календарях телефона. Google Календарь подключится, как только ваш аккаунт Google есть на телефоне.';

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
      'В Spotify, Apple Music, Amazon Music, YouTube, YouTube Music или SoundCloud нажмите «Поделиться», затем «Копировать ссылку» и вставьте её сюда.';

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
  String get youTubeOn => 'Ваши плейлисты и любимые треки. Удерживайте, чтобы выйти.';

  @override
  String get youTubeSignIn => 'Войдите через Google, чтобы выбирать из плейлистов и любимых треков.';

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
  String get spotifyDirectOnHint => 'Spotify играет именно ваш трек как будильник. Нажмите, чтобы выключить.';

  @override
  String get spotifyDirectHint =>
      'Играет именно ваш трек Spotify как будильник, надёжнее. Нужны приложение Spotify и Spotify Premium. Нажмите, чтобы войти.';

  @override
  String get spotifyComingSoon => 'Скоро: ваш трек Spotify как будильник (нужен Spotify Premium).';

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
      'Запишите свой голос, песню или что угодно, до 5 минут. Добавьте MP3, M4A или WAV с телефона. Дайте ссылку на трек или плейлист: его приложение сыграет его как будильник, с запасным звуком. Или выберите радиостанцию: она играет в прямом эфире, а если не подключится, звонит будильник телефона.';

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
}
