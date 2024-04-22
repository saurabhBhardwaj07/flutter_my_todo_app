import 'package:get_it/get_it.dart';
import 'package:my_todo_app/data/remote/sqflite_remote_client.dart';
import 'package:my_todo_app/presentation/dashboard/bloc/dasboard_bloc.dart';
import 'package:my_todo_app/presentation/todo_list/bloc/todo_list_bloc.dart';
import 'package:my_todo_app/presentation/todo_task/bloc/todo_bloc.dart';
import 'package:my_todo_app/service/impl/dashboard_repository_impl.dart';
import 'package:my_todo_app/service/impl/todo_list_repository_impl.dart';
import 'package:my_todo_app/service/impl/todo_repository_impl.dart';
import 'package:my_todo_app/service/interface/dasboard_repository.dart';
import 'package:my_todo_app/service/interface/todo_list_repositry.dart';
import 'package:my_todo_app/service/interface/todo_repository.dart';

final getIt = GetIt.instance;

Future<void> initializeDependencies() async {
  await setupSyncService();
  setupService();
  setupBloc();
}

DashboardBloc get dashBloc => getIt.get<DashboardBloc>();

void setupBloc() {
  getIt.registerSingleton<DashboardBloc>(DashboardBloc(dashRep));
  getIt.registerFactory<TodoBloc>(() => TodoBloc(todoRepo));
  getIt.registerFactory<TodoListBloc>(() => TodoListBloc(todoListRep));
}

TodoRepository get todoRepo => getIt.get<TodoRepository>();
DashboardRepository get dashRep => getIt.get<DashboardRepository>();
TodoListRepository get todoListRep => getIt.get<TodoListRepository>();
void setupService() {
  getIt.registerLazySingleton<TodoRepository>(
      () => TodoRepositoryImpl(client: client));
  getIt.registerLazySingleton<DashboardRepository>(
      () => DashboardRepositoryImpl(client: client));
  getIt.registerLazySingleton<TodoListRepository>(
      () => TodoListRepositoryImpl(client: client));
}

SqfliteRemoteClient get client => getIt.get<SqfliteRemoteClient>();

Future<void> setupSyncService() async {
  getIt.registerSingleton<SqfliteRemoteClient>(SqfliteRemoteClient());
  await client.initializeDatabase();
}
