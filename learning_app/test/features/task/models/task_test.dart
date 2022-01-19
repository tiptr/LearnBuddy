import 'package:flutter_test/flutter_test.dart';
import 'package:learning_app/features/tasks/models/task.dart';
import 'package:learning_app/features/time_logs/models/time_log.dart';

void main() {
  group('when estimating the remaining duration', () {
    test('it should return the full duration when no time logs are present',
        () {
      // Arrange
      const mockDuration = Duration(hours: 5);

      var mockTask = Task(
          id: 1,
          title: 'ABC',
          keywords: [],
          timeLogs: [],
          creationDateTime: DateTime.now(),
          children: [],
          learnLists: [],
          manualTimeEffortDelta: Duration.zero,
          estimatedTime: mockDuration);

      // Act
      var actual = mockTask.remainingTimeEstimation;

      // Arrange
      expect(actual, mockDuration);
    });

    test('it should properly take time logs into consideration', () {
      // Arrange
      const mockDuration = Duration(hours: 5);
      const mockDelta = Duration(hours: 2);
      const expected = Duration(hours: 3);

      var mockTask = Task(
        id: 1,
        title: 'ABC',
        keywords: [],
        timeLogs: [
          TimeLog(
            id: 1,
            taskId: 1,
            beginTime: DateTime.now().subtract(const Duration(hours: 24)),
            duration: mockDelta,
          )
        ],
        creationDateTime: DateTime.now(),
        children: [],
        learnLists: [],
        manualTimeEffortDelta: Duration.zero,
        estimatedTime: mockDuration,
      );

      // Act
      var actual = mockTask.remainingTimeEstimation;

      // Arrange
      expect(actual, expected);
    });

    test(
        'it should also properly take time logs of children into consideration',
        () {
      // Arrange
      const mockDuration = Duration(hours: 5);
      const mockDelta = Duration(hours: 2);
      const expected = Duration(hours: 1);

      var mockTask = Task(
        id: 1,
        title: 'ABC',
        keywords: [],
        timeLogs: [
          TimeLog(
            id: 1,
            taskId: 1,
            beginTime: DateTime.now().subtract(const Duration(hours: 24)),
            duration: mockDelta,
          )
        ],
        creationDateTime: DateTime.now(),
        children: [
          Task(
            id: 2,
            title: 'DEF',
            keywords: [],
            timeLogs: [
              TimeLog(
                id: 2,
                taskId: 2,
                beginTime: DateTime.now().subtract(const Duration(hours: 24)),
                duration: mockDelta,
              )
            ],
            creationDateTime:
                DateTime.now().subtract(const Duration(hours: 12)),
            children: [],
            learnLists: [],
            manualTimeEffortDelta: Duration.zero,
          )
        ],
        learnLists: [],
        manualTimeEffortDelta: Duration.zero,
        estimatedTime: mockDuration,
      );

      // Act
      var actual = mockTask.remainingTimeEstimation;

      // Arrange
      expect(actual, expected);
    });

    test('it should calculate at least Duration.zero', () {
      // Arrange
      const mockDuration = Duration(hours: 5);
      const mockDelta = Duration(hours: 10);
      const expected = Duration.zero;

      var mockTask = Task(
        id: 1,
        title: 'ABC',
        keywords: [],
        timeLogs: [
          TimeLog(
            id: 1,
            taskId: 1,
            beginTime: DateTime.now().subtract(const Duration(hours: 24)),
            duration: mockDelta,
          )
        ],
        creationDateTime: DateTime.now(),
        children: [],
        learnLists: [],
        manualTimeEffortDelta: Duration.zero,
        estimatedTime: mockDuration,
      );

      // Act
      var actual = mockTask.remainingTimeEstimation;

      // Arrange
      expect(actual, expected);
    });
  });
}
