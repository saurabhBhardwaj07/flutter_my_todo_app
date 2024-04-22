import 'package:fpdart/fpdart.dart';
import 'package:my_todo_app/model/sqflite_error_response.dart';

typedef FutureEither<T> = Future<Either<SqfliteError, T>>;
