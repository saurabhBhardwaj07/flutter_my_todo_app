// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:my_todo_app/core/enum/dashboard_category_enum.dart';
import 'package:my_todo_app/model/todo_task_model.dart';
import 'package:my_todo_app/service/interface/todo_list_repositry.dart';

class TodoListBloc extends Bloc<TodoListEvent, TodoListState> {
  final TodoListRepository repository;

  TodoListBloc(this.repository) : super(TodoInitialState()) {
    on<TodoInitialEvent>(_todoListEvent);
  }

  bool isDesc = true;
  FutureOr<void> _todoListEvent(
      TodoInitialEvent event, Emitter<TodoListState> emit) async {
    emit(TodoLoadingState());
    String? status = event.categoryEnum == DashboardCategoryEnum.complete
        ? "Completed"
        : event.categoryEnum == DashboardCategoryEnum.overdue
            ? "Overdue"
            : event.status;
    final result = await repository.getTodoList(isDesc: isDesc, status: status);

    result.fold((error) {
      emit(TodoErrorState());
    }, (r) {
      emit(TodoResponseState(taskList: r));
    });
  }
}

abstract class TodoListState {}

class TodoInitialState extends TodoListState {}

class TodoLoadingState extends TodoListState {}

class TodoResponseState extends TodoListState {
  final List<TodoTaskModel> taskList;
  TodoResponseState({
    required this.taskList,
  });
}

class TodoErrorState extends TodoListState {}

abstract class TodoListEvent {}

class TodoInitialEvent extends TodoListEvent {
  final DashboardCategoryEnum categoryEnum;
  final String? status;
  TodoInitialEvent({
    required this.categoryEnum,
    this.status,
  });
}
