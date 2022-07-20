import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:to_do_app/Models/todo_model.dart';

class DatabaseConnect {
  Database? _database;

  Future<Database> get database async {
    final _dbpath = await getDatabasesPath();
    const _db_name = 'todo.db';
    final _path = join(_dbpath, _db_name);
    _database = await openDatabase(_path, version: 1, onCreate: _createDB);
    return _database!;
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE todo(
      id INTEGEER PRIMARY KEY AUTOINCREMENT,
      title TEXT,
      creationDate TEXT,
      isChecked INTEGER
    )
''');
  }

  Future<void> insertTodo(Todo todo) async {
    final db = await database;
    await db.insert('todo', todo.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> deletetodb(Todo todo) async {
    final db = await database;
    await db.delete('todo', where: 'id==?', whereArgs: [todo.id]);
  }
}
