// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Vietnamese (`vi`).
class AppLocalizationsVi extends AppLocalizations {
  AppLocalizationsVi([String locale = 'vi']) : super(locale);

  @override
  String get undo => 'Hoàn tác';

  @override
  String duplicatedNamed(String name) {
    return 'Đã nhân bản “$name”';
  }

  @override
  String deletedNamed(String name) {
    return 'Đã xóa “$name”';
  }

  @override
  String get when => 'Khi nào?';

  @override
  String get newAtTime => 'Vào một giờ cụ thể';

  @override
  String get newAtTimeHint => 'Mỗi ngày làm việc lúc 7:00, một lần lúc 15:30…';

  @override
  String get newAroundEvent => 'Quanh một sự kiện';

  @override
  String get newAroundEventHint =>
      'Tìm trong lịch, giờ Shabbat và giờ mặt trời, rồi reo trước, đúng lúc hoặc sau đó';

  @override
  String get editThisAlarm => 'Sửa báo thức này';

  @override
  String editNamed(String name) {
    return 'Sửa “$name”';
  }

  @override
  String get preset => 'mẫu';

  @override
  String get editThisCalendarRule => 'Sửa quy tắc lịch này';

  @override
  String get ringThisOneAfterAll => 'Vẫn reo lần này';

  @override
  String get skipJustThisOne => 'Chỉ bỏ qua lần này';

  @override
  String get renameGroup => 'Đổi tên nhóm';

  @override
  String quickSet(String label, String time) {
    return '$label · reo lúc $time';
  }

  @override
  String get newAlarm => 'Báo thức mới';

  @override
  String get appName => 'Quando?';

  @override
  String get lockMode => 'Chế độ khóa';

  @override
  String get calendars => 'Lịch';

  @override
  String get settings => 'Cài đặt';

  @override
  String get nextAlarmHeading => 'BÁO THỨC TIẾP THEO';

  @override
  String get nothingSet => 'Chưa đặt gì';

  @override
  String get tagline => 'Mọi việc đều có lúc.';

  @override
  String sunriseAt(String time) {
    return 'Mặt trời mọc $time';
  }

  @override
  String sunsetAt(String time) {
    return 'Mặt trời lặn $time';
  }

  @override
  String get alarmsMayNotRing => 'Báo thức của bạn có thể không reo';

  @override
  String get tapToFixIt => 'Chạm để sửa';

  @override
  String inMinutes(int minutes) {
    return 'Sau $minutes phút';
  }

  @override
  String get atSunset => 'Lúc mặt trời lặn';

  @override
  String get sunset => 'Mặt trời lặn';

  @override
  String get shabbatModeIsOn => 'CHẾ ĐỘ SHABBAT ĐANG BẬT';

  @override
  String nextInCity(String city) {
    return 'TIẾP THEO · $city';
  }

  @override
  String get candleLighting => 'Thắp nến';

  @override
  String get havdalah => 'Havdalah';

  @override
  String get shabbatAndFestivals => 'Shabbat và ngày lễ';

  @override
  String get yourAlarmsHeading => 'BÁO THỨC CỦA BẠN';

  @override
  String get tapWhenToAdd => 'Chạm Khi nào? để thêm báo thức.';

  @override
  String get aroundEventsHeading => 'QUANH SỰ KIỆN';

  @override
  String searchFor(String words) {
    return 'tìm: $words';
  }

  @override
  String get thisWeekHeading => 'BÁO THỨC TUẦN NÀY';

  @override
  String get noAlarmsThisWeek => 'Không có báo thức trong 7 ngày tới.';

  @override
  String get alarmsSetThemselves => 'Báo thức tự đặt trên điện thoại này mỗi khi bạn thay đổi gì đó.';

  @override
  String cityTime(String city) {
    return 'giờ $city';
  }

  @override
  String get more => 'Thêm';

  @override
  String get turnOff => 'Tắt';

  @override
  String get turnOn => 'Bật';

  @override
  String get duplicate => 'Nhân bản';

  @override
  String get delete => 'Xóa';

  @override
  String get inOneHour => 'Sau 1 giờ';

  @override
  String get logoLabel => 'Logo Quando?';

  @override
  String get noTimesSet => 'Chưa đặt giờ';

  @override
  String get atTheMoment => 'đúng lúc đó';

  @override
  String timesRange(int count, String from, String to) {
    return '$count lần · $from đến $to';
  }

  @override
  String spanDays(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n ngày');
    return '$_temp0';
  }

  @override
  String spanHours(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n giờ');
    return '$_temp0';
  }

  @override
  String spanMinutes(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n phút');
    return '$_temp0';
  }

  @override
  String spanSeconds(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n giây');
    return '$_temp0';
  }

  @override
  String get now => 'bây giờ';

  @override
  String spanBefore(String span) {
    return '$span trước';
  }

  @override
  String spanAfter(String span) {
    return '$span sau';
  }

