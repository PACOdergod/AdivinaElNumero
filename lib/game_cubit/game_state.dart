part of 'game_cubit.dart';

class GameState extends Equatable {
  final List<int> greaterThan;
  final List<int> lessThan;
  final int attempts;
  final int secretNumber;

  const GameState({
    required this.greaterThan,
    required this.lessThan,
    required this.attempts,
    required this.secretNumber,
  });

  GameState copyWith({
    List<int>? greaterThan,
    List<int>? lessThan,
    int? attempts,
    int? secretNumber,
  }) {
    return GameState(
      greaterThan: greaterThan ?? this.greaterThan,
      lessThan: lessThan ?? this.lessThan,
      attempts: attempts ?? this.attempts,
      secretNumber: secretNumber ?? this.secretNumber,
    );
  }

  GameState copyWithOneLessAttempt() {
    return copyWith(attempts: attempts - 1);
  }

  GameState addGreaterThan(int newValue) {
    return copyWith(greaterThan: [...greaterThan, newValue]);
  }

  GameState addLessThan(int newValue) {
    return copyWith(lessThan: [...lessThan, newValue]);
  }

  factory GameState.empty() => const GameState(
      greaterThan: [], lessThan: [], attempts: 0, secretNumber: 0);

  @override
  List<Object?> get props => [
        greaterThan,
        lessThan,
        attempts,
        secretNumber,
      ];
}
