import 'package:flutter_test/flutter_test.dart';
import 'package:quando/features/events/domain/event_query.dart';

void main() {
  bool m(String q, String title) => EventQuery.parse(q).matches(title);

  test('plain words match inside titles, any case', () {
    expect(m('dentist', 'Dentist with Dr. Cohen'), isTrue);
    expect(m('DENT', 'dentist'), isTrue);
    expect(m('flight', 'Dentist'), isFalse);
    expect(m('', 'anything'), isTrue);
    expect(EventQuery.parse('  ').isEmpty, isTrue);
  });

  test('wildcards match whole words or the whole title', () {
    expect(m('dent*', 'My dentist visit'), isTrue);
    expect(m('*sync', 'Weekly team sync'), isTrue);
    expect(m('?oga', 'Yoga class'), isTrue);
    expect(m('?oga', 'Yogurt'), isFalse);
    expect(m('team*sync', 'Team weekly sync'), isTrue);
    expect(m('dent*', 'Accident report'), isFalse);
  });

  test('phrases, AND, OR, NOT and brackets', () {
    expect(m('"team sync"', 'Team sync'), isTrue);
    expect(m('"team sync"', 'Team weekly sync'), isFalse);
    expect(m('gym yoga', 'Gym then yoga'), isTrue);
    expect(m('gym AND yoga', 'Gym'), isFalse);
    expect(m('flight OR train', 'Train to Haifa'), isTrue);
    expect(m('flight | train', 'Flight LIS'), isTrue);
    expect(m('meeting -cancelled', 'Meeting (cancelled)'), isFalse);
    expect(m('meeting NOT cancelled', 'Meeting'), isTrue);
    expect(m('meeting !cancelled', 'Meeting'), isTrue);
    expect(m('(gym OR yoga) morning', 'Morning yoga'), isTrue);
    expect(m('(gym OR yoga) morning', 'Evening yoga'), isFalse);
    expect(m('-(a OR b)', 'cde'), isTrue);
    expect(m('candle* -second', 'Candle lighting · Shabbat'), isTrue);
  });

  test('odd input never throws', () {
    for (final q in [
      '(',
      ')',
      'OR',
      'AND OR',
      '"',
      '"open',
      '((a',
      'a))',
      '-',
      '!!',
      '*',
      '?',
    ]) {
      expect(() => m(q, 'Some event'), returnsNormally, reason: q);
    }
    expect(m('*', 'x'), isTrue);
    expect(m('a))', 'a'), isTrue);
  });

  test('terms lists what to highlight', () {
    expect(EventQuery.parse('gym -cancelled "team sync"').terms, [
      'gym',
      'team sync',
    ]);
  });
}
