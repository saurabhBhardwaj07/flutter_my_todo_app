import 'package:my_todo_app/core/type_def/either_type_def.dart';
import 'package:my_todo_app/data/remote/sqflite_remote_client.dart';
import 'package:my_todo_app/model/todo_task_model.dart';
import 'package:my_todo_app/presentation/dashboard/bloc/dasboard_bloc.dart';
import 'package:my_todo_app/service/interface/dasboard_repository.dart';
import 'package:sqflite/sqflite.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  final SqfliteRemoteClient client;
  DashboardRepositoryImpl({
    required this.client,
  });
  @override
  Future<DashboardCategoryCountState> getTaskCounts() async {
    final today = DateTime.now().toIso8601String();
    final totalResult = await client.rawQuery('SELECT COUNT(*) FROM todo_list');
    final todayResult = await client.rawQuery(
        'SELECT COUNT(*) FROM todo_list WHERE DATE(createdAt) = DATE(?)',
        [today]);
    final completedResult = await client.rawQuery(
        'SELECT COUNT(*) FROM todo_list WHERE status = ?', ['Completed']);
    final overdueResult = await client.rawQuery(
        'SELECT COUNT(*) FROM todo_list WHERE status = ?', ['Overdue']);

    final total = Sqflite.firstIntValue(totalResult) ?? 0;
    final todayCount = Sqflite.firstIntValue(todayResult) ?? 0;
    final completedCount = Sqflite.firstIntValue(completedResult) ?? 0;
    final overdueCount = Sqflite.firstIntValue(overdueResult) ?? 0;

    return DashboardCategoryCountState(
        all: total,
        today: todayCount,
        completed: completedCount,
        overdue: overdueCount);
  }

  @override
  Future<List<TodoTaskModel>> getLatestTask() async {
    var resp = await client.getAll(
      "todo_list",
      limit: 20,
      orderBy: 'createdAt DESC',
    );
    List<TodoTaskModel> taskList =
        resp.map((e) => TodoTaskModel.fromJson(e)).toList();
    return taskList;
  }
}
