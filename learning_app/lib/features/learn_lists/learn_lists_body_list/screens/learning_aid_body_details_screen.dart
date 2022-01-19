import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:learning_app/constants/theme_font_constants.dart';
import 'package:learning_app/features/learn_lists/learn_lists_body_list/widgets/learning_aid_body_details_screen.dart';
import 'package:learning_app/features/learn_lists/learn_lists_general/bloc/alter_learn_list_cubit.dart';
import 'package:learning_app/features/learn_lists/learn_lists_general/bloc/learn_lists_cubit.dart';
import 'package:learning_app/features/learn_lists/learn_lists_general/dtos/learn_list_manipulation_dto.dart';
import 'package:learning_app/features/learn_lists/learn_lists_general/dtos/read_learn_list_dto.dart';
import 'package:learning_app/features/learn_lists/learn_lists_general/models/learn_list_word.dart';
import 'package:learning_app/features/learn_lists/learn_lists_general/models/learn_methods.dart';
import 'package:learning_app/features/learn_lists/learn_lists_general/widgets/learn_list_add_app_bar.dart';
import 'package:learning_app/features/learn_lists/learn_lists_general/widgets/learning_lists_detail_app_bar.dart';
import 'package:learning_app/features/learn_lists/learn_lists_general/widgets/term_input_field.dart';
import 'package:learning_app/util/logger.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class LearningAidBodyDetailsScreen extends StatelessWidget {
  final int learnListId;

  List<String> bodyParts = [
    "Kopf:",
    "Brust:",
    "Ellenbogen:",
    "Hände:",
    "Bauch:",
    "Po:",
    "Knie:",
    "Füße:"
  ];

  LearningAidBodyDetailsScreen({
    required this.learnListId,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ReadLearnListDto>(
      stream:  BlocProvider.of<LearnListsCubit>(context)
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
          body: SlidingUpPanel(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(18.0),
              topRight: Radius.circular(18.0),
            ),
            parallaxEnabled: true,
            parallaxOffset: .0,
            panelSnapping: true,
            minHeight: 145,
            maxHeight: MediaQuery.of(context).size.height * 0.80,
            panel: Column(
              children: [
                // The indicator on top showing the draggability of the panel
                InkWell(
                  child: Center(
                    heightFactor: 5,
                    child: Container(
                      height: 5,
                      width: 80,
                      margin: const EdgeInsets.only(right: 10),
                      decoration: const BoxDecoration(
                        color: Color(0xFFCBCCCD),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),
                const Text(
                  "Hier ist deine Körperliste:",
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.fade,
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10.0),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: learnList.words.length, //should always be 8 for a body list!
                  itemBuilder: (context, i) {
                    var newDescriptionController = TextEditingController();
                    return LearningAidBodyDetailsListViewItem(
                        word: learnList.words[i].word,
                        text: bodyParts[i],
                      );
                  },
                ),
                // Only for navigation to tags
                const SizedBox(height: 10.0)
              ],
            ),
            color: Colors.white,
            body: SvgPicture.asset(
                "assets/learning_aids/moehm_alternative.svg",
              ),
          ),
        );
      },
    );
  }
}
