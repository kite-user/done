import 'package:done/src/controllers/tasklists_controller.dart';
import 'package:done/src/controllers/tasks_controller.dart';
import 'package:done/src/ui/app/done_app.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => TasksController()),
      ChangeNotifierProvider(create: (_) => TaskListsController()),
    ],
    child: const DoneApp(),
  ));
}
