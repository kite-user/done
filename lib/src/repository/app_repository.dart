import 'package:done/src/models/sub_task.dart';
import 'package:done/src/models/task.dart';
import 'package:done/src/models/tasklist.dart';

abstract class AppRepository {
  Future<List<TaskList>> getTaskLists();
  Future<void> deleteTaskList(TaskList taskList);
  Future<void> addTaskList(TaskList taskList);
  Future<void> updateTaskList(TaskList taskList);

  Future<List<Task>> getTasks();
  Future<void> deleteTask(String taskId);
  Future<void> addTask(Task task);
  Future<void> updateTask(Task task);

  Future<List<SubTask>> getSubTasks(String taskId);
  Future<void> deleteSubTask(String id);
  Future<void> addSubTask(SubTask subTask);
  Future<void> updateSubTask(SubTask subTask);
}
