import 'package:flutter/material.dart';
import 'package:to_do_list/widgets.dart';

List tareas = [];

void main() {
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
        "home": (context) => HOME(),
      },
    );
  }
}

class HOME extends StatefulWidget {
  const HOME({
    super.key,
  });

  @override
  State<HOME> createState() => _HOMEState();
}

class _HOMEState extends State<HOME> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TODO LIST APP"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ListView.separated(
              separatorBuilder: (context, index) {
                return SizedBox(height: 30);
              },
              shrinkWrap: true,
              itemCount: tareas.length,
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tareas[index]["titulo"],
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      tareas[index]["descripcion"],
                      textAlign: TextAlign.left,
                    )
                  ],
                );
              },
            )
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: FloatingActionButton(
          onPressed: () async {
            await dialog(context);
            setState(() {});
          },
          child: Icon(Icons.add),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

Future<void> dialog(BuildContext context) async {
  TextEditingController tareaController = TextEditingController();
  TextEditingController descripcionController = TextEditingController();
  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Center(child: Text('Agregar tarea')),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.close)),
              IconButton(
                  onPressed: () {
                    //guardar
                    print(tareas);
                    // tareas = [];
                  },
                  icon: Icon(Icons.remove_red_eye)),
              IconButton(
                  onPressed: () {
                    final tarea = {
                      "id": 0,
                      "titulo": tareaController.text,
                      "descripcion": descripcionController.text,
                    };
                    final tarea2 = {
                      "id": 0,
                      "titulo": "bañar al perro",
                      "descripcion": "asdasd",
                    };
                    //guardar
                    tareas.add(tarea2);
                    //esto se hace para vaciar el campo
                    tareaController.text = "";
                    descripcionController.text = "";
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.save)),
            ],
          )
        ],
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: tareaController,
            ),
            TextFormField(
              controller: descripcionController,
            ),
          ],
        ),
      );
    },
  );
}
