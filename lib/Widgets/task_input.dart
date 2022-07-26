// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:to_do_app/Models/todo_model.dart';

class UserInput extends StatefulWidget {
  final Function insertionFunction;
  const UserInput({required this.insertionFunction, Key? key})
      : super(key: key);

  @override
  State<UserInput> createState() => _UserInputState();
}

class _UserInputState extends State<UserInput> {
  final title = "";

  final description = "";

  final textController = TextEditingController();

  final textController2 = TextEditingController();

  DateTime selecteddate = DateTime.now();
  TimeOfDay? selectedTime;
  @override
  void initState() {
    super.initState();
    selectedTime;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
      child: Column(
        children: [
          buildtitle(),
          builddescription(),
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

  Widget buildDate(BuildContext context) => DatePickerDialog(
        // context:context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1947, 01, 01),
        lastDate: DateTime(2100, 12, 12),
      );

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

  Widget buildButton() => ElevatedButton(
        onPressed: () {
          Navigator.pop(context);
          var mytodo = Todo(
            status: "Pending",
            title: textController.text.toString(),
            description: textController2.text.toString(),
            isChecked: false,
            creationDate: selecteddate,
          );
          widget.insertionFunction(mytodo);
        },
        child: const Text("Save"),
      );
}
