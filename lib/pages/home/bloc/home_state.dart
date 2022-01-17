part of 'home_bloc.dart';

@immutable
abstract class HomeState extends Equatable {}

class HomeLoadingState extends HomeState {
  @override
  List<Object?> get props => [];
}

class HomeLoadedState extends HomeState {
  final List<Task> tasks;

  HomeLoadedState(this.tasks);

  @override
  List<Object?> get props => [tasks];
}

class HomeDataNotFound extends HomeState {
  @override
  List<Object?> get props => [];
}
