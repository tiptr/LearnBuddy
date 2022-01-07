import 'package:flutter_test/flutter_test.dart';
import 'package:learning_app/database/type_converters/body_parts_converter.dart';
import 'package:learning_app/features/learning_aids_body_list/models/body_parts.dart';

void main() {
  group('when formatting from db to dart', () {
    late BodyPartsConverter bodyPartsConverter;

    setUp(() {
      bodyPartsConverter = const BodyPartsConverter();
    });

    test('the converter should return the correct learn method', () {
      // Arrange
      var expected = BodyParts.head;

      // Act
      var actual = bodyPartsConverter.mapToDart(1);

      // Assert
      expect(expected, actual);
    });

    test('the converter should return null', () {
      // Act
      var actual = bodyPartsConverter.mapToDart(null);

      // Assert
      expect(null, actual);
    });

    test('body list order is intact', () {
      expect(BodyParts.head, 1);
      expect(BodyParts.breast, 2);
      expect(BodyParts.shoulderLeft, 3);
      expect(BodyParts.shoulderRight, 4);
      expect(BodyParts.upperArmLeft, 5);
      expect(BodyParts.upperArmRight, 6);
      expect(BodyParts.lowerArmLeft, 7);
      expect(BodyParts.lowerArmRight, 8);
      expect(BodyParts.handLeft, 9);
      expect(BodyParts.handRight, 10);
      expect(BodyParts.waist, 11);
      expect(BodyParts.hip, 12);
      expect(BodyParts.upperLegLeft, 13);
      expect(BodyParts.lowerLegRight, 14);
      expect(BodyParts.footLeft, 15);
      expect(BodyParts.footRight, 16);
    });
  });

  group('when formatting from dart to db', () {
    late BodyPartsConverter learnMethodsConverter;

    setUp(() {
      learnMethodsConverter = const BodyPartsConverter();
    });

    test('the converter should return the correct int', () {
      // Arrange
      const expected = 1;

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
