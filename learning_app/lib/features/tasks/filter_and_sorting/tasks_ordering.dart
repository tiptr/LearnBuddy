enum TaskOrderAttributes {
  dueDate,
  creationDate,
  doneDate,
  title,
}

enum OrderDirection {
  asc,
  desc,
}

class TaskOrder {
  final TaskOrderAttributes attribute;
  final OrderDirection direction;

  const TaskOrder({
    this.attribute = TaskOrderAttributes.dueDate,
    this.direction = OrderDirection.desc,
  });
}
