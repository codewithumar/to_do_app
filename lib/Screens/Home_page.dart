import 'package:flutter/material.dart';
import 'package:to_do_app/Models/db_model.dart';
import 'package:to_do_app/Widgets/todo_card.dart';
import 'package:to_do_app/Widgets/task_input.dart';
import 'package:to_do_app/Widgets/todo_list.dart';

import '../Models/todo_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  var db = DatabaseConnect();
  void addItem(Todo todo) async {
    await db.insertTodo(todo);
    setState(() {});
  }

  void deleteItem(Todo todo) async {
    await db.deletetodb(todo);
    setState(() {});
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo App'),
      ),
      body: Column(
        children: [
          TodoList(
            insertionFuntion: addItem,
            deleteFunction: deleteItem,
          ),
          const SizedBox(height: 5),
          UserInput(
            insertionFunction: addItem,
          )
        ],
      ),
    );
  }
}
