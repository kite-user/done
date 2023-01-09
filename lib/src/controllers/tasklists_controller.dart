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

  Future<void> createList(String name) async {
    final newList = TaskList(id: const Uuid().v4(), name: name);
    await repository.addTaskList(newList);
    _taskLists.add(newList);

    notifyListeners();
  }

  TaskList getList(String id) {
    final index = _taskLists.indexWhere((element) => element.id == id);
    return _taskLists[index];
  }

  Future<void> deleteList(String id) async {
    int index = _taskLists.indexWhere((element) => element.id == id);
    var list = _taskLists[index];

    await repository.deleteTaskList(list);
    _taskLists.remove(list);

    notifyListeners();
  }
}
