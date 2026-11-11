import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_he.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_id.dart';
import 'app_localizations_it.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_ko.dart';
import 'app_localizations_nl.dart';
import 'app_localizations_pl.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_tr.dart';
import 'app_localizations_uk.dart';
import 'app_localizations_vi.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('he'),
    Locale('hi'),
    Locale('id'),
    Locale('it'),
    Locale('ja'),
    Locale('ko'),
    Locale('nl'),
    Locale('pl'),
    Locale('pt'),
    Locale('ru'),
    Locale('tr'),
    Locale('uk'),
    Locale('vi'),
    Locale('zh'),
    Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hant'),
  ];

  /// No description provided for @undo.
  ///
  /// In en, this message translates to:
  /// **'Undo'**
  String get undo;

  /// No description provided for @duplicatedNamed.
  ///
  /// In en, this message translates to:
  /// **'Duplicated “{name}”'**
  String duplicatedNamed(String name);

  /// No description provided for @deletedNamed.
  ///
  /// In en, this message translates to:
  /// **'Deleted “{name}”'**
  String deletedNamed(String name);

  /// No description provided for @when.
  ///
  /// In en, this message translates to:
  /// **'When?'**
  String get when;

  /// No description provided for @newAtTime.
  ///
  /// In en, this message translates to:
  /// **'At a time'**
  String get newAtTime;

  /// No description provided for @newAtTimeHint.
  ///
  /// In en, this message translates to:
  /// **'Every weekday at 7:00, once at 15:30…'**
  String get newAtTimeHint;

  /// No description provided for @newAroundEvent.
  ///
  /// In en, this message translates to:
  /// **'Around an event'**
  String get newAroundEvent;

  /// No description provided for @newAroundEventHint.
  ///
  /// In en, this message translates to:
  /// **'Search calendars, Shabbat and sun times, then ring before, at or after'**
  String get newAroundEventHint;

  /// No description provided for @editThisAlarm.
  ///
  /// In en, this message translates to:
  /// **'Edit this alarm'**
  String get editThisAlarm;

  /// No description provided for @editNamed.
  ///
  /// In en, this message translates to:
  /// **'Edit “{name}”'**
  String editNamed(String name);

  /// No description provided for @preset.
  ///
  /// In en, this message translates to:
  /// **'preset'**
  String get preset;

  /// No description provided for @editThisCalendarRule.
  ///
  /// In en, this message translates to:
  /// **'Edit this calendar rule'**
  String get editThisCalendarRule;

  /// No description provided for @ringThisOneAfterAll.
  ///
  /// In en, this message translates to:
  /// **'Ring this one after all'**
  String get ringThisOneAfterAll;

  /// No description provided for @skipJustThisOne.
  ///
  /// In en, this message translates to:
  /// **'Skip just this one'**
  String get skipJustThisOne;

  /// No description provided for @renameGroup.
  ///
  /// In en, this message translates to:
  /// **'Rename group'**
  String get renameGroup;

  /// No description provided for @quickSet.
  ///
  /// In en, this message translates to:
  /// **'{label} · rings at {time}'**
  String quickSet(String label, String time);

  /// No description provided for @newAlarm.
  ///
  /// In en, this message translates to:
  /// **'New alarm'**
  String get newAlarm;

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Quando?'**
  String get appName;

  /// No description provided for @lockMode.
  ///
  /// In en, this message translates to:
  /// **'Lock mode'**
  String get lockMode;

  /// No description provided for @calendars.
  ///
  /// In en, this message translates to:
  /// **'Calendars'**
  String get calendars;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @nextAlarmHeading.
  ///
  /// In en, this message translates to:
  /// **'NEXT ALARM'**
  String get nextAlarmHeading;

  /// No description provided for @nothingSet.
  ///
  /// In en, this message translates to:
  /// **'Nothing set'**
  String get nothingSet;

  /// No description provided for @tagline.
  ///
  /// In en, this message translates to:
  /// **'All in good time.'**
  String get tagline;

  /// No description provided for @sunriseAt.
  ///
  /// In en, this message translates to:
  /// **'Sunrise {time}'**
  String sunriseAt(String time);

  /// No description provided for @sunsetAt.
  ///
  /// In en, this message translates to:
  /// **'Sunset {time}'**
  String sunsetAt(String time);

  /// No description provided for @alarmsMayNotRing.
  ///
  /// In en, this message translates to:
  /// **'Your alarms may not ring'**
  String get alarmsMayNotRing;

  /// No description provided for @tapToFixIt.
  ///
  /// In en, this message translates to:
  /// **'Tap to fix it'**
  String get tapToFixIt;

  /// No description provided for @inMinutes.
  ///
  /// In en, this message translates to:
  /// **'In {minutes} min'**
  String inMinutes(int minutes);

  /// No description provided for @atSunset.
  ///
  /// In en, this message translates to:
  /// **'At sunset'**
  String get atSunset;

  /// No description provided for @sunset.
  ///
  /// In en, this message translates to:
  /// **'Sunset'**
  String get sunset;

  /// No description provided for @shabbatModeIsOn.
  ///
  /// In en, this message translates to:
  /// **'SHABBAT MODE IS ON'**
  String get shabbatModeIsOn;

  /// No description provided for @nextInCity.
  ///
  /// In en, this message translates to:
  /// **'NEXT · {city}'**
  String nextInCity(String city);

  /// No description provided for @candleLighting.
  ///
  /// In en, this message translates to:
  /// **'Candle lighting'**
  String get candleLighting;

  /// No description provided for @havdalah.
  ///
  /// In en, this message translates to:
  /// **'Havdalah'**
  String get havdalah;

  /// No description provided for @shabbatAndFestivals.
  ///
  /// In en, this message translates to:
  /// **'Shabbat & festivals'**
  String get shabbatAndFestivals;

  /// No description provided for @yourAlarmsHeading.
  ///
  /// In en, this message translates to:
  /// **'YOUR ALARMS'**
  String get yourAlarmsHeading;

  /// No description provided for @tapWhenToAdd.
  ///
  /// In en, this message translates to:
  /// **'Tap When? to add an alarm.'**
  String get tapWhenToAdd;

  /// No description provided for @aroundEventsHeading.
  ///
  /// In en, this message translates to:
  /// **'AROUND EVENTS'**
  String get aroundEventsHeading;

  /// No description provided for @searchFor.
  ///
  /// In en, this message translates to:
  /// **'search: {words}'**
  String searchFor(String words);

  /// No description provided for @thisWeekHeading.
  ///
  /// In en, this message translates to:
  /// **'ALARMS THIS WEEK'**
  String get thisWeekHeading;

  /// No description provided for @noAlarmsThisWeek.
  ///
  /// In en, this message translates to:
  /// **'No alarms in the next 7 days.'**
  String get noAlarmsThisWeek;

  /// No description provided for @alarmsSetThemselves.
  ///
  /// In en, this message translates to:
  /// **'Alarms set themselves on this phone whenever you change something.'**
  String get alarmsSetThemselves;

  /// No description provided for @cityTime.
  ///
  /// In en, this message translates to:
  /// **'{city} time'**
  String cityTime(String city);

  /// No description provided for @more.
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get more;

  /// No description provided for @turnOff.
  ///
  /// In en, this message translates to:
  /// **'Turn off'**
  String get turnOff;

  /// No description provided for @turnOn.
  ///
  /// In en, this message translates to:
  /// **'Turn on'**
  String get turnOn;

  /// No description provided for @duplicate.
  ///
  /// In en, this message translates to:
  /// **'Duplicate'**
  String get duplicate;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @inOneHour.
  ///
  /// In en, this message translates to:
  /// **'In 1 hour'**
  String get inOneHour;

  /// No description provided for @logoLabel.
  ///
  /// In en, this message translates to:
  /// **'Quando? logo'**
  String get logoLabel;

  /// No description provided for @noTimesSet.
  ///
  /// In en, this message translates to:
  /// **'No times set'**
  String get noTimesSet;

  /// No description provided for @atTheMoment.
  ///
  /// In en, this message translates to:
  /// **'at the moment'**
  String get atTheMoment;

  /// No description provided for @timesRange.
  ///
  /// In en, this message translates to:
  /// **'{count} times · {from} to {to}'**
  String timesRange(int count, String from, String to);

  /// No description provided for @spanDays.
  ///
  /// In en, this message translates to:
  /// **'{n, plural, =1{1 day} other{{n} days}}'**
  String spanDays(int n);

  /// No description provided for @spanHours.
  ///
  /// In en, this message translates to:
  /// **'{n, plural, =1{1 hour} other{{n} hours}}'**
  String spanHours(int n);

  /// No description provided for @spanMinutes.
  ///
  /// In en, this message translates to:
  /// **'{n, plural, =1{1 minute} other{{n} minutes}}'**
  String spanMinutes(int n);

  /// No description provided for @spanSeconds.
  ///
  /// In en, this message translates to:
  /// **'{n, plural, =1{1 second} other{{n} seconds}}'**
  String spanSeconds(int n);

  /// No description provided for @now.
  ///
  /// In en, this message translates to:
  /// **'now'**
  String get now;

  /// No description provided for @spanBefore.
  ///
  /// In en, this message translates to:
  /// **'{span} before'**
  String spanBefore(String span);

  /// No description provided for @spanAfter.
  ///
  /// In en, this message translates to:
  /// **'{span} after'**
  String spanAfter(String span);

  /// No description provided for @alarmCount.
  ///
  /// In en, this message translates to:
  /// **'{n, plural, =1{1 alarm} other{{n} alarms}}'**
  String alarmCount(int n);

  /// No description provided for @allOn.
  ///
  /// In en, this message translates to:
  /// **'all on'**
  String get allOn;

  /// No description provided for @allOff.
  ///
  /// In en, this message translates to:
  /// **'all off'**
  String get allOff;

  /// No description provided for @someOn.
  ///
  /// In en, this message translates to:
  /// **'{n} on'**
  String someOn(int n);

  /// No description provided for @skippedBody.
  ///
  /// In en, this message translates to:
  /// **'Skipped · {body}'**
  String skippedBody(String body);

  /// No description provided for @timeToTime.
  ///
  /// In en, this message translates to:
  /// **'{from} to {to}'**
  String timeToTime(String from, String to);

  /// No description provided for @skippedCount.
  ///
  /// In en, this message translates to:
  /// **'{n} skipped'**
  String skippedCount(int n);

  /// No description provided for @sunNoRiseSet.
  ///
  /// In en, this message translates to:
  /// **'The sun does not rise or set here today'**
  String get sunNoRiseSet;

  /// No description provided for @sunProgress.
  ///
  /// In en, this message translates to:
  /// **'The sun is {percent}% of the way through the day'**
  String sunProgress(int percent);

  /// No description provided for @sunIsDown.
  ///
  /// In en, this message translates to:
  /// **'The sun is down'**
  String get sunIsDown;

  /// No description provided for @searchCity.
  ///
  /// In en, this message translates to:
  /// **'Search a city'**
  String get searchCity;

  /// No description provided for @tomorrowLower.
  ///
  /// In en, this message translates to:
  /// **'tomorrow'**
  String get tomorrowLower;

  /// No description provided for @yesterdayLower.
  ///
  /// In en, this message translates to:
  /// **'yesterday'**
  String get yesterdayLower;

  /// No description provided for @worldClocksHeading.
  ///
  /// In en, this message translates to:
  /// **'WORLD CLOCKS'**
  String get worldClocksHeading;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @cityHere.
  ///
  /// In en, this message translates to:
  /// **'{city} · here'**
  String cityHere(String city);

  /// No description provided for @worldClocksHint.
  ///
  /// In en, this message translates to:
  /// **'Add cities to see their time here. Swipe one left to remove it.'**
  String get worldClocksHint;

  /// No description provided for @groupNameHint.
  ///
  /// In en, this message translates to:
  /// **'Work, Kids, Gym…'**
  String get groupNameHint;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @noGroup.
  ///
  /// In en, this message translates to:
  /// **'No group'**
  String get noGroup;

  /// No description provided for @newGroupEllipsis.
  ///
  /// In en, this message translates to:
  /// **'New group…'**
  String get newGroupEllipsis;

  /// No description provided for @newGroup.
  ///
  /// In en, this message translates to:
  /// **'New group'**
  String get newGroup;

  /// No description provided for @secondsShort.
  ///
  /// In en, this message translates to:
  /// **'{n} s'**
  String secondsShort(int n);

  /// No description provided for @minutesShort.
  ///
  /// In en, this message translates to:
  /// **'{n} min'**
  String minutesShort(int n);

  /// No description provided for @minutes.
  ///
  /// In en, this message translates to:
  /// **'Minutes'**
  String get minutes;

  /// No description provided for @ringFor.
  ///
  /// In en, this message translates to:
  /// **'Ring for'**
  String get ringFor;

  /// No description provided for @seconds.
  ///
  /// In en, this message translates to:
  /// **'Seconds'**
  String get seconds;

  /// No description provided for @oneSecondLess.
  ///
  /// In en, this message translates to:
  /// **'1 second less'**
  String get oneSecondLess;

  /// No description provided for @oneSecondMore.
  ///
  /// In en, this message translates to:
  /// **'1 second more'**
  String get oneSecondMore;

  /// No description provided for @inDays.
  ///
  /// In en, this message translates to:
  /// **'in {d} d'**
  String inDays(int d);

  /// No description provided for @inDaysHours.
  ///
  /// In en, this message translates to:
  /// **'in {d} d {h} h'**
  String inDaysHours(int d, int h);

  /// No description provided for @inHours.
  ///
  /// In en, this message translates to:
  /// **'in {h} h'**
  String inHours(int h);

  /// No description provided for @inHoursMinutes.
  ///
  /// In en, this message translates to:
  /// **'in {h} h {m} min'**
  String inHoursMinutes(int h, int m);

  /// No description provided for @inMins.
  ///
  /// In en, this message translates to:
  /// **'in {m} min'**
  String inMins(int m);

  /// No description provided for @placeChange.
  ///
  /// In en, this message translates to:
  /// **'{city} · {where} · change'**
  String placeChange(String city, String where);

  /// No description provided for @israel.
  ///
  /// In en, this message translates to:
  /// **'Israel'**
  String get israel;

  /// No description provided for @outsideIsrael.
  ///
  /// In en, this message translates to:
  /// **'outside Israel'**
  String get outsideIsrael;

  /// No description provided for @comingUpHeading.
  ///
  /// In en, this message translates to:
  /// **'COMING UP'**
  String get comingUpHeading;

  /// No description provided for @lockForShabbat.
  ///
  /// In en, this message translates to:
  /// **'Lock the phone for Shabbat'**
  String get lockForShabbat;

  /// No description provided for @lockForShabbatHint.
  ///
  /// In en, this message translates to:
  /// **'From candle lighting to Havdalah, festivals too'**
  String get lockForShabbatHint;

  /// No description provided for @ownShabbatAlarmsHeading.
  ///
  /// In en, this message translates to:
  /// **'YOUR OWN SHABBAT ALARMS'**
  String get ownShabbatAlarmsHeading;

  /// No description provided for @addShabbatAlarm.
  ///
  /// In en, this message translates to:
  /// **'Add a Shabbat or festival alarm'**
  String get addShabbatAlarm;

  /// No description provided for @readyMadeHeading.
  ///
  /// In en, this message translates to:
  /// **'READY-MADE ALARMS'**
  String get readyMadeHeading;

  /// No description provided for @bringBackDeleted.
  ///
  /// In en, this message translates to:
  /// **'Bring back deleted ones ({n})'**
  String bringBackDeleted(int n);

  /// No description provided for @presetsHint.
  ///
  /// In en, this message translates to:
  /// **'Tap one to change its times. Swipe one away to delete it.'**
  String get presetsHint;

  /// No description provided for @lockSentence.
  ///
  /// In en, this message translates to:
  /// **'Lock the phone down to the clock and your alarms, for Shabbat or a focused night.'**
  String get lockSentence;

  /// No description provided for @lockExplain.
  ///
  /// In en, this message translates to:
  /// **'While locked, Quando? shows only the time, the next alarm and when the lock ends. Alarms keep working, and nothing can be changed until it unlocks.'**
  String get lockExplain;

  /// No description provided for @lockNowHeading.
  ///
  /// In en, this message translates to:
  /// **'LOCK NOW'**
  String get lockNowHeading;

  /// No description provided for @lockAutoHeading.
  ///
  /// In en, this message translates to:
  /// **'LOCK AUTOMATICALLY'**
  String get lockAutoHeading;

  /// No description provided for @shabbatAndFestivalsLong.
  ///
  /// In en, this message translates to:
  /// **'Shabbat and festivals'**
  String get shabbatAndFestivalsLong;

  /// No description provided for @fromCandleToHavdalah.
  ///
  /// In en, this message translates to:
  /// **'From candle lighting to Havdalah'**
  String get fromCandleToHavdalah;

  /// No description provided for @lockCalendarWord.
  ///
  /// In en, this message translates to:
  /// **'During events named…'**
  String get lockCalendarWord;

  /// No description provided for @lockCalendarWordHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. lock, exam, focus'**
  String get lockCalendarWordHint;

  /// No description provided for @leaveEmptyForNone.
  ///
  /// In en, this message translates to:
  /// **'Leave empty for none'**
  String get leaveEmptyForNone;

  /// No description provided for @connectCalendarsFirst.
  ///
  /// In en, this message translates to:
  /// **'Connect calendars first (calendar icon)'**
  String get connectCalendarsFirst;

  /// No description provided for @openWhenLockStarts.
  ///
  /// In en, this message translates to:
  /// **'Open Quando? when a lock starts'**
  String get openWhenLockStarts;

  /// No description provided for @openWhenLockStartsHint.
  ///
  /// In en, this message translates to:
  /// **'A soft 1-second chime brings Quando? to the front so it can lock'**
  String get openWhenLockStartsHint;

  /// No description provided for @pinToScreen.
  ///
  /// In en, this message translates to:
  /// **'Pin Quando? to the screen'**
  String get pinToScreen;

  /// No description provided for @pinToScreenHint.
  ///
  /// In en, this message translates to:
  /// **'Other apps can\'t be opened while locked. Android asks you to confirm the first time.'**
  String get pinToScreenHint;

  /// No description provided for @noLocksComingUp.
  ///
  /// In en, this message translates to:
  /// **'No locks coming up.'**
  String get noLocksComingUp;

  /// No description provided for @leaveLockEarly.
  ///
  /// In en, this message translates to:
  /// **'To leave a lock early, hold “Hold to unlock” for 3 seconds.'**
  String get leaveLockEarly;

  /// No description provided for @locked.
  ///
  /// In en, this message translates to:
  /// **'Locked'**
  String get locked;

  /// No description provided for @shabbatShalom.
  ///
  /// In en, this message translates to:
  /// **'Shabbat shalom'**
  String get shabbatShalom;

  /// No description provided for @chagSameach.
  ///
  /// In en, this message translates to:
  /// **'Chag sameach'**
  String get chagSameach;

  /// No description provided for @unlocksHeading.
  ///
  /// In en, this message translates to:
  /// **'UNLOCKS'**
  String get unlocksHeading;

  /// No description provided for @nowCap.
  ///
  /// In en, this message translates to:
  /// **'Now'**
  String get nowCap;

  /// No description provided for @nextAlarm.
  ///
  /// In en, this message translates to:
  /// **'Next alarm'**
  String get nextAlarm;

  /// No description provided for @holdToUnlock.
  ///
  /// In en, this message translates to:
  /// **'Hold to unlock'**
  String get holdToUnlock;

  /// No description provided for @lockSentenceCalm.
  ///
  /// In en, this message translates to:
  /// **'Lock the phone down to the clock and your alarms: for an exam, a meeting or a quiet evening.'**
  String get lockSentenceCalm;

  /// No description provided for @lockCalendarHeading.
  ///
  /// In en, this message translates to:
  /// **'WITH YOUR CALENDAR'**
  String get lockCalendarHeading;

  /// No description provided for @lockCalendarExplain.
  ///
  /// In en, this message translates to:
  /// **'Lock during an event, or from one event until the next one you name. Works with any calendar you picked, including shared ones.'**
  String get lockCalendarExplain;

  /// No description provided for @lockAddCalendar.
  ///
  /// In en, this message translates to:
  /// **'Add a calendar lock'**
  String get lockAddCalendar;

  /// No description provided for @lockEditCalendar.
  ///
  /// In en, this message translates to:
  /// **'Calendar lock'**
  String get lockEditCalendar;

  /// No description provided for @lockDuring.
  ///
  /// In en, this message translates to:
  /// **'During an event'**
  String get lockDuring;

  /// No description provided for @lockBetween.
  ///
  /// In en, this message translates to:
  /// **'Between two events'**
  String get lockBetween;

  /// No description provided for @lockStartsAt.
  ///
  /// In en, this message translates to:
  /// **'Events named…'**
  String get lockStartsAt;

  /// No description provided for @lockStartsAtBetween.
  ///
  /// In en, this message translates to:
  /// **'Starts at an event named…'**
  String get lockStartsAtBetween;

  /// No description provided for @lockEndsAt.
  ///
  /// In en, this message translates to:
  /// **'Ends at the next event named…'**
  String get lockEndsAt;

  /// No description provided for @lockStartHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. exam, focus, gym'**
  String get lockStartHint;

  /// No description provided for @lockEndHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. back home'**
  String get lockEndHint;

  /// No description provided for @lockAnyCalendar.
  ///
  /// In en, this message translates to:
  /// **'Any calendar'**
  String get lockAnyCalendar;

  /// No description provided for @lockNoMatches.
  ///
  /// In en, this message translates to:
  /// **'Nothing in your calendars matches yet.'**
  String get lockNoMatches;

  /// No description provided for @lockNextTimes.
  ///
  /// In en, this message translates to:
  /// **'NEXT TIMES'**
  String get lockNextTimes;

  /// No description provided for @lockDuringTitle.
  ///
  /// In en, this message translates to:
  /// **'During “{a}”'**
  String lockDuringTitle(String a);

  /// No description provided for @lockBetweenTitle.
  ///
  /// In en, this message translates to:
  /// **'From “{a}” to the next “{b}”'**
  String lockBetweenTitle(String a, String b);

  /// No description provided for @lockShabbatCalendarFound.
  ///
  /// In en, this message translates to:
  /// **'“{name}” has Shabbat times.'**
  String lockShabbatCalendarFound(String name);

  /// No description provided for @lockShabbatFromCalendar.
  ///
  /// In en, this message translates to:
  /// **'Lock from candle lighting to Havdalah'**
  String get lockShabbatFromCalendar;

  /// No description provided for @lockShabbatFromCalendarHint.
  ///
  /// In en, this message translates to:
  /// **'Uses the times in that calendar, with candles on the lock screen.'**
  String get lockShabbatFromCalendarHint;

  /// No description provided for @lockMoreWays.
  ///
  /// In en, this message translates to:
  /// **'More ways to lock'**
  String get lockMoreWays;

  /// No description provided for @lockQuietTime.
  ///
  /// In en, this message translates to:
  /// **'Quiet time'**
  String get lockQuietTime;

  /// No description provided for @nextCandleLightingFrom.
  ///
  /// In en, this message translates to:
  /// **'Next candle lighting: {time}, from {name}'**
  String nextCandleLightingFrom(String time, String name);

  /// No description provided for @calendarAlarm.
  ///
  /// In en, this message translates to:
  /// **'Calendar alarm'**
  String get calendarAlarm;

  /// No description provided for @connectCalendars.
  ///
  /// In en, this message translates to:
  /// **'Connect calendars'**
  String get connectCalendars;

  /// No description provided for @calendarAlarmsHeading.
  ///
  /// In en, this message translates to:
  /// **'CALENDAR ALARMS'**
  String get calendarAlarmsHeading;

  /// No description provided for @calendarNoneYet.
  ///
  /// In en, this message translates to:
  /// **'None yet. Start with one, then change it as you like:'**
  String get calendarNoneYet;

  /// No description provided for @fifteenBeforeEvery.
  ///
  /// In en, this message translates to:
  /// **'15 minutes before every event'**
  String get fifteenBeforeEvery;

  /// No description provided for @useTheseCalendarsHeading.
  ///
  /// In en, this message translates to:
  /// **'USE THESE CALENDARS'**
  String get useTheseCalendarsHeading;

  /// No description provided for @noTimedEvents.
  ///
  /// In en, this message translates to:
  /// **'No timed events coming up in these calendars.'**
  String get noTimedEvents;

  /// No description provided for @atTheStart.
  ///
  /// In en, this message translates to:
  /// **'at the start'**
  String get atTheStart;

  /// No description provided for @everyForBefore.
  ///
  /// In en, this message translates to:
  /// **'every {every} for {span} before'**
  String everyForBefore(String every, String span);

  /// No description provided for @spanAfterItEnds.
  ///
  /// In en, this message translates to:
  /// **'{span} after it ends'**
  String spanAfterItEnds(String span);

  /// No description provided for @noAlarmsChosen.
  ///
  /// In en, this message translates to:
  /// **'No alarms chosen'**
  String get noAlarmsChosen;

  /// No description provided for @gentleWakeUp.
  ///
  /// In en, this message translates to:
  /// **'Gentle wake-up'**
  String get gentleWakeUp;

  /// No description provided for @gentleSummary.
  ///
  /// In en, this message translates to:
  /// **'{minutes} min before · {sound}'**
  String gentleSummary(int minutes, String sound);

  /// No description provided for @off.
  ///
  /// In en, this message translates to:
  /// **'Off'**
  String get off;

  /// No description provided for @gentleSentence.
  ///
  /// In en, this message translates to:
  /// **'A calm sound starts softly before your alarm, so it never jolts you awake.'**
  String get gentleSentence;

  /// No description provided for @gentleExplain.
  ///
  /// In en, this message translates to:
  /// **'It grows slowly, easing you out of light sleep, and stops just before the alarm rings.'**
  String get gentleExplain;

  /// No description provided for @startsBeforeHeading.
  ///
  /// In en, this message translates to:
  /// **'STARTS BEFORE THE ALARM'**
  String get startsBeforeHeading;

  /// No description provided for @leadUpSoundHeading.
  ///
  /// In en, this message translates to:
  /// **'LEAD-UP SOUND'**
  String get leadUpSoundHeading;

  /// No description provided for @listen.
  ///
  /// In en, this message translates to:
  /// **'Listen'**
  String get listen;

  /// No description provided for @whoRecordedThese.
  ///
  /// In en, this message translates to:
  /// **'Who recorded these'**
  String get whoRecordedThese;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @soundCredits.
  ///
  /// In en, this message translates to:
  /// **'Sound credits'**
  String get soundCredits;

  /// No description provided for @yourTimeCity.
  ///
  /// In en, this message translates to:
  /// **'Your time ({city})'**
  String yourTimeCity(String city);

  /// No description provided for @anotherCity.
  ///
  /// In en, this message translates to:
  /// **'Another city…'**
  String get anotherCity;

  /// No description provided for @ringingIn5.
  ///
  /// In en, this message translates to:
  /// **'Ringing in 5 seconds…'**
  String get ringingIn5;

  /// No description provided for @alarmSaved.
  ///
  /// In en, this message translates to:
  /// **'Alarm saved.'**
  String get alarmSaved;

  /// No description provided for @alarmSetFor.
  ///
  /// In en, this message translates to:
  /// **'Alarm set for {span} from now.'**
  String alarmSetFor(String span);

  /// No description provided for @hoursMinutesShort.
  ///
  /// In en, this message translates to:
  /// **'{h} h {m} min'**
  String hoursMinutesShort(int h, int m);

  /// No description provided for @editAlarm.
  ///
  /// In en, this message translates to:
  /// **'Edit alarm'**
  String get editAlarm;

  /// No description provided for @previewCaps.
  ///
  /// In en, this message translates to:
  /// **'PREVIEW'**
  String get previewCaps;

  /// No description provided for @saveCaps.
  ///
  /// In en, this message translates to:
  /// **'SAVE'**
  String get saveCaps;

  /// No description provided for @cityTimeForYou.
  ///
  /// In en, this message translates to:
  /// **'{city} time · {time} for you'**
  String cityTimeForYou(String city, String time);

  /// No description provided for @repeatHeading.
  ///
  /// In en, this message translates to:
  /// **'REPEAT · {repeat}'**
  String repeatHeading(String repeat);

  /// No description provided for @labelField.
  ///
  /// In en, this message translates to:
  /// **'Label (read aloud if spoken alarms are on)'**
  String get labelField;

  /// No description provided for @group.
  ///
  /// In en, this message translates to:
  /// **'Group'**
  String get group;

  /// No description provided for @ringsForHeading.
  ///
  /// In en, this message translates to:
  /// **'RINGS FOR {span}'**
  String ringsForHeading(String span);

  /// No description provided for @useDefault.
  ///
  /// In en, this message translates to:
  /// **'Use the default ({value})'**
  String useDefault(String value);

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @sameTime.
  ///
  /// In en, this message translates to:
  /// **'same time'**
  String get sameTime;

  /// No description provided for @untilYouStopIt.
  ///
  /// In en, this message translates to:
  /// **'Until you stop it'**
  String get untilYouStopIt;

  /// No description provided for @alarm.
  ///
  /// In en, this message translates to:
  /// **'Alarm'**
  String get alarm;

  /// No description provided for @once.
  ///
  /// In en, this message translates to:
  /// **'Once'**
  String get once;

  /// No description provided for @everyDay.
  ///
  /// In en, this message translates to:
  /// **'Every day'**
  String get everyDay;

  /// No description provided for @weekdays.
  ///
  /// In en, this message translates to:
  /// **'Weekdays'**
  String get weekdays;

  /// No description provided for @weekends.
  ///
  /// In en, this message translates to:
  /// **'Weekends'**
  String get weekends;

  /// No description provided for @timeInCity.
  ///
  /// In en, this message translates to:
  /// **'{time} {city} time'**
  String timeInCity(String time, String city);

  /// No description provided for @eventsMatching.
  ///
  /// In en, this message translates to:
  /// **'Events matching “{words}”'**
  String eventsMatching(String words);

  /// No description provided for @everyEvent.
  ///
  /// In en, this message translates to:
  /// **'Every event'**
  String get everyEvent;

  /// No description provided for @sunrise.
  ///
  /// In en, this message translates to:
  /// **'Sunrise'**
  String get sunrise;

  /// No description provided for @havdalahEndOf.
  ///
  /// In en, this message translates to:
  /// **'Havdalah · end of {day}'**
  String havdalahEndOf(String day);

  /// No description provided for @yomTov.
  ///
  /// In en, this message translates to:
  /// **'Yom Tov'**
  String get yomTov;

  /// No description provided for @shabbat.
  ///
  /// In en, this message translates to:
  /// **'Shabbat'**
  String get shabbat;

  /// No description provided for @presetCountdown.
  ///
  /// In en, this message translates to:
  /// **'Countdown to candle lighting'**
  String get presetCountdown;

  /// No description provided for @presetHourly.
  ///
  /// In en, this message translates to:
  /// **'Every hour, from 6 hours before'**
  String get presetHourly;

  /// No description provided for @presetDailyWeek.
  ///
  /// In en, this message translates to:
  /// **'Once a day, for a week before'**
  String get presetDailyWeek;

  /// No description provided for @presetSecondNight.
  ///
  /// In en, this message translates to:
  /// **'Second-night candles'**
  String get presetSecondNight;

  /// No description provided for @presetFridayReminder.
  ///
  /// In en, this message translates to:
  /// **'Reminder 3 hours before: charge your phone'**
  String get presetFridayReminder;

  /// No description provided for @presetFridayReminderLabel.
  ///
  /// In en, this message translates to:
  /// **'Charge your phone and set any alarms for tomorrow'**
  String get presetFridayReminderLabel;

  /// No description provided for @presetSunset.
  ///
  /// In en, this message translates to:
  /// **'Sunset, and 15 minutes before'**
  String get presetSunset;

  /// No description provided for @pesach.
  ///
  /// In en, this message translates to:
  /// **'Pesach'**
  String get pesach;

  /// No description provided for @shavuot.
  ///
  /// In en, this message translates to:
  /// **'Shavuot'**
  String get shavuot;

  /// No description provided for @roshHashanah.
  ///
  /// In en, this message translates to:
  /// **'Rosh Hashanah'**
  String get roshHashanah;

  /// No description provided for @yomKippur.
  ///
  /// In en, this message translates to:
  /// **'Yom Kippur'**
  String get yomKippur;

  /// No description provided for @sukkot.
  ///
  /// In en, this message translates to:
  /// **'Sukkot'**
  String get sukkot;

  /// No description provided for @sheminiAtzeret.
  ///
  /// In en, this message translates to:
  /// **'Shemini Atzeret'**
  String get sheminiAtzeret;

  /// No description provided for @simchatTorah.
  ///
  /// In en, this message translates to:
  /// **'Simchat Torah'**
  String get simchatTorah;

  /// No description provided for @readyNotifications.
  ///
  /// In en, this message translates to:
  /// **'Show alarms'**
  String get readyNotifications;

  /// No description provided for @readyNotificationsWhy.
  ///
  /// In en, this message translates to:
  /// **'Lets the ringing screen and Stop button appear.'**
  String get readyNotificationsWhy;

  /// No description provided for @readyFullScreen.
  ///
  /// In en, this message translates to:
  /// **'Ring over the lock screen'**
  String get readyFullScreen;

  /// No description provided for @readyFullScreenWhy.
  ///
  /// In en, this message translates to:
  /// **'Shows the alarm full screen, even when the phone is locked.'**
  String get readyFullScreenWhy;

  /// No description provided for @readyExact.
  ///
  /// In en, this message translates to:
  /// **'Ring on the minute'**
  String get readyExact;

  /// No description provided for @readyExactWhy.
  ///
  /// In en, this message translates to:
  /// **'Without it, the phone may ring alarms a few minutes late.'**
  String get readyExactWhy;

  /// No description provided for @readyBattery.
  ///
  /// In en, this message translates to:
  /// **'Keep running on battery saver'**
  String get readyBattery;

  /// No description provided for @readyBatteryWhy.
  ///
  /// In en, this message translates to:
  /// **'Stops battery saving from silencing alarms overnight.'**
  String get readyBatteryWhy;

  /// No description provided for @tipXiaomi.
  ///
  /// In en, this message translates to:
  /// **'Xiaomi phones: in Settings › Apps › Quando?, turn on Autostart and set Battery saver to No restrictions.'**
  String get tipXiaomi;

  /// No description provided for @tipSamsung.
  ///
  /// In en, this message translates to:
  /// **'Samsung phones: in Settings › Battery › Background usage limits, make sure Quando? isn\'t sleeping.'**
  String get tipSamsung;

  /// No description provided for @tipHuawei.
  ///
  /// In en, this message translates to:
  /// **'Huawei and Honor phones: in Settings › Battery › App launch, set Quando? to Manage manually and allow everything.'**
  String get tipHuawei;

  /// No description provided for @tipOther.
  ///
  /// In en, this message translates to:
  /// **'On this phone: in Settings › Battery, allow Quando? to run in the background and turn off Optimise for it.'**
  String get tipOther;

  /// No description provided for @testRing.
  ///
  /// In en, this message translates to:
  /// **'Test ring'**
  String get testRing;

  /// No description provided for @testRingBody.
  ///
  /// In en, this message translates to:
  /// **'Quando? can wake you'**
  String get testRingBody;

  /// No description provided for @ringsIn20.
  ///
  /// In en, this message translates to:
  /// **'Rings in 20 seconds. Lock your phone now and wait.'**
  String get ringsIn20;

  /// No description provided for @readyToRing.
  ///
  /// In en, this message translates to:
  /// **'Ready to ring'**
  String get readyToRing;

  /// No description provided for @checkingPhone.
  ///
  /// In en, this message translates to:
  /// **'Checking your phone…'**
  String get checkingPhone;

  /// No description provided for @phoneReady.
  ///
  /// In en, this message translates to:
  /// **'Your phone is set up to ring every alarm on time.'**
  String get phoneReady;

  /// No description provided for @thingsNeedFixing.
  ///
  /// In en, this message translates to:
  /// **'{n, plural, =1{1 thing needs fixing, or alarms may not ring.} other{{n} things need fixing, or alarms may not ring.}}'**
  String thingsNeedFixing(int n);

  /// No description provided for @fix.
  ///
  /// In en, this message translates to:
  /// **'Fix'**
  String get fix;

  /// No description provided for @testIn20.
  ///
  /// In en, this message translates to:
  /// **'Test it: ring in 20 seconds'**
  String get testIn20;

  /// No description provided for @testIn20Hint.
  ///
  /// In en, this message translates to:
  /// **'Lock the phone and put it down. If the alarm rings and shows full screen, you\'re all set.'**
  String get testIn20Hint;

  /// No description provided for @readyToRingHint.
  ///
  /// In en, this message translates to:
  /// **'Check your phone lets every alarm ring on time'**
  String get readyToRingHint;

  /// No description provided for @connections.
  ///
  /// In en, this message translates to:
  /// **'Connections'**
  String get connections;

  /// No description provided for @timeZoneHeading.
  ///
  /// In en, this message translates to:
  /// **'TIME ZONE'**
  String get timeZoneHeading;

  /// No description provided for @followPhone.
  ///
  /// In en, this message translates to:
  /// **'Follow the phone'**
  String get followPhone;

  /// No description provided for @followPhoneNow.
  ///
  /// In en, this message translates to:
  /// **'Now {city}. Changes by itself when you travel.'**
  String followPhoneNow(String city);

  /// No description provided for @zoneFixed.
  ///
  /// In en, this message translates to:
  /// **'Fixed. Alarms keep this time even when you travel.'**
  String get zoneFixed;

  /// No description provided for @shabbatCityHeading.
  ///
  /// In en, this message translates to:
  /// **'SHABBAT CITY'**
  String get shabbatCityHeading;

  /// No description provided for @inIsraelOneDay.
  ///
  /// In en, this message translates to:
  /// **'In Israel (one festival day)'**
  String get inIsraelOneDay;

  /// No description provided for @candleMinutesHeading.
  ///
  /// In en, this message translates to:
  /// **'CANDLE LIGHTING: {n} MINUTES BEFORE SUNSET'**
  String candleMinutesHeading(int n);

  /// No description provided for @endOfShabbatHeading.
  ///
  /// In en, this message translates to:
  /// **'END OF SHABBAT AND FESTIVALS'**
  String get endOfShabbatHeading;

  /// No description provided for @nightfallGeonim.
  ///
  /// In en, this message translates to:
  /// **'Nightfall (Geonim, 8.5°)'**
  String get nightfallGeonim;

  /// No description provided for @rabbeinuTam.
  ///
  /// In en, this message translates to:
  /// **'72 minutes after sunset (Rabbeinu Tam)'**
  String get rabbeinuTam;

  /// No description provided for @whenAlarmRingsHeading.
  ///
  /// In en, this message translates to:
  /// **'WHEN AN ALARM RINGS'**
  String get whenAlarmRingsHeading;

  /// No description provided for @recordOrAddSounds.
  ///
  /// In en, this message translates to:
  /// **'Record or add sounds'**
  String get recordOrAddSounds;

  /// No description provided for @ringsForThisLong.
  ///
  /// In en, this message translates to:
  /// **'Rings for this long, then stops by itself'**
  String get ringsForThisLong;

  /// No description provided for @sameFades.
  ///
  /// In en, this message translates to:
  /// **'Same fades for every alarm'**
  String get sameFades;

  /// No description provided for @sameFadesOn.
  ///
  /// In en, this message translates to:
  /// **'Overrides the fades set on each alarm. Each keeps its own volume.'**
  String get sameFadesOn;

  /// No description provided for @sameFadesOff.
  ///
  /// In en, this message translates to:
  /// **'Off: each alarm uses the fades set under its Volume.'**
  String get sameFadesOff;

  /// No description provided for @sayItOutLoud.
  ///
  /// In en, this message translates to:
  /// **'Say it out loud'**
  String get sayItOutLoud;

  /// No description provided for @sayItOutLoudHint.
  ///
  /// In en, this message translates to:
  /// **'Reads what the alarm is for, e.g. “Candle lighting, 15 minutes before”'**
  String get sayItOutLoudHint;

  /// No description provided for @noSnooze.
  ///
  /// In en, this message translates to:
  /// **'No snooze'**
  String get noSnooze;

  /// No description provided for @snoozeUpTo.
  ///
  /// In en, this message translates to:
  /// **'Snooze up to {times}× of {minutes} min'**
  String snoozeUpTo(int times, int minutes);

  /// No description provided for @wakeUpCheck.
  ///
  /// In en, this message translates to:
  /// **'Wake-up check'**
  String get wakeUpCheck;

  /// No description provided for @wakeUpCheckHint.
  ///
  /// In en, this message translates to:
  /// **'After you stop it, rings again in 3 minutes unless you tap “I\'m up”'**
  String get wakeUpCheckHint;

  /// No description provided for @solveSum.
  ///
  /// In en, this message translates to:
  /// **'Solve a sum to stop'**
  String get solveSum;

  /// No description provided for @provesAwake.
  ///
  /// In en, this message translates to:
  /// **'Proves you\'re awake'**
  String get provesAwake;

  /// No description provided for @shabbatNoTasks.
  ///
  /// In en, this message translates to:
  /// **'On Shabbat and festivals none of these apply: alarms stop by themselves and never ask you to touch the phone.'**
  String get shabbatNoTasks;

  /// No description provided for @testAlarmIn1.
  ///
  /// In en, this message translates to:
  /// **'Ring a test alarm in 1 minute'**
  String get testAlarmIn1;

  /// No description provided for @timesDisclaimer.
  ///
  /// In en, this message translates to:
  /// **'Times are calculated on your phone. For borderline cases, check with your rabbi or community calendar.'**
  String get timesDisclaimer;

  /// No description provided for @recommended.
  ///
  /// In en, this message translates to:
  /// **'Recommended'**
  String get recommended;

  /// No description provided for @chooseCity.
  ///
  /// In en, this message translates to:
  /// **'Choose a city'**
  String get chooseCity;

  /// No description provided for @testOnlyOnPhone.
  ///
  /// In en, this message translates to:
  /// **'Test alarms only work on a phone.'**
  String get testOnlyOnPhone;

  /// No description provided for @testAlarm.
  ///
  /// In en, this message translates to:
  /// **'Test alarm'**
  String get testAlarm;

  /// No description provided for @testAlarmBody.
  ///
  /// In en, this message translates to:
  /// **'This is how your alarms will sound'**
  String get testAlarmBody;

  /// No description provided for @testAlarmIn1Set.
  ///
  /// In en, this message translates to:
  /// **'Test alarm in 1 minute. You can lock the phone.'**
  String get testAlarmIn1Set;

  /// No description provided for @presetGone.
  ///
  /// In en, this message translates to:
  /// **'This preset no longer exists.'**
  String get presetGone;

  /// No description provided for @editPreset.
  ///
  /// In en, this message translates to:
  /// **'Edit preset'**
  String get editPreset;

  /// No description provided for @on.
  ///
  /// In en, this message translates to:
  /// **'On'**
  String get on;

  /// No description provided for @ringsHeading.
  ///
  /// In en, this message translates to:
  /// **'RINGS'**
  String get ringsHeading;

  /// No description provided for @noTimesYet.
  ///
  /// In en, this message translates to:
  /// **'No times yet. Add one below.'**
  String get noTimesYet;

  /// No description provided for @atTheMomentItself.
  ///
  /// In en, this message translates to:
  /// **'At the moment itself'**
  String get atTheMomentItself;

  /// No description provided for @remove.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get remove;

  /// No description provided for @addATime.
  ///
  /// In en, this message translates to:
  /// **'Add a time'**
  String get addATime;

  /// No description provided for @resetPreset.
  ///
  /// In en, this message translates to:
  /// **'Reset to how it came'**
  String get resetPreset;

  /// No description provided for @skipOneHint.
  ///
  /// In en, this message translates to:
  /// **'To skip just one alarm, tap it in “Alarms this week” on the home screen.'**
  String get skipOneHint;

  /// No description provided for @unitMinutes.
  ///
  /// In en, this message translates to:
  /// **'minutes'**
  String get unitMinutes;

  /// No description provided for @unitHours.
  ///
  /// In en, this message translates to:
  /// **'hours'**
  String get unitHours;

  /// No description provided for @unitDays.
  ///
  /// In en, this message translates to:
  /// **'days'**
  String get unitDays;

  /// No description provided for @before.
  ///
  /// In en, this message translates to:
  /// **'Before'**
  String get before;

  /// No description provided for @after.
  ///
  /// In en, this message translates to:
  /// **'After'**
  String get after;

  /// No description provided for @oneWeek.
  ///
  /// In en, this message translates to:
  /// **'1 week'**
  String get oneWeek;

  /// No description provided for @daysShort.
  ///
  /// In en, this message translates to:
  /// **'{n} d'**
  String daysShort(int n);

  /// No description provided for @hoursShort.
  ///
  /// In en, this message translates to:
  /// **'{n} h'**
  String hoursShort(int n);

  /// No description provided for @howToSearch.
  ///
  /// In en, this message translates to:
  /// **'How to search'**
  String get howToSearch;

  /// No description provided for @searchHelpWord.
  ///
  /// In en, this message translates to:
  /// **'The title contains “dentist”, any case'**
  String get searchHelpWord;

  /// No description provided for @searchHelpStar.
  ///
  /// In en, this message translates to:
  /// **'* is any letters: dentist, dentures'**
  String get searchHelpStar;

  /// No description provided for @searchHelpQuestion.
  ///
  /// In en, this message translates to:
  /// **'? is one letter: yoga, toga'**
  String get searchHelpQuestion;

  /// No description provided for @searchHelpPhrase.
  ///
  /// In en, this message translates to:
  /// **'This exact phrase'**
  String get searchHelpPhrase;

  /// No description provided for @searchHelpAnd.
  ///
  /// In en, this message translates to:
  /// **'Both words (AND)'**
  String get searchHelpAnd;

  /// No description provided for @searchHelpOr.
  ///
  /// In en, this message translates to:
  /// **'Either one. | works too'**
  String get searchHelpOr;

  /// No description provided for @searchHelpNot.
  ///
  /// In en, this message translates to:
  /// **'Leave out. NOT and ! work too'**
  String get searchHelpNot;

  /// No description provided for @searchHelpBrackets.
  ///
  /// In en, this message translates to:
  /// **'Brackets group words'**
  String get searchHelpBrackets;

  /// No description provided for @searchHelpEmpty.
  ///
  /// In en, this message translates to:
  /// **'Leave it empty to ring for every event.'**
  String get searchHelpEmpty;

  /// No description provided for @customTime.
  ///
  /// In en, this message translates to:
  /// **'Custom time'**
  String get customTime;

  /// No description provided for @other.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get other;

  /// No description provided for @sun.
  ///
  /// In en, this message translates to:
  /// **'Sun'**
  String get sun;

  /// No description provided for @calendar.
  ///
  /// In en, this message translates to:
  /// **'Calendar'**
  String get calendar;

  /// No description provided for @newEventAlarm.
  ///
  /// In en, this message translates to:
  /// **'New event alarm'**
  String get newEventAlarm;

  /// No description provided for @eventAlarm.
  ///
  /// In en, this message translates to:
  /// **'Event alarm'**
  String get eventAlarm;

  /// No description provided for @findEventsHeading.
  ///
  /// In en, this message translates to:
  /// **'FIND THE EVENTS'**
  String get findEventsHeading;

  /// No description provided for @searchEventsHint.
  ///
  /// In en, this message translates to:
  /// **'Search: dentist, gym OR yoga, dent*…'**
  String get searchEventsHint;

  /// No description provided for @alsoBuiltInTimes.
  ///
  /// In en, this message translates to:
  /// **'Also Shabbat, festival and sun times'**
  String get alsoBuiltInTimes;

  /// No description provided for @alsoBuiltInTimesHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. “candle*”, “havdalah”, “sunset”'**
  String get alsoBuiltInTimesHint;

  /// No description provided for @allMyCalendars.
  ///
  /// In en, this message translates to:
  /// **'All my calendars'**
  String get allMyCalendars;

  /// No description provided for @connectToSearch.
  ///
  /// In en, this message translates to:
  /// **'Connect your calendars to search them'**
  String get connectToSearch;

  /// No description provided for @searching.
  ///
  /// In en, this message translates to:
  /// **'Searching…'**
  String get searching;

  /// No description provided for @nothingMatches60.
  ///
  /// In en, this message translates to:
  /// **'Nothing matches in the next 60 days'**
  String get nothingMatches60;

  /// No description provided for @eventsIn60.
  ///
  /// In en, this message translates to:
  /// **'{n, plural, =1{1 event in the next 60 days} other{{n} events in the next 60 days}}'**
  String eventsIn60(int n);

  /// No description provided for @nextRingsAt.
  ///
  /// In en, this message translates to:
  /// **'Next: rings at {times} for “{title}”'**
  String nextRingsAt(String times, String title);

  /// No description provided for @showMoreLeft.
  ///
  /// In en, this message translates to:
  /// **'Show more ({n} left)'**
  String showMoreLeft(int n);

  /// No description provided for @ringBeforeStartsHeading.
  ///
  /// In en, this message translates to:
  /// **'RING BEFORE IT STARTS'**
  String get ringBeforeStartsHeading;

  /// No description provided for @ringWhenStarts.
  ///
  /// In en, this message translates to:
  /// **'Ring when it starts'**
  String get ringWhenStarts;

  /// No description provided for @repeatBeforeHeading.
  ///
  /// In en, this message translates to:
  /// **'AND REPEAT BEFORE IT'**
  String get repeatBeforeHeading;

  /// No description provided for @everyPrefix.
  ///
  /// In en, this message translates to:
  /// **'Every '**
  String get everyPrefix;

  /// No description provided for @offLower.
  ///
  /// In en, this message translates to:
  /// **'off'**
  String get offLower;

  /// No description provided for @forInfix.
  ///
  /// In en, this message translates to:
  /// **'  for '**
  String get forInfix;

  /// No description provided for @ringAfterEndsHeading.
  ///
  /// In en, this message translates to:
  /// **'RING AFTER IT ENDS'**
  String get ringAfterEndsHeading;

  /// No description provided for @nameOptional.
  ///
  /// In en, this message translates to:
  /// **'Name (optional)'**
  String get nameOptional;

  /// No description provided for @toppedUp.
  ///
  /// In en, this message translates to:
  /// **'Alarms are set for the next 7 days and topped up each time you open Quando?.'**
  String get toppedUp;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @stepWhichEvents.
  ///
  /// In en, this message translates to:
  /// **'Which events'**
  String get stepWhichEvents;

  /// No description provided for @stepWhenToRing.
  ///
  /// In en, this message translates to:
  /// **'When to ring'**
  String get stepWhenToRing;

  /// No description provided for @stepHowItRings.
  ///
  /// In en, this message translates to:
  /// **'How it rings'**
  String get stepHowItRings;

  /// No description provided for @defaultNamed.
  ///
  /// In en, this message translates to:
  /// **'Default ({name})'**
  String defaultNamed(String name);

  /// No description provided for @phoneAlarmSound.
  ///
  /// In en, this message translates to:
  /// **'Phone alarm sound'**
  String get phoneAlarmSound;

  /// No description provided for @onlineRadio.
  ///
  /// In en, this message translates to:
  /// **'Online radio'**
  String get onlineRadio;

  /// No description provided for @songLinkOpens.
  ///
  /// In en, this message translates to:
  /// **'Song link · opens {app}'**
  String songLinkOpens(String app);

  /// No description provided for @builtIn.
  ///
  /// In en, this message translates to:
  /// **'Built in'**
  String get builtIn;

  /// No description provided for @yourRecording.
  ///
  /// In en, this message translates to:
  /// **'Your recording'**
  String get yourRecording;

  /// No description provided for @sound.
  ///
  /// In en, this message translates to:
  /// **'Sound'**
  String get sound;

  /// No description provided for @wakeToOwnSound.
  ///
  /// In en, this message translates to:
  /// **'Wake up to your own sound'**
  String get wakeToOwnSound;

  /// No description provided for @wakeToOwnSoundHint.
  ///
  /// In en, this message translates to:
  /// **'Your voice, a song, Spotify or live radio'**
  String get wakeToOwnSoundHint;

  /// No description provided for @musicAdded.
  ///
  /// In en, this message translates to:
  /// **'{name} added. Pick it as the sound for any alarm.'**
  String musicAdded(String name);

  /// No description provided for @playlists.
  ///
  /// In en, this message translates to:
  /// **'Playlists'**
  String get playlists;

  /// No description provided for @likedSongs.
  ///
  /// In en, this message translates to:
  /// **'Liked songs'**
  String get likedSongs;

  /// No description provided for @noPlaylists.
  ///
  /// In en, this message translates to:
  /// **'No playlists yet.'**
  String get noPlaylists;

  /// No description provided for @noLikedSongs.
  ///
  /// In en, this message translates to:
  /// **'No liked songs yet.'**
  String get noLikedSongs;

  /// No description provided for @needsMic.
  ///
  /// In en, this message translates to:
  /// **'Quando? needs the microphone to record.'**
  String get needsMic;

  /// No description provided for @recordingN.
  ///
  /// In en, this message translates to:
  /// **'Recording {n}'**
  String recordingN(int n);

  /// No description provided for @couldNotAddFile.
  ///
  /// In en, this message translates to:
  /// **'Could not add that file: {error}'**
  String couldNotAddFile(String error);

  /// No description provided for @addSongLink.
  ///
  /// In en, this message translates to:
  /// **'Add a song link'**
  String get addSongLink;

  /// No description provided for @songLink.
  ///
  /// In en, this message translates to:
  /// **'Song link'**
  String get songLink;

  /// No description provided for @songLinkHowTo.
  ///
  /// In en, this message translates to:
  /// **'In Spotify, Apple Music, YouTube, YouTube Music or SoundCloud, tap Share, then Copy link, and paste it here.'**
  String get songLinkHowTo;

  /// No description provided for @songNameHint.
  ///
  /// In en, this message translates to:
  /// **'Name, e.g. Morning playlist'**
  String get songNameHint;

  /// No description provided for @whenAlarmGoesOffHeading.
  ///
  /// In en, this message translates to:
  /// **'WHEN THE ALARM GOES OFF'**
  String get whenAlarmGoesOffHeading;

  /// No description provided for @playTheSong.
  ///
  /// In en, this message translates to:
  /// **'Play the song'**
  String get playTheSong;

  /// No description provided for @ringThenOpen.
  ///
  /// In en, this message translates to:
  /// **'Ring, then open'**
  String get ringThenOpen;

  /// No description provided for @playTheSongHint.
  ///
  /// In en, this message translates to:
  /// **'Its app opens and plays it. If it stays silent for 10 seconds, the backup sound rings instead, so you always wake up. Alarms with a task ring, then open it.'**
  String get playTheSongHint;

  /// No description provided for @ringThenOpenHint.
  ///
  /// In en, this message translates to:
  /// **'The backup sound rings. Stop opens the song in its app.'**
  String get ringThenOpenHint;

  /// No description provided for @playForHeading.
  ///
  /// In en, this message translates to:
  /// **'PLAY FOR'**
  String get playForHeading;

  /// No description provided for @pausesAfter.
  ///
  /// In en, this message translates to:
  /// **'Quando? pauses the song after this, using the phone\'s own pause button.'**
  String get pausesAfter;

  /// No description provided for @backupSoundHeading.
  ///
  /// In en, this message translates to:
  /// **'BACKUP SOUND'**
  String get backupSoundHeading;

  /// No description provided for @notALink.
  ///
  /// In en, this message translates to:
  /// **'That doesn\'t look like a link.'**
  String get notALink;

  /// No description provided for @songOn.
  ///
  /// In en, this message translates to:
  /// **'Song on {app}'**
  String songOn(String app);

  /// No description provided for @theWeb.
  ///
  /// In en, this message translates to:
  /// **'the web'**
  String get theWeb;

  /// No description provided for @pickFromYouTube.
  ///
  /// In en, this message translates to:
  /// **'Pick from my YouTube'**
  String get pickFromYouTube;

  /// No description provided for @youTubeAndMusic.
  ///
  /// In en, this message translates to:
  /// **'YouTube and YouTube Music'**
  String get youTubeAndMusic;

  /// No description provided for @youTubeOn.
  ///
  /// In en, this message translates to:
  /// **'Connected · hold to sign out'**
  String get youTubeOn;

  /// No description provided for @youTubeSignIn.
  ///
  /// In en, this message translates to:
  /// **'Sign in with Google'**
  String get youTubeSignIn;

  /// No description provided for @addSongLinkInstead.
  ///
  /// In en, this message translates to:
  /// **'Add a song link instead.'**
  String get addSongLinkInstead;

  /// No description provided for @googleSignInFailed.
  ///
  /// In en, this message translates to:
  /// **'Google sign-in didn\'t finish. Try again.'**
  String get googleSignInFailed;

  /// No description provided for @myYouTube.
  ///
  /// In en, this message translates to:
  /// **'My YouTube'**
  String get myYouTube;

  /// No description provided for @spotifyDirectOn.
  ///
  /// In en, this message translates to:
  /// **'Spotify direct play is on'**
  String get spotifyDirectOn;

  /// No description provided for @spotifyDirect.
  ///
  /// In en, this message translates to:
  /// **'Spotify direct play'**
  String get spotifyDirect;

  /// No description provided for @spotifyDirectOnHint.
  ///
  /// In en, this message translates to:
  /// **'On · tap to turn off'**
  String get spotifyDirectOnHint;

  /// No description provided for @spotifyDirectHint.
  ///
  /// In en, this message translates to:
  /// **'Plays the exact song. Needs Premium.'**
  String get spotifyDirectHint;

  /// No description provided for @spotifyComingSoon.
  ///
  /// In en, this message translates to:
  /// **'Coming soon · needs Premium'**
  String get spotifyComingSoon;

  /// No description provided for @spotifyFailed.
  ///
  /// In en, this message translates to:
  /// **'Spotify didn\'t connect. Check the Spotify app is installed, you\'re signed in, and you have Premium.'**
  String get spotifyFailed;

  /// No description provided for @nameThisSound.
  ///
  /// In en, this message translates to:
  /// **'Name this sound'**
  String get nameThisSound;

  /// No description provided for @sounds.
  ///
  /// In en, this message translates to:
  /// **'Sounds'**
  String get sounds;

  /// No description provided for @soundsSentence.
  ///
  /// In en, this message translates to:
  /// **'Wake up to your own voice, a song, a playlist or live radio.'**
  String get soundsSentence;

  /// No description provided for @stopTimer.
  ///
  /// In en, this message translates to:
  /// **'Stop · {time}'**
  String stopTimer(String time);

  /// No description provided for @record.
  ///
  /// In en, this message translates to:
  /// **'Record'**
  String get record;

  /// No description provided for @addAFile.
  ///
  /// In en, this message translates to:
  /// **'Add a file'**
  String get addAFile;

  /// No description provided for @addSongLinkLong.
  ///
  /// In en, this message translates to:
  /// **'Add a song link (Spotify, Apple Music, YouTube…)'**
  String get addSongLinkLong;

  /// No description provided for @musicAppsHeading.
  ///
  /// In en, this message translates to:
  /// **'MUSIC APPS'**
  String get musicAppsHeading;

  /// No description provided for @pickFromSpotify.
  ///
  /// In en, this message translates to:
  /// **'Pick from my Spotify'**
  String get pickFromSpotify;

  /// No description provided for @yourPlaylistsAndLiked.
  ///
  /// In en, this message translates to:
  /// **'Your playlists and liked songs'**
  String get yourPlaylistsAndLiked;

  /// No description provided for @mySpotify.
  ///
  /// In en, this message translates to:
  /// **'My Spotify'**
  String get mySpotify;

  /// No description provided for @spotifySignInFailed.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t sign in to Spotify.'**
  String get spotifySignInFailed;

  /// No description provided for @appleMusicNote.
  ///
  /// In en, this message translates to:
  /// **'Sign-in coming with the iPhone version. For now, add a song link.'**
  String get appleMusicNote;

  /// No description provided for @noSignInNote.
  ///
  /// In en, this message translates to:
  /// **'{service} doesn\'t allow sign-in from other apps. Add a song link instead.'**
  String noSignInNote(String service);

  /// No description provided for @wakeToRadio.
  ///
  /// In en, this message translates to:
  /// **'Wake up to online radio'**
  String get wakeToRadio;

  /// No description provided for @soundsExplain.
  ///
  /// In en, this message translates to:
  /// **'Record up to 5 minutes, add a file, a song link or live radio. A backup sound rings if anything fails.'**
  String get soundsExplain;

  /// No description provided for @yourSoundsHeading.
  ///
  /// In en, this message translates to:
  /// **'YOUR SOUNDS'**
  String get yourSoundsHeading;

  /// No description provided for @playsIn.
  ///
  /// In en, this message translates to:
  /// **'Plays in {app}'**
  String playsIn(String app);

  /// No description provided for @opensIn.
  ///
  /// In en, this message translates to:
  /// **'Opens in {app}'**
  String opensIn(String app);

  /// No description provided for @forSpan.
  ///
  /// In en, this message translates to:
  /// **'for {span}'**
  String forSpan(String span);

  /// No description provided for @defaultLabel.
  ///
  /// In en, this message translates to:
  /// **'Default'**
  String get defaultLabel;

  /// No description provided for @radioUnreachable.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t reach the radio directory. Check your connection.'**
  String get radioUnreachable;

  /// No description provided for @addStreamAddress.
  ///
  /// In en, this message translates to:
  /// **'Add a stream address'**
  String get addStreamAddress;

  /// No description provided for @notAStream.
  ///
  /// In en, this message translates to:
  /// **'That doesn\'t look like a stream address (it starts with http).'**
  String get notAStream;

  /// No description provided for @anyGenre.
  ///
  /// In en, this message translates to:
  /// **'Any genre'**
  String get anyGenre;

  /// No description provided for @stationName.
  ///
  /// In en, this message translates to:
  /// **'Station name'**
  String get stationName;

  /// No description provided for @closeSearch.
  ///
  /// In en, this message translates to:
  /// **'Close search'**
  String get closeSearch;

  /// No description provided for @searchByName.
  ///
  /// In en, this message translates to:
  /// **'Search by name'**
  String get searchByName;

  /// No description provided for @anywhere.
  ///
  /// In en, this message translates to:
  /// **'Anywhere'**
  String get anywhere;

  /// No description provided for @noStations.
  ///
  /// In en, this message translates to:
  /// **'No stations found. Try another genre or country.'**
  String get noStations;

  /// No description provided for @wakeUpTo.
  ///
  /// In en, this message translates to:
  /// **'Wake up to {name}'**
  String wakeUpTo(String name);

  /// No description provided for @notQuite.
  ///
  /// In en, this message translates to:
  /// **'Not quite. Try again.'**
  String get notQuite;

  /// No description provided for @shabbatStopsItself.
  ///
  /// In en, this message translates to:
  /// **'Shabbat mode: this stops by itself in {n} seconds. No need to touch the phone.'**
  String shabbatStopsItself(int n);

  /// No description provided for @solveToSnooze.
  ///
  /// In en, this message translates to:
  /// **'SOLVE TO SNOOZE'**
  String get solveToSnooze;

  /// No description provided for @solveToStop.
  ///
  /// In en, this message translates to:
  /// **'SOLVE TO STOP'**
  String get solveToStop;

  /// No description provided for @answer.
  ///
  /// In en, this message translates to:
  /// **'Answer'**
  String get answer;

  /// No description provided for @snooze.
  ///
  /// In en, this message translates to:
  /// **'Snooze'**
  String get snooze;

  /// No description provided for @stop.
  ///
  /// In en, this message translates to:
  /// **'Stop'**
  String get stop;

  /// No description provided for @shakeToSnooze.
  ///
  /// In en, this message translates to:
  /// **'SHAKE TO SNOOZE'**
  String get shakeToSnooze;

  /// No description provided for @shakeToStop.
  ///
  /// In en, this message translates to:
  /// **'SHAKE TO STOP'**
  String get shakeToStop;

  /// No description provided for @shakeHard.
  ///
  /// In en, this message translates to:
  /// **'Shake the phone hard until the bar fills.'**
  String get shakeHard;

  /// No description provided for @cantShake.
  ///
  /// In en, this message translates to:
  /// **'Can\'t shake? Solve a sum instead'**
  String get cantShake;

  /// No description provided for @pairsToSnooze.
  ///
  /// In en, this message translates to:
  /// **'FIND THE PAIRS TO SNOOZE'**
  String get pairsToSnooze;

  /// No description provided for @pairsToStop.
  ///
  /// In en, this message translates to:
  /// **'FIND THE PAIRS TO STOP'**
  String get pairsToStop;

  /// No description provided for @typeToSnooze.
  ///
  /// In en, this message translates to:
  /// **'TYPE THIS TO SNOOZE'**
  String get typeToSnooze;

  /// No description provided for @typeToStop.
  ///
  /// In en, this message translates to:
  /// **'TYPE THIS TO STOP'**
  String get typeToStop;

  /// No description provided for @scanToSnooze.
  ///
  /// In en, this message translates to:
  /// **'SCAN YOUR CODE TO SNOOZE'**
  String get scanToSnooze;

  /// No description provided for @scanToStop.
  ///
  /// In en, this message translates to:
  /// **'SCAN YOUR CODE TO STOP'**
  String get scanToStop;

  /// No description provided for @ringAgainUnless.
  ///
  /// In en, this message translates to:
  /// **'I\'ll ring again in {n} minutes unless you tap below.'**
  String ringAgainUnless(int n);

  /// No description provided for @imUp.
  ///
  /// In en, this message translates to:
  /// **'I\'m up'**
  String get imUp;

  /// No description provided for @snoozeMin.
  ///
  /// In en, this message translates to:
  /// **'Snooze {n} min'**
  String snoozeMin(int n);

  /// No description provided for @snoozeMinLeft.
  ///
  /// In en, this message translates to:
  /// **'Snooze {n} min · {left} left'**
  String snoozeMinLeft(int n, int left);

  /// No description provided for @noSnoozesLeft.
  ///
  /// In en, this message translates to:
  /// **'No snoozes left'**
  String get noSnoozesLeft;

  /// No description provided for @stopThenOpen.
  ///
  /// In en, this message translates to:
  /// **'Stop · then open'**
  String get stopThenOpen;

  /// No description provided for @startingSong.
  ///
  /// In en, this message translates to:
  /// **'Starting your song'**
  String get startingSong;

  /// No description provided for @wayToStop.
  ///
  /// In en, this message translates to:
  /// **'{way} to stop'**
  String wayToStop(String way);

  /// No description provided for @wayToSnooze.
  ///
  /// In en, this message translates to:
  /// **'{way} to snooze'**
  String wayToSnooze(String way);

  /// No description provided for @ringsForMore.
  ///
  /// In en, this message translates to:
  /// **'Rings for {n} more seconds'**
  String ringsForMore(int n);

  /// No description provided for @leftToRing.
  ///
  /// In en, this message translates to:
  /// **'left to ring'**
  String get leftToRing;

  /// No description provided for @wayVolumeButtons.
  ///
  /// In en, this message translates to:
  /// **'Volume buttons'**
  String get wayVolumeButtons;

  /// No description provided for @wayShake.
  ///
  /// In en, this message translates to:
  /// **'Shake the phone'**
  String get wayShake;

  /// No description provided for @taskNothing.
  ///
  /// In en, this message translates to:
  /// **'Nothing'**
  String get taskNothing;

  /// No description provided for @taskSum.
  ///
  /// In en, this message translates to:
  /// **'Solve a sum'**
  String get taskSum;

  /// No description provided for @taskShake.
  ///
  /// In en, this message translates to:
  /// **'Shake 30 times'**
  String get taskShake;

  /// No description provided for @taskMemory.
  ///
  /// In en, this message translates to:
  /// **'Memory game'**
  String get taskMemory;

  /// No description provided for @taskPhrase.
  ///
  /// In en, this message translates to:
  /// **'Type a phrase'**
  String get taskPhrase;

  /// No description provided for @taskScan.
  ///
  /// In en, this message translates to:
  /// **'Scan a code'**
  String get taskScan;

  /// No description provided for @noLimit.
  ///
  /// In en, this message translates to:
  /// **'no limit'**
  String get noLimit;

  /// No description provided for @upToTimes.
  ///
  /// In en, this message translates to:
  /// **'up to {n}×'**
  String upToTimes(int n);

  /// No description provided for @shorterEachTime.
  ///
  /// In en, this message translates to:
  /// **'{n} min shorter each time'**
  String shorterEachTime(int n);

  /// No description provided for @autoSnoozeAfter.
  ///
  /// In en, this message translates to:
  /// **'snoozes by itself after {n} min'**
  String autoSnoozeAfter(int n);

  /// No description provided for @card.
  ///
  /// In en, this message translates to:
  /// **'Card'**
  String get card;

  /// No description provided for @hiddenCard.
  ///
  /// In en, this message translates to:
  /// **'Hidden card'**
  String get hiddenCard;

  /// No description provided for @phrase1.
  ///
  /// In en, this message translates to:
  /// **'I am awake and the day is mine'**
  String get phrase1;

  /// No description provided for @phrase2.
  ///
  /// In en, this message translates to:
  /// **'If not now, then when'**
  String get phrase2;

  /// No description provided for @phrase3.
  ///
  /// In en, this message translates to:
  /// **'Good morning to me and everyone I love'**
  String get phrase3;

  /// No description provided for @phrase4.
  ///
  /// In en, this message translates to:
  /// **'My feet are on the floor and I am up'**
  String get phrase4;

  /// No description provided for @phrase5.
  ///
  /// In en, this message translates to:
  /// **'Today I begin again'**
  String get phrase5;

  /// No description provided for @notQuiteWords.
  ///
  /// In en, this message translates to:
  /// **'Not quite, check each word.'**
  String get notQuiteWords;

  /// No description provided for @typeItHere.
  ///
  /// In en, this message translates to:
  /// **'Type it here'**
  String get typeItHere;

  /// No description provided for @differentCode.
  ///
  /// In en, this message translates to:
  /// **'That\'s a different code.'**
  String get differentCode;

  /// No description provided for @cameraUnavailable.
  ///
  /// In en, this message translates to:
  /// **'The camera isn\'t available.'**
  String get cameraUnavailable;

  /// No description provided for @cantScan.
  ///
  /// In en, this message translates to:
  /// **'Can\'t scan? Solve a sum instead'**
  String get cantScan;

  /// No description provided for @saveCodeToScan.
  ///
  /// In en, this message translates to:
  /// **'Save a code to scan'**
  String get saveCodeToScan;

  /// No description provided for @saveCodeHint.
  ///
  /// In en, this message translates to:
  /// **'Point the camera at a barcode or QR code somewhere you have to walk to, like a box in the kitchen or toothpaste in the bathroom. To stop the alarm, you\'ll scan it again.'**
  String get saveCodeHint;

  /// No description provided for @cameraUnavailableSettings.
  ///
  /// In en, this message translates to:
  /// **'The camera isn\'t available. Allow camera access in Settings.'**
  String get cameraUnavailableSettings;

  /// No description provided for @gentleToGo.
  ///
  /// In en, this message translates to:
  /// **'Gentle wake-up · {n} min to go'**
  String gentleToGo(int n);

  /// No description provided for @previewBody.
  ///
  /// In en, this message translates to:
  /// **'Preview · {body}'**
  String previewBody(String body);

  /// No description provided for @snoozedBody.
  ///
  /// In en, this message translates to:
  /// **'Snoozed: {body}'**
  String snoozedBody(String body);

  /// No description provided for @areYouUp.
  ///
  /// In en, this message translates to:
  /// **'Are you up?'**
  String get areYouUp;

  /// No description provided for @tapImUp.
  ///
  /// In en, this message translates to:
  /// **'Tap “I\'m up” to stop'**
  String get tapImUp;

  /// No description provided for @volume.
  ///
  /// In en, this message translates to:
  /// **'Volume'**
  String get volume;

  /// No description provided for @wakeCheckOn.
  ///
  /// In en, this message translates to:
  /// **'Wake-up check on'**
  String get wakeCheckOn;

  /// No description provided for @stopsAtOnce.
  ///
  /// In en, this message translates to:
  /// **'Stops at once'**
  String get stopsAtOnce;

  /// No description provided for @ringsAgainIfNotUp.
  ///
  /// In en, this message translates to:
  /// **'Rings again if you\'re not up'**
  String get ringsAgainIfNotUp;

  /// No description provided for @openAppAfter.
  ///
  /// In en, this message translates to:
  /// **'Open an app after'**
  String get openAppAfter;

  /// No description provided for @noTask.
  ///
  /// In en, this message translates to:
  /// **'No task'**
  String get noTask;

  /// No description provided for @codeSaved.
  ///
  /// In en, this message translates to:
  /// **'Code saved'**
  String get codeSaved;

  /// No description provided for @tapToSaveDifferent.
  ///
  /// In en, this message translates to:
  /// **'Tap to save a different one'**
  String get tapToSaveDifferent;

  /// No description provided for @controlsHeading.
  ///
  /// In en, this message translates to:
  /// **'CONTROLS'**
  String get controlsHeading;

  /// No description provided for @onScreen.
  ///
  /// In en, this message translates to:
  /// **'On screen'**
  String get onScreen;

  /// No description provided for @taskHeading.
  ///
  /// In en, this message translates to:
  /// **'TASK'**
  String get taskHeading;

  /// No description provided for @none.
  ///
  /// In en, this message translates to:
  /// **'None'**
  String get none;

  /// No description provided for @snoozeSentence.
  ///
  /// In en, this message translates to:
  /// **'Five more minutes? Choose how long, how often, and what it takes.'**
  String get snoozeSentence;

  /// No description provided for @settingsHeading.
  ///
  /// In en, this message translates to:
  /// **'SETTINGS'**
  String get settingsHeading;

  /// No description provided for @snoozeTime.
  ///
  /// In en, this message translates to:
  /// **'Snooze time'**
  String get snoozeTime;

  /// No description provided for @snoozeTimeHint.
  ///
  /// In en, this message translates to:
  /// **'How long the first snooze lasts'**
  String get snoozeTimeHint;

  /// No description provided for @shortenSnoozes.
  ///
  /// In en, this message translates to:
  /// **'Shorten extra snoozes'**
  String get shortenSnoozes;

  /// No description provided for @shortenSnoozesHint.
  ///
  /// In en, this message translates to:
  /// **'Each snooze after the first is this much shorter'**
  String get shortenSnoozesHint;

  /// No description provided for @autoSnooze.
  ///
  /// In en, this message translates to:
  /// **'Auto-snooze'**
  String get autoSnooze;

  /// No description provided for @autoSnoozeHint.
  ///
  /// In en, this message translates to:
  /// **'If you don\'t touch it, it snoozes by itself after'**
  String get autoSnoozeHint;

  /// No description provided for @never.
  ///
  /// In en, this message translates to:
  /// **'Never'**
  String get never;

  /// No description provided for @snoozeLimit.
  ///
  /// In en, this message translates to:
  /// **'Snooze limit'**
  String get snoozeLimit;

  /// No description provided for @snoozeLimitHint.
  ///
  /// In en, this message translates to:
  /// **'How many times you can snooze'**
  String get snoozeLimitHint;

  /// No description provided for @unlimited.
  ///
  /// In en, this message translates to:
  /// **'Unlimited'**
  String get unlimited;

  /// No description provided for @useSnoozeFromSettings.
  ///
  /// In en, this message translates to:
  /// **'Use the snooze from Settings'**
  String get useSnoozeFromSettings;

  /// No description provided for @stopSentence.
  ///
  /// In en, this message translates to:
  /// **'How you turn the alarm off, and what you must do first.'**
  String get stopSentence;

  /// No description provided for @shabbatNoTask.
  ///
  /// In en, this message translates to:
  /// **'On Shabbat and festivals alarms stop by themselves and never ask for a task.'**
  String get shabbatNoTask;

  /// No description provided for @volumeSentence.
  ///
  /// In en, this message translates to:
  /// **'How loud it rings, and how gently it gets there.'**
  String get volumeSentence;

  /// No description provided for @openAfterAlarm.
  ///
  /// In en, this message translates to:
  /// **'Open after the alarm'**
  String get openAfterAlarm;

  /// No description provided for @pickAnApp.
  ///
  /// In en, this message translates to:
  /// **'Pick an app'**
  String get pickAnApp;

  /// No description provided for @orPasteLink.
  ///
  /// In en, this message translates to:
  /// **'Or paste a link: https://…'**
  String get orPasteLink;

  /// No description provided for @useThisLink.
  ///
  /// In en, this message translates to:
  /// **'Use this link'**
  String get useThisLink;

  /// No description provided for @noAppsFound.
  ///
  /// In en, this message translates to:
  /// **'No apps found.'**
  String get noAppsFound;

  /// No description provided for @weather.
  ///
  /// In en, this message translates to:
  /// **'Weather'**
  String get weather;

  /// No description provided for @news.
  ///
  /// In en, this message translates to:
  /// **'News'**
  String get news;

  /// No description provided for @usePhoneVolume.
  ///
  /// In en, this message translates to:
  /// **'Use the phone\'s alarm volume'**
  String get usePhoneVolume;

  /// No description provided for @setsPhoneVolume.
  ///
  /// In en, this message translates to:
  /// **'Sets the phone\'s alarm volume while it rings, then puts it back.'**
  String get setsPhoneVolume;

  /// No description provided for @fadeInOff.
  ///
  /// In en, this message translates to:
  /// **'Fade in: off, full volume at once'**
  String get fadeInOff;

  /// No description provided for @fadeInOver.
  ///
  /// In en, this message translates to:
  /// **'Fade in over {span}'**
  String fadeInOver(String span);

  /// No description provided for @fadeOutOff.
  ///
  /// In en, this message translates to:
  /// **'Fade out: off'**
  String get fadeOutOff;

  /// No description provided for @fadeOutOver.
  ///
  /// In en, this message translates to:
  /// **'Fade out over the last {span}'**
  String fadeOutOver(String span);

  /// No description provided for @fadesExplain.
  ///
  /// In en, this message translates to:
  /// **'Fading out happens as the alarm stops by itself. If the fades are longer than the alarm rings, both shrink to fit.'**
  String get fadesExplain;

  /// No description provided for @soundSoftChime.
  ///
  /// In en, this message translates to:
  /// **'Soft chime'**
  String get soundSoftChime;

  /// No description provided for @soundMorningRise.
  ///
  /// In en, this message translates to:
  /// **'Morning rise'**
  String get soundMorningRise;

  /// No description provided for @soundClassicBeep.
  ///
  /// In en, this message translates to:
  /// **'Classic beep'**
  String get soundClassicBeep;

  /// No description provided for @calmCity.
  ///
  /// In en, this message translates to:
  /// **'Quiet city morning'**
  String get calmCity;

  /// No description provided for @calmBirds.
  ///
  /// In en, this message translates to:
  /// **'Birds at dawn'**
  String get calmBirds;

  /// No description provided for @calmWaves.
  ///
  /// In en, this message translates to:
  /// **'Waves on the shore'**
  String get calmWaves;

  /// No description provided for @calmRain.
  ///
  /// In en, this message translates to:
  /// **'Soft rain'**
  String get calmRain;

  /// No description provided for @calmStream.
  ///
  /// In en, this message translates to:
  /// **'Forest stream'**
  String get calmStream;

  /// No description provided for @calmWind.
  ///
  /// In en, this message translates to:
  /// **'Gentle wind'**
  String get calmWind;

  /// No description provided for @calmFire.
  ///
  /// In en, this message translates to:
  /// **'Crackling fire'**
  String get calmFire;

  /// No description provided for @calmNight.
  ///
  /// In en, this message translates to:
  /// **'Summer night'**
  String get calmNight;

  /// No description provided for @publicDomain.
  ///
  /// In en, this message translates to:
  /// **'Public domain'**
  String get publicDomain;

  /// No description provided for @phoneVolume.
  ///
  /// In en, this message translates to:
  /// **'Phone volume'**
  String get phoneVolume;

  /// No description provided for @fadesIn.
  ///
  /// In en, this message translates to:
  /// **'fades in {span}'**
  String fadesIn(String span);

  /// No description provided for @fadesOut.
  ///
  /// In en, this message translates to:
  /// **'fades out {span}'**
  String fadesOut(String span);

  /// No description provided for @noFade.
  ///
  /// In en, this message translates to:
  /// **'no fade'**
  String get noFade;

  /// No description provided for @minSecShort.
  ///
  /// In en, this message translates to:
  /// **'{m} min {s} s'**
  String minSecShort(int m, int s);

  /// No description provided for @happensRings.
  ///
  /// In en, this message translates to:
  /// **'Rings'**
  String get happensRings;

  /// No description provided for @happensStopped.
  ///
  /// In en, this message translates to:
  /// **'You stop it'**
  String get happensStopped;

  /// No description provided for @happensSnoozed.
  ///
  /// In en, this message translates to:
  /// **'You snooze it'**
  String get happensSnoozed;

  /// No description provided for @happensAutoStopped.
  ///
  /// In en, this message translates to:
  /// **'It stops by itself'**
  String get happensAutoStopped;

  /// No description provided for @eventLower.
  ///
  /// In en, this message translates to:
  /// **'event'**
  String get eventLower;

  /// No description provided for @appTest.
  ///
  /// In en, this message translates to:
  /// **'Quando? test'**
  String get appTest;

  /// No description provided for @pushoverConnected.
  ///
  /// In en, this message translates to:
  /// **'Pushover is connected'**
  String get pushoverConnected;

  /// No description provided for @webhookConnected.
  ///
  /// In en, this message translates to:
  /// **'Webhook is connected'**
  String get webhookConnected;

  /// No description provided for @pushoverSaid.
  ///
  /// In en, this message translates to:
  /// **'Pushover said {code}: {body}'**
  String pushoverSaid(int code, String body);

  /// No description provided for @couldNotReachPushover.
  ///
  /// In en, this message translates to:
  /// **'Could not reach Pushover ({error})'**
  String couldNotReachPushover(String error);

  /// No description provided for @itAnswered.
  ///
  /// In en, this message translates to:
  /// **'It answered {code}'**
  String itAnswered(int code);

  /// No description provided for @couldNotReachIt.
  ///
  /// In en, this message translates to:
  /// **'Could not reach it ({error})'**
  String couldNotReachIt(String error);

  /// No description provided for @calendarNotAllowed.
  ///
  /// In en, this message translates to:
  /// **'Calendar access was not allowed.'**
  String get calendarNotAllowed;

  /// No description provided for @playlist.
  ///
  /// In en, this message translates to:
  /// **'Playlist'**
  String get playlist;

  /// No description provided for @songCount.
  ///
  /// In en, this message translates to:
  /// **'{n, plural, =1{1 song} other{{n} songs}}'**
  String songCount(int n);

  /// No description provided for @spotifySaidNo.
  ///
  /// In en, this message translates to:
  /// **'Spotify said no. In the Spotify dashboard, tick Web API for Quando? and add your account under User Management.'**
  String get spotifySaidNo;

  /// No description provided for @serviceDidntAnswer.
  ///
  /// In en, this message translates to:
  /// **'{service} didn\'t answer ({code}).'**
  String serviceDidntAnswer(String service, int code);

  /// No description provided for @youTubeSaidNo.
  ///
  /// In en, this message translates to:
  /// **'YouTube said no. Check your Google account is a test user of the Quando project.'**
  String get youTubeSaidNo;

  /// No description provided for @event.
  ///
  /// In en, this message translates to:
  /// **'Event'**
  String get event;

  /// No description provided for @eventEnds.
  ///
  /// In en, this message translates to:
  /// **'{title} (ends)'**
  String eventEnds(String title);

  /// No description provided for @foundSoundsDevices.
  ///
  /// In en, this message translates to:
  /// **'Found {s} sounds and {d} devices.'**
  String foundSoundsDevices(int s, int d);

  /// No description provided for @sentCheckDevices.
  ///
  /// In en, this message translates to:
  /// **'Sent. Check your other devices.'**
  String get sentCheckDevices;

  /// No description provided for @sentTo.
  ///
  /// In en, this message translates to:
  /// **'Sent to {name}.'**
  String sentTo(String name);

  /// No description provided for @zapierHowTo.
  ///
  /// In en, this message translates to:
  /// **'In Zapier, make a Zap that starts with “Webhooks by Zapier → Catch Hook”, then paste its URL here.'**
  String get zapierHowTo;

  /// No description provided for @catchHookUrl.
  ///
  /// In en, this message translates to:
  /// **'Catch Hook URL'**
  String get catchHookUrl;

  /// No description provided for @iftttHowTo.
  ///
  /// In en, this message translates to:
  /// **'In IFTTT, make an applet that starts with “Webhooks → Receive a web request with a JSON payload”. Use the same event name here. Your key is on ifttt.com/maker_webhooks/settings.'**
  String get iftttHowTo;

  /// No description provided for @eventName.
  ///
  /// In en, this message translates to:
  /// **'Event name'**
  String get eventName;

  /// No description provided for @webhooksKey.
  ///
  /// In en, this message translates to:
  /// **'Webhooks key'**
  String get webhooksKey;

  /// No description provided for @webhookHowTo.
  ///
  /// In en, this message translates to:
  /// **'Quando? sends a JSON POST to this address.'**
  String get webhookHowTo;

  /// No description provided for @connectionsSentence.
  ///
  /// In en, this message translates to:
  /// **'Tell your other apps and devices when an alarm rings, stops or snoozes.'**
  String get connectionsSentence;

  /// No description provided for @pushWhenRings.
  ///
  /// In en, this message translates to:
  /// **'Send a push when an alarm rings'**
  String get pushWhenRings;

  /// No description provided for @pushWhenRingsHint.
  ///
  /// In en, this message translates to:
  /// **'To your other phones, tablet, watch or computer'**
  String get pushWhenRingsHint;

  /// No description provided for @yourUserKey.
  ///
  /// In en, this message translates to:
  /// **'Your user key'**
  String get yourUserKey;

  /// No description provided for @appToken.
  ///
  /// In en, this message translates to:
  /// **'App token'**
  String get appToken;

  /// No description provided for @soundAndDevicesHeading.
  ///
  /// In en, this message translates to:
  /// **'SOUND AND DEVICES'**
  String get soundAndDevicesHeading;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading…'**
  String get loading;

  /// No description provided for @loadFromPushover.
  ///
  /// In en, this message translates to:
  /// **'Load from Pushover'**
  String get loadFromPushover;

  /// No description provided for @soundItPlays.
  ///
  /// In en, this message translates to:
  /// **'Sound it plays'**
  String get soundItPlays;

  /// No description provided for @myPushoverDefault.
  ///
  /// In en, this message translates to:
  /// **'My Pushover default'**
  String get myPushoverDefault;

  /// No description provided for @pushoverOwnSounds.
  ///
  /// In en, this message translates to:
  /// **'Your own sounds appear here after you upload them at pushover.net/sounds.'**
  String get pushoverOwnSounds;

  /// No description provided for @allMyDevices.
  ///
  /// In en, this message translates to:
  /// **'All my devices'**
  String get allMyDevices;

  /// No description provided for @pushoverOnThisPhone.
  ///
  /// In en, this message translates to:
  /// **'Install the Pushover app on this phone too and it rings here with your Pushover sound.'**
  String get pushoverOnThisPhone;

  /// No description provided for @priority.
  ///
  /// In en, this message translates to:
  /// **'Priority'**
  String get priority;

  /// No description provided for @priorityNormal.
  ///
  /// In en, this message translates to:
  /// **'Normal'**
  String get priorityNormal;

  /// No description provided for @priorityHigh.
  ///
  /// In en, this message translates to:
  /// **'High: through quiet hours'**
  String get priorityHigh;

  /// No description provided for @priorityEmergency.
  ///
  /// In en, this message translates to:
  /// **'Emergency: repeats until acknowledged'**
  String get priorityEmergency;

  /// No description provided for @sending.
  ///
  /// In en, this message translates to:
  /// **'Sending…'**
  String get sending;

  /// No description provided for @sendATest.
  ///
  /// In en, this message translates to:
  /// **'Send a test'**
  String get sendATest;

  /// No description provided for @findUserKey.
  ///
  /// In en, this message translates to:
  /// **'Find my user key'**
  String get findUserKey;

  /// No description provided for @makeAppToken.
  ///
  /// In en, this message translates to:
  /// **'Make an app token'**
  String get makeAppToken;

  /// No description provided for @webhooksHeading.
  ///
  /// In en, this message translates to:
  /// **'ZAPIER, IFTTT AND WEBHOOKS'**
  String get webhooksHeading;

  /// No description provided for @webhooksExplain.
  ///
  /// In en, this message translates to:
  /// **'Start anything when an alarm rings or you stop it: turn on lights, log your wake-up time, message someone.'**
  String get webhooksExplain;

  /// No description provided for @sendWhenAlarm.
  ///
  /// In en, this message translates to:
  /// **'Send when the alarm:'**
  String get sendWhenAlarm;

  /// No description provided for @pauseOnShabbat.
  ///
  /// In en, this message translates to:
  /// **'Pause on Shabbat and festivals'**
  String get pauseOnShabbat;

  /// No description provided for @pauseOnShabbatHint.
  ///
  /// In en, this message translates to:
  /// **'Nothing is sent for alarms from candle lighting to Havdalah'**
  String get pauseOnShabbatHint;

  /// No description provided for @webhookPayloadNote.
  ///
  /// In en, this message translates to:
  /// **'Each message carries: event (ring, stopped, snoozed, auto_stopped), title, body, time, shabbat and snoozes. Keys stay on this phone.'**
  String get webhookPayloadNote;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @tomorrow.
  ///
  /// In en, this message translates to:
  /// **'Tomorrow'**
  String get tomorrow;

  /// No description provided for @notAWebAddress.
  ///
  /// In en, this message translates to:
  /// **'That doesn\'t look like a web address starting with https://'**
  String get notAWebAddress;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @phoneLanguage.
  ///
  /// In en, this message translates to:
  /// **'The phone\'s language'**
  String get phoneLanguage;

  /// No description provided for @ringQuote.
  ///
  /// In en, this message translates to:
  /// **'If not now, when?'**
  String get ringQuote;

  /// No description provided for @ringQuoteBy.
  ///
  /// In en, this message translates to:
  /// **'Hillel'**
  String get ringQuoteBy;

  /// No description provided for @quotesTitle.
  ///
  /// In en, this message translates to:
  /// **'Quotes about time'**
  String get quotesTitle;

  /// No description provided for @quotesHint.
  ///
  /// In en, this message translates to:
  /// **'Pick where they come from. You get one for each part of the day; tap a quote to see another.'**
  String get quotesHint;

  /// No description provided for @quotesOff.
  ///
  /// In en, this message translates to:
  /// **'Off'**
  String get quotesOff;

  /// No description provided for @quoteSongs.
  ///
  /// In en, this message translates to:
  /// **'Songs'**
  String get quoteSongs;

  /// No description provided for @quoteMovies.
  ///
  /// In en, this message translates to:
  /// **'Movies'**
  String get quoteMovies;

  /// No description provided for @quoteLiterature.
  ///
  /// In en, this message translates to:
  /// **'Books and poems'**
  String get quoteLiterature;

  /// No description provided for @quoteTanakh.
  ///
  /// In en, this message translates to:
  /// **'Tanakh (Hebrew Bible)'**
  String get quoteTanakh;

  /// No description provided for @quoteSages.
  ///
  /// In en, this message translates to:
  /// **'Talmud and sages'**
  String get quoteSages;

  /// No description provided for @quoteSpeeches.
  ///
  /// In en, this message translates to:
  /// **'Famous speeches'**
  String get quoteSpeeches;

  /// No description provided for @quotePhilosophy.
  ///
  /// In en, this message translates to:
  /// **'Philosophers'**
  String get quotePhilosophy;

  /// No description provided for @quoteProverbs.
  ///
  /// In en, this message translates to:
  /// **'Proverbs and sayings'**
  String get quoteProverbs;

  /// No description provided for @quotesAlso.
  ///
  /// In en, this message translates to:
  /// **'Also show'**
  String get quotesAlso;

  /// No description provided for @quoteCarnaval.
  ///
  /// In en, this message translates to:
  /// **'Carnaval'**
  String get quoteCarnaval;

  /// No description provided for @quoteCarnavalHint.
  ///
  /// In en, this message translates to:
  /// **'Songs and sayings during Brazil’s Carnaval'**
  String get quoteCarnavalHint;

  /// No description provided for @quoteNearMe.
  ///
  /// In en, this message translates to:
  /// **'Near me'**
  String get quoteNearMe;

  /// No description provided for @quoteNearMeHint.
  ///
  /// In en, this message translates to:
  /// **'Poets and local days where you are, from your time zone and Shabbat city'**
  String get quoteNearMeHint;

  /// No description provided for @quoteSiddur.
  ///
  /// In en, this message translates to:
  /// **'Siddur (prayer book)'**
  String get quoteSiddur;

  /// This week's Torah portion, shown under the Hebrew date in Quando? Shabbat.
  ///
  /// In en, this message translates to:
  /// **'Weekly Torah Portion: {name}'**
  String weeklyParasha(String name);

  /// Under the Jewish edition's name; {name} is Quando?.
  ///
  /// In en, this message translates to:
  /// **'powered by {name}'**
  String poweredBy(String name);

  /// No description provided for @syncTitle.
  ///
  /// In en, this message translates to:
  /// **'Sync my devices'**
  String get syncTitle;

  /// No description provided for @syncHint.
  ///
  /// In en, this message translates to:
  /// **'Sign in with Google to keep alarms and settings the same on all your devices.'**
  String get syncHint;

  /// No description provided for @syncOn.
  ///
  /// In en, this message translates to:
  /// **'On · {email}'**
  String syncOn(String email);

  /// No description provided for @syncWorking.
  ///
  /// In en, this message translates to:
  /// **'Connecting…'**
  String get syncWorking;

  /// No description provided for @syncNotAllowed.
  ///
  /// In en, this message translates to:
  /// **'This account can\'t sync yet. If you signed in with email, confirm it first.'**
  String get syncNotAllowed;

  /// No description provided for @syncFailed.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t connect. Tap to try again.'**
  String get syncFailed;

  /// No description provided for @syncStop.
  ///
  /// In en, this message translates to:
  /// **'Stop syncing'**
  String get syncStop;

  /// No description provided for @syncNotSetUp.
  ///
  /// In en, this message translates to:
  /// **'Sync isn\'t set up in this build yet.'**
  String get syncNotSetUp;

  /// No description provided for @ringTheseAfterAll.
  ///
  /// In en, this message translates to:
  /// **'Ring these after all'**
  String get ringTheseAfterAll;

  /// No description provided for @skipTheseDay.
  ///
  /// In en, this message translates to:
  /// **'Skip these {n} today'**
  String skipTheseDay(int n);

  /// No description provided for @turnOffNamed.
  ///
  /// In en, this message translates to:
  /// **'Turn off “{name}”'**
  String turnOffNamed(String name);

  /// No description provided for @turnOnNamed.
  ///
  /// In en, this message translates to:
  /// **'Turn on “{name}”'**
  String turnOnNamed(String name);

  /// No description provided for @turnedOffNamed.
  ///
  /// In en, this message translates to:
  /// **'Turned off “{name}”'**
  String turnedOffNamed(String name);

  /// No description provided for @removeTimeFrom.
  ///
  /// In en, this message translates to:
  /// **'Remove “{time}” from “{name}”'**
  String removeTimeFrom(String time, String name);

  /// No description provided for @removedTimeFrom.
  ///
  /// In en, this message translates to:
  /// **'Removed “{time}” from “{name}”'**
  String removedTimeFrom(String time, String name);

  /// No description provided for @moveToGroup.
  ///
  /// In en, this message translates to:
  /// **'Move to a group'**
  String get moveToGroup;

  /// No description provided for @inGroupMove.
  ///
  /// In en, this message translates to:
  /// **'In “{group}”, move'**
  String inGroupMove(String group);

  /// No description provided for @movedToGroup.
  ///
  /// In en, this message translates to:
  /// **'Moved to “{group}”'**
  String movedToGroup(String group);

  /// No description provided for @deleteNamed.
  ///
  /// In en, this message translates to:
  /// **'Delete “{name}”'**
  String deleteNamed(String name);

  /// No description provided for @signInWithGoogle.
  ///
  /// In en, this message translates to:
  /// **'Sign in with Google'**
  String get signInWithGoogle;

  /// No description provided for @signOut.
  ///
  /// In en, this message translates to:
  /// **'Sign out'**
  String get signOut;

  /// No description provided for @signInWithEmail.
  ///
  /// In en, this message translates to:
  /// **'Sign in with email'**
  String get signInWithEmail;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get signIn;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create account'**
  String get createAccount;

  /// No description provided for @haveAccount.
  ///
  /// In en, this message translates to:
  /// **'I have an account'**
  String get haveAccount;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get forgotPassword;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @passwordResetSent.
  ///
  /// In en, this message translates to:
  /// **'We sent you a link to choose a new password.'**
  String get passwordResetSent;

  /// No description provided for @emailCheckInbox.
  ///
  /// In en, this message translates to:
  /// **'We sent a link to {email}. Open it, then come back and tap “I’ve confirmed”.'**
  String emailCheckInbox(String email);

  /// No description provided for @emailConfirmed.
  ///
  /// In en, this message translates to:
  /// **'I’ve confirmed'**
  String get emailConfirmed;

  /// No description provided for @emailNotYet.
  ///
  /// In en, this message translates to:
  /// **'Not confirmed yet. Open the link in the email first.'**
  String get emailNotYet;

  /// No description provided for @emailSendAgain.
  ///
  /// In en, this message translates to:
  /// **'Send the email again'**
  String get emailSendAgain;

  /// No description provided for @emailSentAgain.
  ///
  /// In en, this message translates to:
  /// **'Sent. Check your inbox and spam.'**
  String get emailSentAgain;

  /// No description provided for @emailInvalid.
  ///
  /// In en, this message translates to:
  /// **'That doesn’t look like an email address.'**
  String get emailInvalid;

  /// No description provided for @emailWrong.
  ///
  /// In en, this message translates to:
  /// **'Wrong email or password.'**
  String get emailWrong;

  /// No description provided for @emailInUse.
  ///
  /// In en, this message translates to:
  /// **'There’s already an account with this email. Sign in instead, or use Google if you made it with Google.'**
  String get emailInUse;

  /// No description provided for @passwordWeak.
  ///
  /// In en, this message translates to:
  /// **'Choose a password of at least 6 characters.'**
  String get passwordWeak;

  /// No description provided for @emailNotSwitchedOn.
  ///
  /// In en, this message translates to:
  /// **'Email sign-in isn’t switched on yet.'**
  String get emailNotSwitchedOn;

  /// No description provided for @tooManyTries.
  ///
  /// In en, this message translates to:
  /// **'Too many tries. Wait a few minutes.'**
  String get tooManyTries;

  /// No description provided for @spotifyLibrary.
  ///
  /// In en, this message translates to:
  /// **'Spotify'**
  String get spotifyLibrary;

  /// No description provided for @spotifyLibrarySignIn.
  ///
  /// In en, this message translates to:
  /// **'Playlists, liked songs and search'**
  String get spotifyLibrarySignIn;

  /// No description provided for @spotifyLibraryOn.
  ///
  /// In en, this message translates to:
  /// **'Connected · hold to sign out'**
  String get spotifyLibraryOn;

  /// No description provided for @spotifyLoginError.
  ///
  /// In en, this message translates to:
  /// **'Spotify sign-in didn\'t work: {reason}'**
  String spotifyLoginError(String reason);

  /// No description provided for @googleSignInError.
  ///
  /// In en, this message translates to:
  /// **'Google sign-in didn\'t work: {reason}'**
  String googleSignInError(String reason);

  /// No description provided for @searchSongsHint.
  ///
  /// In en, this message translates to:
  /// **'Search songs, artists, playlists'**
  String get searchSongsHint;

  /// No description provided for @nothingFound.
  ///
  /// In en, this message translates to:
  /// **'Nothing found for “{query}”.'**
  String nothingFound(String query);

  /// No description provided for @deliveryTitle.
  ///
  /// In en, this message translates to:
  /// **'Delivery'**
  String get deliveryTitle;

  /// No description provided for @deliveryLocal.
  ///
  /// In en, this message translates to:
  /// **'Local audio'**
  String get deliveryLocal;

  /// No description provided for @deliveryBoth.
  ///
  /// In en, this message translates to:
  /// **'Both'**
  String get deliveryBoth;

  /// No description provided for @deliveryConnect.
  ///
  /// In en, this message translates to:
  /// **'Connect Pushover'**
  String get deliveryConnect;

  /// No description provided for @deliveryLoadFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not load sounds and devices. Try again.'**
  String get deliveryLoadFailed;

  /// No description provided for @deliveryBothHint.
  ///
  /// In en, this message translates to:
  /// **'Local audio still rings if Pushover fails.'**
  String get deliveryBothHint;

  /// No description provided for @deliveryPushHint.
  ///
  /// In en, this message translates to:
  /// **'Pushover only. This device must be online when it fires.'**
  String get deliveryPushHint;

  /// No description provided for @deliveryFallback.
  ///
  /// In en, this message translates to:
  /// **'Local audio is kept if Pushover is disconnected or paused.'**
  String get deliveryFallback;

  /// No description provided for @deliveryReset.
  ///
  /// In en, this message translates to:
  /// **'Use existing settings'**
  String get deliveryReset;

  /// No description provided for @beforeShabbat.
  ///
  /// In en, this message translates to:
  /// **'Before Shabbat'**
  String get beforeShabbat;

  /// No description provided for @preparationReminders.
  ///
  /// In en, this message translates to:
  /// **'Preparation reminders'**
  String get preparationReminders;

  /// No description provided for @skipThisWeek.
  ///
  /// In en, this message translates to:
  /// **'Skip this week'**
  String get skipThisWeek;

  /// No description provided for @restoreThisWeek.
  ///
  /// In en, this message translates to:
  /// **'Restore this week'**
  String get restoreThisWeek;

  /// No description provided for @allAlarms.
  ///
  /// In en, this message translates to:
  /// **'All alarms'**
  String get allAlarms;

  /// No description provided for @timesAndSound.
  ///
  /// In en, this message translates to:
  /// **'Times & sound'**
  String get timesAndSound;

  /// No description provided for @changeCity.
  ///
  /// In en, this message translates to:
  /// **'Change city'**
  String get changeCity;

  /// No description provided for @useMyLocation.
  ///
  /// In en, this message translates to:
  /// **'Use my location'**
  String get useMyLocation;

  /// No description provided for @locationUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Location is temporarily unavailable. Try again or choose a city.'**
  String get locationUnavailable;

  /// No description provided for @locationReview.
  ///
  /// In en, this message translates to:
  /// **'Confirm this location'**
  String get locationReview;

  /// No description provided for @locationDeviceOnly.
  ///
  /// In en, this message translates to:
  /// **'This location is saved only on this device. Check the timezone and Israel setting before using these times.'**
  String get locationDeviceOnly;

  /// No description provided for @timesIn.
  ///
  /// In en, this message translates to:
  /// **'{city} · {zone} · city time'**
  String timesIn(String city, String zone);

  /// No description provided for @preparationOff.
  ///
  /// In en, this message translates to:
  /// **'Preparation reminders are off. Havdalah and ordinary alarms are unchanged.'**
  String get preparationOff;

  /// No description provided for @preparationSkipped.
  ///
  /// In en, this message translates to:
  /// **'Preparation reminders are skipped this week. Your weekly settings are kept.'**
  String get preparationSkipped;

  /// No description provided for @shabbatControls.
  ///
  /// In en, this message translates to:
  /// **'Shabbat controls'**
  String get shabbatControls;

  /// No description provided for @duringAfterShabbat.
  ///
  /// In en, this message translates to:
  /// **'During / after Shabbat'**
  String get duringAfterShabbat;

  /// No description provided for @locationCoordinates.
  ///
  /// In en, this message translates to:
  /// **'Latitude {latitude} · longitude {longitude}'**
  String locationCoordinates(String latitude, String longitude);

  /// No description provided for @currentLocation.
  ///
  /// In en, this message translates to:
  /// **'Current location'**
  String get currentLocation;

  /// No description provided for @testPushoverSound.
  ///
  /// In en, this message translates to:
  /// **'Test sound on Pushover'**
  String get testPushoverSound;

  /// No description provided for @pushoverSoundTestHint.
  ///
  /// In en, this message translates to:
  /// **'Plays the selected sound on your selected Pushover devices. Silent and quiet-hour settings still apply.'**
  String get pushoverSoundTestHint;

  /// No description provided for @pushoverShareDevices.
  ///
  /// In en, this message translates to:
  /// **'Share credentials with my devices'**
  String get pushoverShareDevices;

  /// No description provided for @pushoverShareHint.
  ///
  /// In en, this message translates to:
  /// **'Your Pushover user key and app token can follow your signed-in account across Quando? and Matai?.'**
  String get pushoverShareHint;

  /// No description provided for @pushoverShareQueued.
  ///
  /// In en, this message translates to:
  /// **'Credentials queued for your signed-in devices.'**
  String get pushoverShareQueued;

  /// No description provided for @pushoverShareSignIn.
  ///
  /// In en, this message translates to:
  /// **'Sign in to the same app account on each device to share Pushover credentials.'**
  String get pushoverShareSignIn;

  /// No description provided for @smartHomeHeading.
  ///
  /// In en, this message translates to:
  /// **'Smart home'**
  String get smartHomeHeading;

  /// No description provided for @smartHomeHint.
  ///
  /// In en, this message translates to:
  /// **'Run Tuya scenes directly, or connect your own Home Assistant or Node-RED automations.'**
  String get smartHomeHint;

  /// No description provided for @shareServices.
  ///
  /// In en, this message translates to:
  /// **'Share service connections'**
  String get shareServices;

  /// No description provided for @shareServicesHint.
  ///
  /// In en, this message translates to:
  /// **'Use the same app account on your devices to share Pushover, Tuya, Spotify library and automation connections. YouTube and device permissions may still need approval on each device.'**
  String get shareServicesHint;

  /// No description provided for @tuyaSetupHint.
  ///
  /// In en, this message translates to:
  /// **'Use your linked Tuya developer project. Enter its data center, Access ID, Access Secret and the UID shown under Link App Account. No Home Assistant needed.'**
  String get tuyaSetupHint;

  /// No description provided for @tuyaDataCenter.
  ///
  /// In en, this message translates to:
  /// **'Data center'**
  String get tuyaDataCenter;

  /// No description provided for @tuyaUserId.
  ///
  /// In en, this message translates to:
  /// **'Linked account UID'**
  String get tuyaUserId;

  /// No description provided for @tuyaAccessId.
  ///
  /// In en, this message translates to:
  /// **'Access ID / Client ID'**
  String get tuyaAccessId;

  /// No description provided for @tuyaAccessSecret.
  ///
  /// In en, this message translates to:
  /// **'Access Secret / Client Secret'**
  String get tuyaAccessSecret;

  /// No description provided for @tuyaLoadScenes.
  ///
  /// In en, this message translates to:
  /// **'Load scenes'**
  String get tuyaLoadScenes;

  /// No description provided for @tuyaNoScenes.
  ///
  /// In en, this message translates to:
  /// **'No available Tap-to-Run scenes found. Check the linked account, data center and scene API permissions.'**
  String get tuyaNoScenes;

  /// No description provided for @tuyaRunNow.
  ///
  /// In en, this message translates to:
  /// **'Run scene now'**
  String get tuyaRunNow;

  /// No description provided for @tuyaRunConfirm.
  ///
  /// In en, this message translates to:
  /// **'Run this scene on your Tuya devices now?'**
  String get tuyaRunConfirm;

  /// No description provided for @tuyaSent.
  ///
  /// In en, this message translates to:
  /// **'Tuya accepted the scene command. Check your devices.'**
  String get tuyaSent;

  /// No description provided for @tuyaFailed.
  ///
  /// In en, this message translates to:
  /// **'Tuya could not complete the request. Check project permissions, data center and subscription. Error:'**
  String get tuyaFailed;

  /// No description provided for @tuyaAlarmScene.
  ///
  /// In en, this message translates to:
  /// **'Tuya scene when this alarm rings'**
  String get tuyaAlarmScene;

  /// No description provided for @homeAssistantHowTo.
  ///
  /// In en, this message translates to:
  /// **'Create a Home Assistant automation with a Webhook trigger accepting POST and JSON. Paste its URL here. Use the alarm event (ring, stopped, snoozed or auto_stopped) to choose your actions. New devices receive this connection switched off.'**
  String get homeAssistantHowTo;

  /// No description provided for @nodeRedHowTo.
  ///
  /// In en, this message translates to:
  /// **'Use a Node-RED HTTP In node accepting POST, followed by your automation and an HTTP Response node. Paste the endpoint here. Local HTTP hubs and HTTPS endpoints are supported.'**
  String get nodeRedHowTo;

  /// No description provided for @smartHomeConnect.
  ///
  /// In en, this message translates to:
  /// **'Connect a smart-home service'**
  String get smartHomeConnect;

  /// No description provided for @automationTestHint.
  ///
  /// In en, this message translates to:
  /// **'Testing runs the connected automation immediately.'**
  String get automationTestHint;

  /// No description provided for @smartHomeDeviceOn.
  ///
  /// In en, this message translates to:
  /// **'Run smart-home alarm actions on this device'**
  String get smartHomeDeviceOn;

  /// No description provided for @smartHomeDeviceHint.
  ///
  /// In en, this message translates to:
  /// **'Choose one device to run your automations. Connections are shared; this switch stays on this device.'**
  String get smartHomeDeviceHint;

  /// No description provided for @smartHomeDeviceOff.
  ///
  /// In en, this message translates to:
  /// **'Alarm actions are off on this device. Enable them in Connections; manual scene tests still work.'**
  String get smartHomeDeviceOff;

  /// No description provided for @homeDisplay.
  ///
  /// In en, this message translates to:
  /// **'Home display'**
  String get homeDisplay;

  /// No description provided for @skyDay.
  ///
  /// In en, this message translates to:
  /// **'Day'**
  String get skyDay;

  /// No description provided for @skyDayNight.
  ///
  /// In en, this message translates to:
  /// **'Day + night'**
  String get skyDayNight;

  /// No description provided for @showMoonPhase.
  ///
  /// In en, this message translates to:
  /// **'Moon phase'**
  String get showMoonPhase;

  /// No description provided for @weatherLabel.
  ///
  /// In en, this message translates to:
  /// **'Weather'**
  String get weatherLabel;

  /// No description provided for @skyLabel.
  ///
  /// In en, this message translates to:
  /// **'Sky'**
  String get skyLabel;

  /// No description provided for @weatherSwipeHint.
  ///
  /// In en, this message translates to:
  /// **'Swipe between sky and weather'**
  String get weatherSwipeHint;

  /// No description provided for @parashaHeading.
  ///
  /// In en, this message translates to:
  /// **'Weekly parashah'**
  String get parashaHeading;

  /// No description provided for @dailyStudyHeading.
  ///
  /// In en, this message translates to:
  /// **'Daily learning'**
  String get dailyStudyHeading;

  /// No description provided for @courseDaf.
  ///
  /// In en, this message translates to:
  /// **'Daf Yomi'**
  String get courseDaf;

  /// No description provided for @courseRambam1.
  ///
  /// In en, this message translates to:
  /// **'Rambam · 1 chapter/day'**
  String get courseRambam1;

  /// No description provided for @courseRambam3.
  ///
  /// In en, this message translates to:
  /// **'Rambam · 3 chapters/day'**
  String get courseRambam3;

  /// No description provided for @courseMitzvot.
  ///
  /// In en, this message translates to:
  /// **'Sefer HaMitzvot'**
  String get courseMitzvot;

  /// No description provided for @courseMishnah.
  ///
  /// In en, this message translates to:
  /// **'Mishnah Yomit'**
  String get courseMishnah;

  /// No description provided for @courseNach.
  ///
  /// In en, this message translates to:
  /// **'Nach Yomi'**
  String get courseNach;

  /// No description provided for @moonriseLabel.
  ///
  /// In en, this message translates to:
  /// **'Moonrise'**
  String get moonriseLabel;

  /// No description provided for @moonsetLabel.
  ///
  /// In en, this message translates to:
  /// **'Moonset'**
  String get moonsetLabel;

  /// No description provided for @nightfallLabel.
  ///
  /// In en, this message translates to:
  /// **'Nightfall'**
  String get nightfallLabel;

  /// No description provided for @moonAlwaysUp.
  ///
  /// In en, this message translates to:
  /// **'Moon above horizon all day'**
  String get moonAlwaysUp;

  /// No description provided for @moonAlwaysDown.
  ///
  /// In en, this message translates to:
  /// **'Moon below horizon all day'**
  String get moonAlwaysDown;

  /// No description provided for @noRiseToday.
  ///
  /// In en, this message translates to:
  /// **'No rise today'**
  String get noRiseToday;

  /// No description provided for @noSetToday.
  ///
  /// In en, this message translates to:
  /// **'No set today'**
  String get noSetToday;

  /// No description provided for @moonNew.
  ///
  /// In en, this message translates to:
  /// **'New moon'**
  String get moonNew;

  /// No description provided for @moonWaxingCrescent.
  ///
  /// In en, this message translates to:
  /// **'Waxing crescent'**
  String get moonWaxingCrescent;

  /// No description provided for @moonFirstQuarter.
  ///
  /// In en, this message translates to:
  /// **'First quarter'**
  String get moonFirstQuarter;

  /// No description provided for @moonWaxingGibbous.
  ///
  /// In en, this message translates to:
  /// **'Waxing gibbous'**
  String get moonWaxingGibbous;

  /// No description provided for @moonFull.
  ///
  /// In en, this message translates to:
  /// **'Full moon'**
  String get moonFull;

  /// No description provided for @moonWaningGibbous.
  ///
  /// In en, this message translates to:
  /// **'Waning gibbous'**
  String get moonWaningGibbous;

  /// No description provided for @moonLastQuarter.
  ///
  /// In en, this message translates to:
  /// **'Last quarter'**
  String get moonLastQuarter;

  /// No description provided for @moonWaningCrescent.
  ///
  /// In en, this message translates to:
  /// **'Waning crescent'**
  String get moonWaningCrescent;

  /// No description provided for @moonIlluminated.
  ///
  /// In en, this message translates to:
  /// **'illuminated'**
  String get moonIlluminated;

  /// No description provided for @weatherClear.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get weatherClear;

  /// No description provided for @weatherClouds.
  ///
  /// In en, this message translates to:
  /// **'Cloudy'**
  String get weatherClouds;

  /// No description provided for @weatherRain.
  ///
  /// In en, this message translates to:
  /// **'Rain'**
  String get weatherRain;

  /// No description provided for @weatherSnow.
  ///
  /// In en, this message translates to:
  /// **'Snow / sleet'**
  String get weatherSnow;

  /// No description provided for @weatherFog.
  ///
  /// In en, this message translates to:
  /// **'Fog'**
  String get weatherFog;

  /// No description provided for @weatherThunder.
  ///
  /// In en, this message translates to:
  /// **'Thunderstorms'**
  String get weatherThunder;

  /// No description provided for @weatherUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Weather is temporarily unavailable'**
  String get weatherUnavailable;

  /// No description provided for @weatherCached.
  ///
  /// In en, this message translates to:
  /// **'Saved forecast'**
  String get weatherCached;

  /// No description provided for @weatherUpdated.
  ///
  /// In en, this message translates to:
  /// **'Updated'**
  String get weatherUpdated;

  /// No description provided for @weatherForecast.
  ///
  /// In en, this message translates to:
  /// **'Forecast'**
  String get weatherForecast;

  /// No description provided for @weatherThunderExpected.
  ///
  /// In en, this message translates to:
  /// **'Thunderstorms forecast'**
  String get weatherThunderExpected;

  /// No description provided for @learningUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Connect to load this month’s learning schedule'**
  String get learningUnavailable;

  /// No description provided for @festivalReading.
  ///
  /// In en, this message translates to:
  /// **'Festival Torah reading'**
  String get festivalReading;

  /// No description provided for @learningCalendarSource.
  ///
  /// In en, this message translates to:
  /// **'Learning calendar · Hebcal · CC BY 4.0'**
  String get learningCalendarSource;

  /// No description provided for @weatherSource.
  ///
  /// In en, this message translates to:
  /// **'Forecast · MET Norway · CC BY 4.0'**
  String get weatherSource;

  /// No description provided for @weatherConsent.
  ///
  /// In en, this message translates to:
  /// **'Weather for your selected city. Uses rounded coordinates with MET Norway.'**
  String get weatherConsent;

  /// No description provided for @learningConsent.
  ///
  /// In en, this message translates to:
  /// **'Rambam and other study schedules are loaded from Hebcal and saved for offline use.'**
  String get learningConsent;

  /// No description provided for @homeRefresh.
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get homeRefresh;

  /// No description provided for @skyTimezone.
  ///
  /// In en, this message translates to:
  /// **'My timezone'**
  String get skyTimezone;

  /// No description provided for @skyShabbat.
  ///
  /// In en, this message translates to:
  /// **'Shabbat city'**
  String get skyShabbat;

  /// No description provided for @skyReferenceCity.
  ///
  /// In en, this message translates to:
  /// **'Timezone reference city'**
  String get skyReferenceCity;

  /// No description provided for @skyChooseCity.
  ///
  /// In en, this message translates to:
  /// **'Choose sky city'**
  String get skyChooseCity;

  /// No description provided for @skyCityExplain.
  ///
  /// In en, this message translates to:
  /// **'Sun and Moon use this city’s coordinates. Your Shabbat city and alarm timezone stay as chosen.'**
  String get skyCityExplain;

  /// No description provided for @skySun.
  ///
  /// In en, this message translates to:
  /// **'Sun today'**
  String get skySun;

  /// No description provided for @skyMoon.
  ///
  /// In en, this message translates to:
  /// **'Moon today'**
  String get skyMoon;

  /// No description provided for @moonAboveHorizon.
  ///
  /// In en, this message translates to:
  /// **'Moon above the horizon'**
  String get moonAboveHorizon;

  /// No description provided for @moonBelowHorizon.
  ///
  /// In en, this message translates to:
  /// **'Moon below the horizon'**
  String get moonBelowHorizon;

  /// No description provided for @moonNextNew.
  ///
  /// In en, this message translates to:
  /// **'Next new moon'**
  String get moonNextNew;

  /// No description provided for @moonNextFull.
  ///
  /// In en, this message translates to:
  /// **'Next full moon'**
  String get moonNextFull;

  /// No description provided for @locationServicesOff.
  ///
  /// In en, this message translates to:
  /// **'Location Services is off. Turn it on in Settings or choose a city.'**
  String get locationServicesOff;

  /// No description provided for @locationDenied.
  ///
  /// In en, this message translates to:
  /// **'Location access was denied. Allow it in Settings or choose a city.'**
  String get locationDenied;

  /// No description provided for @locationTimedOut.
  ///
  /// In en, this message translates to:
  /// **'No location fix yet. On Mac, keep Wi-Fi on and try again, or choose a city.'**
  String get locationTimedOut;

  /// No description provided for @locationTimeZoneUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Use a city in the selected timezone, or follow your device timezone before using location.'**
  String get locationTimeZoneUnavailable;

  /// No description provided for @locationSettings.
  ///
  /// In en, this message translates to:
  /// **'Open location settings'**
  String get locationSettings;

  /// No description provided for @locationLooking.
  ///
  /// In en, this message translates to:
  /// **'Getting a location fix…'**
  String get locationLooking;

  /// No description provided for @skyMoonDisplay.
  ///
  /// In en, this message translates to:
  /// **'Show Moon: rise, set and phase'**
  String get skyMoonDisplay;

  /// No description provided for @tuyaConsumerPending.
  ///
  /// In en, this message translates to:
  /// **'Account sign-in isn’t available in this build yet. If you already have a Tuya developer project, use Advanced setup.'**
  String get tuyaConsumerPending;

  /// No description provided for @tuyaAdvanced.
  ///
  /// In en, this message translates to:
  /// **'Advanced setup'**
  String get tuyaAdvanced;

  /// No description provided for @tuyaSignInTitle.
  ///
  /// In en, this message translates to:
  /// **'Sign in with your Smart Life account'**
  String get tuyaSignInTitle;

  /// No description provided for @tuyaSignInHint.
  ///
  /// In en, this message translates to:
  /// **'Use the same country, email or phone and password as in the Smart Life or Tuya Smart app. The account must already be linked to your Tuya project. The password goes only to Tuya and is never saved.'**
  String get tuyaSignInHint;

  /// No description provided for @tuyaCountryCode.
  ///
  /// In en, this message translates to:
  /// **'Country calling code (Brazil 55, US 1)'**
  String get tuyaCountryCode;

  /// No description provided for @tuyaAccount.
  ///
  /// In en, this message translates to:
  /// **'Smart Life email or phone'**
  String get tuyaAccount;

  /// No description provided for @tuyaPassword.
  ///
  /// In en, this message translates to:
  /// **'Smart Life password'**
  String get tuyaPassword;

  /// No description provided for @tuyaSignIn.
  ///
  /// In en, this message translates to:
  /// **'Sign in and load scenes'**
  String get tuyaSignIn;

  /// No description provided for @tuyaRelayUrl.
  ///
  /// In en, this message translates to:
  /// **'Quando Tuya relay address (https)'**
  String get tuyaRelayUrl;

  /// No description provided for @tuyaRelayHint.
  ///
  /// In en, this message translates to:
  /// **'Use the country, email or phone and password of your Smart Life or Tuya Smart account. They go to Quando’s Tuya relay once and are not saved. You need to be signed in to your Quando account.'**
  String get tuyaRelayHint;

  /// No description provided for @tuyaGoogleHint.
  ///
  /// In en, this message translates to:
  /// **'Signed in to Smart Life with Google or Apple? In Smart Life, tap Forgot Password to set a password, then use it here.'**
  String get tuyaGoogleHint;

  /// No description provided for @tuyaLinked.
  ///
  /// In en, this message translates to:
  /// **'Smart Life account linked'**
  String get tuyaLinked;

  /// No description provided for @tuyaUnlink.
  ///
  /// In en, this message translates to:
  /// **'Unlink'**
  String get tuyaUnlink;

  /// No description provided for @tuyaNeedsAccount.
  ///
  /// In en, this message translates to:
  /// **'Sign in to your Quando account in Settings first.'**
  String get tuyaNeedsAccount;

  /// No description provided for @roshHodeshHeading.
  ///
  /// In en, this message translates to:
  /// **'Rosh Hodesh'**
  String get roshHodeshHeading;

  /// No description provided for @roshHodeshExplain.
  ///
  /// In en, this message translates to:
  /// **'Show the next Hebrew month’s first day or two days on Home.'**
  String get roshHodeshExplain;

  /// No description provided for @roshHodeshNext.
  ///
  /// In en, this message translates to:
  /// **'Next Rosh Hodesh'**
  String get roshHodeshNext;

  /// No description provided for @roshHodeshBegins.
  ///
  /// In en, this message translates to:
  /// **'Begins at sunset on'**
  String get roshHodeshBegins;

  /// No description provided for @openParashaSefaria.
  ///
  /// In en, this message translates to:
  /// **'Read this Torah portion on Sefaria'**
  String get openParashaSefaria;

  /// No description provided for @skyMyLocation.
  ///
  /// In en, this message translates to:
  /// **'My location'**
  String get skyMyLocation;

  /// No description provided for @skyLocationLocalTimes.
  ///
  /// In en, this message translates to:
  /// **'Sky times use this location’s timezone. Your alarm-clock timezone and Shabbat city stay unchanged. Saved only on this device.'**
  String get skyLocationLocalTimes;

  /// No description provided for @musicRingDurationHint.
  ///
  /// In en, this message translates to:
  /// **'Playback follows this alarm’s Ring for setting and stops with Stop or Snooze.'**
  String get musicRingDurationHint;

  /// No description provided for @musicBackupPlaying.
  ///
  /// In en, this message translates to:
  /// **'Music could not start. The local alarm sound is playing.'**
  String get musicBackupPlaying;

  /// No description provided for @desktopMusicConnect.
  ///
  /// In en, this message translates to:
  /// **'Connect the {service} app'**
  String desktopMusicConnect(String service);

  /// No description provided for @desktopMusicOn.
  ///
  /// In en, this message translates to:
  /// **'Connected to {service} · hold to disconnect'**
  String desktopMusicOn(String service);

  /// No description provided for @musicSongs.
  ///
  /// In en, this message translates to:
  /// **'Songs'**
  String get musicSongs;

  /// No description provided for @noMusicSongs.
  ///
  /// In en, this message translates to:
  /// **'No songs found in your Music library.'**
  String get noMusicSongs;

  /// No description provided for @serviceConnectUnavailable.
  ///
  /// In en, this message translates to:
  /// **'{service} links open after the alarm'**
  String serviceConnectUnavailable(String service);

  /// No description provided for @soundCloudWidgetNote.
  ///
  /// In en, this message translates to:
  /// **'Add a public link'**
  String get soundCloudWidgetNote;

  /// No description provided for @youtubePlayerHint.
  ///
  /// In en, this message translates to:
  /// **'YouTube plays video in a visible player. If it is hidden or cannot play, the local alarm continues.'**
  String get youtubePlayerHint;

  /// No description provided for @musicPreviewFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not play this sound. Check your connection or try another track or station.'**
  String get musicPreviewFailed;

  /// No description provided for @skyMoonPhase.
  ///
  /// In en, this message translates to:
  /// **'Moon phase'**
  String get skyMoonPhase;

  /// No description provided for @skyMoonDetailsDisplay.
  ///
  /// In en, this message translates to:
  /// **'Add a Moon phase page'**
  String get skyMoonDetailsDisplay;

  /// No description provided for @skyMoonDetailsHint.
  ///
  /// In en, this message translates to:
  /// **'Swipe to it, or tap the Moon card any time'**
  String get skyMoonDetailsHint;

  /// No description provided for @moonRises.
  ///
  /// In en, this message translates to:
  /// **'Rises'**
  String get moonRises;

  /// No description provided for @moonSets.
  ///
  /// In en, this message translates to:
  /// **'Sets'**
  String get moonSets;

  /// No description provided for @moonLunarDay.
  ///
  /// In en, this message translates to:
  /// **'Day {day} of 29.5 in this lunar month'**
  String moonLunarDay(int day);

  /// No description provided for @moonDetailsOpen.
  ///
  /// In en, this message translates to:
  /// **'Open Moon phase'**
  String get moonDetailsOpen;

  /// No description provided for @musicPlaylists.
  ///
  /// In en, this message translates to:
  /// **'Music playlists'**
  String get musicPlaylists;

  /// No description provided for @videoPlaylists.
  ///
  /// In en, this message translates to:
  /// **'Video playlists'**
  String get videoPlaylists;

  /// No description provided for @likedVideos.
  ///
  /// In en, this message translates to:
  /// **'Liked videos'**
  String get likedVideos;

  /// No description provided for @wholePlaylist.
  ///
  /// In en, this message translates to:
  /// **'Wake up to the whole playlist'**
  String get wholePlaylist;

  /// No description provided for @noSongsInPlaylist.
  ///
  /// In en, this message translates to:
  /// **'No songs here that can play.'**
  String get noSongsInPlaylist;

  /// No description provided for @hebrewNamesHeading.
  ///
  /// In en, this message translates to:
  /// **'Spelling of parasha and month names'**
  String get hebrewNamesHeading;

  /// No description provided for @hebrewNamesIsraeli.
  ///
  /// In en, this message translates to:
  /// **'Israeli'**
  String get hebrewNamesIsraeli;

  /// No description provided for @hebrewNamesAshkenazi.
  ///
  /// In en, this message translates to:
  /// **'Ashkenazi'**
  String get hebrewNamesAshkenazi;

  /// No description provided for @pickFromService.
  ///
  /// In en, this message translates to:
  /// **'Pick from my {service}'**
  String pickFromService(String service);

  /// No description provided for @weatherTonight.
  ///
  /// In en, this message translates to:
  /// **'Tonight'**
  String get weatherTonight;

  /// No description provided for @weatherTomorrowMorning.
  ///
  /// In en, this message translates to:
  /// **'Tomorrow morning'**
  String get weatherTomorrowMorning;

  /// No description provided for @weatherUntilAbout.
  ///
  /// In en, this message translates to:
  /// **'until about {time}'**
  String weatherUntilAbout(String time);

  /// No description provided for @weatherSunBehindClouds.
  ///
  /// In en, this message translates to:
  /// **'Sun behind the clouds'**
  String get weatherSunBehindClouds;

  /// No description provided for @keysLockTitle.
  ///
  /// In en, this message translates to:
  /// **'Keys on your devices'**
  String get keysLockTitle;

  /// No description provided for @keysLockOff.
  ///
  /// In en, this message translates to:
  /// **'Your service keys stay on this device. Choose a sync passphrase to send them, encrypted, to your other devices.'**
  String get keysLockOff;

  /// No description provided for @keysLockOn.
  ///
  /// In en, this message translates to:
  /// **'Your service keys are encrypted with your sync passphrase before they leave this device. Nobody else, not even Google, can read them.'**
  String get keysLockOn;

  /// No description provided for @keysLockWaiting.
  ///
  /// In en, this message translates to:
  /// **'Keys from your other device arrived here, locked. Type your sync passphrase to open them.'**
  String get keysLockWaiting;

  /// No description provided for @keysSetPassphrase.
  ///
  /// In en, this message translates to:
  /// **'Choose passphrase'**
  String get keysSetPassphrase;

  /// No description provided for @keysChangePassphrase.
  ///
  /// In en, this message translates to:
  /// **'Change passphrase'**
  String get keysChangePassphrase;

  /// No description provided for @keysUnlock.
  ///
  /// In en, this message translates to:
  /// **'Unlock keys'**
  String get keysUnlock;

  /// No description provided for @keysStartOver.
  ///
  /// In en, this message translates to:
  /// **'Forgot it? Start over'**
  String get keysStartOver;

  /// No description provided for @keysStartOverHint.
  ///
  /// In en, this message translates to:
  /// **'Starting over sends this device\'s keys with a new passphrase. Your other devices will ask for the new one.'**
  String get keysStartOverHint;

  /// No description provided for @keysPassphrase.
  ///
  /// In en, this message translates to:
  /// **'Sync passphrase'**
  String get keysPassphrase;

  /// No description provided for @keysPassphraseAgain.
  ///
  /// In en, this message translates to:
  /// **'Type it again'**
  String get keysPassphraseAgain;

  /// No description provided for @keysPassphraseShort.
  ///
  /// In en, this message translates to:
  /// **'Use at least {count} characters.'**
  String keysPassphraseShort(int count);

  /// No description provided for @keysPassphraseMismatch.
  ///
  /// In en, this message translates to:
  /// **'The two don\'t match.'**
  String get keysPassphraseMismatch;

  /// No description provided for @keysPassphraseWrong.
  ///
  /// In en, this message translates to:
  /// **'That passphrase doesn\'t open these keys.'**
  String get keysPassphraseWrong;

  /// No description provided for @keysPassphraseNote.
  ///
  /// In en, this message translates to:
  /// **'Write it down: if you forget it, nobody can recover it, and you\'ll type your keys again.'**
  String get keysPassphraseNote;

  /// No description provided for @keysShareNeedsPassphrase.
  ///
  /// In en, this message translates to:
  /// **'Choose a sync passphrase first, under Keys on your devices.'**
  String get keysShareNeedsPassphrase;

  /// No description provided for @settingsAlarmDefaults.
  ///
  /// In en, this message translates to:
  /// **'Alarm defaults'**
  String get settingsAlarmDefaults;

  /// No description provided for @settingsPlacesTime.
  ///
  /// In en, this message translates to:
  /// **'Places & time'**
  String get settingsPlacesTime;

  /// No description provided for @settingsLook.
  ///
  /// In en, this message translates to:
  /// **'Look, language & quotes'**
  String get settingsLook;

  /// No description provided for @settingsAbout.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get settingsAbout;

  /// No description provided for @defaultForNewAlarms.
  ///
  /// In en, this message translates to:
  /// **'Default for new alarms'**
  String get defaultForNewAlarms;

  /// No description provided for @preview.
  ///
  /// In en, this message translates to:
  /// **'Preview'**
  String get preview;

  /// No description provided for @atClock.
  ///
  /// In en, this message translates to:
  /// **'at {time}'**
  String atClock(String time);

  /// No description provided for @connectACalendar.
  ///
  /// In en, this message translates to:
  /// **'Connect a calendar'**
  String get connectACalendar;

  /// No description provided for @newFromReadyMade.
  ///
  /// In en, this message translates to:
  /// **'From a ready-made'**
  String get newFromReadyMade;

  /// No description provided for @newFromReadyMadeHint.
  ///
  /// In en, this message translates to:
  /// **'Sunrise, sunset and other alarms that are already set up for you'**
  String get newFromReadyMadeHint;

  /// No description provided for @calendarSourcesIntro.
  ///
  /// In en, this message translates to:
  /// **'Quando? can ring before and after events in your calendars. Pick where they come from.'**
  String get calendarSourcesIntro;

  /// No description provided for @deviceCalendarsHeading.
  ///
  /// In en, this message translates to:
  /// **'ON THIS DEVICE'**
  String get deviceCalendarsHeading;

  /// No description provided for @deviceCalendarsTitle.
  ///
  /// In en, this message translates to:
  /// **'This device\'s calendar app'**
  String get deviceCalendarsTitle;

  /// No description provided for @deviceCalendarsHint.
  ///
  /// In en, this message translates to:
  /// **'Every account on it: Google, Samsung, Outlook, iCloud, and calendars kept only here.'**
  String get deviceCalendarsHint;

  /// No description provided for @googleCalendarHeading.
  ///
  /// In en, this message translates to:
  /// **'GOOGLE CALENDAR'**
  String get googleCalendarHeading;

  /// No description provided for @googleCalendarSignIn.
  ///
  /// In en, this message translates to:
  /// **'Sign in with Google to read your calendars straight from Google, even when your Google account isn\'t on this device.'**
  String get googleCalendarSignIn;

  /// No description provided for @googleCalendarSignedIn.
  ///
  /// In en, this message translates to:
  /// **'Signed in as {email}'**
  String googleCalendarSignedIn(String email);

  /// No description provided for @googleCalendarSignOut.
  ///
  /// In en, this message translates to:
  /// **'Sign out'**
  String get googleCalendarSignOut;

  /// No description provided for @googleCalendarNotHere.
  ///
  /// In en, this message translates to:
  /// **'Google sign-in isn\'t available on this device yet. Add your Google account in the device\'s settings (Calendar › Accounts) and its calendars appear under this device.'**
  String get googleCalendarNotHere;

  /// No description provided for @googleCalendarUnreachable.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t reach Google Calendar just now. Alarms already set from it still ring.'**
  String get googleCalendarUnreachable;

  /// No description provided for @googleCalendarTwiceHint.
  ///
  /// In en, this message translates to:
  /// **'Calendars this device already shows from the same Google account start off, so nothing rings twice.'**
  String get googleCalendarTwiceHint;

  /// No description provided for @timersTitle.
  ///
  /// In en, this message translates to:
  /// **'Timers'**
  String get timersTitle;

  /// No description provided for @timerStopwatch.
  ///
  /// In en, this message translates to:
  /// **'Stopwatch'**
  String get timerStopwatch;

  /// No description provided for @timerCountdown.
  ///
  /// In en, this message translates to:
  /// **'Timer'**
  String get timerCountdown;

  /// No description provided for @timerSequence.
  ///
  /// In en, this message translates to:
  /// **'Get set'**
  String get timerSequence;

  /// No description provided for @timerStopwatchSub.
  ///
  /// In en, this message translates to:
  /// **'Count up, with laps'**
  String get timerStopwatchSub;

  /// No description provided for @timerCountdownSub.
  ///
  /// In en, this message translates to:
  /// **'Count down, rings at zero'**
  String get timerCountdownSub;

  /// No description provided for @timerSequenceSub.
  ///
  /// In en, this message translates to:
  /// **'Spoken start and marks'**
  String get timerSequenceSub;

  /// No description provided for @timerStart.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get timerStart;

  /// No description provided for @timerPause.
  ///
  /// In en, this message translates to:
  /// **'Pause'**
  String get timerPause;

  /// No description provided for @timerResume.
  ///
  /// In en, this message translates to:
  /// **'Resume'**
  String get timerResume;

  /// No description provided for @timerReset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get timerReset;

  /// No description provided for @timerLap.
  ///
  /// In en, this message translates to:
  /// **'Lap'**
  String get timerLap;

  /// No description provided for @timerTimesUp.
  ///
  /// In en, this message translates to:
  /// **'Time\'s up'**
  String get timerTimesUp;

  /// No description provided for @timerSetTime.
  ///
  /// In en, this message translates to:
  /// **'Set the time'**
  String get timerSetTime;

  /// No description provided for @timerMinutes.
  ///
  /// In en, this message translates to:
  /// **'Minutes'**
  String get timerMinutes;

  /// No description provided for @timerSeconds.
  ///
  /// In en, this message translates to:
  /// **'Seconds'**
  String get timerSeconds;

  /// No description provided for @seqOnYourMarks.
  ///
  /// In en, this message translates to:
  /// **'On your marks'**
  String get seqOnYourMarks;

  /// No description provided for @seqGetSet.
  ///
  /// In en, this message translates to:
  /// **'Get set'**
  String get seqGetSet;

  /// No description provided for @seqGo.
  ///
  /// In en, this message translates to:
  /// **'Go!'**
  String get seqGo;

  /// No description provided for @seqFinish.
  ///
  /// In en, this message translates to:
  /// **'Time!'**
  String get seqFinish;

  /// No description provided for @seqReady.
  ///
  /// In en, this message translates to:
  /// **'Ready'**
  String get seqReady;

  /// No description provided for @seqSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get seqSettings;

  /// No description provided for @seqStartCalls.
  ///
  /// In en, this message translates to:
  /// **'Calls before the start'**
  String get seqStartCalls;

  /// No description provided for @seqStartCallsHelp.
  ///
  /// In en, this message translates to:
  /// **'Said aloud before Go, counted back from the start.'**
  String get seqStartCallsHelp;

  /// No description provided for @seqCallBefore.
  ///
  /// In en, this message translates to:
  /// **'{n, plural, =1{1 second before} other{{n} seconds before}}'**
  String seqCallBefore(int n);

  /// No description provided for @seqAddCall.
  ///
  /// In en, this message translates to:
  /// **'Add a call'**
  String get seqAddCall;

  /// No description provided for @seqCallText.
  ///
  /// In en, this message translates to:
  /// **'What to say'**
  String get seqCallText;

  /// No description provided for @seqGoText.
  ///
  /// In en, this message translates to:
  /// **'At the start, say'**
  String get seqGoText;

  /// No description provided for @seqFinishText.
  ///
  /// In en, this message translates to:
  /// **'At the end, say'**
  String get seqFinishText;

  /// No description provided for @seqLength.
  ///
  /// In en, this message translates to:
  /// **'Length'**
  String get seqLength;

  /// No description provided for @seqNoLimit.
  ///
  /// In en, this message translates to:
  /// **'No limit'**
  String get seqNoLimit;

  /// No description provided for @seqSayEvery.
  ///
  /// In en, this message translates to:
  /// **'Say the time every'**
  String get seqSayEvery;

  /// No description provided for @seqOff.
  ///
  /// In en, this message translates to:
  /// **'Off'**
  String get seqOff;

  /// No description provided for @seqEverySeconds.
  ///
  /// In en, this message translates to:
  /// **'{n, plural, =1{1 second} other{{n} seconds}}'**
  String seqEverySeconds(int n);

  /// No description provided for @seqEveryMinutes.
  ///
  /// In en, this message translates to:
  /// **'{n, plural, =1{1 minute} other{{n} minutes}}'**
  String seqEveryMinutes(int n);

  /// No description provided for @seqFinalCount.
  ///
  /// In en, this message translates to:
  /// **'Count down the last'**
  String get seqFinalCount;

  /// No description provided for @seqMarks.
  ///
  /// In en, this message translates to:
  /// **'Your marks'**
  String get seqMarks;

  /// No description provided for @seqAddMark.
  ///
  /// In en, this message translates to:
  /// **'Add a mark'**
  String get seqAddMark;

  /// No description provided for @seqMarkAt.
  ///
  /// In en, this message translates to:
  /// **'At {time}'**
  String seqMarkAt(String time);

  /// No description provided for @seqSpeak.
  ///
  /// In en, this message translates to:
  /// **'Speak aloud'**
  String get seqSpeak;

  /// No description provided for @seqBeeps.
  ///
  /// In en, this message translates to:
  /// **'Beeps and vibration'**
  String get seqBeeps;

  /// No description provided for @seqSayRemaining.
  ///
  /// In en, this message translates to:
  /// **'Say time left, not time passed'**
  String get seqSayRemaining;

  /// No description provided for @seqPresets.
  ///
  /// In en, this message translates to:
  /// **'Presets'**
  String get seqPresets;

  /// No description provided for @seqPresetRace.
  ///
  /// In en, this message translates to:
  /// **'Race start'**
  String get seqPresetRace;

  /// No description provided for @seqPresetSprint.
  ///
  /// In en, this message translates to:
  /// **'30 s effort'**
  String get seqPresetSprint;

  /// No description provided for @seqPresetRound.
  ///
  /// In en, this message translates to:
  /// **'1 min round'**
  String get seqPresetRound;

  /// No description provided for @seqHintNoLimit.
  ///
  /// In en, this message translates to:
  /// **'After Go it counts up until you stop it.'**
  String get seqHintNoLimit;

  /// No description provided for @seqHintLength.
  ///
  /// In en, this message translates to:
  /// **'After Go it counts down to zero.'**
  String get seqHintLength;

  /// No description provided for @seqWords.
  ///
  /// In en, this message translates to:
  /// **'Words'**
  String get seqWords;

  /// No description provided for @homeEdit.
  ///
  /// In en, this message translates to:
  /// **'Arrange home'**
  String get homeEdit;

  /// No description provided for @homeEditHint.
  ///
  /// In en, this message translates to:
  /// **'Drag the handle to move a card, fold it, or change its size.'**
  String get homeEditHint;

  /// No description provided for @homeReset.
  ///
  /// In en, this message translates to:
  /// **'Reset layout'**
  String get homeReset;

  /// No description provided for @homeMove.
  ///
  /// In en, this message translates to:
  /// **'Move'**
  String get homeMove;

  /// No description provided for @homeExpand.
  ///
  /// In en, this message translates to:
  /// **'Show'**
  String get homeExpand;

  /// No description provided for @homeCollapse.
  ///
  /// In en, this message translates to:
  /// **'Fold'**
  String get homeCollapse;

  /// No description provided for @homeSize.
  ///
  /// In en, this message translates to:
  /// **'Size'**
  String get homeSize;

  /// No description provided for @homeBlockClock.
  ///
  /// In en, this message translates to:
  /// **'CLOCK'**
  String get homeBlockClock;

  /// No description provided for @homeBlockSky.
  ///
  /// In en, this message translates to:
  /// **'SUN, MOON AND WEATHER'**
  String get homeBlockSky;

  /// No description provided for @homeBlockQuick.
  ///
  /// In en, this message translates to:
  /// **'QUICK ALARMS'**
  String get homeBlockQuick;

  /// No description provided for @homeBlockShabbat.
  ///
  /// In en, this message translates to:
  /// **'SHABBAT AND HOLIDAYS'**
  String get homeBlockShabbat;

  /// No description provided for @homePlaceTitle.
  ///
  /// In en, this message translates to:
  /// **'City for the sky'**
  String get homePlaceTitle;

  /// No description provided for @nextAlarmLine.
  ///
  /// In en, this message translates to:
  /// **'Next alarm · {title} {time}'**
  String nextAlarmLine(String title, String time);

  /// No description provided for @showAllAlarms.
  ///
  /// In en, this message translates to:
  /// **'Show all days'**
  String get showAllAlarms;

  /// No description provided for @noAlarmsThatDay.
  ///
  /// In en, this message translates to:
  /// **'Nothing rings this day'**
  String get noAlarmsThatDay;

  /// No description provided for @homeClockSize.
  ///
  /// In en, this message translates to:
  /// **'Clock on home'**
  String get homeClockSize;

  /// No description provided for @sizeSmall.
  ///
  /// In en, this message translates to:
  /// **'Small'**
  String get sizeSmall;

  /// No description provided for @sizeMedium.
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get sizeMedium;

  /// No description provided for @sizeLarge.
  ///
  /// In en, this message translates to:
  /// **'Large'**
  String get sizeLarge;

  /// No description provided for @homeLayout.
  ///
  /// In en, this message translates to:
  /// **'Home layout'**
  String get homeLayout;

  /// No description provided for @homeLayoutClassic.
  ///
  /// In en, this message translates to:
  /// **'Classic'**
  String get homeLayoutClassic;

  /// No description provided for @homeLayoutCards.
  ///
  /// In en, this message translates to:
  /// **'Cards'**
  String get homeLayoutCards;

  /// No description provided for @homeCardsHint.
  ///
  /// In en, this message translates to:
  /// **'Drag a card to move it. Drag its edge or corner to resize it, or pick a size.'**
  String get homeCardsHint;

  /// No description provided for @homeAddCard.
  ///
  /// In en, this message translates to:
  /// **'Add card'**
  String get homeAddCard;

  /// No description provided for @homeOnHome.
  ///
  /// In en, this message translates to:
  /// **'On home'**
  String get homeOnHome;

  /// No description provided for @homeRemoveCard.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get homeRemoveCard;

  /// No description provided for @cardNext.
  ///
  /// In en, this message translates to:
  /// **'Next alarm'**
  String get cardNext;

  /// No description provided for @cardClock.
  ///
  /// In en, this message translates to:
  /// **'Clock and date'**
  String get cardClock;

  /// No description provided for @cardSky.
  ///
  /// In en, this message translates to:
  /// **'Sun, moon and weather'**
  String get cardSky;

  /// No description provided for @cardMoon.
  ///
  /// In en, this message translates to:
  /// **'Moon'**
  String get cardMoon;

  /// No description provided for @cardWeather.
  ///
  /// In en, this message translates to:
  /// **'Weather'**
  String get cardWeather;

  /// No description provided for @cardAlarms.
  ///
  /// In en, this message translates to:
  /// **'Your alarms'**
  String get cardAlarms;

  /// No description provided for @cardQuick.
  ///
  /// In en, this message translates to:
  /// **'Quick alarms'**
  String get cardQuick;

  /// No description provided for @cardTools.
  ///
  /// In en, this message translates to:
  /// **'Stopwatch, countdown and get set'**
  String get cardTools;

  /// No description provided for @cardWorld.
  ///
  /// In en, this message translates to:
  /// **'World clocks'**
  String get cardWorld;

  /// No description provided for @cardWeek.
  ///
  /// In en, this message translates to:
  /// **'This week'**
  String get cardWeek;

  /// No description provided for @cardShabbat.
  ///
  /// In en, this message translates to:
  /// **'Shabbat and holidays'**
  String get cardShabbat;

  /// No description provided for @ringAtEventReminders.
  ///
  /// In en, this message translates to:
  /// **'Ring at the event\'s own reminders'**
  String get ringAtEventReminders;

  /// No description provided for @ringAtEventRemindersHint.
  ///
  /// In en, this message translates to:
  /// **'The reminders set in your calendar app ring here as loud alarms, with this alarm\'s sound.'**
  String get ringAtEventRemindersHint;

  /// No description provided for @atEventReminders.
  ///
  /// In en, this message translates to:
  /// **'at the event\'s reminders'**
  String get atEventReminders;

  /// No description provided for @everyEventReminderLoud.
  ///
  /// In en, this message translates to:
  /// **'Ring loud at every event\'s own reminders'**
  String get everyEventReminderLoud;

  /// No description provided for @loudNotificationsHeading.
  ///
  /// In en, this message translates to:
  /// **'LOUD CALENDAR NOTIFICATIONS'**
  String get loudNotificationsHeading;

  /// No description provided for @loudNotificationsTitle.
  ///
  /// In en, this message translates to:
  /// **'Make calendar notifications loud'**
  String get loudNotificationsTitle;

  /// No description provided for @loudNotificationsHint.
  ///
  /// In en, this message translates to:
  /// **'When a calendar app shows a reminder, Quando? rings it as an alarm, even with the phone on silent.'**
  String get loudNotificationsHint;

  /// No description provided for @loudNotificationsDisclosureTitle.
  ///
  /// In en, this message translates to:
  /// **'Let Quando? read calendar notifications?'**
  String get loudNotificationsDisclosureTitle;

  /// No description provided for @loudNotificationsDisclosure.
  ///
  /// In en, this message translates to:
  /// **'To ring your calendar reminders out loud, Quando? needs notification access. It only looks at notifications from the calendar apps you pick, reads their title and text on this phone to show them on the alarm, and never stores or sends them anywhere. You can turn this off at any time.'**
  String get loudNotificationsDisclosure;

  /// No description provided for @loudNotificationsAgree.
  ///
  /// In en, this message translates to:
  /// **'Agree and continue'**
  String get loudNotificationsAgree;

  /// No description provided for @loudNotificationsNoAccess.
  ///
  /// In en, this message translates to:
  /// **'Notification access is off. Turn Quando? on in the list that opens.'**
  String get loudNotificationsNoAccess;

  /// No description provided for @loudNotificationsAllow.
  ///
  /// In en, this message translates to:
  /// **'Allow'**
  String get loudNotificationsAllow;

  /// No description provided for @loudNotificationsNoApps.
  ///
  /// In en, this message translates to:
  /// **'No supported calendar app found on this phone.'**
  String get loudNotificationsNoApps;

  /// No description provided for @loudNotificationsTwiceNote.
  ///
  /// In en, this message translates to:
  /// **'Events that already have a Quando? calendar alarm ring only once.'**
  String get loudNotificationsTwiceNote;

  /// No description provided for @loudNotificationsShabbatNote.
  ///
  /// In en, this message translates to:
  /// **'Quiet during Shabbat and festivals.'**
  String get loudNotificationsShabbatNote;

  /// No description provided for @busyMode.
  ///
  /// In en, this message translates to:
  /// **'Busy mode'**
  String get busyMode;

  /// No description provided for @busyModeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Do Not Disturb and auto-replies while you\'re busy'**
  String get busyModeSubtitle;

  /// No description provided for @busyIntro.
  ///
  /// In en, this message translates to:
  /// **'While you\'re busy, Quando? can quiet the phone and answer messages for you. Alarms still ring.'**
  String get busyIntro;

  /// No description provided for @busyIosFocus.
  ///
  /// In en, this message translates to:
  /// **'On iPhone and iPad, apps can\'t turn on Focus or answer messages. In the Shortcuts app, add an automation \"When Quando? opens\" or a time of day that turns on a Focus, and set the Focus to auto-reply.'**
  String get busyIosFocus;

  /// No description provided for @busyWhileHeading.
  ///
  /// In en, this message translates to:
  /// **'WHILE YOU\'RE BUSY'**
  String get busyWhileHeading;

  /// No description provided for @busyDnd.
  ///
  /// In en, this message translates to:
  /// **'Do Not Disturb'**
  String get busyDnd;

  /// No description provided for @busyDndHint.
  ///
  /// In en, this message translates to:
  /// **'Priority only: calls and messages stay quiet, alarms still ring. Back to normal when it ends.'**
  String get busyDndHint;

  /// No description provided for @busyDndNoAccess.
  ///
  /// In en, this message translates to:
  /// **'Quando? isn\'t allowed to change Do Not Disturb yet.'**
  String get busyDndNoAccess;

  /// No description provided for @busyReplies.
  ///
  /// In en, this message translates to:
  /// **'Answer messages'**
  String get busyReplies;

  /// No description provided for @busyRepliesHint.
  ///
  /// In en, this message translates to:
  /// **'Once per person, with your text, through the app\'s own Reply button. Android only.'**
  String get busyRepliesHint;

  /// No description provided for @busyRepliesDisclosureTitle.
  ///
  /// In en, this message translates to:
  /// **'Let Quando? answer messages?'**
  String get busyRepliesDisclosureTitle;

  /// No description provided for @busyRepliesDisclosure.
  ///
  /// In en, this message translates to:
  /// **'To answer for you, Quando? needs notification access. Only while you\'re busy, it looks at message notifications from the apps you pick, reads the sender\'s name on this phone, and sends your text once through the app\'s own Reply button. Messages are never stored or sent anywhere else. Group chats are skipped unless you allow them.'**
  String get busyRepliesDisclosure;

  /// No description provided for @busyReplyText.
  ///
  /// In en, this message translates to:
  /// **'Your answer'**
  String get busyReplyText;

  /// No description provided for @busyReplyTextHint.
  ///
  /// In en, this message translates to:
  /// **'{until} becomes the time Busy mode ends.'**
  String busyReplyTextHint(String until);

  /// No description provided for @busyReplyDefault.
  ///
  /// In en, this message translates to:
  /// **'I\'m busy right now and will answer after {until}.'**
  String busyReplyDefault(String until);

  /// No description provided for @busyGroups.
  ///
  /// In en, this message translates to:
  /// **'Answer in group chats too'**
  String get busyGroups;

  /// No description provided for @busyGroupsHint.
  ///
  /// In en, this message translates to:
  /// **'Off: groups are never answered.'**
  String get busyGroupsHint;

  /// No description provided for @busyRepliesOnShabbat.
  ///
  /// In en, this message translates to:
  /// **'Answer during Shabbat and festivals'**
  String get busyRepliesOnShabbat;

  /// No description provided for @busyAskRabbi.
  ///
  /// In en, this message translates to:
  /// **'Off by default. Ask your rabbi before turning this on for Shabbat.'**
  String get busyAskRabbi;

  /// No description provided for @busyWhenHeading.
  ///
  /// In en, this message translates to:
  /// **'WHEN YOU\'RE BUSY'**
  String get busyWhenHeading;

  /// No description provided for @busyWhenHint.
  ///
  /// In en, this message translates to:
  /// **'Turn on \"Busy during these events\" on a calendar alarm, or \"Busy after it rings\" on an alarm.'**
  String get busyWhenHint;

  /// No description provided for @busyDuringLock.
  ///
  /// In en, this message translates to:
  /// **'Busy while lock mode is on'**
  String get busyDuringLock;

  /// No description provided for @busyNoneComing.
  ///
  /// In en, this message translates to:
  /// **'Nothing busy in the next 7 days.'**
  String get busyNoneComing;

  /// No description provided for @busyDuringEvents.
  ///
  /// In en, this message translates to:
  /// **'Busy during these events'**
  String get busyDuringEvents;

  /// No description provided for @busyDuringEventsHint.
  ///
  /// In en, this message translates to:
  /// **'Busy mode from each event\'s start to its end.'**
  String get busyDuringEventsHint;

  /// No description provided for @busySettings.
  ///
  /// In en, this message translates to:
  /// **'Busy mode settings'**
  String get busySettings;

  /// No description provided for @busyAfterRing.
  ///
  /// In en, this message translates to:
  /// **'Busy after it rings'**
  String get busyAfterRing;

  /// No description provided for @busyAfterRingHint.
  ///
  /// In en, this message translates to:
  /// **'Do Not Disturb and auto-replies for a while, e.g. a workout or a nap.'**
  String get busyAfterRingHint;

  /// No description provided for @shareCard.
  ///
  /// In en, this message translates to:
  /// **'Share your morning'**
  String get shareCard;

  /// No description provided for @shareCardSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Today\'s sky and quote, or your own photo, for Stories and status'**
  String get shareCardSubtitle;

  /// No description provided for @shareAppMissing.
  ///
  /// In en, this message translates to:
  /// **'That app isn\'t on this phone.'**
  String get shareAppMissing;

  /// No description provided for @shareAsIs.
  ///
  /// In en, this message translates to:
  /// **'Share as it is'**
  String get shareAsIs;

  /// No description provided for @shareTapQuote.
  ///
  /// In en, this message translates to:
  /// **'Tap the quote for another one.'**
  String get shareTapQuote;

  /// No description provided for @shareStory.
  ///
  /// In en, this message translates to:
  /// **'Story'**
  String get shareStory;

  /// No description provided for @shareSquare.
  ///
  /// In en, this message translates to:
  /// **'Square'**
  String get shareSquare;

  /// No description provided for @shareYourWords.
  ///
  /// In en, this message translates to:
  /// **'Your own words (optional)'**
  String get shareYourWords;

  /// No description provided for @shareYourWordsHint.
  ///
  /// In en, this message translates to:
  /// **'Instead of today\'s quote'**
  String get shareYourWordsHint;

  /// No description provided for @shareYourPhoto.
  ///
  /// In en, this message translates to:
  /// **'Your photo'**
  String get shareYourPhoto;

  /// No description provided for @shareOtherPhoto.
  ///
  /// In en, this message translates to:
  /// **'Another photo'**
  String get shareOtherPhoto;

  /// No description provided for @shareSkyBack.
  ///
  /// In en, this message translates to:
  /// **'Today\'s sky instead'**
  String get shareSkyBack;

  /// No description provided for @shareYourVideo.
  ///
  /// In en, this message translates to:
  /// **'Your video'**
  String get shareYourVideo;

  /// No description provided for @shareInstagramStory.
  ///
  /// In en, this message translates to:
  /// **'Instagram Stories'**
  String get shareInstagramStory;

  /// No description provided for @shareWhatsApp.
  ///
  /// In en, this message translates to:
  /// **'WhatsApp: status or chat'**
  String get shareWhatsApp;

  /// No description provided for @shareMore.
  ///
  /// In en, this message translates to:
  /// **'More apps'**
  String get shareMore;

  /// No description provided for @shareYouPost.
  ///
  /// In en, this message translates to:
  /// **'Quando? opens the app with your card loaded. You choose where it goes and tap Post yourself.'**
  String get shareYouPost;

  /// No description provided for @shareAndroidFirst.
  ///
  /// In en, this message translates to:
  /// **'Sharing comes to iPhone and iPad soon.'**
  String get shareAndroidFirst;

  /// No description provided for @songSaved.
  ///
  /// In en, this message translates to:
  /// **'“{name}” saved as an alarm sound'**
  String songSaved(String name);

  /// No description provided for @shareToQuando.
  ///
  /// In en, this message translates to:
  /// **'Share a song to Quando?'**
  String get shareToQuando;

  /// No description provided for @shareToQuandoHint.
  ///
  /// In en, this message translates to:
  /// **'In YouTube, YouTube Music, Spotify, SoundCloud or Apple Music, tap Share, then Quando?. It becomes an alarm sound that plays in its app.'**
  String get shareToQuandoHint;

  /// No description provided for @askOption.
  ///
  /// In en, this message translates to:
  /// **'Say or type it'**
  String get askOption;

  /// No description provided for @askOptionHint.
  ///
  /// In en, this message translates to:
  /// **'“Tomorrow at 6”, “30 min before sunrise”'**
  String get askOptionHint;

  /// No description provided for @askHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. wake me 30 min before sunrise on weekdays'**
  String get askHint;

  /// No description provided for @askListening.
  ///
  /// In en, this message translates to:
  /// **'Listening…'**
  String get askListening;

  /// No description provided for @askNotUnderstood.
  ///
  /// In en, this message translates to:
  /// **'I couldn\'t find a time in that. Try “7am on weekdays” or “in 20 minutes”.'**
  String get askNotUnderstood;

  /// No description provided for @askAnswerFromCalendar.
  ///
  /// In en, this message translates to:
  /// **'From your calendar “{name}”'**
  String askAnswerFromCalendar(String name);

  /// No description provided for @askAnswerBuiltIn.
  ///
  /// In en, this message translates to:
  /// **'Quando?\'s own times for your city'**
  String get askAnswerBuiltIn;

  /// No description provided for @askNoAnswer.
  ///
  /// In en, this message translates to:
  /// **'No time found for that yet.'**
  String get askNoAnswer;

  /// No description provided for @askNoSpeech.
  ///
  /// In en, this message translates to:
  /// **'Voice isn\'t available on this device. You can type instead.'**
  String get askNoSpeech;

  /// No description provided for @askShabbatOff.
  ///
  /// In en, this message translates to:
  /// **'Turn on Shabbat in Settings so Shabbat times can ring.'**
  String get askShabbatOff;

  /// No description provided for @askSaved.
  ///
  /// In en, this message translates to:
  /// **'Saved: {what}'**
  String askSaved(String what);

  /// No description provided for @askMic.
  ///
  /// In en, this message translates to:
  /// **'Speak'**
  String get askMic;

  /// No description provided for @askMorning.
  ///
  /// In en, this message translates to:
  /// **'Morning'**
  String get askMorning;

  /// No description provided for @askEvening.
  ///
  /// In en, this message translates to:
  /// **'Evening'**
  String get askEvening;

  /// No description provided for @askUnsure.
  ///
  /// In en, this message translates to:
  /// **'I may have missed part of that. Check it before saving.'**
  String get askUnsure;

  /// No description provided for @askTeach.
  ///
  /// In en, this message translates to:
  /// **'Teach me this'**
  String get askTeach;

  /// No description provided for @askTaught.
  ///
  /// In en, this message translates to:
  /// **'Got it: “{phrase}” now means {time}.'**
  String askTaught(String phrase, String time);

  /// No description provided for @askSkipAction.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get askSkipAction;

  /// No description provided for @askNoMatch.
  ///
  /// In en, this message translates to:
  /// **'No alarm matches that.'**
  String get askNoMatch;

  /// No description provided for @askTurnedOff.
  ///
  /// In en, this message translates to:
  /// **'Turned off: {what}'**
  String askTurnedOff(String what);

  /// No description provided for @askSkipped.
  ///
  /// In en, this message translates to:
  /// **'Skipped: {what}'**
  String askSkipped(String what);

  /// No description provided for @askEventPlan.
  ///
  /// In en, this message translates to:
  /// **'{offset} “{event}” in your calendar'**
  String askEventPlan(String offset, String event);

  /// No description provided for @askEventNoCalendar.
  ///
  /// In en, this message translates to:
  /// **'Connect a calendar so Quando? can find “{event}”.'**
  String askEventNoCalendar(String event);

  /// No description provided for @askSnoozeAll.
  ///
  /// In en, this message translates to:
  /// **'Snooze: {minutes} min, for this alarm'**
  String askSnoozeAll(int minutes);

  /// No description provided for @askWakeWith.
  ///
  /// In en, this message translates to:
  /// **'Wakes you with {sound}'**
  String askWakeWith(String sound);

  /// No description provided for @askReadAs.
  ///
  /// In en, this message translates to:
  /// **'Read as'**
  String get askReadAs;

  /// No description provided for @askHelpTitle.
  ///
  /// In en, this message translates to:
  /// **'Help improve voice alarms'**
  String get askHelpTitle;

  /// No description provided for @askHelpBody.
  ///
  /// In en, this message translates to:
  /// **'Send what you say or type, and what you did with it, anonymously. No account or device ID.'**
  String get askHelpBody;

  /// No description provided for @askHelpPromptTitle.
  ///
  /// In en, this message translates to:
  /// **'Help Quando? understand you?'**
  String get askHelpPromptTitle;

  /// No description provided for @askHelpPromptBody.
  ///
  /// In en, this message translates to:
  /// **'We\'d send what you say or type, like “{sentence}”, and whether you saved it. Anonymous: no name, account or device ID. You can switch it off anytime.'**
  String askHelpPromptBody(String sentence);

  /// No description provided for @askHelpYes.
  ///
  /// In en, this message translates to:
  /// **'Yes, help'**
  String get askHelpYes;

  /// No description provided for @askHelpNo.
  ///
  /// In en, this message translates to:
  /// **'No thanks'**
  String get askHelpNo;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'ar',
    'de',
    'en',
    'es',
    'fr',
    'he',
    'hi',
    'id',
    'it',
    'ja',
    'ko',
    'nl',
    'pl',
    'pt',
    'ru',
    'tr',
    'uk',
    'vi',
    'zh',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when language+script codes are specified.
  switch (locale.languageCode) {
    case 'zh':
      {
        switch (locale.scriptCode) {
          case 'Hant':
            return AppLocalizationsZhHant();
        }
        break;
      }
  }

  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'he':
      return AppLocalizationsHe();
    case 'hi':
      return AppLocalizationsHi();
    case 'id':
      return AppLocalizationsId();
    case 'it':
      return AppLocalizationsIt();
    case 'ja':
      return AppLocalizationsJa();
    case 'ko':
      return AppLocalizationsKo();
    case 'nl':
      return AppLocalizationsNl();
    case 'pl':
      return AppLocalizationsPl();
    case 'pt':
      return AppLocalizationsPt();
    case 'ru':
      return AppLocalizationsRu();
    case 'tr':
      return AppLocalizationsTr();
    case 'uk':
      return AppLocalizationsUk();
    case 'vi':
      return AppLocalizationsVi();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
