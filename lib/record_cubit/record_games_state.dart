part of 'record_games_cubit.dart';

class RecordGamesState extends Equatable {
  final List<(bool, int)> values;

  const RecordGamesState({required this.values});

  factory RecordGamesState.empty() => const RecordGamesState(values: []);

  RecordGamesState copyWith({
    List<(bool, int)>? values,
  }) {
    return RecordGamesState(
      values: values ?? this.values,
    );
  }

  RecordGamesState copyWithNewValue(bool success, int value) {
    return copyWith(values: [...values, (success, value)]);
  }

  @override
  List<Object?> get props => [...values];
}
