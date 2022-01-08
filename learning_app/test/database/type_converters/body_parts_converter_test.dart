import 'package:flutter_test/flutter_test.dart';
import 'package:learning_app/database/type_converters/body_parts_converter.dart';
import 'package:learning_app/features/learning_aids_body_list/models/body_parts.dart';

void main() {
  group('when formatting from db to dart', () {
    late BodyPartsConverter learnMethodsConverter;

    setUp(() {
      learnMethodsConverter = const BodyPartsConverter();
    });

    test('the converter should return the correct learn method', () {
      // Arrange
      var expected = BodyParts.head;

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
      expect(BodyParts.head.index, 0);
      expect(BodyParts.breast.index, 1);
      expect(BodyParts.shoulderLeft.index, 2);
      expect(BodyParts.shoulderRight.index, 3);
      expect(BodyParts.upperArmLeft.index, 4);
      expect(BodyParts.upperArmRight.index, 5);
      expect(BodyParts.lowerArmLeft.index, 6);
      expect(BodyParts.lowerArmRight.index, 7);
      expect(BodyParts.handLeft.index, 8);
      expect(BodyParts.handRight.index, 9);
      expect(BodyParts.waist.index, 10);
      expect(BodyParts.hip.index, 11);
      expect(BodyParts.upperLegLeft.index, 12);
      expect(BodyParts.lowerLegRight.index, 13);
      expect(BodyParts.footLeft.index, 14);
      expect(BodyParts.footRight.index, 15);
    });
  });

  group('when formatting from dart to db', () {
    late BodyPartsConverter learnMethodsConverter;

    setUp(() {
      learnMethodsConverter = const BodyPartsConverter();
    });

    test('the converter should return the correct int', () {
      // Arrange
      const expected = 0;

      // Act
      var actual = learnMethodsConverter.mapToSql(BodyParts.head);

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
