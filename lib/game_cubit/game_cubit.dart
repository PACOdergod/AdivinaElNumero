import 'dart:async';

import 'package:bloc/bloc.dart';

import '../difficult_cubit/difficult_cubit.dart';

part 'game_state.dart';

class GameCubit extends Cubit<GameState> {
  final DifficultCubit difficultCubit;
  late final StreamSubscription _difficultSubscription;

  GameCubit(this.difficultCubit) : super(initialGameState()) {
    _difficultSubscription = difficultCubit.stream.listen((difficultState) {
      _initNewGame(difficultState);
    });
  }

  static GameState initialGameState() {
    return GameState(
        greaterThan: [],
        lessThan: [],
        attempts: 5,
        secretNumber: _generateRandomNumber(10));
  }

  void _initNewGame(DifficultState difficultState) {
    emit(GameState(
        greaterThan: [],
        lessThan: [],
        attempts: difficultState.attempts,
        secretNumber: _generateRandomNumber(difficultState.maximum)));
  }

  static int _generateRandomNumber(int maximum) {
    return 5;
  }

  @override
  Future<void> close() {
    _difficultSubscription.cancel();
    return super.close();
  }

  void onSubmittValue(int userNumber) {
    if (state.secretNumber > userNumber) {
      emit(state.addGreaterThan(userNumber).copyWithOneLessAttempt());
    } else if (state.secretNumber < userNumber) {
      emit(state.addLessThan(userNumber).copyWithOneLessAttempt());
    } else {
      print('exito');
    }
  }
}
