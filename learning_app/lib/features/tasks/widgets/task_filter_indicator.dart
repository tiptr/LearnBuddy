import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_app/constants/theme_font_constants.dart';
import 'package:learning_app/features/tasks/bloc/tasks_cubit.dart';
import 'package:learning_app/features/tasks/filter_and_sorting/tasks_filter.dart';

class TaskFilterIndicator extends StatelessWidget {
  final TaskFilter taskFilter;

  const TaskFilterIndicator({
    Key? key,
    required this.taskFilter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 20.0,
        right: 20.0,
        bottom: 20.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Aktive Filter:',
                  style: Theme.of(context).textTheme.textStyle3.withBold,
                ),
                if (taskFilter.dueToday.present &&
                    taskFilter.dueToday.value == true)
                  Text(
                    'Heute fällig',
                    style: Theme.of(context).textTheme.textStyle3.withBold,
                  ),
                if (taskFilter.done.present && taskFilter.done.value == true)
                  Text(
                    'Erledigte Aufgaben',
                    style: Theme.of(context).textTheme.textStyle3.withBold,
                  ),
                for (String category in taskFilter.categoryNames)
                  Text(
                    'Kategorie: $category',
                    style: Theme.of(context).textTheme.textStyle3.withBold,
                  ),
                for (String keyword in taskFilter.keywordNames)
                  Text(
                    'Schlagwort: $keyword',
                    style: Theme.of(context).textTheme.textStyle3.withBold,
                  ),
              ],
            ),
          ),
          // Reset button
          InkWell(
            onTap: () async {
              BlocProvider.of<TasksCubit>(context).loadTasksWithoutFilter();
            },
            child: Ink(
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Aufheben",
                      style: Theme.of(context).textTheme.textStyle4.withPrimary,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Icon(Icons.close,
                        size: 25.0,
                        color: Theme.of(context).colorScheme.primary),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
