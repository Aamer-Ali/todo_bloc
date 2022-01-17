import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_bloc/helper/database_helper/repository/task_repository.dart';
import 'package:todo_bloc/model/task.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final TaskRepository taskRepository;

  HomeBloc(this.taskRepository) : super(HomeLoadingState()) {

    on<LoadTaskFromDataBaseEvent>((event, state) async {
      emit(HomeLoadingState());
      final tasks = await taskRepository.getAllTask();
      if (tasks.isNotEmpty) {

        emit(HomeLoadedState(tasks));
      } else {
        emit(HomeDataNotFound());
      }
    });


    on<LoadTaskById>((event, state) async {
      emit(HomeLoadingState());


      // if (task) {
      //   emit(HomeLoadedState(task));
      // } else {
      //   emit(HomeDataNotFound());
      // }
    });
  }
}
