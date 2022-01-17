import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_app/features/time_logs/bloc/time_logging_bloc.dart';
import 'package:learning_app/features/timer/bloc/timer_bloc.dart';
import 'package:learning_app/features/timer/models/pomodoro_mode.dart';
import 'package:learning_app/features/timer/widgets/actions.dart'
    show TimerActions;
import 'package:learning_app/features/timer/widgets/active_task.dart';
import 'package:learning_app/features/timer/widgets/task_queue_list.dart';
import 'package:learning_app/shared/widgets/base_layout.dart';
import 'package:learning_app/shared/widgets/base_title_bar.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:learning_app/constants/theme_color_constants.dart';
import 'package:learning_app/constants/theme_font_constants.dart';

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
  final _panelController = PanelController();

  @override
  Widget build(BuildContext context) {
    return SlidingUpPanel(
      controller: _panelController,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(18.0),
        topRight: Radius.circular(18.0),
      ),
      parallaxEnabled: true,
      parallaxOffset: .0,
      panelSnapping: true,
      minHeight: 145,
      maxHeight: MediaQuery.of(context).size.height * 0.61,
      panelBuilder: (ScrollController sc) {
        return TaskQueueList(
          scrollController: sc,
          panelController: _panelController,
        );
      },
      color: Theme.of(context).colorScheme.cardColor,
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
          padding: EdgeInsets.symmetric(vertical: 20.0),
          child: TimerWidget(),
        ),
        Padding(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 70),
            child: PomodoroPhaseCountWidget()),
        TimerActions(),
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
    final completedSessionColor = Theme.of(context).colorScheme.tertiary;
    final unCompletedSessionColor =
        Theme.of(context).colorScheme.onBackgroundSoft;
    return StepProgressIndicator(
        totalSteps: totalSteps,
        currentStep: currentStep + 1,
        // index starts with 1 apparently :(
        selectedColor: completedSessionColor,
        size: 30,
        padding: 5,
        customStep: (index, color, _) {
          return Container(
            width: 30.0,
            height: 30.0,
            decoration: BoxDecoration(
              color: color == completedSessionColor
                  ? completedSessionColor
                  : unCompletedSessionColor,
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

    final phaseDuration = context.select((TimerBloc bloc) => bloc.state
        .getConfig()
        .getPomodoroMinutes()[bloc.state.getPomodoroMode()]);

    final pomoState = getPomoStateText(context);

    bool showProgressBar =
        context.select((TimerBloc bloc) => bloc.state is! TimerRunComplete);

    return SizedBox(
      width: 180,
      height: 180,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Visibility(
            visible: showProgressBar,
            child: CircularProgressIndicator(
              value: duration / phaseDuration,
              strokeWidth: 15,
              color: Theme.of(context).colorScheme.tertiary,
              backgroundColor:
                  Theme.of(context).colorScheme.subtleBackgroundGrey,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  pomoState,
                  style: Theme.of(context)
                      .textTheme
                      .textStyle1
                      .withOnBackgroundHard
                      .withBold,
                ),
              ),
              // This text should be in the middle of the circular progress bar
              Text('$signStr$minutesStr:$secondsStr',
                  style: Theme.of(context).textTheme.pomodoroTimeDisplayStyle,
              ),
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
          style: Theme.of(context).textTheme.headline6,
        ),
      ],
    );
  }
}
