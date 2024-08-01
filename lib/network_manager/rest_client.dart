
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';
import 'package:todo_app/models/get_all_todo_model.dart';

part 'rest_client.g.dart';

@RestApi(baseUrl: '')
abstract class RestClient{
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET('/todos')
  Future<List<TodoModel>> getAllTodo();

  @POST('/todos')
  Future<TodoModel> addTodo(@Body() TodoModel todoModel);

  @PUT('/todos/{id}')
  Future<TodoModel> updateTodo(@Path() int id, @Body() TodoModel todoModel);

  @DELETE('/todos/{id}')
  Future<TodoModel> deleteTodo(@Path() int id);
}