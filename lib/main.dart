import 'package:flutter/material.dart';
import 'package:to_do_app/Models/db_model.dart';
import 'package:to_do_app/Models/todo_model.dart';
import 'package:to_do_app/Screens/Home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
