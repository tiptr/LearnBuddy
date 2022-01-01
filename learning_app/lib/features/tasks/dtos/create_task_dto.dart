
class CreateTaskDto {
  // Only attributes of task, that are userdefined at task creation:
  String? title;
  String? description;
  int? estimatedTime;
  DateTime? dueDate;

  //Task? parentTask; TODO
  // category TODO
  // List keywords TODO

  CreateTaskDto({
    this.title,
    this.description,
    this.estimatedTime,
    this.dueDate,
  });

  /// Changes the current instance by adding all non-null values of the new DTO
  void applyChangesFrom(CreateTaskDto newDto) {
    title = newDto.title ?? title;
    description = newDto.description ?? description;
    estimatedTime = newDto.estimatedTime ?? estimatedTime;
    dueDate = newDto.dueDate ?? dueDate;
    // TODO: parentTask
    // TODO: category
    // TODO: keywords
  }

  /// Checks, if the DTO is fulfilling all attribute requirements
  bool isReadyToStore() {
    return title != null && description != null && dueDate != null;
  }
}
