import 'package:flutter/material.dart';
import 'package:my_first_app/domain/entities/task.dart';
import 'package:my_first_app/domain/repositories/task_repository.dart';
import 'package:uuid/uuid.dart';

class TaskProvider extends ChangeNotifier {
  TaskRepository repository;
  final Uuid _uuid = const Uuid();

  String _currentCategory = 'daily_task';
  List<Task> _tasks = [];
  List<String> _categories = [];

  TaskProvider(this.repository) {
    loadTasks(_currentCategory);
    loadCategories();
  }

  String get currentCategory => _currentCategory;

  List<Task> get tasks => _tasks;

  List<Task> get todoTasks =>
      _tasks.where((task) => task.status == 'todo').toList();

  List<Task> get doneTasks =>
      _tasks.where((task) => task.status == 'done').toList();

  List<String> get categories => _categories;

  void setCategory(String category) {
    _currentCategory = category;
    loadTasks(category);
  }

  void setRepository(TaskRepository newRepository) {
    repository = newRepository;
    loadTasks(_currentCategory);
    loadCategories();
  }

  void loadTasks(String category) {
    _tasks = repository.getTask(category);
    notifyListeners();
  }

  void loadCategories() {
    _categories = repository.getAllCategories();
    notifyListeners();
  }

  void addTask(String title) {
    final task = Task(
      id: _uuid.v4(),
      title: title,
      status: 'todo',
      category: _currentCategory,
    );

    repository.addTask(task);
    loadTasks(_currentCategory);
  }

  void addCategory(String category) {
    if (category.trim().isNotEmpty) {
      repository.addCategory(category.trim());
      loadCategories();
    }
  }

  void toogleTaskStatus(String id) {
    final task = _tasks.firstWhere((task) => task.id == id);
    final newStatus = task.status == 'todo' ? 'done' : 'todo';

    repository.updateTaskStatus(id, newStatus);
    loadTasks(_currentCategory);
  }

  void deleteTask(String id) {
    repository.deleteTask(id);
    loadTasks(_currentCategory);
  }
}
