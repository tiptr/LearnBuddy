import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_app/constants/theme_font_constants.dart';
import 'package:learning_app/features/categories/dtos/read_category_dto.dart';
import 'package:learning_app/features/keywords/dtos/read_key_word_dto.dart';
import 'package:learning_app/features/tasks/bloc/tasks_cubit.dart';
import 'package:learning_app/features/tasks/bloc/tasks_state.dart';
import 'package:learning_app/features/tasks/filter_and_sorting/tasks_filter.dart';
import 'package:learning_app/features/tasks/widgets/filter_category_selection.dart';
import 'package:learning_app/features/tasks/widgets/filter_keyword_selection.dart';

class FilterSelectDialog extends StatefulWidget {
  const FilterSelectDialog({
    Key? key,
  }) : super(key: key);

  @override
  State<FilterSelectDialog> createState() => _FilterSelectDialogState();
}

class _FilterSelectDialogState extends State<FilterSelectDialog> {
  List<ReadCategoryDto> selectedCategories = [];
  List<ReadKeyWordDto> selectedKeywords = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: false,
      titlePadding: const EdgeInsets.all(15.0),
      contentPadding: const EdgeInsets.all(15.0),
      title: Text(
        "Filter",
        style: Theme.of(context).textTheme.mainPageTitleStyle,
      ),
      content: Scrollbar(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 350,
                width: 500,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FilterCategorySelection(
                      selected: selectedCategories,
                      onTap: (ReadCategoryDto category) {
                        setState(
                          () {
                            if (selectedCategories.contains(category)) {
                              selectedCategories = selectedCategories
                                  .where((c) => c.id != category.id)
                                  .toList();
                            } else {
                              selectedCategories = [
                                ...selectedCategories,
                                category
                              ];
                            }
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 25.0),
                    FilterKeyWordSelection(
                      selected: selectedKeywords,
                      onTap: (ReadKeyWordDto keyWord) {
                        setState(
                          () {
                            if (selectedKeywords.contains(keyWord)) {
                              selectedKeywords = selectedKeywords
                                  .where((c) => c.id != keyWord.id)
                                  .toList();
                            } else {
                              selectedKeywords = [...selectedKeywords, keyWord];
                            }
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  MaterialButton(
                    child: Text(
                      "Abbrechen",
                      style: Theme.of(context)
                          .textTheme
                          .textStyle4
                          .withOnBackgroundSoft,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  MaterialButton(
                    child: Text(
                      "Anwenden",
                      style: Theme.of(context).textTheme.textStyle4.withPrimary,
                    ),
                    onPressed: () {
                      final currentState =
                          BlocProvider.of<TasksCubit>(context).state;

                      if (currentState is TasksLoaded) {
                        final currentFilter =
                            currentState.taskFilter ?? const TaskFilter();

                        final categoryIds = selectedCategories
                            .map((category) => category.id)
                            .toList();

                        final categoryNames = selectedCategories
                            .map((category) => category.name)
                            .toList();

                        final keywordIds = selectedKeywords
                            .map((keyword) => keyword.id)
                            .toList();

                        final keywordNames = selectedKeywords
                            .map((keyword) => keyword.name)
                            .toList();

                        final newFilter = TaskFilter(
                          keywords: keywordIds.isEmpty
                              ? const drift.Value.absent()
                              : drift.Value(keywordIds),
                          categories: categoryIds.isEmpty
                              ? const drift.Value.absent()
                              : drift.Value(categoryIds),
                          dueToday: currentFilter.dueToday, // TODO
                          done: currentFilter.done,
                          categoryNames: categoryNames,
                          keywordNames: keywordNames,
                        );

                        BlocProvider.of<TasksCubit>(context)
                            .loadFilteredTasks(newFilter);
                      }
                      Navigator.of(context).pop();
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
