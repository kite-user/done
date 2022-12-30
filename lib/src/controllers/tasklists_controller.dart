import 'dart:collection';

import 'package:done/src/models/tasklist.dart';
import 'package:flutter/widgets.dart';

class TaskListsController extends ChangeNotifier {
  final List<TaskList> _taskLists = [
    const TaskList(
      id: 1,
      name: 'Work',
    ),
    ...List.generate(
      4,
      (index) => const TaskList(id: 2, name: 'Clone'),
    ),
  ];

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
