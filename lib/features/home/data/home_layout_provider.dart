import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/providers.dart';
import '../domain/home_layout.dart';

class HomeLayoutNotifier extends Notifier<HomeLayout> {
  static const _key = 'home.layout';

  @override
  HomeLayout build() => HomeLayout.decode(ref.read(prefsProvider).getString(_key)) ?? const HomeLayout();

  Future<void> _set(HomeLayout v) async {
    state = v;
    await ref.read(prefsProvider).setString(_key, v.encode());
  }

  void setBlock(HomeBlock b, BlockState s) => _set(state.withState(b, s));

  void toggle(HomeBlock b) => setBlock(b, state.of(b).copyWith(collapsed: !state.of(b).collapsed));

  void move(List<HomeBlock> visible, int from, int to) => _set(state.move(visible, from, to));

  void reset() => _set(const HomeLayout());
}

final homeLayoutProvider = NotifierProvider<HomeLayoutNotifier, HomeLayout>(HomeLayoutNotifier.new);
