import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:learning_app/database/type_converters/color_converter.dart';

void main() {
  group('when formatting from db to dart', () {
    const mockColor = Colors.red;
    var mockValue = mockColor.value;

    late ColorConverter colorConverter;

    setUp(() {
      colorConverter = const ColorConverter();
    });

    test('the converter should return the correct color', () {
      // Arrange
      MaterialColor expected = mockColor;

      // Act
      var actual = colorConverter.mapToDart(mockValue);

      // Assert
      expect(expected.value, actual!.value);
    });

    test('the converter should return null', () {
      // Act
      var actual = colorConverter.mapToDart(null);

      // Assert
      expect(null, actual);
    });
  });

  group('when formatting from dart to db', () {
    late ColorConverter colorConverter;

    setUp(() {
      colorConverter = const ColorConverter();
    });

    test('the converter should return the correct value', () {
      // Arrange
      int expected = Colors.red.value;

      // Act
      var actual = colorConverter.mapToSql(Colors.red);

      // Assert
      expect(expected, actual);
    });

    test('the converter should return null', () {
      // Act
      var actual = colorConverter.mapToSql(null);

      // Assert
      expect(null, actual);
    });
  });
}
