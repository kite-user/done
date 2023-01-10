import 'dart:collection';

import 'package:done/src/controllers/app_state.dart';
import 'package:done/src/models/task.dart';
import 'package:done/src/repository/app_repository.dart';
import 'package:flutter/widgets.dart';
import 'package:uuid/uuid.dart';

class TasksController extends ChangeNotifier {
  final AppRepository repository;
  final AppState appState;

  final List<Task> _tasks = [];
  UnmodifiableListView<Task> get tasks =>
      UnmodifiableListView(_getTasksFromCurrentList());

  bool get isEmpty => _getTasksFromCurrentList().isEmpty;

  TasksController(this.repository, this.appState);

  Future loadData() async {
    _tasks.clear();

    appState.addListener(() {
      notifyListeners();
    });

    return repository.getTasks().then((data) {
      _tasks.addAll(data);
      notifyListeners();
    }).catchError((err) {
      notifyListeners();
    });
  }

  _getTasksFromCurrentList() =>
      _tasks.where((element) => element.listId == appState.currentListId);

  Task getTask(String taskId) {
    final index = _tasks.indexWhere((element) => element.id == taskId);
    if (index == -1) return const Task(id: '-', title: '');
    return _tasks[index];
  }

  Future<void> _addTask(Task task) async {
    await repository.addTask(task);

    _tasks.add(task);
    notifyListeners();
  }

  Future<void> createTask({
    String title = '',
    String? details,
    DateTime? time,
    bool onFavorite = false,
  }) async {
    final task = Task(
      id: const Uuid().v4(),
      title: title,
      details: details,
      time: time,
      onFavorite: onFavorite,
      listId: appState.currentListId,
    );

    _addTask(task);
    notifyListeners();
  }

  Future<void> update(String id,
      {String? title,
      String? details,
      String? listId,
      DateTime? time,
      bool? completed,
      bool? onFavorite}) async {
    final taskIndex = _tasks.indexWhere((element) => element.id == id);

    final modifiedTask = _tasks[taskIndex].copyWith(
      id: id,
      title: title,
      details: details,
      time: time,
      listId: listId,
      completed: completed,
      onFavorite: onFavorite,
    );

    await repository.updateTask(modifiedTask);

    _tasks[taskIndex] = modifiedTask;
    notifyListeners();
  }

  Future<void> updateWithNullableDate(String id,
      {String? title,
      String? details,
      String? listId,
      DateTime? time,
      bool? completed,
      bool? onFavorite}) async {
    final taskIndex = _tasks.indexWhere((element) => element.id == id);
    final modifiedTask = _tasks[taskIndex].copyWithNullableDate(
      id: id,
      title: title,
      details: details,
      time: time,
      listId: listId,
      completed: completed,
      onFavorite: onFavorite,
    );

    await repository.updateTask(modifiedTask);
    _tasks[taskIndex] = modifiedTask;
  }

  Future<void> deleteTask(String id) async {
    final taskIndex = _tasks.indexWhere((element) => element.id == id);
    await repository.deleteTask(id);
    _tasks.removeAt(taskIndex);
    notifyListeners();
  }
}
