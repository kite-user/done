import 'dart:collection';

import 'package:done/src/models/tasklist.dart';
import 'package:flutter/widgets.dart';

class TaskListsController extends ChangeNotifier {
  final List<TaskList> _taskLists = [];

  UnmodifiableListView<TaskList> get tasklists =>
      UnmodifiableListView(_taskLists);

  Future<void> createList(TaskList list) async {
    _taskLists.add(list);
    notifyListeners();
  }

  Future<void> deleteTask(TaskList list) async {
    _taskLists.remove(list);
    notifyListeners();
  }
}
