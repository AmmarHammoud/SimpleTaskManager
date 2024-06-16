import 'package:flutter_test/flutter_test.dart';
import 'package:maidscc_test/database/database_service.dart';
import 'package:maidscc_test/models/task_model.dart';
import 'package:maidscc_test/shared/constants.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() async {
  setUpAll(() async {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
    await MyDatabase.open();
  });

  group('database test', () {
    Todo todo = Todo(title: 'task_test');
    test('add task', () async {
      var t = await MyDatabase.insert(todo, tableName: tableTodoTask);
      var p = await MyDatabase.db.query(tableTodoTask);
      print(p);
      expect(p.length, t.id);
    });

    test('update task', () async {
      var t = await MyDatabase.update(todo);
      var p = await MyDatabase.db.query(tableTodoTask);
      expect(p.first['title'], todo.title);
    });

    test('delete task', () async {
      var p1 = await MyDatabase.db.query(tableTodoTask);
      var t = await MyDatabase.delete(todo.id!, tableName: tableTodoTask);
      var p2 = await MyDatabase.db.query(tableTodoTask);
      expect(p2.length, p1.length - t);
    });
  });
}
