import 'package:my_first_app/data/models/task_model.dart';

class TaskMemoryDataSource {
  final Map<String, List<TaskModel>> _categoryTask = {
    'daily_task': [
      TaskModel(
        id: '1',
        title: 'baca buku',
        status: 'todo',
        category: 'daily_task',
      ),
      TaskModel(
        id: '2',
        title: 'kerjain tugas',
        status: 'todo',
        category: 'daily_task',
      ),
      TaskModel(
        id: '3',
        title: 'cuci baju',
        status: 'done',
        category: 'daily_task',
      ),
    ],
    'homeworks': [
      TaskModel(
        id: '4',
        title: 'Physic A-1',
        status: 'todo',
        category: 'homeworks',
      ),
      TaskModel(
        id: '5',
        title: 'Math A-9',
        status: 'done',
        category: 'homeworks',
      ),
      TaskModel(
        id: '6',
        title: 'Math A-2',
        status: 'done',
        category: 'homeworks',
      ),
      TaskModel(
        id: '7',
        title: 'Bio A-6',
        status: 'todo',
        category: 'homeworks',
      ),
    ],
    'other': [],
  };

  List<TaskModel> getTask(String category) {
    return _categoryTask[category] ?? [];
  }

  void addTask(TaskModel task) {
    if (!_categoryTask.containsKey(task.category)) {
      _categoryTask[task.category] = [];
    }
    _categoryTask[task.category]!.add(task);
  }

  void updateTaskStatus(String id, String status) {
    for (var category in _categoryTask.keys) {
      for (var task in _categoryTask[category]!) {
        if (task.id == id) {
          task.status = status;
          return;
        }
      }
    }
  }

  void deleteTask(String id) {
    for (var category in _categoryTask.keys) {
      _categoryTask[category]!.removeWhere((task) => task.id == id);
    }
  }

  List<String> getAllCategories() {
    return _categoryTask.keys.toList();
  }

  void addCategory(String category) {
    if (!_categoryTask.containsKey(category)) {
      _categoryTask[category] = [];
    }
  }
}
