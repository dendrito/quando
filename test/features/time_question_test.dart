import 'package:flutter_test/flutter_test.dart';
import 'package:quando/features/assistant/domain/alarm_request.dart';
import 'package:quando/features/assistant/domain/time_question.dart';
import 'package:quando/features/events/domain/event.dart';

// Tuesday 10 Nov 2026, 12:00 in São Paulo.
final _now = DateTime.utc(2026, 11, 10, 15);
const _zone = 'America/Sao_Paulo';

AnchorEvent _cal(String title, DateTime at) =>
    AnchorEvent(id: 'cal.$title$at', kind: EventKind.calendar, title: title, at: at, source: 'hebcal');

AnchorEvent _own(EventKind kind, DateTime at) =>
    AnchorEvent(id: '$kind$at', kind: kind, title: '$kind', at: at, source: 'jewish');

void main() {
  test('questions are told apart from alarms', () {
    final q = readTimeQuestion('When is candle lighting this Friday?')!;
    expect((q.anchor, q.weekday), (TimeAnchor.candleLighting, 5));
    expect(readTimeQuestion('Quando é o acendimento das velas na sexta?')!.anchor, TimeAnchor.candleLighting);
    expect(readTimeQuestion('מתי הבדלה')!.anchor, TimeAnchor.havdalah);
    expect(readTimeQuestion('what time is sunset tomorrow')!.dayOffset, 1);
    expect(readTimeQuestion('wake me 30 min before candle lighting'), isNull);
    expect(readTimeQuestion('me acorda no pôr do sol?'), isNull);
    expect(readTimeQuestion('when is my dentist?'), isNull);
  });

  test('candle lighting is read from the calendar first', () {
    final a = answerTimeQuestion(
      readTimeQuestion('When is candle lighting this Friday?')!,
      now: _now,
      zone: _zone,
      calendarEvents: [_cal('Candle lighting: 19:01', DateTime.utc(2026, 11, 13, 22, 1))],
      builtIn: [_own(EventKind.holyDayStart, DateTime.utc(2026, 11, 13, 21, 59))],
    )!;
    expect((a.at, a.calendarId), (DateTime.utc(2026, 11, 13, 22, 1), 'hebcal'));
  });

  test('without a Shabbat calendar, Quando?\'s own times answer', () {
    final a = answerTimeQuestion(
      readTimeQuestion('when is havdalah?')!,
      now: _now,
      zone: _zone,
      calendarEvents: [_cal('Dentist', DateTime.utc(2026, 11, 14, 13))],
      builtIn: [_own(EventKind.holyDayEnd, DateTime.utc(2026, 11, 14, 23))],
    )!;
    expect(a.fromCalendar, isFalse);
    expect(a.at, DateTime.utc(2026, 11, 14, 23));
  });

  test('"this Friday" skips other days', () {
    expect(
      answerTimeQuestion(
        readTimeQuestion('When is candle lighting this Friday?')!,
        now: _now,
        zone: _zone,
        builtIn: [_own(EventKind.secondNightCandles, DateTime.utc(2026, 11, 11, 22))],
      ),
      isNull,
    );
  });
}
