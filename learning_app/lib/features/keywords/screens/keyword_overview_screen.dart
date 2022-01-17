import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_app/features/keywords/bloc/keywords_cubit.dart';
import 'package:learning_app/features/keywords/bloc/keywords_state.dart';
import 'package:learning_app/features/keywords/models/keyword.dart';
import 'package:learning_app/features/keywords/widgets/keyword_add_dialog.dart';
import 'package:learning_app/shared/widgets/go_back_title_bar.dart';
import 'package:learning_app/shared/widgets/screen_without_bottom_navbar_base_template.dart';
import 'package:learning_app/features/keywords/widgets/keyword_card.dart';
import 'package:learning_app/constants/theme_font_constants.dart';

class KeyWordOverviewScreen extends StatelessWidget {
  const KeyWordOverviewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<KeyWordsCubit, KeyWordsState>(
      builder: (context, state) {
        // This only checks for the success state, we might want to check for
        // errors in the future here.
        if (state is! KeyWordsLoaded) {
          return const Center(child: CircularProgressIndicator());
        }

        return StreamBuilder<List<KeyWord>>(
          stream: state.keywordsStream,
          builder: (context, snapshot) {
            late Widget body;
            if (snapshot.connectionState == ConnectionState.waiting) {
              body = const Center(child: CircularProgressIndicator());
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              body = Center(
                child: Text(
                  'Du hast aktuell keine Schlagwörter.\nDrücke auf das Plus, um ein Schlagwort anzulegen',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.textStyle4,
                ),
              );
            } else {
              final keywords = snapshot.data!;
              body = ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: keywords.length,
                itemBuilder: (BuildContext ctx, int idx) => KeyWordCard(
                  keyword: keywords[idx],
                ),
              );
            }

            return ScreenWithoutBottomNavbarBaseTemplate(
              titleBar: const GoBackTitleBar(title: "Schlagwörter"),
              body: body,
              fab: FloatingActionButton(
                heroTag: "NavigateToKeyWordAddScreen",
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return const KeyWordAddDialog();
                    },
                  );
                },
                child: const Icon(Icons.add),
                backgroundColor: Theme.of(context).colorScheme.primary,
              ),
            );
          },
        );
      },
    );
  }
}
