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
    return 'in ${d}d';
  }

  @override
  String inDaysHours(int d, int h) {
    return 'in ${d}d ${h}h';
  }

  @override
  String inHours(int h) {
    return 'in ${h}h';
  }

  @override
  String inHoursMinutes(int h, int m) {
    return 'in ${h}h ${m}m';
  }

  @override
  String inMins(int m) {
    return 'in ${m}m';
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
  String get lockCalendarWord => 'During calendar events with this word';

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
  String get calendarIntro =>
      'Quando? can ring before and after events in your phone\'s calendars. Google Calendar is included once your Google account is on the phone.';

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
      'In Spotify, Apple Music, Amazon Music, YouTube, YouTube Music or SoundCloud, tap Share, then Copy link, and paste it here.';

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
  String get youTubeOn => 'Your playlists and liked songs. Long-press to sign out.';

  @override
  String get youTubeSignIn => 'Sign in with Google to pick from your playlists and liked songs.';

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
  String get spotifyDirectOnHint => 'Spotify plays your exact song as the alarm. Tap to turn off.';

  @override
  String get spotifyDirectHint =>
      'Plays your exact Spotify song as the alarm, more reliably. Needs the Spotify app and Spotify Premium. Tap to sign in.';

  @override
  String get spotifyComingSoon =>
      'Coming soon: plays your exact Spotify song as the alarm (needs Spotify Premium).';

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
      'Record your voice, a song or anything else, up to 5 minutes. Add an MP3, M4A or WAV from your phone. Link a song or playlist: its app plays it as the alarm, with a backup sound. Or pick a radio station: it plays live, and if it can\'t connect, the phone\'s alarm sound rings instead.';

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
    return 'Parashat $name';
  }

  @override
  String poweredBy(String name) {
    return 'powered by $name';
  }

  @override
  String get spotifyLibrary => 'Spotify';

  @override
  String get spotifyLibrarySignIn =>
      'Sign in to pick from your playlists and liked songs, or search all of Spotify. No Premium needed.';

  @override
  String get spotifyLibraryOn => 'Your playlists, liked songs and search. Long-press to sign out.';

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
}
