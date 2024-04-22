import 'package:my_todo_app/core/type_def/either_type_def.dart';

abstract class TodoRepository {
  FutureEither<bool> add(
      String title, String dec, String status, String duwDate);
  FutureEither<List<Map<String, dynamic>>> getAll({List<String>? status});
  FutureEither<bool> update(
      int taskId, String title, String dec, String status, String duwDate);
  FutureEither<bool> delete(int taskId);
}
