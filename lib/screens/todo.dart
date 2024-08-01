// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/cubit/get_todo_list/get_todo_list_cubit.dart';

import 'package:todo_app/helpers/color_helper.dart';
import 'package:todo_app/helpers/dimension_helper.dart';
import 'package:todo_app/helpers/font_helper.dart';
import 'package:todo_app/helpers/string_helper.dart';
import 'package:todo_app/models/get_all_todo_model.dart';
import 'package:todo_app/routes/route_name.dart';
import 'package:todo_app/widgets/delete_button.dart';
import 'package:todo_app/widgets/done_button.dart';

class Todo extends StatelessWidget {
  final List<TodoModel> todoList;
  const Todo({
    super.key,
    required this.todoList,
  });

  @override
  Widget build(BuildContext context) {
    return todoList.isEmpty
        ? Center(
            child: Text(
              StringHelper.noTodoFound,
              style: TextStyle(
                  // color: ColorHelper.blackColor,
                  fontWeight: FontHelper.w400,
                  fontSize: FontHelper.font_14,
                  color: ColorHelper.secondaryColor),
            ),
          )
        : ListView.separated(
            itemCount: todoList.length,
            itemBuilder: (context, index) {
              var todo = todoList[index];
              return GestureDetector(
                onTap: () async {
                  dynamic showLoading = await Navigator.pushNamed(
                    context,
                    RouteName.addAndUpdateTodoScreen,
                    arguments: {
                      'type': 'update',
                      'todo': todo,
                    },
                  );
                  if (showLoading == true) {
                    if (context.mounted) {
                      context.read<GetTodoListCubit>().getTodoList(true);
                    }
                  }
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: DimensionHelper.size12,
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: DimensionHelper.size8,
                      vertical: DimensionHelper.size8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(DimensionHelper.size12),
                    border: Border.all(color: ColorHelper.primaryColor),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              "${todo.title}",
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                // color: ColorHelper.blackColor,
                                fontWeight: FontHelper.w500,
                                fontSize: FontHelper.font_18,
                              ),
                            ),
                          ),
                          DeleteButton(
                            id: todo.id!,
                          ),
                        ],
                      ),
                      Text(
                        " user ID${todo.userId}",
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          // color: ColorHelper.blackColor,
                          fontWeight: FontHelper.w400,
                          fontSize: FontHelper.font_16,
                        ),
                      ),
                      const SizedBox(height: DimensionHelper.size12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          DoneButton(todoModel: todo),
                          Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(
                              horizontal: DimensionHelper.size16,
                              vertical: DimensionHelper.size8,
                            ),
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: ColorHelper.primaryColor),
                              borderRadius:
                                  BorderRadius.circular(DimensionHelper.size50),
                            ),
                            child: Text(
                              "${todo.id}",
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                // color: ColorHelper.blackColor,
                                fontWeight: FontHelper.w400,
                                fontSize: FontHelper.font_14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (context, i) => const SizedBox(
              height: DimensionHelper.size8,
            ),
          );
  }
}
