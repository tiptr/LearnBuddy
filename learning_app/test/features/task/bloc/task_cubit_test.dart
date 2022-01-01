import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:learning_app/features/tasks/bloc/tasks_cubit.dart';
import 'package:learning_app/features/tasks/bloc/tasks_state.dart';
import 'package:learning_app/features/tasks/dtos/create_task_dto.dart';
import 'package:learning_app/features/tasks/dtos/update_task_dto.dart';
import 'package:learning_app/features/tasks/models/task.dart';
import 'package:learning_app/features/tasks/repositories/task_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockTaskRepository extends Mock implements TaskRepository {}

class AnyCreateTaskDto extends Mock implements CreateTaskDto {}

class AnyUpdateTaskDto extends Mock implements UpdateTaskDto {}

void main() {
  late MockTaskRepository mockTaskRepository;
  late TasksCubit taskCubit;

  Task mockTask = const Task(id: 1, title: 'Do something', done: false);
  CreateTaskDto mockCreateDto =
      CreateTaskDto(title: mockTask.title, done: mockTask.done);
  // UpdateTaskDto mockUpdateDto =
  //     UpdateTaskDto(title: mockTask.title, done: !mockTask.done);

  setUp(() {
    mockTaskRepository = MockTaskRepository();
    taskCubit = TasksCubit(taskRepository: mockTaskRepository);
  });

  setUpAll(() {
    registerFallbackValue(AnyCreateTaskDto());
    registerFallbackValue(AnyUpdateTaskDto());
  });

  group(
    'when calling fetchTasks',
    () {
      blocTest<TasksCubit, TaskState>(
        'CounterCubit should fetch all tasks and store the result',
        build: () {
          var mockResponse = Future.value([mockTask]);
          when(() => mockTaskRepository.loadTasks())
              .thenAnswer((_) => mockResponse);

          return taskCubit;
        },
        act: (cubit) async => await cubit.loadTasks(),
        expect: () => [
          TaskLoading(),
          TasksLoaded(tasks: [mockTask]),
        ],
        verify: (_) {
          verify(() => mockTaskRepository.loadTasks()).called(1);
        },
      );

      blocTest<TasksCubit, TaskState>(
        'CounterCubit should overwrite existing tasks in the state',
        build: () {
          var mockResponse = Future.value(<Task>[]);

          when(() => mockTaskRepository.loadTasks())
              .thenAnswer((_) => mockResponse);

          return taskCubit;
        },
        seed: () => TasksLoaded(tasks: [mockTask]),
        act: (cubit) async => await cubit.loadTasks(),
        expect: () => [
          TaskLoading(),
          TasksLoaded(tasks: const []),
        ],
      );
    },
  );

  group(
    'when calling createTask',
    () {
      blocTest<TasksCubit, TaskState>(
        'CounterCubit should create the task and store the result',
        build: () {
          when(() => mockTaskRepository.createTask(any()))
              .thenAnswer((_) => Future.value(mockTask));
          return taskCubit;
        },
        seed: () => TasksLoaded(tasks: const []),
        act: (cubit) async => await cubit.createTask(mockCreateDto),
        expect: () => [
          TasksLoaded(
            tasks: [mockTask],
          ),
        ],
        verify: (_) {
          verify(() => mockTaskRepository.createTask(mockCreateDto)).called(1);
        },
      );
    },
  );

  group(
    'when calling toggleDone',
    () {
      blocTest<TasksCubit, TaskState>(
        'CounterCubit should update the task and store the result',
        build: () {
          when(() => mockTaskRepository.toggleDone(mockTask.id))
              .thenAnswer((_) => Future.value(true));
          return taskCubit;
        },
        seed: () => TasksLoaded(tasks: [mockTask]),
        act: (cubit) async => await cubit.toggleDone(mockTask),
        expect: () => [
          TasksLoaded(
            tasks: [
              Task(id: mockTask.id, title: mockTask.title, done: !mockTask.done)
            ],
          ),
        ],
        verify: (_) {
          verify(() => mockTaskRepository.toggleDone(mockTask.id)).called(1);
        },
      );
    },
  );

  group(
    'when calling deleteTaskById',
    () {
      blocTest<TasksCubit, TaskState>(
        'CounterCubit delete the task and store the result',
        build: () {
          when(() => mockTaskRepository.deleteById(mockTask.id))
              .thenAnswer((_) => Future.value(true));
          return taskCubit;
        },
        seed: () => TasksLoaded(tasks: [mockTask]),
        act: (cubit) async => await cubit.deleteTaskById(mockTask.id),
        expect: () => [
          TasksLoaded(
            tasks: const [],
          ),
        ],
        verify: (_) {
          verify(() => mockTaskRepository.deleteById(mockTask.id)).called(1);
        },
      );
    },
  );
}
