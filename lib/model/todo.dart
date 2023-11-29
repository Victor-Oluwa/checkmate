// ignore_for_file: public_member_api_docs, sort_constructors_first
class ToDo {
  final String id;
  final String todoText;
  bool isDone;
  ToDo({
    required this.id,
    required this.todoText,
    required this.isDone,
  });

  static List<ToDo> todoList() {
    return [
      ToDo(id: '01', todoText: 'Morning Excercise', isDone: true),
      ToDo(id: '03', todoText: 'Read The Bible', isDone: true),
      ToDo(id: '02', todoText: 'Feed the cows', isDone: true),
      ToDo(id: '04', todoText: 'Code', isDone: true),
      ToDo(id: '06', todoText: 'Play Football', isDone: true),
      ToDo(id: '05', todoText: 'Love', isDone: true),
      ToDo(id: '07', todoText: 'Toast a girl', isDone: false),
      ToDo(id: '08', todoText: 'Sleep 12 hours', isDone: false),
    ];
  }

  ToDo copyWith({
    String? id,
    String? todoText,
    bool? isDone,
  }) {
    return ToDo(
      id: id ?? this.id,
      todoText: todoText ?? this.todoText,
      isDone: isDone ?? this.isDone,
    );
  }
}
