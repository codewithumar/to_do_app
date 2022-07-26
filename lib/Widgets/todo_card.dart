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

  TextEditingController textEditingController = TextEditingController();
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
  DateTime selecteddate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    var anotherTodo = Todo(
        id: widget.id,
        title: widget.title,
        description: widget.description,
        creationDate: widget.cerationDate,
        isChecked: widget.isChecked);
    return GestureDetector(
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
            TextButton(
              child: const Text("Delete"),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: const Text('Confirm'),
                          content: const Text('Are you sure?'),
                          actions: <Widget>[
                            TextButton(
                                child: const Text('Cancel'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                }),
                            TextButton(
                                child: const Text('Delete'),
                                onPressed: () {
                                  widget.deleteFunction(anotherTodo);
                                  setState(() {});
                                  Navigator.of(context).pop();
                                }),
                          ],
                        ));

                //  widget.deleteFunction(anotherTodo);
                // setState(() {});
              },
              //  icon: const Icon(Icons.close)),
            )
          ],
        ),
      ),
      onTap: () {
        Todo(
            id: widget.id,
            title: widget.title,
            description: widget.description,
            isChecked: widget.isChecked,
            creationDate: widget.cerationDate);

        opendialog();
      },
    );
  }

  getdatefromuser(BuildContext context) {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime(3000))
        .then((pickeddate) {
      if (pickeddate == null) {
        return null;
      }
      setState(() {
        selecteddate = pickeddate;
      });
    });
    Builder:
    (context);
  }

  Future opendialog() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(widget.title),
        ),
      );
}
