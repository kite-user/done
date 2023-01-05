import 'package:done/src/models/task.dart';
import 'package:flutter/material.dart';

class TaskContentController extends ChangeNotifier {
  final Task _task;

  String get taskId => _task.id;
  String? get listId => _task.listId;

  Future<void> changeListId() async {}

  TaskContentController(this._task);
}
