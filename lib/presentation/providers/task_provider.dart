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
  bool _isLoading = false;

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

  bool get isLoading => _isLoading;

  void setCategory(String category) {
    _currentCategory = category;
    loadTasks(category);
  }

  void setRepository(TaskRepository newRepository) {
    repository = newRepository;
    loadTasks(_currentCategory);
    loadCategories();
  }

  Future<void> loadTasks(String category) async {
    _isLoading = true;

    notifyListeners();

    try {
      _tasks = await repository.getTask(category);
    } catch (e) {
      debugPrint('Error loading task: $e');
      _tasks = [];
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> loadCategories() async {
    try {
      _categories = await repository.getAllCategories();
    } catch (e) {
      debugPrint('Error loading categories: $e');
      _categories = [];
    }
    notifyListeners();
  }

  Future<void> addTask(String title) async {
    if (title.trim().isEmpty) return;

    final task = Task(
      id: _uuid.v4(),
      title: title,
      status: 'todo',
      category: _currentCategory,
    );

    try {
      await repository.addTask(task);
      await loadTasks(_currentCategory);
    } catch (e) {
      debugPrint('Error adding task: $e');
    }
  }

  Future<void> addCategory(String category) async {
    if (category.trim().isEmpty) return;
    try {
      await repository.addCategory(category.trim());
      await loadCategories();
    } catch (e) {
      debugPrint('Error adding category: $e');
    }
  }

  Future<void> toogleTaskStatus(String id) async {
    final task = _tasks.firstWhere((task) => task.id == id);
    final newStatus = task.status == 'todo' ? 'done' : 'todo';

    try {
      await repository.updateTaskStatus(id, newStatus);
      await loadTasks(_currentCategory);
    } catch (e) {
      debugPrint('Error updating task status: $e');
    }
  }

  Future<void> deleteTask(String id) async {
    try {
      await repository.deleteTask(id);
      await loadTasks(_currentCategory);
    } catch (e) {
      debugPrint('Error deleting task: $e');
    }
  }
}
