part of 'home_bloc.dart';

@immutable
abstract class HomeEvent extends Equatable {}

class LoadTaskFromDataBaseEvent extends HomeEvent {
  @override
  List<Object?> get props => [];
}

class LoadTaskById extends HomeEvent {
  @override
  List<Object?> get props => [];
}
