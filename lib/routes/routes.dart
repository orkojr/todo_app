import 'package:flutter/material.dart';
import 'package:todo_app/cubit/get_todo_list/get_todo_list_cubit.dart';
import 'package:todo_app/routes/route_name.dart';
import 'package:todo_app/screens/add_and_update_todo_screen.dart';
import 'package:todo_app/screens/home_screen.dart';
import 'package:todo_app/screens/no_route_found.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Routes {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.homeScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => GetTodoListCubit(),
            child: const HomeScreen(),
          ),
        );
      case RouteName.addAndUpdateTodoScreen:
        final args = settings.arguments as Map;
        return MaterialPageRoute(
            builder: (context) => AddAndUpdateTodoScreen(args: args));

      default:
        return MaterialPageRoute(builder: (context) => const NoRouteFound());
    }
  }
}
