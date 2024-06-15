import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

const String tableTodo = 'todo';
const String columnId = '_id';
const String columnTitle = 'title';
const String columnDone = 'done';

class Todo {
  late int? id;
  late String title;
  late bool done;

  Todo({this.id, required this.title, this.done = false});

  factory Todo.fromSqfliteDatabase(Map<String, dynamic> map) =>
      Todo(id: map['_id']?.toInt() ?? 0, title: map['title'] ?? '', done: map['done'] == 0 ? false : true);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnTitle: title,
      columnDone: done == true ? 1 : 0
    };

    map[columnId] = id;

    return map;
  }

  //Todo();

  Todo.fromMap(Map<String, dynamic> map) {
    id = map[columnId];
    title = map[columnTitle];
    done = map[columnDone] == 1;
  }

  @override
  String toString() {
    return 'Todo{id: $id, title: $title, done: $done}';
  }
}

class MyDatabase {
  static late Database db;

  static Future<String> get fullPath async {
    const name = 'task_manager.db';
    final path = await getDatabasesPath();
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
    });
  }

  static Future<Todo> insert(Todo todo) async {
    todo.id = await db.insert(tableTodo, todo.toMap());
    print('in insert: $todo');
    return todo;
  }

  static Future<Todo?> getTodo(int id) async {
    List<Map<String, dynamic>> maps = await db.query(tableTodo,
        columns: [columnId, columnDone, columnTitle],
        where: '$columnId = ?',
        whereArgs: [id]);
    if (maps.isNotEmpty) {
      return Todo.fromMap(maps.first);
    }
    return null;
  }

    static Future<List<Todo>> fetchAll() async {
    final todos = await db.rawQuery('''SELECT * FROM $tableTodo''');
    return todos.map((todo) => Todo.fromSqfliteDatabase(todo)).toList();
  }

  static Future<int> delete(int id) async {
    return await db.delete(tableTodo, where: '$columnId = ?', whereArgs: [id]);
  }

  static Future<int> update(Todo todo) async {
    return await db.update(tableTodo, todo.toMap(),
        where: '$columnId = ?', whereArgs: [todo.id]);
  }

  ///Many applications use one database and would never need to close it
  ///(it will be closed when the application is terminated).
  ///If you want to release resources, you can close the database.
  static Future close() async => db.close();

  static Future<dynamic> test() async{
    insert(Todo(id: 0, title: 'go to  gym', done: false));
    insert(Todo(id: 1, title: 'go to  market', done: false));
    return await db.rawQuery('''SELECT * FROM $tableTodo''');
  }
  static Future<dynamic> clear() async{
    //return await db.
  }

  static Future<void> deleteDatabase() async{
    databaseFactory.deleteDatabase(await fullPath);
  }
}
