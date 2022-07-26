import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:to_do_app/Models/todo_model.dart';

class DatabaseConnect {
  Database? _database;

  Future<Database> get database async {
    final dbpath = await getDatabasesPath();
    const dbName = 'todo.db';
    final path = join(dbpath, dbName);
    _database = await openDatabase(path, version: 1, onCreate: _createDB);
    return _database!;
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE todo(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT,
      description TEXT,
      creationDate TEXT,
      isChecked INTEGER,
      status TEXT
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

  Future<void> update(Todo todo) async {
    final db = await database;
    await db.update('todo', todo.toMap(), where: 'id=?', whereArgs: [todo.id]);
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
        description: items[i]['description'],
        creationDate: DateTime.parse(items[i]['creationDate']),
        isChecked: items[i]['isChecked'] == 1 ? true : false,
        status: items[i]['status'],
      ),
    );
  }
}
