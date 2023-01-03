import 'package:done/src/models/task.dart';
import 'package:done/src/models/tasklist.dart';

abstract class AppRepository {
  Future<List<TaskList>> getTaskLists();
  Future<void> deleteTaskList(TaskList taskList);
  Future<void> addTaskList(TaskList taskList);
  Future<void> updateTaskList(TaskList taskList);

  Future<List<Task>> getTasks(String listId);
  Future<void> deleteTask(Task task);
  Future<void> addTask(Task task);
  Future<void> updateTask(Task task);
}
