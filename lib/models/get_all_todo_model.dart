// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';





class TodoModel {
    final int? userId;
    final int? id;
    final String? title;
    final bool? completed;

    TodoModel({
        this.userId,
        this.id,
        this.title,
        this.completed,
    });

    factory TodoModel.fromRawJson(String str) => TodoModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory TodoModel.fromJson(Map<String, dynamic> json) => TodoModel(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
        completed: json["completed"],
    );

    Map<String, dynamic> toJson() => {
        "userId": userId,
        "id": id,
        "title": title,
        "completed": completed,
    };
}
