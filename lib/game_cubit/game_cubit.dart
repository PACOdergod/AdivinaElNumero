import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

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
  }) : super(GameState.empty()) {
    _difficultSubscription = difficultCubit.stream.listen((difficultState) {
      lastDifficultState = difficultState;
      _initNewGame(difficultState);
    });
    _initNewGame(DifficultStateEasy());
  }

  @override
  Future<void> close() {
    _difficultSubscription.cancel();
    return super.close();
  }

  void _initNewGame(DifficultState difficultState) {
    emit(GameState(
        greaterThan: const [],
        lessThan: const [],
        attempts: difficultState.attempts,
        secretNumber: _generateRandomNumber(
            difficultState.minimum, difficultState.maximum)));
  }

  static int _generateRandomNumber(int min, int max) {
    Random random = Random();
    return min + random.nextInt(max - min + 1);
  }

  void onSubmittValue(int userNumber) {
    if (state.secretNumber == userNumber) {
      recordGamesCubit.addNewValue(true, userNumber);
      _initNewGame(lastDifficultState ?? DifficultStateEasy());
      return;
    }

    if (state.attempts == 1) {
      // último intento
      recordGamesCubit.addNewValue(false, userNumber);
      _initNewGame(lastDifficultState ?? DifficultStateEasy());
      return;
    }

    if (state.secretNumber > userNumber) {
      emit(state.addGreaterThan(userNumber).copyWithOneLessAttempt());
    } else if (state.secretNumber < userNumber) {
      emit(state.addLessThan(userNumber).copyWithOneLessAttempt());
    }
  }
}
