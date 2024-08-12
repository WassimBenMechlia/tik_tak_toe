import 'package:riverpod/riverpod.dart';

class UserChoiceNotifier extends StateNotifier<String> {
  UserChoiceNotifier() : super('');

  void playersChoise(String choise) {
    state = choise;
  }

  String getUserChoice() {
    return state;
  }
}

final userChoiseProvider =
    StateNotifierProvider<UserChoiceNotifier, String>((ref) {
  return UserChoiceNotifier();
});
