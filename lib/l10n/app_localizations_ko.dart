// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get undo => '실행 취소';

  @override
  String duplicatedNamed(String name) {
    return '“$name” 복제됨';
  }

  @override
  String deletedNamed(String name) {
    return '“$name” 삭제됨';
  }

  @override
  String get when => '언제?';

  @override
  String get newAtTime => '시간 지정';

  @override
  String get newAtTimeHint => '평일 7:00, 한 번만 15:30…';

  @override
  String get newAroundEvent => '일정에 맞춰';

  @override
  String get newAroundEventHint => '캘린더, 안식일과 해 시간에서 찾아 전, 정각, 후에 울리기';

  @override
  String get editThisAlarm => '이 알람 편집';

  @override
  String editNamed(String name) {
    return '“$name” 편집';
  }

  @override
  String get preset => '템플릿';

  @override
  String get editThisCalendarRule => '이 캘린더 규칙 편집';

  @override
  String get ringThisOneAfterAll => '그래도 울리기';

  @override
  String get skipJustThisOne => '이번만 건너뛰기';

  @override
  String get renameGroup => '그룹 이름 변경';

  @override
  String quickSet(String label, String time) {
    return '$label · $time에 울림';
  }

  @override
  String get newAlarm => '새 알람';

  @override
  String get appName => 'Quando?';

  @override
  String get lockMode => '잠금 모드';

  @override
  String get calendars => '캘린더';

  @override
  String get settings => '설정';

  @override
  String get nextAlarmHeading => '다음 알람';

  @override
  String get nothingSet => '설정된 알람 없음';

  @override
  String get tagline => '모든 것에는 때가 있다.';

  @override
  String sunriseAt(String time) {
    return '일출 $time';
  }

  @override
  String sunsetAt(String time) {
    return '일몰 $time';
  }

  @override
  String get alarmsMayNotRing => '알람이 울리지 않을 수 있어요';

  @override
  String get tapToFixIt => '탭하여 해결';

  @override
  String inMinutes(int minutes) {
    return '$minutes분 후';
  }

  @override
  String get atSunset => '일몰 때';

  @override
  String get sunset => '일몰';

  @override
  String get shabbatModeIsOn => '안식일 모드 켜짐';

  @override
  String nextInCity(String city) {
    return '다음 · $city';
  }

  @override
  String get candleLighting => '촛불 점화';

  @override
  String get havdalah => '하브달라';

  @override
  String get shabbatAndFestivals => '안식일 및 절기';

  @override
  String get yourAlarmsHeading => '내 알람';

  @override
  String get tapWhenToAdd => '“언제?”를 탭해 알람을 추가하세요.';

  @override
  String get aroundEventsHeading => '일정에 맞춘 알람';

  @override
  String searchFor(String words) {
    return '검색: $words';
  }

  @override
  String get thisWeekHeading => '이번 주 알람';

  @override
  String get noAlarmsThisWeek => '앞으로 7일간 알람이 없어요.';

  @override
  String get alarmsSetThemselves => '무언가를 바꿀 때마다 알람이 이 휴대폰에 자동으로 설정돼요.';

  @override
  String cityTime(String city) {
    return '$city 시간';
  }

  @override
  String get more => '더보기';

  @override
  String get turnOff => '끄기';

  @override
  String get turnOn => '켜기';

  @override
  String get duplicate => '복제';

  @override
  String get delete => '삭제';

  @override
  String get inOneHour => '1시간 후';

  @override
  String get logoLabel => 'Quando? 로고';

  @override
  String get noTimesSet => '설정된 시간 없음';

  @override
  String get atTheMoment => '그 순간';

  @override
  String timesRange(int count, String from, String to) {
    return '$count회 · $from~$to';
  }

  @override
  String spanDays(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n일');
    return '$_temp0';
  }

  @override
  String spanHours(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n시간');
    return '$_temp0';
  }

  @override
  String spanMinutes(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n분');
    return '$_temp0';
  }

  @override
  String spanSeconds(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n초');
    return '$_temp0';
  }

  @override
  String get now => '지금';

  @override
  String spanBefore(String span) {
    return '$span 전';
  }

  @override
  String spanAfter(String span) {
    return '$span 후';
  }

  @override
  String alarmCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '알람 $n개');
    return '$_temp0';
  }

  @override
  String get allOn => '모두 켜짐';

  @override
  String get allOff => '모두 꺼짐';

  @override
  String someOn(int n) {
    return '$n개 켜짐';
  }

  @override
  String skippedBody(String body) {
    return '건너뜀 · $body';
  }

  @override
  String timeToTime(String from, String to) {
    return '$from – $to';
  }

  @override
  String skippedCount(int n) {
    return '$n개 건너뜀';
  }

  @override
  String get sunNoRiseSet => '오늘 이곳은 해가 뜨거나 지지 않아요';

  @override
  String sunProgress(int percent) {
    return '해가 하루의 $percent%를 지났어요';
  }

  @override
  String get sunIsDown => '해가 졌어요';

  @override
  String get searchCity => '도시 검색';

  @override
  String get tomorrowLower => '내일';

  @override
  String get yesterdayLower => '어제';

  @override
  String get worldClocksHeading => '세계 시계';

  @override
  String get add => '추가';

  @override
  String cityHere(String city) {
    return '$city · 여기';
  }

  @override
  String get worldClocksHint => '도시를 추가하면 여기서 시간을 볼 수 있어요. 왼쪽으로 밀어 삭제하세요.';

  @override
  String get groupNameHint => '직장, 아이들, 헬스…';

  @override
  String get cancel => '취소';

  @override
  String get ok => '확인';

  @override
  String get noGroup => '그룹 없음';

  @override
  String get newGroupEllipsis => '새 그룹…';

  @override
  String get newGroup => '새 그룹';

  @override
  String secondsShort(int n) {
    return '$n초';
  }

  @override
  String minutesShort(int n) {
    return '$n분';
  }

  @override
  String get minutes => '분';

  @override
  String get ringFor => '울리는 시간';

  @override
  String get seconds => '초';

  @override
  String get oneSecondLess => '1초 줄이기';

  @override
  String get oneSecondMore => '1초 늘리기';

  @override
  String inDays(int d) {
    return '$d일 후';
  }

  @override
  String inDaysHours(int d, int h) {
    return '$d일 $h시간 후';
  }

  @override
  String inHours(int h) {
    return '$h시간 후';
  }

  @override
  String inHoursMinutes(int h, int m) {
    return '$h시간 $m분 후';
  }

  @override
  String inMins(int m) {
    return '$m분 후';
  }

  @override
  String placeChange(String city, String where) {
    return '$city · $where · 변경';
  }

  @override
  String get israel => '이스라엘';

  @override
  String get outsideIsrael => '이스라엘 외';

  @override
  String get comingUpHeading => '다가오는 일정';

  @override
  String get lockForShabbat => '안식일 동안 휴대폰 잠금';

  @override
  String get lockForShabbatHint => '촛불 점화부터 하브달라까지, 절기에도';

  @override
  String get ownShabbatAlarmsHeading => '내 안식일 알람';

  @override
  String get addShabbatAlarm => '안식일 또는 절기 알람 추가';

  @override
  String get readyMadeHeading => '준비된 알람';

  @override
  String bringBackDeleted(int n) {
    return '삭제한 알람 복원 ($n)';
  }

  @override
  String get presetsHint => '탭해서 시간을 바꾸고, 밀어서 삭제하세요.';

  @override
  String get lockSentence => '안식일이나 집중하고 싶은 밤을 위해 휴대폰을 시계와 알람만 남겨요.';

  @override
  String get lockExplain =>
      '잠금 중에는 Quando?가 시간, 다음 알람, 잠금 종료 시각만 보여 줘요. 알람은 계속 작동하고, 잠금이 풀릴 때까지 아무것도 바꿀 수 없어요.';

  @override
  String get lockNowHeading => '지금 잠그기';

  @override
  String get lockAutoHeading => '자동 잠금';

  @override
  String get shabbatAndFestivalsLong => '안식일 및 절기';

  @override
  String get fromCandleToHavdalah => '촛불 점화부터 하브달라까지';

  @override
  String get lockCalendarWord => '이 단어가 있는 캘린더 일정 동안';

  @override
  String get lockCalendarWordHint => '예: 잠금, 시험, 집중';

  @override
  String get leaveEmptyForNone => '사용하지 않으려면 비워 두세요';

  @override
  String get connectCalendarsFirst => '먼저 캘린더를 연결하세요 (캘린더 아이콘)';

  @override
  String get openWhenLockStarts => '잠금이 시작되면 Quando? 열기';

  @override
  String get openWhenLockStartsHint => '1초짜리 조용한 소리로 Quando?를 앞으로 불러와 잠가요';

  @override
  String get pinToScreen => 'Quando?를 화면에 고정';

  @override
  String get pinToScreenHint => '잠금 중에는 다른 앱이 열리지 않아요. 처음에는 Android가 확인을 요청해요.';

  @override
  String get noLocksComingUp => '예정된 잠금이 없어요.';

  @override
  String get leaveLockEarly => '일찍 나가려면 “길게 눌러 잠금 해제”를 3초간 누르세요.';

  @override
  String get locked => '잠김';

  @override
  String get shabbatShalom => '샤밧 샬롬';

  @override
  String get chagSameach => '하그 사메악';

  @override
  String get unlocksHeading => '잠금 해제';

  @override
  String get nowCap => '지금';

  @override
  String get nextAlarm => '다음 알람';

  @override
  String get holdToUnlock => '길게 눌러 잠금 해제';

  @override
  String get lockSentenceCalm => '시험, 회의, 조용한 저녁을 위해 시계와 알람만 남기고 잠급니다.';

  @override
  String get lockCalendarHeading => '캘린더로';

  @override
  String get lockCalendarExplain => '일정 동안, 또는 한 일정부터 지정한 다음 일정까지 잠급니다. 선택한 모든 캘린더, 공유 캘린더에서도 됩니다.';

  @override
  String get lockAddCalendar => '캘린더 잠금 추가';

  @override
  String get lockEditCalendar => '캘린더 잠금';

  @override
  String get lockDuring => '일정 동안';

  @override
  String get lockBetween => '두 일정 사이';

  @override
  String get lockStartsAt => '이름이 이런 일정…';

  @override
  String get lockStartsAtBetween => '이 이름의 일정에서 시작…';

  @override
  String get lockEndsAt => '이 이름의 다음 일정에서 끝…';

  @override
  String get lockStartHint => '예: 시험, 집중, 헬스';

  @override
  String get lockEndHint => '예: 귀가';

  @override
  String get lockAnyCalendar => '모든 캘린더';

  @override
  String get lockNoMatches => '아직 캘린더에 맞는 일정이 없습니다.';

  @override
  String get lockNextTimes => '다음 시간';

  @override
  String lockDuringTitle(String a) {
    return '“$a” 동안';
  }

  @override
  String lockBetweenTitle(String a, String b) {
    return '“$a”부터 다음 “$b”까지';
  }

  @override
  String lockShabbatCalendarFound(String name) {
    return '“$name”에 안식일 시간이 있습니다.';
  }

  @override
  String get lockShabbatFromCalendar => '촛불 점화부터 하브달라까지 잠금';

  @override
  String get lockShabbatFromCalendarHint => '그 캘린더의 시간을 쓰고 잠금 화면에 촛불을 보여 줍니다.';

  @override
  String get lockMoreWays => '다른 잠금 방법';

  @override
  String get lockQuietTime => '조용한 시간';

  @override
  String nextCandleLightingFrom(String time, String name) {
    return '다음 촛불 점화: $time, $name에서';
  }

  @override
  String get calendarAlarm => '캘린더 알람';

  @override
  String get connectCalendars => '캘린더 연결';

  @override
  String get calendarAlarmsHeading => '캘린더 알람';

  @override
  String get calendarNoneYet => '아직 없어요. 이것부터 시작해서 원하는 대로 바꾸세요:';

  @override
  String get fifteenBeforeEvery => '모든 일정 15분 전';

  @override
  String get useTheseCalendarsHeading => '사용할 캘린더';

  @override
  String get noTimedEvents => '이 캘린더에 시간이 정해진 예정 일정이 없어요.';

  @override
  String get atTheStart => '시작할 때';

  @override
  String everyForBefore(String every, String span) {
    return '$span 전부터 $every마다';
  }

  @override
  String spanAfterItEnds(String span) {
    return '끝나고 $span 후';
  }

  @override
  String get noAlarmsChosen => '선택한 알람 없음';

  @override
  String get gentleWakeUp => '부드러운 기상';

  @override
  String gentleSummary(int minutes, String sound) {
    return '$minutes분 전 · $sound';
  }

  @override
  String get off => '끔';

  @override
  String get gentleSentence => '알람 전에 차분한 소리가 조용히 시작되어 깜짝 놀라 깨지 않아요.';

  @override
  String get gentleExplain => '천천히 커지며 얕은 잠에서 깨우고, 알람이 울리기 직전에 멈춰요.';

  @override
  String get startsBeforeHeading => '알람 전에 시작';

  @override
  String get leadUpSoundHeading => '도입 소리';

  @override
  String get listen => '듣기';

  @override
  String get whoRecordedThese => '이 소리를 녹음한 사람';

  @override
  String get done => '완료';

  @override
  String get soundCredits => '사운드 출처';

  @override
  String yourTimeCity(String city) {
    return '내 시간 ($city)';
  }

  @override
  String get anotherCity => '다른 도시…';

  @override
  String get ringingIn5 => '5초 후 울려요…';

  @override
  String get alarmSaved => '알람을 저장했어요.';

  @override
  String alarmSetFor(String span) {
    return '$span 후에 알람이 울려요.';
  }

  @override
  String hoursMinutesShort(int h, int m) {
    return '$h시간 $m분';
  }

  @override
  String get editAlarm => '알람 편집';

  @override
  String get previewCaps => '미리 듣기';

  @override
  String get saveCaps => '저장';

  @override
  String cityTimeForYou(String city, String time) {
    return '$city 시간 · 내 시간 $time';
  }

  @override
  String repeatHeading(String repeat) {
    return '반복 · $repeat';
  }

  @override
  String get labelField => '라벨 (음성 알람이 켜져 있으면 소리 내어 읽음)';

  @override
  String get group => '그룹';

  @override
  String ringsForHeading(String span) {
    return '$span 동안 울림';
  }

  @override
  String useDefault(String value) {
    return '기본값 사용 ($value)';
  }

  @override
  String get save => '저장';

  @override
  String get sameTime => '같은 시간';

  @override
  String get untilYouStopIt => '끌 때까지';

  @override
  String get alarm => '알람';

  @override
  String get once => '한 번';

  @override
  String get everyDay => '매일';

  @override
  String get weekdays => '평일';

  @override
  String get weekends => '주말';

  @override
  String timeInCity(String time, String city) {
    return '$city 시간 $time';
  }

  @override
  String eventsMatching(String words) {
    return '“$words” 포함 일정';
  }

  @override
  String get everyEvent => '모든 일정';

  @override
  String get sunrise => '일출';

  @override
  String havdalahEndOf(String day) {
    return '하브달라 · $day 끝';
  }

  @override
  String get yomTov => '욤 토브';

  @override
  String get shabbat => '안식일';

  @override
  String get presetCountdown => '촛불 점화 카운트다운';

  @override
  String get presetHourly => '6시간 전부터 매시간';

  @override
  String get presetDailyWeek => '전주에 하루 한 번';

  @override
  String get presetSecondNight => '둘째 날 밤 촛불';

  @override
  String get presetFridayReminder => '3시간 전 알림: 휴대폰 충전';

  @override
  String get presetFridayReminderLabel => '휴대폰을 충전하고 내일 알람을 설정하세요';

  @override
  String get presetSunset => '일몰, 그리고 15분 전';

  @override
  String get pesach => '유월절';

  @override
  String get shavuot => '칠칠절';

  @override
  String get roshHashanah => '로시 하샤나';

  @override
  String get yomKippur => '욤 키푸르';

  @override
  String get sukkot => '초막절';

  @override
  String get sheminiAtzeret => '셰미니 아체레트';

  @override
  String get simchatTorah => '심핫 토라';

  @override
  String get readyNotifications => '알람 표시';

  @override
  String get readyNotificationsWhy => '알람 화면과 중지 버튼이 나타나게 해요.';

  @override
  String get readyFullScreen => '잠금 화면 위에 울리기';

  @override
  String get readyFullScreenWhy => '휴대폰이 잠겨 있어도 알람을 전체 화면으로 보여 줘요.';

  @override
  String get readyExact => '정확한 분에 울리기';

  @override
  String get readyExactWhy => '이게 없으면 휴대폰이 알람을 몇 분 늦출 수 있어요.';

  @override
  String get readyBattery => '절전 모드에서도 실행';

  @override
  String get readyBatteryWhy => '절전 기능이 밤에 알람을 무음으로 만드는 것을 막아요.';

  @override
  String get tipXiaomi => 'Xiaomi 휴대폰: 설정 › 앱 › Quando?에서 자동 시작을 켜고 배터리 절약을 제한 없음으로 설정하세요.';

  @override
  String get tipSamsung => 'Samsung 휴대폰: 설정 › 배터리 › 백그라운드 사용 제한에서 Quando?가 절전 상태가 아닌지 확인하세요.';

  @override
  String get tipHuawei => 'Huawei·Honor 휴대폰: 설정 › 배터리 › 앱 실행에서 Quando?를 수동 관리로 바꾸고 모두 허용하세요.';

  @override
  String get tipOther => '이 휴대폰에서: 설정 › 배터리에서 Quando?의 백그라운드 실행을 허용하고 최적화를 끄세요.';

  @override
  String get testRing => '테스트 알람';

  @override
  String get testRingBody => 'Quando?가 깨워 줄 수 있어요';

  @override
  String get ringsIn20 => '20초 후에 울려요. 지금 휴대폰을 잠그고 기다리세요.';

  @override
  String get readyToRing => '울릴 준비';

  @override
  String get checkingPhone => '휴대폰 확인 중…';

  @override
  String get phoneReady => '휴대폰이 모든 알람을 제시간에 울릴 준비가 됐어요.';

  @override
  String thingsNeedFixing(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n개 항목을 해결해야 해요. 그렇지 않으면 알람이 울리지 않을 수 있어요.',
    );
    return '$_temp0';
  }

  @override
  String get fix => '해결';

  @override
  String get testIn20 => '테스트: 20초 후 울림';

  @override
  String get testIn20Hint => '휴대폰을 잠그고 내려놓으세요. 알람이 전체 화면으로 울리면 준비 완료예요.';

  @override
  String get readyToRingHint => '휴대폰이 모든 알람을 제시간에 울리는지 확인';

  @override
  String get connections => '연결';

  @override
  String get timeZoneHeading => '시간대';

  @override
  String get followPhone => '휴대폰 따라가기';

  @override
  String followPhoneNow(String city) {
    return '지금은 $city. 여행하면 자동으로 바뀌어요.';
  }

  @override
  String get zoneFixed => '고정. 여행 중에도 알람이 이 시간을 유지해요.';

  @override
  String get shabbatCityHeading => '안식일 기준 도시';

  @override
  String get inIsraelOneDay => '이스라엘 (절기 하루)';

  @override
  String candleMinutesHeading(int n) {
    return '촛불: 일몰 $n분 전';
  }

  @override
  String get endOfShabbatHeading => '안식일 및 절기 종료';

  @override
  String get nightfallGeonim => '별이 뜰 때 (게오님, 8.5°)';

  @override
  String get rabbeinuTam => '일몰 72분 후 (라베이누 탐)';

  @override
  String get whenAlarmRingsHeading => '알람이 울릴 때';

  @override
  String get recordOrAddSounds => '소리 녹음 또는 추가';

  @override
  String get ringsForThisLong => '이만큼 울리고 저절로 멈춰요';

  @override
  String get sameFades => '모든 알람에 같은 페이드';

  @override
  String get sameFadesOn => '각 알람의 페이드를 대신해요. 음량은 각자 유지돼요.';

  @override
  String get sameFadesOff => '끔: 각 알람이 자기 음량 설정의 페이드를 사용해요.';

  @override
  String get sayItOutLoud => '소리 내어 읽기';

  @override
  String get sayItOutLoudHint => '알람의 용도를 읽어 줘요. 예: “촛불 점화, 15분 전”';

  @override
  String get noSnooze => '다시 알림 없음';

  @override
  String snoozeUpTo(int times, int minutes) {
    return '$minutes분씩 최대 $times회 다시 알림';
  }

  @override
  String get wakeUpCheck => '기상 확인';

  @override
  String get wakeUpCheckHint => '끈 뒤 “일어났어요”를 누르지 않으면 3분 후 다시 울려요';

  @override
  String get solveSum => '문제를 풀어 끄기';

  @override
  String get provesAwake => '깨어 있음을 확인해요';

  @override
  String get shabbatNoTasks => '안식일과 절기에는 이 중 아무것도 적용되지 않아요. 알람은 저절로 멈추고 휴대폰을 만지라고 하지 않아요.';

  @override
  String get testAlarmIn1 => '1분 후 테스트 알람 울리기';

  @override
  String get timesDisclaimer => '시간은 휴대폰에서 계산돼요. 애매한 경우에는 랍비에게 묻거나 공동체 달력을 확인하세요.';

  @override
  String get recommended => '추천';

  @override
  String get chooseCity => '도시 선택';

  @override
  String get testOnlyOnPhone => '테스트 알람은 휴대폰에서만 작동해요.';

  @override
  String get testAlarm => '테스트 알람';

  @override
  String get testAlarmBody => '알람은 이렇게 울려요';

  @override
  String get testAlarmIn1Set => '1분 후 테스트 알람. 휴대폰을 잠가도 돼요.';

  @override
  String get presetGone => '이 템플릿은 더 이상 없어요.';

  @override
  String get editPreset => '템플릿 편집';

  @override
  String get on => '켬';

  @override
  String get ringsHeading => '울림';

  @override
  String get noTimesYet => '아직 시간이 없어요. 아래에서 추가하세요.';

  @override
  String get atTheMomentItself => '바로 그 순간';

  @override
  String get remove => '삭제';

  @override
  String get addATime => '시간 추가';

  @override
  String get resetPreset => '원래대로';

  @override
  String get skipOneHint => '한 번만 건너뛰려면 홈 화면의 “이번 주 알람”에서 탭하세요.';

  @override
  String get unitMinutes => '분';

  @override
  String get unitHours => '시간';

  @override
  String get unitDays => '일';

  @override
  String get before => '전';

  @override
  String get after => '후';

  @override
  String get oneWeek => '1주';

  @override
  String daysShort(int n) {
    return '$n일';
  }

  @override
  String hoursShort(int n) {
    return '$n시간';
  }

  @override
  String get howToSearch => '검색 방법';

  @override
  String get searchHelpWord => '제목에 “dentist” 포함, 대소문자 무관';

  @override
  String get searchHelpStar => '*는 아무 글자: dentist, dentures';

  @override
  String get searchHelpQuestion => '?는 한 글자: yoga, toga';

  @override
  String get searchHelpPhrase => '정확히 이 문구';

  @override
  String get searchHelpAnd => '두 단어 모두 (AND)';

  @override
  String get searchHelpOr => '둘 중 하나. |도 가능';

  @override
  String get searchHelpNot => '제외. NOT과 !도 가능';

  @override
  String get searchHelpBrackets => '괄호로 단어를 묶어요';

  @override
  String get searchHelpEmpty => '비워 두면 모든 일정에 울려요.';

  @override
  String get customTime => '다른 시간';

  @override
  String get other => '기타';

  @override
  String get sun => '해';

  @override
  String get calendar => '캘린더';

  @override
  String get newEventAlarm => '새 일정 알람';

  @override
  String get eventAlarm => '일정 알람';

  @override
  String get findEventsHeading => '일정 찾기';

  @override
  String get searchEventsHint => '검색: 치과, 헬스 OR 요가, 치*…';

  @override
  String get alsoBuiltInTimes => '안식일, 절기, 해 시간도';

  @override
  String get alsoBuiltInTimesHint => '예: “촛불*”, “하브달라”, “일몰”';

  @override
  String get allMyCalendars => '내 모든 캘린더';

  @override
  String get connectToSearch => '캘린더를 연결하면 검색할 수 있어요';

  @override
  String get searching => '검색 중…';

  @override
  String get nothingMatches60 => '앞으로 60일간 일치하는 항목 없음';

  @override
  String eventsIn60(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '앞으로 60일간 일정 $n개');
    return '$_temp0';
  }

  @override
  String nextRingsAt(String times, String title) {
    return '다음: “$title” 위해 $times에 울림';
  }

  @override
  String showMoreLeft(int n) {
    return '더 보기 ($n개 남음)';
  }

  @override
  String get ringBeforeStartsHeading => '시작 전에 울리기';

  @override
  String get ringWhenStarts => '시작할 때 울리기';

  @override
  String get repeatBeforeHeading => '그리고 전에 반복';

  @override
  String get everyPrefix => '';

  @override
  String get offLower => '끔';

  @override
  String get forInfix => '마다 · ';

  @override
  String get ringAfterEndsHeading => '끝난 후 울리기';

  @override
  String get nameOptional => '이름 (선택)';

  @override
  String get toppedUp => '알람은 앞으로 7일간 설정되어 있고, Quando?를 열 때마다 채워져요.';

  @override
  String get back => '뒤로';

  @override
  String get next => '다음';

  @override
  String get stepWhichEvents => '어떤 일정';

  @override
  String get stepWhenToRing => '언제 울릴지';

  @override
  String get stepHowItRings => '어떻게 울릴지';

  @override
  String defaultNamed(String name) {
    return '기본값 ($name)';
  }

  @override
  String get phoneAlarmSound => '휴대폰 알람 소리';

  @override
  String get onlineRadio => '인터넷 라디오';

  @override
  String songLinkOpens(String app) {
    return '노래 링크 · $app 열기';
  }

  @override
  String get builtIn => '기본 제공';

  @override
  String get yourRecording => '내 녹음';

  @override
  String get sound => '소리';

  @override
  String get wakeToOwnSound => '나만의 소리로 일어나기';

  @override
  String get wakeToOwnSoundHint => '내 목소리, 노래, Spotify 또는 라이브 라디오';

  @override
  String musicAdded(String name) {
    return '$name 추가됨. 어떤 알람의 소리로든 선택하세요.';
  }

  @override
  String get playlists => '재생목록';

  @override
  String get likedSongs => '좋아요 표시한 곡';

  @override
  String get noPlaylists => '아직 재생목록이 없어요.';

  @override
  String get noLikedSongs => '아직 좋아요 표시한 곡이 없어요.';

  @override
  String get needsMic => '녹음하려면 Quando?에 마이크가 필요해요.';

  @override
  String recordingN(int n) {
    return '녹음 $n';
  }

  @override
  String couldNotAddFile(String error) {
    return '파일을 추가할 수 없어요: $error';
  }

  @override
  String get addSongLink => '노래 링크 추가';

  @override
  String get songLink => '노래 링크';

  @override
  String get songLinkHowTo =>
      'Spotify, Apple Music, YouTube, YouTube Music, SoundCloud에서 공유 → 링크 복사를 탭하고 여기에 붙여 넣으세요.';

  @override
  String get songNameHint => '이름, 예: 아침 재생목록';

  @override
  String get whenAlarmGoesOffHeading => '알람이 울리면';

  @override
  String get playTheSong => '노래 재생';

  @override
  String get ringThenOpen => '울린 후 열기';

  @override
  String get playTheSongHint => '해당 앱이 열려 재생해요. 10초간 조용하면 백업 소리가 울려서 항상 깰 수 있어요. 미션이 있는 알람은 먼저 울린 뒤 열어요.';

  @override
  String get ringThenOpenHint => '백업 소리가 울려요. 중지하면 앱에서 노래가 열려요.';

  @override
  String get playForHeading => '재생 시간';

  @override
  String get pausesAfter => '이 시간이 지나면 Quando?가 휴대폰의 일시정지 키로 노래를 멈춰요.';

  @override
  String get backupSoundHeading => '백업 소리';

  @override
  String get notALink => '링크가 아닌 것 같아요.';

  @override
  String songOn(String app) {
    return '$app의 노래';
  }

  @override
  String get theWeb => '웹';

  @override
  String get pickFromYouTube => '내 YouTube에서 선택';

  @override
  String get youTubeAndMusic => 'YouTube 및 YouTube Music';

  @override
  String get youTubeOn => '연결됨 · 길게 눌러 로그아웃';

  @override
  String get youTubeSignIn => 'Google로 로그인';

  @override
  String get addSongLinkInstead => '대신 노래 링크를 추가하세요.';

  @override
  String get googleSignInFailed => 'Google 로그인이 완료되지 않았어요. 다시 시도하세요.';

  @override
  String get myYouTube => '내 YouTube';

  @override
  String get spotifyDirectOn => 'Spotify 직접 재생 켜짐';

  @override
  String get spotifyDirect => 'Spotify 직접 재생';

  @override
  String get spotifyDirectOnHint => '켜짐 · 탭하여 끄기';

  @override
  String get spotifyDirectHint => '정확한 곡을 재생해요. Premium 필요.';

  @override
  String get spotifyComingSoon => '곧 제공 · Premium 필요';

  @override
  String get spotifyFailed => 'Spotify에 연결되지 않았어요. Spotify 앱이 설치되어 있고 로그인했으며 Premium인지 확인하세요.';

  @override
  String get nameThisSound => '이 소리의 이름';

  @override
  String get sounds => '소리';

  @override
  String get soundsSentence => '내 목소리, 노래, 재생목록, 라이브 라디오로 일어나세요.';

  @override
  String stopTimer(String time) {
    return '중지 · $time';
  }

  @override
  String get record => '녹음';

  @override
  String get addAFile => '파일 추가';

  @override
  String get addSongLinkLong => '노래 링크 추가 (Spotify, Apple Music, YouTube…)';

  @override
  String get musicAppsHeading => '음악 앱';

  @override
  String get pickFromSpotify => '내 Spotify에서 선택';

  @override
  String get yourPlaylistsAndLiked => '내 재생목록과 좋아요 표시한 곡';

  @override
  String get mySpotify => '내 Spotify';

  @override
  String get spotifySignInFailed => 'Spotify에 로그인할 수 없어요.';

  @override
  String get appleMusicNote => '로그인은 iPhone 버전에서 지원될 예정이에요. 지금은 노래 링크를 추가하세요.';

  @override
  String noSignInNote(String service) {
    return '$service는 다른 앱의 로그인을 허용하지 않아요. 대신 노래 링크를 추가하세요.';
  }

  @override
  String get wakeToRadio => '인터넷 라디오로 일어나기';

  @override
  String get soundsExplain => '최대 5분 녹음, 파일, 노래 링크 또는 라디오를 추가하세요. 문제가 생기면 예비 소리가 울려요.';

  @override
  String get yourSoundsHeading => '내 소리';

  @override
  String playsIn(String app) {
    return '$app에서 재생';
  }

  @override
  String opensIn(String app) {
    return '$app에서 열림';
  }

  @override
  String forSpan(String span) {
    return '$span 동안';
  }

  @override
  String get defaultLabel => '기본값';

  @override
  String get radioUnreachable => '방송국 목록에 연결할 수 없어요. 연결을 확인하세요.';

  @override
  String get addStreamAddress => '스트림 주소 추가';

  @override
  String get notAStream => '스트림 주소가 아닌 것 같아요 (http로 시작).';

  @override
  String get anyGenre => '모든 장르';

  @override
  String get stationName => '방송국 이름';

  @override
  String get closeSearch => '검색 닫기';

  @override
  String get searchByName => '이름으로 검색';

  @override
  String get anywhere => '모든 지역';

  @override
  String get noStations => '방송국을 찾지 못했어요. 다른 장르나 국가를 시도하세요.';

  @override
  String wakeUpTo(String name) {
    return '$name(으)로 일어나기';
  }

  @override
  String get notQuite => '아쉬워요. 다시 해 보세요.';

  @override
  String shabbatStopsItself(int n) {
    return '안식일 모드: $n초 후 저절로 멈춰요. 휴대폰을 만질 필요 없어요.';
  }

  @override
  String get solveToSnooze => '풀어서 다시 알림';

  @override
  String get solveToStop => '풀어서 끄기';

  @override
  String get answer => '답';

  @override
  String get snooze => '다시 알림';

  @override
  String get stop => '중지';

  @override
  String get shakeToSnooze => '흔들어서 다시 알림';

  @override
  String get shakeToStop => '흔들어서 끄기';

  @override
  String get shakeHard => '막대가 찰 때까지 휴대폰을 세게 흔드세요.';

  @override
  String get cantShake => '흔들 수 없나요? 문제 풀기';

  @override
  String get pairsToSnooze => '짝을 맞춰 다시 알림';

  @override
  String get pairsToStop => '짝을 맞춰 끄기';

  @override
  String get typeToSnooze => '입력해서 다시 알림';

  @override
  String get typeToStop => '입력해서 끄기';

  @override
  String get scanToSnooze => '코드를 스캔해 다시 알림';

  @override
  String get scanToStop => '코드를 스캔해 끄기';

  @override
  String ringAgainUnless(int n) {
    return '아래를 탭하지 않으면 $n분 후 다시 울려요.';
  }

  @override
  String get imUp => '일어났어요';

  @override
  String snoozeMin(int n) {
    return '$n분 다시 알림';
  }

  @override
  String snoozeMinLeft(int n, int left) {
    return '$n분 다시 알림 · $left회 남음';
  }

  @override
  String get noSnoozesLeft => '다시 알림 횟수 없음';

  @override
  String get stopThenOpen => '중지 · 그다음 열기';

  @override
  String get startingSong => '노래 시작 중';

  @override
  String wayToStop(String way) {
    return '$way(으)로 끄기';
  }

  @override
  String wayToSnooze(String way) {
    return '$way(으)로 다시 알림';
  }

  @override
  String ringsForMore(int n) {
    return '$n초 더 울려요';
  }

  @override
  String get leftToRing => '남음';

  @override
  String get wayVolumeButtons => '음량 버튼';

  @override
  String get wayShake => '휴대폰 흔들기';

  @override
  String get taskNothing => '없음';

  @override
  String get taskSum => '문제 풀기';

  @override
  String get taskShake => '30번 흔들기';

  @override
  String get taskMemory => '기억력 게임';

  @override
  String get taskPhrase => '문장 입력';

  @override
  String get taskScan => '코드 스캔';

  @override
  String get noLimit => '제한 없음';

  @override
  String upToTimes(int n) {
    return '최대 $n회';
  }

  @override
  String shorterEachTime(int n) {
    return '매번 $n분씩 짧게';
  }

  @override
  String autoSnoozeAfter(int n) {
    return '$n분 후 자동 다시 알림';
  }

  @override
  String get card => '카드';

  @override
  String get hiddenCard => '뒤집힌 카드';

  @override
  String get phrase1 => '나는 깨어 있고 오늘은 나의 날';

  @override
  String get phrase2 => '지금이 아니면 언제';

  @override
  String get phrase3 => '나와 사랑하는 모두에게 좋은 아침';

  @override
  String get phrase4 => '발은 바닥에 있고 나는 일어났다';

  @override
  String get phrase5 => '오늘 나는 다시 시작한다';

  @override
  String get notQuiteWords => '아쉬워요, 단어를 하나씩 확인하세요.';

  @override
  String get typeItHere => '여기에 입력';

  @override
  String get differentCode => '다른 코드예요.';

  @override
  String get cameraUnavailable => '카메라를 사용할 수 없어요.';

  @override
  String get cantScan => '스캔할 수 없나요? 문제 풀기';

  @override
  String get saveCodeToScan => '스캔할 코드 저장';

  @override
  String get saveCodeHint => '부엌의 상자나 욕실의 치약처럼 걸어가야 하는 곳의 바코드나 QR 코드를 비추세요. 알람을 끄려면 다시 스캔하게 돼요.';

  @override
  String get cameraUnavailableSettings => '카메라를 사용할 수 없어요. 설정에서 카메라 접근을 허용하세요.';

  @override
  String gentleToGo(int n) {
    return '부드러운 기상 · $n분 남음';
  }

  @override
  String previewBody(String body) {
    return '미리 듣기 · $body';
  }

  @override
  String snoozedBody(String body) {
    return '다시 알림: $body';
  }

  @override
  String get areYouUp => '일어났나요?';

  @override
  String get tapImUp => '“일어났어요”를 탭해 끄기';

  @override
  String get volume => '음량';

  @override
  String get wakeCheckOn => '기상 확인 켜짐';

  @override
  String get stopsAtOnce => '바로 멈춤';

  @override
  String get ringsAgainIfNotUp => '일어나지 않으면 다시 울림';

  @override
  String get openAppAfter => '이후 앱 열기';

  @override
  String get noTask => '미션 없음';

  @override
  String get codeSaved => '코드 저장됨';

  @override
  String get tapToSaveDifferent => '탭해서 다른 코드 저장';

  @override
  String get controlsHeading => '조작';

  @override
  String get onScreen => '화면에서';

  @override
  String get taskHeading => '미션';

  @override
  String get none => '없음';

  @override
  String get snoozeSentence => '5분만 더? 얼마나, 몇 번, 무엇이 필요한지 고르세요.';

  @override
  String get settingsHeading => '설정';

  @override
  String get snoozeTime => '다시 알림 시간';

  @override
  String get snoozeTimeHint => '첫 번째 다시 알림의 길이';

  @override
  String get shortenSnoozes => '이후 다시 알림 줄이기';

  @override
  String get shortenSnoozesHint => '첫 번째 이후 다시 알림을 이만큼 짧게';

  @override
  String get autoSnooze => '자동 다시 알림';

  @override
  String get autoSnoozeHint => '만지지 않으면 이 시간 후 자동으로 다시 알림';

  @override
  String get never => '안 함';

  @override
  String get snoozeLimit => '다시 알림 제한';

  @override
  String get snoozeLimitHint => '다시 알림할 수 있는 횟수';

  @override
  String get unlimited => '무제한';

  @override
  String get useSnoozeFromSettings => '설정의 다시 알림 사용';

  @override
  String get stopSentence => '알람을 끄는 방법과 먼저 해야 할 일.';

  @override
  String get shabbatNoTask => '안식일과 절기에는 알람이 저절로 멈추고 미션을 요구하지 않아요.';

  @override
  String get volumeSentence => '얼마나 크게 울리고, 얼마나 부드럽게 커지는지.';

  @override
  String get openAfterAlarm => '알람 후 열기';

  @override
  String get pickAnApp => '앱 선택';

  @override
  String get orPasteLink => '또는 링크 붙여넣기: https://…';

  @override
  String get useThisLink => '이 링크 사용';

  @override
  String get noAppsFound => '앱을 찾지 못했어요.';

  @override
  String get weather => '날씨';

  @override
  String get news => '뉴스';

  @override
  String get usePhoneVolume => '휴대폰 알람 음량 사용';

  @override
  String get setsPhoneVolume => '울리는 동안 휴대폰 알람 음량을 설정하고, 이후 되돌려요.';

  @override
  String get fadeInOff => '페이드 인 없음, 바로 최대 음량';

  @override
  String fadeInOver(String span) {
    return '$span 동안 커짐';
  }

  @override
  String get fadeOutOff => '페이드 아웃 없음';

  @override
  String fadeOutOver(String span) {
    return '마지막 $span 동안 작아짐';
  }

  @override
  String get fadesExplain => '페이드 아웃은 알람이 저절로 멈출 때 일어나요. 페이드가 울리는 시간보다 길면 둘 다 짧아져요.';

  @override
  String get soundSoftChime => '부드러운 차임';

  @override
  String get soundMorningRise => '아침 햇살';

  @override
  String get soundClassicBeep => '클래식 비프';

  @override
  String get calmCity => '조용한 도시의 아침';

  @override
  String get calmBirds => '새벽의 새소리';

  @override
  String get calmWaves => '해변의 파도';

  @override
  String get calmRain => '잔잔한 비';

  @override
  String get calmStream => '숲속 시냇물';

  @override
  String get calmWind => '산들바람';

  @override
  String get calmFire => '타닥이는 모닥불';

  @override
  String get calmNight => '여름밤';

  @override
  String get publicDomain => '퍼블릭 도메인';

  @override
  String get phoneVolume => '휴대폰 음량';

  @override
  String fadesIn(String span) {
    return '$span 동안 커짐';
  }

  @override
  String fadesOut(String span) {
    return '$span 동안 작아짐';
  }

  @override
  String get noFade => '페이드 없음';

  @override
  String minSecShort(int m, int s) {
    return '$m분 $s초';
  }

  @override
  String get happensRings => '울림';

  @override
  String get happensStopped => '끔';

  @override
  String get happensSnoozed => '다시 알림';

  @override
  String get happensAutoStopped => '저절로 멈춤';

  @override
  String get eventLower => '일정';

  @override
  String get appTest => 'Quando? 테스트';

  @override
  String get pushoverConnected => 'Pushover 연결됨';

  @override
  String get webhookConnected => '웹훅 연결됨';

  @override
  String pushoverSaid(int code, String body) {
    return 'Pushover 응답 $code: $body';
  }

  @override
  String couldNotReachPushover(String error) {
    return 'Pushover에 연결할 수 없어요 ($error)';
  }

  @override
  String itAnswered(int code) {
    return '응답: $code';
  }

  @override
  String couldNotReachIt(String error) {
    return '연결할 수 없어요 ($error)';
  }

  @override
  String get calendarNotAllowed => '캘린더 접근이 허용되지 않았어요.';

  @override
  String get playlist => '재생목록';

  @override
  String songCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n곡');
    return '$_temp0';
  }

  @override
  String get spotifySaidNo =>
      'Spotify가 거부했어요. Spotify 대시보드에서 Quando?의 Web API를 체크하고 User Management에 계정을 추가하세요.';

  @override
  String serviceDidntAnswer(String service, int code) {
    return '$service가 응답하지 않았어요 ($code).';
  }

  @override
  String get youTubeSaidNo => 'YouTube가 거부했어요. Google 계정이 Quando 프로젝트의 테스트 사용자인지 확인하세요.';

  @override
  String get event => '일정';

  @override
  String eventEnds(String title) {
    return '$title (종료)';
  }

  @override
  String foundSoundsDevices(int s, int d) {
    return '소리 $s개와 기기 $d대를 찾았어요.';
  }

  @override
  String get sentCheckDevices => '보냈어요. 다른 기기를 확인하세요.';

  @override
  String sentTo(String name) {
    return '$name(으)로 보냈어요.';
  }

  @override
  String get zapierHowTo => 'Zapier에서 “Webhooks by Zapier → Catch Hook”로 시작하는 Zap을 만들고 그 URL을 여기에 붙여 넣으세요.';

  @override
  String get catchHookUrl => 'Catch Hook URL';

  @override
  String get iftttHowTo =>
      'IFTTT에서 “Webhooks → Receive a web request with a JSON payload”로 시작하는 애플릿을 만드세요. 여기서도 같은 이벤트 이름을 쓰세요. 키는 ifttt.com/maker_webhooks/settings에 있어요.';

  @override
  String get eventName => '이벤트 이름';

  @override
  String get webhooksKey => 'Webhooks 키';

  @override
  String get webhookHowTo => 'Quando?는 이 주소로 JSON POST를 보내요.';

  @override
  String get connectionsSentence => '알람이 울리거나, 꺼지거나, 다시 알림될 때 다른 앱과 기기에 알려요.';

  @override
  String get pushWhenRings => '알람이 울리면 알림 보내기';

  @override
  String get pushWhenRingsHint => '다른 휴대폰, 태블릿, 시계, 컴퓨터로';

  @override
  String get yourUserKey => '내 사용자 키';

  @override
  String get appToken => '앱 토큰';

  @override
  String get soundAndDevicesHeading => '소리 및 기기';

  @override
  String get loading => '불러오는 중…';

  @override
  String get loadFromPushover => 'Pushover에서 불러오기';

  @override
  String get soundItPlays => '재생할 소리';

  @override
  String get myPushoverDefault => '내 Pushover 기본값';

  @override
  String get pushoverOwnSounds => 'pushover.net/sounds에 올린 내 소리가 여기에 나타나요.';

  @override
  String get allMyDevices => '내 모든 기기';

  @override
  String get pushoverOnThisPhone => '이 휴대폰에도 Pushover 앱을 설치하면 여기서도 Pushover 소리로 울려요.';

  @override
  String get priority => '우선순위';

  @override
  String get priorityNormal => '보통';

  @override
  String get priorityHigh => '높음: 방해 금지 시간 무시';

  @override
  String get priorityEmergency => '긴급: 확인할 때까지 반복';

  @override
  String get sending => '보내는 중…';

  @override
  String get sendATest => '테스트 보내기';

  @override
  String get findUserKey => '내 사용자 키 찾기';

  @override
  String get makeAppToken => '앱 토큰 만들기';

  @override
  String get webhooksHeading => 'ZAPIER, IFTTT 및 웹훅';

  @override
  String get webhooksExplain => '알람이 울리거나 끌 때 무엇이든 시작하세요: 조명 켜기, 기상 시간 기록, 누군가에게 메시지 보내기.';

  @override
  String get sendWhenAlarm => '알람이 다음일 때 보내기:';

  @override
  String get pauseOnShabbat => '안식일과 절기에는 일시 중지';

  @override
  String get pauseOnShabbatHint => '촛불 점화와 하브달라 사이의 알람에는 아무것도 보내지 않아요';

  @override
  String get webhookPayloadNote =>
      '각 메시지에는 event(ring, stopped, snoozed, auto_stopped), title, body, time, shabbat, snoozes가 들어 있어요. 키는 이 휴대폰에 남아요.';

  @override
  String get today => '오늘';

  @override
  String get tomorrow => '내일';

  @override
  String get notAWebAddress => 'https://로 시작하는 웹 주소가 아닌 것 같아요';

  @override
  String get language => '언어';

  @override
  String get phoneLanguage => '휴대폰 언어';

  @override
  String get ringQuote => '지금이 아니면, 언제?';

  @override
  String get ringQuoteBy => '힐렐';

  @override
  String get quotesTitle => '시간에 관한 명언';

  @override
  String get quotesHint => '어디서 가져올지 고르세요. 하루의 각 시간대마다 하나씩, 탭하면 다른 명언이 나옵니다.';

  @override
  String get quotesOff => '끔';

  @override
  String get quoteSongs => '노래';

  @override
  String get quoteMovies => '영화';

  @override
  String get quoteLiterature => '책과 시';

  @override
  String get quoteTanakh => '타나크 (히브리 성경)';

  @override
  String get quoteSages => '탈무드와 현자';

  @override
  String get quoteSpeeches => '유명한 연설';

  @override
  String get quotePhilosophy => '철학자';

  @override
  String get quoteProverbs => '속담과 격언';

  @override
  String get quotesAlso => '함께 보기';

  @override
  String get quoteCarnaval => '카니발';

  @override
  String get quoteCarnavalHint => '브라질 카니발 기간의 노래와 격언';

  @override
  String get quoteNearMe => '내 주변';

  @override
  String get quoteNearMeHint => '시간대와 안식일 도시를 기준으로 사는 곳의 시인과 기념일';

  @override
  String get quoteSiddur => '시두르 (기도서)';

  @override
  String weeklyParasha(String name) {
    return '파라샤 $name';
  }

  @override
  String poweredBy(String name) {
    return '$name 기반';
  }

  @override
  String get syncTitle => '내 기기 동기화';

  @override
  String get syncHint => 'Google로 로그인하면 알람과 설정이 모든 기기에서 똑같이 유지됩니다.';

  @override
  String syncOn(String email) {
    return 'On · $email';
  }

  @override
  String get syncWorking => 'Connecting…';

  @override
  String get syncNotAllowed => 'This Google account can\'t sync.';

  @override
  String get syncFailed => '연결하지 못했어요. 탭해서 다시 시도하세요.';

  @override
  String get syncStop => 'Stop syncing';

  @override
  String get syncNotSetUp => '이 버전에서는 아직 동기화가 설정되지 않았어요.';

  @override
  String get ringTheseAfterAll => '그래도 울리기';

  @override
  String skipTheseDay(int n) {
    return '오늘 이 $n개 건너뛰기';
  }

  @override
  String turnOffNamed(String name) {
    return '“$name” 끄기';
  }

  @override
  String turnOnNamed(String name) {
    return '“$name” 켜기';
  }

  @override
  String turnedOffNamed(String name) {
    return '“$name”을(를) 껐어요';
  }

  @override
  String removeTimeFrom(String time, String name) {
    return '“$name”에서 “$time” 삭제';
  }

  @override
  String removedTimeFrom(String time, String name) {
    return '“$name”에서 “$time”을(를) 삭제했어요';
  }

  @override
  String get moveToGroup => '그룹으로 이동';

  @override
  String inGroupMove(String group) {
    return '“$group”(으)로 이동';
  }

  @override
  String movedToGroup(String group) {
    return '“$group”(으)로 옮겼어요';
  }

  @override
  String deleteNamed(String name) {
    return '“$name” 삭제';
  }

  @override
  String get signInWithGoogle => 'Google로 로그인';

  @override
  String get signOut => 'Sign out';

  @override
  String get signInWithEmail => '이메일로 로그인';

  @override
  String get signIn => 'Sign in';

  @override
  String get createAccount => '계정 만들기';

  @override
  String get haveAccount => '이미 계정이 있어요';

  @override
  String get forgotPassword => '비밀번호를 잊으셨나요?';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get passwordResetSent => '새 비밀번호를 정할 수 있는 링크를 보냈어요.';

  @override
  String emailCheckInbox(String email) {
    return '$email(으)로 링크를 보냈어요. 링크를 연 다음 돌아와서 “확인했어요”를 탭하세요.';
  }

  @override
  String get emailConfirmed => '확인했어요';

  @override
  String get emailNotYet => '아직 확인되지 않았어요. 먼저 이메일의 링크를 여세요.';

  @override
  String get emailSendAgain => '이메일 다시 보내기';

  @override
  String get emailSentAgain => '보냈어요. 받은편지함과 스팸함을 확인하세요.';

  @override
  String get emailInvalid => '이메일 주소처럼 보이지 않아요.';

  @override
  String get emailWrong => '이메일 또는 비밀번호가 틀렸어요.';

  @override
  String get emailInUse => '이 이메일로 만든 계정이 이미 있어요. 로그인하거나, Google로 만들었다면 Google을 사용하세요.';

  @override
  String get passwordWeak => '6자 이상의 비밀번호를 정하세요.';

  @override
  String get emailNotSwitchedOn => '이메일 로그인이 아직 켜지지 않았어요.';

  @override
  String get tooManyTries => '시도가 너무 많아요. 몇 분 뒤에 다시 해 보세요.';

  @override
  String get spotifyLibrary => 'Spotify';

  @override
  String get spotifyLibrarySignIn => '재생목록, 좋아요한 곡, 검색';

  @override
  String get spotifyLibraryOn => '연결됨 · 길게 눌러 로그아웃';

  @override
  String spotifyLoginError(String reason) {
    return 'Spotify 로그인 실패: $reason';
  }

  @override
  String googleSignInError(String reason) {
    return 'Google 로그인 실패: $reason';
  }

  @override
  String get searchSongsHint => '곡, 아티스트, 플레이리스트 검색';

  @override
  String nothingFound(String query) {
    return '“$query”에 대한 결과가 없어요.';
  }

  @override
  String get deliveryTitle => '알림 방식';

  @override
  String get deliveryLocal => '기기 소리';

  @override
  String get deliveryBoth => '둘 다';

  @override
  String get deliveryConnect => 'Pushover 연결';

  @override
  String get deliveryLoadFailed => '소리와 기기를 불러오지 못했습니다. 다시 시도하세요.';

  @override
  String get deliveryBothHint => 'Pushover가 실패해도 기기 소리는 울립니다.';

  @override
  String get deliveryPushHint => 'Pushover만 사용합니다. 알림 시 이 기기가 온라인이어야 합니다.';

  @override
  String get deliveryFallback => 'Pushover가 연결 해제되거나 일시 중지되면 기기 소리를 유지합니다.';

  @override
  String get deliveryReset => '기존 설정 사용';

  @override
  String get beforeShabbat => '안식일 전';

  @override
  String get preparationReminders => '준비 알림';

  @override
  String get skipThisWeek => '이번 주 건너뛰기';

  @override
  String get restoreThisWeek => '이번 주 되돌리기';

  @override
  String get allAlarms => 'All alarms';

  @override
  String get timesAndSound => '시간 및 소리';

  @override
  String get changeCity => 'Change city';

  @override
  String get useMyLocation => '내 위치 사용';

  @override
  String get locationUnavailable => '위치를 일시적으로 사용할 수 없어요. 다시 시도하거나 도시를 고르세요.';

  @override
  String get locationReview => '이 위치 확인';

  @override
  String get locationDeviceOnly => '이 위치는 이 기기에만 저장돼요. 이 시각을 쓰기 전에 시간대와 이스라엘 설정을 확인하세요.';

  @override
  String timesIn(String city, String zone) {
    return '$city · $zone · 도시 시각';
  }

  @override
  String get preparationOff => '준비 알림이 꺼져 있습니다. 하브달라와 일반 알람은 바뀌지 않습니다.';

  @override
  String get preparationSkipped => '이번 주 준비 알림을 건너뛰었습니다. 주간 설정은 그대로 저장됩니다.';

  @override
  String get shabbatControls => '안식일 제어';

  @override
  String get duringAfterShabbat => '안식일 중 / 후';

  @override
  String locationCoordinates(String latitude, String longitude) {
    return '위도 $latitude · 경도 $longitude';
  }

  @override
  String get currentLocation => '현재 위치';

  @override
  String get testPushoverSound => 'Pushover에서 소리 테스트';

  @override
  String get pushoverSoundTestHint => '선택한 소리를 선택한 Pushover 기기에서 재생합니다. 무음 및 방해 금지 시간 설정은 계속 적용됩니다.';

  @override
  String get pushoverShareDevices => '내 기기와 자격 증명 공유';

  @override
  String get pushoverShareHint => 'Pushover 사용자 키와 앱 토큰이 Quando?와 Matai?에 로그인한 계정을 따라갈 수 있습니다.';

  @override
  String get pushoverShareQueued => '자격 증명이 로그인한 기기로 전송 대기 중입니다.';

  @override
  String get pushoverShareSignIn => 'Pushover 자격 증명을 공유하려면 모든 기기에서 같은 앱 계정으로 로그인하세요.';

  @override
  String get smartHomeHeading => 'Smart home';

  @override
  String get smartHomeHint => 'Tuya 장면을 직접 실행하거나 나만의 Home Assistant 또는 Node-RED 자동화를 연결하세요.';

  @override
  String get shareServices => '서비스 연결 공유';

  @override
  String get shareServicesHint =>
      '기기마다 같은 앱 계정을 사용하면 Pushover, Tuya, Spotify 라이브러리, 자동화 연결을 공유할 수 있습니다. YouTube와 기기 권한은 기기마다 승인이 필요할 수 있습니다.';

  @override
  String get tuyaSetupHint =>
      '연결된 Tuya 개발자 프로젝트를 사용하세요. 데이터 센터, Access ID, Access Secret, 그리고 “Link App Account”에 표시되는 UID를 입력하세요. Home Assistant는 필요 없습니다.';

  @override
  String get tuyaDataCenter => 'Data center';

  @override
  String get tuyaUserId => '연결된 계정 UID';

  @override
  String get tuyaAccessId => 'Access ID / Client ID';

  @override
  String get tuyaAccessSecret => 'Access Secret / Client Secret';

  @override
  String get tuyaLoadScenes => 'Load scenes';

  @override
  String get tuyaNoScenes => '사용 가능한 Tap-to-Run 장면을 찾지 못했습니다. 연결된 계정, 데이터 센터, 장면 API 권한을 확인하세요.';

  @override
  String get tuyaRunNow => '지금 장면 실행';

  @override
  String get tuyaRunConfirm => '지금 이 장면을 Tuya 기기에서 실행할까요?';

  @override
  String get tuyaSent => 'Tuya가 장면 명령을 수락했습니다. 기기를 확인하세요.';

  @override
  String get tuyaFailed => 'Tuya가 요청을 완료하지 못했습니다. 프로젝트 권한, 데이터 센터, 구독을 확인하세요. 오류:';

  @override
  String get tuyaAlarmScene => '이 알람이 울릴 때 실행할 Tuya 장면';

  @override
  String get homeAssistantHowTo =>
      'POST와 JSON을 받는 Webhook 트리거로 Home Assistant 자동화를 만들고 그 URL을 여기에 붙여넣으세요. 알람 이벤트(ring, stopped, snoozed, auto_stopped)로 동작을 선택할 수 있습니다. 새 기기에서는 이 연결이 꺼진 상태로 시작합니다.';

  @override
  String get nodeRedHowTo =>
      'POST를 받는 Node-RED HTTP In 노드를 사용하고, 이어서 자동화와 HTTP Response 노드를 연결하세요. 엔드포인트를 여기에 붙여넣으세요. 로컬 HTTP 허브와 HTTPS 엔드포인트를 지원합니다.';

  @override
  String get smartHomeConnect => '스마트홈 서비스 연결';

  @override
  String get automationTestHint => '테스트하면 연결된 자동화가 즉시 실행됩니다.';

  @override
  String get smartHomeDeviceOn => '이 기기에서 스마트홈 알람 동작 실행';

  @override
  String get smartHomeDeviceHint => '자동화를 실행할 기기를 하나 선택하세요. 연결은 공유되며, 이 스위치는 이 기기에만 적용됩니다.';

  @override
  String get smartHomeDeviceOff => '이 기기에서는 알람 동작이 꺼져 있습니다. 연결에서 켜세요. 수동 장면 테스트는 계속 작동합니다.';

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
  String get weatherSwipeHint => '하늘과 날씨 사이를 넘겨 보세요';

  @override
  String get parashaHeading => '주간 파라샤';

  @override
  String get dailyStudyHeading => '매일 학습';

  @override
  String get courseDaf => 'Daf Yomi';

  @override
  String get courseRambam1 => '람밤 · 하루 1장';

  @override
  String get courseRambam3 => '람밤 · 하루 3장';

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
  String get moonAlwaysUp => '달이 하루 종일 지평선 위에 있음';

  @override
  String get moonAlwaysDown => '달이 하루 종일 지평선 아래에 있음';

  @override
  String get noRiseToday => '오늘은 뜨지 않음';

  @override
  String get noSetToday => 'No set today';

  @override
  String get moonNew => 'New moon';

  @override
  String get moonWaxingCrescent => '초승달';

  @override
  String get moonFirstQuarter => '상현달';

  @override
  String get moonWaxingGibbous => '차오르는 볼록달';

  @override
  String get moonFull => 'Full moon';

  @override
  String get moonWaningGibbous => '기우는 볼록달';

  @override
  String get moonLastQuarter => 'Last quarter';

  @override
  String get moonWaningCrescent => '그믐달';

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
  String get weatherThunder => '뇌우';

  @override
  String get weatherUnavailable => '날씨를 일시적으로 사용할 수 없어요';

  @override
  String get weatherCached => '저장된 예보';

  @override
  String get weatherUpdated => 'Updated';

  @override
  String get weatherForecast => 'Forecast';

  @override
  String get weatherThunderExpected => '뇌우 예보';

  @override
  String get learningUnavailable => '연결하여 이번 달 학습 일정 불러오기';

  @override
  String get festivalReading => '명절 토라 낭독';

  @override
  String get learningCalendarSource => '학습 달력 · Hebcal · CC BY 4.0';

  @override
  String get weatherSource => '예보 · MET Norway · CC BY 4.0';

  @override
  String get weatherConsent => '선택한 도시의 날씨입니다. MET Norway에는 반올림한 좌표를 사용합니다.';

  @override
  String get learningConsent => '람밤 및 기타 학습 일정은 Hebcal에서 불러와 오프라인 사용을 위해 저장됩니다.';

  @override
  String get homeRefresh => 'Refresh';

  @override
  String get skyTimezone => 'My timezone';

  @override
  String get skyShabbat => 'Shabbat city';

  @override
  String get skyReferenceCity => '시간대 기준 도시';

  @override
  String get skyChooseCity => '하늘 도시 고르기';

  @override
  String get skyCityExplain => '해와 달은 이 도시의 좌표를 사용해요. 안식일 도시와 알람 시간대는 고른 그대로 유지돼요.';

  @override
  String get skySun => 'Sun today';

  @override
  String get skyMoon => 'Moon today';

  @override
  String get moonAboveHorizon => '달이 지평선 위에 있음';

  @override
  String get moonBelowHorizon => '달이 지평선 아래에 있음';

  @override
  String get moonNextNew => '다음 신월';

  @override
  String get moonNextFull => '다음 보름달';

  @override
  String get locationServicesOff => '위치 서비스가 꺼져 있어요. 설정에서 켜거나 도시를 고르세요.';

  @override
  String get locationDenied => '위치 접근이 거부되었어요. 설정에서 허용하거나 도시를 고르세요.';

  @override
  String get locationTimedOut => '아직 위치를 찾지 못했어요. Mac에서는 Wi-Fi를 켜 둔 채 다시 시도하거나 도시를 고르세요.';

  @override
  String get locationTimeZoneUnavailable => '위치를 사용하기 전에 선택한 시간대의 도시를 쓰거나 기기의 시간대를 따르세요.';

  @override
  String get locationSettings => '위치 설정 열기';

  @override
  String get locationLooking => '위치 확인 중…';

  @override
  String get skyMoonDisplay => '달 표시: 월출, 월몰, 위상';

  @override
  String get tuyaConsumerPending => '계정으로 로그인하는 기능은 이 버전에서 아직 지원되지 않습니다. 이미 Tuya 개발자 프로젝트가 있다면 고급 설정을 사용하세요.';

  @override
  String get tuyaAdvanced => '고급 설정';

  @override
  String get tuyaSignInTitle => 'Smart Life 계정으로 로그인';

  @override
  String get tuyaSignInHint =>
      'Smart Life 또는 Tuya Smart 앱과 같은 국가, 이메일 또는 전화번호, 비밀번호를 사용하세요. 계정은 이미 Tuya 프로젝트에 연결되어 있어야 합니다. 비밀번호는 Tuya로만 전송되며 저장되지 않습니다.';

  @override
  String get tuyaCountryCode => '국가 번호 (브라질 55, 미국 1)';

  @override
  String get tuyaAccount => 'Smart Life 이메일 또는 전화번호';

  @override
  String get tuyaPassword => 'Smart Life 비밀번호';

  @override
  String get tuyaSignIn => '로그인하고 장면 불러오기';

  @override
  String get tuyaRelayUrl => 'Quando Tuya 릴레이 주소 (https)';

  @override
  String get tuyaRelayHint =>
      'Smart Life 또는 Tuya Smart 계정의 국가, 이메일 또는 전화번호, 비밀번호를 사용하세요. Quando의 Tuya 릴레이로 한 번 전송되며 저장되지 않습니다. Quando 계정에 로그인해 있어야 합니다.';

  @override
  String get tuyaGoogleHint =>
      'Google이나 Apple로 Smart Life에 로그인하나요? Smart Life에서 ‘비밀번호 찾기’를 눌러 비밀번호를 설정한 뒤 여기에서 사용하세요.';

  @override
  String get tuyaLinked => 'Smart Life 계정 연결됨';

  @override
  String get tuyaUnlink => '연결 해제';

  @override
  String get tuyaNeedsAccount => '먼저 설정에서 Quando 계정에 로그인하세요.';

  @override
  String get roshHodeshHeading => 'Rosh Hodesh';

  @override
  String get roshHodeshExplain => '다음 히브리력 달의 첫날 또는 첫 이틀을 홈에 표시합니다.';

  @override
  String get roshHodeshNext => '다음 로시 호데시';

  @override
  String get roshHodeshBegins => '일몰부터 시작:';

  @override
  String get openParashaSefaria => '이 토라 구절을 Sefaria에서 읽기';

  @override
  String get skyMyLocation => 'My location';

  @override
  String get skyLocationLocalTimes => '하늘 시각은 이 위치의 시간대를 사용해요. 알람 시간대와 안식일 도시는 바뀌지 않아요. 이 기기에만 저장돼요.';

  @override
  String get musicRingDurationHint => '재생은 이 알람의 울림 시간을 따르며 중지 또는 다시 알림으로 멈춥니다.';

  @override
  String get musicBackupPlaying => '음악을 시작할 수 없습니다. 로컬 알람 소리가 재생 중입니다.';

  @override
  String desktopMusicConnect(String service) {
    return '$service 앱 연결';
  }

  @override
  String desktopMusicOn(String service) {
    return '$service에 연결됨 · 길게 눌러 해제';
  }

  @override
  String get musicSongs => '노래';

  @override
  String get noMusicSongs => '음악 보관함에서 노래를 찾지 못했습니다.';

  @override
  String serviceConnectUnavailable(String service) {
    return '$service 링크 추가 · 알람 후 열림';
  }

  @override
  String get soundCloudWidgetNote => '공개 링크 추가';

  @override
  String get youtubePlayerHint => 'YouTube는 표시되는 플레이어에서 동영상을 재생합니다. 숨겨지거나 재생할 수 없으면 로컬 알람이 계속됩니다.';

  @override
  String get musicPreviewFailed => '이 소리를 재생할 수 없습니다. 연결을 확인하거나 다른 트랙 또는 방송국을 사용해 보세요.';

  @override
  String get skyMoonPhase => '달의 위상';

  @override
  String get skyMoonDetailsDisplay => '달 위상 페이지 추가';

  @override
  String get skyMoonDetailsHint => '밀어서 이동하거나 언제든 달 카드를 탭하세요';

  @override
  String get moonRises => '월출';

  @override
  String get moonSets => '월몰';

  @override
  String moonLunarDay(int day) {
    return '이번 음력 달 29.5일 중 $day일째';
  }

  @override
  String get moonDetailsOpen => '달 위상 열기';

  @override
  String get musicPlaylists => '음악 재생목록';

  @override
  String get videoPlaylists => '동영상 재생목록';

  @override
  String get likedVideos => '좋아요 표시한 동영상';

  @override
  String get wholePlaylist => '재생목록 전체로 일어나기';

  @override
  String get noSongsInPlaylist => '재생할 수 있는 곡이 없어요.';

  @override
  String get hebrewNamesHeading => '파라샤와 달 이름 표기';

  @override
  String get hebrewNamesIsraeli => '이스라엘식';

  @override
  String get hebrewNamesAshkenazi => '아슈케나즈식';

  @override
  String pickFromService(String service) {
    return '내 $service에서 선택';
  }

  @override
  String get weatherTonight => '오늘 밤';

  @override
  String get weatherTomorrowMorning => '내일 아침';

  @override
  String weatherUntilAbout(String time) {
    return '$time쯤까지';
  }

  @override
  String get weatherSunBehindClouds => '구름 뒤의 해';

  @override
  String get keysLockTitle => '기기 간 키';

  @override
  String get keysLockOff => '서비스 키는 이 기기에만 남아 있어요. 동기화 암호 문구를 정하면 암호화해서 다른 기기로 보낼 수 있어요.';

  @override
  String get keysLockOn => '서비스 키는 이 기기를 떠나기 전에 동기화 암호 문구로 암호화돼요. Google을 포함해 누구도 읽을 수 없어요.';

  @override
  String get keysLockWaiting => '다른 기기에서 키가 잠긴 채로 도착했어요. 동기화 암호 문구를 입력해 열어 주세요.';

  @override
  String get keysSetPassphrase => '암호 문구 정하기';

  @override
  String get keysChangePassphrase => '암호 문구 바꾸기';

  @override
  String get keysUnlock => '키 열기';

  @override
  String get keysStartOver => '잊으셨나요? 다시 시작';

  @override
  String get keysStartOverHint => '다시 시작하면 이 기기의 키를 새 암호 문구로 보내요. 다른 기기에서는 새 암호 문구를 물어봐요.';

  @override
  String get keysPassphrase => '동기화 암호 문구';

  @override
  String get keysPassphraseAgain => '한 번 더 입력';

  @override
  String keysPassphraseShort(int count) {
    return '$count자 이상 입력하세요.';
  }

  @override
  String get keysPassphraseMismatch => '두 입력이 일치하지 않아요.';

  @override
  String get keysPassphraseWrong => '이 암호 문구로는 키를 열 수 없어요.';

  @override
  String get keysPassphraseNote => '적어 두세요. 잊어버리면 아무도 복구할 수 없고 키를 다시 입력해야 해요.';

  @override
  String get keysShareNeedsPassphrase => '먼저 \'기기 간 키\'에서 동기화 암호 문구를 정하세요.';

  @override
  String get settingsAlarmDefaults => '알람 기본값';

  @override
  String get settingsPlacesTime => '장소 및 시간';

  @override
  String get settingsLook => '화면, 언어 및 명언';

  @override
  String get settingsAbout => 'About';

  @override
  String get defaultForNewAlarms => '새 알람의 기본값';

  @override
  String get preview => 'Preview';

  @override
  String atClock(String time) {
    return 'at $time';
  }

  @override
  String get connectACalendar => '캘린더 연결';

  @override
  String get newFromReadyMade => '준비된 알람에서';

  @override
  String get newFromReadyMadeHint => '일출, 일몰 등 이미 준비된 알람';

  @override
  String get calendarSourcesIntro => 'Quando?는 캘린더 일정 전후에 울릴 수 있어요. 어디서 가져올지 고르세요.';

  @override
  String get deviceCalendarsHeading => '이 기기';

  @override
  String get deviceCalendarsTitle => '이 기기의 캘린더 앱';

  @override
  String get deviceCalendarsHint => '기기의 모든 계정: Google, Samsung, Outlook, iCloud, 여기에만 있는 캘린더.';

  @override
  String get googleCalendarHeading => 'GOOGLE 캘린더';

  @override
  String get googleCalendarSignIn => 'Google 계정이 이 기기에 없어도 Google에서 바로 캘린더를 읽으려면 Google로 로그인하세요.';

  @override
  String googleCalendarSignedIn(String email) {
    return '$email(으)로 로그인됨';
  }

  @override
  String get googleCalendarSignOut => '로그아웃';

  @override
  String get googleCalendarNotHere =>
      '이 기기에서는 아직 Google 로그인을 쓸 수 없어요. 기기 설정(캘린더 › 계정)에서 Google 계정을 추가하면 캘린더가 이 기기 항목에 나타나요.';

  @override
  String get googleCalendarUnreachable => '지금 Google 캘린더에 연결할 수 없어요. 이미 맞춰 둔 알람은 그대로 울려요.';

  @override
  String get googleCalendarTwiceHint => '같은 Google 계정에서 이 기기가 이미 보여주는 캘린더는 꺼진 채로 시작해서 두 번 울리지 않아요.';

  @override
  String get timersTitle => '타이머';

  @override
  String get timerStopwatch => '스톱워치';

  @override
  String get timerCountdown => '타이머';

  @override
  String get timerSequence => '준비';

  @override
  String get timerStopwatchSub => '랩과 함께 위로 셉니다';

  @override
  String get timerCountdownSub => '아래로 세고, 0에서 울립니다';

  @override
  String get timerSequenceSub => '음성 출발과 표시';

  @override
  String get timerStart => '시작';

  @override
  String get timerPause => '일시정지';

  @override
  String get timerResume => '다시 시작';

  @override
  String get timerReset => '초기화';

  @override
  String get timerLap => '랩';

  @override
  String get timerTimesUp => '시간 종료';

  @override
  String get timerSetTime => '시간 설정';

  @override
  String get timerMinutes => '분';

  @override
  String get timerSeconds => '초';

  @override
  String get seqOnYourMarks => '제자리에';

  @override
  String get seqGetSet => '준비';

  @override
  String get seqGo => '출발!';

  @override
  String get seqFinish => '종료!';

  @override
  String get seqReady => '준비됨';

  @override
  String get seqSettings => '설정';

  @override
  String get seqStartCalls => '출발 전 안내';

  @override
  String get seqStartCallsHelp => '출발 전에 소리 내어 말하며, 출발 시점부터 거꾸로 셉니다.';

  @override
  String seqCallBefore(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n초 전');
    return '$_temp0';
  }

  @override
  String get seqAddCall => '안내 추가';

  @override
  String get seqCallText => '말할 내용';

  @override
  String get seqGoText => '시작할 때 말하기';

  @override
  String get seqFinishText => '끝날 때 말하기';

  @override
  String get seqLength => '길이';

  @override
  String get seqNoLimit => '제한 없음';

  @override
  String get seqSayEvery => '시간 안내 간격';

  @override
  String get seqOff => '끔';

  @override
  String seqEverySeconds(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n초');
    return '$_temp0';
  }

  @override
  String seqEveryMinutes(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n분');
    return '$_temp0';
  }

  @override
  String get seqFinalCount => '마지막 카운트다운';

  @override
  String get seqMarks => '내 표시';

  @override
  String get seqAddMark => '표시 추가';

  @override
  String seqMarkAt(String time) {
    return '$time에';
  }

  @override
  String get seqSpeak => '소리 내어 말하기';

  @override
  String get seqBeeps => '비프음과 진동';

  @override
  String get seqSayRemaining => '경과 시간이 아닌 남은 시간 말하기';

  @override
  String get seqPresets => '프리셋';

  @override
  String get seqPresetRace => '경주 출발';

  @override
  String get seqPresetSprint => '30초 전력';

  @override
  String get seqPresetRound => '1분 라운드';

  @override
  String get seqHintNoLimit => '출발 후 멈출 때까지 위로 셉니다.';

  @override
  String get seqHintLength => '출발 후 0까지 아래로 셉니다.';

  @override
  String get seqWords => '문구';

  @override
  String get homeEdit => 'Arrange home';

  @override
  String get homeEditHint => '핸들을 끌어 카드를 옮기거나, 접거나, 크기를 바꾸세요.';

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
  String get homeBlockSky => '해, 달, 날씨';

  @override
  String get homeBlockQuick => 'QUICK ALARMS';

  @override
  String get homeBlockShabbat => '안식일과 명절';

  @override
  String get homePlaceTitle => '하늘 도시';

  @override
  String nextAlarmLine(String title, String time) {
    return '다음 알람 · $title $time';
  }

  @override
  String get showAllAlarms => '모든 날 보기';

  @override
  String get noAlarmsThatDay => '이날은 울리는 알람이 없어요';

  @override
  String get homeClockSize => '홈 화면 시계';

  @override
  String get sizeSmall => '작게';

  @override
  String get sizeMedium => '보통';

  @override
  String get sizeLarge => '크게';

  @override
  String get homeLayout => '홈 레이아웃';

  @override
  String get homeLayoutClassic => '클래식';

  @override
  String get homeLayoutCards => '카드';

  @override
  String get homeCardsHint => '카드를 끌어 옮기세요. 가장자리나 모서리를 끌거나 크기를 골라 크기를 바꾸세요.';

  @override
  String get homeAddCard => '카드 추가';

  @override
  String get homeOnHome => '홈에 있음';

  @override
  String get homeRemoveCard => '제거';

  @override
  String get cardNext => '다음 알람';

  @override
  String get cardClock => '시계와 날짜';

  @override
  String get cardSky => '해, 달, 날씨';

  @override
  String get cardMoon => '달';

  @override
  String get cardWeather => '날씨';

  @override
  String get cardAlarms => '내 알람';

  @override
  String get cardQuick => '빠른 알람';

  @override
  String get cardTools => '스톱워치, 카운트다운, 준비';

  @override
  String get cardWorld => '세계 시계';

  @override
  String get cardWeek => '이번 주';

  @override
  String get cardShabbat => '안식일과 명절';

  @override
  String get ringAtEventReminders => '일정 자체의 알림 시간에 울리기';

  @override
  String get ringAtEventRemindersHint => '캘린더 앱에 설정한 알림이 이 알람 소리로 크게 울립니다.';

  @override
  String get atEventReminders => '일정 알림 시간에';

  @override
  String get everyEventReminderLoud => '모든 일정 알림 시간에 크게 울리기';

  @override
  String get loudNotificationsHeading => '캘린더 알림 크게';

  @override
  String get loudNotificationsTitle => '캘린더 알림을 크게 울리기';

  @override
  String get loudNotificationsHint => '캘린더 앱이 알림을 보여 주면 무음 모드에서도 Quando?가 알람으로 울립니다.';

  @override
  String get loudNotificationsDisclosureTitle => 'Quando?가 캘린더 알림을 읽도록 허용할까요?';

  @override
  String get loudNotificationsDisclosure =>
      '캘린더 알림을 크게 울리려면 Quando?에 알림 접근 권한이 필요합니다. 선택한 캘린더 앱의 알림만 보고, 알람에 표시하기 위해 이 휴대폰에서 제목과 내용을 읽으며, 저장하거나 어디로도 보내지 않습니다. 언제든지 끌 수 있습니다.';

  @override
  String get loudNotificationsAgree => '동의하고 계속';

  @override
  String get loudNotificationsNoAccess => '알림 접근이 꺼져 있습니다. 열리는 목록에서 Quando?를 켜세요.';

  @override
  String get loudNotificationsAllow => '허용';

  @override
  String get loudNotificationsNoApps => '이 휴대폰에서 지원되는 캘린더 앱을 찾지 못했습니다.';

  @override
  String get loudNotificationsTwiceNote => '이미 Quando? 캘린더 알람이 있는 일정은 한 번만 울립니다.';

  @override
  String get loudNotificationsShabbatNote => '안식일과 명절에는 울리지 않습니다.';

  @override
  String get busyMode => '바쁨 모드';

  @override
  String get busyModeSubtitle => '바쁠 때 방해 금지와 자동 답장';

  @override
  String get busyIntro => '바쁠 때 Quando?가 휴대폰을 조용히 하고 대신 메시지에 답장합니다. 알람은 그대로 울립니다.';

  @override
  String get busyIosFocus =>
      'iPhone과 iPad에서는 앱이 집중 모드를 켜거나 메시지에 답장할 수 없습니다. 단축어 앱에서 \'Quando?를 열 때\' 또는 특정 시간에 집중 모드를 켜는 자동화를 만들고 집중 모드에서 자동 답장을 설정하세요.';

  @override
  String get busyWhileHeading => '바쁠 때';

  @override
  String get busyDnd => '방해 금지';

  @override
  String get busyDndHint => '중요 알림만: 전화와 메시지는 조용히, 알람은 울립니다. 끝나면 원래대로.';

  @override
  String get busyDndNoAccess => 'Quando?에 아직 방해 금지 변경 권한이 없습니다.';

  @override
  String get busyReplies => '메시지에 답장';

  @override
  String get busyRepliesHint => '한 사람당 한 번, 내 문구로, 앱 자체의 답장 버튼을 통해. Android 전용.';

  @override
  String get busyRepliesDisclosureTitle => 'Quando?가 메시지에 답장하도록 허용할까요?';

  @override
  String get busyRepliesDisclosure =>
      '대신 답장하려면 Quando?에 알림 접근 권한이 필요합니다. 바쁠 때만 선택한 앱의 메시지 알림을 보고, 이 휴대폰에서 보낸 사람 이름을 읽고, 앱 자체의 답장 버튼으로 내 문구를 한 번 보냅니다. 메시지는 저장하거나 다른 곳으로 보내지 않습니다. 허용하지 않으면 그룹은 건너뜁니다.';

  @override
  String get busyReplyText => '내 답장';

  @override
  String busyReplyTextHint(String until) {
    return '$until은 바쁨 모드가 끝나는 시간으로 바뀝니다.';
  }

  @override
  String busyReplyDefault(String until) {
    return '지금 바빠서 $until 이후에 답장할게요.';
  }

  @override
  String get busyGroups => '그룹 채팅에도 답장';

  @override
  String get busyGroupsHint => '끔: 그룹에는 답장하지 않습니다.';

  @override
  String get busyRepliesOnShabbat => '안식일과 명절에도 답장';

  @override
  String get busyAskRabbi => '기본값은 꺼짐. 안식일에 켜기 전에 랍비에게 문의하세요.';

  @override
  String get busyWhenHeading => '바쁜 시간';

  @override
  String get busyWhenHint => '캘린더 알람에서 \'이 일정 동안 바쁨\' 또는 알람에서 \'울린 후 바쁨\'을 켜세요.';

  @override
  String get busyDuringLock => '잠금 모드 동안 바쁨';

  @override
  String get busyNoneComing => '앞으로 7일 동안 바쁜 시간이 없습니다.';

  @override
  String get busyDuringEvents => '이 일정 동안 바쁨';

  @override
  String get busyDuringEventsHint => '각 일정의 시작부터 끝까지 바쁨 모드.';

  @override
  String get busySettings => '바쁨 모드 설정';

  @override
  String get busyAfterRing => '울린 후 바쁨';

  @override
  String get busyAfterRingHint => '잠시 방해 금지와 자동 답장. 운동이나 낮잠 등.';

  @override
  String get shareCard => '내 아침 공유';

  @override
  String get shareCardSubtitle => '오늘의 하늘과 명언, 또는 내 사진을 스토리와 상태에';

  @override
  String get shareAppMissing => '이 휴대폰에 그 앱이 없습니다.';

  @override
  String get shareAsIs => '그대로 공유';

  @override
  String get shareTapQuote => '명언을 탭하면 바뀝니다.';

  @override
  String get shareStory => '스토리';

  @override
  String get shareSquare => '정사각형';

  @override
  String get shareYourWords => '나만의 문구 (선택)';

  @override
  String get shareYourWordsHint => '오늘의 명언 대신';

  @override
  String get shareYourPhoto => '내 사진';

  @override
  String get shareOtherPhoto => '다른 사진';

  @override
  String get shareSkyBack => '오늘의 하늘로';

  @override
  String get shareYourVideo => '내 동영상';

  @override
  String get shareInstagramStory => '인스타그램 스토리';

  @override
  String get shareWhatsApp => 'WhatsApp: 상태 또는 채팅';

  @override
  String get shareMore => '다른 앱';

  @override
  String get shareYouPost => 'Quando?가 카드를 담아 앱을 엽니다. 어디에 올릴지 직접 고르고 게시를 누르세요.';

  @override
  String get shareAndroidFirst => 'iPhone과 iPad 공유는 곧 지원됩니다.';

  @override
  String songSaved(String name) {
    return '\'$name\'을(를) 알람 소리로 저장했습니다';
  }

  @override
  String get shareToQuando => 'Quando?로 노래 공유';

  @override
  String get shareToQuandoHint =>
      'YouTube, YouTube Music, Spotify, SoundCloud, Apple Music에서 공유 후 Quando?를 누르면 해당 앱에서 재생되는 알람 소리가 됩니다.';

  @override
  String get askOption => '말하거나 입력';

  @override
  String get askOptionHint => '“내일 6시”, “일출 30분 전”';

  @override
  String get askHint => '예: 평일에는 일출 30분 전에 깨워 줘';

  @override
  String get askListening => '듣는 중…';

  @override
  String get askNotUnderstood => '시간을 찾지 못했어요. “평일 오전 7시”나 “20분 후”로 해 보세요.';

  @override
  String askAnswerFromCalendar(String name) {
    return '캘린더 “$name”에서';
  }

  @override
  String get askAnswerBuiltIn => '도시 기준 Quando? 시간';

  @override
  String get askNoAnswer => '아직 시간을 찾지 못했습니다.';

  @override
  String get askNoSpeech => '이 기기에서는 음성을 사용할 수 없어요. 입력할 수 있어요.';

  @override
  String get askShabbatOff => '안식일 시간이 울리려면 설정에서 안식일을 켜세요.';

  @override
  String askSaved(String what) {
    return '저장됨: $what';
  }

  @override
  String get askMic => '말하기';

  @override
  String get askMorning => '아침';

  @override
  String get askEvening => '저녁';

  @override
  String get askUnsure => '일부를 놓쳤을 수 있어요. 저장하기 전에 확인하세요.';

  @override
  String get askTeach => '이걸 가르쳐 주기';

  @override
  String askTaught(String phrase, String time) {
    return '알겠어요: “$phrase”는 이제 $time이에요.';
  }

  @override
  String get askSkipAction => '건너뛰기';

  @override
  String get askNoMatch => '맞는 알람이 없어요.';

  @override
  String askTurnedOff(String what) {
    return '껐어요: $what';
  }

  @override
  String askSkipped(String what) {
    return '건너뛰었어요: $what';
  }

  @override
  String askEventPlan(String offset, String event) {
    return '캘린더의 “$event” $offset';
  }

  @override
  String askEventNoCalendar(String event) {
    return 'Quando?가 “$event”를 찾을 수 있게 캘린더를 연결하세요.';
  }

  @override
  String askSnoozeAll(int minutes) {
    return '다시 알림: $minutes분, 모든 알람에 적용';
  }

  @override
  String askWakeWith(String sound) {
    return '$sound(으)로 깨워요';
  }

  @override
  String get askReadAs => '이렇게 읽었어요';

  @override
  String get syncHeading => '캘린더가 바뀌면';

  @override
  String get syncLive => '캘린더 따라가기';

  @override
  String get syncLiveHint => '새 일정에 알람이 생깁니다. 일정이 옮겨지면 알람도 옮겨지고, 삭제되면 알람도 사라집니다.';

  @override
  String get syncKeepFirst => '처음 본 대로 두기';

  @override
  String get syncKeepFirstHint => '새 일정에도 알람이 생깁니다. 한 번 맞춘 알람은 일정이 옮겨지거나 삭제되어도 그대로입니다.';

  @override
  String get syncSnapshot => '지금 있는 일정만';

  @override
  String get syncSnapshotHint => '저장할 때 캘린더에 있는 일정만, 지금 모습 그대로. 나중에 새 일정은 추가되지 않습니다.';

  @override
  String get syncHelpButton => '작동 방식';

  @override
  String get syncHelpTitle => '알람이 캘린더를 따라가는 방식';

  @override
  String get syncHelpIntro => '이 규칙은 검색과 맞는 일정을 계속 찾습니다. 캘린더가 바뀔 때 어떻게 할지 고를 수 있습니다.';

  @override
  String get syncHelpExampleLive => '예: “치과” 규칙. 치과가 화요일 예약을 수요일로 옮기면 알람도 수요일로 옮겨집니다. 예약이 취소되면 알람도 사라집니다.';

  @override
  String get syncHelpExampleKeepFirst =>
      '같은 규칙: 예약은 수요일로 옮겨져도 알람은 Quando?가 처음 본 화요일에 그대로 있습니다. 다음 달 새 예약에는 따로 알람이 생깁니다.';

  @override
  String get syncHelpExampleSnapshot => '같은 규칙: 오늘 캘린더에 있는 예약에만 알람이 생기고 그대로 유지됩니다. 다음 달에 추가된 예약에는 알람이 없습니다.';

  @override
  String get syncHelpTip => '잘 모르겠다면 “캘린더 따라가기”로 두세요.';

  @override
  String get syncHelpWhenTitle => 'Quando?는 언제 변경을 알아차리나요?';

  @override
  String get syncHelpWhenOpen => 'Quando?가 열려 있을 때: 몇 초 안에. 여기서 연결한 Google 캘린더는 2분마다 확인합니다.';

  @override
  String get syncHelpWhenClosed => 'Quando?가 닫혀 있을 때: 다음에 열 때. 그때까지는 맞춰 둔 알람이 원래 시간에 울립니다.';

  @override
  String get syncHelpWhenClosedApple => 'iPhone과 iPad는 앱이 백그라운드에서 캘린더를 지켜보지 못하게 하므로, Quando?를 열 때 변경을 가져옵니다.';

  @override
  String get tapMiddleToStop => '가운데를 탭하면 정지';

  @override
  String get quickSetups => '빠른 설정';

  @override
  String get qsMorningTitle => '잘 되는 아침';

  @override
  String get qsStartTitle => '시작을 놓치지 않기';

  @override
  String get qsStretchTitle => '구간으로 작업하기';

  @override
  String get qsWillChange => '바뀌는 내용';

  @override
  String get qsAlreadyOn => '이미 켜져 있습니다. 바꿀 것이 없습니다.';

  @override
  String get qsApply => '적용';

  @override
  String get qsDone => '완료';

  @override
  String get qsUndo => '실행 취소';

  @override
  String get qsSnoozeTimes => '허용 스누즈 횟수';

  @override
  String get qsSnoozeMinutes => '스누즈 분';

  @override
  String get qsFiveLeft => '5분 남음';

  @override
  String get uiSimple => '간단히';

  @override
  String get uiEverything => '전부';

  @override
  String get firstRunTitle => '얼마나 보고 싶으세요?';

  @override
  String get firstRunSimpleHint => '알람과 기본 기능';

  @override
  String get firstRunEverythingHint => '캘린더, 안식일, 타이머, 날씨 등';

  @override
  String get firstRunChangeLater => '설정에서 언제든 바꿀 수 있어요.';

  @override
  String get continueLabel => '계속';

  @override
  String get everyAlarm => '모든 알람';

  @override
  String get wakeMeWith => '깨우는 방법';

  @override
  String get ringOrMusic => '벨소리 또는 음악';

  @override
  String get ringsForRow => '울리는 시간';

  @override
  String gentleBeforeValue(int minutes) {
    return '$minutes분 전';
  }

  @override
  String get quandoSounds => 'Quando? 소리';

  @override
  String get aSongApps => '노래 (Spotify, YouTube…)';

  @override
  String get myRecording => '내 녹음';

  @override
  String get useForNewAlarms => '새 알람에 사용';

  @override
  String get iWillLabel => '이 알람이 울리면 나는…';

  @override
  String get foldVolume => '음량과 페이드';

  @override
  String get foldSnoozeStop => '다시 알림과 중지';

  @override
  String get foldExtras => '캘린더 및 기타';

  @override
  String get groupAlarms => '알람';

  @override
  String get groupCalendarShabbat => '캘린더와 안식일';

  @override
  String get groupLookQuotes => '화면과 명언';

  @override
  String get groupConnectionsSync => '연결 및 동기화';

  @override
  String qsSummary(int count, int on) {
    return '설정 $count개 · $on개 켜짐';
  }
}
