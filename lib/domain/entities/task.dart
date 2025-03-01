// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Task {
  final String id;
  final String title;
  String status;
  final String category;
  Task({
    required this.id,
    required this.title,
    required this.status,
    required this.category,
  });

  Task copyWith({String? id, String? title, String? status, String? category}) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      status: status ?? this.status,
      category: category ?? this.category,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'status': status,
      'category': category,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'] as String,
      title: map['title'] as String,
      status: map['status'] as String,
      category: map['category'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Task.fromJson(String source) =>
      Task.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Task(id: $id, title: $title, status: $status, category: $category)';
  }

  @override
  bool operator ==(covariant Task other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.status == status &&
        other.category == category;
  }

  @override
  int get hashCode {
    return id.hashCode ^ title.hashCode ^ status.hashCode ^ category.hashCode;
  }
}