  @override
  String alarmCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n báo thức');
    return '$_temp0';
  }

  @override
  String get allOn => 'tất cả đang bật';

  @override
  String get allOff => 'tất cả đang tắt';

  @override
  String someOn(int n) {
    return '$n đang bật';
  }

  @override
  String skippedBody(String body) {
    return 'Đã bỏ qua · $body';
  }

  @override
  String timeToTime(String from, String to) {
    return '$from – $to';
  }

  @override
  String skippedCount(int n) {
    return '$n đã bỏ qua';
  }

  @override
  String get sunNoRiseSet => 'Hôm nay mặt trời không mọc hay lặn ở đây';

  @override
  String sunProgress(int percent) {
    return 'Mặt trời đã đi qua $percent% ngày';
  }

  @override
  String get sunIsDown => 'Mặt trời đã lặn';

  @override
  String get searchCity => 'Tìm thành phố';

  @override
  String get tomorrowLower => 'ngày mai';

  @override
  String get yesterdayLower => 'hôm qua';

  @override
  String get worldClocksHeading => 'ĐỒNG HỒ THẾ GIỚI';

  @override
  String get add => 'Thêm';

  @override
  String cityHere(String city) {
    return '$city · tại đây';
  }

  @override
  String get worldClocksHint => 'Thêm thành phố để xem giờ ở đây. Vuốt sang trái để xóa.';

  @override
  String get groupNameHint => 'Công việc, Con cái, Phòng tập…';

  @override
  String get cancel => 'Hủy';

  @override
  String get ok => 'OK';

  @override
  String get noGroup => 'Không nhóm';

  @override
  String get newGroupEllipsis => 'Nhóm mới…';

  @override
  String get newGroup => 'Nhóm mới';

  @override
  String secondsShort(int n) {
    return '$n giây';
  }

  @override
  String minutesShort(int n) {
    return '$n phút';
  }

  @override
  String get minutes => 'Phút';

  @override
  String get ringFor => 'Reo trong';

  @override
  String get seconds => 'Giây';

  @override
  String get oneSecondLess => 'Bớt 1 giây';

  @override
  String get oneSecondMore => 'Thêm 1 giây';

  @override
  String inDays(int d) {
    return 'sau $d ngày';
  }

  @override
  String inDaysHours(int d, int h) {
    return 'sau $d ngày $h giờ';
  }

  @override
  String inHours(int h) {
    return 'sau $h giờ';
  }

  @override
  String inHoursMinutes(int h, int m) {
    return 'sau $h giờ $m phút';
  }

  @override
  String inMins(int m) {
    return 'sau $m phút';
  }

  @override
  String placeChange(String city, String where) {
    return '$city · $where · đổi';
  }

  @override
  String get israel => 'Israel';

  @override
  String get outsideIsrael => 'ngoài Israel';

  @override
  String get comingUpHeading => 'SẮP TỚI';

  @override
  String get lockForShabbat => 'Khóa điện thoại cho Shabbat';

  @override
  String get lockForShabbatHint => 'Từ lúc thắp nến đến Havdalah, cả ngày lễ';

  @override
  String get ownShabbatAlarmsHeading => 'BÁO THỨC SHABBAT CỦA BẠN';

  @override
  String get addShabbatAlarm => 'Thêm báo thức Shabbat hoặc ngày lễ';

  @override
  String get readyMadeHeading => 'BÁO THỨC CÓ SẴN';

  @override
  String bringBackDeleted(int n) {
    return 'Khôi phục mục đã xóa ($n)';
  }

  @override
  String get presetsHint => 'Chạm vào một mục để đổi giờ. Vuốt để xóa.';

  @override
  String get lockSentence =>
      'Thu gọn điện thoại chỉ còn đồng hồ và báo thức, cho Shabbat hoặc một đêm tập trung.';

  @override
  String get lockExplain =>
      'Khi khóa, Quando? chỉ hiện giờ, báo thức tiếp theo và lúc khóa kết thúc. Báo thức vẫn hoạt động và không thể thay đổi gì cho đến khi mở khóa.';

  @override
  String get lockNowHeading => 'KHÓA NGAY';

  @override
  String get lockAutoHeading => 'TỰ ĐỘNG KHÓA';

  @override
  String get shabbatAndFestivalsLong => 'Shabbat và ngày lễ';

  @override
  String get fromCandleToHavdalah => 'Từ lúc thắp nến đến Havdalah';

  @override
  String get lockCalendarWord => 'Trong các sự kiện lịch có từ này';

  @override
  String get lockCalendarWordHint => 'vd. khóa, thi, tập trung';

  @override
  String get leaveEmptyForNone => 'Để trống nếu không dùng';

  @override
  String get connectCalendarsFirst => 'Hãy kết nối lịch trước (biểu tượng lịch)';

  @override
  String get openWhenLockStarts => 'Mở Quando? khi bắt đầu khóa';

  @override
  String get openWhenLockStartsHint => 'Một âm thanh nhỏ 1 giây đưa Quando? lên trước để khóa';

  @override
  String get pinToScreen => 'Ghim Quando? vào màn hình';

  @override
  String get pinToScreenHint =>
      'Các ứng dụng khác không mở được khi đang khóa. Android sẽ hỏi xác nhận lần đầu.';

  @override
  String get noLocksComingUp => 'Không có lần khóa nào sắp tới.';

  @override
  String get leaveLockEarly => 'Để thoát sớm, giữ “Giữ để mở khóa” trong 3 giây.';

  @override
  String get locked => 'Đã khóa';

  @override
  String get shabbatShalom => 'Shabbat shalom';

  @override
  String get chagSameach => 'Chag sameach';

  @override
  String get unlocksHeading => 'MỞ KHÓA';

  @override
  String get nowCap => 'Bây giờ';

  @override
  String get nextAlarm => 'Báo thức tiếp theo';

  @override
  String get holdToUnlock => 'Giữ để mở khóa';

  @override
  String get lockSentenceCalm =>
      'Khóa điện thoại chỉ còn đồng hồ và báo thức: cho kỳ thi, cuộc họp hay buổi tối yên tĩnh.';

  @override
  String get lockCalendarHeading => 'THEO LỊCH';

  @override
  String get lockCalendarExplain =>
      'Khóa trong một sự kiện, hoặc từ một sự kiện đến sự kiện tiếp theo bạn chọn. Dùng được với mọi lịch đã chọn, cả lịch chia sẻ.';

  @override
  String get lockAddCalendar => 'Thêm khóa theo lịch';

  @override
  String get lockEditCalendar => 'Khóa theo lịch';

  @override
  String get lockDuring => 'Trong sự kiện';

  @override
  String get lockBetween => 'Giữa hai sự kiện';

  @override
  String get lockStartsAt => 'Sự kiện có tên…';

  @override
  String get lockStartsAtBetween => 'Bắt đầu ở sự kiện tên…';

  @override
  String get lockEndsAt => 'Kết thúc ở sự kiện tiếp theo tên…';

  @override
  String get lockStartHint => 'vd. thi, tập trung, gym';

  @override
  String get lockEndHint => 'vd. về nhà';

  @override
  String get lockAnyCalendar => 'Lịch bất kỳ';

  @override
  String get lockNoMatches => 'Chưa có gì trong lịch khớp.';

  @override
  String get lockNextTimes => 'LẦN TỚI';

  @override
  String lockDuringTitle(String a) {
    return 'Trong “$a”';
  }

  @override
  String lockBetweenTitle(String a, String b) {
    return 'Từ “$a” đến “$b” tiếp theo';
  }

  @override
  String lockShabbatCalendarFound(String name) {
    return '“$name” có giờ Shabbat.';
  }

  @override
  String get lockShabbatFromCalendar => 'Khóa từ lúc thắp nến đến Havdalah';

  @override
  String get lockShabbatFromCalendarHint => 'Dùng giờ trong lịch đó, có nến trên màn hình khóa.';

  @override
  String get lockMoreWays => 'Cách khóa khác';

  @override
  String get lockQuietTime => 'Giờ yên tĩnh';

  @override
  String nextCandleLightingFrom(String time, String name) {
    return 'Lần thắp nến tới: $time, từ $name';
  }

  @override
  String get calendarAlarm => 'Báo thức lịch';

  @override
  String get connectCalendars => 'Kết nối lịch';

  @override
  String get calendarAlarmsHeading => 'BÁO THỨC LỊCH';

  @override
  String get calendarNoneYet => 'Chưa có. Bắt đầu với cái này, rồi thay đổi tùy ý:';

  @override
  String get fifteenBeforeEvery => '15 phút trước mỗi sự kiện';

  @override
  String get useTheseCalendarsHeading => 'DÙNG CÁC LỊCH NÀY';

  @override
  String get noTimedEvents => 'Không có sự kiện có giờ sắp tới trong các lịch này.';

  @override
  String get atTheStart => 'lúc bắt đầu';

  @override
  String everyForBefore(String every, String span) {
    return 'mỗi $every trong $span trước';
  }

  @override
  String spanAfterItEnds(String span) {
    return '$span sau khi kết thúc';
  }

  @override
  String get noAlarmsChosen => 'Chưa chọn báo thức';

  @override
  String get gentleWakeUp => 'Thức dậy nhẹ nhàng';

  @override
  String gentleSummary(int minutes, String sound) {
    return '$minutes phút trước · $sound';
  }

  @override
  String get off => 'Tắt';

  @override
  String get gentleSentence =>
      'Một âm thanh êm dịu bắt đầu khẽ trước báo thức, để bạn không bao giờ giật mình tỉnh dậy.';

  @override
  String get gentleExplain => 'Nó to dần, đưa bạn ra khỏi giấc ngủ nông và dừng ngay trước khi báo thức reo.';

  @override
  String get startsBeforeHeading => 'BẮT ĐẦU TRƯỚC BÁO THỨC';

  @override
  String get leadUpSoundHeading => 'ÂM THANH DẪN';

  @override
  String get listen => 'Nghe thử';

  @override
  String get whoRecordedThese => 'Ai đã thu những âm thanh này';

  @override
  String get done => 'Xong';

  @override
  String get soundCredits => 'Nguồn âm thanh';

  @override
  String yourTimeCity(String city) {
    return 'Giờ của bạn ($city)';
  }

  @override
  String get anotherCity => 'Thành phố khác…';

  @override
  String get ringingIn5 => 'Reo sau 5 giây…';

  @override
  String get alarmSaved => 'Đã lưu báo thức.';

  @override
  String alarmSetFor(String span) {
    return 'Báo thức sẽ reo sau $span.';
  }

  @override
  String hoursMinutesShort(int h, int m) {
    return '$h giờ $m phút';
  }

  @override
  String get editAlarm => 'Sửa báo thức';

  @override
  String get previewCaps => 'NGHE THỬ';

  @override
  String get saveCaps => 'LƯU';

  @override
  String cityTimeForYou(String city, String time) {
    return 'giờ $city · $time giờ của bạn';
  }

  @override
  String repeatHeading(String repeat) {
    return 'LẶP LẠI · $repeat';
  }

  @override
  String get labelField => 'Nhãn (được đọc to nếu bật báo thức bằng giọng nói)';

  @override
  String get group => 'Nhóm';

  @override
  String ringsForHeading(String span) {
    return 'REO TRONG $span';
  }

  @override
  String useDefault(String value) {
    return 'Dùng mặc định ($value)';
  }

  @override
  String get save => 'Lưu';

  @override
  String get sameTime => 'cùng giờ';

  @override
  String get untilYouStopIt => 'Đến khi bạn tắt';

  @override
  String get alarm => 'Báo thức';

  @override
  String get once => 'Một lần';

  @override
  String get everyDay => 'Mỗi ngày';

  @override
  String get weekdays => 'Ngày làm việc';

  @override
  String get weekends => 'Cuối tuần';

  @override
  String timeInCity(String time, String city) {
    return '$time giờ $city';
  }

  @override
  String eventsMatching(String words) {
    return 'Sự kiện có “$words”';
  }

  @override
  String get everyEvent => 'Mọi sự kiện';

  @override
  String get sunrise => 'Mặt trời mọc';

  @override
  String havdalahEndOf(String day) {
    return 'Havdalah · kết thúc $day';
  }

  @override
  String get yomTov => 'Yom tov';

  @override
  String get shabbat => 'Shabbat';

  @override
  String get presetCountdown => 'Đếm ngược đến giờ thắp nến';

  @override
  String get presetHourly => 'Mỗi giờ, từ 6 giờ trước';

  @override
  String get presetDailyWeek => 'Mỗi ngày một lần, trong tuần trước';

  @override
  String get presetSecondNight => 'Nến đêm thứ hai';

  @override
  String get presetFridayReminder => 'Nhắc trước 3 giờ: sạc điện thoại';

  @override
  String get presetFridayReminderLabel => 'Sạc điện thoại và đặt báo thức cho ngày mai';

  @override
  String get presetSunset => 'Mặt trời lặn, và 15 phút trước đó';

  @override
  String get pesach => 'Lễ Vượt Qua';

  @override
  String get shavuot => 'Shavuot';

  @override
  String get roshHashanah => 'Rosh Hashanah';

  @override
  String get yomKippur => 'Yom Kippur';

  @override
  String get sukkot => 'Sukkot';

  @override
  String get sheminiAtzeret => 'Shemini Atzeret';

  @override
  String get simchatTorah => 'Simchat Torah';

  @override
  String get readyNotifications => 'Hiện báo thức';

  @override
  String get readyNotificationsWhy => 'Cho phép màn hình báo thức và nút Tắt hiện lên.';

  @override
  String get readyFullScreen => 'Reo trên màn hình khóa';

  @override
  String get readyFullScreenWhy => 'Hiện báo thức toàn màn hình, kể cả khi điện thoại đang khóa.';

  @override
  String get readyExact => 'Reo đúng phút';

  @override
  String get readyExactWhy => 'Nếu không, điện thoại có thể trễ báo thức vài phút.';

  @override
  String get readyBattery => 'Tiếp tục chạy khi tiết kiệm pin';

  @override
  String get readyBatteryWhy => 'Ngăn chế độ tiết kiệm pin tắt tiếng báo thức vào ban đêm.';

  @override
  String get tipXiaomi =>
      'Điện thoại Xiaomi: trong Cài đặt › Ứng dụng › Quando?, bật Tự khởi động và đặt Tiết kiệm pin thành Không hạn chế.';

  @override
  String get tipSamsung =>
      'Điện thoại Samsung: trong Cài đặt › Pin › Giới hạn sử dụng nền, đảm bảo Quando? không bị đưa vào ngủ.';

  @override
  String get tipHuawei =>
      'Điện thoại Huawei và Honor: trong Cài đặt › Pin › Khởi chạy ứng dụng, đặt Quando? thành Quản lý thủ công và cho phép tất cả.';

  @override
  String get tipOther =>
      'Trên điện thoại này: trong Cài đặt › Pin, cho phép Quando? chạy nền và tắt tối ưu hóa.';

  @override
  String get testRing => 'Reo thử';

  @override
  String get testRingBody => 'Quando? có thể đánh thức bạn';

  @override
  String get ringsIn20 => 'Reo sau 20 giây. Hãy khóa điện thoại ngay và chờ.';

  @override
  String get readyToRing => 'Sẵn sàng reo';

  @override
  String get checkingPhone => 'Đang kiểm tra điện thoại…';

  @override
  String get phoneReady => 'Điện thoại của bạn sẵn sàng reo mọi báo thức đúng giờ.';

  @override
  String thingsNeedFixing(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'Cần sửa $n mục, nếu không báo thức có thể không reo.',
    );
    return '$_temp0';
  }

  @override
  String get fix => 'Sửa';

  @override
  String get testIn20 => 'Thử: reo sau 20 giây';

  @override
  String get testIn20Hint =>
      'Khóa điện thoại và đặt xuống. Nếu báo thức reo toàn màn hình, mọi thứ đã sẵn sàng.';

  @override
  String get readyToRingHint => 'Kiểm tra điện thoại reo mọi báo thức đúng giờ';

  @override
  String get connections => 'Kết nối';

  @override
  String get timeZoneHeading => 'MÚI GIỜ';

  @override
  String get followPhone => 'Theo điện thoại';

  @override
  String followPhoneNow(String city) {
    return 'Hiện là $city. Tự đổi khi bạn đi xa.';
  }

  @override
  String get zoneFixed => 'Cố định. Báo thức giữ giờ này kể cả khi bạn đi xa.';

  @override
  String get shabbatCityHeading => 'THÀNH PHỐ CHO SHABBAT';

  @override
  String get inIsraelOneDay => 'Ở Israel (một ngày lễ)';

  @override
  String candleMinutesHeading(int n) {
    return 'NẾN: $n PHÚT TRƯỚC KHI MẶT TRỜI LẶN';
  }

  @override
  String get endOfShabbatHeading => 'KẾT THÚC SHABBAT VÀ NGÀY LỄ';

  @override
  String get nightfallGeonim => 'Lúc sao mọc (Geonim, 8,5°)';

  @override
  String get rabbeinuTam => '72 phút sau khi mặt trời lặn (Rabbeinu Tam)';

  @override
  String get whenAlarmRingsHeading => 'KHI BÁO THỨC REO';

  @override
  String get recordOrAddSounds => 'Thu hoặc thêm âm thanh';

  @override
  String get ringsForThisLong => 'Reo trong khoảng này, rồi tự dừng';

  @override
  String get sameFades => 'Hiệu ứng to/nhỏ dần giống nhau cho mọi báo thức';

  @override
  String get sameFadesOn => 'Thay hiệu ứng của từng báo thức. Mỗi báo thức giữ âm lượng riêng.';

  @override
  String get sameFadesOff => 'Tắt: mỗi báo thức dùng hiệu ứng đặt trong Âm lượng của nó.';

  @override
  String get sayItOutLoud => 'Đọc to';

  @override
  String get sayItOutLoudHint => 'Đọc báo thức dùng để làm gì, vd. “Thắp nến, 15 phút trước”';

  @override
  String get noSnooze => 'Không báo lại';

  @override
  String snoozeUpTo(int times, int minutes) {
    return 'Báo lại tối đa $times× mỗi lần $minutes phút';
  }

  @override
  String get wakeUpCheck => 'Kiểm tra đã dậy';

  @override
  String get wakeUpCheckHint => 'Sau khi tắt, sẽ reo lại sau 3 phút nếu bạn không chạm “Tôi dậy rồi”';

  @override
  String get solveSum => 'Giải phép tính để tắt';

  @override
  String get provesAwake => 'Chứng minh bạn đã tỉnh';

  @override
  String get shabbatNoTasks =>
      'Vào Shabbat và ngày lễ, những điều này không áp dụng: báo thức tự dừng và không bao giờ yêu cầu chạm vào điện thoại.';

  @override
  String get testAlarmIn1 => 'Reo báo thức thử sau 1 phút';

  @override
  String get timesDisclaimer =>
      'Giờ được tính trên điện thoại. Với trường hợp khó, hãy hỏi rabbi của bạn hoặc xem lịch cộng đồng.';

  @override
  String get recommended => 'Khuyên dùng';

  @override
  String get chooseCity => 'Chọn thành phố';

  @override
  String get testOnlyOnPhone => 'Báo thức thử chỉ chạy trên điện thoại.';

  @override
  String get testAlarm => 'Báo thức thử';

  @override
  String get testAlarmBody => 'Báo thức của bạn sẽ reo như thế này';

  @override
  String get testAlarmIn1Set => 'Báo thức thử sau 1 phút. Bạn có thể khóa điện thoại.';

  @override
  String get presetGone => 'Mẫu này không còn nữa.';

  @override
  String get editPreset => 'Sửa mẫu';

  @override
  String get on => 'Bật';

  @override
  String get ringsHeading => 'REO';

  @override
  String get noTimesYet => 'Chưa có giờ. Thêm ở bên dưới.';

  @override
  String get atTheMomentItself => 'Đúng thời điểm đó';

  @override
  String get remove => 'Xóa';

  @override
  String get addATime => 'Thêm giờ';

  @override
  String get resetPreset => 'Khôi phục bản gốc';

  @override
  String get skipOneHint => 'Để bỏ qua một báo thức, chạm vào nó trong “Báo thức tuần này” ở màn hình chính.';

  @override
  String get unitMinutes => 'phút';

  @override
  String get unitHours => 'giờ';

  @override
  String get unitDays => 'ngày';

  @override
  String get before => 'Trước';

  @override
  String get after => 'Sau';

  @override
  String get oneWeek => '1 tuần';

  @override
  String daysShort(int n) {
    return '$n ngày';
  }

  @override
  String hoursShort(int n) {
    return '$n giờ';
  }

  @override
  String get howToSearch => 'Cách tìm';

  @override
  String get searchHelpWord => 'Tiêu đề có “dentist”, không phân biệt hoa thường';

  @override
  String get searchHelpStar => '* là chữ bất kỳ: dentist, dentures';

  @override
  String get searchHelpQuestion => '? là một chữ: yoga, toga';

  @override
  String get searchHelpPhrase => 'Đúng cụm từ này';

  @override
  String get searchHelpAnd => 'Cả hai từ (AND)';

  @override
  String get searchHelpOr => 'Một trong hai. | cũng được';

  @override
  String get searchHelpNot => 'Loại trừ. NOT và ! cũng được';

  @override
  String get searchHelpBrackets => 'Dấu ngoặc nhóm các từ';

  @override
  String get searchHelpEmpty => 'Để trống để reo ở mọi sự kiện.';

  @override
  String get customTime => 'Thời gian khác';

  @override
  String get other => 'Khác';

  @override
  String get sun => 'Mặt trời';

  @override
  String get calendar => 'Lịch';

  @override
  String get newEventAlarm => 'Báo thức sự kiện mới';

  @override
  String get eventAlarm => 'Báo thức sự kiện';

  @override
  String get findEventsHeading => 'TÌM SỰ KIỆN';

  @override
  String get searchEventsHint => 'Tìm: nha sĩ, gym OR yoga, nha*…';

  @override
  String get alsoBuiltInTimes => 'Cả giờ Shabbat, ngày lễ và mặt trời';

  @override
  String get alsoBuiltInTimesHint => 'vd. “nến*”, “havdalah”, “mặt trời lặn”';

  @override
  String get allMyCalendars => 'Tất cả lịch của tôi';

  @override
  String get connectToSearch => 'Kết nối lịch để tìm trong đó';

  @override
  String get searching => 'Đang tìm…';

  @override
  String get nothingMatches60 => 'Không có kết quả trong 60 ngày tới';

  @override
  String eventsIn60(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n sự kiện trong 60 ngày tới');
    return '$_temp0';
  }

  @override
  String nextRingsAt(String times, String title) {
    return 'Tiếp theo: reo lúc $times cho “$title”';
  }

  @override
  String showMoreLeft(int n) {
    return 'Hiện thêm (còn $n)';
  }

  @override
  String get ringBeforeStartsHeading => 'REO TRƯỚC KHI BẮT ĐẦU';

  @override
  String get ringWhenStarts => 'Reo khi bắt đầu';

  @override
  String get repeatBeforeHeading => 'VÀ LẶP LẠI TRƯỚC ĐÓ';

  @override
  String get everyPrefix => 'Mỗi ';

  @override
  String get offLower => 'tắt';

  @override
  String get forInfix => '  trong ';

  @override
  String get ringAfterEndsHeading => 'REO SAU KHI KẾT THÚC';

  @override
  String get nameOptional => 'Tên (không bắt buộc)';

  @override
  String get toppedUp => 'Báo thức đã được đặt cho 7 ngày tới và được bổ sung mỗi khi bạn mở Quando?.';

  @override
  String get back => 'Quay lại';

  @override
  String get next => 'Tiếp';

  @override
  String get stepWhichEvents => 'Sự kiện nào';

  @override
  String get stepWhenToRing => 'Khi nào reo';

  @override
  String get stepHowItRings => 'Reo thế nào';

  @override
  String defaultNamed(String name) {
    return 'Mặc định ($name)';
  }

  @override
  String get phoneAlarmSound => 'Âm báo thức của điện thoại';

  @override
  String get onlineRadio => 'Radio trực tuyến';

  @override
  String songLinkOpens(String app) {
    return 'Liên kết bài hát · mở $app';
  }

  @override
  String get builtIn => 'Có sẵn';

  @override
  String get yourRecording => 'Bản thu của bạn';

  @override
  String get sound => 'Âm thanh';

  @override
  String get wakeToOwnSound => 'Thức dậy với âm thanh của riêng bạn';

  @override
  String get wakeToOwnSoundHint => 'Giọng bạn, một bài hát, Spotify hoặc radio trực tiếp';

  @override
  String musicAdded(String name) {
    return 'Đã thêm $name. Chọn làm âm thanh cho bất kỳ báo thức nào.';
  }

  @override
  String get playlists => 'Danh sách phát';

  @override
  String get likedSongs => 'Bài hát đã thích';

  @override
  String get noPlaylists => 'Chưa có danh sách phát.';

  @override
  String get noLikedSongs => 'Chưa có bài hát đã thích.';

  @override
  String get needsMic => 'Quando? cần micrô để ghi âm.';

  @override
  String recordingN(int n) {
    return 'Bản ghi $n';
  }

  @override
  String couldNotAddFile(String error) {
    return 'Không thể thêm tệp đó: $error';
  }

  @override
  String get addSongLink => 'Thêm liên kết bài hát';

  @override
  String get songLink => 'Liên kết bài hát';

  @override
  String get songLinkHowTo =>
      'Trong Spotify, Apple Music, YouTube, YouTube Music hoặc SoundCloud, chạm Chia sẻ, rồi Sao chép liên kết, và dán vào đây.';

  @override
  String get songNameHint => 'Tên, vd. Danh sách buổi sáng';

  @override
  String get whenAlarmGoesOffHeading => 'KHI BÁO THỨC REO';

  @override
  String get playTheSong => 'Phát bài hát';

  @override
  String get ringThenOpen => 'Reo, rồi mở';

  @override
  String get playTheSongHint =>
      'Ứng dụng của nó mở ra và phát. Nếu im lặng 10 giây, âm dự phòng sẽ reo để bạn luôn thức dậy. Báo thức có nhiệm vụ sẽ reo trước rồi mới mở.';

  @override
  String get ringThenOpenHint => 'Âm dự phòng reo. Tắt sẽ mở bài hát trong ứng dụng của nó.';

  @override
  String get playForHeading => 'PHÁT TRONG';

  @override
  String get pausesAfter =>
      'Quando? tạm dừng bài hát sau khoảng thời gian này bằng phím tạm dừng của điện thoại.';

  @override
  String get backupSoundHeading => 'ÂM DỰ PHÒNG';

  @override
  String get notALink => 'Đó có vẻ không phải là liên kết.';

  @override
  String songOn(String app) {
    return 'Bài hát trên $app';
  }

  @override
  String get theWeb => 'web';

  @override
  String get pickFromYouTube => 'Chọn từ YouTube của tôi';

  @override
  String get youTubeAndMusic => 'YouTube và YouTube Music';

  @override
  String get youTubeOn => 'Đã kết nối · giữ để đăng xuất';

  @override
  String get youTubeSignIn => 'Đăng nhập bằng Google';

  @override
  String get addSongLinkInstead => 'Hãy thêm liên kết bài hát thay vào đó.';

  @override
  String get googleSignInFailed => 'Đăng nhập Google chưa hoàn tất. Hãy thử lại.';

  @override
  String get myYouTube => 'YouTube của tôi';

  @override
  String get spotifyDirectOn => 'Phát trực tiếp Spotify đang bật';

  @override
  String get spotifyDirect => 'Phát trực tiếp Spotify';

  @override
  String get spotifyDirectOnHint => 'Bật · chạm để tắt';

  @override
  String get spotifyDirectHint => 'Phát đúng bài hát. Cần Premium.';

  @override
  String get spotifyComingSoon => 'Sắp có · cần Premium';

  @override
  String get spotifyFailed =>
      'Spotify không kết nối được. Kiểm tra ứng dụng Spotify đã cài, bạn đã đăng nhập và có Premium.';

  @override
  String get nameThisSound => 'Đặt tên cho âm thanh này';

  @override
  String get sounds => 'Âm thanh';

  @override
  String get soundsSentence =>
      'Thức dậy với giọng nói của bạn, một bài hát, danh sách phát hoặc radio trực tiếp.';

  @override
  String stopTimer(String time) {
    return 'Dừng · $time';
  }

  @override
  String get record => 'Ghi âm';

  @override
  String get addAFile => 'Thêm tệp';

  @override
  String get addSongLinkLong => 'Thêm liên kết bài hát (Spotify, Apple Music, YouTube…)';

  @override
  String get musicAppsHeading => 'ỨNG DỤNG NHẠC';

  @override
  String get pickFromSpotify => 'Chọn từ Spotify của tôi';

  @override
  String get yourPlaylistsAndLiked => 'Danh sách phát và bài hát bạn thích';

  @override
  String get mySpotify => 'Spotify của tôi';

  @override
  String get spotifySignInFailed => 'Không thể đăng nhập Spotify.';

  @override
  String get appleMusicNote => 'Đăng nhập sẽ có cùng phiên bản iPhone. Hiện tại, hãy thêm liên kết bài hát.';

  @override
  String noSignInNote(String service) {
    return '$service không cho ứng dụng khác đăng nhập. Hãy thêm liên kết bài hát thay vào đó.';
  }

  @override
  String get wakeToRadio => 'Thức dậy với radio trực tuyến';

  @override
  String get soundsExplain =>
      'Ghi âm tối đa 5 phút, thêm tệp, liên kết bài hát hoặc radio trực tiếp. Nếu có lỗi, âm dự phòng sẽ reo.';

  @override
  String get yourSoundsHeading => 'ÂM THANH CỦA BẠN';

  @override
  String playsIn(String app) {
    return 'Phát trong $app';
  }

  @override
  String opensIn(String app) {
    return 'Mở trong $app';
  }

  @override
  String forSpan(String span) {
    return 'trong $span';
  }

  @override
  String get defaultLabel => 'Mặc định';

  @override
  String get radioUnreachable => 'Không thể tải danh sách đài. Kiểm tra kết nối của bạn.';

  @override
  String get addStreamAddress => 'Thêm địa chỉ stream';

  @override
  String get notAStream => 'Đó có vẻ không phải địa chỉ stream (bắt đầu bằng http).';

  @override
  String get anyGenre => 'Mọi thể loại';

  @override
  String get stationName => 'Tên đài';

  @override
  String get closeSearch => 'Đóng tìm kiếm';

  @override
  String get searchByName => 'Tìm theo tên';

  @override
  String get anywhere => 'Mọi nơi';

  @override
  String get noStations => 'Không tìm thấy đài. Thử thể loại hoặc quốc gia khác.';

  @override
  String wakeUpTo(String name) {
    return 'Thức dậy với $name';
  }

  @override
  String get notQuite => 'Gần đúng. Thử lại nhé.';

  @override
  String shabbatStopsItself(int n) {
    return 'Chế độ Shabbat: tự dừng sau $n giây. Không cần chạm vào điện thoại.';
  }

  @override
  String get solveToSnooze => 'GIẢI ĐỂ BÁO LẠI';

  @override
  String get solveToStop => 'GIẢI ĐỂ TẮT';

  @override
  String get answer => 'Đáp án';

  @override
  String get snooze => 'Báo lại';

  @override
  String get stop => 'Tắt';

  @override
  String get shakeToSnooze => 'LẮC ĐỂ BÁO LẠI';

  @override
  String get shakeToStop => 'LẮC ĐỂ TẮT';

  @override
  String get shakeHard => 'Lắc mạnh điện thoại đến khi thanh đầy.';

  @override
  String get cantShake => 'Không lắc được? Giải phép tính';

  @override
  String get pairsToSnooze => 'GHÉP CẶP ĐỂ BÁO LẠI';

  @override
  String get pairsToStop => 'GHÉP CẶP ĐỂ TẮT';

  @override
  String get typeToSnooze => 'GÕ CÂU NÀY ĐỂ BÁO LẠI';

  @override
  String get typeToStop => 'GÕ CÂU NÀY ĐỂ TẮT';

  @override
  String get scanToSnooze => 'QUÉT MÃ ĐỂ BÁO LẠI';

  @override
  String get scanToStop => 'QUÉT MÃ ĐỂ TẮT';

  @override
  String ringAgainUnless(int n) {
    return 'Tôi sẽ reo lại sau $n phút nếu bạn không chạm bên dưới.';
  }

  @override
  String get imUp => 'Tôi dậy rồi';

  @override
  String snoozeMin(int n) {
    return 'Báo lại $n phút';
  }

  @override
  String snoozeMinLeft(int n, int left) {
    return 'Báo lại $n phút · còn $left';
  }

  @override
  String get noSnoozesLeft => 'Hết lượt báo lại';

  @override
  String get stopThenOpen => 'Tắt · rồi mở';

  @override
  String get startingSong => 'Đang bắt đầu bài hát';

  @override
  String wayToStop(String way) {
    return '$way để tắt';
  }

  @override
  String wayToSnooze(String way) {
    return '$way để báo lại';
  }

  @override
  String ringsForMore(int n) {
    return 'Reo thêm $n giây';
  }

  @override
  String get leftToRing => 'còn lại';

  @override
  String get wayVolumeButtons => 'Nút âm lượng';

  @override
  String get wayShake => 'Lắc điện thoại';

  @override
  String get taskNothing => 'Không gì';

  @override
  String get taskSum => 'Giải phép tính';

  @override
  String get taskShake => 'Lắc 30 lần';

  @override
  String get taskMemory => 'Trò chơi trí nhớ';

  @override
  String get taskPhrase => 'Gõ một câu';

  @override
  String get taskScan => 'Quét mã';

  @override
  String get noLimit => 'không giới hạn';

  @override
  String upToTimes(int n) {
    return 'tối đa $n×';
  }

  @override
  String shorterEachTime(int n) {
    return 'ngắn hơn $n phút mỗi lần';
  }

  @override
  String autoSnoozeAfter(int n) {
    return 'tự báo lại sau $n phút';
  }

  @override
  String get card => 'Lá bài';

  @override
  String get hiddenCard => 'Lá bài úp';

  @override
  String get phrase1 => 'Tôi đã thức và hôm nay là của tôi';

  @override
  String get phrase2 => 'Không phải bây giờ thì khi nào';

  @override
  String get phrase3 => 'Chào buổi sáng tôi và những người tôi yêu';

  @override
  String get phrase4 => 'Chân tôi chạm đất và tôi đã dậy';

  @override
  String get phrase5 => 'Hôm nay tôi bắt đầu lại';

  @override
  String get notQuiteWords => 'Gần đúng, hãy kiểm tra từng từ.';

  @override
  String get typeItHere => 'Gõ vào đây';

  @override
  String get differentCode => 'Đó là mã khác.';

  @override
  String get cameraUnavailable => 'Máy ảnh không khả dụng.';

  @override
  String get cantScan => 'Không quét được? Giải phép tính';

  @override
  String get saveCodeToScan => 'Lưu một mã để quét';

  @override
  String get saveCodeHint =>
      'Hướng vào mã vạch hoặc mã QR ở nơi bạn phải đi bộ tới, như một hộp trong bếp hoặc kem đánh răng trong phòng tắm. Để tắt báo thức, bạn sẽ quét lại nó.';

  @override
  String get cameraUnavailableSettings => 'Máy ảnh không khả dụng. Cho phép truy cập máy ảnh trong Cài đặt.';

  @override
  String gentleToGo(int n) {
    return 'Thức dậy nhẹ nhàng · còn $n phút';
  }

  @override
  String previewBody(String body) {
    return 'Nghe thử · $body';
  }

  @override
  String snoozedBody(String body) {
    return 'Đã báo lại: $body';
  }

  @override
  String get areYouUp => 'Bạn dậy chưa?';

  @override
  String get tapImUp => 'Chạm “Tôi dậy rồi” để tắt';

  @override
  String get volume => 'Âm lượng';

  @override
  String get wakeCheckOn => 'Kiểm tra đã dậy đang bật';

  @override
  String get stopsAtOnce => 'Dừng ngay';

  @override
  String get ringsAgainIfNotUp => 'Reo lại nếu bạn chưa dậy';

  @override
  String get openAppAfter => 'Mở ứng dụng sau đó';

  @override
  String get noTask => 'Không nhiệm vụ';

  @override
  String get codeSaved => 'Đã lưu mã';

  @override
  String get tapToSaveDifferent => 'Chạm để lưu mã khác';

  @override
  String get controlsHeading => 'ĐIỀU KHIỂN';

  @override
  String get onScreen => 'Trên màn hình';

  @override
  String get taskHeading => 'NHIỆM VỤ';

  @override
  String get none => 'Không';

  @override
  String get snoozeSentence => 'Thêm năm phút? Chọn bao lâu, bao nhiêu lần và cần làm gì.';

  @override
  String get settingsHeading => 'CÀI ĐẶT';

  @override
  String get snoozeTime => 'Thời gian báo lại';

  @override
  String get snoozeTimeHint => 'Lần báo lại đầu tiên dài bao lâu';

  @override
  String get shortenSnoozes => 'Rút ngắn các lần báo lại sau';

  @override
  String get shortenSnoozesHint => 'Mỗi lần báo lại sau lần đầu ngắn hơn chừng này';

  @override
  String get autoSnooze => 'Tự báo lại';

  @override
  String get autoSnoozeHint => 'Nếu bạn không chạm, nó tự báo lại sau';

  @override
  String get never => 'Không bao giờ';

  @override
  String get snoozeLimit => 'Giới hạn báo lại';

  @override
  String get snoozeLimitHint => 'Bạn có thể báo lại bao nhiêu lần';

  @override
  String get unlimited => 'Không giới hạn';

  @override
  String get useSnoozeFromSettings => 'Dùng báo lại từ Cài đặt';

  @override
  String get stopSentence => 'Cách tắt báo thức và việc phải làm trước.';

  @override
  String get shabbatNoTask => 'Vào Shabbat và ngày lễ, báo thức tự dừng và không bao giờ đòi nhiệm vụ.';

  @override
  String get volumeSentence => 'Reo to cỡ nào và lên đến đó nhẹ nhàng ra sao.';

  @override
  String get openAfterAlarm => 'Mở sau báo thức';

  @override
  String get pickAnApp => 'Chọn ứng dụng';

  @override
  String get orPasteLink => 'Hoặc dán liên kết: https://…';

  @override
  String get useThisLink => 'Dùng liên kết này';

  @override
  String get noAppsFound => 'Không tìm thấy ứng dụng.';

  @override
  String get weather => 'Thời tiết';

  @override
  String get news => 'Tin tức';

  @override
  String get usePhoneVolume => 'Dùng âm lượng báo thức của điện thoại';

  @override
  String get setsPhoneVolume => 'Đặt âm lượng báo thức của điện thoại khi reo, rồi trả lại như cũ.';

  @override
  String get fadeInOff => 'Không to dần, âm lượng tối đa ngay';

  @override
  String fadeInOver(String span) {
    return 'To dần trong $span';
  }

  @override
  String get fadeOutOff => 'Không nhỏ dần';

  @override
  String fadeOutOver(String span) {
    return 'Nhỏ dần trong $span cuối';
  }

  @override
  String get fadesExplain =>
      'Nhỏ dần xảy ra khi báo thức tự dừng. Nếu hiệu ứng dài hơn thời gian reo, cả hai sẽ được rút ngắn.';

  @override
  String get soundSoftChime => 'Chuông nhẹ';

  @override
  String get soundMorningRise => 'Bình minh';

  @override
  String get soundClassicBeep => 'Tiếng bíp cổ điển';

  @override
  String get calmCity => 'Buổi sáng phố yên bình';

  @override
  String get calmBirds => 'Chim hót lúc bình minh';

  @override
  String get calmWaves => 'Sóng vỗ bờ';

  @override
  String get calmRain => 'Mưa nhẹ';

  @override
  String get calmStream => 'Suối trong rừng';

  @override
  String get calmWind => 'Gió nhẹ';

  @override
  String get calmFire => 'Lửa tí tách';

  @override
  String get calmNight => 'Đêm hè';

  @override
  String get publicDomain => 'Phạm vi công cộng';

  @override
  String get phoneVolume => 'Âm lượng điện thoại';

  @override
  String fadesIn(String span) {
    return 'to dần trong $span';
  }

  @override
  String fadesOut(String span) {
    return 'nhỏ dần trong $span';
  }

  @override
  String get noFade => 'không hiệu ứng';

  @override
  String minSecShort(int m, int s) {
    return '$m phút $s giây';
  }

  @override
  String get happensRings => 'Reo';

  @override
  String get happensStopped => 'Bạn tắt';

  @override
  String get happensSnoozed => 'Bạn báo lại';

  @override
  String get happensAutoStopped => 'Tự dừng';

  @override
  String get eventLower => 'sự kiện';

  @override
  String get appTest => 'Thử Quando?';

  @override
  String get pushoverConnected => 'Pushover đã kết nối';

  @override
  String get webhookConnected => 'Webhook đã kết nối';

  @override
  String pushoverSaid(int code, String body) {
    return 'Pushover trả về $code: $body';
  }

  @override
  String couldNotReachPushover(String error) {
    return 'Không thể kết nối Pushover ($error)';
  }

  @override
  String itAnswered(int code) {
    return 'Trả về $code';
  }

  @override
  String couldNotReachIt(String error) {
    return 'Không thể kết nối ($error)';
  }

  @override
  String get calendarNotAllowed => 'Chưa được cấp quyền truy cập lịch.';

  @override
  String get playlist => 'Danh sách phát';

  @override
  String songCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n bài hát');
    return '$_temp0';
  }

  @override
  String get spotifySaidNo =>
      'Spotify từ chối. Trong bảng điều khiển Spotify, đánh dấu Web API cho Quando? và thêm tài khoản của bạn vào User Management.';

  @override
  String serviceDidntAnswer(String service, int code) {
    return '$service không phản hồi ($code).';
  }

  @override
  String get youTubeSaidNo =>
      'YouTube từ chối. Kiểm tra tài khoản Google của bạn là người dùng thử của dự án Quando.';

  @override
  String get event => 'Sự kiện';

  @override
  String eventEnds(String title) {
    return '$title (kết thúc)';
  }

  @override
  String foundSoundsDevices(int s, int d) {
    return 'Tìm thấy $s âm thanh và $d thiết bị.';
  }

  @override
  String get sentCheckDevices => 'Đã gửi. Hãy kiểm tra các thiết bị khác.';

  @override
  String sentTo(String name) {
    return 'Đã gửi đến $name.';
  }

  @override
  String get zapierHowTo =>
      'Trong Zapier, tạo một Zap bắt đầu bằng “Webhooks by Zapier → Catch Hook”, rồi dán URL của nó vào đây.';

  @override
  String get catchHookUrl => 'URL Catch Hook';

  @override
  String get iftttHowTo =>
      'Trong IFTTT, tạo một applet bắt đầu bằng “Webhooks → Receive a web request with a JSON payload”. Dùng cùng tên sự kiện ở đây. Khóa của bạn ở ifttt.com/maker_webhooks/settings.';

  @override
  String get eventName => 'Tên sự kiện';

  @override
  String get webhooksKey => 'Khóa Webhooks';

  @override
  String get webhookHowTo => 'Quando? gửi JSON POST đến địa chỉ này.';

  @override
  String get connectionsSentence =>
      'Báo cho ứng dụng và thiết bị khác khi báo thức reo, bị tắt hoặc báo lại.';

  @override
  String get pushWhenRings => 'Gửi thông báo khi báo thức reo';

  @override
  String get pushWhenRingsHint => 'Đến điện thoại, máy tính bảng, đồng hồ hoặc máy tính khác của bạn';

  @override
  String get yourUserKey => 'Khóa người dùng của bạn';

  @override
  String get appToken => 'Token ứng dụng';

  @override
  String get soundAndDevicesHeading => 'ÂM THANH VÀ THIẾT BỊ';

  @override
  String get loading => 'Đang tải…';

  @override
  String get loadFromPushover => 'Tải từ Pushover';

  @override
  String get soundItPlays => 'Âm thanh phát ra';

  @override
  String get myPushoverDefault => 'Mặc định Pushover của tôi';

  @override
  String get pushoverOwnSounds => 'Âm thanh riêng của bạn sẽ hiện ở đây sau khi tải lên pushover.net/sounds.';

  @override
  String get allMyDevices => 'Tất cả thiết bị của tôi';

  @override
  String get pushoverOnThisPhone =>
      'Cài ứng dụng Pushover trên điện thoại này nữa, nó sẽ reo ở đây bằng âm Pushover của bạn.';

  @override
  String get priority => 'Mức ưu tiên';

  @override
  String get priorityNormal => 'Bình thường';

  @override
  String get priorityHigh => 'Cao: bỏ qua giờ yên lặng';

  @override
  String get priorityEmergency => 'Khẩn cấp: lặp lại đến khi xác nhận';

  @override
  String get sending => 'Đang gửi…';

  @override
  String get sendATest => 'Gửi thử';

  @override
  String get findUserKey => 'Tìm khóa người dùng của tôi';

  @override
  String get makeAppToken => 'Tạo token ứng dụng';

  @override
  String get webhooksHeading => 'ZAPIER, IFTTT VÀ WEBHOOK';

  @override
  String get webhooksExplain =>
      'Khởi động bất cứ thứ gì khi báo thức reo hoặc bạn tắt nó: bật đèn, ghi giờ thức dậy, nhắn tin cho ai đó.';

  @override
  String get sendWhenAlarm => 'Gửi khi báo thức:';

  @override
  String get pauseOnShabbat => 'Tạm dừng vào Shabbat và ngày lễ';

  @override
  String get pauseOnShabbatHint => 'Không gửi gì cho báo thức trong khoảng từ thắp nến đến Havdalah';

  @override
  String get webhookPayloadNote =>
      'Mỗi tin nhắn gồm: event (ring, stopped, snoozed, auto_stopped), title, body, time, shabbat và snoozes. Các khóa ở lại trên điện thoại này.';

  @override
  String get today => 'Hôm nay';

  @override
  String get tomorrow => 'Ngày mai';

  @override
  String get notAWebAddress => 'Đó có vẻ không phải địa chỉ web bắt đầu bằng https://';

  @override
  String get language => 'Ngôn ngữ';

  @override
  String get phoneLanguage => 'Ngôn ngữ của điện thoại';

  @override
  String get ringQuote => 'Nếu không phải bây giờ, thì khi nào?';

  @override
  String get ringQuoteBy => 'Hillel';

  @override
  String get quotesTitle => 'Trích dẫn về thời gian';

  @override
  String get quotesHint => 'Chọn nguồn trích dẫn. Mỗi buổi trong ngày một câu; chạm vào câu để xem câu khác.';

  @override
  String get quotesOff => 'Tắt';

  @override
  String get quoteSongs => 'Bài hát';

  @override
  String get quoteMovies => 'Phim';

  @override
  String get quoteLiterature => 'Sách và thơ';

  @override
  String get quoteTanakh => 'Tanakh (Kinh Thánh Hebrew)';

  @override
  String get quoteSages => 'Talmud và các hiền triết';

  @override
  String get quoteSpeeches => 'Bài phát biểu nổi tiếng';

  @override
  String get quotePhilosophy => 'Triết gia';

  @override
  String get quoteProverbs => 'Tục ngữ và châm ngôn';

  @override
  String get quotesAlso => 'Hiển thị thêm';

  @override
  String get quoteCarnaval => 'Lễ hội Carnaval';

  @override
  String get quoteCarnavalHint => 'Bài hát và câu nói trong dịp Carnaval ở Brazil';

  @override
  String get quoteNearMe => 'Gần tôi';

  @override
  String get quoteNearMeHint => 'Nhà thơ và ngày lễ nơi bạn ở, theo múi giờ và thành phố Shabbat';

  @override
  String get quoteSiddur => 'Siddur (sách kinh)';

  @override
  String weeklyParasha(String name) {
    return 'Parashat $name';
  }

  @override
  String poweredBy(String name) {
    return 'chạy trên $name';
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
  String get spotifyLibrarySignIn => 'Danh sách phát, bài đã thích và tìm kiếm';

  @override
  String get spotifyLibraryOn => 'Đã kết nối · giữ để đăng xuất';

  @override
  String spotifyLoginError(String reason) {
    return 'Đăng nhập Spotify không thành công: $reason';
  }

  @override
  String googleSignInError(String reason) {
    return 'Đăng nhập Google không thành công: $reason';
  }

  @override
  String get searchSongsHint => 'Tìm bài hát, nghệ sĩ, danh sách phát';

  @override
  String nothingFound(String query) {
    return 'Không tìm thấy gì cho “$query”.';
  }

  @override
  String get deliveryTitle => 'Cách thông báo';

  @override
  String get deliveryLocal => 'Âm thanh tại máy';

  @override
  String get deliveryBoth => 'Cả hai';

  @override
  String get deliveryConnect => 'Kết nối Pushover';

  @override
  String get deliveryLoadFailed => 'Không tải được âm thanh và thiết bị. Hãy thử lại.';

  @override
  String get deliveryBothHint => 'Âm thanh tại máy vẫn phát nếu Pushover lỗi.';

  @override
  String get deliveryPushHint => 'Chỉ Pushover. Thiết bị này phải trực tuyến khi đến giờ.';

  @override
  String get deliveryFallback => 'Giữ âm thanh tại máy nếu Pushover ngắt kết nối hoặc tạm dừng.';

  @override
  String get deliveryReset => 'Dùng cài đặt hiện có';

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
  String get tuyaSignInTitle => 'Đăng nhập bằng tài khoản Smart Life';

  @override
  String get tuyaSignInHint =>
      'Dùng cùng quốc gia, email hoặc số điện thoại và mật khẩu như trong ứng dụng Smart Life hoặc Tuya Smart. Tài khoản phải được liên kết với dự án Tuya của bạn. Mật khẩu chỉ gửi đến Tuya và không bao giờ được lưu.';

  @override
  String get tuyaCountryCode => 'Mã quốc gia (Brazil 55, Mỹ 1)';

  @override
  String get tuyaAccount => 'Email hoặc số điện thoại Smart Life';

  @override
  String get tuyaPassword => 'Mật khẩu Smart Life';

  @override
  String get tuyaSignIn => 'Đăng nhập và tải kịch bản';

  @override
  String get tuyaRelayUrl => 'Địa chỉ relay Tuya của Quando (https)';

  @override
  String get tuyaRelayHint =>
      'Dùng quốc gia, email hoặc số điện thoại và mật khẩu của tài khoản Smart Life hoặc Tuya Smart. Chúng chỉ được gửi một lần đến relay Tuya của Quando và không được lưu. Bạn cần đăng nhập tài khoản Quando.';

  @override
  String get tuyaGoogleHint =>
      'Đăng nhập Smart Life bằng Google hoặc Apple? Trong Smart Life, chạm “Quên mật khẩu” để đặt mật khẩu, rồi dùng ở đây.';

  @override
  String get tuyaLinked => 'Đã liên kết tài khoản Smart Life';

  @override
  String get tuyaUnlink => 'Hủy liên kết';

  @override
  String get tuyaNeedsAccount => 'Hãy đăng nhập tài khoản Quando trong Cài đặt trước.';

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
      'Phát nhạc theo thời lượng chuông của báo thức này và dừng khi nhấn Dừng hoặc Báo lại.';

  @override
  String get musicBackupPlaying => 'Không thể bắt đầu nhạc. Âm báo thức cục bộ đang phát.';

  @override
  String desktopMusicConnect(String service) {
    return 'Kết nối ứng dụng $service';
  }

  @override
  String desktopMusicOn(String service) {
    return 'Đã kết nối $service · giữ để ngắt';
  }

  @override
  String get musicSongs => 'Bài hát';

  @override
  String get noMusicSongs => 'Không tìm thấy bài hát trong thư viện Nhạc.';

  @override
  String serviceConnectUnavailable(String service) {
    return 'Thêm liên kết $service · mở sau báo thức';
  }

  @override
  String get soundCloudWidgetNote => 'Thêm liên kết công khai';

  @override
  String get youtubePlayerHint =>
      'YouTube phát video trong trình phát hiển thị. Nếu bị ẩn hoặc không thể phát, báo thức cục bộ tiếp tục.';

  @override
  String get musicPreviewFailed =>
      'Không thể phát âm thanh này. Kiểm tra kết nối hoặc thử bài hát hay đài khác.';

  @override
  String get skyMoonPhase => 'Pha Mặt Trăng';

  @override
  String get skyMoonDetailsDisplay => 'Thêm trang pha Mặt Trăng';

  @override
  String get skyMoonDetailsHint => 'Vuốt đến đó hoặc chạm vào thẻ Mặt Trăng bất cứ lúc nào';

  @override
  String get moonRises => 'Mọc';

  @override
  String get moonSets => 'Lặn';

  @override
  String moonLunarDay(int day) {
    return 'Ngày $day trên 29,5 của tháng âm lịch này';
  }

  @override
  String get moonDetailsOpen => 'Mở pha Mặt Trăng';

  @override
  String get musicPlaylists => 'Danh sách nhạc';

  @override
  String get videoPlaylists => 'Danh sách video';

  @override
  String get likedVideos => 'Video đã thích';

  @override
  String get wholePlaylist => 'Thức dậy với cả danh sách';

  @override
  String get noSongsInPlaylist => 'Không có bài nào phát được ở đây.';

  @override
  String get hebrewNamesHeading => 'Cách viết tên parasha và tháng';

  @override
  String get hebrewNamesIsraeli => 'Israel';

  @override
  String get hebrewNamesAshkenazi => 'Ashkenazi';

  @override
  String pickFromService(String service) {
    return 'Chọn từ $service của tôi';
  }

  @override
  String get weatherTonight => 'Tối nay';

  @override
  String get weatherTomorrowMorning => 'Sáng mai';

  @override
  String weatherUntilAbout(String time) {
    return 'đến khoảng $time';
  }

  @override
  String get weatherSunBehindClouds => 'Mặt trời sau mây';

  @override
  String get keysLockTitle => 'Khóa trên các thiết bị của bạn';

  @override
  String get keysLockOff =>
      'Khóa dịch vụ của bạn ở lại trên thiết bị này. Chọn cụm mật khẩu đồng bộ để gửi chúng, đã mã hóa, sang các thiết bị khác.';

  @override
  String get keysLockOn =>
      'Khóa dịch vụ của bạn được mã hóa bằng cụm mật khẩu đồng bộ trước khi rời thiết bị này. Không ai khác, kể cả Google, đọc được.';

  @override
  String get keysLockWaiting =>
      'Khóa từ thiết bị khác của bạn đã đến đây và đang bị khóa. Nhập cụm mật khẩu đồng bộ để mở.';

  @override
  String get keysSetPassphrase => 'Chọn cụm mật khẩu';

  @override
  String get keysChangePassphrase => 'Đổi cụm mật khẩu';

  @override
  String get keysUnlock => 'Mở khóa';

  @override
  String get keysStartOver => 'Quên rồi? Bắt đầu lại';

  @override
  String get keysStartOverHint =>
      'Bắt đầu lại sẽ gửi khóa của thiết bị này với cụm mật khẩu mới. Các thiết bị khác sẽ hỏi cụm mới.';

  @override
  String get keysPassphrase => 'Cụm mật khẩu đồng bộ';

  @override
  String get keysPassphraseAgain => 'Nhập lại';

  @override
  String keysPassphraseShort(int count) {
    return 'Dùng ít nhất $count ký tự.';
  }

  @override
  String get keysPassphraseMismatch => 'Hai lần nhập không khớp.';

  @override
  String get keysPassphraseWrong => 'Cụm mật khẩu này không mở được các khóa này.';

  @override
  String get keysPassphraseNote =>
      'Hãy ghi lại: nếu quên, không ai khôi phục được và bạn sẽ phải nhập lại khóa.';

  @override
  String get keysShareNeedsPassphrase =>
      'Hãy chọn cụm mật khẩu đồng bộ trước, trong Khóa trên các thiết bị của bạn.';

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
      'Quando? có thể reo trước và sau các sự kiện trong lịch của bạn. Chọn lịch lấy từ đâu.';

  @override
  String get deviceCalendarsHeading => 'TRÊN THIẾT BỊ NÀY';

  @override
  String get deviceCalendarsTitle => 'Ứng dụng lịch của thiết bị này';

  @override
  String get deviceCalendarsHint =>
      'Mọi tài khoản trên máy: Google, Samsung, Outlook, iCloud và các lịch chỉ lưu tại đây.';

  @override
  String get googleCalendarHeading => 'GOOGLE LỊCH';

  @override
  String get googleCalendarSignIn =>
      'Đăng nhập bằng Google để đọc lịch trực tiếp từ Google, kể cả khi tài khoản Google không có trên thiết bị này.';

  @override
  String googleCalendarSignedIn(String email) {
    return 'Đã đăng nhập: $email';
  }

  @override
  String get googleCalendarSignOut => 'Đăng xuất';

  @override
  String get googleCalendarNotHere =>
      'Thiết bị này chưa hỗ trợ đăng nhập Google. Hãy thêm tài khoản Google trong cài đặt thiết bị (Lịch › Tài khoản), các lịch sẽ hiện trong mục thiết bị này.';

  @override
  String get googleCalendarUnreachable =>
      'Hiện không kết nối được Google Lịch. Báo thức đã đặt từ đó vẫn reo.';

  @override
  String get googleCalendarTwiceHint =>
      'Các lịch của cùng tài khoản Google mà thiết bị đã hiển thị sẽ tắt lúc đầu, để không gì reo hai lần.';

  @override
  String get timersTitle => 'Hẹn giờ';

  @override
  String get timerStopwatch => 'Bấm giờ';

  @override
  String get timerCountdown => 'Đếm ngược';

  @override
  String get timerSequence => 'Sẵn sàng';

  @override
  String get timerStopwatchSub => 'Đếm lên, có vòng';

  @override
  String get timerCountdownSub => 'Đếm ngược, reo khi về không';

  @override
  String get timerSequenceSub => 'Xuất phát và mốc bằng giọng nói';

  @override
  String get timerStart => 'Bắt đầu';

  @override
  String get timerPause => 'Tạm dừng';

  @override
  String get timerResume => 'Tiếp tục';

  @override
  String get timerReset => 'Đặt lại';

  @override
  String get timerLap => 'Vòng';

  @override
  String get timerTimesUp => 'Hết giờ';

  @override
  String get timerSetTime => 'Đặt thời gian';

  @override
  String get timerMinutes => 'Phút';

  @override
  String get timerSeconds => 'Giây';

  @override
  String get seqOnYourMarks => 'Vào vị trí';

  @override
  String get seqGetSet => 'Sẵn sàng';

  @override
  String get seqGo => 'Chạy!';

  @override
  String get seqFinish => 'Hết giờ!';

  @override
  String get seqReady => 'Sẵn sàng';

  @override
  String get seqSettings => 'Cài đặt';

  @override
  String get seqStartCalls => 'Lời hô trước khi xuất phát';

  @override
  String get seqStartCallsHelp => 'Được nói to trước khi Chạy, đếm ngược từ lúc xuất phát.';

  @override
  String seqCallBefore(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: 'Trước $n giây');
    return '$_temp0';
  }

  @override
  String get seqAddCall => 'Thêm lời hô';

  @override
  String get seqCallText => 'Nói gì';

  @override
  String get seqGoText => 'Lúc bắt đầu, nói';

  @override
  String get seqFinishText => 'Lúc kết thúc, nói';

  @override
  String get seqLength => 'Độ dài';

  @override
  String get seqNoLimit => 'Không giới hạn';

  @override
  String get seqSayEvery => 'Đọc giờ mỗi';

  @override
  String get seqOff => 'Tắt';

  @override
  String seqEverySeconds(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n giây');
    return '$_temp0';
  }

  @override
  String seqEveryMinutes(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n phút');
    return '$_temp0';
  }

  @override
  String get seqFinalCount => 'Đếm ngược những giây cuối';

  @override
  String get seqMarks => 'Các mốc của bạn';

  @override
  String get seqAddMark => 'Thêm mốc';

  @override
  String seqMarkAt(String time) {
    return 'Lúc $time';
  }

  @override
  String get seqSpeak => 'Nói thành tiếng';

  @override
  String get seqBeeps => 'Tiếng bíp và rung';

  @override
  String get seqSayRemaining => 'Đọc thời gian còn lại, không phải đã trôi qua';

  @override
  String get seqPresets => 'Mẫu có sẵn';

  @override
  String get seqPresetRace => 'Xuất phát cuộc đua';

  @override
  String get seqPresetSprint => 'Nỗ lực 30 giây';

  @override
  String get seqPresetRound => 'Hiệp 1 phút';

  @override
  String get seqHintNoLimit => 'Sau Chạy, nó đếm lên cho đến khi bạn dừng.';

  @override
  String get seqHintLength => 'Sau Chạy, nó đếm ngược về không.';

  @override
  String get seqWords => 'Từ';

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
  String get homeClockSize => 'Đồng hồ trên màn hình chính';

  @override
  String get sizeSmall => 'Nhỏ';

  @override
  String get sizeMedium => 'Vừa';

  @override
  String get sizeLarge => 'Lớn';

  @override
  String get homeLayout => 'Bố cục màn hình chính';

  @override
  String get homeLayoutClassic => 'Cổ điển';

  @override
  String get homeLayoutCards => 'Thẻ';

  @override
  String get homeCardsHint =>
      'Kéo thẻ để di chuyển. Kéo cạnh hoặc góc để đổi kích thước, hoặc chọn kích thước.';

  @override
  String get homeAddCard => 'Thêm thẻ';

  @override
  String get homeOnHome => 'Trên màn hình';

  @override
  String get homeRemoveCard => 'Gỡ';

  @override
  String get cardNext => 'Báo thức tiếp theo';

  @override
  String get cardClock => 'Đồng hồ và ngày';

  @override
  String get cardSky => 'Mặt trời, mặt trăng và thời tiết';

  @override
  String get cardMoon => 'Mặt trăng';

  @override
  String get cardWeather => 'Thời tiết';

  @override
  String get cardAlarms => 'Báo thức của bạn';

  @override
  String get cardQuick => 'Báo thức nhanh';

  @override
  String get cardTools => 'Bấm giờ, đếm ngược và chuẩn bị';

  @override
  String get cardWorld => 'Đồng hồ thế giới';

  @override
  String get cardWeek => 'Tuần này';

  @override
  String get cardShabbat => 'Shabbat và ngày lễ';

  @override
  String get ringAtEventReminders => 'Reo vào lời nhắc của chính sự kiện';

  @override
  String get ringAtEventRemindersHint =>
      'Lời nhắc trong ứng dụng lịch sẽ reo to tại đây như báo thức, bằng âm thanh của báo thức này.';

  @override
  String get atEventReminders => 'vào lời nhắc của sự kiện';

  @override
  String get everyEventReminderLoud => 'Reo to vào lời nhắc của mọi sự kiện';

  @override
  String get loudNotificationsHeading => 'THÔNG BÁO LỊCH THẬT TO';

  @override
  String get loudNotificationsTitle => 'Cho thông báo lịch reo thật to';

  @override
  String get loudNotificationsHint =>
      'Khi ứng dụng lịch hiện lời nhắc, Quando? sẽ reo như báo thức, kể cả khi điện thoại để im lặng.';

  @override
  String get loudNotificationsDisclosureTitle => 'Cho phép Quando? đọc thông báo lịch?';

  @override
  String get loudNotificationsDisclosure =>
      'Để reo to lời nhắc lịch, Quando? cần quyền truy cập thông báo. Ứng dụng chỉ xem thông báo từ các ứng dụng lịch bạn chọn, đọc tiêu đề và nội dung ngay trên điện thoại này để hiện trên báo thức, và không bao giờ lưu hay gửi đi đâu. Bạn có thể tắt bất cứ lúc nào.';

  @override
  String get loudNotificationsAgree => 'Đồng ý và tiếp tục';

  @override
  String get loudNotificationsNoAccess =>
      'Quyền truy cập thông báo đang tắt. Hãy bật Quando? trong danh sách mở ra.';

  @override
  String get loudNotificationsAllow => 'Cho phép';

  @override
  String get loudNotificationsNoApps => 'Không tìm thấy ứng dụng lịch được hỗ trợ trên điện thoại này.';

  @override
  String get loudNotificationsTwiceNote => 'Sự kiện đã có báo thức lịch Quando? chỉ reo một lần.';

  @override
  String get loudNotificationsShabbatNote => 'Im lặng trong ngày Sabát và lễ.';

  @override
  String get busyMode => 'Chế độ bận';

  @override
  String get busyModeSubtitle => 'Không làm phiền và tự động trả lời khi bạn bận';

  @override
  String get busyIntro =>
      'Khi bạn bận, Quando? có thể làm điện thoại im lặng và trả lời tin nhắn thay bạn. Báo thức vẫn reo.';

  @override
  String get busyIosFocus =>
      'Trên iPhone và iPad, ứng dụng không thể bật Tập trung hay trả lời tin nhắn. Trong ứng dụng Phím tắt, hãy tạo tự động hóa \"Khi mở Quando?\" hoặc theo giờ để bật Tập trung, rồi đặt Tập trung tự động trả lời.';

  @override
  String get busyWhileHeading => 'KHI BẠN BẬN';

  @override
  String get busyDnd => 'Không làm phiền';

  @override
  String get busyDndHint =>
      'Chỉ ưu tiên: cuộc gọi và tin nhắn im lặng, báo thức vẫn reo. Kết thúc thì trở lại bình thường.';

  @override
  String get busyDndNoAccess => 'Quando? chưa được phép đổi Không làm phiền.';

  @override
  String get busyReplies => 'Trả lời tin nhắn';

  @override
  String get busyRepliesHint =>
      'Mỗi người một lần, bằng nội dung của bạn, qua nút Trả lời của chính ứng dụng. Chỉ Android.';

  @override
  String get busyRepliesDisclosureTitle => 'Cho phép Quando? trả lời tin nhắn?';

  @override
  String get busyRepliesDisclosure =>
      'Để trả lời thay bạn, Quando? cần quyền truy cập thông báo. Chỉ khi bạn bận, ứng dụng xem thông báo tin nhắn từ các ứng dụng bạn chọn, đọc tên người gửi ngay trên điện thoại này và gửi nội dung của bạn một lần qua nút Trả lời của chính ứng dụng. Tin nhắn không bao giờ được lưu hay gửi đi nơi khác. Nhóm sẽ bị bỏ qua trừ khi bạn cho phép.';

  @override
  String get busyReplyText => 'Câu trả lời của bạn';

  @override
  String busyReplyTextHint(String until) {
    return '$until sẽ thành giờ kết thúc chế độ bận.';
  }

  @override
  String busyReplyDefault(String until) {
    return 'Mình đang bận, sẽ trả lời sau $until.';
  }

  @override
  String get busyGroups => 'Trả lời cả trong nhóm';

  @override
  String get busyGroupsHint => 'Tắt: không bao giờ trả lời nhóm.';

  @override
  String get busyRepliesOnShabbat => 'Trả lời cả trong Sabát và lễ';

  @override
  String get busyAskRabbi => 'Mặc định tắt. Hãy hỏi giáo sĩ của bạn trước khi bật cho ngày Sabát.';

  @override
  String get busyWhenHeading => 'KHI NÀO BẠN BẬN';

  @override
  String get busyWhenHint =>
      'Bật \"Bận trong các sự kiện này\" ở báo thức lịch, hoặc \"Bận sau khi reo\" ở báo thức.';

  @override
  String get busyDuringLock => 'Bận khi bật chế độ khóa';

  @override
  String get busyNoneComing => 'Không có lúc bận trong 7 ngày tới.';

  @override
  String get busyDuringEvents => 'Bận trong các sự kiện này';

  @override
  String get busyDuringEventsHint => 'Chế độ bận từ lúc bắt đầu đến khi kết thúc mỗi sự kiện.';

  @override
  String get busySettings => 'Cài đặt chế độ bận';

  @override
  String get busyAfterRing => 'Bận sau khi reo';

  @override
  String get busyAfterRingHint => 'Không làm phiền và tự động trả lời một lúc, như tập thể dục hay ngủ trưa.';

  @override
  String get shareCard => 'Chia sẻ buổi sáng';

  @override
  String get shareCardSubtitle => 'Bầu trời và câu nói hôm nay, hoặc ảnh của bạn, cho Tin và trạng thái';

  @override
  String get shareAppMissing => 'Điện thoại không có ứng dụng đó.';

  @override
  String get shareAsIs => 'Chia sẻ nguyên bản';

  @override
  String get shareTapQuote => 'Chạm vào câu nói để đổi câu khác.';

  @override
  String get shareStory => 'Tin';

  @override
  String get shareSquare => 'Vuông';

  @override
  String get shareYourWords => 'Lời của bạn (không bắt buộc)';

  @override
  String get shareYourWordsHint => 'Thay cho câu nói hôm nay';

  @override
  String get shareYourPhoto => 'Ảnh của bạn';

  @override
  String get shareOtherPhoto => 'Ảnh khác';

  @override
  String get shareSkyBack => 'Bầu trời hôm nay';

  @override
  String get shareYourVideo => 'Video của bạn';

  @override
  String get shareInstagramStory => 'Tin Instagram';

  @override
  String get shareWhatsApp => 'WhatsApp: trạng thái hoặc trò chuyện';

  @override
  String get shareMore => 'Ứng dụng khác';

  @override
  String get shareYouPost => 'Quando? mở ứng dụng với thẻ đã sẵn sàng. Bạn chọn nơi đăng và tự nhấn Đăng.';

  @override
  String get shareAndroidFirst => 'Sắp có chia sẻ trên iPhone và iPad.';

  @override
  String songSaved(String name) {
    return 'Đã lưu “$name” làm âm báo thức';
  }

  @override
  String get shareToQuando => 'Chia sẻ bài hát tới Quando?';

  @override
  String get shareToQuandoHint =>
      'Trong YouTube, YouTube Music, Spotify, SoundCloud hoặc Apple Music, nhấn Chia sẻ rồi Quando?. Bài hát thành âm báo thức phát trong chính ứng dụng đó.';

  @override
  String get askOption => 'Nói hoặc gõ';

  @override
  String get askOptionHint => '“Mai 6 giờ”, “30 phút trước bình minh”';

  @override
  String get askHint => 'vd: đánh thức tôi 30 phút trước bình minh vào ngày thường';

  @override
  String get askListening => 'Đang nghe…';

  @override
  String get askNotUnderstood => 'Không tìm thấy giờ. Thử “7 giờ sáng ngày thường” hoặc “sau 20 phút”.';

  @override
  String askAnswerFromCalendar(String name) {
    return 'Từ lịch “$name” của bạn';
  }

  @override
  String get askAnswerBuiltIn => 'Giờ của Quando? cho thành phố của bạn';

  @override
  String get askNoAnswer => 'Chưa tìm thấy giờ.';

  @override
  String get askNoSpeech => 'Thiết bị này không hỗ trợ giọng nói. Bạn có thể gõ.';

  @override
  String get askShabbatOff => 'Bật Shabbat trong Cài đặt để giờ Shabbat đổ chuông.';

  @override
  String askSaved(String what) {
    return 'Đã lưu: $what';
  }

  @override
  String get askMic => 'Nói';

  @override
  String get askMorning => 'Sáng';

  @override
  String get askEvening => 'Tối';

  @override
  String get askUnsure => 'Có thể tôi đã bỏ sót một phần. Hãy kiểm tra trước khi lưu.';

  @override
  String get askTeach => 'Dạy tôi điều này';

  @override
  String askTaught(String phrase, String time) {
    return 'Đã hiểu: “$phrase” giờ có nghĩa là $time.';
  }

  @override
  String get askSkipAction => 'Bỏ qua';

  @override
  String get askNoMatch => 'Không có báo thức nào khớp.';

  @override
  String askTurnedOff(String what) {
    return 'Đã tắt: $what';
  }

  @override
  String askSkipped(String what) {
    return 'Đã bỏ qua: $what';
  }

  @override
  String askEventPlan(String offset, String event) {
    return '$offset “$event” trong lịch của bạn';
  }

  @override
  String askEventNoCalendar(String event) {
    return 'Kết nối lịch để Quando? tìm được “$event”.';
  }

  @override
  String askSnoozeAll(int minutes) {
    return 'Báo lại: $minutes phút, cho báo thức này';
  }

  @override
  String askWakeWith(String sound) {
    return 'Đánh thức bạn bằng $sound';
  }

  @override
  String get askReadAs => 'Được hiểu là';
}
