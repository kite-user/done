import 'dart:collection';

import 'package:done/src/models/task.dart';
import 'package:flutter/widgets.dart';

class TasksController extends ChangeNotifier {
  final List<Task> _tasks = [
    const Task(
      id: 1,
      title: 'Move the lawn',
      details: 'Detail move',
    ),
  ];

  UnmodifiableListView<Task> get tasks => UnmodifiableListView(_tasks);

  Future<void> createTask(Task task) async {
    _tasks.add(task);
    notifyListeners();
  }

  Future<void> update(Task task) async {
    final taskIndex = _tasks.indexWhere((element) => element.id == task.id);
    _tasks[taskIndex] = _tasks[taskIndex].copyWith(
      title: task.title,
      details: task.details,
      time: task.time,
      completed: task.completed,
    );

    notifyListeners();
  }

  Future<void> deleteTask(Task task) async {
    _tasks.remove(task);
    notifyListeners();
  }
}
