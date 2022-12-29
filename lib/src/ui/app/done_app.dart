import 'package:done/src/styles/themes.dart';
import 'package:done/src/ui/app/navigating_point.dart';
import 'package:flutter/material.dart';

class DoneApp extends StatelessWidget {
  const DoneApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Done',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,
      home: const NavigatingPoint(),
    );
  }
}
