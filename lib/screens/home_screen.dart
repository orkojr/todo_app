import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/cubit/get_todo_list/get_todo_list_cubit.dart';
import 'package:todo_app/helpers/color_helper.dart';
import 'package:todo_app/helpers/dimension_helper.dart';
import 'package:todo_app/helpers/font_helper.dart';
import 'package:todo_app/helpers/string_helper.dart';
import 'package:todo_app/routes/route_name.dart';
import 'package:todo_app/screens/todo.dart';
import 'package:todo_app/utils/loading_indicator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    context.read<GetTodoListCubit>().getTodoList(true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: ColorHelper.primaryColor,
          automaticallyImplyLeading: false,
          title: const Text(
            StringHelper.todoApp,
            style: TextStyle(color: ColorHelper.whiteColor),
          ),
          bottom: const TabBar(
            labelPadding:
                EdgeInsets.symmetric(vertical: DimensionHelper.size10),
            unselectedLabelStyle: TextStyle(
              color: ColorHelper.whiteColor,
              fontWeight: FontHelper.w500,
              fontSize: FontHelper.font_16,
            ),
            unselectedLabelColor: ColorHelper.whiteColor,
            labelStyle: TextStyle(
              color: ColorHelper.whiteColor,
              fontWeight: FontHelper.w500,
              fontSize: FontHelper.font_16,
            ),
            tabs: [
              Text(StringHelper.all),
              Text(StringHelper.todo),
              Text(StringHelper.done),
            ],
          ),
        ),
        body: BlocConsumer<GetTodoListCubit, GetTodoListState>(
          listener: (context, state) {
            debugPrint(state.toString());
          },
          builder: (context, state) {
            if (state is GetTodoListNetworkError) {
              return const Center(
                  child: Text(StringHelper.pleaseCheckInternet));
            } else if (State is GetTodoListLoading) {
              return loadingIndicator();
            } else if (state is GetTodoListError) {
              return const Center(child: Text(StringHelper.someThingWentWrong));
            } else if (state is GetTodoListLoaded) {
              return TabBarView(children: [
                Todo(todoList: state.all),
                Todo(todoList: state.todo),
                Todo(todoList: state.done),
              ]);
            }
            return const SizedBox();
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            dynamic showLoading = await Navigator.pushNamed(
              context,
              RouteName.addAndUpdateTodoScreen,
              arguments: {'type': 'add'},
            );

            if (showLoading == true) {
              if(context.mounted){
                context.read<GetTodoListCubit>().getTodoList(true);
              }
            }
          },
          backgroundColor: ColorHelper.secondaryColor,
          child: Icon(
            Icons.add,
            color: ColorHelper.primaryColor,
          ),
        ),
      ),
    );
  }
}
