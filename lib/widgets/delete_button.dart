// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:todo_app/cubit/delete_todo/delete_todo_cubit.dart';
import 'package:todo_app/cubit/get_todo_list/get_todo_list_cubit.dart';

import 'package:todo_app/helpers/color_helper.dart';
import 'package:todo_app/helpers/dimension_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/utils/loading_indicator.dart';

class DeleteButton extends StatelessWidget {
  final int id;
  const DeleteButton({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DeleteTodoCubit(),
      child: BlocConsumer<DeleteTodoCubit, DeleteTodoState>(
        listener: (context, state) {
          if (state is DeleteTodoLoaded) {
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              context.read<GetTodoListCubit>().getTodoList(false);
            });
          }
        },
        builder: (context, state) {
          return GestureDetector(
            onTap: () {
              if (state is DeleteTodoLoading) {
              } else {
                context.read<DeleteTodoCubit>().deleteTodo(context, id);
              }
            },
            child: Container(
              alignment: Alignment.center,
              width: DimensionHelper.size80,
              height: DimensionHelper.size35,
              decoration: BoxDecoration(
                color: ColorHelper.redColor.withOpacity(.2),
                borderRadius: BorderRadius.circular(DimensionHelper.size50),
              ),
              child: state is DeleteTodoLoading
                  ? loadingIndicator(loadingColor: ColorHelper.redColor)
                  : const Icon(
                      Icons.delete_outline,
                      color: ColorHelper.redColor,
                    ),
            ),
          );
        },
      ),
    );
  }
}
