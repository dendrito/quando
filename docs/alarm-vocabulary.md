# Alarm vocabulary

What we call each part of an alarm, the words people use for it, and where
to find those words in other languages. It is the shared word list for
"Say or type it" (`lib/features/assistant/`), for the phrasebook, and later
for training the on-device AI. Each part maps to one field of
`AlarmRequest`, so a parser, a dataset label and an AI answer all mean the
same thing.

Sources, by short name:

- **CLDR**: Unicode CLDR (`cldr-dates-full`): weekday names, today/tomorrow,
  "in {0} minutes", morning/evening, in every language. Unicode license.
- **MASSIVE**: Amazon MASSIVE, alarm phrases in 51 languages with labelled
  parts (slots). CC BY 4.0.
- **RT**: Microsoft Recognizers-Text, date and time rules per language. MIT.
- **Duckling**: Facebook Duckling, time and duration rules per language. BSD.
- **Calendars**: religious calendar libraries (Hebcal, adhan/hijri,
  tithi_engine, lunar, romcal, nanakshahi) and the user's own calendars.

## Parts the parser reads

| Our name (app) | Code (`AlarmRequest`) | People also say | Example EN / PT / HE | Words from | MASSIVE slot | RT / Duckling type |
|---|---|---|---|---|---|---|
| **Time** | `hour`, `minute` | at, o'clock, half past, quarter to, noon, midnight | "at 7:30" / "às 7 e meia" / "ב־7 וחצי" | RT, Duckling, CLDR (hour format) | `time` | `datetimeV2.time` / `time` |
| **Morning or evening** | `hour` (+12), `halfDayUnsure` | am, pm, in the morning, at night, tonight | "7 pm" / "7 da noite" / "7 בערב" | CLDR `dayPeriods` | `timeofday` | part of `time` |
| **Day** (once) | `dayOffset` | today, tonight, tomorrow, the day after | "tomorrow at 6" / "amanhã às 6" / "מחר ב־6" | CLDR `relative` fields (day -1/0/+1) | `date` | `datetimeV2.date` / `time` |
| **Repeat** | `days` | every day, daily, weekdays, weekends, Monday to Friday, on Mondays | "weekdays at 6" / "dias úteis às 6" / "בימי חול ב־6" | CLDR weekday names; RT `set` rules | `general_frequency`, `date` | `datetimeV2.set` |
| **In** (countdown) | `after` | in, after, from now, a timer for | "in 20 minutes" / "daqui a 20 minutos" / "בעוד 20 דקות" | CLDR "in {0} minutes"; Duckling `duration` | `time` | `datetimeV2.duration` / `duration` |
| **Moment** (sun and holy times) | `anchor` | sunrise, dawn, sunset, dusk, candle lighting, Shabbat starts, havdalah, Shabbat ends | "at sunset" / "no pôr do sol" / "בשקיעה" | Calendars (see table below) | `event_name` | none (ours) |
| **Before / After** | `offset` (minus = before) | before, after, earlier, ahead of, prior to | "20 min before candle lighting" / "20 min antes de acender as velas" / "20 דקות לפני הדלקת נרות" | RT and Duckling (`before`/`after` rules) | `time` | `datetimeV2` with `Mod` before/after |
| **Label** (Name) | `label` | to, for, called, named, remind me to | "to take pills" / "para tomar remédio" / "לקחת כדורים" | MASSIVE (the rest of the phrase) | `alarm_type`, `event_name` | none |
| **One date** | `onWeekday`, `dayOfMonth`, `month` | next Friday, on the 15th, 25 May | "next Friday at 7" / "dia 15 às 7" / "ביום שישי הבא ב־7" | CLDR weekday and month names | `date` | `datetimeV2.date` |
| **My event** | `eventQuery` | before my exam, after my meeting | "30 min before my exam" / "30 min antes da minha prova" | the user's calendar | `event_name` | none |
| **Turn off / Skip** | `action` | turn off, cancel, delete; skip, not tomorrow | "turn off the 7am alarm" / "desliga o alarme das 7" | MASSIVE intent `alarm_remove` | intent | none |
| **Sound** | `sound` | with the radio, with a song, with my voice | "wake me with the radio" | MASSIVE `music` slots | `song_name`, `radio_name` | none |
| **Snooze** | `snoozeMinutes` | snooze 10 minutes | "snooze 10 minutes" | none | none | none |

