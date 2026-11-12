// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get undo => '撤销';

  @override
  String duplicatedNamed(String name) {
    return '已复制“$name”';
  }

  @override
  String deletedNamed(String name) {
    return '已删除“$name”';
  }

  @override
  String get when => '何时？';

  @override
  String get newAtTime => '在某个时间';

  @override
  String get newAtTimeHint => '每个工作日 7:00，仅一次 15:30…';

  @override
  String get newAroundEvent => '围绕某个事件';

  @override
  String get newAroundEventHint => '在日历、安息日和日出日落时间中查找，然后在之前、当时或之后响铃';

  @override
  String get editThisAlarm => '编辑此闹钟';

  @override
  String editNamed(String name) {
    return '编辑“$name”';
  }

  @override
  String get preset => '模板';

  @override
  String get editThisCalendarRule => '编辑此日历规则';

  @override
  String get ringThisOneAfterAll => '还是响这一次';

  @override
  String get skipJustThisOne => '只跳过这一次';

  @override
  String get renameGroup => '重命名分组';

  @override
  String quickSet(String label, String time) {
    return '$label · $time 响铃';
  }

  @override
  String get newAlarm => '新闹钟';

  @override
  String get appName => 'Quando?';

  @override
  String get lockMode => '锁定模式';

  @override
  String get calendars => '日历';

  @override
  String get settings => '设置';

  @override
  String get nextAlarmHeading => '下一个闹钟';

  @override
  String get nothingSet => '未设置';

  @override
  String get tagline => '凡事皆有时。';

  @override
  String sunriseAt(String time) {
    return '日出 $time';
  }

  @override
  String sunsetAt(String time) {
    return '日落 $time';
  }

  @override
  String get alarmsMayNotRing => '你的闹钟可能不会响';

  @override
  String get tapToFixIt => '点按修复';

  @override
  String inMinutes(int minutes) {
    return '$minutes 分钟后';
  }

  @override
  String get atSunset => '日落时';

  @override
  String get sunset => '日落';

  @override
  String get shabbatModeIsOn => '安息日模式已开启';

  @override
  String nextInCity(String city) {
    return '下一个 · $city';
  }

  @override
  String get candleLighting => '点蜡烛';

  @override
  String get havdalah => '哈夫达拉';

  @override
  String get shabbatAndFestivals => '安息日和节日';

  @override
  String get yourAlarmsHeading => '你的闹钟';

  @override
  String get tapWhenToAdd => '点按“何时？”添加闹钟。';

  @override
  String get aroundEventsHeading => '围绕事件';

  @override
  String searchFor(String words) {
    return '搜索：$words';
  }

  @override
  String get thisWeekHeading => '本周闹钟';

  @override
  String get noAlarmsThisWeek => '未来 7 天没有闹钟。';

  @override
  String get alarmsSetThemselves => '每次你更改设置，闹钟都会在这部手机上自动设好。';

  @override
  String cityTime(String city) {
    return '$city时间';
  }

  @override
  String get more => '更多';

  @override
  String get turnOff => '关闭';

  @override
  String get turnOn => '开启';

  @override
  String get duplicate => '复制';

  @override
  String get delete => '删除';

  @override
  String get inOneHour => '1 小时后';

  @override
  String get logoLabel => 'Quando? 标志';

  @override
  String get noTimesSet => '未设置时间';

  @override
  String get atTheMoment => '当时';

  @override
  String timesRange(int count, String from, String to) {
    return '$count 次 · $from 至 $to';
  }

  @override
  String spanDays(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n 天');
    return '$_temp0';
  }

  @override
  String spanHours(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n 小时');
    return '$_temp0';
  }

  @override
  String spanMinutes(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n 分钟');
    return '$_temp0';
  }

  @override
  String spanSeconds(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n 秒');
    return '$_temp0';
  }

  @override
  String get now => '现在';

  @override
  String spanBefore(String span) {
    return '$span前';
  }

  @override
  String spanAfter(String span) {
    return '$span后';
  }

  @override
  String alarmCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n 个闹钟');
    return '$_temp0';
  }

  @override
  String get allOn => '全部开启';

  @override
  String get allOff => '全部关闭';

  @override
  String someOn(int n) {
    return '$n 个开启';
  }

  @override
  String skippedBody(String body) {
    return '已跳过 · $body';
  }

  @override
  String timeToTime(String from, String to) {
    return '$from – $to';
  }

  @override
  String skippedCount(int n) {
    return '已跳过 $n 个';
  }

  @override
  String get sunNoRiseSet => '今天这里太阳不升起也不落下';

  @override
  String sunProgress(int percent) {
    return '太阳已走过今天的 $percent%';
  }

  @override
  String get sunIsDown => '太阳已落下';

  @override
  String get searchCity => '搜索城市';

  @override
  String get tomorrowLower => '明天';

  @override
  String get yesterdayLower => '昨天';

  @override
  String get worldClocksHeading => '世界时钟';

  @override
  String get add => '添加';

  @override
  String cityHere(String city) {
    return '$city · 此处';
  }

  @override
  String get worldClocksHint => '添加城市即可在这里查看当地时间。向左滑动可移除。';

  @override
  String get groupNameHint => '工作、孩子、健身…';

  @override
  String get cancel => '取消';

  @override
  String get ok => '好';

  @override
  String get noGroup => '无分组';

  @override
  String get newGroupEllipsis => '新分组…';

  @override
  String get newGroup => '新分组';

  @override
  String secondsShort(int n) {
    return '$n 秒';
  }

  @override
  String minutesShort(int n) {
    return '$n 分';
  }

  @override
  String get minutes => '分钟';

  @override
  String get ringFor => '响铃时长';

  @override
  String get seconds => '秒';

  @override
  String get oneSecondLess => '减少 1 秒';

  @override
  String get oneSecondMore => '增加 1 秒';

  @override
  String inDays(int d) {
    return '$d 天后';
  }

  @override
  String inDaysHours(int d, int h) {
    return '$d 天 $h 小时后';
  }

  @override
  String inHours(int h) {
    return '$h 小时后';
  }

  @override
  String inHoursMinutes(int h, int m) {
    return '$h 小时 $m 分后';
  }

  @override
  String inMins(int m) {
    return '$m 分钟后';
  }

  @override
  String placeChange(String city, String where) {
    return '$city · $where · 更改';
  }

  @override
  String get israel => '以色列';

  @override
  String get outsideIsrael => '以色列以外';

  @override
  String get comingUpHeading => '即将到来';

  @override
  String get lockForShabbat => '安息日锁定手机';

  @override
  String get lockForShabbatHint => '从点蜡烛到哈夫达拉，节日也一样';

  @override
  String get ownShabbatAlarmsHeading => '你的安息日闹钟';

  @override
  String get addShabbatAlarm => '添加安息日或节日闹钟';

  @override
  String get readyMadeHeading => '现成的闹钟';

  @override
  String bringBackDeleted(int n) {
    return '恢复已删除（$n）';
  }

  @override
  String get presetsHint => '点按可修改时间，滑动可删除。';

  @override
  String get lockSentence => '让手机只剩时钟和闹钟，用于安息日或专注的夜晚。';

  @override
  String get lockExplain => '锁定期间，Quando? 只显示时间、下一个闹钟和锁定结束时间。闹钟照常工作，解锁前无法更改任何内容。';

  @override
  String get lockNowHeading => '立即锁定';

  @override
  String get lockAutoHeading => '自动锁定';

  @override
  String get shabbatAndFestivalsLong => '安息日和节日';

  @override
  String get fromCandleToHavdalah => '从点蜡烛到哈夫达拉';

  @override
  String get lockCalendarWord => '在含有此词的日历事件期间';

  @override
  String get lockCalendarWordHint => '例如 锁定、考试、专注';

  @override
  String get leaveEmptyForNone => '留空表示不使用';

  @override
  String get connectCalendarsFirst => '请先连接日历（日历图标）';

  @override
  String get openWhenLockStarts => '锁定开始时打开 Quando?';

  @override
  String get openWhenLockStartsHint => '1 秒的轻声提示会把 Quando? 调到前台进行锁定';

  @override
  String get pinToScreen => '将 Quando? 固定在屏幕上';

  @override
  String get pinToScreenHint => '锁定期间其他应用无法打开。首次使用时 Android 会请求确认。';

  @override
  String get noLocksComingUp => '没有即将到来的锁定。';

  @override
  String get leaveLockEarly => '要提前退出，请按住“按住解锁”3 秒。';

  @override
  String get locked => '已锁定';

  @override
  String get shabbatShalom => '安息日平安';

  @override
  String get chagSameach => '节日快乐';

  @override
  String get unlocksHeading => '解锁时间';

  @override
  String get nowCap => '现在';

  @override
  String get nextAlarm => '下一个闹钟';

  @override
  String get holdToUnlock => '按住解锁';

  @override
  String get lockSentenceCalm => '把手机锁定在时钟和闹钟：用于考试、会议或安静的夜晚。';

  @override
  String get lockCalendarHeading => '按日历';

  @override
  String get lockCalendarExplain => '在日程期间锁定，或从一个日程锁到你指定的下一个日程。适用于你选的任何日历，包括共享日历。';

  @override
  String get lockAddCalendar => '添加日历锁定';

  @override
  String get lockEditCalendar => '日历锁定';

  @override
  String get lockDuring => '日程期间';

  @override
  String get lockBetween => '两个日程之间';

  @override
  String get lockStartsAt => '名称为…的日程';

  @override
  String get lockStartsAtBetween => '从名为…的日程开始';

  @override
  String get lockEndsAt => '到下一个名为…的日程结束';

  @override
  String get lockStartHint => '例如 考试、专注、健身';

  @override
  String get lockEndHint => '例如 到家';

  @override
  String get lockAnyCalendar => '任何日历';

  @override
  String get lockNoMatches => '你的日历里还没有匹配的日程。';

  @override
  String get lockNextTimes => '接下来';

  @override
  String lockDuringTitle(String a) {
    return '“$a”期间';
  }

  @override
  String lockBetweenTitle(String a, String b) {
    return '从“$a”到下一个“$b”';
  }

  @override
  String lockShabbatCalendarFound(String name) {
    return '“$name”包含安息日时间。';
  }

  @override
  String get lockShabbatFromCalendar => '从点蜡烛锁到哈夫达拉';

  @override
  String get lockShabbatFromCalendarHint => '使用该日历的时间，锁屏显示蜡烛。';

  @override
  String get lockMoreWays => '更多锁定方式';

  @override
  String get lockQuietTime => '安静时间';

  @override
  String nextCandleLightingFrom(String time, String name) {
    return '下次点蜡烛：$time，来自 $name';
  }

  @override
  String get calendarAlarm => '日历闹钟';

  @override
  String get connectCalendars => '连接日历';

  @override
  String get calendarAlarmsHeading => '日历闹钟';

  @override
  String get calendarNoneYet => '还没有。先从这个开始，再随意修改：';

  @override
  String get fifteenBeforeEvery => '每个事件前 15 分钟';

  @override
  String get useTheseCalendarsHeading => '使用这些日历';

  @override
  String get noTimedEvents => '这些日历中没有即将到来的定时事件。';

  @override
  String get atTheStart => '开始时';

  @override
  String everyForBefore(String every, String span) {
    return '提前 $span 起每 $every';
  }

  @override
  String spanAfterItEnds(String span) {
    return '结束后 $span';
  }

  @override
  String get noAlarmsChosen => '未选择闹钟';

  @override
  String get gentleWakeUp => '温和唤醒';

  @override
  String gentleSummary(int minutes, String sound) {
    return '提前 $minutes 分钟 · $sound';
  }

  @override
  String get off => '关闭';

  @override
  String get gentleSentence => '闹钟响起前，平静的声音会轻轻开始，让你不再被吓醒。';

  @override
  String get gentleExplain => '声音慢慢变大，把你从浅睡中带出来，并在闹钟响起前停止。';

  @override
  String get startsBeforeHeading => '在闹钟前开始';

  @override
  String get leadUpSoundHeading => '前奏声音';

  @override
  String get listen => '试听';

  @override
  String get whoRecordedThese => '这些声音的录制者';

  @override
  String get done => '完成';

  @override
  String get soundCredits => '声音来源';

  @override
  String yourTimeCity(String city) {
    return '你的时间（$city）';
  }

  @override
  String get anotherCity => '其他城市…';

  @override
  String get ringingIn5 => '5 秒后响铃…';

  @override
  String get alarmSaved => '闹钟已保存。';

  @override
  String alarmSetFor(String span) {
    return '闹钟将在 $span后响起。';
  }

  @override
  String hoursMinutesShort(int h, int m) {
    return '$h 小时 $m 分';
  }

  @override
  String get editAlarm => '编辑闹钟';

  @override
  String get previewCaps => '试听';

  @override
  String get saveCaps => '保存';

  @override
  String cityTimeForYou(String city, String time) {
    return '$city时间 · 你那里 $time';
  }

  @override
  String repeatHeading(String repeat) {
    return '重复 · $repeat';
  }

  @override
  String get labelField => '标签（开启语音闹钟时会朗读）';

  @override
  String get group => '分组';

  @override
  String ringsForHeading(String span) {
    return '响铃 $span';
  }

  @override
  String useDefault(String value) {
    return '使用默认（$value）';
  }

  @override
  String get save => '保存';

  @override
  String get sameTime => '同一时间';

  @override
  String get untilYouStopIt => '直到你停止';

  @override
  String get alarm => '闹钟';

  @override
  String get once => '一次';

  @override
  String get everyDay => '每天';

  @override
  String get weekdays => '工作日';

  @override
  String get weekends => '周末';

  @override
  String timeInCity(String time, String city) {
    return '$city时间 $time';
  }

  @override
  String eventsMatching(String words) {
    return '含“$words”的事件';
  }

  @override
  String get everyEvent => '所有事件';

  @override
  String get sunrise => '日出';

  @override
  String havdalahEndOf(String day) {
    return '哈夫达拉 · $day结束';
  }

  @override
  String get yomTov => '节日';

  @override
  String get shabbat => '安息日';

  @override
  String get presetCountdown => '点蜡烛倒计时';

  @override
  String get presetHourly => '提前 6 小时起每小时一次';

  @override
  String get presetDailyWeek => '前一周每天一次';

  @override
  String get presetSecondNight => '第二晚的蜡烛';

  @override
  String get presetFridayReminder => '提前 3 小时提醒：给手机充电';

  @override
  String get presetFridayReminderLabel => '给手机充电并设置明天的闹钟';

  @override
  String get presetSunset => '日落，以及提前 15 分钟';

  @override
  String get pesach => '逾越节';

  @override
  String get shavuot => '七七节';

  @override
  String get roshHashanah => '犹太新年';

  @override
  String get yomKippur => '赎罪日';

  @override
  String get sukkot => '住棚节';

  @override
  String get sheminiAtzeret => '圣会节';

  @override
  String get simchatTorah => '妥拉节';

  @override
  String get readyNotifications => '显示闹钟';

  @override
  String get readyNotificationsWhy => '让闹钟界面和停止按钮能够显示。';

  @override
  String get readyFullScreen => '在锁屏上方响铃';

  @override
  String get readyFullScreenWhy => '即使手机已锁定，也会全屏显示闹钟。';

  @override
  String get readyExact => '准点响铃';

  @override
  String get readyExactWhy => '否则手机可能会把闹钟推迟几分钟。';

  @override
  String get readyBattery => '省电时保持运行';

  @override
  String get readyBatteryWhy => '防止省电功能在夜间让闹钟静音。';

  @override
  String get tipXiaomi => '小米手机：在 设置 › 应用 › Quando? 中开启自启动，并将省电策略设为无限制。';

  @override
  String get tipSamsung => '三星手机：在 设置 › 电池 › 后台使用限制 中确认 Quando? 未被设为休眠。';

  @override
  String get tipHuawei => '华为和荣耀手机：在 设置 › 电池 › 应用启动管理 中将 Quando? 设为手动管理并全部允许。';

  @override
  String get tipOther => '在这部手机上：在 设置 › 电池 中允许 Quando? 后台运行并关闭优化。';

  @override
  String get testRing => '测试响铃';

  @override
  String get testRingBody => 'Quando? 可以叫醒你';

  @override
  String get ringsIn20 => '20 秒后响铃。现在锁定手机并等待。';

  @override
  String get readyToRing => '响铃准备';

  @override
  String get checkingPhone => '正在检查手机…';

  @override
  String get phoneReady => '你的手机已准备好准时响起每个闹钟。';

  @override
  String thingsNeedFixing(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '有 $n 项需要修复，否则闹钟可能不会响。');
    return '$_temp0';
  }

  @override
  String get fix => '修复';

  @override
  String get testIn20 => '测试：20 秒后响铃';

  @override
  String get testIn20Hint => '锁定手机并放下。如果闹钟全屏响起，一切就绪。';

  @override
  String get readyToRingHint => '检查手机能否准时响起每个闹钟';

  @override
  String get connections => '连接';

  @override
  String get timeZoneHeading => '时区';

  @override
  String get followPhone => '跟随手机';

  @override
  String followPhoneNow(String city) {
    return '现在为$city。旅行时会自动更改。';
  }

  @override
  String get zoneFixed => '固定。旅行时闹钟也保持此时间。';

  @override
  String get shabbatCityHeading => '安息日所用城市';

  @override
  String get inIsraelOneDay => '在以色列（节日一天）';

  @override
  String candleMinutesHeading(int n) {
    return '蜡烛：日落前 $n 分钟';
  }

  @override
  String get endOfShabbatHeading => '安息日和节日结束';

  @override
  String get nightfallGeonim => '星出（Geonim，8.5°）';

  @override
  String get rabbeinuTam => '日落后 72 分钟（Rabbeinu Tam）';

  @override
  String get whenAlarmRingsHeading => '闹钟响起时';

  @override
  String get recordOrAddSounds => '录制或添加声音';

  @override
  String get ringsForThisLong => '响这么久，然后自动停止';

  @override
  String get sameFades => '所有闹钟使用相同淡入淡出';

  @override
  String get sameFadesOn => '替换每个闹钟的淡入淡出设置。音量各自保持。';

  @override
  String get sameFadesOff => '关闭：每个闹钟使用其音量设置中的淡入淡出。';

  @override
  String get sayItOutLoud => '大声朗读';

  @override
  String get sayItOutLoudHint => '朗读闹钟的用途，例如“点蜡烛，提前 15 分钟”';

  @override
  String get noSnooze => '不贪睡';

  @override
  String snoozeUpTo(int times, int minutes) {
    return '最多贪睡 $times 次，每次 $minutes 分钟';
  }

  @override
  String get wakeUpCheck => '起床确认';

  @override
  String get wakeUpCheckHint => '停止后，如果你没有点按“我起来了”，3 分钟后会再次响铃';

  @override
  String get solveSum => '解题后停止';

  @override
  String get provesAwake => '证明你醒了';

  @override
  String get shabbatNoTasks => '安息日和节日期间这些都不适用：闹钟会自动停止，也绝不会要求你触碰手机。';

  @override
  String get testAlarmIn1 => '1 分钟后响一个测试闹钟';

  @override
  String get timesDisclaimer => '时间在手机上计算。遇到临界情况，请咨询你的拉比或查看社区日历。';

  @override
  String get recommended => '推荐';

  @override
  String get chooseCity => '选择城市';

  @override
  String get testOnlyOnPhone => '测试闹钟仅在手机上可用。';

  @override
  String get testAlarm => '测试闹钟';

  @override
  String get testAlarmBody => '你的闹钟听起来就是这样';

  @override
  String get testAlarmIn1Set => '测试闹钟将在 1 分钟后响起。你可以锁定手机。';

  @override
  String get presetGone => '此模板已不存在。';

  @override
  String get editPreset => '编辑模板';

  @override
  String get on => '开启';

  @override
  String get ringsHeading => '响铃';

  @override
  String get noTimesYet => '还没有时间。请在下方添加。';

  @override
  String get atTheMomentItself => '恰好在那一刻';

  @override
  String get remove => '移除';

  @override
  String get addATime => '添加时间';

  @override
  String get resetPreset => '恢复原样';

  @override
  String get skipOneHint => '要跳过某一个闹钟，在主屏幕的“本周闹钟”中点按它。';

  @override
  String get unitMinutes => '分钟';

  @override
  String get unitHours => '小时';

  @override
  String get unitDays => '天';

  @override
  String get before => '之前';

  @override
  String get after => '之后';

  @override
  String get oneWeek => '1 周';

  @override
  String daysShort(int n) {
    return '$n 天';
  }

  @override
  String hoursShort(int n) {
    return '$n 小时';
  }

  @override
  String get howToSearch => '搜索方法';

  @override
  String get searchHelpWord => '标题包含“dentist”，不区分大小写';

  @override
  String get searchHelpStar => '* 代表任意字母：dentist、dentures';

  @override
  String get searchHelpQuestion => '? 代表一个字母：yoga、toga';

  @override
  String get searchHelpPhrase => '完全匹配此短语';

  @override
  String get searchHelpAnd => '两个词都有（AND）';

  @override
  String get searchHelpOr => '任意一个。| 也可以';

  @override
  String get searchHelpNot => '排除。NOT 和 ! 也可以';

  @override
  String get searchHelpBrackets => '括号用于组合词语';

  @override
  String get searchHelpEmpty => '留空则每个事件都响铃。';

  @override
  String get customTime => '其他时间';

  @override
  String get other => '其他';

  @override
  String get sun => '太阳';

  @override
  String get calendar => '日历';

  @override
  String get newEventAlarm => '新事件闹钟';

  @override
  String get eventAlarm => '事件闹钟';

  @override
  String get findEventsHeading => '查找事件';

  @override
  String get searchEventsHint => '搜索：牙医、健身 OR 瑜伽、牙*…';

  @override
  String get alsoBuiltInTimes => '也包括安息日、节日和日出日落时间';

  @override
  String get alsoBuiltInTimesHint => '例如“蜡烛*”、“哈夫达拉”、“日落”';

  @override
  String get allMyCalendars => '我的所有日历';

  @override
  String get connectToSearch => '连接日历后可在其中搜索';

  @override
  String get searching => '正在搜索…';

  @override
  String get nothingMatches60 => '未来 60 天内没有匹配项';

  @override
  String eventsIn60(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '未来 60 天内有 $n 个事件');
    return '$_temp0';
  }

  @override
  String nextRingsAt(String times, String title) {
    return '下一次：为“$title”在 $times 响铃';
  }

  @override
  String showMoreLeft(int n) {
    return '显示更多（还剩 $n 个）';
  }

  @override
  String get ringBeforeStartsHeading => '开始前响铃';

  @override
  String get ringWhenStarts => '开始时响铃';

  @override
  String get repeatBeforeHeading => '并在之前重复';

  @override
  String get everyPrefix => '每 ';

  @override
  String get offLower => '关';

  @override
  String get forInfix => '  持续 ';

  @override
  String get ringAfterEndsHeading => '结束后响铃';

  @override
  String get nameOptional => '名称（可选）';

  @override
  String get toppedUp => '闹钟已设好未来 7 天，每次打开 Quando? 都会补充。';

  @override
  String get back => '返回';

  @override
  String get next => '下一步';

  @override
  String get stepWhichEvents => '哪些事件';

  @override
  String get stepWhenToRing => '何时响铃';

  @override
  String get stepHowItRings => '如何响铃';

  @override
  String defaultNamed(String name) {
    return '默认（$name）';
  }

  @override
  String get phoneAlarmSound => '手机闹钟铃声';

  @override
  String get onlineRadio => '网络电台';

  @override
  String songLinkOpens(String app) {
    return '歌曲链接 · 打开 $app';
  }

  @override
  String get builtIn => '内置';

  @override
  String get yourRecording => '你的录音';

  @override
  String get sound => '声音';

  @override
  String get wakeToOwnSound => '用你自己的声音醒来';

  @override
  String get wakeToOwnSoundHint => '你的声音、一首歌、Spotify 或直播电台';

  @override
  String musicAdded(String name) {
    return '已添加 $name。可选作任何闹钟的声音。';
  }

  @override
  String get playlists => '歌单';

  @override
  String get likedSongs => '喜欢的歌曲';

  @override
  String get noPlaylists => '还没有歌单。';

  @override
  String get noLikedSongs => '还没有喜欢的歌曲。';

  @override
  String get needsMic => 'Quando? 需要麦克风才能录音。';

  @override
  String recordingN(int n) {
    return '录音 $n';
  }

  @override
  String couldNotAddFile(String error) {
    return '无法添加该文件：$error';
  }

  @override
  String get addSongLink => '添加歌曲链接';

  @override
  String get songLink => '歌曲链接';

  @override
  String get songLinkHowTo =>
      '在 Spotify、Apple Music、YouTube、YouTube Music 或 SoundCloud 中点按分享，再点复制链接，然后粘贴到这里。';

  @override
  String get songNameHint => '名称，例如 早晨歌单';

  @override
  String get whenAlarmGoesOffHeading => '闹钟响起时';

  @override
  String get playTheSong => '播放歌曲';

  @override
  String get ringThenOpen => '先响铃，再打开';

  @override
  String get playTheSongHint => '它的应用会打开并播放。如果 10 秒内没有声音，就会响起备用铃声，确保你能醒来。带任务的闹钟会先响铃，然后再打开。';

  @override
  String get ringThenOpenHint => '响起备用铃声。停止后在其应用中打开歌曲。';

  @override
  String get playForHeading => '播放时长';

  @override
  String get pausesAfter => '到时间后，Quando? 会用手机的暂停键暂停歌曲。';

  @override
  String get backupSoundHeading => '备用铃声';

  @override
  String get notALink => '这看起来不像链接。';

  @override
  String songOn(String app) {
    return '$app 上的歌曲';
  }

  @override
  String get theWeb => '网页';

  @override
  String get pickFromYouTube => '从我的 YouTube 选择';

  @override
  String get youTubeAndMusic => 'YouTube 和 YouTube Music';

  @override
  String get youTubeOn => '已连接 · 长按退出';

  @override
  String get youTubeSignIn => '使用 Google 登录';

  @override
  String get addSongLinkInstead => '请改为添加歌曲链接。';

  @override
  String get googleSignInFailed => 'Google 登录未完成。请重试。';

  @override
  String get myYouTube => '我的 YouTube';

  @override
  String get spotifyDirectOn => 'Spotify 直接播放已开启';

  @override
  String get spotifyDirect => 'Spotify 直接播放';

  @override
  String get spotifyDirectOnHint => '已开启 · 点按关闭';

  @override
  String get spotifyDirectHint => '播放指定歌曲。需要 Premium。';

  @override
  String get spotifyComingSoon => '即将推出 · 需要 Premium';

  @override
  String get spotifyFailed => 'Spotify 未能连接。请确认已安装 Spotify 应用、已登录并拥有 Premium。';

  @override
  String get nameThisSound => '为这个声音命名';

  @override
  String get sounds => '声音';

  @override
  String get soundsSentence => '用你自己的声音、一首歌、一个歌单或直播电台醒来。';

  @override
  String stopTimer(String time) {
    return '停止 · $time';
  }

  @override
  String get record => '录音';

  @override
  String get addAFile => '添加文件';

  @override
  String get addSongLinkLong => '添加歌曲链接（Spotify、Apple Music、YouTube…）';

  @override
  String get musicAppsHeading => '音乐应用';

  @override
  String get pickFromSpotify => '从我的 Spotify 选择';

  @override
  String get yourPlaylistsAndLiked => '你的歌单和喜欢的歌曲';

  @override
  String get mySpotify => '我的 Spotify';

  @override
  String get spotifySignInFailed => '无法登录 Spotify。';

  @override
  String get appleMusicNote => '登录功能将随 iPhone 版推出。目前请添加歌曲链接。';

  @override
  String noSignInNote(String service) {
    return '$service 不允许其他应用登录。请改为添加歌曲链接。';
  }

  @override
  String get wakeToRadio => '用网络电台醒来';

  @override
  String get soundsExplain => '录音最长 5 分钟,或添加文件、歌曲链接、在线电台。出错时会响起备用铃声。';

  @override
  String get yourSoundsHeading => '你的声音';

  @override
  String playsIn(String app) {
    return '在 $app 中播放';
  }

  @override
  String opensIn(String app) {
    return '在 $app 中打开';
  }

  @override
  String forSpan(String span) {
    return '持续 $span';
  }

  @override
  String get defaultLabel => '默认';

  @override
  String get radioUnreachable => '无法获取电台列表。请检查网络连接。';

  @override
  String get addStreamAddress => '添加流地址';

  @override
  String get notAStream => '这看起来不像流地址（以 http 开头）。';

  @override
  String get anyGenre => '所有类型';

  @override
  String get stationName => '电台名称';

  @override
  String get closeSearch => '关闭搜索';

  @override
  String get searchByName => '按名称搜索';

  @override
  String get anywhere => '所有地区';

  @override
  String get noStations => '未找到电台。试试其他类型或国家。';

  @override
  String wakeUpTo(String name) {
    return '用 $name 醒来';
  }

  @override
  String get notQuite => '差一点。再试一次。';

  @override
  String shabbatStopsItself(int n) {
    return '安息日模式：$n 秒后自动停止。无需触碰手机。';
  }

  @override
  String get solveToSnooze => '解题以贪睡';

  @override
  String get solveToStop => '解题以停止';

  @override
  String get answer => '答案';

  @override
  String get snooze => '贪睡';

  @override
  String get stop => '停止';

  @override
  String get shakeToSnooze => '摇动以贪睡';

  @override
  String get shakeToStop => '摇动以停止';

  @override
  String get shakeHard => '用力摇动手机，直到进度条填满。';

  @override
  String get cantShake => '无法摇动？改为解题';

  @override
  String get pairsToSnooze => '配对以贪睡';

  @override
  String get pairsToStop => '配对以停止';

  @override
  String get typeToSnooze => '输入以下内容以贪睡';

  @override
  String get typeToStop => '输入以下内容以停止';

  @override
  String get scanToSnooze => '扫描你的码以贪睡';

  @override
  String get scanToStop => '扫描你的码以停止';

  @override
  String ringAgainUnless(int n) {
    return '除非你点按下方，否则 $n 分钟后我会再次响铃。';
  }

  @override
  String get imUp => '我起来了';

  @override
  String snoozeMin(int n) {
    return '贪睡 $n 分钟';
  }

  @override
  String snoozeMinLeft(int n, int left) {
    return '贪睡 $n 分钟 · 还剩 $left 次';
  }

  @override
  String get noSnoozesLeft => '贪睡次数已用完';

  @override
  String get stopThenOpen => '停止 · 然后打开';

  @override
  String get startingSong => '正在启动你的歌曲';

  @override
  String wayToStop(String way) {
    return '$way以停止';
  }

  @override
  String wayToSnooze(String way) {
    return '$way以贪睡';
  }

  @override
  String ringsForMore(int n) {
    return '还会响 $n 秒';
  }

  @override
  String get leftToRing => '剩余';

  @override
  String get wayVolumeButtons => '音量键';

  @override
  String get wayShake => '摇动手机';

  @override
  String get taskNothing => '无';

  @override
  String get taskSum => '解一道题';

  @override
  String get taskShake => '摇动 30 次';

  @override
  String get taskMemory => '记忆游戏';

  @override
  String get taskPhrase => '输入一句话';

  @override
  String get taskScan => '扫描一个码';

  @override
  String get noLimit => '无限制';

  @override
  String upToTimes(int n) {
    return '最多 $n 次';
  }

  @override
  String shorterEachTime(int n) {
    return '每次缩短 $n 分钟';
  }

  @override
  String autoSnoozeAfter(int n) {
    return '$n 分钟后自动贪睡';
  }

  @override
  String get card => '卡片';

  @override
  String get hiddenCard => '背面朝上的卡片';

  @override
  String get phrase1 => '我醒了今天属于我';

  @override
  String get phrase2 => '此时不做更待何时';

  @override
  String get phrase3 => '早安给我和我爱的每个人';

  @override
  String get phrase4 => '我双脚着地已经起床';

  @override
  String get phrase5 => '今天我重新开始';

  @override
  String get notQuiteWords => '差一点，请检查每个字。';

  @override
  String get typeItHere => '在此输入';

  @override
  String get differentCode => '这是另一个码。';

  @override
  String get cameraUnavailable => '相机不可用。';

  @override
  String get cantScan => '无法扫描？改为解题';

  @override
  String get saveCodeToScan => '保存一个要扫描的码';

  @override
  String get saveCodeHint => '对准一个需要走过去才能找到的条形码或二维码，比如厨房里的盒子或浴室里的牙膏。要停止闹钟，你需要再扫描一次。';

  @override
  String get cameraUnavailableSettings => '相机不可用。请在设置中允许访问相机。';

  @override
  String gentleToGo(int n) {
    return '温和唤醒 · 还剩 $n 分钟';
  }

  @override
  String previewBody(String body) {
    return '试听 · $body';
  }

  @override
  String snoozedBody(String body) {
    return '已贪睡：$body';
  }

  @override
  String get areYouUp => '起来了吗？';

  @override
  String get tapImUp => '点按“我起来了”以停止';

  @override
  String get volume => '音量';

  @override
  String get wakeCheckOn => '起床确认已开启';

  @override
  String get stopsAtOnce => '立即停止';

  @override
  String get ringsAgainIfNotUp => '如果没起床会再次响铃';

  @override
  String get openAppAfter => '之后打开应用';

  @override
  String get noTask => '无任务';

  @override
  String get codeSaved => '码已保存';

  @override
  String get tapToSaveDifferent => '点按保存另一个';

  @override
  String get controlsHeading => '控制';

  @override
  String get onScreen => '屏幕上';

  @override
  String get taskHeading => '任务';

  @override
  String get none => '无';

  @override
  String get snoozeSentence => '再睡五分钟？选择多久、几次以及需要做什么。';

  @override
  String get settingsHeading => '设置';

  @override
  String get snoozeTime => '贪睡时长';

  @override
  String get snoozeTimeHint => '第一次贪睡的时长';

  @override
  String get shortenSnoozes => '缩短之后的贪睡';

  @override
  String get shortenSnoozesHint => '第一次之后的每次贪睡都缩短这么多';

  @override
  String get autoSnooze => '自动贪睡';

  @override
  String get autoSnoozeHint => '如果你没有触碰，会在此时间后自动贪睡';

  @override
  String get never => '从不';

  @override
  String get snoozeLimit => '贪睡次数上限';

  @override
  String get snoozeLimitHint => '你可以贪睡几次';

  @override
  String get unlimited => '无限制';

  @override
  String get useSnoozeFromSettings => '使用设置中的贪睡';

  @override
  String get stopSentence => '如何关闭闹钟，以及先要做什么。';

  @override
  String get shabbatNoTask => '安息日和节日期间闹钟会自动停止，绝不会要求完成任务。';

  @override
  String get volumeSentence => '响铃有多大声，以及如何柔和地达到那个音量。';

  @override
  String get openAfterAlarm => '闹钟后打开';

  @override
  String get pickAnApp => '选择应用';

  @override
  String get orPasteLink => '或粘贴链接：https://…';

  @override
  String get useThisLink => '使用此链接';

  @override
  String get noAppsFound => '未找到应用。';

  @override
  String get weather => '天气';

  @override
  String get news => '新闻';

  @override
  String get usePhoneVolume => '使用手机闹钟音量';

  @override
  String get setsPhoneVolume => '响铃时设置手机闹钟音量，之后恢复。';

  @override
  String get fadeInOff => '不淡入，立即全音量';

  @override
  String fadeInOver(String span) {
    return '$span内逐渐变大';
  }

  @override
  String get fadeOutOff => '不淡出';

  @override
  String fadeOutOver(String span) {
    return '最后 $span内逐渐变小';
  }

  @override
  String get fadesExplain => '淡出发生在闹钟自动停止时。如果淡入淡出比响铃时间长，两者都会缩短。';

  @override
  String get soundSoftChime => '柔和铃声';

  @override
  String get soundMorningRise => '晨光初现';

  @override
  String get soundClassicBeep => '经典哔声';

  @override
  String get calmCity => '宁静的城市清晨';

  @override
  String get calmBirds => '黎明鸟鸣';

  @override
  String get calmWaves => '海浪拍岸';

  @override
  String get calmRain => '细雨';

  @override
  String get calmStream => '林间小溪';

  @override
  String get calmWind => '微风';

  @override
  String get calmFire => '噼啪炉火';

  @override
  String get calmNight => '夏夜';

  @override
  String get publicDomain => '公共领域';

  @override
  String get phoneVolume => '手机音量';

  @override
  String fadesIn(String span) {
    return '$span内淡入';
  }

  @override
  String fadesOut(String span) {
    return '$span内淡出';
  }

  @override
  String get noFade => '无淡入淡出';

  @override
  String minSecShort(int m, int s) {
    return '$m 分 $s 秒';
  }

  @override
  String get happensRings => '响铃';

  @override
  String get happensStopped => '你停止了它';

  @override
  String get happensSnoozed => '你贪睡了';

  @override
  String get happensAutoStopped => '自动停止';

  @override
  String get eventLower => '事件';

  @override
  String get appTest => 'Quando? 测试';

  @override
  String get pushoverConnected => 'Pushover 已连接';

  @override
  String get webhookConnected => 'Webhook 已连接';

  @override
  String pushoverSaid(int code, String body) {
    return 'Pushover 返回 $code：$body';
  }

  @override
  String couldNotReachPushover(String error) {
    return '无法连接 Pushover（$error）';
  }

  @override
  String itAnswered(int code) {
    return '返回 $code';
  }

  @override
  String couldNotReachIt(String error) {
    return '无法连接（$error）';
  }

  @override
  String get calendarNotAllowed => '未获准访问日历。';

  @override
  String get playlist => '歌单';

  @override
  String songCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n 首歌');
    return '$_temp0';
  }

  @override
  String get spotifySaidNo => 'Spotify 拒绝了。在 Spotify 控制台中为 Quando? 勾选 Web API，并在 User Management 中添加你的帐号。';

  @override
  String serviceDidntAnswer(String service, int code) {
    return '$service 没有响应（$code）。';
  }

  @override
  String get youTubeSaidNo => 'YouTube 拒绝了。请确认你的 Google 帐号是 Quando 项目的测试用户。';

  @override
  String get event => '事件';

  @override
  String eventEnds(String title) {
    return '$title（结束）';
  }

  @override
  String foundSoundsDevices(int s, int d) {
    return '找到 $s 个声音和 $d 台设备。';
  }

  @override
  String get sentCheckDevices => '已发送。请查看你的其他设备。';

  @override
  String sentTo(String name) {
    return '已发送到 $name。';
  }

  @override
  String get zapierHowTo => '在 Zapier 中创建一个以“Webhooks by Zapier → Catch Hook”开头的 Zap，然后把它的 URL 粘贴到这里。';

  @override
  String get catchHookUrl => 'Catch Hook URL';

  @override
  String get iftttHowTo =>
      '在 IFTTT 中创建一个以“Webhooks → Receive a web request with a JSON payload”开头的小程序。在这里使用相同的事件名称。你的密钥在 ifttt.com/maker_webhooks/settings。';

  @override
  String get eventName => '事件名称';

  @override
  String get webhooksKey => 'Webhooks 密钥';

  @override
  String get webhookHowTo => 'Quando? 会向此地址发送 JSON POST。';

  @override
  String get connectionsSentence => '闹钟响起、停止或贪睡时，通知其他应用和设备。';

  @override
  String get pushWhenRings => '闹钟响起时发送通知';

  @override
  String get pushWhenRingsHint => '发送到你的其他手机、平板、手表或电脑';

  @override
  String get yourUserKey => '你的用户密钥';

  @override
  String get appToken => '应用令牌';

  @override
  String get soundAndDevicesHeading => '声音和设备';

  @override
  String get loading => '正在加载…';

  @override
  String get loadFromPushover => '从 Pushover 加载';

  @override
  String get soundItPlays => '播放的声音';

  @override
  String get myPushoverDefault => '我的 Pushover 默认';

  @override
  String get pushoverOwnSounds => '你上传到 pushover.net/sounds 的声音会显示在这里。';

  @override
  String get allMyDevices => '我的所有设备';

  @override
  String get pushoverOnThisPhone => '在这部手机上也安装 Pushover 应用，它就会在这里用你的 Pushover 声音响铃。';

  @override
  String get priority => '优先级';

  @override
  String get priorityNormal => '普通';

  @override
  String get priorityHigh => '高：无视免打扰时段';

  @override
  String get priorityEmergency => '紧急：重复直到确认';

  @override
  String get sending => '正在发送…';

  @override
  String get sendATest => '发送测试';

  @override
  String get findUserKey => '查找我的用户密钥';

  @override
  String get makeAppToken => '创建应用令牌';

  @override
  String get webhooksHeading => 'ZAPIER、IFTTT 和 WEBHOOK';

  @override
  String get webhooksExplain => '闹钟响起或你停止它时启动任何操作：开灯、记录起床时间、给某人发消息。';

  @override
  String get sendWhenAlarm => '闹钟以下情况时发送：';

  @override
  String get pauseOnShabbat => '安息日和节日暂停';

  @override
  String get pauseOnShabbatHint => '点蜡烛到哈夫达拉之间的闹钟不会发送任何内容';

  @override
  String get webhookPayloadNote =>
      '每条消息包含：event（ring、stopped、snoozed、auto_stopped）、title、body、time、shabbat 和 snoozes。密钥保存在这部手机上。';

  @override
  String get today => '今天';

  @override
  String get tomorrow => '明天';

  @override
  String get notAWebAddress => '这看起来不像以 https:// 开头的网址';

  @override
  String get language => '语言';

  @override
  String get phoneLanguage => '手机语言';

  @override
  String get ringQuote => '此时不做，更待何时？';

  @override
  String get ringQuoteBy => '希勒尔';

  @override
  String get quotesTitle => '关于时间的名言';

  @override
  String get quotesHint => '选择名言的来源。每个时段一句；轻点名言可换一句。';

  @override
  String get quotesOff => '关闭';

  @override
  String get quoteSongs => '歌曲';

  @override
  String get quoteMovies => '电影';

  @override
  String get quoteLiterature => '书籍与诗歌';

  @override
  String get quoteTanakh => '塔纳赫（希伯来圣经）';

  @override
  String get quoteSages => '塔木德与贤哲';

  @override
  String get quoteSpeeches => '著名演讲';

  @override
  String get quotePhilosophy => '哲学家';

  @override
  String get quoteProverbs => '谚语与俗语';

  @override
  String get quotesAlso => '同时显示';

  @override
  String get quoteCarnaval => '狂欢节';

  @override
  String get quoteCarnavalHint => '巴西狂欢节期间的歌曲与俗语';

  @override
  String get quoteNearMe => '我的附近';

  @override
  String get quoteNearMeHint => '根据你的时区和安息日城市，显示当地的诗人与节日';

  @override
  String get quoteSiddur => '祈祷书 (Siddur)';

  @override
  String weeklyParasha(String name) {
    return '本周经文 $name';
  }

  @override
  String poweredBy(String name) {
    return '由 $name 驱动';
  }

  @override
  String get syncTitle => '同步我的设备';

  @override
  String get syncHint => '用 Google 登录，让闹钟和设置在你所有设备上保持一致。';

  @override
  String syncOn(String email) {
    return 'On · $email';
  }

  @override
  String get syncWorking => 'Connecting…';

  @override
  String get syncNotAllowed => 'This Google account can\'t sync.';

  @override
  String get syncFailed => '无法连接。点按重试。';

  @override
  String get syncStop => 'Stop syncing';

  @override
  String get syncNotSetUp => '此版本尚未设置同步。';

  @override
  String get ringTheseAfterAll => '仍然响铃';

  @override
  String skipTheseDay(int n) {
    return '今天跳过这 $n 个';
  }

  @override
  String turnOffNamed(String name) {
    return '关闭“$name”';
  }

  @override
  String turnOnNamed(String name) {
    return '开启“$name”';
  }

  @override
  String turnedOffNamed(String name) {
    return '已关闭“$name”';
  }

  @override
  String removeTimeFrom(String time, String name) {
    return '从“$name”中移除“$time”';
  }

  @override
  String removedTimeFrom(String time, String name) {
    return '已从“$name”中移除“$time”';
  }

  @override
  String get moveToGroup => '移到分组';

  @override
  String inGroupMove(String group) {
    return '在“$group”中，移动';
  }

  @override
  String movedToGroup(String group) {
    return '已移到“$group”';
  }

  @override
  String deleteNamed(String name) {
    return '删除“$name”';
  }

  @override
  String get signInWithGoogle => '使用 Google 登录';

  @override
  String get signOut => 'Sign out';

  @override
  String get signInWithEmail => '使用邮箱登录';

  @override
  String get signIn => 'Sign in';

  @override
  String get createAccount => '创建账号';

  @override
  String get haveAccount => '我已有账号';

  @override
  String get forgotPassword => '忘记密码？';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get passwordResetSent => '我们已向你发送了设置新密码的链接。';

  @override
  String emailCheckInbox(String email) {
    return '我们已向 $email 发送了链接。打开链接后回到这里，点按“我已确认”。';
  }

  @override
  String get emailConfirmed => '我已确认';

  @override
  String get emailNotYet => '尚未确认。请先打开邮件中的链接。';

  @override
  String get emailSendAgain => '重新发送邮件';

  @override
  String get emailSentAgain => '已发送。请查看收件箱和垃圾邮件。';

  @override
  String get emailInvalid => '这看起来不像邮箱地址。';

  @override
  String get emailWrong => '邮箱或密码错误。';

  @override
  String get emailInUse => '这个邮箱已有账号。请直接登录；如果你是用 Google 创建的，请使用 Google 登录。';

  @override
  String get passwordWeak => '请设置至少 6 个字符的密码。';

  @override
  String get emailNotSwitchedOn => '邮箱登录尚未开启。';

  @override
  String get tooManyTries => '尝试次数过多。请等几分钟。';

  @override
  String get spotifyLibrary => 'Spotify';

  @override
  String get spotifyLibrarySignIn => '播放列表、喜欢的歌曲和搜索';

  @override
  String get spotifyLibraryOn => '已连接 · 长按退出';

  @override
  String spotifyLoginError(String reason) {
    return 'Spotify 登录失败：$reason';
  }

  @override
  String googleSignInError(String reason) {
    return 'Google 登录失败：$reason';
  }

  @override
  String get searchSongsHint => '搜索歌曲、艺人、歌单';

  @override
  String nothingFound(String query) {
    return '没有找到“$query”。';
  }

  @override
  String get deliveryTitle => '提醒方式';

  @override
  String get deliveryLocal => '本机音频';

  @override
  String get deliveryBoth => '两者';

  @override
  String get deliveryConnect => '连接 Pushover';

  @override
  String get deliveryLoadFailed => '无法加载声音和设备，请重试。';

  @override
  String get deliveryBothHint => '即使 Pushover 失败，本机仍会响铃。';

  @override
  String get deliveryPushHint => '仅用 Pushover。提醒触发时本设备必须联网。';

  @override
  String get deliveryFallback => 'Pushover 未连接或暂停时保留本机音频。';

  @override
  String get deliveryReset => '使用现有设置';

  @override
  String get beforeShabbat => '安息日之前';

  @override
  String get preparationReminders => '准备提醒';

  @override
  String get skipThisWeek => '跳过本周';

  @override
  String get restoreThisWeek => '恢复本周';

  @override
  String get allAlarms => 'All alarms';

  @override
  String get timesAndSound => '时间与声音';

  @override
  String get changeCity => 'Change city';

  @override
  String get useMyLocation => '使用我的位置';

  @override
  String get locationUnavailable => '位置暂时无法使用。请重试或选择一个城市。';

  @override
  String get locationReview => '确认此位置';

  @override
  String get locationDeviceOnly => '此位置仅保存在这台设备上。使用这些时间之前，请检查时区和以色列设置。';

  @override
  String timesIn(String city, String zone) {
    return '$city · $zone · 城市时间';
  }

  @override
  String get preparationOff => '准备提醒已关闭。哈夫达拉和普通闹钟不受影响。';

  @override
  String get preparationSkipped => '本周的准备提醒已跳过。你的每周设置仍会保留。';

  @override
  String get shabbatControls => '安息日控制';

  @override
  String get duringAfterShabbat => '安息日期间 / 之后';

  @override
  String locationCoordinates(String latitude, String longitude) {
    return '纬度 $latitude · 经度 $longitude';
  }

  @override
  String get currentLocation => '当前位置';

  @override
  String get testPushoverSound => '在 Pushover 上测试声音';

  @override
  String get pushoverSoundTestHint => '在你选择的 Pushover 设备上播放所选声音。静音和免打扰时段设置仍然有效。';

  @override
  String get pushoverShareDevices => '与我的设备共享凭据';

  @override
  String get pushoverShareHint => '你的 Pushover 用户密钥和应用令牌可以跟随你在 Quando? 和 Matai? 中登录的账号。';

  @override
  String get pushoverShareQueued => '凭据已排队，将发送到你已登录的设备。';

  @override
  String get pushoverShareSignIn => '在每台设备上登录同一个应用账号，即可共享 Pushover 凭据。';

  @override
  String get smartHomeHeading => 'Smart home';

  @override
  String get smartHomeHint => '直接运行 Tuya 场景，或连接你自己的 Home Assistant 或 Node-RED 自动化。';

  @override
  String get shareServices => '共享服务连接';

  @override
  String get shareServicesHint =>
      '在你的各台设备上使用同一个应用账号，即可共享 Pushover、Tuya、Spotify 资料库和自动化连接。YouTube 和设备权限可能仍需在每台设备上单独批准。';

  @override
  String get tuyaSetupHint =>
      '使用你已关联的 Tuya 开发者项目。输入其数据中心、Access ID、Access Secret，以及“Link App Account”下显示的 UID。无需 Home Assistant。';

  @override
  String get tuyaDataCenter => 'Data center';

  @override
  String get tuyaUserId => '已关联账号的 UID';

  @override
  String get tuyaAccessId => 'Access ID / Client ID';

  @override
  String get tuyaAccessSecret => 'Access Secret / Client Secret';

  @override
  String get tuyaLoadScenes => 'Load scenes';

  @override
  String get tuyaNoScenes => '未找到可用的 Tap-to-Run 场景。请检查已关联的账号、数据中心和场景 API 权限。';

  @override
  String get tuyaRunNow => '立即运行场景';

  @override
  String get tuyaRunConfirm => '现在在你的 Tuya 设备上运行此场景吗？';

  @override
  String get tuyaSent => 'Tuya 已接受场景指令。请检查你的设备。';

  @override
  String get tuyaFailed => 'Tuya 无法完成该请求。请检查项目权限、数据中心和订阅。错误：';

  @override
  String get tuyaAlarmScene => '此闹钟响起时的 Tuya 场景';

  @override
  String get homeAssistantHowTo =>
      '创建一个使用 Webhook 触发器的 Home Assistant 自动化，接受 POST 和 JSON，并在此粘贴其 URL。用闹钟事件（ring、stopped、snoozed 或 auto_stopped）来选择你的动作。新设备上此连接默认关闭。';

  @override
  String get nodeRedHowTo =>
      '使用接受 POST 的 Node-RED HTTP In 节点，后接你的自动化和一个 HTTP Response 节点。在此粘贴端点。支持本地 HTTP 中枢和 HTTPS 端点。';

  @override
  String get smartHomeConnect => '连接智能家居服务';

  @override
  String get automationTestHint => '测试会立即运行已连接的自动化。';

  @override
  String get smartHomeDeviceOn => '在此设备上运行智能家居闹钟动作';

  @override
  String get smartHomeDeviceHint => '选择一台设备来运行你的自动化。连接是共享的；此开关只对这台设备生效。';

  @override
  String get smartHomeDeviceOff => '此设备上的闹钟动作已关闭。请在“连接”中开启；手动场景测试仍可使用。';

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
  String get weatherSwipeHint => '在天空和天气之间滑动';

  @override
  String get parashaHeading => '每周经文段落';

  @override
  String get dailyStudyHeading => '每日学习';

  @override
  String get courseDaf => 'Daf Yomi';

  @override
  String get courseRambam1 => 'Rambam · 每天 1 章';

  @override
  String get courseRambam3 => 'Rambam · 每天 3 章';

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
  String get moonAlwaysUp => '月亮整天在地平线上方';

  @override
  String get moonAlwaysDown => '月亮整天在地平线下方';

  @override
  String get noRiseToday => '今天没有月出';

  @override
  String get noSetToday => 'No set today';

  @override
  String get moonNew => 'New moon';

  @override
  String get moonWaxingCrescent => '蛾眉月（渐盈）';

  @override
  String get moonFirstQuarter => '上弦月';

  @override
  String get moonWaxingGibbous => '盈凸月';

  @override
  String get moonFull => 'Full moon';

  @override
  String get moonWaningGibbous => '亏凸月';

  @override
  String get moonLastQuarter => 'Last quarter';

  @override
  String get moonWaningCrescent => '残月（渐亏）';

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
  String get weatherThunder => '雷暴';

  @override
  String get weatherUnavailable => '天气暂时无法使用';

  @override
  String get weatherCached => '已保存的预报';

  @override
  String get weatherUpdated => 'Updated';

  @override
  String get weatherForecast => 'Forecast';

  @override
  String get weatherThunderExpected => '预报有雷暴';

  @override
  String get learningUnavailable => '连接以加载本月的学习安排';

  @override
  String get festivalReading => '节日托拉诵读';

  @override
  String get learningCalendarSource => '学习日历 · Hebcal · CC BY 4.0';

  @override
  String get weatherSource => '天气预报 · MET Norway · CC BY 4.0';

  @override
  String get weatherConsent => '所选城市的天气。使用取整后的坐标，通过 MET Norway 获取。';

  @override
  String get learningConsent => 'Rambam 等学习日程从 Hebcal 加载，并保存以供离线使用。';

  @override
  String get homeRefresh => 'Refresh';

  @override
  String get skyTimezone => 'My timezone';

  @override
  String get skyShabbat => 'Shabbat city';

  @override
  String get skyReferenceCity => '时区参考城市';

  @override
  String get skyChooseCity => '选择天空城市';

  @override
  String get skyCityExplain => '太阳和月亮使用这个城市的坐标。你的安息日城市和闹钟时区保持你的选择不变。';

  @override
  String get skySun => 'Sun today';

  @override
  String get skyMoon => 'Moon today';

  @override
  String get moonAboveHorizon => '月亮在地平线上方';

  @override
  String get moonBelowHorizon => '月亮在地平线下方';

  @override
  String get moonNextNew => '下次新月';

  @override
  String get moonNextFull => '下次满月';

  @override
  String get locationServicesOff => '定位服务已关闭。请在“设置”中开启，或选择一个城市。';

  @override
  String get locationDenied => '定位权限被拒绝。请在“设置”中允许，或选择一个城市。';

  @override
  String get locationTimedOut => '暂未获取到位置。在 Mac 上请保持 Wi-Fi 开启后重试，或选择一个城市。';

  @override
  String get locationTimeZoneUnavailable => '使用位置之前，请选择所选时区内的城市，或跟随设备时区。';

  @override
  String get locationSettings => '打开定位设置';

  @override
  String get locationLooking => '正在获取位置…';

  @override
  String get skyMoonDisplay => '显示月亮：月出、月落和月相';

  @override
  String get tuyaConsumerPending => '此版本暂不支持账号登录。如果你已有 Tuya 开发者项目，请使用高级设置。';

  @override
  String get tuyaAdvanced => '高级设置';

  @override
  String get tuyaSignInTitle => '使用 Smart Life 账号登录';

  @override
  String get tuyaSignInHint =>
      '请使用与 Smart Life 或 Tuya Smart 应用相同的国家、邮箱或手机号和密码。该账号必须已关联到你的 Tuya 项目。密码只会发送给 Tuya，不会被保存。';

  @override
  String get tuyaCountryCode => '国家区号（巴西 55，美国 1）';

  @override
  String get tuyaAccount => 'Smart Life 邮箱或手机号';

  @override
  String get tuyaPassword => 'Smart Life 密码';

  @override
  String get tuyaSignIn => '登录并加载场景';

  @override
  String get tuyaRelayUrl => 'Quando Tuya 中继地址（https）';

  @override
  String get tuyaRelayHint =>
      '请使用你的 Smart Life 或 Tuya Smart 账号的国家、邮箱或手机号和密码。它们只会发送一次到 Quando 的 Tuya 中继，不会被保存。你需要先登录 Quando 账号。';

  @override
  String get tuyaGoogleHint => '用 Google 或 Apple 登录 Smart Life？在 Smart Life 中点按“忘记密码”设置一个密码，然后在这里使用。';

  @override
  String get tuyaLinked => 'Smart Life 账号已关联';

  @override
  String get tuyaUnlink => '取消关联';

  @override
  String get tuyaNeedsAccount => '请先在设置中登录你的 Quando 账号。';

  @override
  String get roshHodeshHeading => 'Rosh Hodesh';

  @override
  String get roshHodeshExplain => '在主页显示下一个希伯来月的第一天或前两天。';

  @override
  String get roshHodeshNext => '下一个新月（Rosh Hodesh）';

  @override
  String get roshHodeshBegins => '日落时开始：';

  @override
  String get openParashaSefaria => '在 Sefaria 上阅读此托拉经文';

  @override
  String get skyMyLocation => 'My location';

  @override
  String get skyLocationLocalTimes => '天空时间使用此位置的时区。你的闹钟时区和安息日城市保持不变。仅保存在这台设备上。';

  @override
  String get musicRingDurationHint => '播放遵循此闹钟的响铃时长，并在停止或稍后提醒时结束。';

  @override
  String get musicBackupPlaying => '无法开始播放音乐。正在播放本地闹钟声音。';

  @override
  String desktopMusicConnect(String service) {
    return '连接 $service 应用';
  }

  @override
  String desktopMusicOn(String service) {
    return '已连接 $service · 长按断开';
  }

  @override
  String get musicSongs => '歌曲';

  @override
  String get noMusicSongs => '在音乐资料库中未找到歌曲。';

  @override
  String serviceConnectUnavailable(String service) {
    return '添加 $service 链接 · 闹钟停止后打开';
  }

  @override
  String get soundCloudWidgetNote => '添加公开链接';

  @override
  String get youtubePlayerHint => 'YouTube在可见播放器中播放视频。播放器隐藏或无法播放时，本地闹钟会继续响铃。';

  @override
  String get musicPreviewFailed => '无法播放此声音。请检查连接或尝试其他歌曲或电台。';

  @override
  String get skyMoonPhase => '月相';

  @override
  String get skyMoonDetailsDisplay => '添加月相页面';

  @override
  String get skyMoonDetailsHint => '滑动到该页面，或随时轻点月亮卡片';

  @override
  String get moonRises => '月出';

  @override
  String get moonSets => '月落';

  @override
  String moonLunarDay(int day) {
    return '本朔望月 29.5 天中的第 $day 天';
  }

  @override
  String get moonDetailsOpen => '打开月相';

  @override
  String get musicPlaylists => '音乐播放列表';

  @override
  String get videoPlaylists => '视频播放列表';

  @override
  String get likedVideos => '喜欢的视频';

  @override
  String get wholePlaylist => '用整个播放列表唤醒';

  @override
  String get noSongsInPlaylist => '这里没有可播放的歌曲。';

  @override
  String get hebrewNamesHeading => '诵读段与月份名称的拼写';

  @override
  String get hebrewNamesIsraeli => '以色列式';

  @override
  String get hebrewNamesAshkenazi => '阿什肯纳兹式';

  @override
  String pickFromService(String service) {
    return '从我的 $service 选择';
  }

  @override
  String get weatherTonight => '今晚';

  @override
  String get weatherTomorrowMorning => '明天早上';

  @override
  String weatherUntilAbout(String time) {
    return '持续到约 $time';
  }

  @override
  String get weatherSunBehindClouds => '太阳在云后';

  @override
  String get keysLockTitle => '设备间的密钥';

  @override
  String get keysLockOff => '你的服务密钥只保存在这台设备上。设置同步口令后，可以加密发送到你的其他设备。';

  @override
  String get keysLockOn => '你的服务密钥在离开这台设备前会用同步口令加密。其他任何人，包括 Google，都无法读取。';

  @override
  String get keysLockWaiting => '来自你另一台设备的密钥已到达，但处于锁定状态。输入同步口令即可打开。';

  @override
  String get keysSetPassphrase => '设置口令';

  @override
  String get keysChangePassphrase => '更改口令';

  @override
  String get keysUnlock => '解锁密钥';

  @override
  String get keysStartOver => '忘记了？重新开始';

  @override
  String get keysStartOverHint => '重新开始会用新口令发送这台设备的密钥。你的其他设备会要求输入新口令。';

  @override
  String get keysPassphrase => '同步口令';

  @override
  String get keysPassphraseAgain => '再输入一次';

  @override
  String keysPassphraseShort(int count) {
    return '至少使用 $count 个字符。';
  }

  @override
  String get keysPassphraseMismatch => '两次输入不一致。';

  @override
  String get keysPassphraseWrong => '这个口令打不开这些密钥。';

  @override
  String get keysPassphraseNote => '请记下来：如果忘记，没有人能找回，你需要重新输入密钥。';

  @override
  String get keysShareNeedsPassphrase => '请先在“设备间的密钥”中设置同步口令。';

  @override
  String get settingsAlarmDefaults => '闹钟默认设置';

  @override
  String get settingsPlacesTime => '地点与时间';

  @override
  String get settingsLook => '外观、语言与名言';

  @override
  String get settingsAbout => 'About';

  @override
  String get defaultForNewAlarms => '新闹钟的默认设置';

  @override
  String get preview => 'Preview';

  @override
  String atClock(String time) {
    return 'at $time';
  }

  @override
  String get connectACalendar => '连接日历';

  @override
  String get newFromReadyMade => '从现成闹钟中选';

  @override
  String get newFromReadyMadeHint => '日出、日落以及其他已为你设置好的闹钟';

  @override
  String get calendarSourcesIntro => 'Quando? 可以在日历活动前后响铃。选择活动来自哪里。';

  @override
  String get deviceCalendarsHeading => '此设备';

  @override
  String get deviceCalendarsTitle => '此设备的日历应用';

  @override
  String get deviceCalendarsHint => '设备上的所有账户：Google、Samsung、Outlook、iCloud，以及只存在这里的日历。';

  @override
  String get googleCalendarHeading => 'GOOGLE 日历';

  @override
  String get googleCalendarSignIn => '使用 Google 登录，直接从 Google 读取日历，即使此设备上没有你的 Google 账户。';

  @override
  String googleCalendarSignedIn(String email) {
    return '已登录：$email';
  }

  @override
  String get googleCalendarSignOut => '退出登录';

  @override
  String get googleCalendarNotHere => '此设备暂不支持 Google 登录。请在设备设置（日历 › 账户）中添加 Google 账户，其日历会显示在此设备下。';

  @override
  String get googleCalendarUnreachable => '现在无法连接 Google 日历。已根据它设置的闹钟仍会响。';

  @override
  String get googleCalendarTwiceHint => '此设备已显示的同一 Google 账户的日历默认关闭，避免重复响铃。';

  @override
  String get timersTitle => '计时器';

  @override
  String get timerStopwatch => '秒表';

  @override
  String get timerCountdown => '倒计时';

  @override
  String get timerSequence => '预备';

  @override
  String get timerStopwatchSub => '正计时，带分圈';

  @override
  String get timerCountdownSub => '倒计时，到零时响铃';

  @override
  String get timerSequenceSub => '语音起跑与标记';

  @override
  String get timerStart => '开始';

  @override
  String get timerPause => '暂停';

  @override
  String get timerResume => '继续';

  @override
  String get timerReset => '重置';

  @override
  String get timerLap => '分圈';

  @override
  String get timerTimesUp => '时间到';

  @override
  String get timerSetTime => '设置时间';

  @override
  String get timerMinutes => '分钟';

  @override
  String get timerSeconds => '秒';

  @override
  String get seqOnYourMarks => '各就各位';

  @override
  String get seqGetSet => '预备';

  @override
  String get seqGo => '跑！';

  @override
  String get seqFinish => '时间到！';

  @override
  String get seqReady => '就绪';

  @override
  String get seqSettings => '设置';

  @override
  String get seqStartCalls => '起跑前的口令';

  @override
  String get seqStartCallsHelp => '在“跑”之前大声说出，从起点倒数。';

  @override
  String seqCallBefore(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '提前 $n 秒');
    return '$_temp0';
  }

  @override
  String get seqAddCall => '添加口令';

  @override
  String get seqCallText => '说什么';

  @override
  String get seqGoText => '开始时说';

  @override
  String get seqFinishText => '结束时说';

  @override
  String get seqLength => '时长';

  @override
  String get seqNoLimit => '无限制';

  @override
  String get seqSayEvery => '每隔多久报时';

  @override
  String get seqOff => '关闭';

  @override
  String seqEverySeconds(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n 秒');
    return '$_temp0';
  }

  @override
  String seqEveryMinutes(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n 分钟');
    return '$_temp0';
  }

  @override
  String get seqFinalCount => '最后倒数';

  @override
  String get seqMarks => '你的标记';

  @override
  String get seqAddMark => '添加标记';

  @override
  String seqMarkAt(String time) {
    return '在 $time';
  }

  @override
  String get seqSpeak => '朗读';

  @override
  String get seqBeeps => '提示音和振动';

  @override
  String get seqSayRemaining => '报告剩余时间，而非已用时间';

  @override
  String get seqPresets => '预设';

  @override
  String get seqPresetRace => '比赛起跑';

  @override
  String get seqPresetSprint => '30 秒冲刺';

  @override
  String get seqPresetRound => '1 分钟一轮';

  @override
  String get seqHintNoLimit => '“跑”之后一直正计时，直到你停止。';

  @override
  String get seqHintLength => '“跑”之后倒数到零。';

  @override
  String get seqWords => '词语';

  @override
  String get homeEdit => 'Arrange home';

  @override
  String get homeEditHint => '拖动手柄可移动卡片、折叠卡片或调整卡片大小。';

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
  String get homeBlockSky => '太阳、月亮和天气';

  @override
  String get homeBlockQuick => 'QUICK ALARMS';

  @override
  String get homeBlockShabbat => '安息日与节日';

  @override
  String get homePlaceTitle => '天空城市';

  @override
  String nextAlarmLine(String title, String time) {
    return '下一个闹钟 · $title $time';
  }

  @override
  String get showAllAlarms => '显示所有日期';

  @override
  String get noAlarmsThatDay => '这一天没有闹钟响铃';

  @override
  String get homeClockSize => '主屏幕时钟';

  @override
  String get sizeSmall => '小';

  @override
  String get sizeMedium => '中';

  @override
  String get sizeLarge => '大';

  @override
  String get homeLayout => '主屏布局';

  @override
  String get homeLayoutClassic => '经典';

  @override
  String get homeLayoutCards => '卡片';

  @override
  String get homeCardsHint => '拖动卡片即可移动。拖动边缘或角落调整大小，或选择尺寸。';

  @override
  String get homeAddCard => '添加卡片';

  @override
  String get homeOnHome => '已在主屏';

  @override
  String get homeRemoveCard => '移除';

  @override
  String get cardNext => '下一个闹钟';

  @override
  String get cardClock => '时钟和日期';

  @override
  String get cardSky => '太阳、月亮和天气';

  @override
  String get cardMoon => '月亮';

  @override
  String get cardWeather => '天气';

  @override
  String get cardAlarms => '你的闹钟';

  @override
  String get cardQuick => '快速闹钟';

  @override
  String get cardTools => '秒表、倒计时和预备';

  @override
  String get cardWorld => '世界时钟';

  @override
  String get cardWeek => '本周';

  @override
  String get cardShabbat => '安息日和节日';

  @override
  String get ringAtEventReminders => '在日程自带的提醒时间响铃';

  @override
  String get ringAtEventRemindersHint => '日历应用里设置的提醒会在这里以本闹钟的铃声大声响起。';

  @override
  String get atEventReminders => '在日程提醒时';

  @override
  String get everyEventReminderLoud => '每个日程提醒时都大声响铃';

  @override
  String get loudNotificationsHeading => '日历通知大声响';

  @override
  String get loudNotificationsTitle => '让日历通知大声响铃';

  @override
  String get loudNotificationsHint => '日历应用弹出提醒时，Quando? 会把它当作闹钟响起，即使手机处于静音。';

  @override
  String get loudNotificationsDisclosureTitle => '允许 Quando? 读取日历通知？';

  @override
  String get loudNotificationsDisclosure =>
      '要大声响起日历提醒，Quando? 需要通知使用权。它只查看你所选日历应用的通知，在本机读取标题和内容以显示在闹钟上，从不保存或发送到任何地方。你可以随时关闭。';

  @override
  String get loudNotificationsAgree => '同意并继续';

  @override
  String get loudNotificationsNoAccess => '通知使用权已关闭。请在打开的列表中开启 Quando?。';

  @override
  String get loudNotificationsAllow => '允许';

  @override
  String get loudNotificationsNoApps => '本机未找到支持的日历应用。';

  @override
  String get loudNotificationsTwiceNote => '已有 Quando? 日历闹钟的日程只会响一次。';

  @override
  String get loudNotificationsShabbatNote => '安息日和节日期间静音。';

  @override
  String get busyMode => '忙碌模式';

  @override
  String get busyModeSubtitle => '忙碌时开启勿扰和自动回复';

  @override
  String get busyIntro => '忙碌时，Quando? 可以让手机安静并替你回复消息。闹钟照常响。';

  @override
  String get busyIosFocus =>
      '在 iPhone 和 iPad 上，应用无法开启专注模式或回复消息。请在“快捷指令”App 中添加“打开 Quando? 时”或定时开启专注模式的自动化，并在专注模式中设置自动回复。';

  @override
  String get busyWhileHeading => '忙碌时';

  @override
  String get busyDnd => '勿扰';

  @override
  String get busyDndHint => '仅限优先：来电和消息静音，闹钟照响。结束后恢复。';

  @override
  String get busyDndNoAccess => 'Quando? 还没有更改勿扰的权限。';

  @override
  String get busyReplies => '回复消息';

  @override
  String get busyRepliesHint => '每人一次，用你的文字，通过应用自带的回复按钮。仅限 Android。';

  @override
  String get busyRepliesDisclosureTitle => '允许 Quando? 回复消息？';

  @override
  String get busyRepliesDisclosure =>
      '为了替你回复，Quando? 需要通知使用权。仅在你忙碌时，它查看你所选应用的消息通知，在本机读取发送者名字，并通过应用自带的回复按钮发送一次你的文字。消息从不保存，也不会发往别处。除非你允许，群聊会被跳过。';

  @override
  String get busyReplyText => '你的回复';

  @override
  String busyReplyTextHint(String until) {
    return '$until 会变成忙碌模式结束的时间。';
  }

  @override
  String busyReplyDefault(String until) {
    return '我现在在忙，$until 后回复。';
  }

  @override
  String get busyGroups => '群聊也回复';

  @override
  String get busyGroupsHint => '关闭：从不回复群聊。';

  @override
  String get busyRepliesOnShabbat => '安息日和节日也回复';

  @override
  String get busyAskRabbi => '默认关闭。在安息日开启前请先请教你的拉比。';

  @override
  String get busyWhenHeading => '何时忙碌';

  @override
  String get busyWhenHint => '在日历闹钟上开启“这些日程期间忙碌”，或在闹钟上开启“响铃后忙碌”。';

  @override
  String get busyDuringLock => '锁定模式开启时忙碌';

  @override
  String get busyNoneComing => '未来 7 天没有忙碌时段。';

  @override
  String get busyDuringEvents => '这些日程期间忙碌';

  @override
  String get busyDuringEventsHint => '每个日程从开始到结束都处于忙碌模式。';

  @override
  String get busySettings => '忙碌模式设置';

  @override
  String get busyAfterRing => '响铃后忙碌';

  @override
  String get busyAfterRingHint => '一段时间内勿扰和自动回复，例如锻炼或午睡。';

  @override
  String get shareCard => '分享你的早晨';

  @override
  String get shareCardSubtitle => '今天的天空和名言，或你自己的照片，用于快拍和状态';

  @override
  String get shareAppMissing => '这台手机上没有该应用。';

  @override
  String get shareAsIs => '按原样分享';

  @override
  String get shareTapQuote => '点按名言可换一句。';

  @override
  String get shareStory => '快拍';

  @override
  String get shareSquare => '方形';

  @override
  String get shareYourWords => '你自己的话（可选）';

  @override
  String get shareYourWordsHint => '代替今天的名言';

  @override
  String get shareYourPhoto => '你的照片';

  @override
  String get shareOtherPhoto => '换一张照片';

  @override
  String get shareSkyBack => '改用今天的天空';

  @override
  String get shareYourVideo => '你的视频';

  @override
  String get shareInstagramStory => 'Instagram 快拍';

  @override
  String get shareWhatsApp => 'WhatsApp：状态或聊天';

  @override
  String get shareMore => '更多应用';

  @override
  String get shareYouPost => 'Quando? 会打开应用并载入你的卡片。发到哪里由你选，发布也由你点。';

  @override
  String get shareAndroidFirst => 'iPhone 和 iPad 即将支持分享。';

  @override
  String songSaved(String name) {
    return '已将“$name”存为闹钟铃声';
  }

  @override
  String get shareToQuando => '把歌曲分享到 Quando?';

  @override
  String get shareToQuandoHint =>
      '在 YouTube、YouTube Music、Spotify、SoundCloud 或 Apple Music 中点“分享”，再选 Quando?，它就成为在原应用中播放的闹钟铃声。';

  @override
  String get askOption => '说出或输入';

  @override
  String get askOptionHint => '“明天6点”“日出前30分钟”';

  @override
  String get askHint => '例如：工作日日出前30分钟叫醒我';

  @override
  String get askListening => '正在听…';

  @override
  String get askNotUnderstood => '没有找到时间。试试“工作日早上7点”或“20分钟后”。';

  @override
  String askAnswerFromCalendar(String name) {
    return '来自你的日历“$name”';
  }

  @override
  String get askAnswerBuiltIn => 'Quando? 为你所在城市计算的时间';

  @override
  String get askNoAnswer => '还没有找到时间。';

  @override
  String get askNoSpeech => '此设备不支持语音。你可以输入。';

  @override
  String get askShabbatOff => '在设置中打开安息日，安息日时间才会响铃。';

  @override
  String askSaved(String what) {
    return '已保存：$what';
  }

  @override
  String get askMic => '说话';

  @override
  String get askMorning => '早上';

  @override
  String get askEvening => '晚上';

  @override
  String get askUnsure => '我可能漏掉了一部分。保存前请检查。';

  @override
  String get askTeach => '教我这个';

  @override
  String askTaught(String phrase, String time) {
    return '明白了：“$phrase”现在表示 $time。';
  }

  @override
  String get askSkipAction => '跳过';

  @override
  String get askNoMatch => '没有匹配的闹钟。';

  @override
  String askTurnedOff(String what) {
    return '已关闭：$what';
  }

  @override
  String askSkipped(String what) {
    return '已跳过：$what';
  }

  @override
  String askEventPlan(String offset, String event) {
    return '日历中“$event”$offset';
  }

  @override
  String askEventNoCalendar(String event) {
    return '连接日历，Quando? 才能找到“$event”。';
  }

  @override
  String askSnoozeAll(int minutes) {
    return '贪睡：$minutes 分钟，仅适用于这个闹钟';
  }

  @override
  String askWakeWith(String sound) {
    return '用$sound叫醒你';
  }

  @override
  String get askReadAs => '理解为';

  @override
  String get askHelpTitle => '帮助改进语音闹钟';

  @override
  String get askHelpBody => '匿名发送你说的或输入的内容以及你的操作。不含账号或设备 ID。';

  @override
  String get askHelpPromptTitle => '帮助 Quando? 更懂你？';

  @override
  String askHelpPromptBody(String sentence) {
    return '我们会匿名发送你说的或输入的内容（如“$sentence”）以及你是否保存。不含姓名、账号或设备 ID。你可以随时关闭。';
  }

  @override
  String get askHelpYes => '好，帮忙';

  @override
  String get askHelpNo => '不用了';

  @override
  String get askQuoteTranslation => '生活不是人们所经历的，而是人们所记住的，以及为了讲述而如何记住它。';

  @override
  String get askHelpQuote => '';
  String get quickSetups => '快速设置';

  @override
  String get qsMorningTitle => '管用的早晨';

  @override
  String get qsStartTitle => '不错过任何开始';

  @override
  String get qsStretchTitle => '分段工作';

  @override
  String get qsWillChange => '将更改的内容';

  @override
  String get qsAlreadyOn => '已开启，无需更改。';

  @override
  String get qsApply => '应用';

  @override
  String get qsDone => '完成';

  @override
  String get qsUndo => '撤销';

  @override
  String get qsSnoozeTimes => '允许的贪睡次数';

  @override
  String get qsSnoozeMinutes => '贪睡分钟数';

  @override
  String get qsFiveLeft => '还剩5分钟';

  @override
  String get syncHeading => '日历变化时';

  @override
  String get syncLive => '跟随日历';

  @override
  String get syncLiveHint => '新日程会有闹钟。日程改时间，闹钟跟着改；日程删除，闹钟也删除。';

  @override
  String get syncKeepFirst => '保持最初看到的样子';

  @override
  String get syncKeepFirstHint => '新日程仍会有闹钟。闹钟一旦设好就不变，即使日程改时间或被删除。';

  @override
  String get syncSnapshot => '只要现在已有的日程';

  @override
  String get syncSnapshotHint => '只取保存时日历里已有的日程，保持现在的样子。之后不再添加新的。';

  @override
  String get syncHelpButton => '如何运作';

  @override
  String get syncHelpTitle => '闹钟如何跟随你的日历';

  @override
  String get syncHelpIntro => '这条规则会一直寻找符合搜索的日程。日历变化时怎么做，由你选择。';

  @override
  String get syncHelpExampleLive => '例子：一条“牙医”规则。牙医把周二的预约改到周三，你的闹钟也改到周三。预约取消，闹钟也随之消失。';

  @override
  String get syncHelpExampleKeepFirst => '同一规则：预约改到周三，但闹钟仍留在周二，保持 Quando? 最初看到的样子。下个月的新预约仍会有自己的闹钟。';

  @override
  String get syncHelpExampleSnapshot => '同一规则：今天日历里已有的预约会有闹钟，并保持不变。下个月新加的预约不会有闹钟。';

  @override
  String get syncHelpTip => '拿不准？就保留“跟随日历”。';

  @override
  String get syncHelpWhenTitle => 'Quando? 何时发现变化？';

  @override
  String get syncHelpWhenOpen => 'Quando? 打开时：几秒内。在这里登录的 Google 日历每 2 分钟检查一次。';

  @override
  String get syncHelpWhenClosed => 'Quando? 关闭时：下次打开时。在那之前，已设好的闹钟按原来的时间响。';

  @override
  String get syncHelpWhenClosedApple => 'iPhone 和 iPad 不允许应用在后台监视日历，所以变化会在打开 Quando? 时同步。';

  @override
  String get tapMiddleToStop => '点按中间即可停止';

  @override
  String get uiSimple => '简洁';

  @override
  String get uiEverything => '全部';

  @override
  String get firstRunTitle => '你想看到多少？';

  @override
  String get firstRunSimpleHint => '闹钟和基本功能';

  @override
  String get firstRunEverythingHint => '日历、安息日、计时器、天气等';

  @override
  String get firstRunChangeLater => '你可以随时在设置中更改。';

  @override
  String get continueLabel => '继续';

  @override
  String get everyAlarm => '每个闹钟';

  @override
  String get wakeMeWith => '唤醒方式';

  @override
  String get ringOrMusic => '铃声或音乐';

  @override
  String get ringsForRow => '响铃时长';

  @override
  String gentleBeforeValue(int minutes) {
    return '提前$minutes分钟';
  }

  @override
  String get quandoSounds => 'Quando? 铃声';

  @override
  String get aSongApps => '一首歌（Spotify、YouTube…）';

  @override
  String get myRecording => '我的录音';

  @override
  String get useForNewAlarms => '用于新闹钟';

  @override
  String get iWillLabel => '闹钟响时，我要…';

  @override
  String get foldVolume => '音量与渐变';

  @override
  String get foldSnoozeStop => '贪睡与停止';

  @override
  String get foldExtras => '日历和其他';

  @override
  String get groupAlarms => '闹钟';

  @override
  String get groupCalendarShabbat => '日历和安息日';

  @override
  String get groupLookQuotes => '外观和名言';

  @override
  String get groupConnectionsSync => '连接与同步';

  @override
  String qsSummary(int count, int on) {
    return '$count个设置 · $on个已开启';
  }

  @override
  String get deleteAccount => 'Delete account';

  @override
  String get deleteAccountTitle => 'Delete account?';

  @override
  String get deleteAccountBody => 'Your synced alarms, settings and keys are erased from the cloud and your sign-in is removed. Alarms on this device stay.';

  @override
  String get accountDeleted => 'Account deleted';

  @override
  String get deleteAccountFailed => 'Couldn\'t delete the account. Try again.';
}

