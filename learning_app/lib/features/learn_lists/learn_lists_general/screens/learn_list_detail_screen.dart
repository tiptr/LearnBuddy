import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_app/constants/theme_font_constants.dart';
import 'package:learning_app/features/learn_lists/learn_lists_general/bloc/learn_lists_cubit.dart';
import 'package:learning_app/features/learn_lists/learn_lists_general/dtos/read_learn_list_dto.dart';
import 'package:learning_app/features/learn_lists/learn_lists_general/widgets/learning_lists_detail_app_bar.dart';
import 'package:learning_app/features/learn_lists/learn_lists_general/widgets/term_input_field.dart';

class LearnListDetailScreen extends StatelessWidget {
  final int learnListId;

  const LearnListDetailScreen({
    required this.learnListId,
    Key? key,
  }) : super(key: key);


  @override 
  Widget build(BuildContext context) {
    return StreamBuilder<ReadLearnListDto>(
      stream: BlocProvider.of<LearnListsCubit>(context)
            .watchLearnListById(learnListId: learnListId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData) {
          return Center(
            child: Text(
              'Die gewünschte Lernliste konnte leider nicht geladen werden',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.textStyle4,
            ),
          );
        }

        final learnList = snapshot.data!;

        return Scaffold(
          appBar: LearnListsDetailAppBar(text: learnList.name),
          body: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  const Text(
                    "Hier ist deine Lernliste:",
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.fade,
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 40.0),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: learnList.words.length,
                    itemBuilder: (context, i) {
                      return ListViewItem(
                        word: learnList.words[i].word
                      );
                    },
                  ),
                  const SizedBox(height: 10.0),
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}

class ListViewItem extends StatelessWidget {
  const ListViewItem({Key? key, required this.word})
      : super(key: key);

  final String word;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(word),
        // Only for navigation to tags
        const SizedBox(height: 20.0),
      ],
    );
  }
}
