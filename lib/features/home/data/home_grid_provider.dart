import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/providers.dart';
import '../domain/home_grid.dart';

/// The card grid for each screen width (4 columns on phones, 12 on iPad and
/// Mac), kept between launches.
class HomeGridNotifier extends Notifier<Map<int, HomeGrid>> {
  static String _key(int cols) => 'home.grid.$cols';

  @override
  Map<int, HomeGrid> build() => const {};

  HomeGrid of(int cols) => state[cols] ?? _load(cols);

  HomeGrid _load(int cols) {
    final saved = HomeGrid.decode(ref.read(prefsProvider).getString(_key(cols)), cols);
    return saved ?? HomeGrid.defaults(cols, shabbat: ref.read(shabbatInUseProvider));
  }

  Future<void> set(HomeGrid g) async {
    state = {...state, g.cols: g};
    await ref.read(prefsProvider).setString(_key(g.cols), g.encode());
  }

  Future<void> reset(int cols) async {
    await ref.read(prefsProvider).remove(_key(cols));
    state = {...state}..remove(cols);
  }
}

final homeGridProvider = NotifierProvider<HomeGridNotifier, Map<int, HomeGrid>>(HomeGridNotifier.new);
