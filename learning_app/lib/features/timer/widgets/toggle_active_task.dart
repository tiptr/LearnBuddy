import 'package:flutter/material.dart';
import 'package:learning_app/features/time_logs/bloc/time_logging_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ToggleActiveTask extends StatefulWidget {
  const ToggleActiveTask({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ToggleActiveTaskState();
}

class _ToggleActiveTaskState extends State<ToggleActiveTask> {
  bool _active = false;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: _active
          ? Icon(
              Icons.toggle_on,
              color: Theme.of(context).colorScheme.onBackground,
            )
          : Icon(Icons.toggle_off,
              color: Theme.of(context).colorScheme.onBackground),
      onPressed: () {
        _toggle();
        if (_active) {
          context
              .read<TimeLoggingBloc>()
              .add(const AddTimeLoggingObjectEvent(2, 2));
        } else {
          context
              .read<TimeLoggingBloc>()
              .add(const RemoveTimeLoggingObjectEvent());
        }
      },
    );
  }

  void _toggle() {
    setState(() {
      _active = !_active;
    });
  }
}
