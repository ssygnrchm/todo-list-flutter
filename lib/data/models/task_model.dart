import 'dart:convert';

import 'package:my_first_app/domain/entities/task.dart';

class TaskModel extends Task {
  TaskModel({
    required super.id,
    required super.title,
    required super.status,
    required super.category,
  });

  factory TaskModel.fromTask(Task task) {
    return TaskModel(
      id: task.id,
      title: task.title,
      status: task.status,
      category: task.category,
    );
  }

  @override
  TaskModel copyWith({
    String? id,
    String? title,
    String? status,
    String? category,
  }) {
    return TaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      status: status ?? this.status,
      category: category ?? this.category,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {'id': id, 'title': title, 'status': status, 'category': category};
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      status: map['status'] ?? 'todo',
      category: map['category'] ?? '',
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory TaskModel.fromJson(String source) =>
      TaskModel.fromMap(json.decode(source));
}
