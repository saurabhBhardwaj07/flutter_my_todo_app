import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_todo_app/core/enum/dashboard_category_enum.dart';
import 'package:my_todo_app/core/utils/size_utils.dart';
import 'package:my_todo_app/di_injector.dart';
import 'package:my_todo_app/model/todo_task_model.dart';
import 'package:my_todo_app/presentation/todo_task/add_edit_task_Screen.dart';
import 'package:my_todo_app/presentation/dashboard/dashboard_screen.dart';
import 'package:my_todo_app/presentation/splash_screen.dart';
import 'package:my_todo_app/presentation/todo_list/todo_list_screen.dart';
import 'package:my_todo_app/theme/theme_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Color(0xffF2F7F2),
    statusBarIconBrightness: Brightness.dark,
  ));
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return MaterialApp(
      title: 'My Todo App',
      theme: theme,
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: <String, WidgetBuilder>{
        "/": (BuildContext context) {
          return const AppsSplashScreen();
        },
        "dashboard": (BuildContext context) {
          return const DashboardScreen();
        },
        "addEditTask": (BuildContext context) {
          final model =
              ModalRoute.of(context)!.settings.arguments as TodoTaskModel?;
          return AddEditTaskScreen(
            model: model,
          );
        },
        "todoList": (BuildContext context) {
          final category = ModalRoute.of(context)!.settings.arguments
              as DashboardCategoryEnum;
          return TodoListScreen(
            category: category,
          );
        }
      },
    );
  }
}
