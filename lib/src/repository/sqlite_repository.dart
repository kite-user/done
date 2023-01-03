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
      version: 1,
      onCreate: _createTables,
    );
  }

  Future<void> _createTables(Database db, int version) {
    return db.execute('''
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
  Future<void> deleteTaskList(TaskList taskList) async {
    Database db = await instance.db;
    await db.delete('task_lists', where: 'id = ?', whereArgs: [taskList.id]);
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
  Future<void> addTask(Task task) {
    // TODO: implement addTask
    throw UnimplementedError();
  }

  @override
  Future<void> deleteTask(Task task) {
    // TODO: implement deleteTask
    throw UnimplementedError();
  }

  @override
  Future<List<Task>> getTasks() {
    // TODO: implement getTasks
    throw UnimplementedError();
  }

  @override
  Future<void> updateTask(Task task) {
    // TODO: implement updateTask
    throw UnimplementedError();
  }
}