Not alarm parts, but the parser needs them:

| Our name | Code | People also say | Words from |
|---|---|---|---|
| **Set it** (command) | `_command` in `time_question.dart` | wake me, remind me, alarm, set, ring | MASSIVE intent `alarm_set` |
| **Ask** (question) | `readTimeQuestion` | when, what time, at what time | MASSIVE intent `alarm_query`; question marks |
| **Numbers** | `_numbers`, phrasebook digits | one ... sixty, half, quarter, native digits | CLDR number names; RT number rules |

## Parts set on screen, not by voice (yet)

These have names in the app but the parser does not read them. Once
it does, add a row above.

| Our name (app) | Code (`Alarm`) | People also say | MASSIVE |
|---|---|---|---|
| **Snooze limit** | snooze count | how many times | none |
| **Ring for** | ring length | ring for, how long it rings | none |
| **Gentle wake-up** | gentle sound | soft start, slowly, gradually | none |
| **Volume** | volume | loud, quiet, louder, softer | `audio_volume_*` intents |
| **Wake-up check** | wake check | make sure I'm up, check I got up | none |
| **Mission** | mission | puzzle, math, scan, walk, to turn it off | none |
| **Lock** (Lock mode) | `LockSettings`, `CalendarLock` | quiet time, focus, do not disturb, lock, unplug | none |

## Moments by tradition

The **Moment** part (`TimeAnchor`) grows with each calendar. Shabbat
words show up only when a Shabbat calendar is picked, and the same rule
applies to every tradition: opt in, never on by default.

| Moment | Also said | Source |
|---|---|---|
| Sunrise / Sunset | dawn, daybreak, sundown, dusk; nascer/pôr do sol; זריחה/שקיעה | built-in sun times; CLDR has none, so the phrasebook keeps them |
| Candle lighting / Havdalah (in app) | Shabbat starts/ends, Shabbos, Motzei Shabbat; acendimento das velas; הדלקת נרות/הבדלה | Hebcal (BSD, has many languages: `@hebcal/locales`) |
| Prayer times: Fajr, Dhuhr, Asr, Maghrib, Isha (idea) | dawn prayer, adhan, salah, namaz | `adhan_dart` (MIT) |
| Suhoor / Iftar, Ramadan, Eid (idea) | sehri, fast starts/ends, breaking the fast | `hijri_core` / `hijri_plus` (MIT), Maghrib from `adhan_dart` |
| Tithi, Ekadashi, Diwali, Holi (idea) | fasting day, puja | `tithi_engine` (Dart, Apache 2.0) |
| Lunar new year, solar terms, full moon (idea) | Spring Festival, Mid-Autumn, uposatha | `lunar` by 6tail |
| Mass, Lent, Easter (idea) | Sunday service, feast day | `romcal` (MIT) |
| Gurpurab (idea) | Sikh holy day | `nanakshahi-js` |

When a library only has English names, translate the names into the
20 app languages, like any app text, and have a native speaker check them.

## How to use this table

1. **Adding a language:** fill each "People also say" row from CLDR first
   (official names), then from RT/Duckling rules, then check against
   MASSIVE phrases in that language.
2. **Testing:** MASSIVE `alarm_set` phrases, with their `time`/`date`
   slots, become test cases: the parser's `AlarmRequest` must agree with
   the slots.
3. **Training the AI:** the AI's output is the same `AlarmRequest` fields,
   so a MASSIVE slot maps straight to a field using the table above.
