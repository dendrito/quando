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

  void hide(HomeBlock b) => setBlock(b, state.of(b).copyWith(hidden: true));

  void unhide(HomeBlock b) => setBlock(b, state.of(b).copyWith(hidden: false));

  void reset() => _set(const HomeLayout());
}

final homeLayoutProvider = NotifierProvider<HomeLayoutNotifier, HomeLayout>(HomeLayoutNotifier.new);

/// The one-time hint about dragging and resizing cards; true once it has been dismissed.
class HomeLayoutHintNotifier extends Notifier<bool> {
  static const _key = 'home.layoutHint.seen';

  @override
  bool build() => ref.read(prefsProvider).getBool(_key) ?? false;

  void dismiss() {
    state = true;
    ref.read(prefsProvider).setBool(_key, true);
  }
}

final homeLayoutHintSeenProvider = NotifierProvider<HomeLayoutHintNotifier, bool>(HomeLayoutHintNotifier.new);
