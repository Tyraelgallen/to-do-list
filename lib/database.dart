import 'package:hive_flutter/hive_flutter.dart';

class Database {
  static Box? _box1;

  static Future<void> initBox() async {
    await Hive.initFlutter();
    _box1 = await Hive.openBox("tareas");
  }

  static Future<void> putData(Map value) async {
    _box1!.put(value["id"], value);
    print("campo agregado");
  }

  static Future<Map> getById(int id) async {
    return _box1!.get(id) ?? {};
  }

  static Future<Map> getAllData() async {
    return _box1!.toMap();
  }

  static Future<void> deleteById(int id) async {
    _box1!.delete(id);
  }

  static Future<void> deleteAllData() async {
    _box1!.clear();
  }

  static Future<void> printData() async {
    print(_box1!.toMap());
  }
}
