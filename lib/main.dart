import 'package:flutter/material.dart';
import 'package:todo_list/database.dart';
import 'package:todo_list/home.dart';

//crear tareas
//guardar esas tareas en BD

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Database.initBox();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "home",
      routes: {
        "home": (context) => Home(),
      },
    );
  }
}
