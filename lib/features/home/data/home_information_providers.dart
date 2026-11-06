import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/providers.dart';
import '../../shabbat/domain/place.dart';
import 'weather_repository.dart';
import 'learning_repository.dart';

final weatherRepositoryProvider = Provider<WeatherRepository>((ref) {
  final repo = WeatherRepository(ref.read(prefsProvider));
  ref.onDispose(repo.close);
  return repo;
});
final weatherReportProvider = FutureProvider.autoDispose.family<WeatherReport, (Place, int)>(
  (ref, key) => ref.watch(weatherRepositoryProvider).load(key.$1),
);
final learningRepositoryProvider = Provider<LearningRepository>((ref) {
  final repo = LearningRepository(ref.read(prefsProvider));
  ref.onDispose(repo.close);
  return repo;
});
final learningMonthProvider = FutureProvider.autoDispose.family<List<LearningReading>, (int, int, bool)>(
  (ref, key) => ref.watch(learningRepositoryProvider).month(DateTime(key.$1, key.$2), inIsrael: key.$3),
);
