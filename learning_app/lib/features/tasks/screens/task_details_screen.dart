import 'dart:async';
import 'package:learning_app/constants/theme_font_constants.dart';
import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_app/features/keywords/bloc/keywords_cubit.dart';
import 'package:learning_app/features/keywords/bloc/keywords_state.dart';
import 'package:learning_app/features/keywords/dtos/read_key_word_dto.dart';
import 'package:learning_app/features/categories/bloc/categories_cubit.dart';
import 'package:learning_app/features/categories/bloc/categories_state.dart';
import 'package:learning_app/features/categories/dtos/read_category_dto.dart';
import 'package:learning_app/features/tasks/bloc/alter_task_cubit.dart';
import 'package:learning_app/features/tasks/bloc/tasks_cubit.dart';
import 'package:learning_app/features/tasks/dtos/details_read_task_dto.dart';
import 'package:learning_app/features/tasks/dtos/task_manipulation_dto.dart';
import 'package:learning_app/features/tasks/widgets/category_select_field.dart';
import 'package:learning_app/features/tasks/widgets/date_input_field.dart';
import 'package:learning_app/features/tasks/widgets/duration_input_field.dart';
import 'package:learning_app/features/tasks/widgets/keyword_selection.dart';
import 'package:learning_app/features/tasks/widgets/sub_tasks_list.dart';
import 'package:learning_app/features/tasks/widgets/task_details_app_bar.dart';
import 'package:learning_app/features/tasks/widgets/text_input_field.dart';
import 'package:learning_app/util/logger.dart';

final DateTime? preSelectedDueDate = DateTime.now();
const Duration? preSelectedTimeEstimate = null;
const String preSelectedDescription = '';
const List<DetailsReadTaskDto> preSelectedSubtasks = [];

class TaskDetailsScreen extends StatelessWidget {
  final int? existingTaskId;
  final int? directParentId;
  final int? topLevelParentId;
  final bool directlyStartSubtaskCreation;

  /// If nothing is provided, the screen is used to create a new top level task.
  /// If a directParentId is provided, a new sub-task will be created for
  /// that parent and the topLevelParentId is also required to fetch all required
  /// data.
  /// If existingTaskId is provided, that task will be opened for editing. Then,
  /// also the top level parent id is required.
  const TaskDetailsScreen({
    Key? key,
    this.existingTaskId,
    this.directParentId, // if null -> top level task
    this.topLevelParentId, // required, if any of the others is set
    this.directlyStartSubtaskCreation = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AlterTaskCubit>(
      lazy: true,
      create: (context) {
        return AlterTaskCubit();
      },
      child: TaskDetailsScreenMainElement(
        existingTaskId: existingTaskId,
        parentId: directParentId,
        topLevelParentId: topLevelParentId,
        directlyStartSubtaskCreation: directlyStartSubtaskCreation,
      ),
    );
  }
}

/// This screen is used for both creating and editing tasks
///
/// To use this as create-screen, no existingTask is to be passed.
class TaskDetailsScreenMainElement extends StatefulWidget {
  final int? existingTaskId;
  final int? parentId;
  final int? topLevelParentId;
  final bool directlyStartSubtaskCreation;

  const TaskDetailsScreenMainElement({
    Key? key,
    required this.existingTaskId,
    required this.parentId, // if null -> top level task
    required this.topLevelParentId, // required, if any of the others is set
    required this.directlyStartSubtaskCreation,
  }) : super(key: key);

  @override
  State<TaskDetailsScreenMainElement> createState() =>
      _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreenMainElement> {
  final ScrollController _scrollController = ScrollController();

  Stream<DetailsReadTaskDto?>? _existingTaskStream;
  Stream<DetailsReadTaskDto?>? _parentTaskStream;

  @override
  void initState() {
    super.initState();

    // Load the stream and introduce a listener, if opened for editing a task
    if (widget.existingTaskId != null && widget.topLevelParentId != null) {
      int id = widget.existingTaskId as int;
      int topLevelId = widget.topLevelParentId as int;

      // Load the detail-dto stream for the selected card:
      _existingTaskStream = BlocProvider.of<TasksCubit>(context)
          .getDetailsDtoStreamById(id, topLevelId);

      // Screen is used to update an existing task
      BlocProvider.of<AlterTaskCubit>(context).startAlteringExistingTask(id);
    } else {
      // If a parent id is provided, watch it.
      if (widget.parentId != null && widget.topLevelParentId != null) {
        int id = widget.parentId as int;
        int topLevelId = widget.topLevelParentId as int;

        // Load the detail-dto stream for the parent task:
        _parentTaskStream = BlocProvider.of<TasksCubit>(context)
            .getDetailsDtoStreamById(id, topLevelId);
      }

      // Screen is used to create a new task
      BlocProvider.of<AlterTaskCubit>(context)
          .startNewTaskConstruction(widget.parentId);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_existingTaskStream == null) {
      // Create a new task

      // Set initial dueDate:
      BlocProvider.of<AlterTaskCubit>(context)
          .alterTaskAttribute(TaskManipulationDto(
        dueDate: drift.Value(preSelectedDueDate),
      ));

      if (_parentTaskStream == null) {
        // New top level task
        return _buildTaskDetailsScreen();
      } else {
        // New sub task
        return StreamBuilder<DetailsReadTaskDto?>(
            stream: _parentTaskStream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (!snapshot.hasData) {
                return _buildTaskDetailsScreen();
              }

              return _buildTaskDetailsScreen(parentDetailsDto: snapshot.data);
            });
      }
    } else {
      // Open an existing task
      return StreamBuilder<DetailsReadTaskDto?>(
          stream: _existingTaskStream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (!snapshot.hasData) {
              return _buildTaskDetailsScreen();
            }

            return _buildTaskDetailsScreen(detailsDto: snapshot.data);
          });
    }
  }

