import 'package:my_first_app/data/models/task_model.dart';
import 'package:my_first_app/database_helper.dart';

class TaskSqliteDatasource {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  // retrieve tasks based on category from database
  Future<List<TaskModel>> getTask(String category) async {
    return await _databaseHelper.getTasks(category);
  }

  // add task to task table in category
  Future<void> addTask(TaskModel task) async {
    await _databaseHelper.insertTask(task);
  }

  Future<void> updateTaskStatus(String id, String status) async {
    await _databaseHelper.updateTaskStatus(id, status);
  }

  Future<void> deleteTask(String id) async {
    await _databaseHelper.deleteTask(id);
  }

  Future<void> addCategory(String category) async {
    await _databaseHelper.insertCategory(category);
  }

  Future<List<String>> getAllCategories() async {
    return await _databaseHelper.getAllCategories();
  }

  Future<void> deleteCategory(String category) async {
    await _databaseHelper.deleteCategory(category);
  }
}
