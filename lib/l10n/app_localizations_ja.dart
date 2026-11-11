// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get undo => '元に戻す';

  @override
  String duplicatedNamed(String name) {
    return '「$name」を複製しました';
  }

  @override
  String deletedNamed(String name) {
    return '「$name」を削除しました';
  }

  @override
  String get when => 'いつ？';

  @override
  String get newAtTime => '時刻を指定';

  @override
  String get newAtTimeHint => '平日の7:00、1回だけ15:30…';

  @override
  String get newAroundEvent => '予定に合わせて';

  @override
  String get newAroundEventHint => 'カレンダー、シャバットや日の出入りの時刻から探して、前・ちょうど・後に鳴らす';

  @override
  String get editThisAlarm => 'このアラームを編集';

  @override
  String editNamed(String name) {
    return '「$name」を編集';
  }

  @override
  String get preset => 'テンプレート';

  @override
  String get editThisCalendarRule => 'このカレンダールールを編集';

  @override
  String get ringThisOneAfterAll => 'やっぱり鳴らす';

  @override
  String get skipJustThisOne => '今回だけスキップ';

  @override
  String get renameGroup => 'グループ名を変更';

  @override
  String quickSet(String label, String time) {
    return '$label · $timeに鳴ります';
  }

  @override
  String get newAlarm => '新しいアラーム';

  @override
  String get appName => 'Quando?';

  @override
  String get lockMode => 'ロックモード';

  @override
  String get calendars => 'カレンダー';

  @override
  String get settings => '設定';

  @override
  String get nextAlarmHeading => '次のアラーム';

  @override
  String get nothingSet => '未設定';

  @override
  String get tagline => '何事にも時がある。';

  @override
  String sunriseAt(String time) {
    return '日の出 $time';
  }

  @override
  String sunsetAt(String time) {
    return '日の入り $time';
  }

  @override
  String get alarmsMayNotRing => 'アラームが鳴らない可能性があります';

  @override
  String get tapToFixIt => 'タップして修正';

  @override
  String inMinutes(int minutes) {
    return '$minutes分後';
  }

  @override
  String get atSunset => '日の入りに';

  @override
  String get sunset => '日の入り';

  @override
  String get shabbatModeIsOn => 'シャバットモードがオン';

  @override
  String nextInCity(String city) {
    return '次 · $city';
  }

  @override
  String get candleLighting => 'キャンドル点灯';

  @override
  String get havdalah => 'ハヴダラー';

  @override
  String get shabbatAndFestivals => 'シャバットと祝祭日';

  @override
  String get yourAlarmsHeading => 'あなたのアラーム';

  @override
  String get tapWhenToAdd => '「いつ？」をタップしてアラームを追加。';

  @override
  String get aroundEventsHeading => '予定に合わせて';

  @override
  String searchFor(String words) {
    return '検索: $words';
  }

  @override
  String get thisWeekHeading => '今週のアラーム';

  @override
  String get noAlarmsThisWeek => '今後7日間にアラームはありません。';

  @override
  String get alarmsSetThemselves => '何かを変更するたびに、アラームはこのスマホに自動で設定されます。';

  @override
  String cityTime(String city) {
    return '$cityの時刻';
  }

  @override
  String get more => 'その他';

  @override
  String get turnOff => 'オフにする';

  @override
  String get turnOn => 'オンにする';

  @override
  String get duplicate => '複製';

  @override
  String get delete => '削除';

  @override
  String get inOneHour => '1時間後';

  @override
  String get logoLabel => 'Quando?のロゴ';

  @override
  String get noTimesSet => '時刻が未設定';

  @override
  String get atTheMoment => 'その瞬間';

  @override
  String timesRange(int count, String from, String to) {
    return '$count回 · $from〜$to';
  }

  @override
  String spanDays(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n日');
    return '$_temp0';
  }

  @override
  String spanHours(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n時間');
    return '$_temp0';
  }

  @override
  String spanMinutes(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n分');
    return '$_temp0';
  }

  @override
  String spanSeconds(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n秒');
    return '$_temp0';
  }

  @override
  String get now => '今';

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
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n件のアラーム');
    return '$_temp0';
  }

  @override
  String get allOn => 'すべてオン';

  @override
  String get allOff => 'すべてオフ';

  @override
  String someOn(int n) {
    return '$n件オン';
  }

  @override
  String skippedBody(String body) {
    return 'スキップ · $body';
  }

  @override
  String timeToTime(String from, String to) {
    return '$from – $to';
  }

  @override
  String skippedCount(int n) {
    return '$n件スキップ';
  }

  @override
  String get sunNoRiseSet => '今日ここでは日の出も日の入りもありません';

  @override
  String sunProgress(int percent) {
    return '太陽は1日の$percent%を進みました';
  }

  @override
  String get sunIsDown => '日が沈みました';

  @override
  String get searchCity => '都市を検索';

  @override
  String get tomorrowLower => '明日';

  @override
  String get yesterdayLower => '昨日';

  @override
  String get worldClocksHeading => '世界時計';

  @override
  String get add => '追加';

  @override
  String cityHere(String city) {
    return '$city · 現在地';
  }

  @override
  String get worldClocksHint => '都市を追加するとここに時刻が表示されます。左にスワイプで削除。';

  @override
  String get groupNameHint => '仕事、子ども、ジム…';

  @override
  String get cancel => 'キャンセル';

  @override
  String get ok => 'OK';

  @override
  String get noGroup => 'グループなし';

  @override
  String get newGroupEllipsis => '新しいグループ…';

  @override
  String get newGroup => '新しいグループ';

  @override
  String secondsShort(int n) {
    return '$n秒';
  }

  @override
  String minutesShort(int n) {
    return '$n分';
  }

  @override
  String get minutes => '分';

  @override
  String get ringFor => '鳴らす長さ';

  @override
  String get seconds => '秒';

  @override
  String get oneSecondLess => '1秒減らす';

  @override
  String get oneSecondMore => '1秒増やす';

  @override
  String inDays(int d) {
    return '$d日後';
  }

  @override
  String inDaysHours(int d, int h) {
    return '$d日$h時間後';
  }

  @override
  String inHours(int h) {
    return '$h時間後';
  }

  @override
  String inHoursMinutes(int h, int m) {
    return '$h時間$m分後';
  }

  @override
  String inMins(int m) {
    return '$m分後';
  }

  @override
  String placeChange(String city, String where) {
    return '$city · $where · 変更';
  }

  @override
  String get israel => 'イスラエル';

  @override
  String get outsideIsrael => 'イスラエル国外';

  @override
  String get comingUpHeading => '今後の予定';

  @override
  String get lockForShabbat => 'シャバット中はスマホをロック';

  @override
  String get lockForShabbatHint => 'キャンドル点灯からハヴダラーまで、祝祭日も含む';

  @override
  String get ownShabbatAlarmsHeading => 'シャバット用のアラーム';

  @override
  String get addShabbatAlarm => 'シャバット・祝祭日のアラームを追加';

  @override
  String get readyMadeHeading => '用意されたアラーム';

  @override
  String bringBackDeleted(int n) {
    return '削除したものを戻す（$n）';
  }

  @override
  String get presetsHint => 'タップして時刻を変更。スワイプで削除。';

  @override
  String get lockSentence => 'シャバットや集中したい夜のために、スマホを時計とアラームだけにします。';

  @override
  String get lockExplain => 'ロック中、Quando?は時刻、次のアラーム、ロック終了時刻だけを表示します。アラームは動き続け、ロック解除まで何も変更できません。';

  @override
  String get lockNowHeading => '今すぐロック';

  @override
  String get lockAutoHeading => '自動でロック';

  @override
  String get shabbatAndFestivalsLong => 'シャバットと祝祭日';

  @override
  String get fromCandleToHavdalah => 'キャンドル点灯からハヴダラーまで';

  @override
  String get lockCalendarWord => 'この語を含むカレンダーの予定中';

  @override
  String get lockCalendarWordHint => '例：ロック、試験、集中';

  @override
  String get leaveEmptyForNone => '空欄でなし';

  @override
  String get connectCalendarsFirst => '先にカレンダーを接続（カレンダーアイコン）';

  @override
  String get openWhenLockStarts => 'ロック開始時にQuando?を開く';

  @override
  String get openWhenLockStartsHint => '1秒の静かな音でQuando?を前面に出してロックします';

  @override
  String get pinToScreen => 'Quando?を画面に固定';

  @override
  String get pinToScreenHint => 'ロック中は他のアプリが開きません。初回はAndroidが確認を求めます。';

  @override
  String get noLocksComingUp => '予定されたロックはありません。';

  @override
  String get leaveLockEarly => '早めに終えるには「長押しでロック解除」を3秒押し続けます。';

  @override
  String get locked => 'ロック中';

  @override
  String get shabbatShalom => 'シャバット・シャローム';

  @override
  String get chagSameach => 'ハグ・サメアハ';

  @override
  String get unlocksHeading => 'ロック解除';

  @override
  String get nowCap => '現在';

  @override
  String get nextAlarm => '次のアラーム';

  @override
  String get holdToUnlock => '長押しでロック解除';

  @override
  String get lockSentenceCalm => '試験、会議、静かな夜のために、時計とアラームだけにロックします。';

  @override
  String get lockCalendarHeading => 'カレンダーで';

  @override
  String get lockCalendarExplain => '予定の間、または予定から次に指定した予定までロックします。選んだどのカレンダーでも、共有カレンダーでも使えます。';

  @override
  String get lockAddCalendar => 'カレンダーロックを追加';

  @override
  String get lockEditCalendar => 'カレンダーロック';

  @override
  String get lockDuring => '予定の間';

  @override
  String get lockBetween => '2つの予定の間';

  @override
  String get lockStartsAt => 'この名前の予定…';

  @override
  String get lockStartsAtBetween => 'この名前の予定で開始…';

  @override
  String get lockEndsAt => '次のこの名前の予定で終了…';

  @override
  String get lockStartHint => '例：試験、集中、ジム';

  @override
  String get lockEndHint => '例：帰宅';

  @override
  String get lockAnyCalendar => 'すべてのカレンダー';

  @override
  String get lockNoMatches => 'まだ一致する予定はありません。';

  @override
  String get lockNextTimes => '次の予定';

  @override
  String lockDuringTitle(String a) {
    return '「$a」の間';
  }

  @override
  String lockBetweenTitle(String a, String b) {
    return '「$a」から次の「$b」まで';
  }

  @override
  String lockShabbatCalendarFound(String name) {
    return '「$name」には安息日の時刻があります。';
  }

  @override
  String get lockShabbatFromCalendar => 'キャンドル点灯からハヴダラまでロック';

  @override
  String get lockShabbatFromCalendarHint => 'そのカレンダーの時刻を使い、画面にキャンドルを表示します。';

  @override
  String get lockMoreWays => 'その他のロック方法';

  @override
  String get lockQuietTime => '静かな時間';

  @override
  String nextCandleLightingFrom(String time, String name) {
    return '次のキャンドル点灯：$time（$name）';
  }

  @override
  String get calendarAlarm => 'カレンダーアラーム';

  @override
  String get connectCalendars => 'カレンダーを接続';

  @override
  String get calendarAlarmsHeading => 'カレンダーアラーム';

  @override
  String get calendarNoneYet => 'まだありません。まずはこれから始めて、自由に変更してください：';

  @override
  String get fifteenBeforeEvery => 'すべての予定の15分前';

  @override
  String get useTheseCalendarsHeading => '使うカレンダー';

  @override
  String get noTimedEvents => 'これらのカレンダーに時刻付きの予定はありません。';

  @override
  String get atTheStart => '開始時';

  @override
  String everyForBefore(String every, String span) {
    return '$span前から$everyごと';
  }

  @override
  String spanAfterItEnds(String span) {
    return '終了の$span後';
  }

  @override
  String get noAlarmsChosen => 'アラーム未選択';

  @override
  String get gentleWakeUp => 'やさしい目覚め';

  @override
  String gentleSummary(int minutes, String sound) {
    return '$minutes分前 · $sound';
  }

  @override
  String get off => 'オフ';

  @override
  String get gentleSentence => 'アラームの前に穏やかな音が静かに始まり、驚いて目覚めることがありません。';

  @override
  String get gentleExplain => 'ゆっくり大きくなって浅い眠りから引き出し、アラームが鳴る直前に止まります。';

  @override
  String get startsBeforeHeading => 'アラームの前に開始';

  @override
  String get leadUpSoundHeading => '前奏の音';

  @override
  String get listen => '試聴';

  @override
  String get whoRecordedThese => 'これらの音の録音者';

  @override
  String get done => '完了';

  @override
  String get soundCredits => 'サウンドのクレジット';

  @override
  String yourTimeCity(String city) {
    return 'あなたの時刻（$city）';
  }

  @override
  String get anotherCity => '他の都市…';

  @override
  String get ringingIn5 => '5秒後に鳴ります…';

  @override
  String get alarmSaved => 'アラームを保存しました。';

  @override
  String alarmSetFor(String span) {
    return '$span後にアラームが鳴ります。';
  }

  @override
  String hoursMinutesShort(int h, int m) {
    return '$h時間$m分';
  }

  @override
  String get editAlarm => 'アラームを編集';

  @override
  String get previewCaps => '試聴';

  @override
  String get saveCaps => '保存';

  @override
  String cityTimeForYou(String city, String time) {
    return '$cityの時刻 · あなたの$time';
  }

  @override
  String repeatHeading(String repeat) {
    return '繰り返し · $repeat';
  }

  @override
  String get labelField => 'ラベル（音声アラームがオンなら読み上げ）';

  @override
  String get group => 'グループ';

  @override
  String ringsForHeading(String span) {
    return '$span鳴る';
  }

  @override
  String useDefault(String value) {
    return 'デフォルトを使用（$value）';
  }

  @override
  String get save => '保存';

  @override
  String get sameTime => '同じ時刻';

  @override
  String get untilYouStopIt => '止めるまで';

  @override
  String get alarm => 'アラーム';

  @override
  String get once => '1回';

  @override
  String get everyDay => '毎日';

  @override
  String get weekdays => '平日';

  @override
  String get weekends => '週末';

  @override
  String timeInCity(String time, String city) {
    return '$city時間で$time';
  }

  @override
  String eventsMatching(String words) {
    return '「$words」を含む予定';
  }

  @override
  String get everyEvent => 'すべての予定';

  @override
  String get sunrise => '日の出';

  @override
  String havdalahEndOf(String day) {
    return 'ハヴダラー · $dayの終わり';
  }

  @override
  String get yomTov => 'ヨム・トーヴ';

  @override
  String get shabbat => 'シャバット';

  @override
  String get presetCountdown => 'キャンドル点灯までのカウントダウン';

  @override
  String get presetHourly => '6時間前から1時間ごと';

  @override
  String get presetDailyWeek => '前の週に1日1回';

  @override
  String get presetSecondNight => '2日目の夜のキャンドル';

  @override
  String get presetFridayReminder => '3時間前のリマインダー：スマホを充電';

  @override
  String get presetFridayReminderLabel => 'スマホを充電して明日のアラームを設定';

  @override
  String get presetSunset => '日の入りと、その15分前';

  @override
  String get pesach => 'ペサハ（過越祭）';

  @override
  String get shavuot => 'シャブオット';

  @override
  String get roshHashanah => 'ロシュ・ハシャナ';

  @override
  String get yomKippur => 'ヨム・キプール';

  @override
  String get sukkot => 'スコット';

  @override
  String get sheminiAtzeret => 'シュミニ・アツェレト';

  @override
  String get simchatTorah => 'シムハット・トーラー';

  @override
  String get readyNotifications => 'アラームを表示';

  @override
  String get readyNotificationsWhy => 'アラーム画面と停止ボタンを表示できるようにします。';

  @override
  String get readyFullScreen => 'ロック画面の上で鳴らす';

  @override
  String get readyFullScreenWhy => 'スマホがロック中でもアラームを全画面で表示します。';

  @override
  String get readyExact => '分単位で正確に鳴らす';

  @override
  String get readyExactWhy => 'これがないと、スマホがアラームを数分遅らせることがあります。';

  @override
  String get readyBattery => '省電力中も動作';

  @override
  String get readyBatteryWhy => '省電力機能が夜間にアラームを止めないようにします。';

  @override
  String get tipXiaomi => 'Xiaomiのスマホ：設定 › アプリ › Quando?で自動起動をオンにし、省電力を「制限なし」にします。';

  @override
  String get tipSamsung => 'Samsungのスマホ：設定 › バッテリー › バックグラウンドでの使用制限で、Quando?がスリープになっていないか確認します。';

  @override
  String get tipHuawei => 'HuaweiとHonorのスマホ：設定 › バッテリー › アプリ起動でQuando?を手動管理にし、すべて許可します。';

  @override
  String get tipOther => 'このスマホでは：設定 › バッテリーでQuando?のバックグラウンド実行を許可し、最適化をオフにします。';

  @override
  String get testRing => 'テスト音';

  @override
  String get testRingBody => 'Quando?はあなたを起こせます';

  @override
  String get ringsIn20 => '20秒後に鳴ります。今すぐスマホをロックして待ってください。';

  @override
  String get readyToRing => '鳴らす準備';

  @override
  String get checkingPhone => 'スマホを確認中…';

  @override
  String get phoneReady => 'スマホはすべてのアラームを時間どおりに鳴らせます。';

  @override
  String thingsNeedFixing(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n件の修正が必要です。修正しないとアラームが鳴らないかもしれません。',
    );
    return '$_temp0';
  }

  @override
  String get fix => '修正';

  @override
  String get testIn20 => 'テスト：20秒後に鳴る';

  @override
  String get testIn20Hint => 'スマホをロックして置いてください。全画面でアラームが鳴れば準備完了です。';

  @override
  String get readyToRingHint => 'スマホがすべてのアラームを時間どおりに鳴らすか確認';

  @override
  String get connections => '連携';

  @override
  String get timeZoneHeading => 'タイムゾーン';

  @override
  String get followPhone => 'スマホに合わせる';

  @override
  String followPhoneNow(String city) {
    return '現在は$city。旅行先で自動的に変わります。';
  }

  @override
  String get zoneFixed => '固定。旅行中もアラームはこの時刻を保ちます。';

  @override
  String get shabbatCityHeading => 'シャバットの都市';

  @override
  String get inIsraelOneDay => 'イスラエル（祝祭日は1日）';

  @override
  String candleMinutesHeading(int n) {
    return 'キャンドル：日の入りの$n分前';
  }

  @override
  String get endOfShabbatHeading => 'シャバットと祝祭日の終わり';

  @override
  String get nightfallGeonim => '星の出（ゲオニーム、8.5°）';

  @override
  String get rabbeinuTam => '日の入りの72分後（ラベイヌ・タム）';

  @override
  String get whenAlarmRingsHeading => 'アラームが鳴るとき';

  @override
  String get recordOrAddSounds => '音を録音・追加';

  @override
  String get ringsForThisLong => 'この時間鳴って自動で止まります';

  @override
  String get sameFades => 'すべてのアラームで同じフェード';

  @override
  String get sameFadesOn => '各アラームのフェードを置き換えます。音量はそれぞれのままです。';

  @override
  String get sameFadesOff => 'オフ：各アラームは音量設定のフェードを使います。';

  @override
  String get sayItOutLoud => '読み上げる';

  @override
  String get sayItOutLoudHint => 'アラームの目的を読み上げます。例：「キャンドル点灯、15分前」';

  @override
  String get noSnooze => 'スヌーズなし';

  @override
  String snoozeUpTo(int times, int minutes) {
    return '$minutes分のスヌーズを最大$times回';
  }

  @override
  String get wakeUpCheck => '起床チェック';

  @override
  String get wakeUpCheckHint => '止めた後、「起きた」をタップしないと3分後にまた鳴ります';

  @override
  String get solveSum => '計算を解いて止める';

  @override
  String get provesAwake => '起きていることを確かめます';

  @override
  String get shabbatNoTasks => 'シャバットと祝祭日には、これらは適用されません。アラームは自動で止まり、スマホに触れる必要はありません。';

  @override
  String get testAlarmIn1 => '1分後にテストアラームを鳴らす';

  @override
  String get timesDisclaimer => '時刻はスマホ上で計算されます。判断が難しい場合はラビに相談するか、コミュニティのカレンダーを確認してください。';

  @override
  String get recommended => 'おすすめ';

  @override
  String get chooseCity => '都市を選択';

  @override
  String get testOnlyOnPhone => 'テストアラームはスマホでのみ動作します。';

  @override
  String get testAlarm => 'テストアラーム';

  @override
  String get testAlarmBody => 'アラームはこのように鳴ります';

  @override
  String get testAlarmIn1Set => '1分後にテストアラーム。スマホをロックしても大丈夫です。';

  @override
  String get presetGone => 'このテンプレートはもうありません。';

  @override
  String get editPreset => 'テンプレートを編集';

  @override
  String get on => 'オン';

  @override
  String get ringsHeading => '鳴るタイミング';

  @override
  String get noTimesYet => 'まだ時刻がありません。下で追加してください。';

  @override
  String get atTheMomentItself => 'その瞬間ちょうど';

  @override
  String get remove => '削除';

  @override
  String get addATime => '時刻を追加';

  @override
  String get resetPreset => '元に戻す';

  @override
  String get skipOneHint => '1回だけスキップするには、ホーム画面の「今週のアラーム」でタップします。';

  @override
  String get unitMinutes => '分';

  @override
  String get unitHours => '時間';

  @override
  String get unitDays => '日';

  @override
  String get before => '前';

  @override
  String get after => '後';

  @override
  String get oneWeek => '1週間';

  @override
  String daysShort(int n) {
    return '$n日';
  }

  @override
  String hoursShort(int n) {
    return '$n時間';
  }

  @override
  String get howToSearch => '検索のしかた';

  @override
  String get searchHelpWord => 'タイトルに「dentist」を含む（大文字小文字は区別しない）';

  @override
  String get searchHelpStar => '*は任意の文字：dentist、dentures';

  @override
  String get searchHelpQuestion => '?は1文字：yoga、toga';

  @override
  String get searchHelpPhrase => 'このフレーズそのまま';

  @override
  String get searchHelpAnd => '両方の語（AND）';

  @override
  String get searchHelpOr => 'どちらか。|も使えます';

  @override
  String get searchHelpNot => '除外。NOTや!も使えます';

  @override
  String get searchHelpBrackets => '括弧で語をまとめます';

  @override
  String get searchHelpEmpty => '空欄にするとすべての予定で鳴ります。';

  @override
  String get customTime => 'その他の時間';

  @override
  String get other => 'その他';

  @override
  String get sun => '太陽';

  @override
  String get calendar => 'カレンダー';

  @override
  String get newEventAlarm => '新しい予定アラーム';

  @override
  String get eventAlarm => '予定アラーム';

  @override
  String get findEventsHeading => '予定を探す';

  @override
  String get searchEventsHint => '検索：歯医者、ジム OR ヨガ、歯*…';

  @override
  String get alsoBuiltInTimes => 'シャバット・祝祭日・太陽の時刻も';

  @override
  String get alsoBuiltInTimesHint => '例：「キャンドル*」「ハヴダラー」「日の入り」';

  @override
  String get allMyCalendars => 'すべてのカレンダー';

  @override
  String get connectToSearch => 'カレンダーを接続して検索';

  @override
  String get searching => '検索中…';

  @override
  String get nothingMatches60 => '今後60日間に一致なし';

  @override
  String eventsIn60(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '今後60日間に$n件の予定');
    return '$_temp0';
  }

  @override
  String nextRingsAt(String times, String title) {
    return '次：「$title」のため$timesに鳴ります';
  }

  @override
  String showMoreLeft(int n) {
    return 'さらに表示（残り$n件）';
  }

  @override
  String get ringBeforeStartsHeading => '開始前に鳴らす';

  @override
  String get ringWhenStarts => '開始時に鳴らす';

  @override
  String get repeatBeforeHeading => '前に繰り返す';

  @override
  String get everyPrefix => '';

  @override
  String get offLower => 'オフ';

  @override
  String get forInfix => 'ごと · ';

  @override
  String get ringAfterEndsHeading => '終了後に鳴らす';

  @override
  String get nameOptional => '名前（任意）';

  @override
  String get toppedUp => 'アラームは今後7日分設定済みで、Quando?を開くたびに補充されます。';

  @override
  String get back => '戻る';

  @override
  String get next => '次へ';

  @override
  String get stepWhichEvents => 'どの予定';

  @override
  String get stepWhenToRing => 'いつ鳴らす';

  @override
  String get stepHowItRings => 'どう鳴らす';

  @override
  String defaultNamed(String name) {
    return 'デフォルト（$name）';
  }

  @override
  String get phoneAlarmSound => 'スマホのアラーム音';

  @override
  String get onlineRadio => 'ネットラジオ';

  @override
  String songLinkOpens(String app) {
    return '曲のリンク · $appで開く';
  }

  @override
  String get builtIn => '内蔵';

  @override
  String get yourRecording => 'あなたの録音';

  @override
  String get sound => 'サウンド';

  @override
  String get wakeToOwnSound => '自分の音で目覚める';

  @override
  String get wakeToOwnSoundHint => '自分の声、曲、Spotify、ライブラジオ';

  @override
  String musicAdded(String name) {
    return '$nameを追加しました。どのアラームの音にも選べます。';
  }

  @override
  String get playlists => 'プレイリスト';

  @override
  String get likedSongs => 'お気に入りの曲';

  @override
  String get noPlaylists => 'プレイリストはまだありません。';

  @override
  String get noLikedSongs => 'お気に入りの曲はまだありません。';

  @override
  String get needsMic => '録音にはマイクが必要です。';

  @override
  String recordingN(int n) {
    return '録音 $n';
  }

  @override
  String couldNotAddFile(String error) {
    return 'ファイルを追加できませんでした：$error';
  }

  @override
  String get addSongLink => '曲のリンクを追加';

  @override
  String get songLink => '曲のリンク';

  @override
  String get songLinkHowTo =>
      'Spotify、Apple Music、YouTube、YouTube Music、SoundCloudで「共有」→「リンクをコピー」をタップし、ここに貼り付けます。';

  @override
  String get songNameHint => '名前（例：朝のプレイリスト）';

  @override
  String get whenAlarmGoesOffHeading => 'アラームが鳴ったら';

  @override
  String get playTheSong => '曲を再生';

  @override
  String get ringThenOpen => '鳴らしてから開く';

  @override
  String get playTheSongHint => 'アプリが開いて再生します。10秒間無音ならバックアップ音が鳴るので、必ず目覚めます。タスク付きのアラームは先に鳴ってから開きます。';

  @override
  String get ringThenOpenHint => 'バックアップ音が鳴ります。停止するとアプリで曲が開きます。';

  @override
  String get playForHeading => '再生時間';

  @override
  String get pausesAfter => 'この時間が過ぎると、Quando?がスマホの一時停止キーで曲を止めます。';

  @override
  String get backupSoundHeading => 'バックアップ音';

  @override
  String get notALink => 'リンクではないようです。';

  @override
  String songOn(String app) {
    return '$appの曲';
  }

  @override
  String get theWeb => 'ウェブ';

  @override
  String get pickFromYouTube => 'YouTubeから選ぶ';

  @override
  String get youTubeAndMusic => 'YouTubeとYouTube Music';

  @override
  String get youTubeOn => '接続済み · 長押しでサインアウト';

  @override
  String get youTubeSignIn => 'Googleでサインイン';

  @override
  String get addSongLinkInstead => '代わりに曲のリンクを追加してください。';

  @override
  String get googleSignInFailed => 'Googleログインが完了しませんでした。もう一度お試しください。';

  @override
  String get myYouTube => 'マイYouTube';

  @override
  String get spotifyDirectOn => 'Spotify直接再生がオン';

  @override
  String get spotifyDirect => 'Spotify直接再生';

  @override
  String get spotifyDirectOnHint => 'オン · タップでオフ';

  @override
  String get spotifyDirectHint => 'その曲をそのまま再生。Premiumが必要です。';

  @override
  String get spotifyComingSoon => '近日公開 · Premiumが必要';

  @override
  String get spotifyFailed => 'Spotifyに接続できませんでした。Spotifyアプリがインストール済みで、ログインしていてPremiumであるか確認してください。';

  @override
  String get nameThisSound => 'この音に名前をつける';

  @override
  String get sounds => 'サウンド';

  @override
  String get soundsSentence => '自分の声、曲、プレイリスト、ライブラジオで目覚めましょう。';

  @override
  String stopTimer(String time) {
    return '停止 · $time';
  }

  @override
  String get record => '録音';

  @override
  String get addAFile => 'ファイルを追加';

  @override
  String get addSongLinkLong => '曲のリンクを追加（Spotify、Apple Music、YouTube…）';

  @override
  String get musicAppsHeading => '音楽アプリ';

  @override
  String get pickFromSpotify => 'Spotifyから選ぶ';

  @override
  String get yourPlaylistsAndLiked => 'プレイリストとお気に入りの曲';

  @override
  String get mySpotify => 'マイSpotify';

  @override
  String get spotifySignInFailed => 'Spotifyにログインできませんでした。';

  @override
  String get appleMusicNote => 'ログインはiPhone版で対応予定です。今は曲のリンクを追加してください。';

  @override
  String noSignInNote(String service) {
    return '$serviceは他のアプリからのログインを許可していません。代わりに曲のリンクを追加してください。';
  }

  @override
  String get wakeToRadio => 'ネットラジオで目覚める';

  @override
  String get soundsExplain => '最大5分の録音、ファイル、曲のリンク、ラジオを追加。失敗時は予備の音が鳴ります。';

  @override
  String get yourSoundsHeading => 'あなたのサウンド';

  @override
  String playsIn(String app) {
    return '$appで再生';
  }

  @override
  String opensIn(String app) {
    return '$appで開く';
  }

  @override
  String forSpan(String span) {
    return '$span';
  }

  @override
  String get defaultLabel => 'デフォルト';

  @override
  String get radioUnreachable => '局リストに接続できません。接続を確認してください。';

  @override
  String get addStreamAddress => 'ストリームのアドレスを追加';

  @override
  String get notAStream => 'ストリームのアドレスではないようです（httpで始まります）。';

  @override
  String get anyGenre => 'すべてのジャンル';

  @override
  String get stationName => '局名';

  @override
  String get closeSearch => '検索を閉じる';

  @override
  String get searchByName => '名前で検索';

  @override
  String get anywhere => 'すべての地域';

  @override
  String get noStations => '局が見つかりません。別のジャンルや国をお試しください。';

  @override
  String wakeUpTo(String name) {
    return '$nameで目覚める';
  }

  @override
  String get notQuite => '惜しい。もう一度。';

  @override
  String shabbatStopsItself(int n) {
    return 'シャバットモード：$n秒後に自動で止まります。スマホに触れる必要はありません。';
  }

  @override
  String get solveToSnooze => '解いてスヌーズ';

  @override
  String get solveToStop => '解いて停止';

  @override
  String get answer => '答え';

  @override
  String get snooze => 'スヌーズ';

  @override
  String get stop => '停止';

  @override
  String get shakeToSnooze => '振ってスヌーズ';

  @override
  String get shakeToStop => '振って停止';

  @override
  String get shakeHard => 'バーがいっぱいになるまでスマホを強く振ってください。';

  @override
  String get cantShake => '振れない？計算を解く';

  @override
  String get pairsToSnooze => 'ペアを揃えてスヌーズ';

  @override
  String get pairsToStop => 'ペアを揃えて停止';

  @override
  String get typeToSnooze => '入力してスヌーズ';

  @override
  String get typeToStop => '入力して停止';

  @override
  String get scanToSnooze => 'コードをスキャンしてスヌーズ';

  @override
  String get scanToStop => 'コードをスキャンして停止';

  @override
  String ringAgainUnless(int n) {
    return '下をタップしないと$n分後にまた鳴ります。';
  }

  @override
  String get imUp => '起きた';

  @override
  String snoozeMin(int n) {
    return '$n分スヌーズ';
  }

  @override
  String snoozeMinLeft(int n, int left) {
    return '$n分スヌーズ · 残り$left回';
  }

  @override
  String get noSnoozesLeft => 'スヌーズ残りなし';

  @override
  String get stopThenOpen => '停止 · その後開く';

  @override
  String get startingSong => '曲を開始中';

  @override
  String wayToStop(String way) {
    return '$wayで停止';
  }

  @override
  String wayToSnooze(String way) {
    return '$wayでスヌーズ';
  }

  @override
  String ringsForMore(int n) {
    return 'あと$n秒鳴ります';
  }

  @override
  String get leftToRing => '残り';

  @override
  String get wayVolumeButtons => '音量ボタン';

  @override
  String get wayShake => 'スマホを振る';

  @override
  String get taskNothing => 'なし';

  @override
  String get taskSum => '計算を解く';

  @override
  String get taskShake => '30回振る';

  @override
  String get taskMemory => '神経衰弱';

  @override
  String get taskPhrase => '文を入力';

  @override
  String get taskScan => 'コードをスキャン';

  @override
  String get noLimit => '無制限';

  @override
  String upToTimes(int n) {
    return '最大$n回';
  }

  @override
  String shorterEachTime(int n) {
    return '毎回$n分短く';
  }

  @override
  String autoSnoozeAfter(int n) {
    return '$n分後に自動スヌーズ';
  }

  @override
  String get card => 'カード';

  @override
  String get hiddenCard => '伏せたカード';

  @override
  String get phrase1 => '目が覚めた今日は私の日';

  @override
  String get phrase2 => '今でなければいつ';

  @override
  String get phrase3 => '私と大切な人みんなにおはよう';

  @override
  String get phrase4 => '足は床についてもう起きた';

  @override
  String get phrase5 => '今日また新しく始める';

  @override
  String get notQuiteWords => '惜しい、一語ずつ確認してください。';

  @override
  String get typeItHere => 'ここに入力';

  @override
  String get differentCode => '別のコードです。';

  @override
  String get cameraUnavailable => 'カメラを使用できません。';

  @override
  String get cantScan => 'スキャンできない？計算を解く';

  @override
  String get saveCodeToScan => 'スキャン用のコードを保存';

  @override
  String get saveCodeHint => 'キッチンの箱や洗面所の歯磨き粉など、歩いて行く必要がある場所のバーコードやQRコードを写します。アラームを止めるときにもう一度スキャンします。';

  @override
  String get cameraUnavailableSettings => 'カメラを使用できません。設定でカメラへのアクセスを許可してください。';

  @override
  String gentleToGo(int n) {
    return 'やさしい目覚め · あと$n分';
  }

  @override
  String previewBody(String body) {
    return '試聴 · $body';
  }

  @override
  String snoozedBody(String body) {
    return 'スヌーズ中：$body';
  }

  @override
  String get areYouUp => '起きましたか？';

  @override
  String get tapImUp => '「起きた」をタップして停止';

  @override
  String get volume => '音量';

  @override
  String get wakeCheckOn => '起床チェックがオン';

  @override
  String get stopsAtOnce => 'すぐに止まる';

  @override
  String get ringsAgainIfNotUp => '起きていなければまた鳴る';

  @override
  String get openAppAfter => '後でアプリを開く';

  @override
  String get noTask => 'タスクなし';

  @override
  String get codeSaved => 'コードを保存しました';

  @override
  String get tapToSaveDifferent => 'タップして別のコードを保存';

  @override
  String get controlsHeading => '操作';

  @override
  String get onScreen => '画面上';

  @override
  String get taskHeading => 'タスク';

  @override
  String get none => 'なし';

  @override
  String get snoozeSentence => 'あと5分？長さ、回数、必要なことを選べます。';

  @override
  String get settingsHeading => '設定';

  @override
  String get snoozeTime => 'スヌーズ時間';

  @override
  String get snoozeTimeHint => '最初のスヌーズの長さ';

  @override
  String get shortenSnoozes => '以降のスヌーズを短く';

  @override
  String get shortenSnoozesHint => '2回目以降のスヌーズをこの分だけ短く';

  @override
  String get autoSnooze => '自動スヌーズ';

  @override
  String get autoSnoozeHint => '触れなかった場合、この時間後に自動でスヌーズ';

  @override
  String get never => 'しない';

  @override
  String get snoozeLimit => 'スヌーズ回数の上限';

  @override
  String get snoozeLimitHint => 'スヌーズできる回数';

  @override
  String get unlimited => '無制限';

  @override
  String get useSnoozeFromSettings => '設定のスヌーズを使う';

  @override
  String get stopSentence => 'アラームの止め方と、先にやるべきこと。';

  @override
  String get shabbatNoTask => 'シャバットと祝祭日にはアラームは自動で止まり、タスクを求めることはありません。';

  @override
  String get volumeSentence => 'どれくらいの音量で、どれくらい穏やかにそこまで上がるか。';

  @override
  String get openAfterAlarm => 'アラーム後に開く';

  @override
  String get pickAnApp => 'アプリを選択';

  @override
  String get orPasteLink => 'またはリンクを貼り付け：https://…';

  @override
  String get useThisLink => 'このリンクを使う';

  @override
  String get noAppsFound => 'アプリが見つかりません。';

  @override
  String get weather => '天気';

  @override
  String get news => 'ニュース';

  @override
  String get usePhoneVolume => 'スマホのアラーム音量を使う';

  @override
  String get setsPhoneVolume => '鳴っている間スマホのアラーム音量を設定し、その後元に戻します。';

  @override
  String get fadeInOff => 'フェードインなし、最初から最大音量';

  @override
  String fadeInOver(String span) {
    return '$spanかけて大きくなる';
  }

  @override
  String get fadeOutOff => 'フェードアウトなし';

  @override
  String fadeOutOver(String span) {
    return '最後の$spanで小さくなる';
  }

  @override
  String get fadesExplain => 'フェードアウトはアラームが自動で止まるときに起こります。フェードが鳴る時間より長い場合、両方短くなります。';

  @override
  String get soundSoftChime => 'やわらかなチャイム';

  @override
  String get soundMorningRise => '朝の目覚め';

  @override
  String get soundClassicBeep => 'クラシックなビープ';

  @override
  String get calmCity => '静かな街の朝';

  @override
  String get calmBirds => '夜明けの鳥';

  @override
  String get calmWaves => '岸辺の波';

  @override
  String get calmRain => 'やさしい雨';

  @override
  String get calmStream => '森の小川';

  @override
  String get calmWind => 'やさしい風';

  @override
  String get calmFire => 'はぜる焚き火';

  @override
  String get calmNight => '夏の夜';

  @override
  String get publicDomain => 'パブリックドメイン';

  @override
  String get phoneVolume => 'スマホの音量';

  @override
  String fadesIn(String span) {
    return '$spanかけて大きく';
  }

  @override
  String fadesOut(String span) {
    return '$spanかけて小さく';
  }

  @override
  String get noFade => 'フェードなし';

  @override
  String minSecShort(int m, int s) {
    return '$m分$s秒';
  }

  @override
  String get happensRings => '鳴る';

  @override
  String get happensStopped => '止めた';

  @override
  String get happensSnoozed => 'スヌーズした';

  @override
  String get happensAutoStopped => '自動で止まった';

  @override
  String get eventLower => '予定';

  @override
  String get appTest => 'Quando?テスト';

  @override
  String get pushoverConnected => 'Pushoverに接続しました';

  @override
  String get webhookConnected => 'Webhookに接続しました';

  @override
  String pushoverSaid(int code, String body) {
    return 'Pushoverの応答 $code：$body';
  }

  @override
  String couldNotReachPushover(String error) {
    return 'Pushoverに接続できませんでした（$error）';
  }

  @override
  String itAnswered(int code) {
    return '応答：$code';
  }

  @override
  String couldNotReachIt(String error) {
    return '接続できませんでした（$error）';
  }

  @override
  String get calendarNotAllowed => 'カレンダーへのアクセスが許可されませんでした。';

  @override
  String get playlist => 'プレイリスト';

  @override
  String songCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n曲');
    return '$_temp0';
  }

  @override
  String get spotifySaidNo =>
      'Spotifyに拒否されました。SpotifyダッシュボードでQuando?のWeb APIにチェックを入れ、User Managementにアカウントを追加してください。';

  @override
  String serviceDidntAnswer(String service, int code) {
    return '$serviceが応答しませんでした（$code）。';
  }

  @override
  String get youTubeSaidNo => 'YouTubeに拒否されました。GoogleアカウントがQuandoプロジェクトのテストユーザーか確認してください。';

  @override
  String get event => '予定';

  @override
  String eventEnds(String title) {
    return '$title（終了）';
  }

  @override
  String foundSoundsDevices(int s, int d) {
    return '$s個の音と$d台のデバイスが見つかりました。';
  }

  @override
  String get sentCheckDevices => '送信しました。他のデバイスを確認してください。';

  @override
  String sentTo(String name) {
    return '$nameに送信しました。';
  }

  @override
  String get zapierHowTo => 'Zapierで「Webhooks by Zapier → Catch Hook」から始まるZapを作り、そのURLをここに貼り付けます。';

  @override
  String get catchHookUrl => 'Catch HookのURL';

  @override
  String get iftttHowTo =>
      'IFTTTで「Webhooks → Receive a web request with a JSON payload」から始まるアプレットを作ります。ここでも同じイベント名を使ってください。キーはifttt.com/maker_webhooks/settingsにあります。';

  @override
  String get eventName => 'イベント名';

  @override
  String get webhooksKey => 'Webhooksキー';

  @override
  String get webhookHowTo => 'Quando?はこのアドレスにJSON POSTを送ります。';

  @override
  String get connectionsSentence => 'アラームが鳴った・止まった・スヌーズされたときに、他のアプリやデバイスに知らせます。';

  @override
  String get pushWhenRings => 'アラームが鳴ったら通知を送る';

  @override
  String get pushWhenRingsHint => '他のスマホ、タブレット、時計、パソコンへ';

  @override
  String get yourUserKey => 'ユーザーキー';

  @override
  String get appToken => 'アプリトークン';

  @override
  String get soundAndDevicesHeading => 'サウンドとデバイス';

  @override
  String get loading => '読み込み中…';

  @override
  String get loadFromPushover => 'Pushoverから読み込む';

  @override
  String get soundItPlays => '再生する音';

  @override
  String get myPushoverDefault => 'Pushoverのデフォルト';

  @override
  String get pushoverOwnSounds => 'pushover.net/soundsにアップロードした自分の音がここに表示されます。';

  @override
  String get allMyDevices => 'すべてのデバイス';

  @override
  String get pushoverOnThisPhone => 'このスマホにもPushoverアプリを入れると、ここでもPushoverの音で鳴ります。';

  @override
  String get priority => '優先度';

  @override
  String get priorityNormal => '通常';

  @override
  String get priorityHigh => '高：おやすみ時間も通知';

  @override
  String get priorityEmergency => '緊急：確認されるまで繰り返す';

  @override
  String get sending => '送信中…';

  @override
  String get sendATest => 'テストを送信';

  @override
  String get findUserKey => 'ユーザーキーを探す';

  @override
  String get makeAppToken => 'アプリトークンを作成';

  @override
  String get webhooksHeading => 'ZAPIER、IFTTT、WEBHOOK';

  @override
  String get webhooksExplain => 'アラームが鳴ったり止めたりしたときに何でも起動できます。照明をつける、起床時刻を記録する、誰かにメッセージを送るなど。';

  @override
  String get sendWhenAlarm => 'アラームが次のとき送信：';

  @override
  String get pauseOnShabbat => 'シャバットと祝祭日は一時停止';

  @override
  String get pauseOnShabbatHint => 'キャンドル点灯からハヴダラーまでのアラームでは何も送信しません';

  @override
  String get webhookPayloadNote =>
      '各メッセージには event（ring、stopped、snoozed、auto_stopped）、title、body、time、shabbat、snoozes が含まれます。キーはこのスマホに残ります。';

  @override
  String get today => '今日';

  @override
  String get tomorrow => '明日';

  @override
  String get notAWebAddress => 'https://で始まるウェブアドレスではないようです';

  @override
  String get language => '言語';

  @override
  String get phoneLanguage => 'スマホの言語';

  @override
  String get ringQuote => '今でなければ、いつ？';

  @override
  String get ringQuoteBy => 'ヒレル';

  @override
  String get quotesTitle => '時についての言葉';

  @override
  String get quotesHint => 'どこから選ぶか決めてください。一日の時間帯ごとに一つ。タップすると別の言葉が出ます。';

  @override
  String get quotesOff => 'オフ';

  @override
  String get quoteSongs => '歌';

  @override
  String get quoteMovies => '映画';

  @override
  String get quoteLiterature => '本と詩';

  @override
  String get quoteTanakh => 'タナハ（ヘブライ語聖書）';

  @override
  String get quoteSages => 'タルムードと賢者';

  @override
  String get quoteSpeeches => '有名な演説';

  @override
  String get quotePhilosophy => '哲学者';

  @override
  String get quoteProverbs => 'ことわざ・格言';

  @override
  String get quotesAlso => 'こちらも表示';

  @override
  String get quoteCarnaval => 'カーニバル';

  @override
  String get quoteCarnavalHint => 'ブラジルのカーニバル期間の歌と言葉';

  @override
  String get quoteNearMe => '近くの言葉';

  @override
  String get quoteNearMeHint => 'タイムゾーンとシャバットの都市から、あなたの土地の詩人や記念日';

  @override
  String get quoteSiddur => 'シドゥール（祈祷書）';

  @override
  String weeklyParasha(String name) {
    return '今週のパラシャ $name';
  }

  @override
  String poweredBy(String name) {
    return '$name 搭載';
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
  String get spotifyLibrarySignIn => 'プレイリスト、お気に入り、検索';

  @override
  String get spotifyLibraryOn => '接続済み · 長押しでサインアウト';

  @override
  String spotifyLoginError(String reason) {
    return 'Spotifyにサインインできませんでした：$reason';
  }

  @override
  String googleSignInError(String reason) {
    return 'Googleにサインインできませんでした：$reason';
  }

  @override
  String get searchSongsHint => '曲、アーティスト、プレイリストを検索';

  @override
  String nothingFound(String query) {
    return '「$query」は見つかりませんでした。';
  }

  @override
  String get deliveryTitle => '通知方法';

  @override
  String get deliveryLocal => '本体の音';

  @override
  String get deliveryBoth => '両方';

  @override
  String get deliveryConnect => 'Pushoverを接続';

  @override
  String get deliveryLoadFailed => '音とデバイスを読み込めませんでした。再試行してください。';

  @override
  String get deliveryBothHint => 'Pushoverが失敗しても本体の音は鳴ります。';

  @override
  String get deliveryPushHint => 'Pushoverのみ。通知時にこのデバイスがオンラインである必要があります。';

  @override
  String get deliveryFallback => 'Pushoverが未接続または一時停止中は本体の音を使用します。';

  @override
  String get deliveryReset => '既存の設定を使う';

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
  String get tuyaSignInTitle => 'Smart Life アカウントでログイン';

  @override
  String get tuyaSignInHint =>
      'Smart Life または Tuya Smart アプリと同じ国、メールまたは電話番号、パスワードを使ってください。アカウントはすでに Tuya プロジェクトにリンクされている必要があります。パスワードは Tuya にのみ送られ、保存されません。';

  @override
  String get tuyaCountryCode => '国番号（ブラジル 55、米国 1）';

  @override
  String get tuyaAccount => 'Smart Life のメールまたは電話番号';

  @override
  String get tuyaPassword => 'Smart Life のパスワード';

  @override
  String get tuyaSignIn => 'ログインしてシーンを読み込む';

  @override
  String get tuyaRelayUrl => 'Quando Tuya リレーのアドレス（https）';

  @override
  String get tuyaRelayHint =>
      'Smart Life または Tuya Smart アカウントの国、メールまたは電話番号、パスワードを使ってください。Quando の Tuya リレーに一度だけ送られ、保存されません。Quando アカウントにログインしている必要があります。';

  @override
  String get tuyaGoogleHint =>
      'Smart Life に Google や Apple でログインしていますか？ Smart Life で「パスワードを忘れた場合」をタップしてパスワードを設定し、ここで使ってください。';

  @override
  String get tuyaLinked => 'Smart Life アカウントをリンク済み';

  @override
  String get tuyaUnlink => 'リンク解除';

  @override
  String get tuyaNeedsAccount => '先に設定で Quando アカウントにログインしてください。';

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
  String get musicRingDurationHint => '再生はこのアラームの鳴動時間に従い、停止またはスヌーズで止まります。';

  @override
  String get musicBackupPlaying => '音楽を開始できませんでした。ローカルのアラーム音を再生しています。';

  @override
  String desktopMusicConnect(String service) {
    return '$serviceアプリを接続';
  }

  @override
  String desktopMusicOn(String service) {
    return '$serviceに接続済み · 長押しで解除';
  }

  @override
  String get musicSongs => '曲';

  @override
  String get noMusicSongs => 'ミュージックライブラリに曲が見つかりません。';

  @override
  String serviceConnectUnavailable(String service) {
    return '$serviceのリンクを追加 · アラーム後に開きます';
  }

  @override
  String get soundCloudWidgetNote => '公開リンクを追加';

  @override
  String get youtubePlayerHint => 'YouTubeは表示中のプレーヤーで動画を再生します。非表示または再生できない場合はローカルのアラームが続きます。';

  @override
  String get musicPreviewFailed => 'この音を再生できませんでした。接続を確認するか、別の曲や放送局をお試しください。';

  @override
  String get skyMoonPhase => '月の満ち欠け';

  @override
  String get skyMoonDetailsDisplay => '月相ページを追加';

  @override
  String get skyMoonDetailsHint => 'スワイプするか、いつでも月のカードをタップ';

  @override
  String get moonRises => '月の出';

  @override
  String get moonSets => '月の入り';

  @override
  String moonLunarDay(int day) {
    return 'この朔望月の29.5日中$day日目';
  }

  @override
  String get moonDetailsOpen => '月相を開く';

  @override
  String get musicPlaylists => '音楽プレイリスト';

  @override
  String get videoPlaylists => '動画プレイリスト';

  @override
  String get likedVideos => '高く評価した動画';

  @override
  String get wholePlaylist => 'プレイリスト全体で起きる';

  @override
  String get noSongsInPlaylist => '再生できる曲がありません。';

  @override
  String get hebrewNamesHeading => 'パラシャと月名の表記';

  @override
  String get hebrewNamesIsraeli => 'イスラエル式';

  @override
  String get hebrewNamesAshkenazi => 'アシュケナージ式';

  @override
  String pickFromService(String service) {
    return '$serviceから選ぶ';
  }

  @override
  String get weatherTonight => '今夜';

  @override
  String get weatherTomorrowMorning => '明日の朝';

  @override
  String weatherUntilAbout(String time) {
    return '$timeごろまで';
  }

  @override
  String get weatherSunBehindClouds => '太陽は雲の向こう';

  @override
  String get keysLockTitle => 'デバイス間のキー';

  @override
  String get keysLockOff => 'サービスのキーはこのデバイスに残ります。同期パスフレーズを選ぶと、暗号化してほかのデバイスに送れます。';

  @override
  String get keysLockOn => 'サービスのキーは、このデバイスを離れる前に同期パスフレーズで暗号化されます。Google を含め、ほかの誰も読めません。';

  @override
  String get keysLockWaiting => 'ほかのデバイスからキーが届きましたが、ロックされています。同期パスフレーズを入力して開いてください。';

  @override
  String get keysSetPassphrase => 'パスフレーズを選ぶ';

  @override
  String get keysChangePassphrase => 'パスフレーズを変更';

  @override
  String get keysUnlock => 'キーを開く';

  @override
  String get keysStartOver => '忘れた場合はやり直す';

  @override
  String get keysStartOverHint => 'やり直すと、このデバイスのキーを新しいパスフレーズで送ります。ほかのデバイスでは新しいパスフレーズを求められます。';

  @override
  String get keysPassphrase => '同期パスフレーズ';

  @override
  String get keysPassphraseAgain => 'もう一度入力';

  @override
  String keysPassphraseShort(int count) {
    return '$count 文字以上にしてください。';
  }

  @override
  String get keysPassphraseMismatch => '2つが一致しません。';

  @override
  String get keysPassphraseWrong => 'このパスフレーズではキーを開けません。';

  @override
  String get keysPassphraseNote => '書き留めてください。忘れると誰にも復元できず、キーを入力し直すことになります。';

  @override
  String get keysShareNeedsPassphrase => '先に「デバイス間のキー」で同期パスフレーズを選んでください。';

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
  String get calendarSourcesIntro => 'Quando? はカレンダーの予定の前後に鳴らせます。どこから読むか選んでください。';

  @override
  String get deviceCalendarsHeading => 'このデバイス';

  @override
  String get deviceCalendarsTitle => 'このデバイスのカレンダーアプリ';

  @override
  String get deviceCalendarsHint => 'このデバイスのすべてのアカウント：Google、Samsung、Outlook、iCloud、ここだけのカレンダー。';

  @override
  String get googleCalendarHeading => 'GOOGLE カレンダー';

  @override
  String get googleCalendarSignIn => 'Google でログインすると、Google アカウントがこのデバイスになくても Google から直接カレンダーを読み込めます。';

  @override
  String googleCalendarSignedIn(String email) {
    return '$email でログイン中';
  }

  @override
  String get googleCalendarSignOut => 'ログアウト';

  @override
  String get googleCalendarNotHere =>
      'このデバイスではまだ Google ログインを使えません。デバイスの設定（カレンダー › アカウント）で Google アカウントを追加すると、そのカレンダーがこのデバイスの欄に表示されます。';

  @override
  String get googleCalendarUnreachable => '今は Google カレンダーにつながりません。すでに設定したアラームは鳴ります。';

  @override
  String get googleCalendarTwiceHint => '同じ Google アカウントのカレンダーがすでにこのデバイスにある場合、二重に鳴らないよう最初はオフです。';

  @override
  String get timersTitle => 'タイマー';

  @override
  String get timerStopwatch => 'ストップウォッチ';

  @override
  String get timerCountdown => 'タイマー';

  @override
  String get timerSequence => '用意';

  @override
  String get timerStopwatchSub => 'ラップ付きでカウントアップ';

  @override
  String get timerCountdownSub => 'カウントダウンして0で鳴る';

  @override
  String get timerSequenceSub => '音声のスタートとマーク';

  @override
  String get timerStart => 'スタート';

  @override
  String get timerPause => '一時停止';

  @override
  String get timerResume => '再開';

  @override
  String get timerReset => 'リセット';

  @override
  String get timerLap => 'ラップ';

  @override
  String get timerTimesUp => '時間です';

  @override
  String get timerSetTime => '時間を設定';

  @override
  String get timerMinutes => '分';

  @override
  String get timerSeconds => '秒';

  @override
  String get seqOnYourMarks => '位置について';

  @override
  String get seqGetSet => '用意';

  @override
  String get seqGo => 'スタート！';

  @override
  String get seqFinish => '終了！';

  @override
  String get seqReady => '準備完了';

  @override
  String get seqSettings => '設定';

  @override
  String get seqStartCalls => 'スタート前のコール';

  @override
  String get seqStartCallsHelp => 'スタートの前に声で読み上げます。スタートから逆算します。';

  @override
  String seqCallBefore(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n秒前');
    return '$_temp0';
  }

  @override
  String get seqAddCall => 'コールを追加';

  @override
  String get seqCallText => '読み上げる内容';

  @override
  String get seqGoText => '開始時に言う';

  @override
  String get seqFinishText => '終了時に言う';

  @override
  String get seqLength => '長さ';

  @override
  String get seqNoLimit => '無制限';

  @override
  String get seqSayEvery => '時刻を読み上げる間隔';

  @override
  String get seqOff => 'オフ';

  @override
  String seqEverySeconds(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n秒');
    return '$_temp0';
  }

  @override
  String seqEveryMinutes(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n分');
    return '$_temp0';
  }

  @override
  String get seqFinalCount => '最後のカウントダウン';

  @override
  String get seqMarks => 'マーク';

  @override
  String get seqAddMark => 'マークを追加';

  @override
  String seqMarkAt(String time) {
    return '$timeに';
  }

  @override
  String get seqSpeak => '声で読み上げる';

  @override
  String get seqBeeps => 'ビープ音とバイブレーション';

  @override
  String get seqSayRemaining => '経過時間ではなく残り時間を読み上げる';

  @override
  String get seqPresets => 'プリセット';

  @override
  String get seqPresetRace => 'レース開始';

  @override
  String get seqPresetSprint => '30秒の全力';

  @override
  String get seqPresetRound => '1分ラウンド';

  @override
  String get seqHintNoLimit => 'スタートの後、止めるまでカウントアップします。';

  @override
  String get seqHintLength => 'スタートの後、0までカウントダウンします。';

  @override
  String get seqWords => '言葉';

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
  String get homeClockSize => 'ホームの時計';

  @override
  String get sizeSmall => '小';

  @override
  String get sizeMedium => '中';

  @override
  String get sizeLarge => '大';

  @override
  String get homeLayout => 'ホームのレイアウト';

  @override
  String get homeLayoutClassic => 'クラシック';

  @override
  String get homeLayoutCards => 'カード';

  @override
  String get homeCardsHint => 'カードをドラッグして移動。端や角をドラッグするか、サイズを選んで大きさを変更。';

  @override
  String get homeAddCard => 'カードを追加';

  @override
  String get homeOnHome => 'ホームにあり';

  @override
  String get homeRemoveCard => '削除';

  @override
  String get cardNext => '次のアラーム';

  @override
  String get cardClock => '時計と日付';

  @override
  String get cardSky => '太陽・月・天気';

  @override
  String get cardMoon => '月';

  @override
  String get cardWeather => '天気';

  @override
  String get cardAlarms => 'あなたのアラーム';

  @override
  String get cardQuick => 'クイックアラーム';

  @override
  String get cardTools => 'ストップウォッチ・カウントダウン・よーい';

  @override
  String get cardWorld => '世界時計';

  @override
  String get cardWeek => '今週';

  @override
  String get cardShabbat => '安息日と祝日';

  @override
  String get ringAtEventReminders => '予定自体のリマインダーで鳴らす';

  @override
  String get ringAtEventRemindersHint => 'カレンダーアプリのリマインダーが、このアラームの音で大きなアラームとして鳴ります。';

  @override
  String get atEventReminders => '予定のリマインダーで';

  @override
  String get everyEventReminderLoud => 'すべての予定のリマインダーで大きく鳴らす';

  @override
  String get loudNotificationsHeading => 'カレンダー通知を大きく';

  @override
  String get loudNotificationsTitle => 'カレンダー通知を大きな音で鳴らす';

  @override
  String get loudNotificationsHint => 'カレンダーアプリがリマインダーを表示すると、マナーモードでも Quando? がアラームとして鳴らします。';

  @override
  String get loudNotificationsDisclosureTitle => 'Quando? にカレンダー通知の読み取りを許可しますか？';

  @override
  String get loudNotificationsDisclosure =>
      'カレンダーのリマインダーを大きな音で鳴らすには、Quando? に通知へのアクセスが必要です。選んだカレンダーアプリの通知だけを見て、アラームに表示するためにタイトルと本文をこの端末上で読み取ります。保存したり送信したりすることはありません。いつでもオフにできます。';

  @override
  String get loudNotificationsAgree => '同意して続ける';

  @override
  String get loudNotificationsNoAccess => '通知へのアクセスがオフです。開いた一覧で Quando? をオンにしてください。';

  @override
  String get loudNotificationsAllow => '許可';

  @override
  String get loudNotificationsNoApps => 'この端末に対応するカレンダーアプリが見つかりません。';

  @override
  String get loudNotificationsTwiceNote => 'Quando? のカレンダーアラームがある予定は一度だけ鳴ります。';

  @override
  String get loudNotificationsShabbatNote => '安息日と祭日は鳴りません。';

  @override
  String get busyMode => '取り込み中モード';

  @override
  String get busyModeSubtitle => '取り込み中はおやすみモードと自動返信';

  @override
  String get busyIntro => '取り込み中は Quando? が端末を静かにし、代わりにメッセージに返信します。アラームは鳴ります。';

  @override
  String get busyIosFocus =>
      'iPhone と iPad では、アプリが集中モードをオンにしたりメッセージに返信したりできません。ショートカットアプリで「Quando? を開いたとき」または時刻をきっかけに集中モードをオンにするオートメーションを作り、集中モードで自動返信を設定してください。';

  @override
  String get busyWhileHeading => '取り込み中';

  @override
  String get busyDnd => 'おやすみモード';

  @override
  String get busyDndHint => '優先のみ：通話とメッセージは鳴らず、アラームは鳴ります。終わると元に戻ります。';

  @override
  String get busyDndNoAccess => 'Quando? はまだおやすみモードを変更できません。';

  @override
  String get busyReplies => 'メッセージに返信';

  @override
  String get busyRepliesHint => '1人につき1回、あなたの文面で、アプリ自身の返信ボタンから。Android のみ。';

  @override
  String get busyRepliesDisclosureTitle => 'Quando? にメッセージへの返信を許可しますか？';

  @override
  String get busyRepliesDisclosure =>
      '代わりに返信するには、Quando? に通知へのアクセスが必要です。取り込み中だけ、選んだアプリのメッセージ通知を見て、送信者の名前をこの端末上で読み取り、アプリ自身の返信ボタンからあなたの文面を一度送ります。メッセージを保存したり他へ送ったりすることはありません。許可しない限りグループは対象外です。';

  @override
  String get busyReplyText => '返信の文面';

  @override
  String busyReplyTextHint(String until) {
    return '$until は取り込み中の終了時刻になります。';
  }

  @override
  String busyReplyDefault(String until) {
    return 'ただいま取り込み中です。$until 以降に返信します。';
  }

  @override
  String get busyGroups => 'グループにも返信';

  @override
  String get busyGroupsHint => 'オフ：グループには返信しません。';

  @override
  String get busyRepliesOnShabbat => '安息日と祭日も返信';

  @override
  String get busyAskRabbi => '初期設定はオフ。安息日にオンにする前にラビに相談してください。';

  @override
  String get busyWhenHeading => '取り込み中になるとき';

  @override
  String get busyWhenHint => 'カレンダーアラームで「この予定の間は取り込み中」、アラームで「鳴った後は取り込み中」をオンにします。';

  @override
  String get busyDuringLock => 'ロックモード中は取り込み中';

  @override
  String get busyNoneComing => '今後7日間に取り込み中の予定はありません。';

  @override
  String get busyDuringEvents => 'この予定の間は取り込み中';

  @override
  String get busyDuringEventsHint => '各予定の開始から終了まで取り込み中。';

  @override
  String get busySettings => '取り込み中モードの設定';

  @override
  String get busyAfterRing => '鳴った後は取り込み中';

  @override
  String get busyAfterRingHint => 'しばらくおやすみモードと自動返信。運動や昼寝などに。';

  @override
  String get shareCard => '朝をシェア';

  @override
  String get shareCardSubtitle => '今日の空と言葉、または自分の写真をストーリーズやステータスに';

  @override
  String get shareAppMissing => 'そのアプリはこの端末にありません。';

  @override
  String get shareAsIs => 'そのままシェア';

  @override
  String get shareTapQuote => '言葉をタップすると変わります。';

  @override
  String get shareStory => 'ストーリー';

  @override
  String get shareSquare => '正方形';

  @override
  String get shareYourWords => '自分の言葉（任意）';

  @override
  String get shareYourWordsHint => '今日の言葉の代わりに';

  @override
  String get shareYourPhoto => '自分の写真';

  @override
  String get shareOtherPhoto => '別の写真';

  @override
  String get shareSkyBack => '今日の空にする';

  @override
  String get shareYourVideo => '自分の動画';

  @override
  String get shareInstagramStory => 'Instagram ストーリーズ';

  @override
  String get shareWhatsApp => 'WhatsApp：ステータスかチャット';

  @override
  String get shareMore => 'その他のアプリ';

  @override
  String get shareYouPost => 'Quando? はカードを読み込んだ状態でアプリを開きます。投稿先を選び、投稿はご自身でタップします。';

  @override
  String get shareAndroidFirst => 'iPhone と iPad でのシェアは近日対応。';

  @override
  String songSaved(String name) {
    return '「$name」をアラーム音に保存しました';
  }

  @override
  String get shareToQuando => 'Quando? に曲をシェア';

  @override
  String get shareToQuandoHint =>
      'YouTube、YouTube Music、Spotify、SoundCloud、Apple Music で共有から Quando? を選ぶと、そのアプリで再生されるアラーム音になります。';

  @override
  String get askOption => '話すか入力';

  @override
  String get askOptionHint => '「明日6時」「日の出の30分前」';

  @override
  String get askHint => '例：平日は日の出の30分前に起こして';

  @override
  String get askListening => '聞いています…';

  @override
  String get askNotUnderstood => '時刻が見つかりませんでした。「平日7時」や「20分後」と試してください。';

  @override
  String askAnswerFromCalendar(String name) {
    return 'カレンダー「$name」より';
  }

  @override
  String get askAnswerBuiltIn => 'Quando? による地域の時刻';

  @override
  String get askNoAnswer => 'まだ時刻が見つかりません。';

  @override
  String get askNoSpeech => 'この端末では音声を使えません。入力してください。';

  @override
  String get askShabbatOff => 'シャバットの時刻を鳴らすには設定でシャバットをオンにしてください。';

  @override
  String askSaved(String what) {
    return '保存しました：$what';
  }

  @override
  String get askMic => '話す';

  @override
  String get askMorning => '朝';

  @override
  String get askEvening => '夜';

  @override
  String get askUnsure => '一部を読み取れなかったかもしれません。保存前に確認してください。';

  @override
  String get askTeach => 'これを覚えさせる';

  @override
  String askTaught(String phrase, String time) {
    return 'わかりました：「$phrase」は今後 $time です。';
  }

  @override
  String get askSkipAction => 'スキップ';

  @override
  String get askNoMatch => '一致するアラームはありません。';

  @override
  String askTurnedOff(String what) {
    return 'オフにしました：$what';
  }

  @override
  String askSkipped(String what) {
    return 'スキップしました：$what';
  }

  @override
  String askEventPlan(String offset, String event) {
    return 'カレンダーの「$event」の$offset';
  }

  @override
  String askEventNoCalendar(String event) {
    return 'Quando?が「$event」を見つけられるようカレンダーを接続してください。';
  }

  @override
  String askSnoozeAll(int minutes) {
    return 'スヌーズ：$minutes分、このアラームに適用';
  }

  @override
  String askWakeWith(String sound) {
    return '$soundで起こします';
  }

  @override
  String get askReadAs => '読み取り結果';

  @override
  String get askHelpTitle => '音声アラームの改善に協力';

  @override
  String get askHelpBody => '話した内容や入力した内容と、その後の操作を匿名で送信します。アカウントや端末IDは送りません。';

  @override
  String get askHelpPromptTitle => 'Quando? があなたを理解できるよう協力しますか？';

  @override
  String askHelpPromptBody(String sentence) {
    return '話した内容や入力した内容（例：「$sentence」）と、保存したかどうかを匿名で送信します。名前、アカウント、端末IDは送りません。いつでもオフにできます。';
  }

  @override
  String get askHelpYes => '協力する';

  @override
  String get askHelpNo => '今はしない';

  @override
  String get askQuoteTranslation => '人生とは、生きたことではなく、記憶していること、そして語るためにどう記憶しているかである。';
}
