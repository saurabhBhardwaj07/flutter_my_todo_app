// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:my_todo_app/service/interface/todo_repository.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRepository repository;

  TodoBloc(this.repository) : super(TodoInitialState()) {
    on<AddTodoEvent>((event, emit) async {
      final result = await repository.add(
          event.title, event.dec, event.status, event.duwDate);
      result.fold((e) {
        emit(TodoErrorActionState());
      }, (resp) {
        emit(TodoSuccessActionState());
      });
    });

    on<DeleteTodoEvent>((event, emit) async {
      final result = await repository.delete(event.id);
      result.fold((e) {
        emit(TodoErrorActionState());
      }, (resp) {
        emit(TodoSuccessActionState());
      });
    });

    on<UpdateTodoEvent>((event, emit) async {
      final result = await repository.update(
          event.taskId, event.title, event.dec, event.status, event.duwDate);
      result.fold((e) {
        emit(TodoErrorActionState());
      }, (resp) {
        emit(TodoSuccessActionState());
      });
    });
  }

  @override
  void onChange(Change<TodoState> change) {
    log(change.toString());
    super.onChange(change);
  }
}

abstract class TodoState {}

class TodoInitialState extends TodoState {}

abstract class TodoActionState extends TodoState {}

class TodoSuccessActionState extends TodoActionState {}

class TodoErrorActionState extends TodoActionState {}

abstract class TodoEvent {}

class AddTodoEvent extends TodoEvent {
  final String title;
  final String dec;
  final String status;
  final String duwDate;
  AddTodoEvent({
    required this.title,
    required this.dec,
    required this.status,
    required this.duwDate,
  });
}

class DeleteTodoEvent extends TodoEvent {
  final int id;
  DeleteTodoEvent({
    required this.id,
  });
}

class UpdateTodoEvent extends TodoEvent {
  final int taskId;
  final String title;
  final String dec;
  final String status;
  final String duwDate;
  UpdateTodoEvent({
    required this.taskId,
    required this.title,
    required this.dec,
    required this.status,
    required this.duwDate,
  });
}
