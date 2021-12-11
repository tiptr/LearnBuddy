import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_app/features/timer/bloc/timer_bloc.dart';
import 'package:learning_app/features/timer/widgets/actions.dart'
    show TimerActions;
import 'package:learning_app/features/timer/widgets/background.dart'
    show Background;

class TimerScreen extends StatelessWidget {
  const TimerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TimerBloc(),
      child: const TimerView(),
    );
  }
}

class TimerView extends StatelessWidget {
  const TimerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
      return Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const <Widget>[
              PomodoroState(),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 100.0),
                child:  TimerWidget(),
              ),
              TimerActions(),
            ],
          ),
        ],
      );
  }
}

class TimerWidget extends StatelessWidget {
  const TimerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final duration =
    context.select((TimerBloc bloc) => bloc.state.getDuration());
    //select only rebuilds the Widget if the selected property changes: here duration.
    // If the TimerState changes, TimerText won't rebuild
    final minutesStr =
    ((duration / 60) % 60).floor().toString().padLeft(2, '0');
    final secondsStr = (duration % 60).floor().toString().padLeft(2, '0');
    final phaseDuration = context.select((TimerBloc bloc) =>
    bloc.state
        .getConfig()
        .getPomodoroMinuets()[bloc.state.getPomodoroMode()]);
    return SizedBox(
        width: 200,
        height: 200,
        child: Stack(
          fit: StackFit.expand,
          children: [
            CircularProgressIndicator(
              value: duration / phaseDuration,
            ),
            Center(
                child: Text(
                    '$minutesStr:$secondsStr',
                    style: Theme
                        .of(context)
                        .textTheme
                        .headline2
                )
            ),
          ],
        ));
  }
}

// Displays the Pomodoro State: in  {concentration, shortBreak, longBreak)
class PomodoroState extends StatelessWidget {
  const PomodoroState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String pomoState = context
        .select((TimerBloc bloc) => bloc.state.getPomodoroMode().toString());
    pomoState = pomoState.substring(13);
    String timerState =
    context.select((TimerBloc bloc) => bloc.state.toString());
    //timerState = timerState.substring(0,20);
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            pomoState,
            style: Theme
                .of(context)
                .textTheme
                .headline3,
          ),
          // This is just for Debugging
          Text(
            timerState,
            style: Theme
                .of(context)
                .textTheme
                .headline6,
          ),
        ]);
  }
}
