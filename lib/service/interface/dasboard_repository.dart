import 'package:my_todo_app/core/type_def/either_type_def.dart';
import 'package:my_todo_app/model/todo_task_model.dart';
import 'package:my_todo_app/presentation/dashboard/bloc/dasboard_bloc.dart';

abstract class DashboardRepository {
  Future<DashboardCategoryCountState> getTaskCounts();

  Future<List<TodoTaskModel>> getLatestTask();
}
