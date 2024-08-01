import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_app/models/get_all_todo_model.dart';
import 'package:todo_app/network_manager/injection.dart';
import 'package:todo_app/utils/connectivity.dart';

part 'get_todo_list_state.dart';

class GetTodoListCubit extends Cubit<GetTodoListState> {
  GetTodoListCubit() : super(GetTodoListInitial());

  getTodoList(bool showLoading) async {
    if (await isNetworkAvailable()) {
      if (showLoading) {
        emit(GetTodoListLoading());
      }
      client.getAllTodo().then((value) {
        List<TodoModel> all = [];
        List<TodoModel> todo = [];
        List<TodoModel> done = [];

        all.addAll(value);

        for (var tod in value) {
          if (tod.completed! == true) {
            done.add(tod);
          } else {
            todo.add(tod);
          }
        }

        emit(GetTodoListLoaded(all: all, todo: todo, done: done));
      }).onError((error, stackTrace) {
        emit(GetTodoListError());
      });
    } else {
      emit(GetTodoListNetworkError());
    }
  }
}
