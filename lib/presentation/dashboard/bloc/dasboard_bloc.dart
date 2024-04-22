// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_todo_app/core/enum/dashboard_category_enum.dart';
import 'package:my_todo_app/model/todo_task_model.dart';
import 'package:my_todo_app/service/interface/dasboard_repository.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final DashboardRepository repository;
  DashboardBloc(this.repository) : super(const DashboardState()) {
    on<DashboardInitialEvent>((event, emit) async {
      emit(state.copyWith(loadedState: true)); // Set loading state
      try {
        final countState = await repository.getTaskCounts();
        final latestTask = await repository.getLatestTask();
        emit(state.copyWith(
          countState: countState,
          latestTask: latestTask,
          loadedState: false, // Set loaded state
        ));
      } catch (e) {
        // Handle error state
        emit(state.copyWith(loadedState: false));
        // You can also emit an error state if needed
      }
    });
  }
}

class DashboardState extends Equatable {
  final DashboardCategoryCountState? countState;
  final List<TodoTaskModel> latestTask;
  final bool loadedState;
  const DashboardState(
      {this.countState = const DashboardCategoryCountState(),
      this.latestTask = const [],
      this.loadedState = false});

  @override
  List<Object?> get props => [countState, latestTask];

  DashboardState copyWith({
    DashboardCategoryCountState? countState,
    List<TodoTaskModel>? latestTask,
    bool? loadedState,
  }) {
    return DashboardState(
      countState: countState ?? this.countState,
      latestTask: latestTask ?? this.latestTask,
      loadedState: loadedState ?? this.loadedState,
    );
  }
}

abstract class DashboardEvent {}

class DashboardInitialEvent extends DashboardEvent {}

class DashboardCategoryCountState {
  final int all;
  final int today;
  final int completed;
  final int overdue;
  const DashboardCategoryCountState({
    this.all = 0,
    this.today = 0,
    this.completed = 0,
    this.overdue = 0,
  });

  int getCountONEnum(DashboardCategoryEnum text) {
    switch (text) {
      case DashboardCategoryEnum.all:
        return all;
      case DashboardCategoryEnum.today:
        return today;
      case DashboardCategoryEnum.complete:
        return completed;
      case DashboardCategoryEnum.overdue:
        return overdue;
      default:
        return 0;
    }
  }
}
