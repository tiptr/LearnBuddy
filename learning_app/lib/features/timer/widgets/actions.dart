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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (state is TimerInitial) ...[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () => context
                      .read<TimerBloc>()
                      //context.read calls Provider.of<>(context, listen: false) -> does not trigger rebuild
                      .add(TimerStarted(duration: state.getDuration())),
                  child: Container(
                    width: 100,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Center(
                        child: Text(
                          "Start",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    decoration: const BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () => context.read<TimerBloc>().add(const TimerSkip()),
                  child: Container(
                    width: 100,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Center(
                        child: Text(
                          "Überspringen",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    decoration: const BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                  ),
                ),
              ),
            ],
            if (state is TimerRunInProgress) ...[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () =>
                      context.read<TimerBloc>().add(const TimerPaused()),
                  child: Container(
                    width: 100,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Center(
                        child: Text(
                          "Pause",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    decoration: const BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () => context.read<TimerBloc>().add(const TimerSkip()),
                  child: Container(
                    width: 100,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Center(
                        child: Text(
                          "Überspringen",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    decoration: const BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                  ),
                ),
              ),
            ],
            if (state is TimerRunPause) ...[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () =>
                      context.read<TimerBloc>().add(const TimerResumed()),
                  child: Container(
                    width: 100,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Center(
                        child: Text(
                          "Fortsetzen",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    decoration: const BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () => context.read<TimerBloc>().add(const TimerSkip()),
                  child: Container(
                    width: 100,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Center(
                        child: Text(
                          "Überspringen",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    decoration: const BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                  ),
                ),
              ),
            ],
            if (state is TimerRunComplete) ...[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () => context.read<TimerBloc>().add(const TimerSkip()),
                  child: Container(
                    width: 100,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Center(
                        child: Text(
                          "Phase beenden",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    decoration: const BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                  ),
                ),
              ),
            ],
            if (state is TimerInitialInSession) ...[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () => context
                      .read<TimerBloc>()
                      //context.read calls Provider.of<>(context, listen: false) -> does not trigger rebuild
                      .add(TimerStarted(duration: state.getDuration())),
                  child: Container(
                    width: 100,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Center(
                        child: Text(
                          "Start",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    decoration: const BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () => context.read<TimerBloc>().add(const TimerSkip()),
                  child: Container(
                    width: 100,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Center(
                        child: Text(
                          "Überspringen",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    decoration: const BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                  ),
                ),
              ),
            ]
          ],
        );
      },
    );
  }
}
