import 'package:flutter/material.dart';
import 'package:to_do_app/Models/todo_model.dart';

// ignore: must_be_immutable
class TodoCard extends StatefulWidget {
  final int id;
  final String title;
  final String description;
  bool isChecked;
  final DateTime cerationDate;
  final Function insertionFunction;
  final Function deleteFunction;

  TodoCard(
      {required this.id,
      required this.title,
      required this.description,
      required this.cerationDate,
      required this.isChecked,
      required this.insertionFunction,
      required this.deleteFunction,
      Key? key})
      : super(key: key);

  @override
  State<TodoCard> createState() => _TodoCardState();
}

class _TodoCardState extends State<TodoCard> {
  @override
  Widget build(BuildContext context) {
    double opacity = 1.0;
    var anotherTodo = Todo(
        id: widget.id,
        title: widget.title,
        description: widget.description,
        creationDate: widget.cerationDate,
        isChecked: widget.isChecked);
    return Container(
        child: Card(
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Checkbox(
                value: widget.isChecked,
                onChanged: (bool? value) {
                  setState(() {
                    widget.isChecked = value!;
                    widget.isChecked ? opacity = 0.5 : opacity = 1.0;
                  });

                  anotherTodo.isChecked = value!;
                  widget.insertionFunction(anotherTodo);
                }),
          ),
          Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Text(widget.id.toString()),
                Text(widget.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    )),
                const SizedBox(
                  width: 5,
                ),
                Text(widget.description),
                Text(widget.cerationDate.toString(),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ))
              ])),
          IconButton(
              onPressed: () {
                widget.deleteFunction(anotherTodo);
                setState(() {});
              },
              icon: const Icon(Icons.close)),
        ],
      ),
    ));
  }
}
