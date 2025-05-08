import 'dart:async';

import 'package:bloc/bloc.dart';

import '../difficult_cubit/difficult_cubit.dart';
import '../record_cubit/record_games_cubit.dart';

part 'game_state.dart';

class GameCubit extends Cubit<GameState> {
  final DifficultCubit difficultCubit;
  final RecordGamesCubit recordGamesCubit;

  late final StreamSubscription _difficultSubscription;
  DifficultState? lastDifficultState;

  GameCubit({
    required this.difficultCubit,
    required this.recordGamesCubit,
  }) : super(initialGameState()) {
    _difficultSubscription = difficultCubit.stream.listen((difficultState) {
      lastDifficultState = difficultState;
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
      // Exito
      _onSuccess(userNumber);
    }
  }

  void _onSuccess(int userNumber) {
    recordGamesCubit.addNewValue(true, userNumber);

    final newState = GameState(
        greaterThan: [],
        lessThan: [],
        attempts: lastDifficultState?.attempts ?? 5,
        secretNumber: _generateRandomNumber(lastDifficultState?.maximum ?? 10));
    emit(newState);
  }
}
