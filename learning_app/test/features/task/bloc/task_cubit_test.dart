import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:learning_app/features/tasks/bloc/task_cubit.dart';
import 'package:learning_app/features/tasks/bloc/task_state.dart';
import 'package:learning_app/features/tasks/models/task.dart';
import 'package:learning_app/features/tasks/repositories/task_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockTaskRepository extends Mock implements TaskRepository {}

void main() {
  late MockTaskRepository mockTaskRepository;
  late TaskCubit taskCubit;

  Task mockTask = Task(title: 'Do something', done: false);

  setUp(() {
    mockTaskRepository = MockTaskRepository();
    taskCubit = TaskCubit(mockTaskRepository);
  });

  group(
    'when calling fetchTasks',
    () {
      blocTest<TaskCubit, TaskState>(
        'CounterCubit should fetch all tasks and store the result',
        build: () {
          var mockResponse = Future.value([mockTask]);
          when(() => mockTaskRepository.loadTasks())
              .thenAnswer((_) => mockResponse);

          return taskCubit;
        },
        act: (cubit) async => await cubit.loadTasks(),
        expect: () => [
          TasksLoaded(tasks: [mockTask]),
        ],
        verify: (_) {
          verify(() => mockTaskRepository.loadTasks()).called(1);
        },
      );

      blocTest<TaskCubit, TaskState>(
        'CounterCubit should overwrite existing tasks in the state',
        build: () {
          var mockResponse = Future.value(<Task>[]);

          when(() => mockTaskRepository.loadTasks())
              .thenAnswer((_) => mockResponse);
          return TaskCubit(mockTaskRepository);
        },
        seed: () => TasksLoaded(tasks: [mockTask]),
        act: (cubit) async => await cubit.loadTasks(),
        expect: () => [
          TasksLoaded(tasks: const []),
        ],
      );
    },
  );
}
