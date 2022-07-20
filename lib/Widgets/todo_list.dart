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
                  child: Text('No Record'),
                )
              : ListView.builder(
                  itemCount: datalength,
                  itemBuilder: (context, i) => TodoCard(
                      id: data[i].id,
                      title: data[i].title,
                      cerationDate: data[i].creationDate,
                      isChecked: data[i].isChecked,
                      insertionFunction: insertionFuntion,
                      deleteFunction: deleteFunction),
                );
        },
      ),
    );
  }
}
