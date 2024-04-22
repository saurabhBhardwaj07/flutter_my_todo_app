// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fpdart/fpdart.dart';
import 'package:my_todo_app/core/type_def/either_type_def.dart';
import 'package:my_todo_app/data/remote/sqflite_remote_client.dart';
import 'package:my_todo_app/model/sqflite_error_response.dart';
import 'package:my_todo_app/model/todo_task_model.dart';
import 'package:my_todo_app/service/interface/todo_list_repositry.dart';

class TodoListRepositoryImpl extends TodoListRepository {
  final SqfliteRemoteClient client;
  TodoListRepositoryImpl({
    required this.client,
  });
  @override
  FutureEither<List<TodoTaskModel>> getTodoList(
      {bool isDesc = true, String? status, bool findToday = false}) async {
    final today = DateTime.now().toIso8601String();
    // Construct the WHERE clause based on the status parameter
    String? whereClause;
    List<Object>? whereArgs = [];

    try {
      if (status != null && status.isNotEmpty) {
        whereClause = "status = ?";
        whereArgs.add(status);
      }

      if (findToday == true) {
        if (whereClause != null) {
          whereClause += " AND DATE(createdAt) = DATE(?)";
          whereArgs.add(today);
        } else {
          whereClause = "DATE(createdAt) = DATE(?)";
          whereArgs.add(today);
        }
      }
      var resp = await client.getAll("todo_list",
          where: whereClause,
          whereArgs: whereArgs,
          orderBy: isDesc == true ? "createdAt DESC" : "createdAt ASC");

      List<TodoTaskModel> taskList =
          resp.map((e) => TodoTaskModel.fromJson(e)).toList();

      return right(taskList);
    } catch (e) {
      return left(SqfliteError(object: e.toString()));
    }
  }
}
