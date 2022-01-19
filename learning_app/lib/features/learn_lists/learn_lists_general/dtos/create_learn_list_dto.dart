import 'package:drift/drift.dart';
import 'package:learning_app/features/categories/models/category.dart';
import 'package:learning_app/features/learn_lists/learn_lists_general/dtos/learn_list_manipulation_dto.dart';
import 'package:learning_app/features/learn_lists/learn_lists_general/models/learn_list_word.dart';

class CreateLearnListDto extends LearnListManipulationDto {
  CreateLearnListDto(
      {Value<int> id = const Value.absent(),
      Value<String> name = const Value.absent(),
      Value<DateTime> creationDate = const Value.absent(),
      Value<List<LearnListWord>> words = const Value.absent(),
      Value<Category?> category = const Value.absent(),
      Value<bool> isArchived = const Value.absent(),
      Value<int> referencingTasksCount = const Value.absent()})
      : super(
            id: id,
            name: name,
            creationDate: creationDate,
            words: words,
            category: category,
            isArchived: isArchived,
            referencingTasksCount: referencingTasksCount);

  /// Changes the current instance by replacing all present values of the new DTO
  @override
  void applyChangesFrom(LearnListManipulationDto newDto) {
    super.applyChangesFrom(newDto);
  }

  /// Checks, if the DTO is fulfilling all attribute requirements
  @override
  bool get isReadyToStore {
    return name.present && name.value != '';
  }
}
