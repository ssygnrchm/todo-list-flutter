import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DatabaseHelper {
  final String dbName = 'todo.db';
  final String todoList = "";
  final String id = "";
  final String title = "";
  String status = "";
  final String category = "";

  Future<Database> openMyDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(), "todoDB.db"),
      version: 1,
      onCreate:
          (db, version) => db.execute(
            'CREATE TABLE $todoList($id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, $title TEXT, $status  TEXT, $category TEXT)',
          ),
    );
  }

  // Future<void> insertTask({
  //   required String
  // })
}
