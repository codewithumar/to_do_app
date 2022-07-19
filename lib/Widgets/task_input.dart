import 'package:flutter/material.dart';

class UserInput extends StatelessWidget {
  var textController = TextEditingController();
  UserInput({Key? key}) : super(key: key);

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
          const SizedBox(width: 10),
          GestureDetector(
            onTap: () {},
          )
        ],
      ),
    );
  }
}
