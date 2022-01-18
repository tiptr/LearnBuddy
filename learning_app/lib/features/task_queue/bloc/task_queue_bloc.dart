import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:learning_app/features/task_queue/repositories/queue_repository.dart';
import 'package:learning_app/features/tasks/models/task_with_queue_status.dart';
import 'package:learning_app/features/tasks/repositories/task_repository.dart';
import 'package:learning_app/util/injection.dart';
import 'package:learning_app/util/logger.dart';

part 'task_queue_state.dart';

part 'task_queue_event.dart';

class TaskQueueBloc extends Bloc<TaskQueueEvent, TaskQueueState> {
  late final TaskRepository _taskRepository;
  late final QueueRepository _queueRepository;

  //late final StreamSubscription _streamSubscription;

  TaskQueueBloc(
      {QueueRepository? queueRepository, TaskRepository? taskRepository})
      : super(TaskQueueInit()) {
    _taskRepository = taskRepository ?? getIt<TaskRepository>();
    _queueRepository = queueRepository ?? getIt<QueueRepository>();

    Stream<List<TaskWithQueueStatus>> stream =
        _taskRepository.watchQueuedTasks();
    stream.listen((List<TaskWithQueueStatus> taskListFromStream) {
      add(UpdateQueueEvent(taskListFromStream));
    });

    on<UpdateQueueEvent>((event, emit) {
      var currentState = state;
      if (currentState is TaskQueueReady) {
        emit(TaskQueueReady(
          tasks: event.taskList,
          selectedTask: currentState.selectedTask,
        ));
      } else {
        logger.d("This state should not be accessible.");
      }
    });

    on<InitQueueEvent>((event, emit) async {
      emit(TaskQueueReady(tasks: await stream.first));
    });

    on<UpdateQueueOrderEvent>((event, emit) {
      var currentState = state;
      if (currentState is TaskQueueReady) {
        _queueRepository.writeQueueOrder(event.taskList);
      } else {
        logger.d("This state should not be accessible.");
      }
    });

    on<SelectQueuedTaskEvent>((event, emit) async {
      var currentState = state;
      if (currentState is TaskQueueReady) {
        emit(TaskQueueReady(
          tasks: currentState.tasks,
          selectedTask: event.selectedTaskId,
        ));
      } else {
        logger.d("This state should not be accessible.");
      }
    });

    on<RemoveFromQueueEvent>((event, emit) async {
      _queueRepository.toggleQueued(taskId: event.id, queued: false);
    });

    on<RemoveSelectedTaskEvent>((event, emit) async {
      var currentState = state;
      if (currentState is TaskQueueReady) {
        emit(TaskQueueReady(
          tasks: currentState.tasks,
        ));
      }
    });
  }
}
