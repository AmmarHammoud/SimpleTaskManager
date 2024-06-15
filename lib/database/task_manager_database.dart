// import 'package:maidscc_test/models/task_model.dart';
// import 'package:sqflite/sqflite.dart';
// import 'database_service.dart';
//
// class TaskManagerDB {
//   final tableName = 'task_manager';
//
//   Future<void> createTable(Database database) async {
//     await database.execute('''CREATE TABLE IF NOT EXISTS $tableName (
//     "id" INTEGER NOT NULL,
//     "title" TEXT NOT NULL,
//     "done" INTEGER NOT NULL,
//     PRIMARY KEY ("id" AUTOINCREMENT)
//     );''');
//   }
//
//   Future<int> create({required String title}) async {
//     final database = await DatabaseService().database;
//     return await database.rawInsert(
//         '''INSERT INTO $tableName (title, done) VALUES (?, ?)''',
//         [title, DateTime.now().microsecondsSinceEpoch]);
//   }
//
//   Future<List<Todo>> fetchAll() async {
//     final database = await DatabaseService().database;
//     final todos = await database.rawQuery('''SELECT * FROM $tableName''');
//     return todos.map((todo) => Todo.fromSqfliteDatabase(todo)).toList();
//   }
//
//   Future<Todo> fetchById(int id) async {
//     final database = await DatabaseService().database;
//     final todo = await database
//         .rawQuery('''SELECT * FROM $tableName WHERE id = ?''', [id]);
//     return Todo.fromSqfliteDatabase(todo.first);
//   }
// }
