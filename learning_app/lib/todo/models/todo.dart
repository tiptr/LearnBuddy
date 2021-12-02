class Todo {
  String title;
  bool done;

  Todo({required this.title, required this.done});

  @override
  String toString() {
    return "TODO: $title - $done";
  }
}
