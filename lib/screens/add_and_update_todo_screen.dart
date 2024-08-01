// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:todo_app/cubit/add_and_update_todo/add_and_update_todo_cubit.dart';

import 'package:todo_app/helpers/color_helper.dart';
import 'package:todo_app/helpers/dimension_helper.dart';
import 'package:todo_app/helpers/font_helper.dart';
import 'package:todo_app/helpers/string_helper.dart';
import 'package:todo_app/models/get_all_todo_model.dart';
import 'package:todo_app/utils/loading_indicator.dart';
import 'package:todo_app/utils/snackbar.dart';
import 'package:todo_app/widgets/app_input_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddAndUpdateTodoScreen extends StatefulWidget {
  final Map args;
  const AddAndUpdateTodoScreen({
    super.key,
    required this.args,
  });

  @override
  State<AddAndUpdateTodoScreen> createState() => _AddAndUpdateTodoScreenState();
}

class _AddAndUpdateTodoScreenState extends State<AddAndUpdateTodoScreen> {
  String type = "";
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool isDone = false;
  TodoModel? todo;

  @override
  void initState() {
    if (widget.args.containsKey('type')) {
      type = widget.args['type'];
    }

    if (widget.args.containsKey('todo')) {
      todo = widget.args['todo'];
      titleController.text = todo?.title ?? "";
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: ColorHelper.whiteColor),
        centerTitle: true,
        backgroundColor: ColorHelper.primaryColor,
        automaticallyImplyLeading: false,
        title: Text(
          type == 'add' ? StringHelper.addTodo : StringHelper.updateTodo,
          style: const TextStyle(color: ColorHelper.whiteColor),
        ),
      ),
      body: Column(
        children: [
          AppInput(
            controller: titleController,
            label: "Title",
            obscureText: false,
            prefixIcon: Icons.title,
          ),
          const SizedBox(height: DimensionHelper.size20),
          AppInput(
            controller: descriptionController,
            label: "Description",
            obscureText: false,
            prefixIcon: Icons.description,
          ),
          const SizedBox(height: DimensionHelper.size20),
          SwitchListTile(
              title: const Text(
                'Done',
                style: TextStyle(
                  fontWeight: FontHelper.w400,
                  fontSize: FontHelper.font_16,
                ),
              ),
              value: isDone,
              activeColor: ColorHelper.primaryColor,
              onChanged: (bool? value) {
                setState(
                  () {
                    isDone = value ?? false;
                  },
                );
              }),
          const Divider(),
          BlocProvider(
            create: (context) => AddAndUpdateTodoCubit(),
            child: BlocConsumer<AddAndUpdateTodoCubit, AddAndUpdateTodoState>(
              listener: (context, state) {
                debugPrint(state.toString());
              },
              builder: (context, state) {
                return SizedBox(
                  height: DimensionHelper.size45,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (state is AddAndUpdateTodoError) {
                      } else {
                        if (titleController.text.isEmpty) {
                          toasMessage(context, StringHelper.pleaseEnterTitle);
                        } else {
                          TodoModel todoModel = TodoModel(
                            userId: 1,
                            id: todo?.id,
                            title: titleController.text,
                            completed: isDone,
                          );
                          context
                              .read<AddAndUpdateTodoCubit>()
                              .addAndUpdateTodo(context, type, todoModel);
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorHelper.secondaryColor,
                      foregroundColor: ColorHelper.primaryColor,
                    ),
                    child: state is AddAndUpdateTodoLoading
                        ? loadingIndicator()
                        : Text(
                            type == 'add'
                                ? StringHelper.todoApp
                                : StringHelper.updateTodo,
                            style:
                                const TextStyle(color: ColorHelper.whiteColor),
                          ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
