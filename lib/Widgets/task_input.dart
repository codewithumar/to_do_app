// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:to_do_app/Models/todo_model.dart';

class UserInput extends StatelessWidget {
  final title = "";
  final description = "";
  final textController = TextEditingController();
  final textController2 = TextEditingController();
  DateTime? date;
  final Function insertionFunction;
  UserInput({required this.insertionFunction, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
      child: Column(
        children: [
          buildtitle(),
          builddescription(),
          buildButton(),
          buildDate()
          /*Expanded(
              child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: TextField(
              controller: textController,
              decoration: const InputDecoration(
                hintText: 'Add New Note',
              ),
            ),
          )),
          GestureDetector(
            onTap: () {
              var mytodo = Todo(
                  title: textController.text,
                  description: textController.text,
                  isChecked: false,
                  creationDate: DateTime.now());
              insertionFunction(mytodo);
              Navigator.pop(context);
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
          )*/
        ],
      ),
    );
  }

  Widget buildtitle() => TextField(
        controller: textController,
        decoration: const InputDecoration(
          border: UnderlineInputBorder(),
          labelText: 'Title',
        ),
      );

  Widget builddescription() => TextField(
        controller: textController2,
        decoration: const InputDecoration(
            border: UnderlineInputBorder(), labelText: 'Desctiption'),
      );
  Widget buildDate() => DatePickerDialog(
        initialDate: DateTime.now(),
        firstDate: DateTime(1947, 01, 01),
        lastDate: DateTime(2100, 12, 12),
      );
  Widget buildButton() => ElevatedButton(
        onPressed: () {
          var mytodo = Todo(
              title: textController.text.toString(),
              description: textController2.text.toString(),
              isChecked: false,
              creationDate: DateTime.now());
          insertionFunction(mytodo);
          Dismissible:
          false;
        },
        child: const Text("Save"),
      );
}
