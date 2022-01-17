import 'package:todo_bloc/helper/database_helper/dao/task_dao.dart';
import 'package:todo_bloc/model/task.dart';

class TaskRepository {
  TaskDao taskDao = TaskDao();

  Future<int> insertTask(Task task) => taskDao.insertTask(task);

  Future<Task> getTask(int id) => taskDao.getTask(id);

  Future<List<Task>> getAllTask() => taskDao.getAllTask();
}
