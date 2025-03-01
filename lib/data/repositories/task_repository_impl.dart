import 'package:my_first_app/data/datasources/local/task_memory_datasource.dart';
import 'package:my_first_app/data/models/task_model.dart';
import 'package:my_first_app/domain/entities/task.dart';
import 'package:my_first_app/domain/repositories/task_repository.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskMemoryDataSource dataSource;

  TaskRepositoryImpl(this.dataSource);

  @override
  List<Task> getTask(String category) {
    // TODO: implement getTask
    return dataSource.getTask(category);
  }

  @override
  void addTask(Task task) {
    // TODO: implement addTask
    final taskModel = TaskModel.fromTask(task);
    dataSource.addTask(taskModel);
  }

  @override
  void updateTaskStatus(String id, String status) {
    // TODO: implement updateTaskStatus
    dataSource.updateTaskStatus(id, status);
  }

  @override
  void deleteTask(String id) {
    // TODO: implement deleteTask
    dataSource.deleteTask(id);
  }

  @override
  List<String> getAllCategories() {
    // TODO: implement getAllCategories
    return dataSource.getAllCategories();
  }

  @override
  void addCategory(String category) {
    // TODO: implement addCategory
    dataSource.addCategory(category);
  }
}
