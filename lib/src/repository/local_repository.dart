import 'dart:io';

import 'package:done/src/models/tasklist.dart';
import 'package:done/src/repository/app_repository.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class SQLiteRepository extends AppRepository {
  static final SQLiteRepository instance = SQLiteRepository();

  static Database? _db;
  Future<Database> get db async => _db ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'done_app.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createTables,
    );
  }

  Future<void> _createTables(Database db, int version) async {
    await db.execute('''
      CREATE TABLE task_lists(
        id TEXT PRIMARY KEY,
        name TEXT 
      ) 
    ''');
  }

  @override
  Future<int> addTaskList(TaskList taskList) async {
    Database db = await instance.db;
    return await db.insert('task_lists', taskList.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  @override
  Future<void> deleteTaskList(TaskList taskList) {
    throw UnimplementedError();
  }

  @override
  Future<List<TaskList>> getTaskLists() async {
    Database db = await instance.db;
    var taskLists = await db.query('task_lists', orderBy: 'id');
    return taskLists.isNotEmpty
        ? taskLists.map((e) => TaskList.fromMap(e)).toList()
        : [];
  }

  @override
  Future<void> updateTaskList(TaskList taskList) {
    throw UnimplementedError();
  }
}