  /// Builds the actual details screen
  /// If the detailsDto is not provided, the parentDetailsDto is used
  /// to get information about the parent task(s) -> title, category...
  /// If neither is provided, the screen will be used to create a new top-level
  /// task
  Widget _buildTaskDetailsScreen({
    DetailsReadTaskDto? detailsDto,
    DetailsReadTaskDto? parentDetailsDto,
  }) {
    return Scaffold(
      appBar: TaskAddAppBar(
        existingTask: detailsDto,
        onSaveTask: onSaveTask,
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Scrollbar(
        interactive: true,
        controller: _scrollController,
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Container(
            margin: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                // Category Select
                BlocBuilder<CategoriesCubit, CategoriesState>(
                    builder: (context, state) {
                  if (state is! CategoriesLoaded) {
                    return const CircularProgressIndicator();
                  }

                  return StreamBuilder<List<ReadCategoryDto>>(
                    stream: state.categoriesStream,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      return CategorySelectField(
                        onSelect: (int? categoryId) {
                          BlocProvider.of<AlterTaskCubit>(context)
                              .alterTaskAttribute(
                            TaskManipulationDto(
                              categoryId: drift.Value(categoryId),
                            ),
                          );
                        },
                        options: snapshot.data!,
                        preselectedCategoryId: detailsDto?.category?.id,
                      );
                    },
                  );
                }),
                const SizedBox(height: 20.0),

                // Keywords Selection
                BlocBuilder<KeyWordsCubit, KeyWordsState>(
                  builder: (context, state) {
                    // This only checks for the success state, we might want to check for
                    // errors in the future here.
                    if (state is! KeyWordsLoaded) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    return StreamBuilder<List<ReadKeyWordDto>>(
                      stream: state.keywordsStream,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }

                        final keywords = snapshot.data!;

                        return KeywordSelection(
                          onSelect: (List<ReadKeyWordDto> keywords) {
                            var keywordIds = keywords.map((e) => e.id).toList();

                            BlocProvider.of<AlterTaskCubit>(context)
                                .alterTaskAttribute(
                              TaskManipulationDto(
                                keywordIds: drift.Value(keywordIds),
                              ),
                            );
                          },
                          options: keywords,
                          selectedKeywords: detailsDto?.keywords.toList() ?? [],
                        );
                      },
                    );
                  },
                ),
                const SizedBox(height: 20.0),

                // Date Select
                DateInputField(
                  preselectedDate: detailsDto != null
                      ? detailsDto.dueDate
                      : preSelectedDueDate,
                  onChange: (DateTime? datetime) {
                    BlocProvider.of<AlterTaskCubit>(context)
                        .alterTaskAttribute(TaskManipulationDto(
                      dueDate: drift.Value(datetime),
                    ));
                  },
                ),

                const SizedBox(height: 20.0),
                // Duration Select
                DurationInputField(
                  preselectedDuration: detailsDto != null
                      ? detailsDto.estimatedTime
                      : preSelectedTimeEstimate,
                  onChange: (Duration? duration) {
                    BlocProvider.of<AlterTaskCubit>(context)
                        .alterTaskAttribute(TaskManipulationDto(
                      estimatedTime: drift.Value(duration),
                    ));
                  },
                ),
                const SizedBox(height: 20.0),

                // Description Select
                TextInputField(
                  label: "Beschreibung",
                  hintText: "Text eingeben",
                  iconData: Icons.description_outlined,
                  onChange: (text) async {
                    BlocProvider.of<AlterTaskCubit>(context)
                        .alterTaskAttribute(TaskManipulationDto(
                      description: drift.Value(text),
                    ));
                  },
                  preselectedText: detailsDto != null
                      ? (detailsDto.description ?? '')
                      : preSelectedDescription,
                ),

                // Subtasks
                const SizedBox(height: 20.0),
                Row(
                  children: [
                    Text(
                      "Unteraufgaben",
                      style: Theme.of(context).textTheme.textStyle1,
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                // Subtasks list or shortcut button
                detailsDto != null
                    ? SubTasksList(
                        subTasksList: detailsDto.children,
                        directlyStartSubtaskCreation:
                            widget.directlyStartSubtaskCreation)
                    : InkWell(
                        onTap: () async {
                          int? savedTaskId = await onSaveTask();

                          if (savedTaskId != null) {
                            int id = savedTaskId;
                            // Enter the task editing mode:
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TaskDetailsScreen(
                                  existingTaskId: id,
                                  topLevelParentId:
                                      id, // Subtasks are not created this way
                                  directlyStartSubtaskCreation: true,
                                ),
                              ),
                            );
                          }
                        },
                        child: Ink(
                          height: 50,
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.add,
                                    size: 30.0,
                                    color:
                                        Theme.of(context).colorScheme.primary),
                                Text(
                                  "Speichern und neue Unteraufgabe",
                                  style: Theme.of(context)
                                      .textTheme
                                      .textStyle2
                                      .withPrimary,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Handles the 'save task' functionality
  Future<int?> onSaveTask() async {
    final cubit = BlocProvider.of<AlterTaskCubit>(context);
    // validate required fields:
    if (!cubit.validateTaskConstruction()) {
      // Not ready to save! Inform the user and continue
      final missingFieldsDescr = cubit.getMissingFieldsDescription();
      logger.d(
          'The task is not ready to be saved! Description: $missingFieldsDescr');
      // TODO: inform the user with a SnackBar
      return null;
    }

    return await BlocProvider.of<AlterTaskCubit>(context).saveTask();
  }
}
