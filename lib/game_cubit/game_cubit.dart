import 'package:bloc/bloc.dart';

part 'game_state.dart';

class GameCubit extends Cubit<GameState> {
  GameCubit() : super(GameState.empty());

  void onSubmittValue(String value) {
    emit(state.addGreaterThan(1));
  }
}
