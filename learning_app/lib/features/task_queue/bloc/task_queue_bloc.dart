import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:learning_app/features/task_queue/repositories/queue_repository.dart';
import 'package:learning_app/features/tasks/models/task_with_queue_status.dart';
import 'package:learning_app/features/tasks/repositories/task_repository.dart';
import 'package:learning_app/util/injection.dart';

part 'task_queue_state.dart';

part 'task_queue_event.dart';

class TaskQueueBloc extends Bloc<TaskQueueEvent, TaskQueueState> {
  late final TaskRepository _taskRepository;
  late final QueueRepository _queueRepository;

  //late final StreamSubscription _streamSubscription;

  TaskQueueBloc({QueueRepository? queueRepository, TaskRepository? taskRepository}) : super(TaskQueueState()) {
    _taskRepository = taskRepository ?? getIt<TaskRepository>();
    _queueRepository = queueRepository ?? getIt<QueueRepository>();

    Stream<List<TaskWithQueueStatus>> stream =
        _taskRepository.watchQueuedTasks();
    stream.listen((List<TaskWithQueueStatus> event) {
      add(InitQueueEvent(event));
    });

    on<InitQueueEvent>((event, emit) {
      emit(TaskQueueState(tasks:  event.taskList));
    });

    on<UpdateQueueOrderEvent>((event, emit) {
      _queueRepository.writeQueueOrder(event.taskList);
    });
  }
}

