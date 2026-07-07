part of 'fruits_cubit.dart';

sealed class FruitsState extends Equatable {
  const FruitsState();

  @override
  List<Object?> get props => [];
}

final class FruitsInitial extends FruitsState {
  const FruitsInitial();
}

final class FruitsLoading extends FruitsState {
  const FruitsLoading();
}

final class FruitsLoaded extends FruitsState {
  final List<Fruit> fruits;

  const FruitsLoaded(this.fruits);

  @override
  List<Object?> get props => [fruits];
}

final class FruitsError extends FruitsState {
  final String message;

  const FruitsError(this.message);

  @override
  List<Object?> get props => [message];
}
