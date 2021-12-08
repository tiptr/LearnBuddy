class Todo {
  int? id;
  String title;
  bool done;

  Todo({required this.title, required this.done});

  @override
  String toString() {
    return "TODO: $title - $done";
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'title': title, 'done': done ? 1 : 0};
  }
}
