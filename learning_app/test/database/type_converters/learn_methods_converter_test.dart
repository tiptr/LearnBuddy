import 'package:flutter_test/flutter_test.dart';
import 'package:learning_app/database/type_converters/learn_methods_converter.dart';
import 'package:learning_app/features/learning_aids/models/learn_methods.dart';

void main() {
  group('when formatting from db to dart', () {
    late LearnMethodsConverter learnMethodsConverter;

    setUp(() {
      learnMethodsConverter = const LearnMethodsConverter();
    });

    test('the converter should return the correct learn method', () {
      // Arrange
      LearnMethods expected = LearnMethods.bodyList;

      // Act
      var actual = learnMethodsConverter.mapToDart(0);

      // Assert
      expect(expected, actual);
    });

    test('the converter should return null', () {
      // Act
      var actual = learnMethodsConverter.mapToDart(null);

      // Assert
      expect(null, actual);
    });

    test('body list order is intact', () {
      expect(LearnMethods.bodyList.index, 0);
      expect(LearnMethods.storyList.index, 1);
    });
  });

  group('when formatting from dart to db', () {
    late LearnMethodsConverter learnMethodsConverter;

    setUp(() {
      learnMethodsConverter = const LearnMethodsConverter();
    });

    test('the converter should return the correct int', () {
      // Arrange
      const expected = 0;

      // Act
      var actual = learnMethodsConverter.mapToSql(LearnMethods.bodyList);

      // Assert
      expect(expected, actual);
    });

    test('the converter should return null', () {
      // Act
      var actual = learnMethodsConverter.mapToSql(null);

      // Assert
      expect(null, actual);
    });
  });
}
