
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:learning_app/features/tasks/bloc/task_cubit.dart';
import 'package:learning_app/services/time_logging/bloc/time_logging_bloc.dart';
import 'package:provider/src/provider.dart';

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
      icon: _active? const Icon(Icons.toggle_on): const Icon(Icons.toggle_off),
      onPressed: (){
        _toggle();
        if(_active){
          context.read<TimeLoggingBloc>().add(const AddTimeLoggingObjectEvent(2));
        }
        else {
          context.read<TimeLoggingBloc>().add(const RemoveTimeLoggingObjectEvent());
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

