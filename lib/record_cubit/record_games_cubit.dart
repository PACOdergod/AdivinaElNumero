import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'record_games_state.dart';

class RecordGamesCubit extends Cubit<RecordGamesState> {
  RecordGamesCubit() : super(RecordGamesState.empty());

  void addNewValue(bool success, int value) {
    emit(state.copyWithNewValue(success, value));
  }
}
