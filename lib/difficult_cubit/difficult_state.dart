part of 'difficult_cubit.dart';

@immutable
sealed class DifficultState extends Equatable {
  int get minimum;
  int get maximum;
  int get attempts;
}

final class DifficultStateEasy extends DifficultState {
  @override
  int get minimum => 1;

  @override
  int get maximum => 10;

  @override
  int get attempts => 5;

  @override
  List<Object?> get props => [minimum, maximum, attempts];
}

final class DifficultStateMedium extends DifficultState {
  @override
  int get minimum => 1;

  @override
  int get maximum => 20;

  @override
  int get attempts => 8;

  @override
  List<Object?> get props => [minimum, maximum, attempts];
}

final class DifficultStateAdvanced extends DifficultState {
  @override
  int get minimum => 1;

  @override
  int get maximum => 100;

  @override
  int get attempts => 15;

  @override
  List<Object?> get props => [minimum, maximum, attempts];
}

final class DifficultStateExtreme extends DifficultState {
  @override
  int get minimum => 1;

  @override
  int get maximum => 1000;

  @override
  int get attempts => 25;

  @override
  List<Object?> get props => [minimum, maximum, attempts];
}
