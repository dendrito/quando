// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get undo => 'Undo';

  @override
  String duplicatedNamed(String name) {
    return 'Duplicated “$name”';
  }

  @override
  String deletedNamed(String name) {
    return 'Deleted “$name”';
  }

  @override
  String get when => 'When?';

  @override
  String get newAtTime => 'At a time';

  @override
  String get newAtTimeHint => 'Every weekday at 7:00, once at 15:30…';

  @override
  String get newAroundEvent => 'Around an event';

  @override
  String get newAroundEventHint => 'Search calendars, Shabbat and sun times, then ring before, at or after';

  @override
  String get editThisAlarm => 'Edit this alarm';

  @override
  String editNamed(String name) {
    return 'Edit “$name”';
  }

  @override
  String get preset => 'preset';

  @override
  String get editThisCalendarRule => 'Edit this calendar rule';

  @override
  String get ringThisOneAfterAll => 'Ring this one after all';

  @override
  String get skipJustThisOne => 'Skip just this one';

  @override
  String get renameGroup => 'Rename group';

  @override
  String quickSet(String label, String time) {
    return '$label · rings at $time';
  }

  @override
  String get newAlarm => 'New alarm';

  @override
  String get appName => 'Quando?';

  @override
  String get lockMode => 'Lock mode';

  @override
  String get calendars => 'Calendars';

  @override
  String get settings => 'Settings';

  @override
  String get nextAlarmHeading => 'NEXT ALARM';

  @override
  String get nothingSet => 'Nothing set';

  @override
  String get tagline => 'All in good time.';

  @override
  String sunriseAt(String time) {
    return 'Sunrise $time';
  }

  @override
  String sunsetAt(String time) {
    return 'Sunset $time';
  }

  @override
  String get alarmsMayNotRing => 'Your alarms may not ring';

  @override
  String get tapToFixIt => 'Tap to fix it';

  @override
  String inMinutes(int minutes) {
    return 'In $minutes min';
  }

  @override
  String get atSunset => 'At sunset';

  @override
  String get sunset => 'Sunset';

  @override
  String get shabbatModeIsOn => 'SHABBAT MODE IS ON';

  @override
  String nextInCity(String city) {
    return 'NEXT · $city';
  }

  @override
  String get candleLighting => 'Candle lighting';

  @override
  String get havdalah => 'Havdalah';

  @override
  String get shabbatAndFestivals => 'Shabbat & festivals';

  @override
  String get yourAlarmsHeading => 'YOUR ALARMS';

  @override
  String get tapWhenToAdd => 'Tap When? to add an alarm.';

  @override
  String get aroundEventsHeading => 'AROUND EVENTS';

  @override
  String searchFor(String words) {
    return 'search: $words';
  }

  @override
  String get thisWeekHeading => 'ALARMS THIS WEEK';

  @override
  String get noAlarmsThisWeek => 'No alarms in the next 7 days.';

  @override
  String get alarmsSetThemselves => 'Alarms set themselves on this phone whenever you change something.';

  @override
  String cityTime(String city) {
    return '$city time';
  }

  @override
  String get more => 'More';

  @override
  String get turnOff => 'Turn off';

  @override
  String get turnOn => 'Turn on';

  @override
  String get duplicate => 'Duplicate';

  @override
  String get delete => 'Delete';

  @override
  String get inOneHour => 'In 1 hour';

  @override
  String get logoLabel => 'Quando? logo';

  @override
  String get noTimesSet => 'No times set';

  @override
  String get atTheMoment => 'at the moment';

  @override
  String timesRange(int count, String from, String to) {
    return '$count times · $from to $to';
  }

  @override
  String spanDays(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n days', one: '1 day');
    return '$_temp0';
  }

  @override
  String spanHours(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n hours', one: '1 hour');
    return '$_temp0';
  }

  @override
  String spanMinutes(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n minutes', one: '1 minute');
    return '$_temp0';
  }

  @override
  String spanSeconds(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n seconds', one: '1 second');
    return '$_temp0';
  }

  @override
  String get now => 'now';

  @override
  String spanBefore(String span) {
    return '$span before';
  }

  @override
  String spanAfter(String span) {
    return '$span after';
  }

  @override
  String alarmCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n alarms', one: '1 alarm');
    return '$_temp0';
  }

  @override
  String get allOn => 'all on';

  @override
  String get allOff => 'all off';

  @override
  String someOn(int n) {
    return '$n on';
  }

  @override
  String skippedBody(String body) {
    return 'Skipped · $body';
  }

  @override
  String timeToTime(String from, String to) {
    return '$from to $to';
  }

  @override
  String skippedCount(int n) {
    return '$n skipped';
  }

  @override
  String get sunNoRiseSet => 'The sun does not rise or set here today';

  @override
  String sunProgress(int percent) {
    return 'The sun is $percent% of the way through the day';
  }

  @override
  String get sunIsDown => 'The sun is down';

  @override
  String get searchCity => 'Search a city';

  @override
  String get tomorrowLower => 'tomorrow';

  @override
  String get yesterdayLower => 'yesterday';

  @override
  String get worldClocksHeading => 'WORLD CLOCKS';

  @override
  String get add => 'Add';

  @override
  String cityHere(String city) {
    return '$city · here';
  }

  @override
  String get worldClocksHint => 'Add cities to see their time here. Swipe one left to remove it.';

  @override
  String get groupNameHint => 'Work, Kids, Gym…';

  @override
  String get cancel => 'Cancel';

  @override
  String get ok => 'OK';

  @override
  String get noGroup => 'No group';

  @override
  String get newGroupEllipsis => 'New group…';

  @override
  String get newGroup => 'New group';

  @override
  String secondsShort(int n) {
    return '$n s';
  }

  @override
  String minutesShort(int n) {
    return '$n min';
  }

  @override
  String get minutes => 'Minutes';

  @override
  String get ringFor => 'Ring for';

  @override
  String get seconds => 'Seconds';

  @override
  String get oneSecondLess => '1 second less';

  @override
  String get oneSecondMore => '1 second more';

  @override
  String inDays(int d) {
    return 'in $d d';
  }

  @override
  String inDaysHours(int d, int h) {
    return 'in $d d $h h';
  }

  @override
  String inHours(int h) {
    return 'in $h h';
  }

  @override
  String inHoursMinutes(int h, int m) {
    return 'in $h h $m min';
  }

  @override
  String inMins(int m) {
    return 'in $m min';
  }

  @override
  String placeChange(String city, String where) {
    return '$city · $where · change';
  }

  @override
  String get israel => 'Israel';

  @override
  String get outsideIsrael => 'outside Israel';

  @override
  String get comingUpHeading => 'COMING UP';

  @override
  String get lockForShabbat => 'Lock the phone for Shabbat';

  @override
  String get lockForShabbatHint => 'From candle lighting to Havdalah, festivals too';

  @override
  String get ownShabbatAlarmsHeading => 'YOUR OWN SHABBAT ALARMS';

  @override
  String get addShabbatAlarm => 'Add a Shabbat or festival alarm';

  @override
  String get readyMadeHeading => 'READY-MADE ALARMS';

  @override
  String bringBackDeleted(int n) {
    return 'Bring back deleted ones ($n)';
  }

  @override
  String get presetsHint => 'Tap one to change its times. Swipe one away to delete it.';

  @override
  String get lockSentence =>
      'Lock the phone down to the clock and your alarms, for Shabbat or a focused night.';

  @override
  String get lockExplain =>
      'While locked, Quando? shows only the time, the next alarm and when the lock ends. Alarms keep working, and nothing can be changed until it unlocks.';

  @override
  String get lockNowHeading => 'LOCK NOW';

  @override
  String get lockAutoHeading => 'LOCK AUTOMATICALLY';

  @override
  String get shabbatAndFestivalsLong => 'Shabbat and festivals';

  @override
  String get fromCandleToHavdalah => 'From candle lighting to Havdalah';

  @override
  String get lockCalendarWord => 'During events named…';

  @override
  String get lockCalendarWordHint => 'e.g. lock, exam, focus';

  @override
  String get leaveEmptyForNone => 'Leave empty for none';

  @override
  String get connectCalendarsFirst => 'Connect calendars first (calendar icon)';

  @override
  String get openWhenLockStarts => 'Open Quando? when a lock starts';

  @override
  String get openWhenLockStartsHint => 'A soft 1-second chime brings Quando? to the front so it can lock';

  @override
  String get pinToScreen => 'Pin Quando? to the screen';

  @override
  String get pinToScreenHint =>
      'Other apps can\'t be opened while locked. Android asks you to confirm the first time.';

  @override
  String get noLocksComingUp => 'No locks coming up.';

  @override
  String get leaveLockEarly => 'To leave a lock early, hold “Hold to unlock” for 3 seconds.';

  @override
  String get locked => 'Locked';

  @override
  String get shabbatShalom => 'Shabbat shalom';

  @override
  String get chagSameach => 'Chag sameach';

  @override
  String get unlocksHeading => 'UNLOCKS';

  @override
  String get nowCap => 'Now';

  @override
  String get nextAlarm => 'Next alarm';

  @override
  String get holdToUnlock => 'Hold to unlock';

  @override
  String get calendarAlarm => 'Calendar alarm';

  @override
  String get connectCalendars => 'Connect calendars';

  @override
  String get calendarAlarmsHeading => 'CALENDAR ALARMS';

  @override
  String get calendarNoneYet => 'None yet. Start with one, then change it as you like:';

  @override
  String get fifteenBeforeEvery => '15 minutes before every event';

  @override
  String get useTheseCalendarsHeading => 'USE THESE CALENDARS';

  @override
  String get noTimedEvents => 'No timed events coming up in these calendars.';

  @override
  String get atTheStart => 'at the start';

  @override
  String everyForBefore(String every, String span) {
    return 'every $every for $span before';
  }

  @override
  String spanAfterItEnds(String span) {
    return '$span after it ends';
  }

  @override
  String get noAlarmsChosen => 'No alarms chosen';

  @override
  String get gentleWakeUp => 'Gentle wake-up';

  @override
  String gentleSummary(int minutes, String sound) {
    return '$minutes min before · $sound';
  }

  @override
  String get off => 'Off';

  @override
  String get gentleSentence => 'A calm sound starts softly before your alarm, so it never jolts you awake.';

  @override
  String get gentleExplain =>
      'It grows slowly, easing you out of light sleep, and stops just before the alarm rings.';

  @override
  String get startsBeforeHeading => 'STARTS BEFORE THE ALARM';

  @override
  String get leadUpSoundHeading => 'LEAD-UP SOUND';

  @override
  String get listen => 'Listen';

  @override
  String get whoRecordedThese => 'Who recorded these';

  @override
  String get done => 'Done';

  @override
  String get soundCredits => 'Sound credits';

  @override
  String yourTimeCity(String city) {
    return 'Your time ($city)';
  }

  @override
  String get anotherCity => 'Another city…';

  @override
  String get ringingIn5 => 'Ringing in 5 seconds…';

  @override
  String get alarmSaved => 'Alarm saved.';

  @override
  String alarmSetFor(String span) {
    return 'Alarm set for $span from now.';
  }

  @override
  String hoursMinutesShort(int h, int m) {
    return '$h h $m min';
  }

  @override
  String get editAlarm => 'Edit alarm';

  @override
  String get previewCaps => 'PREVIEW';

  @override
  String get saveCaps => 'SAVE';

  @override
  String cityTimeForYou(String city, String time) {
    return '$city time · $time for you';
  }

  @override
  String repeatHeading(String repeat) {
    return 'REPEAT · $repeat';
  }

  @override
  String get labelField => 'Label (read aloud if spoken alarms are on)';

  @override
  String get group => 'Group';

  @override
  String ringsForHeading(String span) {
    return 'RINGS FOR $span';
  }

  @override
  String useDefault(String value) {
    return 'Use the default ($value)';
  }

  @override
  String get save => 'Save';

  @override
  String get sameTime => 'same time';

  @override
  String get untilYouStopIt => 'Until you stop it';

  @override
  String get alarm => 'Alarm';

  @override
  String get once => 'Once';

  @override
  String get everyDay => 'Every day';

  @override
  String get weekdays => 'Weekdays';

  @override
  String get weekends => 'Weekends';

  @override
  String timeInCity(String time, String city) {
    return '$time $city time';
  }

  @override
  String eventsMatching(String words) {
    return 'Events matching “$words”';
  }

  @override
  String get everyEvent => 'Every event';

  @override
  String get sunrise => 'Sunrise';

  @override
  String havdalahEndOf(String day) {
    return 'Havdalah · end of $day';
  }

  @override
  String get yomTov => 'Yom Tov';

  @override
  String get shabbat => 'Shabbat';

  @override
  String get presetCountdown => 'Countdown to candle lighting';

  @override
  String get presetHourly => 'Every hour, from 6 hours before';

  @override
  String get presetDailyWeek => 'Once a day, for a week before';

  @override
  String get presetSecondNight => 'Second-night candles';

  @override
  String get presetFridayReminder => 'Reminder 3 hours before: charge your phone';

  @override
  String get presetFridayReminderLabel => 'Charge your phone and set any alarms for tomorrow';

  @override
  String get presetSunset => 'Sunset, and 15 minutes before';

  @override
  String get pesach => 'Pesach';

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
  String get readyNotifications => 'Show alarms';

  @override
  String get readyNotificationsWhy => 'Lets the ringing screen and Stop button appear.';

  @override
  String get readyFullScreen => 'Ring over the lock screen';

  @override
  String get readyFullScreenWhy => 'Shows the alarm full screen, even when the phone is locked.';

  @override
  String get readyExact => 'Ring on the minute';

  @override
  String get readyExactWhy => 'Without it, the phone may ring alarms a few minutes late.';

  @override
  String get readyBattery => 'Keep running on battery saver';

  @override
  String get readyBatteryWhy => 'Stops battery saving from silencing alarms overnight.';

  @override
  String get tipXiaomi =>
      'Xiaomi phones: in Settings › Apps › Quando?, turn on Autostart and set Battery saver to No restrictions.';

  @override
  String get tipSamsung =>
      'Samsung phones: in Settings › Battery › Background usage limits, make sure Quando? isn\'t sleeping.';

  @override
  String get tipHuawei =>
      'Huawei and Honor phones: in Settings › Battery › App launch, set Quando? to Manage manually and allow everything.';

  @override
  String get tipOther =>
      'On this phone: in Settings › Battery, allow Quando? to run in the background and turn off Optimise for it.';

  @override
  String get testRing => 'Test ring';

  @override
  String get testRingBody => 'Quando? can wake you';

  @override
  String get ringsIn20 => 'Rings in 20 seconds. Lock your phone now and wait.';

  @override
  String get readyToRing => 'Ready to ring';

  @override
  String get checkingPhone => 'Checking your phone…';

  @override
  String get phoneReady => 'Your phone is set up to ring every alarm on time.';

  @override
  String thingsNeedFixing(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n things need fixing, or alarms may not ring.',
      one: '1 thing needs fixing, or alarms may not ring.',
    );
    return '$_temp0';
  }

  @override
  String get fix => 'Fix';

  @override
  String get testIn20 => 'Test it: ring in 20 seconds';

  @override
  String get testIn20Hint =>
      'Lock the phone and put it down. If the alarm rings and shows full screen, you\'re all set.';

  @override
  String get readyToRingHint => 'Check your phone lets every alarm ring on time';

  @override
  String get connections => 'Connections';

  @override
  String get timeZoneHeading => 'TIME ZONE';

  @override
  String get followPhone => 'Follow the phone';

  @override
  String followPhoneNow(String city) {
    return 'Now $city. Changes by itself when you travel.';
  }

  @override
  String get zoneFixed => 'Fixed. Alarms keep this time even when you travel.';

  @override
  String get shabbatCityHeading => 'SHABBAT CITY';

  @override
  String get inIsraelOneDay => 'In Israel (one festival day)';

  @override
  String candleMinutesHeading(int n) {
    return 'CANDLE LIGHTING: $n MINUTES BEFORE SUNSET';
  }

  @override
  String get endOfShabbatHeading => 'END OF SHABBAT AND FESTIVALS';

  @override
  String get nightfallGeonim => 'Nightfall (Geonim, 8.5°)';

  @override
  String get rabbeinuTam => '72 minutes after sunset (Rabbeinu Tam)';

  @override
  String get whenAlarmRingsHeading => 'WHEN AN ALARM RINGS';

  @override
  String get recordOrAddSounds => 'Record or add sounds';

  @override
  String get ringsForThisLong => 'Rings for this long, then stops by itself';

  @override
  String get sameFades => 'Same fades for every alarm';

  @override
  String get sameFadesOn => 'Overrides the fades set on each alarm. Each keeps its own volume.';

  @override
  String get sameFadesOff => 'Off: each alarm uses the fades set under its Volume.';

  @override
  String get sayItOutLoud => 'Say it out loud';

  @override
  String get sayItOutLoudHint => 'Reads what the alarm is for, e.g. “Candle lighting, 15 minutes before”';

  @override
  String get noSnooze => 'No snooze';

  @override
  String snoozeUpTo(int times, int minutes) {
    return 'Snooze up to $times× of $minutes min';
  }

  @override
  String get wakeUpCheck => 'Wake-up check';

  @override
  String get wakeUpCheckHint => 'After you stop it, rings again in 3 minutes unless you tap “I\'m up”';

  @override
  String get solveSum => 'Solve a sum to stop';

  @override
  String get provesAwake => 'Proves you\'re awake';

  @override
  String get shabbatNoTasks =>
      'On Shabbat and festivals none of these apply: alarms stop by themselves and never ask you to touch the phone.';

  @override
  String get testAlarmIn1 => 'Ring a test alarm in 1 minute';

  @override
  String get timesDisclaimer =>
      'Times are calculated on your phone. For borderline cases, check with your rabbi or community calendar.';

  @override
  String get recommended => 'Recommended';

  @override
  String get chooseCity => 'Choose a city';

  @override
  String get testOnlyOnPhone => 'Test alarms only work on a phone.';

  @override
  String get testAlarm => 'Test alarm';

  @override
  String get testAlarmBody => 'This is how your alarms will sound';

  @override
  String get testAlarmIn1Set => 'Test alarm in 1 minute. You can lock the phone.';

  @override
  String get presetGone => 'This preset no longer exists.';

  @override
  String get editPreset => 'Edit preset';

  @override
  String get on => 'On';

  @override
  String get ringsHeading => 'RINGS';

  @override
  String get noTimesYet => 'No times yet. Add one below.';

  @override
  String get atTheMomentItself => 'At the moment itself';

  @override
  String get remove => 'Remove';

  @override
  String get addATime => 'Add a time';

  @override
  String get resetPreset => 'Reset to how it came';

  @override
  String get skipOneHint => 'To skip just one alarm, tap it in “Alarms this week” on the home screen.';

  @override
  String get unitMinutes => 'minutes';

  @override
  String get unitHours => 'hours';

  @override
  String get unitDays => 'days';

  @override
  String get before => 'Before';

  @override
  String get after => 'After';

  @override
  String get oneWeek => '1 week';

  @override
  String daysShort(int n) {
    return '$n d';
  }

  @override
  String hoursShort(int n) {
    return '$n h';
  }

  @override
  String get howToSearch => 'How to search';

  @override
  String get searchHelpWord => 'The title contains “dentist”, any case';

  @override
  String get searchHelpStar => '* is any letters: dentist, dentures';

  @override
  String get searchHelpQuestion => '? is one letter: yoga, toga';

  @override
  String get searchHelpPhrase => 'This exact phrase';

  @override
  String get searchHelpAnd => 'Both words (AND)';

  @override
  String get searchHelpOr => 'Either one. | works too';

  @override
  String get searchHelpNot => 'Leave out. NOT and ! work too';

  @override
  String get searchHelpBrackets => 'Brackets group words';

  @override
  String get searchHelpEmpty => 'Leave it empty to ring for every event.';

  @override
  String get customTime => 'Custom time';

  @override
  String get other => 'Other';

  @override
  String get sun => 'Sun';

  @override
  String get calendar => 'Calendar';

  @override
  String get newEventAlarm => 'New event alarm';

  @override
  String get eventAlarm => 'Event alarm';

  @override
  String get findEventsHeading => 'FIND THE EVENTS';

  @override
  String get searchEventsHint => 'Search: dentist, gym OR yoga, dent*…';

  @override
  String get alsoBuiltInTimes => 'Also Shabbat, festival and sun times';

  @override
  String get alsoBuiltInTimesHint => 'e.g. “candle*”, “havdalah”, “sunset”';

  @override
  String get allMyCalendars => 'All my calendars';

  @override
  String get connectToSearch => 'Connect your calendars to search them';

  @override
  String get searching => 'Searching…';

  @override
  String get nothingMatches60 => 'Nothing matches in the next 60 days';

  @override
  String eventsIn60(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n events in the next 60 days',
      one: '1 event in the next 60 days',
    );
    return '$_temp0';
  }

  @override
  String nextRingsAt(String times, String title) {
    return 'Next: rings at $times for “$title”';
  }

  @override
  String showMoreLeft(int n) {
    return 'Show more ($n left)';
  }

  @override
  String get ringBeforeStartsHeading => 'RING BEFORE IT STARTS';

  @override
  String get ringWhenStarts => 'Ring when it starts';

  @override
  String get repeatBeforeHeading => 'AND REPEAT BEFORE IT';

  @override
  String get everyPrefix => 'Every ';

  @override
  String get offLower => 'off';

  @override
  String get forInfix => '  for ';

  @override
  String get ringAfterEndsHeading => 'RING AFTER IT ENDS';

  @override
  String get nameOptional => 'Name (optional)';

  @override
  String get toppedUp => 'Alarms are set for the next 7 days and topped up each time you open Quando?.';

  @override
  String get back => 'Back';

  @override
  String get next => 'Next';

  @override
  String get stepWhichEvents => 'Which events';

  @override
  String get stepWhenToRing => 'When to ring';

  @override
  String get stepHowItRings => 'How it rings';

  @override
  String defaultNamed(String name) {
    return 'Default ($name)';
  }

  @override
  String get phoneAlarmSound => 'Phone alarm sound';

  @override
  String get onlineRadio => 'Online radio';

  @override
  String songLinkOpens(String app) {
    return 'Song link · opens $app';
  }

  @override
  String get builtIn => 'Built in';

  @override
  String get yourRecording => 'Your recording';

  @override
  String get sound => 'Sound';

  @override
  String get wakeToOwnSound => 'Wake up to your own sound';

  @override
  String get wakeToOwnSoundHint => 'Your voice, a song, Spotify or live radio';

  @override
  String musicAdded(String name) {
    return '$name added. Pick it as the sound for any alarm.';
  }

  @override
  String get playlists => 'Playlists';

  @override
  String get likedSongs => 'Liked songs';

  @override
  String get noPlaylists => 'No playlists yet.';

  @override
  String get noLikedSongs => 'No liked songs yet.';

  @override
  String get needsMic => 'Quando? needs the microphone to record.';

  @override
  String recordingN(int n) {
    return 'Recording $n';
  }

  @override
  String couldNotAddFile(String error) {
    return 'Could not add that file: $error';
  }

  @override
  String get addSongLink => 'Add a song link';

  @override
  String get songLink => 'Song link';

  @override
  String get songLinkHowTo =>
      'In Spotify, Apple Music, YouTube, YouTube Music or SoundCloud, tap Share, then Copy link, and paste it here.';

  @override
  String get songNameHint => 'Name, e.g. Morning playlist';

  @override
  String get whenAlarmGoesOffHeading => 'WHEN THE ALARM GOES OFF';

  @override
  String get playTheSong => 'Play the song';

  @override
  String get ringThenOpen => 'Ring, then open';

  @override
  String get playTheSongHint =>
      'Its app opens and plays it. If it stays silent for 10 seconds, the backup sound rings instead, so you always wake up. Alarms with a task ring, then open it.';

  @override
  String get ringThenOpenHint => 'The backup sound rings. Stop opens the song in its app.';

  @override
  String get playForHeading => 'PLAY FOR';

  @override
  String get pausesAfter => 'Quando? pauses the song after this, using the phone\'s own pause button.';

  @override
  String get backupSoundHeading => 'BACKUP SOUND';

  @override
  String get notALink => 'That doesn\'t look like a link.';

  @override
  String songOn(String app) {
    return 'Song on $app';
  }

  @override
  String get theWeb => 'the web';

  @override
  String get pickFromYouTube => 'Pick from my YouTube';

  @override
  String get youTubeAndMusic => 'YouTube and YouTube Music';

  @override
  String get youTubeOn => 'Connected · hold to sign out';

  @override
  String get youTubeSignIn => 'Sign in with Google';

  @override
  String get addSongLinkInstead => 'Add a song link instead.';

  @override
  String get googleSignInFailed => 'Google sign-in didn\'t finish. Try again.';

  @override
  String get myYouTube => 'My YouTube';

  @override
  String get spotifyDirectOn => 'Spotify direct play is on';

  @override
  String get spotifyDirect => 'Spotify direct play';

  @override
  String get spotifyDirectOnHint => 'On · tap to turn off';

  @override
  String get spotifyDirectHint => 'Plays the exact song. Needs Premium.';

  @override
  String get spotifyComingSoon => 'Coming soon · needs Premium';

  @override
  String get spotifyFailed =>
      'Spotify didn\'t connect. Check the Spotify app is installed, you\'re signed in, and you have Premium.';

  @override
  String get nameThisSound => 'Name this sound';

  @override
  String get sounds => 'Sounds';

  @override
  String get soundsSentence => 'Wake up to your own voice, a song, a playlist or live radio.';

  @override
  String stopTimer(String time) {
    return 'Stop · $time';
  }

  @override
  String get record => 'Record';

  @override
  String get addAFile => 'Add a file';

  @override
  String get addSongLinkLong => 'Add a song link (Spotify, Apple Music, YouTube…)';

  @override
  String get musicAppsHeading => 'MUSIC APPS';

  @override
  String get pickFromSpotify => 'Pick from my Spotify';

  @override
  String get yourPlaylistsAndLiked => 'Your playlists and liked songs';

  @override
  String get mySpotify => 'My Spotify';

  @override
  String get spotifySignInFailed => 'Couldn\'t sign in to Spotify.';

  @override
  String get appleMusicNote => 'Sign-in coming with the iPhone version. For now, add a song link.';

  @override
  String noSignInNote(String service) {
    return '$service doesn\'t allow sign-in from other apps. Add a song link instead.';
  }

  @override
  String get wakeToRadio => 'Wake up to online radio';

  @override
  String get soundsExplain =>
      'Record up to 5 minutes, add a file, a song link or live radio. A backup sound rings if anything fails.';

  @override
  String get yourSoundsHeading => 'YOUR SOUNDS';

  @override
  String playsIn(String app) {
    return 'Plays in $app';
  }

  @override
  String opensIn(String app) {
    return 'Opens in $app';
  }

  @override
  String forSpan(String span) {
    return 'for $span';
  }

  @override
  String get defaultLabel => 'Default';

  @override
  String get radioUnreachable => 'Couldn\'t reach the radio directory. Check your connection.';

  @override
  String get addStreamAddress => 'Add a stream address';

  @override
  String get notAStream => 'That doesn\'t look like a stream address (it starts with http).';

  @override
  String get anyGenre => 'Any genre';

  @override
  String get stationName => 'Station name';

  @override
  String get closeSearch => 'Close search';

  @override
  String get searchByName => 'Search by name';

  @override
  String get anywhere => 'Anywhere';

  @override
  String get noStations => 'No stations found. Try another genre or country.';

  @override
  String wakeUpTo(String name) {
    return 'Wake up to $name';
  }

  @override
  String get notQuite => 'Not quite. Try again.';

  @override
  String shabbatStopsItself(int n) {
    return 'Shabbat mode: this stops by itself in $n seconds. No need to touch the phone.';
  }

  @override
  String get solveToSnooze => 'SOLVE TO SNOOZE';

  @override
  String get solveToStop => 'SOLVE TO STOP';

  @override
  String get answer => 'Answer';

  @override
  String get snooze => 'Snooze';

  @override
  String get stop => 'Stop';

  @override
  String get shakeToSnooze => 'SHAKE TO SNOOZE';

  @override
  String get shakeToStop => 'SHAKE TO STOP';

  @override
  String get shakeHard => 'Shake the phone hard until the bar fills.';

  @override
  String get cantShake => 'Can\'t shake? Solve a sum instead';

  @override
  String get pairsToSnooze => 'FIND THE PAIRS TO SNOOZE';

  @override
  String get pairsToStop => 'FIND THE PAIRS TO STOP';

  @override
  String get typeToSnooze => 'TYPE THIS TO SNOOZE';

  @override
  String get typeToStop => 'TYPE THIS TO STOP';

  @override
  String get scanToSnooze => 'SCAN YOUR CODE TO SNOOZE';

  @override
  String get scanToStop => 'SCAN YOUR CODE TO STOP';

  @override
  String ringAgainUnless(int n) {
    return 'I\'ll ring again in $n minutes unless you tap below.';
  }

  @override
  String get imUp => 'I\'m up';

  @override
  String snoozeMin(int n) {
    return 'Snooze $n min';
  }

  @override
  String snoozeMinLeft(int n, int left) {
    return 'Snooze $n min · $left left';
  }

  @override
  String get noSnoozesLeft => 'No snoozes left';

  @override
  String get stopThenOpen => 'Stop · then open';

  @override
  String get startingSong => 'Starting your song';

  @override
  String wayToStop(String way) {
    return '$way to stop';
  }

  @override
  String wayToSnooze(String way) {
    return '$way to snooze';
  }

  @override
  String ringsForMore(int n) {
    return 'Rings for $n more seconds';
  }

  @override
  String get leftToRing => 'left to ring';

  @override
  String get wayVolumeButtons => 'Volume buttons';

  @override
  String get wayShake => 'Shake the phone';

  @override
  String get taskNothing => 'Nothing';

  @override
  String get taskSum => 'Solve a sum';

  @override
  String get taskShake => 'Shake 30 times';

  @override
  String get taskMemory => 'Memory game';

  @override
  String get taskPhrase => 'Type a phrase';

  @override
  String get taskScan => 'Scan a code';

  @override
  String get noLimit => 'no limit';

  @override
  String upToTimes(int n) {
    return 'up to $n×';
  }

  @override
  String shorterEachTime(int n) {
    return '$n min shorter each time';
  }

  @override
  String autoSnoozeAfter(int n) {
    return 'snoozes by itself after $n min';
  }

  @override
  String get card => 'Card';

  @override
  String get hiddenCard => 'Hidden card';

  @override
  String get phrase1 => 'I am awake and the day is mine';

  @override
  String get phrase2 => 'If not now, then when';

  @override
  String get phrase3 => 'Good morning to me and everyone I love';

  @override
  String get phrase4 => 'My feet are on the floor and I am up';

  @override
  String get phrase5 => 'Today I begin again';

  @override
  String get notQuiteWords => 'Not quite, check each word.';

  @override
  String get typeItHere => 'Type it here';

  @override
  String get differentCode => 'That\'s a different code.';

  @override
  String get cameraUnavailable => 'The camera isn\'t available.';

  @override
  String get cantScan => 'Can\'t scan? Solve a sum instead';

  @override
  String get saveCodeToScan => 'Save a code to scan';

  @override
  String get saveCodeHint =>
      'Point the camera at a barcode or QR code somewhere you have to walk to, like a box in the kitchen or toothpaste in the bathroom. To stop the alarm, you\'ll scan it again.';

  @override
  String get cameraUnavailableSettings => 'The camera isn\'t available. Allow camera access in Settings.';

  @override
  String gentleToGo(int n) {
    return 'Gentle wake-up · $n min to go';
  }

  @override
  String previewBody(String body) {
    return 'Preview · $body';
  }

  @override
  String snoozedBody(String body) {
    return 'Snoozed: $body';
  }

  @override
  String get areYouUp => 'Are you up?';

  @override
  String get tapImUp => 'Tap “I\'m up” to stop';

  @override
  String get volume => 'Volume';

  @override
  String get wakeCheckOn => 'Wake-up check on';

  @override
  String get stopsAtOnce => 'Stops at once';

  @override
  String get ringsAgainIfNotUp => 'Rings again if you\'re not up';

  @override
  String get openAppAfter => 'Open an app after';

  @override
  String get noTask => 'No task';

  @override
  String get codeSaved => 'Code saved';

  @override
  String get tapToSaveDifferent => 'Tap to save a different one';

  @override
  String get controlsHeading => 'CONTROLS';

  @override
  String get onScreen => 'On screen';

  @override
  String get taskHeading => 'TASK';

  @override
  String get none => 'None';

  @override
  String get snoozeSentence => 'Five more minutes? Choose how long, how often, and what it takes.';

  @override
  String get settingsHeading => 'SETTINGS';

  @override
  String get snoozeTime => 'Snooze time';

  @override
  String get snoozeTimeHint => 'How long the first snooze lasts';

  @override
  String get shortenSnoozes => 'Shorten extra snoozes';

  @override
  String get shortenSnoozesHint => 'Each snooze after the first is this much shorter';

  @override
  String get autoSnooze => 'Auto-snooze';

  @override
  String get autoSnoozeHint => 'If you don\'t touch it, it snoozes by itself after';

  @override
  String get never => 'Never';

  @override
  String get snoozeLimit => 'Snooze limit';

  @override
  String get snoozeLimitHint => 'How many times you can snooze';

  @override
  String get unlimited => 'Unlimited';

  @override
  String get useSnoozeFromSettings => 'Use the snooze from Settings';

  @override
  String get stopSentence => 'How you turn the alarm off, and what you must do first.';

  @override
  String get shabbatNoTask => 'On Shabbat and festivals alarms stop by themselves and never ask for a task.';

  @override
  String get volumeSentence => 'How loud it rings, and how gently it gets there.';

  @override
  String get openAfterAlarm => 'Open after the alarm';

  @override
  String get pickAnApp => 'Pick an app';

  @override
  String get orPasteLink => 'Or paste a link: https://…';

  @override
  String get useThisLink => 'Use this link';

  @override
  String get noAppsFound => 'No apps found.';

  @override
  String get weather => 'Weather';

  @override
  String get news => 'News';

  @override
  String get usePhoneVolume => 'Use the phone\'s alarm volume';

  @override
  String get setsPhoneVolume => 'Sets the phone\'s alarm volume while it rings, then puts it back.';

  @override
  String get fadeInOff => 'Fade in: off, full volume at once';

  @override
  String fadeInOver(String span) {
    return 'Fade in over $span';
  }

  @override
  String get fadeOutOff => 'Fade out: off';

  @override
  String fadeOutOver(String span) {
    return 'Fade out over the last $span';
  }

  @override
  String get fadesExplain =>
      'Fading out happens as the alarm stops by itself. If the fades are longer than the alarm rings, both shrink to fit.';

  @override
  String get soundSoftChime => 'Soft chime';

  @override
  String get soundMorningRise => 'Morning rise';

  @override
  String get soundClassicBeep => 'Classic beep';

  @override
  String get calmCity => 'Quiet city morning';

  @override
  String get calmBirds => 'Birds at dawn';

  @override
  String get calmWaves => 'Waves on the shore';

  @override
  String get calmRain => 'Soft rain';

  @override
  String get calmStream => 'Forest stream';

  @override
  String get calmWind => 'Gentle wind';

  @override
  String get calmFire => 'Crackling fire';

  @override
  String get calmNight => 'Summer night';

  @override
  String get publicDomain => 'Public domain';

  @override
  String get phoneVolume => 'Phone volume';

  @override
  String fadesIn(String span) {
    return 'fades in $span';
  }

  @override
  String fadesOut(String span) {
    return 'fades out $span';
  }

  @override
  String get noFade => 'no fade';

  @override
  String minSecShort(int m, int s) {
    return '$m min $s s';
  }

  @override
  String get happensRings => 'Rings';

  @override
  String get happensStopped => 'You stop it';

  @override
  String get happensSnoozed => 'You snooze it';

  @override
  String get happensAutoStopped => 'It stops by itself';

  @override
  String get eventLower => 'event';

  @override
  String get appTest => 'Quando? test';

  @override
  String get pushoverConnected => 'Pushover is connected';

  @override
  String get webhookConnected => 'Webhook is connected';

  @override
  String pushoverSaid(int code, String body) {
    return 'Pushover said $code: $body';
  }

  @override
  String couldNotReachPushover(String error) {
    return 'Could not reach Pushover ($error)';
  }

  @override
  String itAnswered(int code) {
    return 'It answered $code';
  }

  @override
  String couldNotReachIt(String error) {
    return 'Could not reach it ($error)';
  }

  @override
  String get calendarNotAllowed => 'Calendar access was not allowed.';

  @override
  String get playlist => 'Playlist';

  @override
  String songCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n songs', one: '1 song');
    return '$_temp0';
  }

  @override
  String get spotifySaidNo =>
      'Spotify said no. In the Spotify dashboard, tick Web API for Quando? and add your account under User Management.';

  @override
  String serviceDidntAnswer(String service, int code) {
    return '$service didn\'t answer ($code).';
  }

  @override
  String get youTubeSaidNo =>
      'YouTube said no. Check your Google account is a test user of the Quando project.';

  @override
  String get event => 'Event';

  @override
  String eventEnds(String title) {
    return '$title (ends)';
  }

  @override
  String foundSoundsDevices(int s, int d) {
    return 'Found $s sounds and $d devices.';
  }

  @override
  String get sentCheckDevices => 'Sent. Check your other devices.';

  @override
  String sentTo(String name) {
    return 'Sent to $name.';
  }

  @override
  String get zapierHowTo =>
      'In Zapier, make a Zap that starts with “Webhooks by Zapier → Catch Hook”, then paste its URL here.';

  @override
  String get catchHookUrl => 'Catch Hook URL';

  @override
  String get iftttHowTo =>
      'In IFTTT, make an applet that starts with “Webhooks → Receive a web request with a JSON payload”. Use the same event name here. Your key is on ifttt.com/maker_webhooks/settings.';

  @override
  String get eventName => 'Event name';

  @override
  String get webhooksKey => 'Webhooks key';

  @override
  String get webhookHowTo => 'Quando? sends a JSON POST to this address.';

  @override
  String get connectionsSentence => 'Tell your other apps and devices when an alarm rings, stops or snoozes.';

  @override
  String get pushWhenRings => 'Send a push when an alarm rings';

  @override
  String get pushWhenRingsHint => 'To your other phones, tablet, watch or computer';

  @override
  String get yourUserKey => 'Your user key';

  @override
  String get appToken => 'App token';

  @override
  String get soundAndDevicesHeading => 'SOUND AND DEVICES';

  @override
  String get loading => 'Loading…';

  @override
  String get loadFromPushover => 'Load from Pushover';

  @override
  String get soundItPlays => 'Sound it plays';

  @override
  String get myPushoverDefault => 'My Pushover default';

  @override
  String get pushoverOwnSounds => 'Your own sounds appear here after you upload them at pushover.net/sounds.';

  @override
  String get allMyDevices => 'All my devices';

  @override
  String get pushoverOnThisPhone =>
      'Install the Pushover app on this phone too and it rings here with your Pushover sound.';

  @override
  String get priority => 'Priority';

  @override
  String get priorityNormal => 'Normal';

  @override
  String get priorityHigh => 'High: through quiet hours';

  @override
  String get priorityEmergency => 'Emergency: repeats until acknowledged';

  @override
  String get sending => 'Sending…';

  @override
  String get sendATest => 'Send a test';

  @override
  String get findUserKey => 'Find my user key';

  @override
  String get makeAppToken => 'Make an app token';

  @override
  String get webhooksHeading => 'ZAPIER, IFTTT AND WEBHOOKS';

  @override
  String get webhooksExplain =>
      'Start anything when an alarm rings or you stop it: turn on lights, log your wake-up time, message someone.';

  @override
  String get sendWhenAlarm => 'Send when the alarm:';

  @override
  String get pauseOnShabbat => 'Pause on Shabbat and festivals';

  @override
  String get pauseOnShabbatHint => 'Nothing is sent for alarms from candle lighting to Havdalah';

  @override
  String get webhookPayloadNote =>
      'Each message carries: event (ring, stopped, snoozed, auto_stopped), title, body, time, shabbat and snoozes. Keys stay on this phone.';

  @override
  String get today => 'Today';

  @override
  String get tomorrow => 'Tomorrow';

  @override
  String get notAWebAddress => 'That doesn\'t look like a web address starting with https://';

  @override
  String get language => 'Language';

  @override
  String get phoneLanguage => 'The phone\'s language';

  @override
  String get ringQuote => 'If not now, when?';

  @override
  String get ringQuoteBy => 'Hillel';

  @override
  String get quotesTitle => 'Quotes about time';

  @override
  String get quotesHint =>
      'Pick where they come from. You get one for each part of the day; tap a quote to see another.';

  @override
  String get quotesOff => 'Off';

  @override
  String get quoteSongs => 'Songs';

  @override
  String get quoteMovies => 'Movies';

  @override
  String get quoteLiterature => 'Books and poems';

  @override
  String get quoteTanakh => 'Tanakh (Hebrew Bible)';

  @override
  String get quoteSages => 'Talmud and sages';

  @override
  String get quoteSpeeches => 'Famous speeches';

  @override
  String get quotePhilosophy => 'Philosophers';

  @override
  String get quoteProverbs => 'Proverbs and sayings';

  @override
  String get quotesAlso => 'Also show';

  @override
  String get quoteCarnaval => 'Carnaval';

  @override
  String get quoteCarnavalHint => 'Songs and sayings during Brazil’s Carnaval';

  @override
  String get quoteNearMe => 'Near me';

  @override
  String get quoteNearMeHint => 'Poets and local days where you are, from your time zone and Shabbat city';

  @override
  String get quoteSiddur => 'Siddur (prayer book)';

  @override
  String weeklyParasha(String name) {
    return 'Weekly Torah Portion: $name';
  }

  @override
  String poweredBy(String name) {
    return 'powered by $name';
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
  String get syncNotAllowed => 'This account can\'t sync yet. If you signed in with email, confirm it first.';

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
  String get spotifyLibrarySignIn => 'Playlists, liked songs and search';

  @override
  String get spotifyLibraryOn => 'Connected · hold to sign out';

  @override
  String spotifyLoginError(String reason) {
    return 'Spotify sign-in didn\'t work: $reason';
  }

  @override
  String googleSignInError(String reason) {
    return 'Google sign-in didn\'t work: $reason';
  }

  @override
  String get searchSongsHint => 'Search songs, artists, playlists';

  @override
  String nothingFound(String query) {
    return 'Nothing found for “$query”.';
  }

  @override
  String get deliveryTitle => 'Delivery';

  @override
  String get deliveryLocal => 'Local audio';

  @override
  String get deliveryBoth => 'Both';

  @override
  String get deliveryConnect => 'Connect Pushover';

  @override
  String get deliveryLoadFailed => 'Could not load sounds and devices. Try again.';

  @override
  String get deliveryBothHint => 'Local audio still rings if Pushover fails.';

  @override
  String get deliveryPushHint => 'Pushover only. This device must be online when it fires.';

  @override
  String get deliveryFallback => 'Local audio is kept if Pushover is disconnected or paused.';

  @override
  String get deliveryReset => 'Use existing settings';

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
  String get musicRingDurationHint =>
      'Playback follows this alarm’s Ring for setting and stops with Stop or Snooze.';

  @override
  String get musicBackupPlaying => 'Music could not start. The local alarm sound is playing.';

  @override
  String desktopMusicConnect(String service) {
    return 'Connect the $service app';
  }

  @override
  String desktopMusicOn(String service) {
    return 'Connected to $service · hold to disconnect';
  }

  @override
  String get musicSongs => 'Songs';

  @override
  String get noMusicSongs => 'No songs found in your Music library.';

  @override
  String serviceConnectUnavailable(String service) {
    return '$service links open after the alarm';
  }

  @override
  String get soundCloudWidgetNote => 'Add a public link';

  @override
  String get youtubePlayerHint =>
      'YouTube plays video in a visible player. If it is hidden or cannot play, the local alarm continues.';

  @override
  String get musicPreviewFailed =>
      'Could not play this sound. Check your connection or try another track or station.';

  @override
  String get skyMoonPhase => 'Moon phase';

  @override
  String get skyMoonDetailsDisplay => 'Add a Moon phase page';

  @override
  String get skyMoonDetailsHint => 'Swipe to it, or tap the Moon card any time';

  @override
  String get moonRises => 'Rises';

  @override
  String get moonSets => 'Sets';

  @override
  String moonLunarDay(int day) {
    return 'Day $day of 29.5 in this lunar month';
  }

  @override
  String get moonDetailsOpen => 'Open Moon phase';

  @override
  String get musicPlaylists => 'Music playlists';

  @override
  String get videoPlaylists => 'Video playlists';

  @override
  String get likedVideos => 'Liked videos';

  @override
  String get wholePlaylist => 'Wake up to the whole playlist';

  @override
  String get noSongsInPlaylist => 'No songs here that can play.';

  @override
  String get hebrewNamesHeading => 'Spelling of parasha and month names';

  @override
  String get hebrewNamesIsraeli => 'Israeli';

  @override
  String get hebrewNamesAshkenazi => 'Ashkenazi';

  @override
  String pickFromService(String service) {
    return 'Pick from my $service';
  }

  @override
  String get weatherTonight => 'Tonight';

  @override
  String get weatherTomorrowMorning => 'Tomorrow morning';

  @override
  String weatherUntilAbout(String time) {
    return 'until about $time';
  }

  @override
  String get weatherSunBehindClouds => 'Sun behind the clouds';

  @override
  String get keysLockTitle => 'Keys on your devices';

  @override
  String get keysLockOff =>
      'Your service keys stay on this device. Choose a sync passphrase to send them, encrypted, to your other devices.';

  @override
  String get keysLockOn =>
      'Your service keys are encrypted with your sync passphrase before they leave this device. Nobody else, not even Google, can read them.';

  @override
  String get keysLockWaiting =>
      'Keys from your other device arrived here, locked. Type your sync passphrase to open them.';

  @override
  String get keysSetPassphrase => 'Choose passphrase';

  @override
  String get keysChangePassphrase => 'Change passphrase';

  @override
  String get keysUnlock => 'Unlock keys';

  @override
  String get keysStartOver => 'Forgot it? Start over';

  @override
  String get keysStartOverHint =>
      'Starting over sends this device\'s keys with a new passphrase. Your other devices will ask for the new one.';

  @override
  String get keysPassphrase => 'Sync passphrase';

  @override
  String get keysPassphraseAgain => 'Type it again';

  @override
  String keysPassphraseShort(int count) {
    return 'Use at least $count characters.';
  }

  @override
  String get keysPassphraseMismatch => 'The two don\'t match.';

  @override
  String get keysPassphraseWrong => 'That passphrase doesn\'t open these keys.';

  @override
  String get keysPassphraseNote =>
      'Write it down: if you forget it, nobody can recover it, and you\'ll type your keys again.';

  @override
  String get keysShareNeedsPassphrase => 'Choose a sync passphrase first, under Keys on your devices.';

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
      'Quando? can ring before and after events in your calendars. Pick where they come from.';

  @override
  String get deviceCalendarsHeading => 'ON THIS DEVICE';

  @override
  String get deviceCalendarsTitle => 'This device\'s calendar app';

  @override
  String get deviceCalendarsHint =>
      'Every account on it: Google, Samsung, Outlook, iCloud, and calendars kept only here.';

  @override
  String get googleCalendarHeading => 'GOOGLE CALENDAR';

  @override
  String get googleCalendarSignIn =>
      'Sign in with Google to read your calendars straight from Google, even when your Google account isn\'t on this device.';

  @override
  String googleCalendarSignedIn(String email) {
    return 'Signed in as $email';
  }

  @override
  String get googleCalendarSignOut => 'Sign out';

  @override
  String get googleCalendarNotHere =>
      'Google sign-in isn\'t available on this device yet. Add your Google account in the device\'s settings (Calendar › Accounts) and its calendars appear under this device.';

  @override
  String get googleCalendarUnreachable =>
      'Couldn\'t reach Google Calendar just now. Alarms already set from it still ring.';

  @override
  String get googleCalendarTwiceHint =>
      'Calendars this device already shows from the same Google account start off, so nothing rings twice.';

  @override
  String get timersTitle => 'Timers';

  @override
  String get timerStopwatch => 'Stopwatch';

  @override
  String get timerCountdown => 'Timer';

  @override
  String get timerSequence => 'Get set';

  @override
  String get timerStopwatchSub => 'Count up, with laps';

  @override
  String get timerCountdownSub => 'Count down, rings at zero';

  @override
  String get timerSequenceSub => 'Spoken start and marks';

  @override
  String get timerStart => 'Start';

  @override
  String get timerPause => 'Pause';

  @override
  String get timerResume => 'Resume';

  @override
  String get timerReset => 'Reset';

  @override
  String get timerLap => 'Lap';

  @override
  String get timerTimesUp => 'Time\'s up';

  @override
  String get timerSetTime => 'Set the time';

  @override
  String get timerMinutes => 'Minutes';

  @override
  String get timerSeconds => 'Seconds';

  @override
  String get seqOnYourMarks => 'On your marks';

  @override
  String get seqGetSet => 'Get set';

  @override
  String get seqGo => 'Go!';

  @override
  String get seqFinish => 'Time!';

  @override
  String get seqReady => 'Ready';

  @override
  String get seqSettings => 'Settings';

  @override
  String get seqStartCalls => 'Calls before the start';

  @override
  String get seqStartCallsHelp => 'Said aloud before Go, counted back from the start.';

  @override
  String seqCallBefore(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n seconds before',
      one: '1 second before',
    );
    return '$_temp0';
  }

  @override
  String get seqAddCall => 'Add a call';

  @override
  String get seqCallText => 'What to say';

  @override
  String get seqGoText => 'At the start, say';

  @override
  String get seqFinishText => 'At the end, say';

  @override
  String get seqLength => 'Length';

  @override
  String get seqNoLimit => 'No limit';

  @override
  String get seqSayEvery => 'Say the time every';

  @override
  String get seqOff => 'Off';

  @override
  String seqEverySeconds(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n seconds', one: '1 second');
    return '$_temp0';
  }

  @override
  String seqEveryMinutes(int n) {
    String _temp0 = intl.Intl.pluralLogic(n, locale: localeName, other: '$n minutes', one: '1 minute');
    return '$_temp0';
  }

  @override
  String get seqFinalCount => 'Count down the last';

  @override
  String get seqMarks => 'Your marks';

  @override
  String get seqAddMark => 'Add a mark';

  @override
  String seqMarkAt(String time) {
    return 'At $time';
  }

  @override
  String get seqSpeak => 'Speak aloud';

  @override
  String get seqBeeps => 'Beeps and vibration';

  @override
  String get seqSayRemaining => 'Say time left, not time passed';

  @override
  String get seqPresets => 'Presets';

  @override
  String get seqPresetRace => 'Race start';

  @override
  String get seqPresetSprint => '30 s effort';

  @override
  String get seqPresetRound => '1 min round';

  @override
  String get seqHintNoLimit => 'After Go it counts up until you stop it.';

  @override
  String get seqHintLength => 'After Go it counts down to zero.';

  @override
  String get seqWords => 'Words';

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
}
