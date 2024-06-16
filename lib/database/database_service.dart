import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/task_model.dart';
import '../shared/constants.dart';
class MyDatabase {
  static late Database db;

  static Future<String> get fullPath async {
    const name = 'task_manager.db';
    final path = await getDatabasesPath();
    print(path + name);
    return join(path, name);
  }

  static Future open() async {
    db = await openDatabase(await fullPath, version: 1,
        onCreate: (Database db, int version) async {
          await db.execute('''
create table if not exists $tableTodo ( 
  $columnId integer primary key autoincrement, 
  $columnTitle text not null,
  $columnDone integer not null)
''');
          await db.execute('''
create table if not exists $tableTodoTask (
  $columnId integer primary key autoincrement,
  $columnTitle text not null,
  $columnDone integer not null)
''');
        });
  }

  static Future<Todo> insert(Todo todo, {String tableName = tableTodo}) async {
    todo.id = await db.insert(tableName, todo.toMap());
    return todo;
  }

  static Future<Todo?> getTodo(int id, {String tableName = tableTodo}) async {
    List<Map<String, dynamic>> maps = await db.query(tableName,
        columns: [columnId, columnDone, columnTitle],
        where: '$columnId = ?',
        whereArgs: [id]);
    if (maps.isNotEmpty) {
      return Todo.fromMap(maps.first);
    }
    return null;
  }

  static Future<List<Todo>> fetchAll({String tableName = tableTodo}) async {
    final todos = await db.rawQuery('''SELECT * FROM $tableName''');
    return todos.map((todo) => Todo.fromSqfliteDatabase(todo)).toList();
  }

  static Future<int> delete(int id, {String tableName = tableTodo}) async {
    return await db.delete(tableName, where: '$columnId = ?', whereArgs: [id]);
  }

  static Future<int> update(Todo todo, {String tableName = tableTodo}) async {
    return await db.update(tableName, todo.toMap(),
        where: '$columnId = ?', whereArgs: [todo.id]);
  }

  ///Many applications use one database and would never need to close it
  ///(it will be closed when the application is terminated).
  ///If you want to release resources, you can close the database.
  static Future close() async => db.close();

  static Future<dynamic> clear() async{
    //return await db.
  }

  static Future<void> deleteDatabase() async{
    databaseFactory.deleteDatabase(await fullPath);
  }
}