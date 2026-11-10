import 'package:flutter_test/flutter_test.dart';
import 'package:quando/features/assistant/domain/alarm_parser.dart';
import 'package:quando/features/assistant/domain/alarm_request.dart';

const weekdays = {1, 2, 3, 4, 5};
const everyDay = {1, 2, 3, 4, 5, 6, 7};

void main() {
  const parser = AlarmParser();

  void expectParse(String text, AlarmRequest want) => expect(parser.parse(text), want, reason: text);

  group('English', () {
    test('clock times', () {
      expectParse('wake me up at 7', const AlarmRequest(hour: 7));
      expectParse('alarm at 6:45 am', const AlarmRequest(hour: 6, minute: 45));
      expectParse('Set an alarm for 7pm', const AlarmRequest(hour: 19));
      expectParse('alarm 12am', const AlarmRequest(hour: 0));
      expectParse('wake me at half past six', const AlarmRequest(hour: 6, minute: 30));
      expectParse('quarter to eight in the morning', const AlarmRequest(hour: 7, minute: 45));
      expectParse('at seven thirty', const AlarmRequest(hour: 7, minute: 30));
      expectParse('alarm at noon', const AlarmRequest(hour: 12));
      expectParse('wake me at 10 tonight', const AlarmRequest(hour: 22, dayOffset: 0));
    });

    test('days', () {
      expectParse('wake me at 6:30 on weekdays', const AlarmRequest(hour: 6, minute: 30, days: weekdays));
      expectParse('7am every day', const AlarmRequest(hour: 7, days: everyDay));
      expectParse('alarm at 9 on weekends', const AlarmRequest(hour: 9, days: {6, 7}));
      expectParse('mondays and wednesdays at 8', const AlarmRequest(hour: 8, days: {1, 3}));
      expectParse('Monday to Thursday at 5:15', const AlarmRequest(hour: 5, minute: 15, days: {1, 2, 3, 4}));
      expectParse('tomorrow at 6', const AlarmRequest(hour: 6, dayOffset: 1));
      expectParse('every morning at 7', const AlarmRequest(hour: 7, days: everyDay));
    });

    test('in a while', () {
      expectParse('in 20 minutes', const AlarmRequest(after: Duration(minutes: 20)));
      expectParse('wake me in an hour and a half', const AlarmRequest(after: Duration(minutes: 90)));
      expectParse('alarm in half an hour', const AlarmRequest(after: Duration(minutes: 30)));
      expectParse('in 2 hours 15 minutes', const AlarmRequest(after: Duration(hours: 2, minutes: 15)));
      expectParse(
        'remind me to check the oven in 10 min',
        const AlarmRequest(after: Duration(minutes: 10), label: 'Check the oven'),
      );
    });

    test('sun and Shabbat times', () {
      expectParse(
        'wake me 30 minutes before sunrise on weekdays',
        const AlarmRequest(anchor: TimeAnchor.sunrise, offset: Duration(minutes: -30), days: weekdays),
      );
      expectParse(
        'alarm 10 minutes before Shabbat candle lighting',
        const AlarmRequest(anchor: TimeAnchor.candleLighting, offset: Duration(minutes: -10)),
      );
      expectParse('at sunset', const AlarmRequest(anchor: TimeAnchor.sunset));
      expectParse(
        'an hour before Shabbat',
        const AlarmRequest(anchor: TimeAnchor.candleLighting, offset: Duration(hours: -1)),
      );
      expectParse(
        '15 min after shabbat ends',
        const AlarmRequest(anchor: TimeAnchor.havdalah, offset: Duration(minutes: 15)),
      );
      expectParse(
        '20 minutes after Shabbat',
        const AlarmRequest(anchor: TimeAnchor.havdalah, offset: Duration(minutes: 20)),
      );
    });

    test('labels', () {
      expectParse(
        'remind me to take my pills at 8pm every day',
        const AlarmRequest(hour: 20, days: everyDay, label: 'Take my pills'),
      );
      expectParse('wake me at 6 to go running', const AlarmRequest(hour: 6, label: 'Go running'));
      expectParse('set an alarm for 7', const AlarmRequest(hour: 7));
    });
  });

  group('Portuguese', () {
    test('clock times', () {
      expectParse('me acorda às 7', const AlarmRequest(hour: 7));
      expectParse('alarme às 6h30', const AlarmRequest(hour: 6, minute: 30));
      expectParse('despertador às sete e meia', const AlarmRequest(hour: 7, minute: 30));
      expectParse('às 8 da noite', const AlarmRequest(hour: 20));
      expectParse('quinze para as sete', const AlarmRequest(hour: 6, minute: 45));
      expectParse('ao meio-dia', const AlarmRequest(hour: 12));
      expectParse('às 19h', const AlarmRequest(hour: 19));
    });

    test('days', () {
      expectParse('amanhã às 6', const AlarmRequest(hour: 6, dayOffset: 1));
      expectParse('dias úteis às 6:30', const AlarmRequest(hour: 6, minute: 30, days: weekdays));
      expectParse('de segunda a sexta às 7', const AlarmRequest(hour: 7, days: weekdays));
      expectParse('todo dia às 5', const AlarmRequest(hour: 5, days: everyDay));
      expectParse('sábado e domingo às 9', const AlarmRequest(hour: 9, days: {6, 7}));
      expectParse('terça-feira às 10', const AlarmRequest(hour: 10, days: {2}));
    });

    test('in a while and sun times', () {
      expectParse('daqui a 20 minutos', const AlarmRequest(after: Duration(minutes: 20)));
      expectParse('em meia hora', const AlarmRequest(after: Duration(minutes: 30)));
      expectParse(
        '30 minutos antes do nascer do sol',
        const AlarmRequest(anchor: TimeAnchor.sunrise, offset: Duration(minutes: -30)),
      );
      expectParse(
        '10 minutos antes do acendimento das velas',
        const AlarmRequest(anchor: TimeAnchor.candleLighting, offset: Duration(minutes: -10)),
      );
      expectParse('no pôr do sol', const AlarmRequest(anchor: TimeAnchor.sunset));
    });

    test('labels', () {
      expectParse('me lembra de tomar o remédio às 8 da noite', const AlarmRequest(hour: 20, label: 'Tomar o remédio'));
      expectParse('me acorda às 6 para ir à academia', const AlarmRequest(hour: 6, label: 'Ir à academia'));
    });
  });

  group('Hebrew', () {
    test('clock times', () {
      expectParse('תעיר אותי בשבע', const AlarmRequest(hour: 7));
      expectParse('שעון מעורר ב-6:30', const AlarmRequest(hour: 6, minute: 30));
      expectParse('בשבע וחצי בבוקר', const AlarmRequest(hour: 7, minute: 30));
      expectParse('בשמונה בערב', const AlarmRequest(hour: 20));
    });

    test('days', () {
      expectParse('מחר בשש', const AlarmRequest(hour: 6, dayOffset: 1));
      expectParse('כל יום ב-7', const AlarmRequest(hour: 7, days: everyDay));
      expectParse('בימי חול בשש', const AlarmRequest(hour: 6, days: {7, 1, 2, 3, 4, 5}));
      expectParse('ביום שני בשמונה', const AlarmRequest(hour: 8, days: {1}));
    });

    test('in a while and sun times', () {
      expectParse('בעוד 20 דקות', const AlarmRequest(after: Duration(minutes: 20)));
      expectParse('בעוד חצי שעה', const AlarmRequest(after: Duration(minutes: 30)));
      expectParse(
        'חצי שעה לפני הזריחה',
        const AlarmRequest(anchor: TimeAnchor.sunrise, offset: Duration(minutes: -30)),
      );
      expectParse(
        '10 דקות לפני הדלקת נרות',
        const AlarmRequest(anchor: TimeAnchor.candleLighting, offset: Duration(minutes: -10)),
      );
      expectParse(
        'רבע שעה אחרי צאת שבת',
        const AlarmRequest(anchor: TimeAnchor.havdalah, offset: Duration(minutes: 15)),
      );
    });
  });

  test('nothing to go on', () {
    expect(parser.parse('hello there'), isNull);
    expect(parser.parse(''), isNull);
  });
}
