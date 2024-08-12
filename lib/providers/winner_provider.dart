import 'package:flutter_riverpod/flutter_riverpod.dart';

class WinnerNotifier extends StateNotifier<String> {
  WinnerNotifier() : super('');
  void playerWon() {
    state = 'You Won !';
  }

  void botWon() {
    state = 'You Lost !';
  }
}

final finalResltProvider = StateNotifierProvider<WinnerNotifier, String>((ref) {
  return WinnerNotifier();
});
