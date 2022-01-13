import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_app/features/task_queue/bloc/task_queue_bloc.dart';
import 'package:learning_app/features/timer/widgets/task_queue_list_tile.dart';

class TimerDraggableScrollableSheet extends StatelessWidget {
  final Tween<Offset> _tween;
  final AnimationController _controller;

  const TimerDraggableScrollableSheet(this._tween, this._controller, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: SlideTransition(
        position: _tween.animate(_controller),
        child: DraggableScrollableSheet(
          maxChildSize: 0.7,
          snap: true,
          builder: (BuildContext context, ScrollController scrollController) {
            return Padding(
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
                //top: 10,
              ),
              child: Container(

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.7),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: BlocBuilder<TaskQueueBloc, TaskQueueState>(
                    builder: (context, state) {
                  if (state is TaskQueueReady) {
                    return ListView.builder(
                      controller: scrollController,
                      itemCount: state.tasks.length,
                      itemBuilder: (BuildContext context, int index) {
                        return TaskQueueListTile(
                            topLevelTaskWithQueueStatus: state.tasks[index]);
                      },
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                }),
              ),
            );
          },
        ),
      ),
    );
  }
}
