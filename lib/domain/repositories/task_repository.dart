import 'package:my_first_app/domain/entities/task.dart';

abstract class TaskRepository {
  Future<List<Task>> getTask(String category);
  Future<void> addTask(Task task);
  Future<void> updateTaskStatus(String id, String status);
  Future<void> deleteTask(String id);

  Future<List<String>> getAllCategories();
  Future<void> addCategory(String category);
  Future<void> deleteCategory(String category);
}
