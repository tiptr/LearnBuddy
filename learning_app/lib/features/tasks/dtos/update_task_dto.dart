import 'package:drift/drift.dart';
import 'package:learning_app/features/tasks/dtos/task_manipulation_dto.dart';

class UpdateTaskDto extends TaskManipulationDto {
  int id;

  UpdateTaskDto({
    required this.id,
    Value<String> title = const Value.absent(),
    Value<String?> description = const Value.absent(),
    Value<Duration?> estimatedTime = const Value.absent(),
    Value<DateTime?> dueDate = const Value.absent(),
    Value<Duration> manualTimeEffortDelta = const Value.absent(),
    Value<int?> categoryId = const Value.absent(),
    Value<List<int>> keywordIds = const Value.absent(),
    Value<List<int>> learnListsIds = const Value.absent(),
  }) : super(
          title: title,
          description: description,
          estimatedTime: estimatedTime,
          dueDate: dueDate,
          manualTimeEffortDelta: manualTimeEffortDelta,
          categoryId: categoryId,
          keywordIds: keywordIds,
          learnListsIds: learnListsIds,
        );

  /// Changes the current instance by replacing all present values of the new DTO
  @override
  void applyChangesFrom(TaskManipulationDto newDto) {
    super.applyChangesFrom(newDto);
  }

  /// Checks, if the DTO is fulfilling all attribute requirements
  @override
  bool get isReadyToStore {
    return !title.present || title.value != '';
  }
}
