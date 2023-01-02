import 'dart:collection';

import 'package:done/src/models/tasklist.dart';
import 'package:flutter/widgets.dart';
import 'package:uuid/uuid.dart';

class TaskListsController extends ChangeNotifier {
  final List<TaskList> _taskLists = [
    ...List.generate(
      4,
      (index) => TaskList(id: const Uuid().v4(), name: 'Clone'),
    ),
  ];

  UnmodifiableListView<TaskList> get tasklists =>
      UnmodifiableListView(_taskLists);

  Future<void> addList(TaskList list) async {
    _taskLists.add(list);
    notifyListeners();
  }

  Future<void> createList(String name) async {
    _taskLists.add(TaskList(id: const Uuid().v4(), name: name));
    notifyListeners();
  }

  Future<void> deleteTask(TaskList list) async {
    _taskLists.remove(list);
    notifyListeners();
  }
}
