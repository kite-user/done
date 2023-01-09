import 'dart:collection';

import 'package:done/src/controllers/tasklists_controller.dart';
import 'package:done/src/controllers/tasks_controller.dart';
import 'package:done/src/models/task.dart';
import 'package:done/src/models/tasklist.dart';
import 'package:flutter/material.dart';

class TaskContentController extends ChangeNotifier {
  late final String _taskId;
  late final TaskListsController _taskListsController;
  late final TasksController _tasksController;

  String get taskId => _taskId;
  String? get listId => _getTask().listId;
  String get taskTitle => _getTask().title;
  String? get taskDetails => _getTask().details;
  bool get favorite => _getTask().onFavorite;
  bool get completed => _getTask().completed;
  DateTime? get time => _getTask().time;

  UnmodifiableListView<TaskList> get taskList => _taskListsController.tasklists;

  Task _getTask() => _tasksController.getTask(_taskId);

  TaskContentController(TaskListsController taskListsController,
      TasksController tasksController, String taskId) {
    _tasksController = tasksController;
    _taskListsController = taskListsController;
    _taskId = taskId;
  }

  Future<void> deleteTask() async {
    await _tasksController.deleteTask(_taskId);
  }

  Future<void> updateTask(
      {String? title,
      String? details,
      String? listId,
      DateTime? time,
      bool? completed,
      bool? onFavorite}) async {
    await _tasksController.update(
      taskId,
      title: title,
      details: details,
      time: time,
      listId: listId,
      completed: completed,
      onFavorite: onFavorite,
    );

    notifyListeners();
  }
}
