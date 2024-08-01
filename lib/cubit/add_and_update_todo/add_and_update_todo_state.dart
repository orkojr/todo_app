part of 'add_and_update_todo_cubit.dart';

@immutable
sealed class AddAndUpdateTodoState {}

final class AddAndUpdateTodoInitial extends AddAndUpdateTodoState {}

final class AddAndUpdateTodoNetworkError extends AddAndUpdateTodoState {}

final class AddAndUpdateTodoLoading extends AddAndUpdateTodoState {}

final class AddAndUpdateTodoLoaded extends AddAndUpdateTodoState {}

final class AddAndUpdateTodoError extends AddAndUpdateTodoState {}

