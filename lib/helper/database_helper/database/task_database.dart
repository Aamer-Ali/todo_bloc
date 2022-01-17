import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class TaskDatabase {
  static final TaskDatabase instance = TaskDatabase._init();
  static Database? _database;
  static const int _version = 1;
  static const String tableTask = "tasks";

  TaskDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, "task.db");

    return await openDatabase(path,
        version: _version,
        onCreate: _createDatabase,
        onUpgrade: _upgradeDatabase);
  }

  Future _upgradeDatabase(
      Database db, int previousVersion, int newVersion) async {
    if (previousVersion < newVersion) {}
  }

  Future _createDatabase(Database db, int version) async {
    return db.execute(
      "CREATE TABLE $tableTask("
      "id INTEGER PRIMARY KEY AUTOINCREMENT, "
      "title TEXT, note TEXT, date TEXT,"
      "startTime TEXT, endTime TEXT,"
      "reminder INTEGER, repeat TEXT,"
      "color INTEGER,"
      "isCompleted INTEGER)",
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
