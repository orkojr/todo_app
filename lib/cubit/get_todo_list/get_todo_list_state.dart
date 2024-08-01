part of 'get_todo_list_cubit.dart';

@immutable
sealed class GetTodoListState {}

final class GetTodoListInitial extends GetTodoListState {}

final class GetTodoListNetworkError extends GetTodoListState {}

final class GetTodoListLoading extends GetTodoListState {}

final class GetTodoListLoaded extends GetTodoListState {
  final List<TodoModel> all;
  final List<TodoModel> todo;
  final List<TodoModel> done;

  GetTodoListLoaded({required this.all, required this.todo, required this.done});
}

final class GetTodoListError extends GetTodoListState {}
