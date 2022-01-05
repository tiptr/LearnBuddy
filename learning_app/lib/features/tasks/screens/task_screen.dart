import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:learning_app/features/categories/models/category.dart';
import 'package:learning_app/features/categories/widgets/category_card.dart';
import 'package:learning_app/features/learning_aids/dtos/read_learn_list_dto.dart';
import 'package:learning_app/features/tasks/bloc/tasks_cubit.dart';
import 'package:learning_app/features/tasks/bloc/tasks_state.dart';
import 'package:learning_app/features/tasks/dtos/list_read_task_dto.dart';
import 'package:learning_app/features/tasks/screens/task_add_screen.dart';
import 'package:learning_app/features/tasks/widgets/task_card.dart';
import 'package:learning_app/util/formatting_comparison/date_time_extensions.dart';

class ListGroupSeparator extends StatelessWidget {
  final String _content;
  final bool _highlight;

  const ListGroupSeparator(
      {Key? key, required String content, required bool highlight})
      : _content = content,
        _highlight = highlight,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(
        _content,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 11,
          color: _highlight ? Colors.white : const Color(0xFF636573),
        ),
      ),
      backgroundColor:
          _highlight ? const Color(0xFF9E5EE1) : const Color(0xFFEAECFA),
    );
  }
}

class TaskScreen extends StatelessWidget {
  const TaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TasksCubit, TaskState>(
        builder: (context, state) {
          // This only checks for the success state, we might want to check for
          // errors in the future here.
          if (state is! TasksLoaded) {
            return const Center(child: CircularProgressIndicator());
          }
          // var _elements = List<ListReadTaskDto>.from(state.tasks);
          // _elements.add(const ListReadTaskDto(
          //   id: 99999,
          //   title: 'Aufgabe ohne Fälligkeit',
          //   done: true,
          //   categoryColor: Colors.tealAccent,
          //   subTaskCount: 2,
          //   finishedSubTaskCount: 1,
          //   isQueued: false,
          //   keywords: ['Hausaufgabe', 'Lernen'],
          //   dueDate: null,
          //   remainingTimeEstimation: Duration(hours: 70),
          // ));

          return StreamBuilder<List<ListReadTaskDto>>(
            stream: state.selectedTasksStream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              print('Snapshot has data: ${snapshot.hasData}');

              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(
                    child: Text(
                        'Du hast aktuell keine anstehenden Aufgaben.\nDrücke auf Plus, um eine Aufgabe anzulegen',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 11,
                          color: Color(0xFF636573),
                        )));
              }

              final activeTasks = snapshot.data!;

              return GroupedListView<ListReadTaskDto, DateTime?>(
                // controller: _scrollController,
                physics: const AlwaysScrollableScrollPhysics(),
                sort: false, // sorting will be done via SQL
                elements: activeTasks,
                // TODO: this has to be generalized to work with other groups than the due date
                groupBy: (task) => task.dueDate.getPreviousMidnight(),
                // groupComparator: (dueDate1, dueDate2) {
                //   // null is considered the smallest:
                //   return dueDate1.compareDayOnly(dueDate2);
                // },
                // Sorting of the actual items is handled directly by SQL.
                // Could be done here, otherwise
                // order: GroupedListOrder.ASC,
                useStickyGroupSeparators: true,
                cacheExtent: 20,
                // This would improve scrolling performance, but I did not get it to
                // work with the separators
                // itemExtent: 110,
                floatingHeader: true,
                groupSeparatorBuilder: (DateTime? dateTime) {
                  return ListGroupSeparator(
                    content: dateTime.toListViewFormat(),
                    highlight: dateTime.isInPast(),
                  );
                },
                indexedItemBuilder: (context, task, index) {
                  return TaskCard(task: task);
                },
              );
            },
          );

          // return GroupedListView<ListReadTaskDto, DateTime?>(
          //   // controller: _scrollController,
          //   physics: const AlwaysScrollableScrollPhysics(),
          //   elements: _elements,
          //   // TODO: this has to be generalized to work with other groups than the due date
          //   groupBy: (task) => task.dueDate.getPreviousMidnight(),
          //   groupComparator: (dueDate1, dueDate2) {
          //     // null is considered the smallest:
          //     return dueDate1.compareDayOnly(dueDate2);
          //   },
          //   // Sorting of the actual items is handled directly by SQL.
          //   // Could be done here, otherwise
          //   order: GroupedListOrder.ASC,
          //   useStickyGroupSeparators: true,
          //   cacheExtent: 20,
          //   // This would improve scrolling performance, but I did not get it to
          //   // work with the separators
          //   // itemExtent: 110,
          //   floatingHeader: true,
          //   groupSeparatorBuilder: (DateTime? dateTime) {
          //     return ListGroupSeparator(
          //       content: dateTime.toListViewFormat(),
          //       highlight: dateTime.isInPast(),
          //     );
          //   },
          //   indexedItemBuilder: (context, task, index) {
          //     return TaskCard(task: task);
          //   },
          // );
        },
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "NavigateToTaskAddScreen",
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const TaskAddScreen(),
          ),
        ),
        child: const Icon(Icons.add),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