/// The translations for Chinese, using the Han script (`zh_Hant`).
class AppLocalizationsZhHant extends AppLocalizationsZh {
  AppLocalizationsZhHant() : super('zh_Hant');

  @override
  String get undo => '撤銷';

  @override
  String duplicatedNamed(String name) {
    return '已複製“$name”';
  }

  @override
  String deletedNamed(String name) {
    return '已刪除“$name”';
  }

  @override
  String get when => '何時？';

  @override
  String get newAtTime => '在某個時間';

  @override
  String get newAtTimeHint => '每個工作日 7:00，僅一次 15:30…';

  @override
  String get newAroundEvent => '圍繞某個事件';

  @override
  String get newAroundEventHint => '在日曆、安息日和日出日落時間中查詢，然後在之前、當時或之後響鈴';

  @override
  String get editThisAlarm => '編輯此鬧鐘';

  @override
  String editNamed(String name) {
    return '編輯“$name”';
  }

  @override
  String get preset => '模板';

  @override
  String get editThisCalendarRule => '編輯此日曆規則';

  @override
  String get ringThisOneAfterAll => '還是響這一次';

  @override
  String get skipJustThisOne => '只跳過這一次';

  @override
  String get renameGroup => '重新命名分組';

  @override
  String quickSet(String label, String time) {
    return '$label · $time 響鈴';
  }

