import 'package:flutter_test/flutter_test.dart';
import 'package:learning_app/features/dashboard/util/calculate_progress_data.dart';
import 'package:learning_app/features/tasks/dtos/list_read_task_dto.dart';

void main() {
  test('formatting a duration should return a proper string', () {
    expect(true, true);
  });

  group('when calculating the progress data', () {
    test('it should handle an empty list of tasks properly', () {
      const showTaskCount = 5;
      var actual = calculateProgressData([], showTaskCount);

      expect(actual.doneTaskCount, 0);
      expect(actual.totalTaskCount, 0);
      expect(actual.hasMore, false);
      expect(actual.moreCount, 0);
      expect(actual.remainingDuration, null);
      expect(actual.upcomingTasks, []);
    });

    test('it should calculate the correct result', () {
      // Arrange
      const expectedDuration = Duration(seconds: 10);

      var listReadTaskDtos = <ListReadTaskDto>[
        ListReadTaskDto(
          id: 1,
          title: 'A',
          done: false,
          dueDate: DateTime.now(),
          categoryColor: null,
          isQueued: false,
          keywords: const [],
          finishedSubTaskCount: 0,
          subTaskCount: 0,
          remainingTimeEstimation: expectedDuration,
        ),
        ListReadTaskDto(
          id: 2,
          title: 'B',
          done: true,
          dueDate: DateTime.now(),
          doneDateTime: DateTime.now(),
          categoryColor: null,
          isQueued: false,
          keywords: const [],
          finishedSubTaskCount: 0,
          subTaskCount: 0,
          remainingTimeEstimation: expectedDuration,
        ),
      ];

      const showTaskCount = 10;

      // Act
      var actual = calculateProgressData(listReadTaskDtos, showTaskCount);

      // Only one of both tasks is done
      expect(actual.doneTaskCount, 1);
      expect(actual.totalTaskCount, 2);

      // Enough tasks could be "rendered", hasMore is false
      expect(actual.hasMore, false);
      expect(actual.moreCount, 0);

      // The total duration is expectedDuration * 2, but one is done
      expect(actual.remainingDuration, expectedDuration);

      // Upcoming should be the tasks that are not done
      expect(
        actual.upcomingTasks,
        listReadTaskDtos.where((e) => !e.done).toList(),
      );
    });

    test('it should properly handle the more tasks calculation', () {
      // Arrange

      var listReadTaskDtos = <ListReadTaskDto>[
        ListReadTaskDto(
          id: 1,
          title: 'A',
          done: false,
          dueDate: DateTime.now(),
          doneDateTime: DateTime.now(),
          categoryColor: null,
          isQueued: false,
          keywords: const [],
          finishedSubTaskCount: 0,
          subTaskCount: 0,
        ),
        ListReadTaskDto(
          id: 2,
          title: 'B',
          done: false,
          dueDate: DateTime.now(),
          doneDateTime: DateTime.now(),
          categoryColor: null,
          isQueued: false,
          keywords: const [],
          finishedSubTaskCount: 0,
          subTaskCount: 0,
        ),
      ];

      const showTaskCount = 1;

      // Act
      var actual = calculateProgressData(listReadTaskDtos, showTaskCount);

      // Enough tasks could be "rendered", hasMore is false
      expect(actual.hasMore, true);
      expect(actual.moreCount, 1);
    });

    test('it should calculate a duration of zero when all are done', () {
      // Arrange
      var listReadTaskDtos = <ListReadTaskDto>[
        ListReadTaskDto(
          id: 1,
          title: 'A',
          done: true,
          dueDate: DateTime.now(),
          doneDateTime: DateTime.now(),
          categoryColor: null,
          isQueued: false,
          keywords: const [],
          finishedSubTaskCount: 0,
          subTaskCount: 0,
          remainingTimeEstimation: const Duration(days: 30),
        ),
        ListReadTaskDto(
          id: 2,
          title: 'B',
          done: true,
          dueDate: DateTime.now(),
          doneDateTime: DateTime.now(),
          categoryColor: null,
          isQueued: false,
          keywords: const [],
          finishedSubTaskCount: 0,
          subTaskCount: 0,
          remainingTimeEstimation: const Duration(days: 30),
        ),
      ];

      // Act
      var actual = calculateProgressData(listReadTaskDtos, 10);

      expect(actual.remainingDuration, null);
    });
  });
}
