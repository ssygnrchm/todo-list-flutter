// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:my_first_app/data/datasources/local/task_sqlite_datasource.dart';
import 'package:my_first_app/data/models/task_model.dart';
import 'package:my_first_app/domain/entities/task.dart';
import 'package:my_first_app/domain/repositories/task_repository.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskSqliteDatasource datasource;
  TaskRepositoryImpl({required this.datasource});

  @override
  Future<void> addCategory(String category) async {
    // TODO: implement addCategory
    await datasource.addCategory(category);
  }

  @override
  Future<void> addTask(Task task) async {
    // TODO: implement addTask
    final taskModel = TaskModel.fromTask(task);
    await datasource.addTask(taskModel);
  }

  @override
  Future<void> deleteTask(String id) async {
    // TODO: implement deleteTask
    await datasource.deleteTask(id);
  }

  @override
  Future<List<String>> getAllCategories() async {
    // TODO: implement getAllCategories
    return await datasource.getAllCategories();
  }

  @override
  Future<List<Task>> getTask(String category) async {
    // TODO: implement getTask
    return await datasource.getTask(category);
  }

  @override
  Future<void> updateTaskStatus(String id, String status) async {
    // TODO: implement updateTaskStatus
    await datasource.updateTaskStatus(id, status);
  }
}
