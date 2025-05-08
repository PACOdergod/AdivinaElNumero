import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'difficult_state.dart';

class DifficultCubit extends Cubit<DifficultState> {
  DifficultCubit() : super(DifficultStateEasy());

  void selectEasy() {
    emit(DifficultStateEasy());
  }

  void selectMedium() {
    emit(DifficultStateMedium());
  }

  void selectAdvanced() {
    emit(DifficultStateAdvanced());
  }

  void selectExtreme() {
    emit(DifficultStateExtreme());
  }
}
