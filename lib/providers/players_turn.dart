import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlayersTurnNotifier extends StateNotifier<String> {
  PlayersTurnNotifier() : super('playersTurn');
  void userPlayed() {
    if (state == 'playersTurn') {
      state = 'botsTurn';
    } else {
      state = 'playersTurn';
    }
  }

  void endGame() {
    state = 'playersTurn';
  }
}

final playersTurnProvider =
    StateNotifierProvider<PlayersTurnNotifier, String>((ref) {
  return PlayersTurnNotifier();
});
