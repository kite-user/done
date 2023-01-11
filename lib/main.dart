import 'package:done/src/controllers/app_state.dart';
import 'package:done/src/controllers/tasklists_controller.dart';
import 'package:done/src/controllers/tasks_controller.dart';
import 'package:done/src/repository/app_repository.dart';
import 'package:done/src/repository/sqlite_repository.dart';
import 'package:done/src/ui/app/done_app.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final AppRepository repository = SQLiteRepository.instance;
  final prefs = await SharedPreferences.getInstance();
  final appState = AppState(prefs);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => TaskListsController(repository, appState)..loadData(),
        ),
        ChangeNotifierProvider(create: (_) => appState..loadData()),
        ChangeNotifierProvider(
          create: (_) => TasksController(repository, appState)..loadData(),
        ),
      ],
      child: const DoneApp(),
    ),
  );
}
