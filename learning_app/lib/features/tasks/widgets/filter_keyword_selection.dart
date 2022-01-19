import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_app/constants/theme_font_constants.dart';
import 'package:learning_app/features/keywords/bloc/keywords_cubit.dart';
import 'package:learning_app/features/keywords/bloc/keywords_state.dart';
import 'package:learning_app/features/keywords/dtos/read_key_word_dto.dart';

class FilterKeyWordSelection extends StatelessWidget {
  final List<ReadKeyWordDto> selected;
  final Function onTap;

  const FilterKeyWordSelection({
    Key? key,
    required this.selected,
    required this.onTap,
  }) : super(key: key);

  bool isSelected(ReadKeyWordDto keyWord) {
    return selected.contains(keyWord);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<KeyWordsCubit, KeyWordsState>(
      builder: (context, state) {
        // This only checks for the success state, we might want to check for
        // errors in the future here.
        if (state is! KeyWordsLoaded) {
          return const Center(child: CircularProgressIndicator());
        }

        return StreamBuilder<List<ReadKeyWordDto>>(
          stream: state.keywordsStream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            var keywordOptions = snapshot.data!;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Schlagwörter",
                  style: Theme.of(context)
                      .textTheme
                      .textStyle1
                      .withOnBackgroundSoft,
                ),
                const SizedBox(height: 10.0),
                Wrap(
                  direction: Axis.horizontal,
                  crossAxisAlignment: WrapCrossAlignment.start,
                  runAlignment: WrapAlignment.start,
                  runSpacing: 7.5,
                  spacing: 7.5,
                  children: keywordOptions
                      .map(
                        (c) => InkWell(
                          onTap: () {
                            onTap(c);
                          },
                          child: Chip(
                            label: Text(c.name),
                            backgroundColor: isSelected(c) ? Colors.cyan : null,
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                          ),
                        ),
                      )
                      .toList(),
                )
              ],
            );
          },
        );
      },
    );
  }
}
