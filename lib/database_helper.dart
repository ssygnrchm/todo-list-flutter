import 'package:my_first_app/data/models/task_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'todo_app.db');
    return await openDatabase(path, version: 1, onCreate: _createDb);
  }

  Future<void> _createDb(Database db, int version) async {
    await db.execute('''
      CREATE TABLE tasks(
        id TEXT PRIMARY KEY,
        title TEXT NOT NULL,
        status TEXT NOT NULL,
        category TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE categories(
        name TEXT PRIMARY KEY
      )
    ''');

    // Insert default categories
    await db.insert('categories', {'name': 'daily_task'});
    await db.insert('categories', {'name': 'homeworks'});
    await db.insert('categories', {'name': 'other'});
  }

  // Task operations
  Future<List<TaskModel>> getTasks(String category) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'tasks',
      where: 'category = ?',
      whereArgs: [category],
    );

    return List.generate(maps.length, (i) => TaskModel.fromMap(maps[i]));
  }

  Future<void> insertTask(TaskModel task) async {
    final db = await database;
    await db.insert(
      'tasks',
      task.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateTaskStatus(String id, String status) async {
    final db = await database;
    await db.update(
      'tasks',
      {'status': status},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteTask(String id) async {
    final db = await database;
    await db.delete('tasks', where: 'id = ?', whereArgs: [id]);
  }

  // Category operations
  Future<List<String>> getAllCategories() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('categories');

    return List.generate(maps.length, (i) => maps[i]['name'] as String);
  }

  Future<void> insertCategory(String category) async {
    final db = await database;
    await db.insert('categories', {
      'name': category,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    print(getAllCategories());
  }
}
