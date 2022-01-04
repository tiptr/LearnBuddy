import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:learning_app/services/time_logging/bloc/time_logging_bloc.dart';
import 'package:learning_app/services/time_logging/repository/time_logging_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockTimeLoggingRepository extends Mock implements TimeLoggingRepository {}



/*
void main() {
  late MockTimeLoggingRepository repo;
  late TimeLoggingBloc bloc;

  setUp(() {
    repo = MockTimeLoggingRepository();
    bloc = TimeLoggingBloc();
  });



  group(
    'when calling fetchTasks',
    () {
      blocTest<TimeLoggingBloc, TimeLoggingBloc>(
        'CounterCubit should fetch all tasks and store the result',
        build: () {
          var mockResponse = Future.value([mockTask]);
          when(() => repo.)
              .thenAnswer((_) => mockResponse);

          return bloc;
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

      blocTest<TaskCubit, TaskState>(
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
      blocTest<TaskCubit, TaskState>(
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
      blocTest<TaskCubit, TaskState>(
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
      blocTest<TaskCubit, TaskState>(
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
}*/