  @override
  String get newAlarm => '新鬧鐘';

  @override
  String get appName => 'Quando?';

  @override
  String get lockMode => '鎖定模式';

  @override
  String get calendars => '日曆';

  @override
  String get settings => '設定';

  @override
  String get nextAlarmHeading => '下一個鬧鐘';

  @override
  String get nothingSet => '未設定';

  @override
  String get tagline => '凡事皆有時。';

  @override
  String sunriseAt(String time) {
    return '日出 $time';
  }

  @override
  String sunsetAt(String time) {
    return '日落 $time';
  }

  @override
  String get alarmsMayNotRing => '你的鬧鐘可能不會響';

  @override
  String get tapToFixIt => '點按修復';

  @override
  String inMinutes(int minutes) {
    return '$minutes 分鐘後';
  }

  @override
  String get atSunset => '日落時';

  @override
  String get sunset => '日落';

  @override
  String get shabbatModeIsOn => '安息日模式已開啟';

  @override
  String nextInCity(String city) {
    return '下一個 · $city';
  }

  @override
  String get candleLighting => '點蠟燭';

  @override
  String get havdalah => '哈夫達拉';

  @override
  String get shabbatAndFestivals => '安息日和節日';

  @override
  String get yourAlarmsHeading => '你的鬧鐘';

