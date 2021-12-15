import 'package:flutter_test/flutter_test.dart';
import 'package:learning_app/util/formatting.dart';

void main() {
  group('when formatting a duration', () {
    test('formatting a duration should return a proper string', () {
      // Arrange
      const duration = Duration(hours: 5, minutes: 6);
      const expected = "5 h 6 min";

      // Act
      var actual = Formatting.formatDuration(duration, "");

      expect(actual, expected);
    });

    test('formatting a duration of null should return the alternative', () {
      // Arrange
      const expected = "Alternative String";

      // Act
      var actual = Formatting.formatDuration(null, expected);

      expect(actual, expected);
    });
  });

  group('when formatting a datetime', () {
    test('formatting a datetime should return a proper string', () {
      // Arrange
      var dateTime = DateTime(2020);
      const expected = "01.01.2020";

      // Act
      var actual = Formatting.formatDateTime(dateTime, "");

      expect(actual, expected);
    });

    test('formatting a datetime of null should return the alternative', () {
      // Arrange
      const expected = "Alternative String";

      // Act
      var actual = Formatting.formatDateTime(null, expected);

      expect(actual, expected);
    });
  });
}
