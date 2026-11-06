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
  String get calendarAlarm => '캘린더 알람';

  @override
  String get calendarIntro => 'Quando?는 휴대폰 캘린더 일정의 전후에 울릴 수 있어요. 휴대폰에 Google 계정이 있으면 Google 캘린더도 포함돼요.';

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
      'Spotify, Apple Music, Amazon Music, YouTube, YouTube Music, SoundCloud에서 공유 → 링크 복사를 탭하고 여기에 붙여 넣으세요.';

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
  String get youTubeOn => '내 재생목록과 좋아요 표시한 곡. 길게 눌러 로그아웃.';

  @override
  String get youTubeSignIn => 'Google로 로그인해 재생목록과 좋아요 표시한 곡에서 선택하세요.';

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
  String get spotifyDirectOnHint => 'Spotify가 바로 그 노래를 알람으로 재생해요. 탭하여 끄기.';

  @override
  String get spotifyDirectHint =>
      'Spotify 노래를 그대로 알람으로, 더 안정적으로 재생해요. Spotify 앱과 Spotify Premium이 필요해요. 탭하여 로그인.';

  @override
  String get spotifyComingSoon => '곧 제공: Spotify 노래를 그대로 알람으로 (Spotify Premium 필요).';

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
  String get soundsExplain =>
      '내 목소리, 노래, 무엇이든 최대 5분까지 녹음하세요. 휴대폰의 MP3, M4A, WAV를 추가하세요. 노래나 재생목록을 연결하면 그 앱이 백업 소리와 함께 알람으로 재생해요. 라디오 방송국을 고르면 실시간으로 나오고, 연결되지 않으면 휴대폰 알람이 울려요.';

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
  String get spotifyLibrarySignIn => '로그인하면 내 플레이리스트와 좋아요한 곡에서 고르거나 Spotify 전체를 검색할 수 있어요. Premium 필요 없음.';

  @override
  String get spotifyLibraryOn => '내 플레이리스트, 좋아요한 곡, 검색. 길게 눌러 로그아웃.';

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
  String get locationUnavailable =>
      'Could not get your location. Check location permission or choose a city.';

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
}
