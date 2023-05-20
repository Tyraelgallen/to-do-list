import 'package:flutter/material.dart';
import 'package:todo_list/database.dart';

List tareas = [
  // {
  //   "id": 0,
  //   "titulo": "tarea 1",
  //   "descripcion": "hacer la cama",
  //   "completado": true
  // },
  // {
  //   "id": 1,
  //   "titulo": "tarea 2",
  //   "descripcion": "lavar el auto",
  //   "completado": false
  // },
];
bool completado = false;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    traerInfo();
    super.initState();
  }

  void traerInfo() async {
    // Database.printData();
    Map mapa = await Database.getAllData();
    // tareas.clear();
    mapa.forEach((key, value) {
      tareas.add(value);
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TO DO LIST APP"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListView.separated(
              separatorBuilder: (context, index) => const Divider(
                thickness: 2,
              ),
              itemCount: tareas.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: SwitchListTile(
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Text(tareas[index]["id"].toString()),
                              Text(tareas[index]["titulo"] ?? ""),
                              Text(tareas[index]["descripcion"] ?? ""),
                            ],
                          ),
                          value: tareas[index]["completado"],
                          onChanged: (b) {
                            setState(() {
                              tareas[index]["completado"] =
                                  !tareas[index]["completado"];
                            });
                          }),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.15,
                      child: IconButton(
                          onPressed: () {
                            Database.deleteById(tareas[index]["id"]);
                            tareas.removeAt(index);
                            setState(() {});
                          },
                          icon: Icon(Icons.delete)),
                    )
                  ],
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await cartel(context);

          // Map mapa = await Database.getAllData();
          // tareas.clear();
          // mapa.forEach((key, value) {
          //   tareas.add(value);
          // });

          setState(() {});
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

Future<void> cartel(BuildContext context) async {
  TextEditingController tituloController = TextEditingController();
  TextEditingController descripcionController = TextEditingController();
  await showDialog(
    barrierDismissible: true,
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        contentPadding: EdgeInsets.all(0),
        content: Container(
          // height: 200,
          // color: Colors.red,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Añadir tareas",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: tituloController,
                  decoration: InputDecoration(hintText: "Titulo"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: TextFormField(
                  controller: descripcionController,
                  decoration: InputDecoration(hintText: "Descripcion"),
                ),
              ),
              Row(
                children: [
                  SizedBox(width: 5),
                  Text("¿Completado? "),
                  CustomSwitch(),
                ],
              )
            ],
          ),
        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.close)),
              IconButton(
                  onPressed: () {
                    Database.printData();
                  },
                  icon: Icon(Icons.remove_red_eye_sharp)),
              IconButton(
                  onPressed: () async {
                    Map tarea = {
                      "id": tareas.length,
                      "titulo": tituloController.text,
                      "descripcion": descripcionController.text,
                      "completado": completado
                    };
                    if (tituloController.text.isNotEmpty &
                        descripcionController.text.isNotEmpty) {
                      await Database.putData(tarea);
                      Map mapa = await Database.getById(tareas.length);
                      if (mapa.isNotEmpty) {
                        tareas.add(mapa);
                      }
                      Navigator.pop(context);
                    } else {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("completa los campos por favor"),
                        duration: Duration(seconds: 2),
                      ));
                    }
                  },
                  icon: Icon(Icons.save)),
            ],
          )
        ],
      );
    },
  );
}

class CustomSwitch extends StatefulWidget {
  const CustomSwitch({super.key});

  @override
  State<CustomSwitch> createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> {
  @override
  Widget build(BuildContext context) {
    return Switch(
        value: completado,
        onChanged: (b) {
          setState(() {
            completado = b;
          });
        });
  }
}
