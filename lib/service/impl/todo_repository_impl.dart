// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fpdart/fpdart.dart';
import 'package:my_todo_app/core/type_def/either_type_def.dart';
import 'package:my_todo_app/data/remote/sqflite_remote_client.dart';
import 'package:my_todo_app/model/sqflite_error_response.dart';
import 'package:my_todo_app/service/interface/todo_repository.dart';

class TodoRepositoryImpl implements TodoRepository {
  final SqfliteRemoteClient client;
  TodoRepositoryImpl({
    required this.client,
  });

  @override
  FutureEither<bool> add(
      String title, String dec, String status, String duwDate) async {
    final data = {
      "title": title,
      "desc": dec,
      "status": status,
      "dueDate": duwDate
    };
    try {
      final resp = await client.add("todo_list", data);
      return right(true);
    } catch (e) {
      return left(SqfliteError(object: e.toString()));
    }
  }

  @override
  FutureEither<bool> delete(int taskId) async {
    try {
      final resp = await client
          .delete("todo_list", where: "id = ?", whereArgs: [taskId]);
      return right(true);
    } catch (e) {
      return left(SqfliteError(object: e.toString()));
    }
  }

  @override
  FutureEither<List<Map<String, dynamic>>> getAll(
      {List<String>? status}) async {
    try {
      List<Map<String, dynamic>> result = [];

      // Construct the WHERE clause based on the status parameter
      String? whereClause;
      List<Object>? whereArgs;

      if (status != null && status.isNotEmpty) {
        whereClause =
            'status IN (${List.generate(status.length, (_) => '?').join(', ')})';
        whereArgs = status;
      }

      // Execute the query
      result = await client.getAll("todo_list",
          where: "", whereArgs: whereArgs, orderBy: "createdAt DESC");

      return Right(result); // Return the list of data
    } catch (e) {
      return Left(SqfliteError(
          object: e
              .toString())); // If an error occurred, return Left with the exception
    }
  }

  @override
  FutureEither<bool> update(int taskId, String title, String dec, String status,
      String duwDate) async {
    final data = {
      "title": title,
      "desc": dec,
      "status": status,
      "dueDate": duwDate
    };
    try {
      final resp = await client
          .update("todo_list", data, where: "id = ?", whereArgs: [taskId]);
      return right(true);
    } catch (e) {
      return left(SqfliteError(object: e.toString()));
    }
  }
}
