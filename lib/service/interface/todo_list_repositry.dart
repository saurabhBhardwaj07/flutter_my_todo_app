import 'package:my_todo_app/core/type_def/either_type_def.dart';
import 'package:my_todo_app/model/todo_task_model.dart';

abstract class TodoListRepository {
  FutureEither<List<TodoTaskModel>> getTodoList(
      {bool isDesc, String? status, bool findToday});
}
