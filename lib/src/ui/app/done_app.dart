import 'package:done/src/controllers/app_state.dart';
import 'package:done/src/styles/themes.dart';
import 'package:done/src/ui/app/navigating_point.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DoneApp extends StatelessWidget {
  const DoneApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final themeMode = context.watch<AppState>().themeMode;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Done',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      home: const NavigatingPoint(),
    );
  }
}
