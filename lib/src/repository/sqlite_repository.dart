import 'dart:async';

import 'package:done/src/models/sub_task.dart';
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
    await db.execute('DROP TABLE IF EXISTS sub_tasks');

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

    await db.execute('''
      CREATE TABLE sub_tasks(
        id TEXT PRIMARY KEY,
        content TEXT, 
        completed INTEGER,
        trash INTEGER,
        task_id TEXT REFERENCES tasks(id)
      ); 

    ''');
  }

  Future<void> _createTables(Database db, int version) async {
    await db.execute('DROP TABLE IF EXISTS task_lists');
    await db.execute('DROP TABLE IF EXISTS tasks');
    await db.execute('DROP TABLE IF EXISTS sub_tasks');

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

    await db.execute('''
      CREATE TABLE sub_tasks(
        id TEXT PRIMARY KEY,
        content TEXT, 
        completed INTEGER,
        trash INTEGER,
        task_id TEXT REFERENCES tasks(id)
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
    return taskLists.isEmpty
        ? []
        : taskLists.map((e) => TaskList.fromMap(e)).toList();
  }

  @override
  Future<void> updateTaskList(TaskList taskList) async {
    Database db = await instance.db;

    await db.update('task_lists', taskList.toMap(),
        where: 'id = ?', whereArgs: [taskList.id]);
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
    await db.delete('sub_tasks', where: 'task_id = ?', whereArgs: [taskId]);
  }

  @override
  Future<void> updateTask(Task task) async {
    Database db = await instance.db;

    await db
        .update('tasks', task.toMap(), where: 'id = ?', whereArgs: [task.id]);
  }

  @override
  Future<List<Task>> getTasks() async {
    Database db = await instance.db;

    var tasks = await db.query('tasks');
    return tasks.isNotEmpty ? tasks.map((e) => Task.fromMap(e)).toList() : [];
  }

  @override
  Future<void> addSubTask(SubTask subTask) async {
    Database db = await instance.db;

    await db.insert('sub_tasks', subTask.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  @override
  Future<void> deleteSubTask(String id) async {
    Database db = await instance.db;
    await db.delete('sub_tasks', where: 'id = ?', whereArgs: [id]);
  }

  @override
  Future<List<SubTask>> getSubTasks(String taskId) async {
    Database db = await instance.db;
    var subTasks = await db.query(
      'sub_tasks',
      where: 'task_id = ?',
      whereArgs: [taskId],
    );

    return subTasks.isEmpty
        ? []
        : subTasks.map((e) => SubTask.fromMap(e)).toList();
  }

  @override
  Future<void> updateSubTask(SubTask subTask) async {
    Database db = await instance.db;
    await db.update('sub_tasks', subTask.toMap(),
        where: 'id = ?', whereArgs: [subTask.id]);
  }
}
