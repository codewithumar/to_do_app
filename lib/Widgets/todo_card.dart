import 'package:flutter/material.dart';

class TodoCard extends StatefulWidget {
  const TodoCard({Key? key}) : super(key: key);

  @override
  State<TodoCard> createState() => _TodoCardState();
}

class _TodoCardState extends State<TodoCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          Container(
            child: Checkbox(value: false, onChanged: (bool? value) {}),
          ),
          Expanded(
              child: Column(children: [
            Text('Title'),
            const SizedBox(
              width: 5,
            ),
            Text('Date')
          ])),
          IconButton(onPressed: () {}, icon: const Icon(Icons.close))
        ],
      ),
    );
  }
}
