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
      id INTEGER PRIMARY KEY AUTOINCREMENT,
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

  Future<List<Todo>> getTodo() async {
    final db = await database;
    List<Map<String, dynamic>> items = await db.query(
      'todo',
      orderBy: 'id DESC',
    );
    return List.generate(
      items.length,
      (i) => Todo(
        id: items[i]['id'],
        title: items[i]['title'],
        creationDate: DateTime.parse(items[i]['creationDate']),
        isChecked: items[i]['isChecked'] == 1 ? true : false,
      ),
    );
  }
}
