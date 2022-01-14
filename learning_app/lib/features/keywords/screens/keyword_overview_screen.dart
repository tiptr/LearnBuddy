import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_app/features/keywords/bloc/keywords_cubit.dart';
import 'package:learning_app/features/keywords/bloc/keywords_state.dart';
import 'package:learning_app/features/keywords/models/keyword.dart';
import 'package:learning_app/features/keywords/widgets/keyword_add_dialog.dart';
import 'package:learning_app/features/keywords/widgets/keyword_app_bar.dart';
import 'package:learning_app/features/keywords/widgets/keyword_card.dart';

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
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                child: Text(
                  'Du hast aktuell keine Kategorien.\nDrücke auf das Plus, um eine Kategorie anzulegen',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 11,
                    color: Color(0xFF636573),
                  ),
                ),
              );
            }

            final keywords = snapshot.data!;

            return Scaffold(
              appBar: const KeyWordAddAppBar(),
              body: ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: keywords.length,
                itemBuilder: (BuildContext ctx, int idx) => KeyWordCard(
                  keyword: keywords[idx],
                ),
              ),
              floatingActionButton: FloatingActionButton(
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
