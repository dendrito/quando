import 'package:flutter_test/flutter_test.dart';
import 'package:quando/features/assistant/data/learned_phrases.dart';
import 'package:quando/features/assistant/domain/alarm_parser.dart';
import 'package:quando/features/assistant/domain/alarm_plan.dart';
import 'package:quando/features/assistant/domain/alarm_request.dart';
import 'package:timezone/data/latest.dart' as tzdata;

void main() {
  const parser = AlarmParser();
  AlarmRequest? p(String text, [String? lang]) => parser.parse(text, lang: lang);

  test('next Friday and dates are said once', () {
    expect(p('wake me next friday at 9', 'en'), const AlarmRequest(hour: 9, onWeekday: 5));
    expect(p('me acorda na próxima sexta às 9', 'pt'), const AlarmRequest(hour: 9, onWeekday: 5));
    expect(p('despiértame el próximo viernes a las 9', 'es'), const AlarmRequest(hour: 9, onWeekday: 5));
    expect(p('weck mich nächsten Freitag um 9', 'de'), const AlarmRequest(hour: 9, onWeekday: 5));
    expect(p('réveille-moi vendredi prochain à 9h', 'fr'), const AlarmRequest(hour: 9, onWeekday: 5));
    expect(p('alarm on the 15th at 8am', 'en'), const AlarmRequest(hour: 8, dayOfMonth: 15));
    expect(
      p('remind me on 25 May at 7 to call grandma', 'en'),
      const AlarmRequest(hour: 7, month: 5, dayOfMonth: 25, label: 'Call grandma'),
    );
    expect(p('alarme dia 15 às 8', 'pt'), const AlarmRequest(hour: 8, dayOfMonth: 15));
    // "On Friday" is still every Friday, as before.
    expect(p('wake me at 7 on friday', 'en'), const AlarmRequest(hour: 7, days: {5}));
  });

  test('any calendar event is a moment', () {
    expect(
      p('30 minutes before my exam', 'en'),
      const AlarmRequest(eventQuery: 'exam', offset: Duration(minutes: -30)),
    );
    expect(
      p('20 minutos antes da minha reunião', 'pt'),
      const AlarmRequest(eventQuery: 'reunião', offset: Duration(minutes: -20)),
    );
    expect(
      p('remind me 1 hour before the dentist tomorrow', 'en'),
      const AlarmRequest(eventQuery: 'dentist', offset: Duration(hours: -1), dayOffset: 1),
    );
    // Sun and Shabbat times are still built in.
    expect(p('30 minutes before sunrise', 'en')!.anchor, TimeAnchor.sunrise);
  });

  test('turn off, skip, sound and snooze', () {
    expect(p('turn off the 7am alarm', 'en'), const AlarmRequest(hour: 7, action: AlarmAction.remove));
    expect(p('desliga o alarme das 7', 'pt')!.action, AlarmAction.remove);
    expect(p('תבטל את השעון של 7', 'he')!.action, AlarmAction.remove);
    expect(p('skip tomorrow', 'en'), const AlarmRequest(dayOffset: 1, action: AlarmAction.skip));
    expect(p('wake me at 7 with the radio', 'en'), const AlarmRequest(hour: 7, sound: 'radio'));
    expect(p('me acorda às 7 com o rádio', 'pt'), const AlarmRequest(hour: 7, sound: 'radio'));
    expect(
      p('alarm at 6:30 snooze 10 minutes', 'en'),
      const AlarmRequest(hour: 6, minute: 30, snoozeMinutes: 10),
    );
  });

  test('times said in words', () {
    expect(p('set an alarm for five hundred and thirty am', 'en'), const AlarmRequest(hour: 5, minute: 30));
    expect(
      p('make me a wake up alarm for eight forty five am', 'en'),
      const AlarmRequest(hour: 8, minute: 45),
    );
    expect(p('please set my alarm for five p. m.', 'en'), const AlarmRequest(hour: 17));
    expect(p('set an alarm for twenty minutes', 'en'), const AlarmRequest(after: Duration(minutes: 20)));
    expect(p('me acorda às sete e meia', 'pt'), const AlarmRequest(hour: 7, minute: 30));
    // A number that isn't a time keeps its words.
    expect(p('remind me to take two pills at 8', 'en')!.label, 'Take two pills');
  });

  test('only the app language and English are read', () {
    // German "um" is "at", not Portuguese "one".
    expect(p('weck mich um 8', 'de'), const AlarmRequest(hour: 8));
    // Portuguese still reads English mixed in.
    expect(p('alarme at 7pm', 'pt'), const AlarmRequest(hour: 19));
  });

  test('what was understood, and how sure', () {
    final r = parser.read('wake me tomorrow at 7', lang: 'en');
    expect(r.confidence, 1.0);
    expect(r.understood.map((s) => r.text.substring(s.$1, s.$2)), ['tomorrow at 7']);
    final unsure = parser.read('banana 7 helicopter purple', lang: 'en');
    expect(unsure.confidence, lessThan(AlarmReading.unsure));
  });

  test('phrases taught on the phone', () {
    const l = Learned(phrases: {'gym time': '6:00'});
    expect(p(l.apply('Gym time tomorrow'), 'en'), const AlarmRequest(hour: 6, dayOffset: 1));
    final back = Learned.fromJson(const Learned(phrases: {'x': '7:15'}, halfDay: {7: true}).toJson());
    expect(back.phrases, {'x': '7:15'});
    expect(back.halfDay, {7: true});
  });

  group('plans', () {
    setUpAll(tzdata.initializeTimeZones);
    // Wednesday 11 Nov 2026, 10:00 in São Paulo.
    final now = DateTime.utc(2026, 11, 11, 13);
    AlarmPlan? plan(AlarmRequest r) =>
        planFor(r, now: now, zone: 'America/Sao_Paulo', eventsBetween: (_, _) => const []);

    test('next Friday, the 15th, 25 May', () {
      expect(
        (plan(const AlarmRequest(hour: 9, onWeekday: 5)) as OneOffPlan).at,
        DateTime.utc(2026, 11, 13, 12),
      );
      expect(
        (plan(const AlarmRequest(hour: 8, dayOfMonth: 15)) as OneOffPlan).at,
        DateTime.utc(2026, 11, 15, 11),
      );
      expect(
        (plan(const AlarmRequest(hour: 7, month: 5, dayOfMonth: 25)) as OneOffPlan).at,
        DateTime.utc(2027, 5, 25, 10),
      );
      // "Next Wednesday" said on a Wednesday is a week away.
      expect(
        (plan(const AlarmRequest(hour: 9, onWeekday: 3)) as OneOffPlan).at,
        DateTime.utc(2026, 11, 18, 12),
      );
    });

    test('a calendar event becomes a rule on that event', () {
      final e = plan(const AlarmRequest(eventQuery: 'exam', offset: Duration(minutes: -30))) as EventPlan;
      expect(e.query, 'exam');
      expect(e.offset, const Duration(minutes: -30));
    });
  });
}
