import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:learning_app/constants/theme_font_constants.dart';
import 'package:learning_app/features/learn_lists/learn_lists_body_list/models/body_list.dart';
import 'package:learning_app/features/learn_lists/learn_lists_body_list/screens/learning_aid_body_details_screen.dart';
import 'package:learning_app/features/learn_lists/learn_lists_general/bloc/learn_lists_cubit.dart';
import 'package:learning_app/features/learn_lists/learn_lists_general/bloc/learn_lists_state.dart';
import 'package:learning_app/features/learn_lists/learn_lists_general/dtos/read_learn_list_dto.dart';
import 'package:learning_app/features/learn_lists/learn_lists_general/models/learn_list.dart';
import 'package:learning_app/features/learn_lists/learn_lists_body_list/screens/learning_aid_body_add_screen.dart';
import 'package:learning_app/features/learn_lists/learn_lists_general/screens/learn_list_detail_screen.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:learning_app/features/learn_lists/learn_lists_general/widgets/learn_list_card.dart';
import 'package:learning_app/shared/widgets/base_title_bar.dart';
import 'package:learning_app/shared/widgets/three_points_menu.dart';
import 'learn_list_add_screen.dart';

class LearnListsScreen extends StatelessWidget {
  LearnListsScreen({Key? key}) : super(key: key);

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      // Will change to a custom title bar in the future
      appBar: BaseTitleBar(
        title: "Lernhilfen",
        actions: [
          buildThreePointsMenu(
            context: context,
            showGlobalSettings: true,
          )
        ],
      ),
      body: BlocBuilder<LearnListsCubit, LearnListsState>(
        builder: (context, state) {
          if (state is! LearnListLoaded) {
             return const Center(
               child: CircularProgressIndicator(),
             );
           }

          return StreamBuilder<List<ReadLearnListDto>>(
            stream: state.selectedListViewlearnListsStream,
            builder: (context, snapshot) {
              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(
                  child: Text(
                    'Es sind keine Lernlisten verfügbar.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 11,
                      color: Color(0xFF636573),
                    ),
                  ),
                );
              }

              final learnLists = snapshot.data!;

              return ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: learnLists.length,
                itemBuilder: (BuildContext ctx, int idx) {
                  return GestureDetector(
                    child: LearnListCard(
                      learningAid: learnLists[idx],
                    ),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        if(learnLists[idx] is BodyList) {
                          return LearningAidBodyDetailsScreen(learnListId: learnLists[idx].id);
                        } else {
                          return LearnListDetailScreen(learnListId: learnLists[idx].id);
                        }
                      })
                    )
                  );
                }
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "NavigateToLearningAidAddScreen",
        onPressed: () {
          _openPopup(context);
        },
        child: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
    );
  }

  _openPopup(context) {
    Alert(
        context: context,
        title: "Art der Lernhilfe",
        content: Column(
          children: [
            CustomButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LearningAidBodyAddScreen(),
                ),
              ),
              icon: Icons.accessibility_new_rounded,
              text: "Begriffe an Körperteile binden",
            ),
            const Divider(color: Colors.black),
            CustomButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LearnListAddScreen(),
                ),
              ),
              icon: Icons.format_list_bulleted,
              text:
                  "Begriffsliste                              ", //makes the buttons equally sized:)
            )
          ],
        ),
        buttons: [
          //has to be empty, otherwise a "cancel" button will be inserted by default
        ]).show();
  }
}

class CustomButton extends StatelessWidget {
  final GestureTapCallback onPressed;
  final IconData icon;
  final String text;

  const CustomButton(
      {required this.onPressed,
      required this.icon,
      required this.text,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      fillColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              icon,
              color: Colors.black,
            ),
            const SizedBox(
              width: 10.0,
            ),
            Text(
              text,
              maxLines: 1,
              style: const TextStyle(color: Colors.black),
            ),
          ],
        ),
      ),
      onPressed: onPressed,
      elevation: 0,
      hoverElevation: 0,
      focusElevation: 0,
      highlightElevation: 0,
    );
  }
}
