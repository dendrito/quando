import 'package:flutter_test/flutter_test.dart';
import 'package:quando/features/assistant/domain/alarm_parser.dart';
import 'package:quando/features/assistant/domain/alarm_request.dart';
import 'package:quando/features/assistant/domain/time_question.dart';

const weekdays = {1, 2, 3, 4, 5};
const everyDay = {1, 2, 3, 4, 5, 6, 7};

void main() {
  const parser = AlarmParser();
  void expectParse(String text, AlarmRequest want) => expect(parser.parse(text), want, reason: text);
  void expectQuestion(String text, TimeAnchor anchor, {int? weekday, int? dayOffset}) {
    final q = readTimeQuestion(text);
    expect((q?.anchor, q?.weekday, q?.dayOffset), (anchor, weekday, dayOffset), reason: text);
  }

  group('Spanish', () {
    test('clock times and days', () {
      expectParse('despiértame a las 7', const AlarmRequest(hour: 7));
      expectParse('alarma a las 6:30', const AlarmRequest(hour: 6, minute: 30));
      expectParse('a las siete y media', const AlarmRequest(hour: 7, minute: 30));
      expectParse('a las ocho menos cuarto', const AlarmRequest(hour: 7, minute: 45));
      expectParse('a las 8 de la noche', const AlarmRequest(hour: 20));
      expectParse('mañana a las 6', const AlarmRequest(hour: 6, dayOffset: 1));
      expectParse('a las 7 de la mañana', const AlarmRequest(hour: 7));
      expectParse('de lunes a viernes a las 7', const AlarmRequest(hour: 7, days: weekdays));
      expectParse('todos los días a las 5', const AlarmRequest(hour: 5, days: everyDay));
      expectParse('sábados y domingos a las 9', const AlarmRequest(hour: 9, days: {6, 7}));
    });

    test('in a while, sun and Shabbat times, labels', () {
      expectParse('en 20 minutos', const AlarmRequest(after: Duration(minutes: 20)));
      expectParse('en media hora', const AlarmRequest(after: Duration(minutes: 30)));
      expectParse(
        '30 minutos antes del amanecer',
        const AlarmRequest(anchor: TimeAnchor.sunrise, offset: Duration(minutes: -30)),
      );
      expectParse(
        '10 minutos antes del encendido de velas',
        const AlarmRequest(anchor: TimeAnchor.candleLighting, offset: Duration(minutes: -10)),
      );
      expectParse('a la puesta del sol', const AlarmRequest(anchor: TimeAnchor.sunset));
      expectParse(
        'recuérdame tomar la medicina a las 8 de la noche',
        const AlarmRequest(hour: 20, label: 'Tomar la medicina'),
      );
      expectQuestion('¿Cuándo es el encendido de velas este viernes?', TimeAnchor.candleLighting, weekday: 5);
      expectQuestion('¿A qué hora es la havdalá?', TimeAnchor.havdalah);
    });
  });

  group('French', () {
    test('clock times and days', () {
      expectParse('réveille-moi à 7h', const AlarmRequest(hour: 7));
      expectParse('alarme à 6h30', const AlarmRequest(hour: 6, minute: 30));
      expectParse('à sept heures et demie', const AlarmRequest(hour: 7, minute: 30));
      expectParse('à huit heures moins le quart', const AlarmRequest(hour: 7, minute: 45));
      expectParse('à 8 heures du soir', const AlarmRequest(hour: 20));
      expectParse('demain à 6h', const AlarmRequest(hour: 6, dayOffset: 1));
      expectParse('du lundi au vendredi à 7h', const AlarmRequest(hour: 7, days: weekdays));
      expectParse('tous les jours à 5h', const AlarmRequest(hour: 5, days: everyDay));
      expectParse('samedi et dimanche à 9h', const AlarmRequest(hour: 9, days: {6, 7}));
    });

    test('in a while, sun and Shabbat times, labels', () {
      expectParse('dans 20 minutes', const AlarmRequest(after: Duration(minutes: 20)));
      expectParse('dans une demi-heure', const AlarmRequest(after: Duration(minutes: 30)));
      expectParse(
        '30 minutes avant le lever du soleil',
        const AlarmRequest(anchor: TimeAnchor.sunrise, offset: Duration(minutes: -30)),
      );
      expectParse(
        '10 minutes avant l\'allumage des bougies',
        const AlarmRequest(anchor: TimeAnchor.candleLighting, offset: Duration(minutes: -10)),
      );
      expectParse('au coucher du soleil', const AlarmRequest(anchor: TimeAnchor.sunset));
      expectParse(
        'rappelle-moi de prendre le médicament à 20h',
        const AlarmRequest(hour: 20, label: 'Prendre le médicament'),
      );
      expectQuestion(
        'Quand est l\'allumage des bougies ce vendredi ?',
        TimeAnchor.candleLighting,
        weekday: 5,
      );
      expectQuestion('À quelle heure est la havdala ?', TimeAnchor.havdalah);
    });
  });

  group('German', () {
    test('clock times and days', () {
      expectParse('weck mich um 7', const AlarmRequest(hour: 7));
      expectParse('Wecker um 6:30', const AlarmRequest(hour: 6, minute: 30));
      expectParse('um halb acht', const AlarmRequest(hour: 7, minute: 30));
      expectParse('um viertel vor acht', const AlarmRequest(hour: 7, minute: 45));
      expectParse('um 8 Uhr abends', const AlarmRequest(hour: 20));
      expectParse('morgen um 6', const AlarmRequest(hour: 6, dayOffset: 1));
      expectParse('von Montag bis Freitag um 7', const AlarmRequest(hour: 7, days: weekdays));
      expectParse('jeden Tag um 5', const AlarmRequest(hour: 5, days: everyDay));
      expectParse('Samstag und Sonntag um 9', const AlarmRequest(hour: 9, days: {6, 7}));
    });

    test('in a while, sun and Shabbat times, labels', () {
      expectParse('in 20 Minuten', const AlarmRequest(after: Duration(minutes: 20)));
      expectParse('in einer halben Stunde', const AlarmRequest(after: Duration(minutes: 30)));
      expectParse(
        '30 Minuten vor Sonnenaufgang',
        const AlarmRequest(anchor: TimeAnchor.sunrise, offset: Duration(minutes: -30)),
      );
      expectParse(
        '10 Minuten vor dem Kerzenzünden',
        const AlarmRequest(anchor: TimeAnchor.candleLighting, offset: Duration(minutes: -10)),
      );
      expectParse('bei Sonnenuntergang', const AlarmRequest(anchor: TimeAnchor.sunset));
      expectParse(
        'erinnere mich um 20 Uhr an die Tabletten',
        const AlarmRequest(hour: 20, label: 'Tabletten'),
      );
      expectQuestion('Wann ist Kerzenzünden diesen Freitag?', TimeAnchor.candleLighting, weekday: 5);
      expectQuestion('Wann ist Hawdala?', TimeAnchor.havdalah);
    });
  });

  group('Italian', () {
    test('clock times and days', () {
      expectParse('svegliami alle 7', const AlarmRequest(hour: 7));
      expectParse('sveglia alle 6:30', const AlarmRequest(hour: 6, minute: 30));
      expectParse('alle sette e mezza', const AlarmRequest(hour: 7, minute: 30));
      expectParse('alle otto meno un quarto', const AlarmRequest(hour: 7, minute: 45));
      expectParse('alle 8 di sera', const AlarmRequest(hour: 20));
      expectParse('domani alle 6', const AlarmRequest(hour: 6, dayOffset: 1));
      expectParse('dal lunedì al venerdì alle 7', const AlarmRequest(hour: 7, days: weekdays));
      expectParse('ogni giorno alle 5', const AlarmRequest(hour: 5, days: everyDay));
      expectParse('sabato e domenica alle 9', const AlarmRequest(hour: 9, days: {6, 7}));
    });

    test('in a while, sun and Shabbat times, labels', () {
      expectParse('tra 20 minuti', const AlarmRequest(after: Duration(minutes: 20)));
      expectParse('tra mezz\'ora', const AlarmRequest(after: Duration(minutes: 30)));
      expectParse(
        '30 minuti prima dell\'alba',
        const AlarmRequest(anchor: TimeAnchor.sunrise, offset: Duration(minutes: -30)),
      );
      expectParse(
        '10 minuti prima dell\'accensione delle candele',
        const AlarmRequest(anchor: TimeAnchor.candleLighting, offset: Duration(minutes: -10)),
      );
      expectParse('al tramonto', const AlarmRequest(anchor: TimeAnchor.sunset));
      expectParse(
        'ricordami di prendere la medicina alle 20',
        const AlarmRequest(hour: 20, label: 'Prendere la medicina'),
      );
      expectQuestion(
        'Quando è l\'accensione delle candele questo venerdì?',
        TimeAnchor.candleLighting,
        weekday: 5,
      );
      expectQuestion('A che ora è l\'havdalà?', TimeAnchor.havdalah);
    });
  });
}
