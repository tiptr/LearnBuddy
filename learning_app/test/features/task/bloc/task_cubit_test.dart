import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:learning_app/features/tasks/bloc/tasks_cubit.dart';
import 'package:learning_app/features/tasks/bloc/tasks_state.dart';
import 'package:learning_app/features/tasks/dtos/create_task_dto.dart';
import 'package:learning_app/features/tasks/dtos/list_read_task_dto.dart';
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

  final now = DateTime.now();
  final dueDate = DateTime(2022, 01, 02, 14, 00);

  final mockTask = Task(
      id: 1,
      title: 'A task-title',
      done: false,
      description: 'A description of the task',
      estimatedTime: const Duration(minutes: 30),
      dueDate: dueDate,
      creationDateTime: now,
      parentTask: null,
      manualTimeEffortDelta: null);

  final mockListReadDto = ListReadTaskDto(
    id: mockTask.id,
    title: mockTask.title,
    done: mockTask.done,
    categoryColor: Colors.grey,
    keywords: const ['Hausaufgabe', 'Lernen'],
    // TODO: implement
    remainingTimeEstimation: mockTask.estimatedTime,
    dueDate: mockTask.dueDate,
    subTaskCount: 0,
    finishedSubTaskCount: 0,
  );

  // TODO: implement new create test
  // CreateTaskDto mockCreateDto = CreateTaskDto(
  //   title: mockTask.title,
  //   description: mockTask.description,
  //   estimatedTime: mockTask.estimatedTime,
  //   dueDate: mockTask.dueDate,
  // );

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
        'TasksCubit should fetch all tasks and store the result',
        build: () {
          var mockResponse = Future.value([mockListReadDto]);
          when(() => mockTaskRepository.loadTasks())
              .thenAnswer((_) => mockResponse);

          return taskCubit;
        },
        act: (cubit) async => await cubit.loadTasks(),
        expect: () => [
          TaskLoading(),
          TasksLoaded(tasks: [mockListReadDto]),
        ],
        verify: (_) {
          verify(() => mockTaskRepository.loadTasks()).called(1);
        },
      );

      blocTest<TasksCubit, TaskState>(
        'TasksCubit should overwrite existing tasks in the state',
        build: () {
          var mockResponse = Future.value(<ListReadTaskDto>[]);

          when(() => mockTaskRepository.loadTasks())
              .thenAnswer((_) => mockResponse);

          return taskCubit;
        },
        seed: () => TasksLoaded(tasks: [mockListReadDto]),
        act: (cubit) async => await cubit.loadTasks(),
        expect: () => [
          TaskLoading(),
          TasksLoaded(tasks: const []),
        ],
      );
    },
  );

  // TODO: This functionality was moved to a new, specific BLoC (AddTaskCubit)
  // TODO: The tests have to be restructured (How to test multiple Cubits in one test?)
  // TODO: This was outsourced to a new issue: https://github.com/tiptr/SoftwareEngineering-WS2022-Unicorns/projects/1#card-75475787
  // group(
  //   'when calling createTask',
  //   () {
  //     blocTest<TasksCubit, TaskState>(
  //       'TasksCubit should create the task and store the result',
  //       build: () {
  //         when(() => mockTaskRepository.createTask(any()))
  //             .thenAnswer((_) => Future.value(mockTask.id));
  //         return taskCubit;
  //       },
  //       seed: () => TasksLoaded(tasks: const []),
  //       act: (cubit) async => await cubit.createTask(mockCreateDto),
  //       expect: () => [
  //         TasksLoaded(
  //           tasks: [mockListReadDto],
  //         ),
  //       ],
  //       verify: (_) {
  //         verify(() => mockTaskRepository.createTask(mockCreateDto)).called(1);
  //       },
  //     );
  //   },
  // );

  group(
    'when calling toggleDone',
    () {
      blocTest<TasksCubit, TaskState>(
        'TasksCubit should update the task and store the result',
        build: () {
          when(() => mockTaskRepository.toggleDone(mockTask.id))
              .thenAnswer((_) => Future.value(true));
          return taskCubit;
        },
        seed: () => TasksLoaded(tasks: [mockListReadDto]),
        act: (cubit) async => await cubit.toggleDone(mockTask.id),
        expect: () => [
          TasksLoaded(
            tasks: [
              ListReadTaskDto(
                id: mockTask.id,
                title: mockTask.title,
                done: !mockTask.done,
                categoryColor: Colors.grey,
                keywords: const ['Hausaufgabe', 'Lernen'],
                // TODO: implement
                remainingTimeEstimation: mockTask.estimatedTime,
                dueDate: mockTask.dueDate,
                subTaskCount: 0,
                finishedSubTaskCount: 0,
              )
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
        'TasksCubit delete the task and store the result',
        build: () {
          var mockResponse = Future.value(<ListReadTaskDto>[]);
          when(() => mockTaskRepository.loadTasks())
              .thenAnswer((_) => mockResponse);

          when(() => mockTaskRepository.deleteById(mockTask.id))
              .thenAnswer((_) => Future.value(true));
          return taskCubit;
        },
        seed: () => TasksLoaded(tasks: [mockListReadDto]),
        act: (cubit) async => await cubit.deleteTaskById(mockTask.id),
        expect: () => [
          TaskLoading(),
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