  @override
  String get tapWhenToAdd => '點按「何時？」新增鬧鐘。';

  @override
  String get aroundEventsHeading => '圍繞事件';

  @override
  String searchFor(String words) {
    return '搜尋：$words';
  }

  @override
  String get thisWeekHeading => '本週鬧鐘';

  @override
  String get noAlarmsThisWeek => '未來 7 天沒有鬧鐘。';

  @override
  String get alarmsSetThemselves => '每次你更改設定，鬧鐘都會在這部手機上自動設好。';

  @override
  String cityTime(String city) {
    return '$city時間';
  }

  @override
  String get more => '更多';

  @override
  String get turnOff => '關閉';

  @override
  String get turnOn => '開啟';

  @override
  String get duplicate => '複製';

  @override
  String get delete => '刪除';

  @override
  String get inOneHour => '1 小時後';

  @override
  String get logoLabel => 'Quando? 標誌';

  @override
  String get noTimesSet => '未設定時間';

  @override
  String get atTheMoment => '當時';

  @override
  String timesRange(int count, String from, String to) {
    return '$count 次 · $from 至 $to';
  }

  @override
  String spanDays(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n 天');
    return '$_temp0';
  }

  @override
  String spanHours(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n 小時');
    return '$_temp0';
  }

  @override
  String spanMinutes(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n 分鐘');
    return '$_temp0';
  }

