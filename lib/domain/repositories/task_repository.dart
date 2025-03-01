import 'package:my_first_app/domain/entities/task.dart';

abstract class TaskRepository {
  List<Task> getTask(String category);
  void addTask(Task task);
  void updateTaskStatus(String id, String status);
  void deleteTask(String id);

  List<String> getAllCategories();
  void addCategory(String category);
}
