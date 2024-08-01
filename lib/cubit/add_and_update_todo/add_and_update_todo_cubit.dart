import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_app/helpers/string_helper.dart';
import 'package:todo_app/models/get_all_todo_model.dart';
import 'package:todo_app/network_manager/injection.dart';
import 'package:todo_app/utils/connectivity.dart';
import 'package:todo_app/utils/snackbar.dart';

part 'add_and_update_todo_state.dart';

class AddAndUpdateTodoCubit extends Cubit<AddAndUpdateTodoState> {
  AddAndUpdateTodoCubit() : super(AddAndUpdateTodoInitial());

  addAndUpdateTodo(
      BuildContext context, String type, TodoModel todoModel) async {
    if (await isNetworkAvailable()) {
      emit(AddAndUpdateTodoLoading());
      if (type == 'add') {
        client.addTodo(todoModel).then((value) {
          Navigator.pop(context, true);

          toasMessage(context, StringHelper.addedSuccessfully);


          emit(AddAndUpdateTodoLoaded());
        }).onError((error, stackTrace) {
          toasMessage(context, StringHelper.someThingWentWrong);
          debugPrint("error: ${error.toString()}");
        });
      } else {
        client.updateTodo(todoModel.id!, todoModel).then((value) {
          Navigator.pop(context, true);

          toasMessage(context, StringHelper.updatedSuccessfully);
          if(type=='done'){
            
          }

          emit(AddAndUpdateTodoLoaded());
        }).onError((error, stackTrace) {
          toasMessage(context, StringHelper.someThingWentWrong);
          debugPrint("error: ${error.toString()}");
        });
      }
    } else {
      emit(AddAndUpdateTodoError());
    }
  }
}