  @override
  String spanSeconds(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n 秒');
    return '$_temp0';
  }

  @override
  String get now => '現在';

  @override
  String spanBefore(String span) {
    return '$span前';
  }

  @override
  String spanAfter(String span) {
    return '$span後';
  }

  @override
  String alarmCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n 個鬧鐘');
    return '$_temp0';
  }

  @override
  String get allOn => '全部開啟';

  @override
  String get allOff => '全部關閉';

  @override
  String someOn(int n) {
    return '$n 個開啟';
  }

  @override
  String skippedBody(String body) {
    return '已跳過 · $body';
  }

  @override
  String timeToTime(String from, String to) {
    return '$from – $to';
  }

  @override
  String skippedCount(int n) {
    return '已跳過 $n 個';
  }

  @override
  String get sunNoRiseSet => '今天這裡太陽不升起也不落下';

  @override
  String sunProgress(int percent) {
    return '太陽已走過今天的 $percent%';
  }

  @override
  String get sunIsDown => '太陽已落下';

  @override
  String get searchCity => '搜尋城市';

  @override
  String get tomorrowLower => '明天';

  @override
  String get yesterdayLower => '昨天';

  @override
  String get worldClocksHeading => '世界時鐘';

  @override
  String get add => '新增';

  @override
  String cityHere(String city) {
    return '$city · 此處';
  }

  @override
  String get worldClocksHint => '新增城市即可在這裡檢視當地時間。向左滑動可移除。';

  @override
  String get groupNameHint => '工作、孩子、健身…';

  @override
  String get cancel => '取消';

  @override
  String get ok => '好';

  @override
  String get noGroup => '無分組';

  @override
  String get newGroupEllipsis => '新分組…';

  @override
  String get newGroup => '新分組';

  @override
  String secondsShort(int n) {
    return '$n 秒';
  }

  @override
  String minutesShort(int n) {
    return '$n 分';
  }

  @override
  String get minutes => '分鐘';

  @override
  String get ringFor => '響鈴時長';

  @override
  String get seconds => '秒';

  @override
  String get oneSecondLess => '減少 1 秒';

  @override
  String get oneSecondMore => '增加 1 秒';

  @override
  String inDays(int d) {
    return '$d 天后';
  }

  @override
  String inDaysHours(int d, int h) {
    return '$d 天 $h 小時後';
  }

  @override
  String inHours(int h) {
    return '$h 小時後';
  }

  @override
  String inHoursMinutes(int h, int m) {
    return '$h 小時 $m 分後';
  }

  @override
  String inMins(int m) {
    return '$m 分鐘後';
  }

  @override
  String placeChange(String city, String where) {
    return '$city · $where · 更改';
  }

  @override
  String get israel => '以色列';

  @override
  String get outsideIsrael => '以色列以外';

  @override
  String get comingUpHeading => '即將到來';

  @override
  String get lockForShabbat => '安息日鎖定手機';

  @override
  String get lockForShabbatHint => '從點蠟燭到哈夫達拉，節日也一樣';

  @override
  String get ownShabbatAlarmsHeading => '你的安息日鬧鐘';

  @override
  String get addShabbatAlarm => '新增安息日或節日鬧鐘';

  @override
  String get readyMadeHeading => '現成的鬧鐘';

  @override
  String bringBackDeleted(int n) {
    return '恢復已刪除（$n）';
  }

  @override
  String get presetsHint => '點按可修改時間，滑動可刪除。';

  @override
  String get lockSentence => '讓手機只剩時鐘和鬧鐘，用於安息日或專注的夜晚。';

  @override
  String get lockExplain => '鎖定期間，Quando? 只顯示時間、下一個鬧鐘和鎖定結束時間。鬧鐘照常工作，解鎖前無法更改任何內容。';

  @override
  String get lockNowHeading => '立即鎖定';

  @override
  String get lockAutoHeading => '自動鎖定';

  @override
  String get shabbatAndFestivalsLong => '安息日和節日';

  @override
  String get fromCandleToHavdalah => '從點蠟燭到哈夫達拉';

  @override
  String get lockCalendarWord => '在含有此詞的日曆事件期間';

  @override
  String get lockCalendarWordHint => '例如 鎖定、考試、專注';

  @override
  String get leaveEmptyForNone => '留空表示不使用';

  @override
  String get connectCalendarsFirst => '請先連線日曆（日曆圖示）';

  @override
  String get openWhenLockStarts => '鎖定開始時開啟 Quando?';

  @override
  String get openWhenLockStartsHint => '1 秒的輕聲提示會把 Quando? 調到前臺進行鎖定';

  @override
  String get pinToScreen => '將 Quando? 固定在螢幕上';

  @override
  String get pinToScreenHint => '鎖定期間其他 App 無法開啟。首次使用時 Android 會請求確認。';

  @override
  String get noLocksComingUp => '沒有即將到來的鎖定。';

  @override
  String get leaveLockEarly => '要提前退出，請按住“按住解鎖”3 秒。';

  @override
  String get locked => '已鎖定';

  @override
  String get shabbatShalom => '安息日平安';

  @override
  String get chagSameach => '節日快樂';

  @override
  String get unlocksHeading => '解鎖時間';

  @override
  String get nowCap => '現在';

  @override
  String get nextAlarm => '下一個鬧鐘';

  @override
  String get holdToUnlock => '按住解鎖';

  @override
  String get lockSentenceCalm => '把手機鎖定在時鐘和鬧鐘：用於考試、會議或安靜的夜晚。';

  @override
  String get lockCalendarHeading => '依行事曆';

  @override
  String get lockCalendarExplain => '在活動期間鎖定，或從一個活動鎖到你指定的下一個活動。適用於你選的任何行事曆，包括共用的。';

  @override
  String get lockAddCalendar => '新增行事曆鎖定';

  @override
  String get lockEditCalendar => '行事曆鎖定';

  @override
  String get lockDuring => '活動期間';

  @override
  String get lockBetween => '兩個活動之間';

  @override
  String get lockStartsAt => '名稱為…的活動';

  @override
  String get lockStartsAtBetween => '從名為…的活動開始';

  @override
  String get lockEndsAt => '到下一個名為…的活動結束';

  @override
  String get lockStartHint => '例如 考試、專注、健身';

  @override
  String get lockEndHint => '例如 到家';

  @override
  String get lockAnyCalendar => '任何行事曆';

  @override
  String get lockNoMatches => '你的行事曆裡還沒有符合的活動。';

  @override
  String get lockNextTimes => '接下來';

  @override
  String lockDuringTitle(String a) {
    return '「$a」期間';
  }

  @override
  String lockBetweenTitle(String a, String b) {
    return '從「$a」到下一個「$b」';
  }

  @override
  String lockShabbatCalendarFound(String name) {
    return '「$name」包含安息日時間。';
  }

  @override
  String get lockShabbatFromCalendar => '從點蠟燭鎖到哈夫達拉';

  @override
  String get lockShabbatFromCalendarHint => '使用該行事曆的時間，鎖定畫面顯示蠟燭。';

  @override
  String get lockMoreWays => '更多鎖定方式';

  @override
  String get lockQuietTime => '安靜時間';

  @override
  String nextCandleLightingFrom(String time, String name) {
    return '下次點蠟燭：$time，來自 $name';
  }

  @override
  String get calendarAlarm => '日曆鬧鐘';

  @override
  String get connectCalendars => '連線日曆';

  @override
  String get calendarAlarmsHeading => '日曆鬧鐘';

  @override
  String get calendarNoneYet => '還沒有。先從這個開始，再隨意修改：';

  @override
  String get fifteenBeforeEvery => '每個事件前 15 分鐘';

  @override
  String get useTheseCalendarsHeading => '使用這些日曆';

  @override
  String get noTimedEvents => '這些日曆中沒有即將到來的定時事件。';

  @override
  String get atTheStart => '開始時';

  @override
  String everyForBefore(String every, String span) {
    return '提前 $span 起每 $every';
  }

  @override
  String spanAfterItEnds(String span) {
    return '結束後 $span';
  }

  @override
  String get noAlarmsChosen => '未選擇鬧鐘';

  @override
  String get gentleWakeUp => '溫和喚醒';

  @override
  String gentleSummary(int minutes, String sound) {
    return '提前 $minutes 分鐘 · $sound';
  }

  @override
  String get off => '關閉';

  @override
  String get gentleSentence => '鬧鐘響起前，平靜的聲音會輕輕開始，讓你不再被嚇醒。';

  @override
  String get gentleExplain => '聲音慢慢變大，把你從淺睡中帶出來，並在鬧鐘響起前停止。';

  @override
  String get startsBeforeHeading => '在鬧鐘前開始';

  @override
  String get leadUpSoundHeading => '前奏聲音';

  @override
  String get listen => '試聽';

  @override
  String get whoRecordedThese => '這些聲音的錄製者';

  @override
  String get done => '完成';

  @override
  String get soundCredits => '聲音來源';

  @override
  String yourTimeCity(String city) {
    return '你的時間（$city）';
  }

  @override
  String get anotherCity => '其他城市…';

  @override
  String get ringingIn5 => '5 秒後響鈴…';

  @override
  String get alarmSaved => '鬧鐘已儲存。';

  @override
  String alarmSetFor(String span) {
    return '鬧鐘將在 $span後響起。';
  }

  @override
  String hoursMinutesShort(int h, int m) {
    return '$h 小時 $m 分';
  }

  @override
  String get editAlarm => '編輯鬧鐘';

  @override
  String get previewCaps => '試聽';

  @override
  String get saveCaps => '儲存';

  @override
  String cityTimeForYou(String city, String time) {
    return '$city時間 · 你那裡 $time';
  }

  @override
  String repeatHeading(String repeat) {
    return '重複 · $repeat';
  }

  @override
  String get labelField => '標籤（開啟語音鬧鐘時會朗讀）';

  @override
  String get group => '分組';

  @override
  String ringsForHeading(String span) {
    return '響鈴 $span';
  }

  @override
  String useDefault(String value) {
    return '使用預設（$value）';
  }

  @override
  String get save => '儲存';

  @override
  String get sameTime => '同一時間';

  @override
  String get untilYouStopIt => '直到你停止';

  @override
  String get alarm => '鬧鐘';

  @override
  String get once => '一次';

  @override
  String get everyDay => '每天';

  @override
  String get weekdays => '工作日';

  @override
  String get weekends => '週末';

  @override
  String timeInCity(String time, String city) {
    return '$city時間 $time';
  }

  @override
  String eventsMatching(String words) {
    return '含“$words”的事件';
  }

  @override
  String get everyEvent => '所有事件';

  @override
  String get sunrise => '日出';

  @override
  String havdalahEndOf(String day) {
    return '哈夫達拉 · $day結束';
  }

  @override
  String get yomTov => '節日';

  @override
  String get shabbat => '安息日';

  @override
  String get presetCountdown => '點蠟燭倒計時';

  @override
  String get presetHourly => '提前 6 小時起每小時一次';

  @override
  String get presetDailyWeek => '前一週每天一次';

  @override
  String get presetSecondNight => '第二晚的蠟燭';

  @override
  String get presetFridayReminder => '提前 3 小時提醒：給手機充電';

  @override
  String get presetFridayReminderLabel => '給手機充電並設定明天的鬧鐘';

  @override
  String get presetSunset => '日落，以及提前 15 分鐘';

  @override
  String get pesach => '逾越節';

  @override
  String get shavuot => '七七節';

  @override
  String get roshHashanah => '猶太新年';

  @override
  String get yomKippur => '贖罪日';

  @override
  String get sukkot => '住棚節';

  @override
  String get sheminiAtzeret => '聖會節';

  @override
  String get simchatTorah => '妥拉節';

  @override
  String get readyNotifications => '顯示鬧鐘';

  @override
  String get readyNotificationsWhy => '讓鬧鐘介面和停止按鈕能夠顯示。';

  @override
  String get readyFullScreen => '在鎖屏上方響鈴';

  @override
  String get readyFullScreenWhy => '即使手機已鎖定，也會全屏顯示鬧鐘。';

  @override
  String get readyExact => '準點響鈴';

  @override
  String get readyExactWhy => '否則手機可能會把鬧鐘推遲幾分鐘。';

  @override
  String get readyBattery => '省電時保持執行';

  @override
  String get readyBatteryWhy => '防止省電功能在夜間讓鬧鐘靜音。';

  @override
  String get tipXiaomi => '小米手機：在 設定 › App › Quando? 中開啟自啟動，並將省電策略設為無限制。';

  @override
  String get tipSamsung => '三星手機：在 設定 › 電池 › 後臺使用限制 中確認 Quando? 未被設為休眠。';

  @override
  String get tipHuawei => '華為和榮耀手機：在 設定 › 電池 › App 啟動管理 中將 Quando? 設為手動管理並全部允許。';

  @override
  String get tipOther => '在這部手機上：在 設定 › 電池 中允許 Quando? 後臺執行並關閉最佳化。';

  @override
  String get testRing => '測試響鈴';

  @override
  String get testRingBody => 'Quando? 可以叫醒你';

  @override
  String get ringsIn20 => '20 秒後響鈴。現在鎖定手機並等待。';

  @override
  String get readyToRing => '響鈴準備';

  @override
  String get checkingPhone => '正在檢查手機…';

  @override
  String get phoneReady => '你的手機已準備好準時響起每個鬧鐘。';

  @override
  String thingsNeedFixing(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '有 $n 項需要修復，否則鬧鐘可能不會響。');
    return '$_temp0';
  }

  @override
  String get fix => '修復';

  @override
  String get testIn20 => '測試：20 秒後響鈴';

  @override
  String get testIn20Hint => '鎖定手機並放下。如果鬧鐘全屏響起，一切就緒。';

  @override
  String get readyToRingHint => '檢查手機能否準時響起每個鬧鐘';

  @override
  String get connections => '連線';

  @override
  String get timeZoneHeading => '時區';

  @override
  String get followPhone => '跟隨手機';

  @override
  String followPhoneNow(String city) {
    return '現在為$city。旅行時會自動更改。';
  }

  @override
  String get zoneFixed => '固定。旅行時鬧鐘也保持此時間。';

  @override
  String get shabbatCityHeading => '安息日所用城市';

  @override
  String get inIsraelOneDay => '在以色列（節日一天）';

  @override
  String candleMinutesHeading(int n) {
    return '蠟燭：日落前 $n 分鐘';
  }

  @override
  String get endOfShabbatHeading => '安息日和節日結束';

  @override
  String get nightfallGeonim => '星出（Geonim，8.5°）';

  @override
  String get rabbeinuTam => '日落後 72 分鐘（Rabbeinu Tam）';

  @override
  String get whenAlarmRingsHeading => '鬧鐘響起時';

  @override
  String get recordOrAddSounds => '錄製或新增聲音';

  @override
  String get ringsForThisLong => '響這麼久，然後自動停止';

  @override
  String get sameFades => '所有鬧鐘使用相同淡入淡出';

  @override
  String get sameFadesOn => '替換每個鬧鐘的淡入淡出設定。音量各自保持。';

  @override
  String get sameFadesOff => '關閉：每個鬧鐘使用其音量設定中的淡入淡出。';

  @override
  String get sayItOutLoud => '大聲朗讀';

  @override
  String get sayItOutLoudHint => '朗讀鬧鐘的用途，例如“點蠟燭，提前 15 分鐘”';

  @override
  String get noSnooze => '不貪睡';

  @override
  String snoozeUpTo(int times, int minutes) {
    return '最多貪睡 $times 次，每次 $minutes 分鐘';
  }

  @override
  String get wakeUpCheck => '起床確認';

  @override
  String get wakeUpCheckHint => '停止後，如果你沒有點按“我起來了”，3 分鐘後會再次響鈴';

  @override
  String get solveSum => '解題後停止';

  @override
  String get provesAwake => '證明你醒了';

  @override
  String get shabbatNoTasks => '安息日和節日期間這些都不適用：鬧鐘會自動停止，也絕不會要求你觸碰手機。';

  @override
  String get testAlarmIn1 => '1 分鐘後響一個測試鬧鐘';

  @override
  String get timesDisclaimer => '時間在手機上計算。遇到臨界情況，請諮詢你的拉比或檢視社群日曆。';

  @override
  String get recommended => '推薦';

  @override
  String get chooseCity => '選擇城市';

  @override
  String get testOnlyOnPhone => '測試鬧鐘僅在手機上可用。';

  @override
  String get testAlarm => '測試鬧鐘';

  @override
  String get testAlarmBody => '你的鬧鐘聽起來就是這樣';

  @override
  String get testAlarmIn1Set => '測試鬧鐘將在 1 分鐘後響起。你可以鎖定手機。';

  @override
  String get presetGone => '此模板已不存在。';

  @override
  String get editPreset => '編輯模板';

  @override
  String get on => '開啟';

  @override
  String get ringsHeading => '響鈴';

  @override
  String get noTimesYet => '還沒有時間。請在下方新增。';

  @override
  String get atTheMomentItself => '恰好在那一刻';

  @override
  String get remove => '移除';

  @override
  String get addATime => '新增時間';

  @override
  String get resetPreset => '恢復原樣';

  @override
  String get skipOneHint => '要跳過某一個鬧鐘，在主螢幕的“本週鬧鐘”中點按它。';

  @override
  String get unitMinutes => '分鐘';

  @override
  String get unitHours => '小時';

  @override
  String get unitDays => '天';

  @override
  String get before => '之前';

  @override
  String get after => '之後';

  @override
  String get oneWeek => '1 周';

  @override
  String daysShort(int n) {
    return '$n 天';
  }

  @override
  String hoursShort(int n) {
    return '$n 小時';
  }

  @override
  String get howToSearch => '搜尋方法';

  @override
  String get searchHelpWord => '標題包含“dentist”，不區分大小寫';

  @override
  String get searchHelpStar => '* 代表任意字母：dentist、dentures';

  @override
  String get searchHelpQuestion => '? 代表一個字母：yoga、toga';

  @override
  String get searchHelpPhrase => '完全匹配此短語';

  @override
  String get searchHelpAnd => '兩個詞都有（AND）';

  @override
  String get searchHelpOr => '任意一個。| 也可以';

  @override
  String get searchHelpNot => '排除。NOT 和 ! 也可以';

  @override
  String get searchHelpBrackets => '括號用於組合詞語';

  @override
  String get searchHelpEmpty => '留空則每個事件都響鈴。';

  @override
  String get customTime => '其他時間';

  @override
  String get other => '其他';

  @override
  String get sun => '太陽';

  @override
  String get calendar => '日曆';

  @override
  String get newEventAlarm => '新事件鬧鐘';

  @override
  String get eventAlarm => '事件鬧鐘';

  @override
  String get findEventsHeading => '查詢事件';

  @override
  String get searchEventsHint => '搜尋：牙醫、健身 OR 瑜伽、牙*…';

  @override
  String get alsoBuiltInTimes => '也包括安息日、節日和日出日落時間';

  @override
  String get alsoBuiltInTimesHint => '例如“蠟燭*”、“哈夫達拉”、“日落”';

  @override
  String get allMyCalendars => '我的所有日曆';

  @override
  String get connectToSearch => '連線日曆後可在其中搜尋';

  @override
  String get searching => '正在搜尋…';

  @override
  String get nothingMatches60 => '未來 60 天內沒有匹配項';

  @override
  String eventsIn60(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '未來 60 天內有 $n 個事件');
    return '$_temp0';
  }

  @override
  String nextRingsAt(String times, String title) {
    return '下一次：為“$title”在 $times 響鈴';
  }

  @override
  String showMoreLeft(int n) {
    return '顯示更多（還剩 $n 個）';
  }

  @override
  String get ringBeforeStartsHeading => '開始前響鈴';

  @override
  String get ringWhenStarts => '開始時響鈴';

  @override
  String get repeatBeforeHeading => '並在之前重複';

  @override
  String get everyPrefix => '每 ';

  @override
  String get offLower => '關';

  @override
  String get forInfix => '  持續 ';

  @override
  String get ringAfterEndsHeading => '結束後響鈴';

  @override
  String get nameOptional => '名稱（可選）';

  @override
  String get toppedUp => '鬧鐘已設好未來 7 天，每次開啟 Quando? 都會補充。';

  @override
  String get back => '返回';

  @override
  String get next => '下一步';

  @override
  String get stepWhichEvents => '哪些事件';

  @override
  String get stepWhenToRing => '何時響鈴';

  @override
  String get stepHowItRings => '如何響鈴';

  @override
  String defaultNamed(String name) {
    return '預設（$name）';
  }

  @override
  String get phoneAlarmSound => '手機鬧鐘鈴聲';

  @override
  String get onlineRadio => '網路電台';

  @override
  String songLinkOpens(String app) {
    return '歌曲連結 · 開啟 $app';
  }

  @override
  String get builtIn => '內建';

  @override
  String get yourRecording => '你的錄音';

  @override
  String get sound => '聲音';

  @override
  String get wakeToOwnSound => '用你自己的聲音醒來';

  @override
  String get wakeToOwnSoundHint => '你的聲音、一首歌、Spotify 或直播電台';

  @override
  String musicAdded(String name) {
    return '已新增 $name。可選作任何鬧鐘的聲音。';
  }

  @override
  String get playlists => '播放清單';

  @override
  String get likedSongs => '喜歡的歌曲';

  @override
  String get noPlaylists => '還沒有播放清單。';

  @override
  String get noLikedSongs => '還沒有喜歡的歌曲。';

  @override
  String get needsMic => 'Quando? 需要麥克風才能錄音。';

  @override
  String recordingN(int n) {
    return '錄音 $n';
  }

  @override
  String couldNotAddFile(String error) {
    return '無法新增該檔案：$error';
  }

  @override
  String get addSongLink => '新增歌曲連結';

  @override
  String get songLink => '歌曲連結';

  @override
  String get songLinkHowTo =>
      '在 Spotify、Apple Music、YouTube、YouTube Music 或 SoundCloud 中點按分享，再點複製連結，然後貼上到這裡。';

  @override
  String get songNameHint => '名稱，例如 早晨播放清單';

  @override
  String get whenAlarmGoesOffHeading => '鬧鐘響起時';

  @override
  String get playTheSong => '播放歌曲';

  @override
  String get ringThenOpen => '先響鈴，再開啟';

  @override
  String get playTheSongHint => '它的 App 會開啟並播放。如果 10 秒內沒有聲音，就會響起備用鈴聲，確保你能醒來。帶任務的鬧鐘會先響鈴，然後再開啟。';

  @override
  String get ringThenOpenHint => '響起備用鈴聲。停止後在其 App 中開啟歌曲。';

  @override
  String get playForHeading => '播放時長';

  @override
  String get pausesAfter => '到時間後，Quando? 會用手機的暫停鍵暫停歌曲。';

  @override
  String get backupSoundHeading => '備用鈴聲';

  @override
  String get notALink => '這看起來不像連結。';

  @override
  String songOn(String app) {
    return '$app 上的歌曲';
  }

  @override
  String get theWeb => '網頁';

  @override
  String get pickFromYouTube => '從我的 YouTube 選擇';

  @override
  String get youTubeAndMusic => 'YouTube 和 YouTube Music';

  @override
  String get youTubeOn => '已連接 · 長按登出';

  @override
  String get youTubeSignIn => '使用 Google 登入';

  @override
  String get addSongLinkInstead => '請改為新增歌曲連結。';

  @override
  String get googleSignInFailed => 'Google 登入未完成。請重試。';

  @override
  String get myYouTube => '我的 YouTube';

  @override
  String get spotifyDirectOn => 'Spotify 直接播放已開啟';

  @override
  String get spotifyDirect => 'Spotify 直接播放';

  @override
  String get spotifyDirectOnHint => '已開啟 · 點按關閉';

  @override
  String get spotifyDirectHint => '播放指定歌曲。需要 Premium。';

  @override
  String get spotifyComingSoon => '即將推出 · 需要 Premium';

  @override
  String get spotifyFailed => 'Spotify 未能連線。請確認已安裝 Spotify App、已登入並擁有 Premium。';

  @override
  String get nameThisSound => '為這個聲音命名';

  @override
  String get sounds => '聲音';

  @override
  String get soundsSentence => '用你自己的聲音、一首歌、一個播放清單或直播電台醒來。';

  @override
  String stopTimer(String time) {
    return '停止 · $time';
  }

  @override
  String get record => '錄音';

  @override
  String get addAFile => '新增檔案';

  @override
  String get addSongLinkLong => '新增歌曲連結（Spotify、Apple Music、YouTube…）';

  @override
  String get musicAppsHeading => '音樂 App';

  @override
  String get pickFromSpotify => '從我的 Spotify 選擇';

  @override
  String get yourPlaylistsAndLiked => '你的播放清單和喜歡的歌曲';

  @override
  String get mySpotify => '我的 Spotify';

  @override
  String get spotifySignInFailed => '無法登入 Spotify。';

  @override
  String get appleMusicNote => '登入功能將隨 iPhone 版推出。目前請新增歌曲連結。';

  @override
  String noSignInNote(String service) {
    return '$service 不允許其他 App 登入。請改為新增歌曲連結。';
  }

  @override
  String get wakeToRadio => '用網路電台醒來';

  @override
  String get soundsExplain => '錄音最長 5 分鐘,或新增檔案、歌曲連結、線上電台。出錯時會響起備用鈴聲。';

  @override
  String get yourSoundsHeading => '你的聲音';

  @override
  String playsIn(String app) {
    return '在 $app 中播放';
  }

  @override
  String opensIn(String app) {
    return '在 $app 中開啟';
  }

  @override
  String forSpan(String span) {
    return '持續 $span';
  }

  @override
  String get defaultLabel => '預設';

  @override
  String get radioUnreachable => '無法獲取電台列表。請檢查網路連線。';

  @override
  String get addStreamAddress => '新增流地址';

  @override
  String get notAStream => '這看起來不像流地址（以 http 開頭）。';

  @override
  String get anyGenre => '所有型別';

  @override
  String get stationName => '電台名稱';

  @override
  String get closeSearch => '關閉搜尋';

  @override
  String get searchByName => '按名稱搜尋';

  @override
  String get anywhere => '所有地區';

  @override
  String get noStations => '未找到電台。試試其他型別或國家。';

  @override
  String wakeUpTo(String name) {
    return '用 $name 醒來';
  }

  @override
  String get notQuite => '差一點。再試一次。';

  @override
  String shabbatStopsItself(int n) {
    return '安息日模式：$n 秒後自動停止。無需觸碰手機。';
  }

  @override
  String get solveToSnooze => '解題以貪睡';

  @override
  String get solveToStop => '解題以停止';

  @override
  String get answer => '答案';

  @override
  String get snooze => '貪睡';

  @override
  String get stop => '停止';

  @override
  String get shakeToSnooze => '搖動以貪睡';

  @override
  String get shakeToStop => '搖動以停止';

  @override
  String get shakeHard => '用力搖動手機，直到進度條填滿。';

  @override
  String get cantShake => '無法搖動？改為解題';

  @override
  String get pairsToSnooze => '配對以貪睡';

  @override
  String get pairsToStop => '配對以停止';

  @override
  String get typeToSnooze => '輸入以下內容以貪睡';

  @override
  String get typeToStop => '輸入以下內容以停止';

  @override
  String get scanToSnooze => '掃描你的碼以貪睡';

  @override
  String get scanToStop => '掃描你的碼以停止';

  @override
  String ringAgainUnless(int n) {
    return '除非你點按下方，否則 $n 分鐘後我會再次響鈴。';
  }

  @override
  String get imUp => '我起來了';

  @override
  String snoozeMin(int n) {
    return '貪睡 $n 分鐘';
  }

  @override
  String snoozeMinLeft(int n, int left) {
    return '貪睡 $n 分鐘 · 還剩 $left 次';
  }

  @override
  String get noSnoozesLeft => '貪睡次數已用完';

  @override
  String get stopThenOpen => '停止 · 然後開啟';

  @override
  String get startingSong => '正在啟動你的歌曲';

  @override
  String wayToStop(String way) {
    return '$way以停止';
  }

  @override
  String wayToSnooze(String way) {
    return '$way以貪睡';
  }

  @override
  String ringsForMore(int n) {
    return '還會響 $n 秒';
  }

  @override
  String get leftToRing => '剩餘';

  @override
  String get wayVolumeButtons => '音量鍵';

  @override
  String get wayShake => '搖動手機';

  @override
  String get taskNothing => '無';

  @override
  String get taskSum => '解一道題';

  @override
  String get taskShake => '搖動 30 次';

  @override
  String get taskMemory => '記憶遊戲';

  @override
  String get taskPhrase => '輸入一句話';

  @override
  String get taskScan => '掃描一個碼';

  @override
  String get noLimit => '無限制';

  @override
  String upToTimes(int n) {
    return '最多 $n 次';
  }

  @override
  String shorterEachTime(int n) {
    return '每次縮短 $n 分鐘';
  }

  @override
  String autoSnoozeAfter(int n) {
    return '$n 分鐘後自動貪睡';
  }

  @override
  String get card => '卡片';

  @override
  String get hiddenCard => '背面朝上的卡片';

  @override
  String get phrase1 => '我醒了今天屬於我';

  @override
  String get phrase2 => '此時不做更待何時';

  @override
  String get phrase3 => '早安給我和我愛的每個人';

  @override
  String get phrase4 => '我雙腳著地已經起床';

  @override
  String get phrase5 => '今天我重新開始';

  @override
  String get notQuiteWords => '差一點，請檢查每個字。';

  @override
  String get typeItHere => '在此輸入';

  @override
  String get differentCode => '這是另一個碼。';

  @override
  String get cameraUnavailable => '相機不可用。';

  @override
  String get cantScan => '無法掃描？改為解題';

  @override
  String get saveCodeToScan => '儲存一個要掃描的碼';

  @override
  String get saveCodeHint => '對準一個需要走過去才能找到的條形碼或QR 碼，比如廚房裡的盒子或浴室裡的牙膏。要停止鬧鐘，你需要再掃描一次。';

  @override
  String get cameraUnavailableSettings => '相機不可用。請在設定中允許訪問相機。';

  @override
  String gentleToGo(int n) {
    return '溫和喚醒 · 還剩 $n 分鐘';
  }

  @override
  String previewBody(String body) {
    return '試聽 · $body';
  }

  @override
  String snoozedBody(String body) {
    return '已貪睡：$body';
  }

  @override
  String get areYouUp => '起來了嗎？';

  @override
  String get tapImUp => '點按“我起來了”以停止';

  @override
  String get volume => '音量';

  @override
  String get wakeCheckOn => '起床確認已開啟';

  @override
  String get stopsAtOnce => '立即停止';

  @override
  String get ringsAgainIfNotUp => '如果沒起床會再次響鈴';

  @override
  String get openAppAfter => '之後開啟 App';

  @override
  String get noTask => '無任務';

  @override
  String get codeSaved => '碼已儲存';

  @override
  String get tapToSaveDifferent => '點按儲存另一個';

  @override
  String get controlsHeading => '控制';

  @override
  String get onScreen => '螢幕上';

  @override
  String get taskHeading => '任務';

  @override
  String get none => '無';

  @override
  String get snoozeSentence => '再睡五分鐘？選擇多久、幾次以及需要做什麼。';

  @override
  String get settingsHeading => '設定';

  @override
  String get snoozeTime => '貪睡時長';

  @override
  String get snoozeTimeHint => '第一次貪睡的時長';

  @override
  String get shortenSnoozes => '縮短之後的貪睡';

  @override
  String get shortenSnoozesHint => '第一次之後的每次貪睡都縮短這麼多';

  @override
  String get autoSnooze => '自動貪睡';

  @override
  String get autoSnoozeHint => '如果你沒有觸碰，會在此時間後自動貪睡';

  @override
  String get never => '從不';

  @override
  String get snoozeLimit => '貪睡次數上限';

  @override
  String get snoozeLimitHint => '你可以貪睡幾次';

  @override
  String get unlimited => '無限制';

  @override
  String get useSnoozeFromSettings => '使用設定中的貪睡';

  @override
  String get stopSentence => '如何關閉鬧鐘，以及先要做什麼。';

  @override
  String get shabbatNoTask => '安息日和節日期間鬧鐘會自動停止，絕不會要求完成任務。';

  @override
  String get volumeSentence => '響鈴有多大聲，以及如何柔和地達到那個音量。';

  @override
  String get openAfterAlarm => '鬧鐘後開啟';

  @override
  String get pickAnApp => '選擇 App';

  @override
  String get orPasteLink => '或貼上連結：https://…';

  @override
  String get useThisLink => '使用此連結';

  @override
  String get noAppsFound => '未找到 App。';

  @override
  String get weather => '天氣';

  @override
  String get news => '新聞';

  @override
  String get usePhoneVolume => '使用手機鬧鐘音量';

  @override
  String get setsPhoneVolume => '響鈴時設定手機鬧鐘音量，之後恢復。';

  @override
  String get fadeInOff => '不淡入，立即全音量';

  @override
  String fadeInOver(String span) {
    return '$span內逐漸變大';
  }

  @override
  String get fadeOutOff => '不淡出';

  @override
  String fadeOutOver(String span) {
    return '最後 $span內逐漸變小';
  }

  @override
  String get fadesExplain => '淡出發生在鬧鐘自動停止時。如果淡入淡出比響鈴時間長，兩者都會縮短。';

  @override
  String get soundSoftChime => '柔和鈴聲';

  @override
  String get soundMorningRise => '晨光初現';

  @override
  String get soundClassicBeep => '經典嗶聲';

  @override
  String get calmCity => '寧靜的城市清晨';

  @override
  String get calmBirds => '黎明鳥鳴';

  @override
  String get calmWaves => '海浪拍岸';

  @override
  String get calmRain => '細雨';

  @override
  String get calmStream => '林間小溪';

  @override
  String get calmWind => '微風';

  @override
  String get calmFire => '噼啪爐火';

  @override
  String get calmNight => '夏夜';

  @override
  String get publicDomain => '公共領域';

  @override
  String get phoneVolume => '手機音量';

  @override
  String fadesIn(String span) {
    return '$span內淡入';
  }

  @override
  String fadesOut(String span) {
    return '$span內淡出';
  }

  @override
  String get noFade => '無淡入淡出';

  @override
  String minSecShort(int m, int s) {
    return '$m 分 $s 秒';
  }

  @override
  String get happensRings => '響鈴';

  @override
  String get happensStopped => '你停止了它';

  @override
  String get happensSnoozed => '你貪睡了';

  @override
  String get happensAutoStopped => '自動停止';

  @override
  String get eventLower => '事件';

  @override
  String get appTest => 'Quando? 測試';

  @override
  String get pushoverConnected => 'Pushover 已連線';

  @override
  String get webhookConnected => 'Webhook 已連線';

  @override
  String pushoverSaid(int code, String body) {
    return 'Pushover 返回 $code：$body';
  }

  @override
  String couldNotReachPushover(String error) {
    return '無法連線 Pushover（$error）';
  }

  @override
  String itAnswered(int code) {
    return '返回 $code';
  }

  @override
  String couldNotReachIt(String error) {
    return '無法連線（$error）';
  }

  @override
  String get calendarNotAllowed => '未獲準訪問日曆。';

  @override
  String get playlist => '播放清單';

  @override
  String songCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n 首歌');
    return '$_temp0';
  }

  @override
  String get spotifySaidNo => 'Spotify 拒絕了。在 Spotify 控制檯中為 Quando? 勾選 Web API，並在 User Management 中新增你的帳號。';

  @override
  String serviceDidntAnswer(String service, int code) {
    return '$service 沒有響應（$code）。';
  }

  @override
  String get youTubeSaidNo => 'YouTube 拒絕了。請確認你的 Google 帳號是 Quando 專案的測試使用者。';

  @override
  String get event => '事件';

  @override
  String eventEnds(String title) {
    return '$title（結束）';
  }

  @override
  String foundSoundsDevices(int s, int d) {
    return '找到 $s 個聲音和 $d 臺裝置。';
  }

  @override
  String get sentCheckDevices => '已傳送。請檢視你的其他裝置。';

  @override
  String sentTo(String name) {
    return '已傳送到 $name。';
  }

  @override
  String get zapierHowTo => '在 Zapier 中建立一個以“Webhooks by Zapier → Catch Hook”開頭的 Zap，然後把它的 URL 貼上到這裡。';

  @override
  String get catchHookUrl => 'Catch Hook URL';

  @override
  String get iftttHowTo =>
      '在 IFTTT 中建立一個以“Webhooks → Receive a web request with a JSON payload”開頭的小程式。在這裡使用相同的事件名稱。你的金鑰在 ifttt.com/maker_webhooks/settings。';

  @override
  String get eventName => '事件名稱';

  @override
  String get webhooksKey => 'Webhooks 金鑰';

  @override
  String get webhookHowTo => 'Quando? 會向此地址傳送 JSON POST。';

  @override
  String get connectionsSentence => '鬧鐘響起、停止或貪睡時，通知其他 App 和裝置。';

  @override
  String get pushWhenRings => '鬧鐘響起時傳送通知';

  @override
  String get pushWhenRingsHint => '傳送到你的其他手機、平板、手錶或電腦';

  @override
  String get yourUserKey => '你的使用者金鑰';

  @override
  String get appToken => 'App 令牌';

  @override
  String get soundAndDevicesHeading => '聲音和裝置';

  @override
  String get loading => '正在載入…';

  @override
  String get loadFromPushover => '從 Pushover 載入';

  @override
  String get soundItPlays => '播放的聲音';

  @override
  String get myPushoverDefault => '我的 Pushover 預設';

  @override
  String get pushoverOwnSounds => '你上傳到 pushover.net/sounds 的聲音會顯示在這裡。';

  @override
  String get allMyDevices => '我的所有裝置';

  @override
  String get pushoverOnThisPhone => '在這部手機上也安裝 Pushover App，它就會在這裡用你的 Pushover 聲音響鈴。';

  @override
  String get priority => '優先順序';

  @override
  String get priorityNormal => '普通';

  @override
  String get priorityHigh => '高：無視免打擾時段';

  @override
  String get priorityEmergency => '緊急：重複直到確認';

  @override
  String get sending => '正在傳送…';

  @override
  String get sendATest => '傳送測試';

  @override
  String get findUserKey => '查詢我的使用者金鑰';

  @override
  String get makeAppToken => '建立 App 令牌';

  @override
  String get webhooksHeading => 'ZAPIER、IFTTT 和 WEBHOOK';

  @override
  String get webhooksExplain => '鬧鐘響起或你停止它時啟動任何操作：開燈、記錄起床時間、給某人發訊息。';

  @override
  String get sendWhenAlarm => '鬧鐘以下情況時傳送：';

  @override
  String get pauseOnShabbat => '安息日和節日暫停';

  @override
  String get pauseOnShabbatHint => '點蠟燭到哈夫達拉之間的鬧鐘不會傳送任何內容';

  @override
  String get webhookPayloadNote =>
      '每條訊息包含：event（ring、stopped、snoozed、auto_stopped）、title、body、time、shabbat 和 snoozes。金鑰儲存在這部手機上。';

  @override
  String get today => '今天';

  @override
  String get tomorrow => '明天';

  @override
  String get notAWebAddress => '這看起來不像以 https:// 開頭的網址';

  @override
  String get language => '語言';

  @override
  String get phoneLanguage => '手機語言';

  @override
  String get ringQuote => '此時不做，更待何時？';

  @override
  String get ringQuoteBy => '希勒爾';

  @override
  String get quotesTitle => '關於時間的名言';

  @override
  String get quotesHint => '選擇名言的來源。每個時段一句；輕觸名言可換一句。';

  @override
  String get quotesOff => '關閉';

  @override
  String get quoteSongs => '歌曲';

  @override
  String get quoteMovies => '電影';

  @override
  String get quoteLiterature => '書籍與詩歌';

  @override
  String get quoteTanakh => '塔納赫（希伯來聖經）';

  @override
  String get quoteSages => '塔木德與賢哲';

  @override
  String get quoteSpeeches => '著名演講';

  @override
  String get quotePhilosophy => '哲學家';

  @override
  String get quoteProverbs => '諺語與俗語';

  @override
  String get quotesAlso => '同時顯示';

  @override
  String get quoteCarnaval => '嘉年華';

  @override
  String get quoteCarnavalHint => '巴西嘉年華期間的歌曲與俗語';

  @override
  String get quoteNearMe => '我的附近';

  @override
  String get quoteNearMeHint => '根據你的時區和安息日城市，顯示當地的詩人與節日';

  @override
  String get quoteSiddur => '祈禱書 (Siddur)';

  @override
  String weeklyParasha(String name) {
    return '本週經文 $name';
  }

  @override
  String poweredBy(String name) {
    return '由 $name 驅動';
  }

  @override
  String get syncTitle => '同步我的裝置';

  @override
  String get syncHint => '用 Google 登入，讓鬧鐘和設定在你所有裝置上保持一致。';

  @override
  String syncOn(String email) {
    return 'On · $email';
  }

  @override
  String get syncWorking => 'Connecting…';

  @override
  String get syncNotAllowed => 'This Google account can\'t sync.';

  @override
  String get syncFailed => '無法連線。點一下重試。';

  @override
  String get syncStop => 'Stop syncing';

  @override
  String get syncNotSetUp => '此版本尚未設定同步。';

  @override
  String get ringTheseAfterAll => '仍然響鈴';

  @override
  String skipTheseDay(int n) {
    return '今天略過這 $n 個';
  }

  @override
  String turnOffNamed(String name) {
    return '關閉「$name」';
  }

  @override
  String turnOnNamed(String name) {
    return '開啟「$name」';
  }

  @override
  String turnedOffNamed(String name) {
    return '已關閉「$name」';
  }

  @override
  String removeTimeFrom(String time, String name) {
    return '從「$name」移除「$time」';
  }

  @override
  String removedTimeFrom(String time, String name) {
    return '已從「$name」移除「$time」';
  }

  @override
  String get moveToGroup => '移到群組';

  @override
  String inGroupMove(String group) {
    return '在「$group」中，移動';
  }

  @override
  String movedToGroup(String group) {
    return '已移到「$group」';
  }

  @override
  String deleteNamed(String name) {
    return '刪除「$name」';
  }

  @override
  String get signInWithGoogle => '使用 Google 登入';

  @override
  String get signOut => 'Sign out';

  @override
  String get signInWithEmail => '使用電子郵件登入';

  @override
  String get signIn => 'Sign in';

  @override
  String get createAccount => '建立帳號';

  @override
  String get haveAccount => '我已有帳號';

  @override
  String get forgotPassword => '忘記密碼？';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get passwordResetSent => '我們已寄出設定新密碼的連結給你。';

  @override
  String emailCheckInbox(String email) {
    return '我們已將連結寄到 $email。開啟連結後回到這裡，點一下「我已確認」。';
  }

  @override
  String get emailConfirmed => '我已確認';

  @override
  String get emailNotYet => '尚未確認。請先開啟郵件中的連結。';

  @override
  String get emailSendAgain => '重新寄送郵件';

  @override
  String get emailSentAgain => '已寄出。請查看收件匣和垃圾郵件。';

  @override
  String get emailInvalid => '這看起來不像電子郵件地址。';

  @override
  String get emailWrong => '電子郵件或密碼錯誤。';

  @override
  String get emailInUse => '這個電子郵件已有帳號。請直接登入；如果你是用 Google 建立的，請使用 Google 登入。';

  @override
  String get passwordWeak => '請設定至少 6 個字元的密碼。';

  @override
  String get emailNotSwitchedOn => '電子郵件登入尚未開啟。';

  @override
  String get tooManyTries => '嘗試次數過多。請等幾分鐘。';

  @override
  String get spotifyLibrary => 'Spotify';

  @override
  String get spotifyLibrarySignIn => '播放清單、喜歡的歌曲和搜尋';

  @override
  String get spotifyLibraryOn => '已連接 · 長按登出';

  @override
  String spotifyLoginError(String reason) {
    return 'Spotify 登入失敗：$reason';
  }

  @override
  String googleSignInError(String reason) {
    return 'Google 登入失敗：$reason';
  }

  @override
  String get searchSongsHint => '搜尋歌曲、藝人、播放清單';

  @override
  String nothingFound(String query) {
    return '找不到「$query」。';
  }

  @override
  String get deliveryTitle => '提醒方式';

  @override
  String get deliveryLocal => '本機音訊';

  @override
  String get deliveryBoth => '兩者';

  @override
  String get deliveryConnect => '連接 Pushover';

  @override
  String get deliveryLoadFailed => '無法載入聲音和裝置，請重試。';

  @override
  String get deliveryBothHint => '即使 Pushover 失敗，本機仍會響鈴。';

  @override
  String get deliveryPushHint => '僅用 Pushover。提醒觸發時本裝置必須連線。';

  @override
  String get deliveryFallback => 'Pushover 未連接或暫停時保留本機音訊。';

  @override
  String get deliveryReset => '使用現有設定';

  @override
  String get beforeShabbat => '安息日之前';

  @override
  String get preparationReminders => '準備提醒';

  @override
  String get skipThisWeek => '略過本週';

  @override
  String get restoreThisWeek => '還原本週';

  @override
  String get allAlarms => 'All alarms';

  @override
  String get timesAndSound => '時間與聲音';

  @override
  String get changeCity => 'Change city';

  @override
  String get useMyLocation => '使用我的位置';

  @override
  String get locationUnavailable => '位置暫時無法使用。請重試或選擇一個城市。';

  @override
  String get locationReview => '確認此位置';

  @override
  String get locationDeviceOnly => '此位置只儲存在這台裝置上。使用這些時間之前，請檢查時區和以色列設定。';

  @override
  String timesIn(String city, String zone) {
    return '$city · $zone · 城市時間';
  }

  @override
  String get preparationOff => '準備提醒已關閉。哈夫達拉與一般鬧鐘不受影響。';

  @override
  String get preparationSkipped => '本週的準備提醒已略過。你的每週設定仍會保留。';

  @override
  String get shabbatControls => '安息日控制';

  @override
  String get duringAfterShabbat => '安息日期間 / 之後';

  @override
  String locationCoordinates(String latitude, String longitude) {
    return '緯度 $latitude · 經度 $longitude';
  }

  @override
  String get currentLocation => '目前位置';

  @override
  String get testPushoverSound => '在 Pushover 上測試聲音';

  @override
  String get pushoverSoundTestHint => '在你選擇的 Pushover 裝置上播放所選聲音。靜音與勿擾時段設定仍然有效。';

  @override
  String get pushoverShareDevices => '與我的裝置共用憑證';

  @override
  String get pushoverShareHint => '你的 Pushover 使用者金鑰與應用程式權杖可以跟隨你在 Quando? 與 Matai? 中登入的帳號。';

  @override
  String get pushoverShareQueued => '憑證已排入佇列，將傳送到你已登入的裝置。';

  @override
  String get pushoverShareSignIn => '在每部裝置上登入同一個應用程式帳號，即可共用 Pushover 憑證。';

  @override
  String get smartHomeHeading => 'Smart home';

  @override
  String get smartHomeHint => '直接執行 Tuya 情境，或連接你自己的 Home Assistant 或 Node-RED 自動化。';

  @override
  String get shareServices => '共用服務連線';

  @override
  String get shareServicesHint =>
      '在你的各部裝置上使用同一個應用程式帳號，即可共用 Pushover、Tuya、Spotify 資料庫與自動化連線。YouTube 與裝置權限可能仍需在每部裝置上個別核准。';

  @override
  String get tuyaSetupHint =>
      '使用你已連結的 Tuya 開發者專案。輸入其資料中心、Access ID、Access Secret，以及「Link App Account」下顯示的 UID。不需要 Home Assistant。';

  @override
  String get tuyaDataCenter => 'Data center';

  @override
  String get tuyaUserId => '已連結帳號的 UID';

  @override
  String get tuyaAccessId => 'Access ID / Client ID';

  @override
  String get tuyaAccessSecret => 'Access Secret / Client Secret';

  @override
  String get tuyaLoadScenes => 'Load scenes';

  @override
  String get tuyaNoScenes => '找不到可用的 Tap-to-Run 情境。請檢查已連結的帳號、資料中心與情境 API 權限。';

  @override
  String get tuyaRunNow => '立即執行情境';

  @override
  String get tuyaRunConfirm => '現在在你的 Tuya 裝置上執行此情境嗎？';

  @override
  String get tuyaSent => 'Tuya 已接受情境指令。請檢查你的裝置。';

  @override
  String get tuyaFailed => 'Tuya 無法完成該請求。請檢查專案權限、資料中心與訂閱。錯誤：';

  @override
  String get tuyaAlarmScene => '此鬧鐘響起時的 Tuya 情境';

  @override
  String get homeAssistantHowTo =>
      '建立一個使用 Webhook 觸發器的 Home Assistant 自動化，接受 POST 與 JSON，並在此貼上其 URL。用鬧鐘事件（ring、stopped、snoozed 或 auto_stopped）來選擇你的動作。新裝置上此連線預設為關閉。';

  @override
  String get nodeRedHowTo =>
      '使用接受 POST 的 Node-RED HTTP In 節點，後接你的自動化與一個 HTTP Response 節點。在此貼上端點。支援本機 HTTP 中樞與 HTTPS 端點。';

  @override
  String get smartHomeConnect => '連接智慧家庭服務';

  @override
  String get automationTestHint => '測試會立即執行已連接的自動化。';

  @override
  String get smartHomeDeviceOn => '在此裝置上執行智慧家庭鬧鐘動作';

  @override
  String get smartHomeDeviceHint => '選擇一部裝置來執行你的自動化。連線是共用的；此開關只對這部裝置生效。';

  @override
  String get smartHomeDeviceOff => '此裝置上的鬧鐘動作已關閉。請在「連線」中開啟；手動情境測試仍可使用。';

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
  String get weatherSwipeHint => '在天空和天氣之間滑動';

  @override
  String get parashaHeading => '每週經文段落';

  @override
  String get dailyStudyHeading => '每日學習';

  @override
  String get courseDaf => 'Daf Yomi';

  @override
  String get courseRambam1 => 'Rambam · 每天 1 章';

  @override
  String get courseRambam3 => 'Rambam · 每天 3 章';

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
  String get moonAlwaysUp => '月亮整天在地平線上方';

  @override
  String get moonAlwaysDown => '月亮整天在地平線下方';

  @override
  String get noRiseToday => '今天沒有月出';

  @override
  String get noSetToday => 'No set today';

  @override
  String get moonNew => 'New moon';

  @override
  String get moonWaxingCrescent => '蛾眉月（漸盈）';

  @override
  String get moonFirstQuarter => '上弦月';

  @override
  String get moonWaxingGibbous => '盈凸月';

  @override
  String get moonFull => 'Full moon';

  @override
  String get moonWaningGibbous => '虧凸月';

  @override
  String get moonLastQuarter => 'Last quarter';

  @override
  String get moonWaningCrescent => '殘月（漸虧）';

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
  String get weatherThunder => '雷暴';

  @override
  String get weatherUnavailable => '天氣暫時無法使用';

  @override
  String get weatherCached => '已儲存的預報';

  @override
  String get weatherUpdated => 'Updated';

  @override
  String get weatherForecast => 'Forecast';

  @override
  String get weatherThunderExpected => '預報有雷暴';

  @override
  String get learningUnavailable => '連線以載入本月的學習安排';

  @override
  String get festivalReading => '節日托拉誦讀';

  @override
  String get learningCalendarSource => '學習日曆 · Hebcal · CC BY 4.0';

  @override
  String get weatherSource => '天氣預報 · MET Norway · CC BY 4.0';

  @override
  String get weatherConsent => '所選城市的天氣。使用四捨五入後的座標，透過 MET Norway 取得。';

  @override
  String get learningConsent => 'Rambam 等學習日程會從 Hebcal 載入，並儲存供離線使用。';

  @override
  String get homeRefresh => 'Refresh';

  @override
  String get skyTimezone => 'My timezone';

  @override
  String get skyShabbat => 'Shabbat city';

  @override
  String get skyReferenceCity => '時區參考城市';

  @override
  String get skyChooseCity => '選擇天空城市';

  @override
  String get skyCityExplain => '太陽和月亮使用這個城市的座標。你的安息日城市和鬧鐘時區會維持你的選擇不變。';

  @override
  String get skySun => 'Sun today';

  @override
  String get skyMoon => 'Moon today';

  @override
  String get moonAboveHorizon => '月亮在地平線上方';

  @override
  String get moonBelowHorizon => '月亮在地平線下方';

  @override
  String get moonNextNew => '下次新月';

  @override
  String get moonNextFull => '下次滿月';

  @override
  String get locationServicesOff => '定位服務已關閉。請在「設定」中開啟，或選擇一個城市。';

  @override
  String get locationDenied => '定位權限遭到拒絕。請在「設定」中允許，或選擇一個城市。';

  @override
  String get locationTimedOut => '暫時還沒取得位置。在 Mac 上請保持 Wi-Fi 開啟後重試，或選擇一個城市。';

  @override
  String get locationTimeZoneUnavailable => '使用位置之前，請選擇所選時區內的城市，或跟隨裝置時區。';

  @override
  String get locationSettings => '開啟定位設定';

  @override
  String get locationLooking => '正在取得位置…';

  @override
  String get skyMoonDisplay => '顯示月亮：月出、月落和月相';

  @override
  String get tuyaConsumerPending => '此版本尚不支援帳號登入。如果你已有 Tuya 開發者專案，請使用進階設定。';

  @override
  String get tuyaAdvanced => '進階設定';

  @override
  String get tuyaSignInTitle => '使用 Smart Life 帳號登入';

  @override
  String get tuyaSignInHint =>
      '請使用與 Smart Life 或 Tuya Smart 應用程式相同的國家、電子郵件或電話號碼和密碼。該帳號必須已連結到你的 Tuya 專案。密碼只會傳送給 Tuya，不會被儲存。';

  @override
  String get tuyaCountryCode => '國碼（巴西 55，美國 1）';

  @override
  String get tuyaAccount => 'Smart Life 電子郵件或電話號碼';

  @override
  String get tuyaPassword => 'Smart Life 密碼';

  @override
  String get tuyaSignIn => '登入並載入情境';

  @override
  String get tuyaRelayUrl => 'Quando Tuya 中繼位址（https）';

  @override
  String get tuyaRelayHint =>
      '請使用你的 Smart Life 或 Tuya Smart 帳號的國家、電子郵件或電話號碼和密碼。它們只會傳送一次到 Quando 的 Tuya 中繼，不會被儲存。你需要先登入 Quando 帳號。';

  @override
  String get tuyaGoogleHint => '用 Google 或 Apple 登入 Smart Life？在 Smart Life 中點選「忘記密碼」設定密碼，然後在這裡使用。';

  @override
  String get tuyaLinked => 'Smart Life 帳號已連結';

  @override
  String get tuyaUnlink => '取消連結';

  @override
  String get tuyaNeedsAccount => '請先在設定中登入你的 Quando 帳號。';

  @override
  String get roshHodeshHeading => 'Rosh Hodesh';

  @override
  String get roshHodeshExplain => '在主畫面顯示下一個希伯來月的第一天或前兩天。';

  @override
  String get roshHodeshNext => '下一個新月（Rosh Hodesh）';

  @override
  String get roshHodeshBegins => '日落時開始：';

  @override
  String get openParashaSefaria => '在 Sefaria 上閱讀此托拉經文';

  @override
  String get skyMyLocation => 'My location';

  @override
  String get skyLocationLocalTimes => '天空時間使用此位置的時區。你的鬧鐘時區和安息日城市維持不變。只儲存在這台裝置上。';

  @override
  String get musicRingDurationHint => '播放遵循此鬧鐘的響鈴時長，並在停止或稍後提醒時結束。';

  @override
  String get musicBackupPlaying => '無法開始播放音樂。正在播放本機鬧鐘聲音。';

  @override
  String desktopMusicConnect(String service) {
    return '連接 $service 應用程式';
  }

  @override
  String desktopMusicOn(String service) {
    return '已連接 $service · 長按中斷';
  }

  @override
  String get musicSongs => '歌曲';

  @override
  String get noMusicSongs => '在音樂資料庫中找不到歌曲。';

  @override
  String serviceConnectUnavailable(String service) {
    return '新增 $service 連結 · 鬧鐘停止後開啟';
  }

  @override
  String get soundCloudWidgetNote => '新增公開連結';

  @override
  String get youtubePlayerHint => 'YouTube在可見播放器中播放影片。播放器隱藏或無法播放時，本機鬧鐘會繼續響鈴。';

  @override
  String get musicPreviewFailed => '無法播放此聲音。請檢查連線或嘗試其他歌曲或電台。';

  @override
  String get skyMoonPhase => '月相';

  @override
  String get skyMoonDetailsDisplay => '新增月相頁面';

  @override
  String get skyMoonDetailsHint => '滑動到該頁面，或隨時輕點月亮卡片';

  @override
  String get moonRises => '月出';

  @override
  String get moonSets => '月落';

  @override
  String moonLunarDay(int day) {
    return '本朔望月 29.5 天中的第 $day 天';
  }

  @override
  String get moonDetailsOpen => '開啟月相';

  @override
  String get musicPlaylists => '音樂播放清單';

  @override
  String get videoPlaylists => '影片播放清單';

  @override
  String get likedVideos => '喜歡的影片';

  @override
  String get wholePlaylist => '用整個播放清單喚醒';

  @override
  String get noSongsInPlaylist => '這裡沒有可播放的歌曲。';

  @override
  String get hebrewNamesHeading => '誦讀段與月份名稱的拼寫';

  @override
  String get hebrewNamesIsraeli => '以色列式';

  @override
  String get hebrewNamesAshkenazi => '阿什肯納茲式';

  @override
  String pickFromService(String service) {
    return '從我的 $service 選擇';
  }

  @override
  String get weatherTonight => '今晚';

  @override
  String get weatherTomorrowMorning => '明天早上';

  @override
  String weatherUntilAbout(String time) {
    return '持續到約 $time';
  }

  @override
  String get weatherSunBehindClouds => '太陽在雲後';

  @override
  String get keysLockTitle => '裝置間的金鑰';

  @override
  String get keysLockOff => '你的服務金鑰只保存在這台裝置上。設定同步密語後，可以加密傳送到你的其他裝置。';

  @override
  String get keysLockOn => '你的服務金鑰在離開這台裝置前會以同步密語加密。其他任何人，包括 Google，都無法讀取。';

  @override
  String get keysLockWaiting => '來自你另一台裝置的金鑰已送達，但處於鎖定狀態。輸入同步密語即可開啟。';

  @override
  String get keysSetPassphrase => '設定密語';

  @override
  String get keysChangePassphrase => '變更密語';

  @override
  String get keysUnlock => '解鎖金鑰';

  @override
  String get keysStartOver => '忘記了？重新開始';

  @override
  String get keysStartOverHint => '重新開始會以新密語傳送這台裝置的金鑰。你的其他裝置會要求輸入新密語。';

  @override
  String get keysPassphrase => '同步密語';

  @override
  String get keysPassphraseAgain => '再輸入一次';

  @override
  String keysPassphraseShort(int count) {
    return '至少使用 $count 個字元。';
  }

  @override
  String get keysPassphraseMismatch => '兩次輸入不一致。';

  @override
  String get keysPassphraseWrong => '這個密語打不開這些金鑰。';

  @override
  String get keysPassphraseNote => '請記下來：如果忘記，沒有人能找回，你需要重新輸入金鑰。';

  @override
  String get keysShareNeedsPassphrase => '請先在「裝置間的金鑰」中設定同步密語。';

  @override
  String get settingsAlarmDefaults => '鬧鐘預設值';

  @override
  String get settingsPlacesTime => '地點與時間';

  @override
  String get settingsLook => '外觀、語言與名言';

  @override
  String get settingsAbout => 'About';

  @override
  String get defaultForNewAlarms => '新鬧鐘的預設值';

  @override
  String get preview => 'Preview';

  @override
  String atClock(String time) {
    return 'at $time';
  }

  @override
  String get connectACalendar => '連接行事曆';

  @override
  String get newFromReadyMade => '從現成鬧鐘中選';

  @override
  String get newFromReadyMadeHint => '日出、日落以及其他已為你設定好的鬧鐘';

  @override
  String get calendarSourcesIntro => 'Quando? 可以在行事曆活動前後響鈴。選擇活動來自哪裡。';

  @override
  String get deviceCalendarsHeading => '此裝置';

  @override
  String get deviceCalendarsTitle => '此裝置的行事曆 App';

  @override
  String get deviceCalendarsHint => '裝置上的所有帳號：Google、Samsung、Outlook、iCloud，以及只存在這裡的行事曆。';

  @override
  String get googleCalendarHeading => 'GOOGLE 日曆';

  @override
  String get googleCalendarSignIn => '使用 Google 登入，直接從 Google 讀取行事曆，即使此裝置上沒有你的 Google 帳號。';

  @override
  String googleCalendarSignedIn(String email) {
    return '已登入：$email';
  }

  @override
  String get googleCalendarSignOut => '登出';

  @override
  String get googleCalendarNotHere => '此裝置暫不支援 Google 登入。請在裝置設定（行事曆 › 帳號）中加入 Google 帳號，其行事曆會顯示在此裝置下。';

  @override
  String get googleCalendarUnreachable => '現在無法連線到 Google 日曆。已依它設定的鬧鐘仍會響。';

  @override
  String get googleCalendarTwiceHint => '此裝置已顯示的同一 Google 帳號行事曆預設關閉，避免重複響鈴。';

  @override
  String get timersTitle => '計時器';

  @override
  String get timerStopwatch => '碼錶';

  @override
  String get timerCountdown => '倒數計時';

  @override
  String get timerSequence => '預備';

  @override
  String get timerStopwatchSub => '正計時，附分圈';

  @override
  String get timerCountdownSub => '倒數計時，到零時響鈴';

  @override
  String get timerSequenceSub => '語音起跑與標記';

  @override
  String get timerStart => '開始';

  @override
  String get timerPause => '暫停';

  @override
  String get timerResume => '繼續';

  @override
  String get timerReset => '重設';

  @override
  String get timerLap => '分圈';

  @override
  String get timerTimesUp => '時間到';

  @override
  String get timerSetTime => '設定時間';

  @override
  String get timerMinutes => '分鐘';

  @override
  String get timerSeconds => '秒';

  @override
  String get seqOnYourMarks => '各就各位';

  @override
  String get seqGetSet => '預備';

  @override
  String get seqGo => '跑！';

  @override
  String get seqFinish => '時間到！';

  @override
  String get seqReady => '就緒';

  @override
  String get seqSettings => '設定';

  @override
  String get seqStartCalls => '起跑前的口令';

  @override
  String get seqStartCallsHelp => '在「跑」之前大聲說出，從起點倒數。';

  @override
  String seqCallBefore(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '提前 $n 秒');
    return '$_temp0';
  }

  @override
  String get seqAddCall => '新增口令';

  @override
  String get seqCallText => '要說什麼';

  @override
  String get seqGoText => '開始時說';

  @override
  String get seqFinishText => '結束時說';

  @override
  String get seqLength => '時長';

  @override
  String get seqNoLimit => '無限制';

  @override
  String get seqSayEvery => '每隔多久報時';

  @override
  String get seqOff => '關閉';

  @override
  String seqEverySeconds(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n 秒');
    return '$_temp0';
  }

  @override
  String seqEveryMinutes(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n 分鐘');
    return '$_temp0';
  }

  @override
  String get seqFinalCount => '最後倒數';

  @override
  String get seqMarks => '你的標記';

  @override
  String get seqAddMark => '新增標記';

  @override
  String seqMarkAt(String time) {
    return '在 $time';
  }

  @override
  String get seqSpeak => '朗讀';

  @override
  String get seqBeeps => '提示音與震動';

  @override
  String get seqSayRemaining => '報告剩餘時間，而非已用時間';

  @override
  String get seqPresets => '預設';

  @override
  String get seqPresetRace => '比賽起跑';

  @override
  String get seqPresetSprint => '30 秒衝刺';

  @override
  String get seqPresetRound => '1 分鐘一輪';

  @override
  String get seqHintNoLimit => '「跑」之後一直正計時，直到你停止。';

  @override
  String get seqHintLength => '「跑」之後倒數到零。';

  @override
  String get seqWords => '詞語';

  @override
  String get homeEdit => 'Arrange home';

  @override
  String get homeEditHint => '拖曳握把可移動卡片、收合卡片或調整卡片大小。';

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
  String get homeBlockSky => '太陽、月亮和天氣';

  @override
  String get homeBlockQuick => 'QUICK ALARMS';

  @override
  String get homeBlockShabbat => '安息日與節日';

  @override
  String get homePlaceTitle => '天空城市';

  @override
  String nextAlarmLine(String title, String time) {
    return '下一個鬧鐘 · $title $time';
  }

  @override
  String get showAllAlarms => '顯示所有日期';

  @override
  String get noAlarmsThatDay => '這一天沒有鬧鐘響鈴';

  @override
  String get homeClockSize => '主畫面時鐘';

  @override
  String get sizeSmall => '小';

  @override
  String get sizeMedium => '中';

  @override
  String get sizeLarge => '大';

  @override
  String get homeLayout => '主畫面版面';

  @override
  String get homeLayoutClassic => '經典';

  @override
  String get homeLayoutCards => '卡片';

  @override
  String get homeCardsHint => '拖動卡片即可移動。拖動邊緣或角落調整大小，或選擇尺寸。';

  @override
  String get homeAddCard => '新增卡片';

  @override
  String get homeOnHome => '已在主畫面';

  @override
  String get homeRemoveCard => '移除';

  @override
  String get cardNext => '下一個鬧鐘';

  @override
  String get cardClock => '時鐘和日期';

  @override
  String get cardSky => '太陽、月亮和天氣';

  @override
  String get cardMoon => '月亮';

  @override
  String get cardWeather => '天氣';

  @override
  String get cardAlarms => '你的鬧鐘';

  @override
  String get cardQuick => '快速鬧鐘';

  @override
  String get cardTools => '碼錶、倒數和預備';

  @override
  String get cardWorld => '世界時鐘';

  @override
  String get cardWeek => '本週';

  @override
  String get cardShabbat => '安息日和節日';

  @override
  String get ringAtEventReminders => '在行程自帶的提醒時間響鈴';

  @override
  String get ringAtEventRemindersHint => '日曆 App 裡設定的提醒會在這裡以本鬧鐘的鈴聲大聲響起。';

  @override
  String get atEventReminders => '在行程提醒時';

  @override
  String get everyEventReminderLoud => '每個行程提醒時都大聲響鈴';

  @override
  String get loudNotificationsHeading => '日曆通知大聲響';

  @override
  String get loudNotificationsTitle => '讓日曆通知大聲響鈴';

  @override
  String get loudNotificationsHint => '日曆 App 跳出提醒時，Quando? 會把它當作鬧鐘響起，即使手機處於靜音。';

  @override
  String get loudNotificationsDisclosureTitle => '允許 Quando? 讀取日曆通知？';

  @override
  String get loudNotificationsDisclosure =>
      '要大聲響起日曆提醒，Quando? 需要通知存取權。它只查看你所選日曆 App 的通知，在本機讀取標題和內容以顯示在鬧鐘上，從不儲存或傳送到任何地方。你可以隨時關閉。';

  @override
  String get loudNotificationsAgree => '同意並繼續';

  @override
  String get loudNotificationsNoAccess => '通知存取權已關閉。請在開啟的清單中開啟 Quando?。';

  @override
  String get loudNotificationsAllow => '允許';

  @override
  String get loudNotificationsNoApps => '本機找不到支援的日曆 App。';

  @override
  String get loudNotificationsTwiceNote => '已有 Quando? 日曆鬧鐘的行程只會響一次。';

  @override
  String get loudNotificationsShabbatNote => '安息日和節日期間靜音。';

  @override
  String get busyMode => '忙碌模式';

  @override
  String get busyModeSubtitle => '忙碌時開啟勿擾和自動回覆';

  @override
  String get busyIntro => '忙碌時，Quando? 可以讓手機安靜並替你回覆訊息。鬧鐘照常響。';

  @override
  String get busyIosFocus =>
      '在 iPhone 和 iPad 上，App 無法開啟專注模式或回覆訊息。請在「捷徑」App 中加入「打開 Quando? 時」或定時開啟專注模式的自動化，並在專注模式中設定自動回覆。';

  @override
  String get busyWhileHeading => '忙碌時';

  @override
  String get busyDnd => '勿擾';

  @override
  String get busyDndHint => '僅限優先：來電和訊息靜音，鬧鐘照響。結束後恢復。';

  @override
  String get busyDndNoAccess => 'Quando? 還沒有變更勿擾的權限。';

  @override
  String get busyReplies => '回覆訊息';

  @override
  String get busyRepliesHint => '每人一次，用你的文字，透過 App 自帶的回覆按鈕。僅限 Android。';

  @override
  String get busyRepliesDisclosureTitle => '允許 Quando? 回覆訊息？';

  @override
  String get busyRepliesDisclosure =>
      '為了替你回覆，Quando? 需要通知存取權。僅在你忙碌時，它查看你所選 App 的訊息通知，在本機讀取傳送者名字，並透過 App 自帶的回覆按鈕傳送一次你的文字。訊息從不儲存，也不會傳往別處。除非你允許，群組會被略過。';

  @override
  String get busyReplyText => '你的回覆';

  @override
  String busyReplyTextHint(String until) {
    return '$until 會變成忙碌模式結束的時間。';
  }

  @override
  String busyReplyDefault(String until) {
    return '我現在在忙，$until 後回覆。';
  }

  @override
  String get busyGroups => '群組也回覆';

  @override
  String get busyGroupsHint => '關閉：從不回覆群組。';

  @override
  String get busyRepliesOnShabbat => '安息日和節日也回覆';

  @override
  String get busyAskRabbi => '預設關閉。在安息日開啟前請先請教你的拉比。';

  @override
  String get busyWhenHeading => '何時忙碌';

  @override
  String get busyWhenHint => '在日曆鬧鐘上開啟「這些行程期間忙碌」，或在鬧鐘上開啟「響鈴後忙碌」。';

  @override
  String get busyDuringLock => '鎖定模式開啟時忙碌';

  @override
  String get busyNoneComing => '未來 7 天沒有忙碌時段。';

  @override
  String get busyDuringEvents => '這些行程期間忙碌';

  @override
  String get busyDuringEventsHint => '每個行程從開始到結束都處於忙碌模式。';

  @override
  String get busySettings => '忙碌模式設定';

  @override
  String get busyAfterRing => '響鈴後忙碌';

  @override
  String get busyAfterRingHint => '一段時間內勿擾和自動回覆，例如運動或午睡。';

  @override
  String get shareCard => '分享你的早晨';

  @override
  String get shareCardSubtitle => '今天的天空和名言，或你自己的照片，用於限時動態和狀態';

  @override
  String get shareAppMissing => '這支手機上沒有該 App。';

  @override
  String get shareAsIs => '按原樣分享';

  @override
  String get shareTapQuote => '點按名言可換一句。';

  @override
  String get shareStory => '限時動態';

  @override
  String get shareSquare => '方形';

  @override
  String get shareYourWords => '你自己的話（選填）';

  @override
  String get shareYourWordsHint => '代替今天的名言';

  @override
  String get shareYourPhoto => '你的照片';

  @override
  String get shareOtherPhoto => '換一張照片';

  @override
  String get shareSkyBack => '改用今天的天空';

  @override
  String get shareYourVideo => '你的影片';

  @override
  String get shareInstagramStory => 'Instagram 限時動態';

  @override
  String get shareWhatsApp => 'WhatsApp：狀態或聊天';

  @override
  String get shareMore => '更多 App';

  @override
  String get shareYouPost => 'Quando? 會打開 App 並載入你的卡片。發到哪裡由你選，發佈也由你點。';

  @override
  String get shareAndroidFirst => 'iPhone 和 iPad 即將支援分享。';

  @override
  String songSaved(String name) {
    return '已將「$name」存為鬧鐘鈴聲';
  }

  @override
  String get shareToQuando => '把歌曲分享到 Quando?';

  @override
  String get shareToQuandoHint =>
      '在 YouTube、YouTube Music、Spotify、SoundCloud 或 Apple Music 中點「分享」，再選 Quando?，它就成為在原 App 中播放的鬧鐘鈴聲。';

  @override
  String get askOption => '說出或輸入';

  @override
  String get askOptionHint => '「明天6點」「日出前30分鐘」';

  @override
  String get askHint => '例如：平日日出前30分鐘叫醒我';

  @override
  String get askListening => '正在聽…';

  @override
  String get askNotUnderstood => '沒有找到時間。試試「平日早上7點」或「20分鐘後」。';

  @override
  String askAnswerFromCalendar(String name) {
    return '來自你的行事曆「$name」';
  }

  @override
  String get askAnswerBuiltIn => 'Quando? 為你所在城市計算的時間';

  @override
  String get askNoAnswer => '還沒有找到時間。';

  @override
  String get askNoSpeech => '此裝置不支援語音。你可以輸入。';

  @override
  String get askShabbatOff => '在設定中開啟安息日，安息日時間才會響鈴。';

  @override
  String askSaved(String what) {
    return '已儲存：$what';
  }

  @override
  String get askMic => '說話';

  @override
  String get askMorning => '早上';

  @override
  String get askEvening => '晚上';

  @override
  String get askUnsure => '我可能漏掉了一部分。儲存前請檢查。';

  @override
  String get askTeach => '教我這個';

  @override
  String askTaught(String phrase, String time) {
    return '明白了：「$phrase」現在表示 $time。';
  }

  @override
  String get askSkipAction => '略過';

  @override
  String get askNoMatch => '沒有符合的鬧鐘。';

  @override
  String askTurnedOff(String what) {
    return '已關閉：$what';
  }

  @override
  String askSkipped(String what) {
    return '已略過：$what';
  }

  @override
  String askEventPlan(String offset, String event) {
    return '行事曆中「$event」$offset';
  }

  @override
  String askEventNoCalendar(String event) {
    return '連結行事曆，Quando? 才能找到「$event」。';
  }

  @override
  String askSnoozeAll(int minutes) {
    return '貪睡：$minutes 分鐘，僅適用於這個鬧鐘';
  }

  @override
  String askWakeWith(String sound) {
    return '用$sound叫醒你';
  }

  @override
  String get askReadAs => '理解為';

  @override
  String get askHelpTitle => '協助改進語音鬧鐘';

  @override
  String get askHelpBody => '匿名傳送你說的或輸入的內容以及你的操作。不含帳號或裝置 ID。';

  @override
  String get askHelpPromptTitle => '協助 Quando? 更懂你？';

  @override
  String askHelpPromptBody(String sentence) {
    return '我們會匿名傳送你說的或輸入的內容（如「$sentence」）以及你是否儲存。不含姓名、帳號或裝置 ID。你可以隨時關閉。';
  }

  @override
  String get askHelpYes => '好，幫忙';

  @override
  String get askHelpNo => '不用了';

  @override
  String get askQuoteTranslation => '生活不是人們所經歷的，而是人們所記住的，以及為了講述而如何記住它。';

  @override
  String get askHelpQuote => '';
  String get quickSetups => '快速設定';

  @override
  String get qsMorningTitle => '管用的早晨';

  @override
  String get qsStartTitle => '不錯過任何開始';

  @override
  String get qsStretchTitle => '分段工作';

  @override
  String get qsWillChange => '將變更的內容';

  @override
  String get qsAlreadyOn => '已開啟，無需變更。';

  @override
  String get qsApply => '套用';

  @override
  String get qsDone => '完成';

  @override
  String get qsUndo => '復原';

  @override
  String get qsSnoozeTimes => '允許的貪睡次數';

  @override
  String get qsSnoozeMinutes => '貪睡分鐘數';

  @override
  String get qsFiveLeft => '還剩5分鐘';

  @override
  String get syncHeading => '行事曆變更時';

  @override
  String get syncLive => '跟隨行事曆';

  @override
  String get syncLiveHint => '新活動會有鬧鐘。活動改時間，鬧鐘跟著改；活動刪除，鬧鐘也刪除。';

  @override
  String get syncKeepFirst => '保持最初看到的樣子';

  @override
  String get syncKeepFirstHint => '新活動仍會有鬧鐘。鬧鐘一旦設好就不變，即使活動改時間或被刪除。';

  @override
  String get syncSnapshot => '只要現在已有的活動';

  @override
  String get syncSnapshotHint => '只取儲存時行事曆裡已有的活動，保持現在的樣子。之後不再加入新的。';

  @override
  String get syncHelpButton => '如何運作';

  @override
  String get syncHelpTitle => '鬧鐘如何跟隨你的行事曆';

  @override
  String get syncHelpIntro => '這條規則會一直尋找符合搜尋的活動。行事曆變更時怎麼做，由你選擇。';

  @override
  String get syncHelpExampleLive => '例子：一條「牙醫」規則。牙醫把週二的預約改到週三，你的鬧鐘也改到週三。預約取消，鬧鐘也隨之消失。';

  @override
  String get syncHelpExampleKeepFirst => '同一規則：預約改到週三，但鬧鐘仍留在週二，保持 Quando? 最初看到的樣子。下個月的新預約仍會有自己的鬧鐘。';

  @override
  String get syncHelpExampleSnapshot => '同一規則：今天行事曆裡已有的預約會有鬧鐘，並保持不變。下個月新加的預約不會有鬧鐘。';

  @override
  String get syncHelpTip => '拿不定主意？就保留「跟隨行事曆」。';

  @override
  String get syncHelpWhenTitle => 'Quando? 何時發現變更？';

  @override
  String get syncHelpWhenOpen => 'Quando? 開啟時：幾秒內。在這裡登入的 Google 日曆每 2 分鐘檢查一次。';

  @override
  String get syncHelpWhenClosed => 'Quando? 關閉時：下次開啟時。在那之前，已設好的鬧鐘按原本的時間響。';

  @override
  String get syncHelpWhenClosedApple => 'iPhone 和 iPad 不允許 App 在背景監看行事曆，所以變更會在開啟 Quando? 時同步。';

  @override
  String get tapMiddleToStop => '點按中間即可停止';

  @override
  String get uiSimple => '簡潔';

  @override
  String get uiEverything => '全部';

  @override
  String get firstRunTitle => '你想看到多少？';

  @override
  String get firstRunSimpleHint => '鬧鐘和基本功能';

  @override
  String get firstRunEverythingHint => '日曆、安息日、計時器、天氣等';

  @override
  String get firstRunChangeLater => '你可以隨時在設定中更改。';

  @override
  String get continueLabel => '繼續';

  @override
  String get everyAlarm => '每個鬧鐘';

  @override
  String get wakeMeWith => '喚醒方式';

  @override
  String get ringOrMusic => '鈴聲或音樂';

  @override
  String get ringsForRow => '響鈴時長';

  @override
  String gentleBeforeValue(int minutes) {
    return '提前$minutes分鐘';
  }

  @override
  String get quandoSounds => 'Quando? 鈴聲';

  @override
  String get aSongApps => '一首歌（Spotify、YouTube…）';

  @override
  String get myRecording => '我的錄音';

  @override
  String get useForNewAlarms => '用於新鬧鐘';

  @override
  String get iWillLabel => '鬧鐘響時，我要…';

  @override
  String get foldVolume => '音量與漸變';

  @override
  String get foldSnoozeStop => '貪睡與停止';

  @override
  String get foldExtras => '日曆和其他';

  @override
  String get groupAlarms => '鬧鐘';

  @override
  String get groupCalendarShabbat => '日曆和安息日';

  @override
  String get groupLookQuotes => '外觀和名言';

  @override
  String get groupConnectionsSync => '連線與同步';

  @override
  String qsSummary(int count, int on) {
    return '$count個設定 · $on個已開啟';
  }

  @override
  String get deleteAccount => 'Delete account';

  @override
  String get deleteAccountTitle => 'Delete account?';

  @override
  String get deleteAccountBody => 'Your synced alarms, settings and keys are erased from the cloud and your sign-in is removed. Alarms on this device stay.';

  @override
  String get accountDeleted => 'Account deleted';

  @override
  String get deleteAccountFailed => 'Couldn\'t delete the account. Try again.';
}
