import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_todo_app/core/utils/size_utils.dart';
import 'package:my_todo_app/presentation/dashboard_screen.dart';
import 'package:my_todo_app/presentation/splash_screen.dart';
import 'package:my_todo_app/theme/theme_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
        }
      },
    );
  }
}
