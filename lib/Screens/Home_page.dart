import 'package:flutter/material.dart';
import 'package:to_do_app/Models/db_model.dart';
import 'package:to_do_app/Widgets/task_input.dart';
import 'package:to_do_app/Widgets/todo_list.dart';

import '../Models/todo_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var db = DatabaseConnect();
  void addItem(Todo todo) async {
    await db.insertTodo(todo);
    setState(() {});
  }

  void deleteItem(Todo todo) async {
    await db.deletetodb(todo);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo App'),
      ),
      body: Column(
        children: [
          UserInput(
            insertionFunction: addItem,
          ),
          TodoList(
            insertionFuntion: addItem,
            deleteFunction: deleteItem,
          ),
          const SizedBox(height: 5),
        ],
      ),
    );
  }
}
