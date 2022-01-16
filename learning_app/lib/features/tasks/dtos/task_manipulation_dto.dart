import 'package:drift/drift.dart';

/// This is the parent class for both the create and the update dto
///
/// Used by the frontend to update individual attributes
class TaskManipulationDto {
  Value<String> title;
  Value<String?> description;
  Value<Duration?> estimatedTime;
  Value<DateTime?> dueDate;
  Value<Duration> manualTimeEffortDelta;
  Value<int?> categoryId;
  Value<List<int>> keywordIds;
  Value<List<int>> learnListsIds;

  TaskManipulationDto({
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
  void applyChangesFrom(TaskManipulationDto newDto) {
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

  /// Checks, if the DTO is fulfilling all attribute requirements
  bool get isReadyToStore {
    return title.present && title.value != '';
  }

  /// Returns a string that explains, which fields are still missing for
  /// the validation to succeed
  String? get missingFieldsDescription {
    if (isReadyToStore) {
      // Nothing missing
      return null;
    } else {
      return 'Bitte zuerst einen Titel eingeben.';
    }
  }
}
