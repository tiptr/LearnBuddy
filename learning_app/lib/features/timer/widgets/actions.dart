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
                heroTag: "TimerInitialPlayButton",
                child: const Icon(Icons.play_arrow),
                onPressed: () => context
                    .read<TimerBloc>()
                    //context.read calls Provider.of<>(context, listen: false) -> does not trigger rebuild
                    .add(TimerStarted(duration: state.getDuration())),
              ),
              FloatingActionButton(
                heroTag: "TimerInitialSkipButton",
                child: const Icon(Icons.skip_next),
                onPressed: () =>
                    context.read<TimerBloc>().add(const TimerSkip()),
              ),
            ],
            if (state is TimerRunInProgress) ...[
              FloatingActionButton(
                heroTag: "TimerInProgressPauseButton",
                child: const Icon(Icons.pause),
                onPressed: () =>
                    context.read<TimerBloc>().add(const TimerPaused()),
              ),
              FloatingActionButton(
                heroTag: "TimerInProgressSkipButton",
                child: const Icon(Icons.skip_next),
                onPressed: () =>
                    context.read<TimerBloc>().add(const TimerSkip()),
              ),
            ],
            if (state is TimerRunPause) ...[
              FloatingActionButton(
                heroTag: "TimerPausePlayButton",
                child: const Icon(Icons.play_arrow),
                onPressed: () =>
                    context.read<TimerBloc>().add(const TimerResumed()),
              ),
              FloatingActionButton(
                heroTag: "TimerPauseSkipButton",
                child: const Icon(Icons.skip_next),
                onPressed: () =>
                    context.read<TimerBloc>().add(const TimerSkip()),
              ),
            ],
            if (state is TimerRunComplete) ...[
              FloatingActionButton(
                heroTag: "TimerCompleteSkipButton",
                child: const Icon(Icons.skip_next),
                onPressed: () =>
                    context.read<TimerBloc>().add(const TimerSkip()),
              ),
            ],
            if (state is TimerInitialInSession) ...[
              FloatingActionButton(
                heroTag: "TimerInitialInSessionPlayButton",
                child: const Icon(Icons.play_arrow),
                onPressed: () => context
                    .read<TimerBloc>()
                    //context.read calls Provider.of<>(context, listen: false) -> does not trigger rebuild
                    .add(TimerStarted(duration: state.getDuration())),
              ),
              FloatingActionButton(
                heroTag: "TimerInitialInSessionSkipButton",
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
