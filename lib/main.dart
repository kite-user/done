import 'package:done/src/repository/sqlite_repository.dart';
import 'package:done/src/ui/app/done_app.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final repository = SQLiteRepository.instance;

  runApp(DoneApp(
    repository: repository,
  ));
}
