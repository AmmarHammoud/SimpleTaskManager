
import '../shared/constants.dart';

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
