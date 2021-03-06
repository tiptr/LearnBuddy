import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:learning_app/features/tasks/bloc/tasks_cubit.dart';
import 'package:learning_app/features/tasks/bloc/tasks_state.dart';
import 'package:learning_app/features/tasks/dtos/list_read_task_dto.dart';
import 'package:learning_app/features/tasks/filter_and_sorting/tasks_filter.dart';
import 'package:learning_app/features/tasks/screens/task_details_screen.dart';
import 'package:learning_app/features/tasks/widgets/filter_select_dialog.dart';
import 'package:learning_app/features/tasks/widgets/list_group_separator.dart';
import 'package:learning_app/features/tasks/widgets/task_card.dart';
import 'package:learning_app/features/tasks/widgets/task_filter_indicator.dart';
import 'package:learning_app/shared/widgets/base_title_bar.dart';
import 'package:learning_app/shared/widgets/three_points_menu.dart';
import 'package:learning_app/util/formatting_comparison/date_time_extensions.dart';
import 'package:learning_app/constants/theme_font_constants.dart';
import 'package:drift/drift.dart' as drift;

class TaskScreen extends StatefulWidget {
  const TaskScreen({Key? key}) : super(key: key);

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksCubit, TaskState>(builder: (context, state) {
      // This only checks for the success state, we might want to check for
      // errors in the future here.
      if (state is! TasksLoaded) {
        return const Center(child: CircularProgressIndicator());
      }

      final TaskFilter currentFilter = state.taskFilter ?? const TaskFilter();
      final bool isFiltered =
          BlocProvider.of<TasksCubit>(context).isFilterActive();

      final showingDoneTasks =
          currentFilter.done.present ? currentFilter.done.value : false;

      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        // Will change to a custom title bar in the future
        appBar: BaseTitleBar(
          title: "Aufgaben",
          actions: [
            // Filters:
            IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const FilterSelectDialog();
                  },
                );
              },
              icon: const Icon(Icons.filter_list_outlined),
            ),
            // Done tasks
            IconButton(
                onPressed: () {
                  final newFilter = TaskFilter(
                    keywords: currentFilter.keywords,
                    categories: currentFilter.categories,
                    dueToday: currentFilter.dueToday,
                    done: drift.Value(!currentFilter.done.value),
                    categoryNames: currentFilter.categoryNames,
                    keywordNames: currentFilter.keywordNames,
                  );

                  BlocProvider.of<TasksCubit>(context)
                      .loadFilteredTasks(newFilter);
                },
                icon: Icon(showingDoneTasks
                    ? Icons.done_all_outlined
                    : Icons.remove_done_outlined)),
            // Three points menu
            buildThreePointsMenu(
              context: context,
              showCategoryManagement: true,
              showKeyWordsManagement: true,
              showGlobalSettings: true,
            ),
          ],
        ),
        body: StreamBuilder<List<ListReadTaskDto>>(
          stream: state.selectedListViewTasksStream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(
                child: Text(
                  'Du hast aktuell keine anstehenden Aufgaben.\nDr??cke auf das Plus, um eine Aufgabe anzulegen',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.textStyle4,
                ),
              );
            }

            final activeTasks = snapshot.data!;

            return Column(
              children: [
                // Filter info and reset button, if some filters set
                if (isFiltered) TaskFilterIndicator(taskFilter: currentFilter),

                // Task List
                Flexible(
                  child: Scrollbar(
                    controller: _scrollController,
                    interactive: true,
                    child: GroupedListView<ListReadTaskDto, DateTime?>(
                      controller: _scrollController,
                      physics: const AlwaysScrollableScrollPhysics(),
                      sort: false,
                      // sorting will be done via SQL
                      elements: activeTasks,
                      // TODO: this has to be generalized to work with other groups than the due date, when a different sorting is applied
                      groupBy: (task) =>
                          task.dueDate.getBeginOfDayConcatPastToYesterday(),
                      useStickyGroupSeparators: true,
                      cacheExtent: 20,
                      // This would improve scrolling performance, but I did not get it to
                      // work with the separators
                      // itemExtent: 110,
                      floatingHeader: true,
                      groupSeparatorBuilder: (DateTime? dateTime) {
                        return ListGroupSeparator(
                          content: dateTime == null
                              ? 'Ohne F??lligkeitsdatum'
                              : (dateTime.isInPast()
                                  ? '??berf??llig'
                                  : '${dateTime.formatDependingOnCurrentDate()} f??llig'),
                          highlight: dateTime.isInPast(),
                        );
                      },
                      indexedItemBuilder: (context, task, index) {
                        return TaskCard(task: task, context: context);
                      },
                    ),
                  ),
                ),
              ],
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          heroTag: "NavigateToTaskAddScreen",
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const TaskDetailsScreen(),
            ),
          ),
          child: Icon(
            Icons.add,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
      );
    });
  }
}
