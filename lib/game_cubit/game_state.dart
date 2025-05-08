part of 'game_cubit.dart';

class GameState {
  final List<int> greaterThan;
  final List<int> lessThan;
  final int attempts;

  const GameState({
    required this.greaterThan,
    required this.lessThan,
    required this.attempts,
  });

  factory GameState.empty() =>
      const GameState(greaterThan: [], lessThan: [], attempts: 0);

  GameState copyWith({
    List<int>? greaterThan,
    List<int>? lessThan,
    int? attempts,
  }) {
    return GameState(
      greaterThan: greaterThan ?? this.greaterThan,
      lessThan: lessThan ?? this.lessThan,
      attempts: attempts ?? this.attempts,
    );
  }

  GameState addGreaterThan(int newValue) {
    return copyWith(greaterThan: [...greaterThan, newValue]);
  }

  GameState addLessThan(int newValue) {
    return copyWith(lessThan: [...lessThan, newValue]);
  }
}
