import 'dart:async';

import 'package:done/src/models/task.dart';
import 'package:done/src/models/tasklist.dart';
import 'package:done/src/repository/app_repository.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SQLiteRepository extends AppRepository {
  static final SQLiteRepository instance = SQLiteRepository();

  Database? _db;
  Future<Database> get db async => _db ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'done_app.db'),
      version: 2,
      onCreate: _createTables,
      onUpgrade: _upgradeTables,
    );
  }

  Future<void> _upgradeTables(
      Database db, int oldVersion, int newVersion) async {
    await db.execute('DROP TABLE IF EXISTS task_lists');
    await db.execute('DROP TABLE IF EXISTS tasks');

    await db.execute('''
      CREATE TABLE task_lists(
        id TEXT PRIMARY KEY,
        name TEXT 
      ); 

    ''');

    await db.execute('''
      CREATE TABLE tasks( 
        id TEXT PRIMARY KEY,
        title TEXT,
        details TEXT,
        time TEXT,
        completed INTEGER,
        favorited INTEGER,
        list_id TEXT REFERENCES task_lists(id),
        trash INTEGER
      );
    ''');
  }

  Future<void> _createTables(Database db, int version) async {
    await db.execute('DROP TABLE IF EXISTS task_lists');
    await db.execute('DROP TABLE IF EXISTS tasks');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS task_lists(
        id TEXT PRIMARY KEY,
        name TEXT
      );
    ''');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS tasks(
        id TEXT PRIMARY KEY,
        title TEXT,
        details TEXT,
        time TEXT,
        completed INTEGER,
        favorited INTEGER,
        list_id TEXT,
        trash INTEGER
      );
    ''');
  }

  @override
  Future<int> addTaskList(TaskList taskList) async {
    Database db = await instance.db;
    return await db.insert('task_lists', taskList.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  @override
  Future<void> deleteTaskList(TaskList taskList) async {
    Database db = await instance.db;
    await db.delete('task_lists', where: 'id = ?', whereArgs: [taskList.id]);
    await db.delete('tasks', where: 'list_id = ?', whereArgs: [taskList.id]);
  }

  @override
  Future<List<TaskList>> getTaskLists() async {
    Database db = await instance.db;

    var taskLists = await db.query('task_lists');
    return taskLists.isNotEmpty
        ? taskLists.map((e) => TaskList.fromMap(e)).toList()
        : [];
  }

  @override
  Future<void> updateTaskList(TaskList taskList) {
    throw UnimplementedError();
  }

  @override
  Future<void> addTask(Task task) async {
    Database db = await instance.db;

    await db.insert('tasks', task.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  @override
  Future<void> deleteTask(String taskId) async {
    Database db = await instance.db;

    await db.delete('tasks', where: 'id = ?', whereArgs: [taskId]);
  }

  @override
  Future<void> updateTask(Task task) async {
    Database db = await instance.db;

    await db
        .update('tasks', task.toMap(), where: 'id = ?', whereArgs: [task.id]);
  }

  @override
  Future<List<Task>> getTasks(String listId) async {
    Database db = await instance.db;

    var tasks =
        await db.query('tasks', where: 'list_id = ?', whereArgs: [listId]);

    return tasks.isNotEmpty ? tasks.map((e) => Task.fromMap(e)).toList() : [];
  }
}
