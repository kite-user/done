import 'dart:collection';

import 'package:done/src/models/task.dart';
import 'package:done/src/repository/app_repository.dart';
import 'package:flutter/widgets.dart';
import 'package:uuid/uuid.dart';

class TasksController extends ChangeNotifier {
  final AppRepository repository;
  final List<Task> _tasks = [];

  TasksController(this.repository);

  UnmodifiableListView<Task> get tasks => UnmodifiableListView(_tasks);

  Future loadData() async {}

  Future<void> addTask(Task task) async {
    _tasks.add(task);
    notifyListeners();
  }

  Future<void> createTask(String title) async {
    final task = Task(id: const Uuid().v4(), title: title);
    addTask(task);
    notifyListeners();
  }

  Future<void> update(String id,
      {String? title,
      String? details,
      DateTime? time,
      bool? completed,
      bool? onFavorite}) async {
    final taskIndex = _tasks.indexWhere((element) => element.id == id);
    _tasks[taskIndex] = _tasks[taskIndex].copyWith(
      id: id,
      title: title,
      details: details,
      time: time,
      completed: completed,
      onFavorite: onFavorite,
    );

    notifyListeners();
  }

  Future<void> deleteTask(String id) async {
    final taskIndex = _tasks.indexWhere((element) => element.id == id);
    _tasks.removeAt(taskIndex);
    notifyListeners();
  }
}
