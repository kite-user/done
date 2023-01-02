import 'dart:collection';

import 'package:done/src/models/tasklist.dart';
import 'package:done/src/repository/app_repository.dart';
import 'package:flutter/widgets.dart';
import 'package:uuid/uuid.dart';

class TaskListsController extends ChangeNotifier {
  final AppRepository repository;

  final List<TaskList> _taskLists = [];

  TaskListsController(
    this.repository,
  );

  Future loadData() async {
    return repository.getTaskLists().then((data) {
      _taskLists.addAll(data);
      notifyListeners();
    }).catchError((err) {
      // print(err);
      notifyListeners();
    });
  }

  UnmodifiableListView<TaskList> get tasklists =>
      UnmodifiableListView(_taskLists);

  Future<void> addList(TaskList list) async {
    await repository.addTaskList(list);
    _taskLists.add(list);
    notifyListeners();
  }

  Future<void> createList(String name) async {
    final newList = TaskList(id: const Uuid().v4(), name: name);
    _taskLists.add(newList);
    notifyListeners();
  }

  Future<void> deleteList(TaskList list) async {
    _taskLists.remove(list);
    notifyListeners();
  }
}
