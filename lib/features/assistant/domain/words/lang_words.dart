import '../alarm_request.dart';
import 'de.dart';
import 'en.dart';
import 'es.dart';
import 'fr.dart';
import 'he.dart';
import 'it.dart';
import 'pt.dart';

/// The words one language uses for each part of an alarm (see
/// docs/alarm-vocabulary.md). One file per language, so a native speaker
/// can check it without reading the parser.
///
/// Values are pieces of regular expressions: `|` separates choices,
/// `\s+` is a space, `?` makes the letter before it optional. Words are
/// written without accents (the parser strips them) and in lower case.
class LangWords {
  const LangWords({
    this.numbers = const {},
    this.numberJoin = '',
    this.oneWords = const {},
    this.minute = '',
    this.hour = '',
    this.halfHourAfter = '',
    this.durations = const {},
    this.inWords = '',
    this.fromNow = '',
    this.days = const {},
    this.daySuffix = '',
    this.dayPrefix = '',
    this.dayGroups = const [],
    this.morning = '',
    this.evening = '',
    this.rangeFrom = '',
    this.rangeTo = '',
    this.relativeDays = const [],
    this.tonight = '',
    this.thisNext = '',
    this.before = '',
    this.after = '',
    this.at = '',
    this.article = '',
    this.moments = const {},
    this.am = '',
    this.pm = '',
    this.noon = '',
    this.midnight = '',
    this.atHour = '',
    this.timePrefix = '',
    this.oclock = '',
    this.hourWord = '',
    this.halfPast = '',
    this.quarterPast = '',
    this.quarterTo = '',
    this.minutesTo = '',
    this.connector = '',
    this.labelTriggers = '',
    this.filler = const {},
    this.question = '',
    this.command = '',
    this.remove = '',
    this.skip = '',
    this.months = const {},
    this.ordinalDay = '',
    this.myEvent = '',
    this.soundWords = const {},
    this.snooze = '',
  });

  /// "seven" → 7. Tens and units are joined by [numberJoin] or a space.
  final Map<String, int> numbers;
  final String numberJoin;

  /// Words for "a" / "one" before a length of time: "an hour".
  final Set<String> oneWords;

  /// Units: "minutes", "hours".
  final String minute;
  final String hour;

  /// "an hour and a half": what follows "hour".
  final String halfHourAfter;

  /// Whole phrases for a length of time, in minutes: "half an hour" = 30.
  final Map<String, int> durations;

  /// "in 20 minutes" and "20 minutes from now".
  final String inWords;
  final String fromNow;

  /// Weekday names, 1 = Monday ... 7 = Sunday.
  final Map<String, int> days;

  /// What may follow a day name: Portuguese "segunda-feira".
  final String daySuffix;

  /// What may come before a day name: "on", "every".
  final String dayPrefix;

  /// "weekdays", "weekends", "every day": a phrase and its days.
  final List<(String, Set<int>)> dayGroups;

  /// Stems that make a day group a morning or an evening one.
  final String morning;
  final String evening;

  /// "from Monday to Friday".
  final String rangeFrom;
  final String rangeTo;

  /// "tomorrow" = 1, "today" = 0, "the day after tomorrow" = 2.
  final List<(String, int)> relativeDays;

  /// "tonight": today, in the evening.
  final String tonight;

  /// "next Friday", "this Friday": once, not every week.
  final String thisNext;

  /// "before" and "after" a moment.
  final String before;
  final String after;

  /// "at", "on" before a moment, and the articles after it.
  final String at;
  final String article;

  /// Sunrise, sunset and Shabbat times.
  final Map<TimeAnchor, String> moments;

  /// Morning and evening words: "am", "in the morning", "pm", "tonight".
  final String am;
  final String pm;
  final String noon;
  final String midnight;

  /// Words before an hour: "at 7", "for 7".
  final String atHour;

  /// Words before a clock time: "at 7:30".
  final String timePrefix;

  /// After an hour: "o'clock".
  final String oclock;

  /// "hours" said between the hour and its minutes: "sept heures et demie".
  final String hourWord;

  /// "seven and a half", "seven fifteen" (quarter), "a quarter to eight".
  final String halfPast;
  final String quarterPast;
  final String quarterTo;

  /// "quinze para as sete" = 6:45: minutes, this word, then the hour.
  final String minutesTo;

  /// Between hour and minutes: "sete e quinze".
  final String connector;

  /// What starts a label: "to", "for", "remind me to".
  final String labelTriggers;

  /// Words that never make a label by themselves.
  final Set<String> filler;

  /// "when", "what time": a question, not an alarm to set.
  final String question;

  /// "wake me", "remind me", "set": an alarm to set.
  final String command;

  /// "cancel", "turn off", "delete" an alarm.
  final String remove;

  /// "skip" the next one.
  final String skip;

  /// Month names, 1 = January.
  final Map<String, int> months;

  /// "the 15th": what follows a day-of-month number.
  final String ordinalDay;

  /// "my" / "the" before a calendar event: "before my exam".
  final String myEvent;

  /// "radio", "a song": what an alarm wakes you up to.
  final Map<String, String> soundWords;

  /// "snooze" in "snooze 5 minutes".
  final String snooze;
}

/// Every language the parser reads directly, by language code. Others
/// are first rewritten into English by the phrasebook.
const Map<String, LangWords> parserLanguages = {
  'en': english,
  'pt': portuguese,
  'es': spanish,
  'fr': french,
  'de': german,
  'it': italian,
  'he': hebrew,
};
