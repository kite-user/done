import 'package:done/src/models/tasklist.dart';

abstract class AppRepository {
  Future<List<TaskList>> getTaskLists();
  Future<void> deleteTaskList(TaskList taskList);
  Future<void> addTaskList(TaskList taskList);
  Future<void> updateTaskList(TaskList taskList);
}
