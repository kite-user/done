import 'dart:collection';

import 'package:done/src/controllers/tasklists_controller.dart';
import 'package:done/src/controllers/tasks_controller.dart';
import 'package:done/src/models/sub_task.dart';
import 'package:done/src/models/task.dart';
import 'package:done/src/models/tasklist.dart';
import 'package:done/src/repository/app_repository.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class TaskContentController extends ChangeNotifier {
  late final String _taskId;
  late final TaskListsController _taskListsController;
  late final TasksController _tasksController;
  late final AppRepository repository;

  final List<SubTask> _subTasks = [];
  UnmodifiableListView<SubTask> get subTasks => UnmodifiableListView(_subTasks);

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
    repository = _tasksController.repository;
    _taskId = taskId;
  }

  Future loadData() async {
    return repository.getSubTasks(taskId).then(
      (data) {
        _subTasks.addAll(data);
        notifyListeners();
      },
    );
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

  Future<void> updateTaskWithNullableDate(
      {String? title,
      String? details,
      String? listId,
      DateTime? time,
      bool? completed,
      bool? onFavorite}) async {
    await _tasksController.updateWithNullableDate(
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

  Future<void> createEmptySubTask() async {
    final newEmpty = SubTask(
      id: const Uuid().v4(),
      content: '',
      taskId: _taskId,
    );

    await repository.addSubTask(newEmpty);
    _subTasks.add(newEmpty);
    notifyListeners();
  }

  Future<void> updateSubTask(String id,
      {String? content, bool? completed, bool? onTrash}) async {
    final index = _subTasks.indexWhere((element) => element.id == id);

    final modified = _subTasks[index].copyWith(
      id: id,
      content: content,
      completed: completed,
      onTrash: onTrash,
    );

    await repository.updateSubTask(modified);
    _subTasks[index] = modified;

    notifyListeners();
  }

  Future<void> deleteSubTask(String id) async {
    final index = _subTasks.indexWhere((element) => element.id == id);

    await repository.deleteSubTask(id);
    _subTasks.removeAt(index);

    notifyListeners();
  }
}
