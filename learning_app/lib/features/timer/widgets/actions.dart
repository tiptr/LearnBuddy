import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/timer_bloc.dart';

class TimerActions extends StatelessWidget {
  const TimerActions({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimerBloc, TimerState>(
      buildWhen: (prev, state) => prev.runtimeType != state.runtimeType,
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            if (state is TimerInitial) ...[
              FloatingActionButton(
                child: const Icon(Icons.play_arrow),
                onPressed: () => context
                    .read<TimerBloc>()
                    //context.read calls Provider.of<>(context, listen: false) -> does not trigger rebuild
                    .add(TimerStarted(duration: state.getDuration())),
              ),
            ],
            if (state is TimerRunInProgress) ...[
              FloatingActionButton(
                child: const Icon(Icons.pause),
                onPressed: () =>
                    context.read<TimerBloc>().add(const TimerPaused()),
              ),
              FloatingActionButton(
                child: const Icon(Icons.skip_next),
                onPressed: () =>
                    context.read<TimerBloc>().add(const TimerSkip()),
              ),
            ],
            if (state is TimerRunPause) ...[
              FloatingActionButton(
                child: const Icon(Icons.play_arrow),
                onPressed: () =>
                    context.read<TimerBloc>().add(const TimerResumed()),
              ),
              FloatingActionButton(
                child: const Icon(Icons.skip_next),
                onPressed: () =>
                    context.read<TimerBloc>().add(const TimerSkip()),
              ),
            ],
            if (state is TimerRunComplete) ...[
              FloatingActionButton(
                child: const Icon(Icons.skip_next),
                onPressed: () =>
                    context.read<TimerBloc>().add(const TimerSkip()),
              ),
            ],
            if (state is TimerInitialInSession) ...[
              FloatingActionButton(
                child: const Icon(Icons.play_arrow),
                onPressed: () => context
                    .read<TimerBloc>()
                    //context.read calls Provider.of<>(context, listen: false) -> does not trigger rebuild
                    .add(TimerStarted(duration: state.getDuration())),
              ),
              FloatingActionButton(
                child: const Icon(Icons.skip_next),
                onPressed: () =>
                    context.read<TimerBloc>().add(const TimerSkip()),
              ),
            ]
          ],
        );
      },
    );
  }
}
