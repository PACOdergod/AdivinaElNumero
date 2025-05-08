import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:desafio/difficult_cubit/difficult_cubit.dart';

part 'game_state.dart';

class GameCubit extends Cubit<GameState> {
  final DifficultCubit difficultCubit;
  late final StreamSubscription _difficultSubscription;

  GameCubit(this.difficultCubit) : super(GameState.empty()) {
    _difficultSubscription = difficultCubit.stream.listen((difficultState) {
      _initNewGame(difficultState);
    });
  }

  void _initNewGame(DifficultState difficultState) {
    emit(GameState(
        greaterThan: [],
        lessThan: [],
        attempts: difficultState.attempts,
        secretNumber: _generateRandomNumber(difficultState)));
  }

  int _generateRandomNumber(DifficultState difficultState) {
    return 5;
  }

  @override
  Future<void> close() {
    _difficultSubscription.cancel();
    return super.close();
  }

  void onSubmittValue(String value) {
    emit(state.addLessThan(1));
  }
}
