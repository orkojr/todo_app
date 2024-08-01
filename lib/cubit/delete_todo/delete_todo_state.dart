part of 'delete_todo_cubit.dart';

@immutable
sealed class DeleteTodoState {}

final class DeleteTodoInitial extends DeleteTodoState {}

final class DeleteTodoNetworkError extends DeleteTodoState {}

final class DeleteTodoLoading extends DeleteTodoState {}

final class DeleteTodoLoaded extends DeleteTodoState {}

final class DeleteTodoError extends DeleteTodoState {}
