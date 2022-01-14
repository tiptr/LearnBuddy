import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_app/features/time_logs/bloc/time_logging_bloc.dart';
import 'package:learning_app/features/timer/bloc/timer_bloc.dart';
import 'package:learning_app/features/timer/models/pomodoro_mode.dart';
import 'package:learning_app/features/timer/widgets/actions.dart'
    show TimerActions;
import 'package:learning_app/features/timer/widgets/active_task.dart';
import 'package:learning_app/features/timer/widgets/test.dart';
import 'package:learning_app/features/timer/widgets/timer_sheet.dart';
import 'package:learning_app/features/timer/widgets/toggle_active_task.dart';
import 'package:learning_app/shared/widgets/base_layout.dart';
import 'package:learning_app/shared/widgets/base_title_bar.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class TimerScreen extends StatelessWidget {
  const TimerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          TimerBloc(timeLoggingBloc: context.read<TimeLoggingBloc>()),
      child: const BaseLayout(
        titleBar: BaseTitleBar(
          title: "Pomodoro Timer",
        ),
        content: TimerView(),
      ),
    );
  }
}

class TimerView extends StatefulWidget {
  const TimerView({Key? key}) : super(key: key);

  @override
  _TimerViewState createState() => _TimerViewState();
}

class _TimerViewState extends State<TimerView> {


  @override
  Widget build(BuildContext context) {
    return SlidingUpPanel(
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(18.0),
          topRight: Radius.circular(18.0),
      ),
      parallaxEnabled: true,
      parallaxOffset: .0,
      panelSnapping: true,
      minHeight: 20,
      maxHeight: 470,
      panelBuilder: (ScrollController sc) => TaskQueueList(sc),
      color: Colors.white,
      body: const Center(
        child: TimerBackGround(),
      ),
    );
    }
}


//Stack(
//children: <Widget>[
//const TimerBackGround(),
//TimerDraggableScrollableSheet(_tween, _controller),

class TimerBackGround extends StatelessWidget {
  const TimerBackGround({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: const <Widget>[
        ActiveTaskBar(),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 50.0),
          child: TimerWidget(),
        ),
        Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 70),
            child: PomodoroPhaseCountWidget()),
        TimerActions(),
        ToggleActiveTask(),
      ],
    );
  }
}


class PomodoroPhaseCountWidget extends StatelessWidget {
  const PomodoroPhaseCountWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentStep =
    context.select((TimerBloc bloc) => bloc.state.getCountPhase());
    final totalSteps = context
        .select((TimerBloc bloc) => bloc.state.getConfig().getPhaseCount());
    return StepProgressIndicator(
        totalSteps: totalSteps,
        currentStep: currentStep + 1,
        // index starts with 1 apparently :(
        selectedColor: Colors.blue,
        size: 30,
        padding: 10,
        customStep: (index, color, _) {
          return Container(
            width: 30.0,
            height: 30.0,
            decoration: BoxDecoration(
              color: color == Colors.blue ? Colors.blue : Colors.grey,
              shape: BoxShape.circle,
            ),
          );
        });
  }
}

class TimerWidget extends StatelessWidget {
  const TimerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int duration = context.select((TimerBloc bloc) => bloc.state.getDuration());
    // select only rebuilds the Widget if the selected property changes: here duration.
    // If the TimerState changes, TimerText won't rebuild (same as BlocProvider.of)
    final sign = duration.sign;
    duration = duration * sign; // Keep duration positive

    final minutesStr =
    ((duration / 60) % 60).floor().toString().padLeft(2, '0');
    final secondsStr = (duration % 60).floor().toString().padLeft(2, '0');
    final signStr = sign == -1 ? "- " : "";

    final phaseDuration = context.select((TimerBloc bloc) =>
    bloc.state
        .getConfig()
        .getPomodoroMinutes()[bloc.state.getPomodoroMode()]);

    final pomoState = getPomoStateText(context);

    bool showProgressBar =
    context.select((TimerBloc bloc) => bloc.state is! TimerRunComplete);

    return SizedBox(
      width: 200,
      height: 200,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Visibility(
            visible: showProgressBar,
            child: CircularProgressIndicator(
              value: duration / phaseDuration,
              strokeWidth: 15,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  pomoState,
                  style: Theme
                      .of(context)
                      .textTheme
                      .headline5,
                ),
              ),
              // This text should be in the middle of the circular progress bar
              Text('$signStr$minutesStr:$secondsStr',
                  style: Theme
                      .of(context)
                      .textTheme
                      .headline2),
            ],
          )
        ],
      ),
    );
  }

  String getPomoStateText(BuildContext context) {
    PomodoroMode pomoState =
    context.select((TimerBloc bloc) => bloc.state.getPomodoroMode());
    if (pomoState == PomodoroMode.concentration) return "Konzentration";
    if (pomoState == PomodoroMode.shortBreak) return "Kurze Pause";
    return "Lange Pause";
  }
}

// Displays the Pomodoro State: in  {concentration, shortBreak, longBreak)
class PomodoroState extends StatelessWidget {
  const PomodoroState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String timerState =
    context.select((TimerBloc bloc) => bloc.state.toString());
    //timerState = timerState.substring(0,20);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // This is just for Debugging
        Text(
          timerState,
          style: Theme
              .of(context)
              .textTheme
              .headline6,
        ),
      ],
    );
  }
}
