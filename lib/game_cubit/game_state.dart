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
}
