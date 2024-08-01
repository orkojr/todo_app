

import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:todo_app/network_manager/rest_client.dart';

final  client = RestClient(dio, baseUrl: 'https://jsonplaceholder.typicode.com');


final dio = getDio();

Dio getDio(){
  BaseOptions options =  BaseOptions(
    receiveDataWhenStatusError: true,
    contentType: 'application/json',
    sendTimeout: const Duration(seconds: 10),
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30)
   
  );

  Dio dio = Dio(options);

  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (request, handler){
        log("Body: ${jsonEncode(request.data?? "")}");
        return handler.next(request);
      },
      onResponse: (Response response, ResponseInterceptorHandler handler){
        log("Response: ${jsonEncode(response.data?? "")}");
        return handler.next(response);

      },

      onError: (DioException e, handler){
        final response = e.response;

        log("Error: ${jsonEncode(e.toString())}   ||Status code: ${response?.statusCode}");
        if(response?.statusCode == 401){
          //navigate here
        }
        return handler.next(e);
      }
    )
  );

  return dio;
}