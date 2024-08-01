// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:todo_app/cubit/add_and_update_todo/add_and_update_todo_cubit.dart';
import 'package:todo_app/cubit/get_todo_list/get_todo_list_cubit.dart';

import 'package:todo_app/helpers/color_helper.dart';
import 'package:todo_app/helpers/dimension_helper.dart';
import 'package:todo_app/helpers/font_helper.dart';
import 'package:todo_app/models/get_all_todo_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/utils/loading_indicator.dart';

class DoneButton extends StatelessWidget {
  final TodoModel todoModel;
  const DoneButton({
    super.key,
    required this.todoModel,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddAndUpdateTodoCubit(),
      child: BlocConsumer<AddAndUpdateTodoCubit, AddAndUpdateTodoState>(
        listener: (context, state) {
          if (state is AddAndUpdateTodoLoaded) {
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              context.read<GetTodoListCubit>().getTodoList(false);
            });
          }
        },
        builder: (context, state) {
          return GestureDetector(
            onTap: () {
              if (todoModel.completed == true) {
                TodoModel todoModel1 = TodoModel(
                  userId: todoModel.userId,
                  id: todoModel.id,
                  title: todoModel.title,
                  completed: true,
                );
                context
                    .read<AddAndUpdateTodoCubit>()
                    .addAndUpdateTodo(context, 'done', todoModel1);
              }
            },
            child: Container(
              alignment: Alignment.center,
              width: DimensionHelper.size130,
              height: DimensionHelper.size35,
              decoration: BoxDecoration(
                color: ColorHelper.primaryColor,
                borderRadius: BorderRadius.circular(DimensionHelper.size50),
              ),
              child: state is AddAndUpdateTodoLoading? loadingIndicator(loadingColor: ColorHelper.secondaryColor): Text(
                todoModel.completed == true ? "Done" : "Mark as Done",
                style: const TextStyle(
                  color: ColorHelper.whiteColor,
                  fontSize: FontHelper.font_16,
                  fontWeight: FontHelper.w400,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
