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
  UnmodifiableListView<Task> get tasks => UnmodifiableListView(_tasks);
  bool get isEmpty => _tasks.isEmpty;

  TasksController(this.repository, this.appState);

  void construct() => appState.addListener(() {
        loadData();
      });

  Future loadData() async {
    final listId = appState.currentListId;
    _tasks.clear();

    return repository.getTasks(listId).then((data) {
      _tasks.addAll(data);
      notifyListeners();
    }).catchError((err) {
      notifyListeners();
    });
  }

  Task getTask(String taskId) {
    final index = _tasks.indexWhere((element) => element.id == taskId);
    if (index == -1) return const Task(id: '0', title: '');
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

  Future<void> deleteTask(String id) async {
    final taskIndex = _tasks.indexWhere((element) => element.id == id);
    await repository.deleteTask(id);
    _tasks.removeAt(taskIndex);
    notifyListeners();
  }
}
