import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:todo_app/helpers/string_helper.dart';
import 'package:todo_app/network_manager/injection.dart';
import 'package:todo_app/utils/connectivity.dart';
import 'package:todo_app/utils/snackbar.dart';

part 'delete_todo_state.dart';

class DeleteTodoCubit extends Cubit<DeleteTodoState> {
  DeleteTodoCubit() : super(DeleteTodoInitial());

  deleteTodo(BuildContext context, int id) async{
    if(await isNetworkAvailable()){
      emit(DeleteTodoLoading());

      client.deleteTodo(id).then((value){
        emit(DeleteTodoLoaded());
        toasMessage(context, StringHelper.deletedSuccessfully);

      }).onError((error, stackTrace){
        emit(DeleteTodoError());
        toasMessage(context, StringHelper.someThingWentWrong);
      });

    }else{
      if(context.mounted){
        toasMessage(context, StringHelper.pleaseCheckInternet);
      }
    }
  }
}
