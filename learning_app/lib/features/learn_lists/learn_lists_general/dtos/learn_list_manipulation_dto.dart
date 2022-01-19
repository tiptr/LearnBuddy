import 'package:drift/drift.dart';
import 'package:learning_app/features/categories/models/category.dart';
import 'package:learning_app/features/learn_lists/learn_lists_general/models/learn_list_word.dart';

class LearnListManipulationDto {
  Value<int> id;
  Value<String> name;
  Value<DateTime> creationDate;
  Value<List<LearnListWord>> words;
  Value<Category?> category;
  Value<bool> isArchived;

  // To be calculated additionally to the attributes from the model.
  Value<int> referencingTasksCount;

  LearnListManipulationDto(
      {this.id = const Value.absent(),
      this.name = const Value.absent(),
      this.creationDate = const Value.absent(),
      this.words = const Value.absent(),
      this.category = const Value.absent(),
      this.isArchived = const Value.absent(),
      this.referencingTasksCount = const Value.absent()});

  /// Changes the current instance by replacing all present values of the new DTO
  void applyChangesFrom(LearnListManipulationDto newDto) {
    id = newDto.id.present ? newDto.id : id;
    name = newDto.name.present ? newDto.name : name;
    creationDate =
        newDto.creationDate.present ? newDto.creationDate : creationDate;
    words = newDto.words.present ? newDto.words : words;
    category = newDto.category.present ? newDto.category : category;
    isArchived = newDto.isArchived.present ? newDto.isArchived : isArchived;
    referencingTasksCount = newDto.referencingTasksCount.present
        ? newDto.referencingTasksCount
        : referencingTasksCount;
  }

  /// Checks, if the DTO is fulfilling all attribute requirements
  bool get isReadyToStore {
    return name.present && name.value != '';
  }

  /// Returns a string that explains, which fields are still missing for
  /// the validation to succeed
  String? get missingFieldsDescription {
    if (isReadyToStore) {
      // Nothing missing
      return null;
    } else {
      return 'Bitte zuerst einen Namen eingeben.';
    }
  }
}
