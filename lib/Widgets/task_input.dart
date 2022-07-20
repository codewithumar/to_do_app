import 'package:flutter/material.dart';
import 'package:to_do_app/Models/todo_model.dart';

class UserInput extends StatelessWidget {
  var textController = TextEditingController();
  final Function insertionFunction;
  UserInput({required this.insertionFunction, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
      child: Row(
        children: [
          Expanded(
              child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: TextField(
              controller: textController,
              decoration: const InputDecoration(hintText: 'Add New Note'),
            ),
          )),
          GestureDetector(
            onTap: () {
              var mytodo = Todo(
                  title: textController.text,
                  isChecked: false,
                  creationDate: DateTime.now());
              insertionFunction(mytodo);
            },
            child: Container(
              color: Colors.red,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: const Text(
                'Add',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
