import 'package:todo_bloc/helper/database_helper/database/task_database.dart';
import 'package:todo_bloc/model/task.dart';

class TaskDao {
  Future<int> insertTask(Task? task) async {
    final _db = await TaskDatabase.instance.database;
    return await _db.insert(TaskDatabase.tableTask, task!.toJson());
  }

  Future<Task> getTask(int id) async {
    final _db = await TaskDatabase.instance.database;
    final map = await _db
        .query(TaskDatabase.tableTask, where: 'id = ?', whereArgs: [id]);
    if (map.isNotEmpty) {
      return Task.fromJson(map.first);
    } else {
      throw Exception("Id $id is not found in the database");
    }
  }

  Future<List<Task>> getAllTask() async {
    final _db = await TaskDatabase.instance.database;
    final result = await _db.query(TaskDatabase.tableTask);
    return result.map((json) => Task.fromJson(json)).toList();
  }
}
