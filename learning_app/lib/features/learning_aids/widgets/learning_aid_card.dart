import 'package:flutter/material.dart';
import 'package:learning_app/constants/basic_card.dart';
import 'package:learning_app/features/learning_aids/models/learning_aid.dart';
import 'package:learning_app/constants/theme_font_constants.dart';
import 'package:learning_app/constants/theme_color_constants.dart';

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
    var borderRadius = BasicCard.borderRadius;

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
        color: Theme.of(context).colorScheme.cardColor,
        elevation: BasicCard.elevation.high,
        shadowColor: Theme.of(context).colorScheme.shadowColor,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
          decoration: BoxDecoration(
            border: Border(
              // TODO: Use color of category once added
              left: BorderSide(width: borderRadius, color: categoryColor),
            ),
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
                    _buildLowerRow(context),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUpperRow(BuildContext context) {
    TextStyle dueDateStyle = Theme.of(context).textTheme.textStyle4;
    // To keep this in for further expansion, the pipeline has to be tricked,
    // otherwise, the on the date dependent styles are seen as dead code if the
    // flag is constant.
    bool _isOverDue = true == false ? true : false;
    return Expanded(
      flex: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Title
          Expanded(
            flex: 70,
            child: Text(_learningAid.title,
                style: Theme.of(context)
                    .textTheme
                    .textStyle2
                    .withBold
                    .withOnBackgroundHard),
          ),
          // Date Chip
          Expanded(
            flex: 30,
            child: Chip(
              label: Text(
                // TODO: Use real date here
                "Heute",
                style: _isOverDue
                    ? dueDateStyle.withOnSecondary
                    : dueDateStyle.withOnBackgroundHard,
              ),
              avatar: Icon(
                // TODO check if learningAid is overdue for color selection
                Icons.calendar_today_outlined,
                size: 16,
                color: _isOverDue
                    ? Theme.of(context).colorScheme.onSecondary
                    : Theme.of(context).colorScheme.onBackgroundHard,
              ),
              backgroundColor: _isOverDue
                  ? Theme.of(context).colorScheme.secondary
                  : Theme.of(context).colorScheme.cardColor,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildLowerRow(BuildContext context) {
    return Expanded(
      flex: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(Icons.accessibility_new_rounded,
              size: iconSize,
              color: Theme.of(context).colorScheme.onBackgroundSoft),
          const Spacer(flex: 1),
          Text(
            "9 Begriffe",
            textAlign: TextAlign.end,
            style: Theme.of(context).textTheme.textStyle4.withOnBackgroundSoft,
          ),
          const Spacer(flex: 40),
        ],
      ),
    );
  }
}