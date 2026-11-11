import 'package:flutter_test/flutter_test.dart';
import 'package:quando/features/assistant/domain/alarm_parser.dart';
import 'package:quando/features/assistant/domain/phrasebook.dart';

void main() {
  test('show', () {
    for (final (l, t) in [
      ('vi', 'cài báo thức lúc sáu giờ sáng'),
      ('vi', 'đặt báo thức lúc ba giờ chiều'),
      ('vi', 'đặt báo thức để gọi tôi dậy sau năm tiếng'),
      ('nl', 'zet een alarm voor veertig minuten vanaf nu'),
      ('nl', 'stel een alarm voor drie uur vanmiddag'),
      ('ko', '오전 여섯 시 삼십 분 에 알람 설정해'),
      ('ar', 'حط منبه على خمسة ونص الصبح'),
      ('ar', 'سوي منبه لثلاثة الظهر'),
    ]) {
      // ignore: avoid_print
      print('$l: $t\n  → ${rewriteForParser(t, l)}\n  = ${const AlarmParser().parse(t, lang: l)}');
    }
  });
}
