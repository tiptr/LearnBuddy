import 'package:flutter/material.dart';
import 'package:learning_app/constants/card_elevation.dart';
import 'package:learning_app/features/learn_lists/learn_lists_general/models/learning_aid.dart';

const double iconSize = 18.0;

class LearningAidCard extends StatelessWidget {
  final LearningAid _learningAid;

  const LearningAidCard({Key? key, required LearningAid learningAid})
      : _learningAid = learningAid,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: _card(context),
    );
  }

  Widget _card(BuildContext context) {
    const borderRadius = 12.5;

    //////////////////////////////////////////////////
    //----------For Testing multiple options----------
    // TODO use real values from learningAid
    var categoryColor = Colors.red;
    // const categoryColor = Colors.lightBlue.shade600;
    //////////////////////////////////////////////////

    return Dismissible(
      key: Key(_learningAid.id.toString()),
      //onDismissed: (_) =>
      //    BlocProvider.of<LearningAidCubit>(context).deleteLearningAidById(_learningAid.id),
      child: Card(
        clipBehavior: Clip.hardEdge,
        margin: const EdgeInsets.all(0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        color: Theme.of(context).scaffoldBackgroundColor,
        elevation: CardElevation.high,
        child: ColorFiltered(
          // Grey out when done -> Overlay with semitransparent white; Else
          // overlay with fulltransparent "black" (no effect)
          colorFilter:
              const ColorFilter.mode(Color(0x00000000), BlendMode.lighten),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
            decoration: BoxDecoration(
              border: Border(
                // TODO: Use color of category once added
                left: BorderSide(width: 12.5, color: categoryColor),
              ),
              color: Colors.white,
            ),
            height: 110.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 80,
                  // This column holds the title + datechip
                  // and the description + further info row
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Upper Row
                      _buildUpperRow(context),
                      // Lower Row
                      _buildLowerRow()
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUpperRow(BuildContext context) {
    return Expanded(
      flex: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Title
          Expanded(
            flex: 70,
            child: Text(
              _learningAid.title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.none,
                decorationThickness: 2.0,
                fontSize: 20,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          // Date Chip
          Expanded(
            flex: 30,
            child: Chip(
              label: const Text(
                // TODO: Use real date here
                "Heute",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              avatar: const Icon(
                // TODO check if learningAid is overdue for color selection
                Icons.calendar_today_outlined,
                size: 16,
                color: Colors.black,
              ),
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildLowerRow() {
    return Expanded(
      flex: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: const [
          Icon(Icons.accessibility_new_rounded, size: iconSize),
          Spacer(flex: 1),
          Text(
            "9 Begriffe",
          ),
          Spacer(flex: 40),
        ],
      ),
    );
  }
}
