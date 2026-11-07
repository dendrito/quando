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
  String get calendarAlarm => '日历闹钟';

  @override
  String get calendarIntro => 'Quando? 可以在手机日历中的事件前后响铃。手机上登录 Google 帐号后，Google 日历也会包含在内。';

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
  String get youTubeOn => '你的歌单和喜欢的歌曲。长按退出登录。';

  @override
  String get youTubeSignIn => '使用 Google 登录，从你的歌单和喜欢的歌曲中选择。';

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
  String get spotifyDirectOnHint => 'Spotify 会把你的那首歌作为闹钟播放。点按关闭。';

  @override
  String get spotifyDirectHint => '把你的 Spotify 歌曲作为闹钟播放，更加可靠。需要 Spotify 应用和 Spotify Premium。点按登录。';

  @override
  String get spotifyComingSoon => '即将推出：把你的 Spotify 歌曲作为闹钟播放（需要 Spotify Premium）。';

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
  String get soundsExplain =>
      '录下你的声音、一首歌或任何内容，最长 5 分钟。从手机添加 MP3、M4A 或 WAV。链接一首歌或歌单：它的应用会把它作为闹钟播放，并带备用铃声。或选择一个电台：直播播放，如果连接失败，则响起手机闹钟。';

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
  String get spotifyLibrarySignIn => '登录后可从你的歌单和喜欢的歌曲中选择，或搜索整个 Spotify。无需 Premium。';

  @override
  String get spotifyLibraryOn => '你的歌单、喜欢的歌曲和搜索。长按退出登录。';

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
  String get musicRingDurationHint => '播放遵循此闹钟的响铃时长，并在停止或稍后提醒时结束。';

  @override
  String get musicBackupPlaying => '无法开始播放音乐。正在播放本地闹钟声音。';

  @override
  String desktopMusicConnect(String service) {
    return '连接此Mac上的$service应用。请先在应用中登录；macOS将请求授权。';
  }

  @override
  String desktopMusicOn(String service) {
    return '已连接此Mac上的$service。使用闹钟的响铃时长。长按可断开连接。';
  }

  @override
  String get musicSongs => '歌曲';

  @override
  String get noMusicSongs => '在音乐资料库中未找到歌曲。';

  @override
  String serviceConnectUnavailable(String service) {
    return '此平台不支持连接$service账户。停止闹钟后可以打开链接。';
  }

  @override
  String get soundCloudWidgetNote => '添加公开的歌曲或播放列表链接。官方播放器遵循闹钟时长；不支持账户登录。';

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
  String get calendarAlarm => '日曆鬧鐘';

  @override
  String get calendarIntro => 'Quando? 可以在手機日曆中的事件前後響鈴。手機上登入 Google 帳號後，Google 日曆也會包含在內。';

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
  String get youTubeOn => '你的播放清單和喜歡的歌曲。長按登出。';

  @override
  String get youTubeSignIn => '使用 Google 登入，從你的播放清單和喜歡的歌曲中選擇。';

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
  String get spotifyDirectOnHint => 'Spotify 會把你的那首歌作為鬧鐘播放。點按關閉。';

  @override
  String get spotifyDirectHint => '把你的 Spotify 歌曲作為鬧鐘播放，更加可靠。需要 Spotify App 和 Spotify Premium。點按登入。';

  @override
  String get spotifyComingSoon => '即將推出：把你的 Spotify 歌曲作為鬧鐘播放（需要 Spotify Premium）。';

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
  String get soundsExplain =>
      '錄下你的聲音、一首歌或任何內容，最長 5 分鐘。從手機新增 MP3、M4A 或 WAV。連結一首歌或播放清單：它的 App 會把它作為鬧鐘播放，並帶備用鈴聲。或選擇一個電台：直播播放，如果連線失敗，則響起手機鬧鐘。';

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
  String get spotifyLibrarySignIn => '登入後可從你的播放清單和喜歡的歌曲中選擇，或搜尋整個 Spotify。不需要 Premium。';

  @override
  String get spotifyLibraryOn => '你的播放清單、喜歡的歌曲和搜尋。長按以登出。';

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
  String get musicRingDurationHint => '播放遵循此鬧鐘的響鈴時長，並在停止或稍後提醒時結束。';

  @override
  String get musicBackupPlaying => '無法開始播放音樂。正在播放本機鬧鐘聲音。';

  @override
  String desktopMusicConnect(String service) {
    return '連接此Mac上的$service應用程式。請先在應用程式中登入；macOS將請求授權。';
  }

  @override
  String desktopMusicOn(String service) {
    return '已連接此Mac上的$service。使用鬧鐘的響鈴時長。長按可中斷連線。';
  }

  @override
  String get musicSongs => '歌曲';

  @override
  String get noMusicSongs => '在音樂資料庫中找不到歌曲。';

  @override
  String serviceConnectUnavailable(String service) {
    return '此平台不支援連接$service帳戶。停止鬧鐘後可以開啟連結。';
  }

  @override
  String get soundCloudWidgetNote => '新增公開的歌曲或播放清單連結。官方播放器遵循鬧鐘時長；不支援帳戶登入。';

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
}
