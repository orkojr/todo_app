import 'package:flutter/material.dart';
import 'package:todo_app/helpers/string_helper.dart';

class NoRouteFound extends StatelessWidget {
  const NoRouteFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(StringHelper.someThingWentWrong),
        centerTitle: true,
      ),
      body: const Center(
        child: Center(
          child: Text(StringHelper.someThingWentWrong),
        ),
      ),
    );
  }
}
