import 'package:flutter_test/flutter_test.dart';
import 'package:quando/features/assistant/domain/alarm_parser.dart';
import 'package:quando/features/assistant/domain/alarm_request.dart';
import 'package:quando/features/assistant/domain/time_question.dart';

/// Quando?'s other languages, read through the phrasebook: a clock time,
/// tomorrow, every day, a weekday range, "in 20 minutes", "30 minutes
/// before sunrise" and "when is candle lighting on Friday?" in each.
void main() {
  const cases = <(String, String, String, TimeAnchor?)>[
    ('nl', 'maak me wakker om 7 uur', 'AlarmRequest(at 7:00)', null),
    ('nl', 'morgen om half acht', 'AlarmRequest(at 7:30, dayOffset 1)', null),
    ('nl', 'elke dag om 6:30', 'AlarmRequest(at 6:30, days 1,2,3,4,5,6,7)', null),
    ('nl', 'van maandag tot vrijdag om 7', 'AlarmRequest(at 7:00, days 1,2,3,4,5)', null),
    ('nl', 'over 20 minuten', 'AlarmRequest(in 20m)', null),
    ('nl', '30 minuten voor zonsopgang', 'AlarmRequest(sunrise -30m)', null),
    (
      'nl',
      'wanneer is het kaarsen aansteken vrijdag?',
      'AlarmRequest(days 5, candleLighting 0m)',
      TimeAnchor.candleLighting,
    ),
    ('pl', 'obudź mnie o 7', 'AlarmRequest(at 7:00)', null),
    ('pl', 'jutro o siódmej rano', 'AlarmRequest(at 7:00, dayOffset 1)', null),
    ('pl', 'codziennie o 6:30', 'AlarmRequest(at 6:30, days 1,2,3,4,5,6,7)', null),
    ('pl', 'od poniedziałku do piątku o 7', 'AlarmRequest(at 7:00, days 1,2,3,4,5)', null),
    ('pl', 'za 20 minut', 'AlarmRequest(in 20m)', null),
    ('pl', '30 minut przed wschodem słońca', 'AlarmRequest(sunrise -30m)', null),
    (
      'pl',
      'kiedy jest zapalenie świec w piątek?',
      'AlarmRequest(days 5, candleLighting 0m)',
      TimeAnchor.candleLighting,
    ),
    ('ru', 'разбуди меня в 7 утра', 'AlarmRequest(at 7:00)', null),
    ('ru', 'завтра в 6:30', 'AlarmRequest(at 6:30, dayOffset 1)', null),
    ('ru', 'каждый день в 7', 'AlarmRequest(at 7:00, days 1,2,3,4,5,6,7)', null),
    ('ru', 'с понедельника по пятницу в 7', 'AlarmRequest(at 7:00, days 1,2,3,4,5)', null),
    ('ru', 'через 20 минут', 'AlarmRequest(in 20m)', null),
    ('ru', 'за 30 минут до восхода солнца', 'AlarmRequest(sunrise -30m)', null),
    (
      'ru',
      'когда зажигание свечей в пятницу?',
      'AlarmRequest(days 5, candleLighting 0m)',
      TimeAnchor.candleLighting,
    ),
    ('ru', 'во сколько авдала?', 'AlarmRequest(havdalah 0m)', TimeAnchor.havdalah),
    ('uk', 'розбуди мене о 7 ранку', 'AlarmRequest(at 7:00)', null),
    ('uk', 'завтра о 6:30', 'AlarmRequest(at 6:30, dayOffset 1)', null),
    ('uk', 'щодня о 7', 'AlarmRequest(at 7:00, days 1,2,3,4,5,6,7)', null),
    ('uk', 'через 20 хвилин', 'AlarmRequest(in 20m)', null),
    ('uk', 'за 30 хвилин до сходу сонця', 'AlarmRequest(sunrise -30m)', null),
    (
      'uk',
      'коли запалювання свічок у пʼятницю?',
      'AlarmRequest(days 5, candleLighting 0m)',
      TimeAnchor.candleLighting,
    ),
    ('tr', 'beni saat 7\'de uyandır', 'AlarmRequest(at 7:00)', null),
    ('tr', 'yarın 6:30\'da', 'AlarmRequest(at 6:30, dayOffset 1)', null),
    ('tr', 'her gün saat 7\'de', 'AlarmRequest(at 7:00, days 1,2,3,4,5,6,7)', null),
    ('tr', 'pazartesiden cumaya saat 7', 'AlarmRequest(at 7:00, days 1,2,3,4,5)', null),
    ('tr', '20 dakika sonra', 'AlarmRequest(in 20m)', null),
    ('tr', 'gün doğumundan 30 dakika önce', 'AlarmRequest(sunrise -30m)', null),
    ('tr', 'cuma mum yakma ne zaman?', 'AlarmRequest(days 5, candleLighting 0m)', TimeAnchor.candleLighting),
    ('id', 'bangunkan saya jam 7 pagi', 'AlarmRequest(at 7:00)', null),
    ('id', 'besok jam 6:30', 'AlarmRequest(at 6:30, dayOffset 1)', null),
    ('id', 'setiap hari jam 7', 'AlarmRequest(at 7:00, days 1,2,3,4,5,6,7)', null),
    ('id', 'dari senin sampai jumat jam 7', 'AlarmRequest(at 7:00, days 1,2,3,4,5)', null),
    ('id', '20 menit lagi', 'AlarmRequest(in 20m)', null),
    ('id', '30 menit sebelum matahari terbit', 'AlarmRequest(sunrise -30m)', null),
    (
      'id',
      'kapan menyalakan lilin hari jumat?',
      'AlarmRequest(days 5, candleLighting 0m)',
      TimeAnchor.candleLighting,
    ),
    ('vi', 'đánh thức tôi lúc 7 giờ sáng', 'AlarmRequest(at 7:00)', null),
    ('vi', 'ngày mai lúc 6 giờ 30', 'AlarmRequest(at 6:30, dayOffset 1)', null),
    ('vi', 'mỗi ngày lúc 7 giờ', 'AlarmRequest(at 7:00, days 1,2,3,4,5,6,7)', null),
    ('vi', 'từ thứ hai đến thứ sáu lúc 7 giờ', 'AlarmRequest(at 7:00, days 1,2,3,4,5)', null),
    ('vi', '20 phút nữa', 'AlarmRequest(in 20m)', null),
    ('vi', '30 phút trước bình minh', 'AlarmRequest(sunrise -30m)', null),
    ('vi', 'khi nào thắp nến thứ sáu?', 'AlarmRequest(days 5, candleLighting 0m)', TimeAnchor.candleLighting),
    ('hi', 'मुझे 7 बजे जगाना', 'AlarmRequest(at 7:00)', null),
    ('hi', 'कल सुबह साढ़े 6 बजे', 'AlarmRequest(at 6:30, dayOffset 1)', null),
    ('hi', 'हर दिन 7 बजे', 'AlarmRequest(at 7:00, days 1,2,3,4,5,6,7)', null),
    ('hi', 'सोमवार से शुक्रवार 7 बजे', 'AlarmRequest(at 7:00, days 1,2,3,4,5)', null),
    ('hi', '20 मिनट में', 'AlarmRequest(in 20m)', null),
    ('hi', 'सूर्योदय से 30 मिनट पहले', 'AlarmRequest(sunrise -30m)', null),
    (
      'hi',
      'शुक्रवार को मोमबत्ती जलाने का समय कब है?',
      'AlarmRequest(days 5, candleLighting 0m)',
      TimeAnchor.candleLighting,
    ),
    ('ar', 'أيقظني الساعة 7 صباحا', 'AlarmRequest(at 7:00)', null),
    ('ar', 'غدا الساعة 6:30', 'AlarmRequest(at 6:30, dayOffset 1)', null),
    ('ar', 'كل يوم الساعة 7', 'AlarmRequest(at 7:00, days 1,2,3,4,5,6,7)', null),
    ('ar', 'من الاثنين إلى الجمعة الساعة 7', 'AlarmRequest(at 7:00, days 1,2,3,4,5)', null),
    ('ar', 'بعد 20 دقيقة', 'AlarmRequest(in 20m)', null),
    ('ar', 'قبل شروق الشمس بـ30 دقيقة', 'AlarmRequest(sunrise -30m)', null),
    (
      'ar',
      'متى إشعال الشموع يوم الجمعة؟',
      'AlarmRequest(days 5, candleLighting 0m)',
      TimeAnchor.candleLighting,
    ),
    ('ar', 'أيقظني الساعة السابعة والنصف', 'AlarmRequest(at 7:30)', null),
    ('ja', '7時に起こして', 'AlarmRequest(at 7:00)', null),
    ('ja', '明日の朝6時半', 'AlarmRequest(at 6:30, dayOffset 1)', null),
    ('ja', '毎日7時', 'AlarmRequest(at 7:00, days 1,2,3,4,5,6,7)', null),
    ('ja', '月曜から金曜まで7時', 'AlarmRequest(at 7:00, days 1,2,3,4,5)', null),
    ('ja', '20分後', 'AlarmRequest(in 20m)', null),
    ('ja', '日の出の30分前', 'AlarmRequest(sunrise -30m)', null),
    ('ja', '金曜日のろうそく点灯はいつ？', 'AlarmRequest(days 5, candleLighting 0m)', TimeAnchor.candleLighting),
    ('ja', '七時に起こして', 'AlarmRequest(at 7:00)', null),
    ('zh', '早上7点叫醒我', 'AlarmRequest(at 7:00)', null),
    ('zh', '明天6点半', 'AlarmRequest(at 6:30, dayOffset 1)', null),
    ('zh', '每天7点', 'AlarmRequest(at 7:00, days 1,2,3,4,5,6,7)', null),
    ('zh', '星期一到星期五7点', 'AlarmRequest(at 7:00, days 1,2,3,4,5)', null),
    ('zh', '20分钟后', 'AlarmRequest(in 20m)', null),
    ('zh', '日出前30分钟', 'AlarmRequest(sunrise -30m)', null),
    ('zh', '星期五点蜡烛是什么时候？', 'AlarmRequest(days 5, candleLighting 0m)', TimeAnchor.candleLighting),
    ('zh', '七点叫醒我', 'AlarmRequest(at 7:00)', null),
    ('zh', '週五點蠟燭是什麼時候？', 'AlarmRequest(days 5, candleLighting 0m)', TimeAnchor.candleLighting),
    ('ko', '7시에 깨워줘', 'AlarmRequest(at 7:00)', null),
    ('ko', '내일 아침 6시 반', 'AlarmRequest(at 6:30, dayOffset 1)', null),
    ('ko', '매일 7시', 'AlarmRequest(at 7:00, days 1,2,3,4,5,6,7)', null),
    ('ko', '월요일부터 금요일까지 7시', 'AlarmRequest(at 7:00, days 1,2,3,4,5)', null),
    ('ko', '20분 후', 'AlarmRequest(in 20m)', null),
    ('ko', '일출 30분 전', 'AlarmRequest(sunrise -30m)', null),
    ('ko', '금요일 촛불 점화는 언제야?', 'AlarmRequest(days 5, candleLighting 0m)', TimeAnchor.candleLighting),
    ('ko', '일곱 시에 깨워줘', 'AlarmRequest(at 7:00)', null),
  ];
  for (final (lang, text, want, question) in cases) {
    test('[$lang] $text', () {
      expect(const AlarmParser().parse(text, lang: lang).toString(), want);
      expect(readTimeQuestion(text, lang: lang)?.anchor, question);
    });
  }

  test('without the phrasebook, other languages are left alone', () {
    expect(const AlarmParser().parse('завтра в 7')?.dayOffset, isNull);
    expect(const AlarmParser().parse('wake me at 7', lang: 'ja').toString(), 'AlarmRequest(at 7:00)');
  });
}
