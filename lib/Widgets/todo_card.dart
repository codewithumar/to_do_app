import 'package:flutter/material.dart';
import 'package:to_do_app/Models/todo_model.dart';

import '../Models/db_model.dart';

// ignore: must_be_immutable
class TodoCard extends StatefulWidget {
  Todo todo;
  bool isChecked;
  DateTime cerationDate;
  final Function insertionFunction;
  final Function deleteFunction;

  TodoCard(
      {required this.todo,
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
  var db = DatabaseConnect();
  late TextEditingController textEditingController;
  late TextEditingController textEditingController2;

  TimeOfDay? selectedTime;

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController(text: "");
    textEditingController2 = TextEditingController(
      text: "",
    );
    widget.todo.status;
  }

  Future<void> _updateItem(Todo todo) async {
    await db.update(todo);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
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
                      if (value == true) {
                        widget.todo.status = "Completed";
                      } else {
                        widget.todo.status = "Pending";
                      }
                    });

                    widget.todo.isChecked = value!;
                    widget.insertionFunction(widget.todo);
                  }),
            ),
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  //Text(widget.id.toString()),
                  Text(widget.todo.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      )),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(widget.todo.description),
                  Text(widget.cerationDate.toString(),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ))
                ])),
            TextButton(onPressed: () {}, child: Text(widget.todo.status)),
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
                                  widget.deleteFunction(widget.todo);
                                  setState(() {});
                                  Navigator.of(context).pop();
                                }),
                          ],
                        ));
              },
            )
          ],
        ),
      ),
      onTap: () {
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
  }

  getTiemfromuser(BuildContext context) {
    showTimePicker(
            context: context,
            initialTime:
                TimeOfDay(hour: selecteddate.hour, minute: selecteddate.minute))
        .then((pickTime) {
      if (pickTime == null) {
        return null;
      }
      setState(() {
        selectedTime = pickTime;
      });
    });
  }

  Future opendialog() => showDialog(
        context: context,
        builder: (context) => SimpleDialog(
          title: const Text("Update Todo"),
          children: [
            TextFormField(controller: textEditingController),
            TextFormField(controller: textEditingController2),
            buildButton(),
            TextButton(
                onPressed: () {
                  selecteddate = getdatefromuser(context);
                },
                child: const Text('Choose date')),
            TextButton(
                onPressed: () {
                  selectedTime = getTiemfromuser(context);
                },
                child: const Text("Choose Time"))

            /// getdatefromuser(context),
          ],
        ),
      );
  buildButton() => ElevatedButton(
        onPressed: () async {
          Navigator.pop(context);
          var mytodo = Todo(
            status: widget.todo.status,
            id: widget.todo.id,
            title: textEditingController.text,
            description: textEditingController2.text,
            isChecked: widget.isChecked,
            creationDate: selecteddate,
          );
          widget.todo = mytodo;
          widget.insertionFunction(widget.todo);
          await _updateItem(mytodo);
          setState(() {});
        },
        child: const Text("Save"),
      );
}
