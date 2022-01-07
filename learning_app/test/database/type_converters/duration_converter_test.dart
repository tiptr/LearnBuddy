import 'package:flutter_test/flutter_test.dart';
import 'package:learning_app/database/type_converters/duration_converter.dart';

void main() {
  group('when formatting from db to dart', () {
    late DurationConverter durationConverter;

    setUp(() {
      durationConverter = const DurationConverter();
    });

    test('the converter should return the correct duration', () {
      // Arrange
      const seconds = 600;
      Duration expected = const Duration(seconds: seconds);

      // Act
      var actual = durationConverter.mapToDart(seconds);

      // Assert
      expect(expected, actual);
    });

    test('the converter should return null', () {
      // Act
      var actual = durationConverter.mapToDart(null);

      // Assert
      expect(null, actual);
    });
  });

  group('when formatting from dart to db', () {
    late DurationConverter durationConverter;

    setUp(() {
      durationConverter = const DurationConverter();
    });

    test('the converter should return the correct amount of seconds', () {
      // Arrange
      const expected = 600;
      const mockDuration = Duration(seconds: expected);

      // Act
      var actual = durationConverter.mapToSql(mockDuration);

      // Assert
      expect(expected, actual);
    });

    test('the converter should return null', () {
      // Act
      var actual = durationConverter.mapToSql(null);

      // Assert
      expect(null, actual);
    });
  });
}
