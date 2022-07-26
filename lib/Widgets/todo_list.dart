// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:to_do_app/Models/db_model.dart';
import 'package:to_do_app/Widgets/todo_card.dart';

class TodoList extends StatelessWidget {
  var db = DatabaseConnect();
  final Function insertionFuntion;
  final Function deleteFunction;
  TodoList(
      {required this.insertionFuntion, required this.deleteFunction, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder(
        future: db.getTodo(),
        initialData: const [],
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          var data = snapshot.data;
          var datalength = data!.length;

          return datalength == 0
              ? const Center(
                  child: Text('Nothing To Show Up'),
                )
              : ListView.builder(
                  itemCount: datalength,
                  itemBuilder: (context, i) {
                    final todo = data[i];
                    return TodoCard(
                      todo: todo,
                      cerationDate: todo.creationDate,
                      isChecked: todo.isChecked,
                      insertionFunction: insertionFuntion,
                      deleteFunction: deleteFunction,
                    );
                  });
        },
      ),
    );
  }
}
