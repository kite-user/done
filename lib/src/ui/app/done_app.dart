import 'package:done/src/controllers/tasklists_controller.dart';
import 'package:done/src/controllers/tasks_controller.dart';
import 'package:done/src/repository/app_repository.dart';
import 'package:done/src/styles/themes.dart';
import 'package:done/src/ui/app/navigating_point.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DoneApp extends StatelessWidget {
  const DoneApp({super.key, required this.repository});

  final AppRepository repository;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => TaskListsController(repository)..loadData(),
        ),
        ChangeNotifierProvider(create: (_) => TasksController()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Done',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.dark,
        home: const NavigatingPoint(),
      ),
    );
  }
}
