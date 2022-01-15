import 'package:sqflite/sqflite.dart';
import 'package:todo_bloc/model/task.dart';

class DBHelper {
  static Database? _db;
  static final int _version = 1;
  static final String _tableTask = "tasks";

  static Future<void> initDb() async {
    if (_db != null) {
      return;
    }
    try {
      String _path = await getDatabasesPath() + "tasks.db";
      _db =
          await openDatabase(_path, version: _version, onCreate: (db, version) {
        print("Creating Database");
        return db.execute(
          "CREATE TABLE $_tableTask("
          "id INTEGER PRIMARY KEY AUTOINCREMENT, "
          "title TEXT, note TEXT, date TEXT,"
          "startTime TEXT, endTime TEXT,"
          "reminder INTEGER, repeat TEXT,"
          "color INTEGER,"
          "isCompleted INTEGER)",
        );
      });
    } catch (e) {
      print(e);
    }
  }

  static Future<int> insert(Task? task) async{
    print("insert function is called");
    return await _db!.insert(_tableTask, task!.toJson());
  }
}
