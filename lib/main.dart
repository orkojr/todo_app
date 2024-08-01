import 'package:flutter/material.dart';
import 'package:todo_app/helpers/string_helper.dart';
import 'package:todo_app/routes/route_name.dart';
import 'package:todo_app/routes/routes.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: StringHelper.todoApp,
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(useMaterial3: true),
      darkTheme: ThemeData.dark(useMaterial3: true),
      initialRoute: RouteName.homeScreen,
      onGenerateRoute:Routes.onGenerateRoute,
    );
  }
}
