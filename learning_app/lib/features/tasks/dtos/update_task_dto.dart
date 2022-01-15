import 'package:drift/drift.dart';

class UpdateTaskDto {
  int id;
  Value<String> title;
  Value<String?> description;
  Value<Duration?> estimatedTime;
  Value<DateTime?> dueDate;
  Value<Duration> manualTimeEffortDelta;
  Value<int?> categoryId;
  Value<List<int>> keywordIds;
  Value<List<int>> learnListsIds;

  UpdateTaskDto({
    required this.id,
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.keywordIds = const Value.absent(),
    this.estimatedTime = const Value.absent(),
    this.dueDate = const Value.absent(),
    this.learnListsIds = const Value.absent(),
    this.manualTimeEffortDelta = const Value.absent(),
  });

  /// Changes the current instance by replacing all present values of the new DTO
  void applyChangesFrom(UpdateTaskDto newDto) {
    title = newDto.title.present ? newDto.title : title;
    description = newDto.description.present ? newDto.description : description;
    estimatedTime =
        newDto.estimatedTime.present ? newDto.estimatedTime : estimatedTime;
    dueDate = newDto.dueDate.present ? newDto.dueDate : dueDate;
    manualTimeEffortDelta = newDto.manualTimeEffortDelta.present
        ? newDto.manualTimeEffortDelta
        : manualTimeEffortDelta;
    categoryId = newDto.categoryId.present ? newDto.categoryId : categoryId;
    keywordIds = newDto.keywordIds.present ? newDto.keywordIds : keywordIds;
    learnListsIds =
        newDto.learnListsIds.present ? newDto.learnListsIds : learnListsIds;
  }

  /// Whether this update-dto actually contains changes
  bool containsUpdates() {
    return title.present ||
        description.present ||
        categoryId.present ||
        keywordIds.present ||
        estimatedTime.present ||
        dueDate.present ||
        learnListsIds.present ||
        manualTimeEffortDelta.present;
  }
}
