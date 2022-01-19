import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:learning_app/constants/basic_card.dart';
import 'package:learning_app/constants/theme_color_constants.dart';
import 'package:learning_app/constants/theme_font_constants.dart';
import 'package:learning_app/features/leisure/bloc/leisure_cubit.dart';
import 'package:learning_app/features/leisure/dtos/read_leisure_activities_dto.dart';
import 'package:learning_app/features/leisure/screens/leisure_activity_screen.dart';
import 'package:learning_app/util/formatting_comparison/duration_extensions.dart';

class LeisureCard extends StatelessWidget {
  const LeisureCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var randomActivity =
        BlocProvider.of<LeisureCubit>(context).getDailyRandomLeisureActivity();

    return FutureBuilder(
      future: randomActivity, // async work
      builder: (
        BuildContext context,
        AsyncSnapshot<ReadLeisureActivitiesDto?> snapshot,
      ) {
        if (snapshot.data == null) {
          // Return empty widget
          return Container();
        }

        var activity = snapshot.data!;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Ausgleich des Tages",
                  style: Theme.of(context).textTheme.mainPageTitleStyle,
                  textAlign: TextAlign.start,
                ),
              ],
            ),
            const SizedBox(
              height: 10.0,
            ),
            InkWell(
              onTap: () => {
                // Open the activity screen for the shown activity
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) => LeisureActivityScreen(
                      categoryId: activity.categoryId,
                      activityId: activity.id,
                    ),
                  ),
                )
              },
              child: Card(
                clipBehavior: Clip.hardEdge,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    12.5,
                  ),
                ),
                color: Theme.of(context).colorScheme.cardColor,
                elevation: BasicCard.elevation.high,
                shadowColor: Theme.of(context).colorScheme.shadowColor,
                child: Container(
                  // height: 220.0,
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Title
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                activity.name,
                                style: Theme.of(context)
                                    .textTheme
                                    .textStyle2
                                    .withOnBackgroundHard
                                    .withBold,
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                activity.duration.formatShort(),
                                style: Theme.of(context)
                                    .textTheme
                                    .textStyle3
                                    .withOnBackgroundSoft,
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 85.0,
                            height: 85.0,
                            child: SvgPicture.asset(
                              activity.pathToImage ??
                                  // For now, the crazy cat is the default when no path is present
                                  'assets/leisure/leisure-fun-smiling-cats.svg',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      // Leisure description
                      Text(
                        activity.descriptionLong ?? activity.descriptionShort,
                        overflow: TextOverflow.visible,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
