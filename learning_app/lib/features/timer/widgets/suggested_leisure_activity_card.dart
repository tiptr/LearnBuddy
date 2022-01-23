import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:learning_app/constants/theme_font_constants.dart';
import 'package:learning_app/features/leisure/bloc/suggested_leisure_cubit.dart';
import 'package:learning_app/features/leisure/model/leisure_activity.dart';
import 'package:learning_app/features/leisure/screens/leisure_activity_screen.dart';
import 'package:learning_app/util/formatting_comparison/duration_extensions.dart';

class SuggestedLeisureActivityCard extends StatelessWidget {
  const SuggestedLeisureActivityCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SuggestedLeisureCubit, SuggestedLeisureState>(
      builder: (context, state) {
        if (state is SuggestedLeisureLoaded) {
          LeisureActivity activity = state.activeLeisureActivity;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Title
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 30, left: 8, right: 8, bottom: 8),
                  child: Text(
                    "Zeit für eine Pause!",
                    style: Theme.of(context).textTheme.mainPageTitleStyle,
                    textAlign: TextAlign.start,
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Hier ein Vorschlag für etwas Abwechslung:",
                    style: Theme.of(context).textTheme.textStyle4,
                    textAlign: TextAlign.start,
                  ),
                ),
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
                child: Container(
                  // height: 220.0,
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Title
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 7,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 300,
                                  child: Text(
                                    activity.name,
                                    style: Theme.of(context)
                                        .textTheme
                                        .textStyle2
                                        .withOnBackgroundHard
                                        .withBold
                                        .withOverflow(TextOverflow.ellipsis),
                                  ),
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
                          ),
                          SizedBox(
                            width: 100.0,
                            height: 100.0,
                            child: SvgPicture.asset(
                                activity.pathToImage ??
                                    // For now, the crazy cat is the default when no path is present
                                    'assets/leisure/leisure-fun-smiling-cats.svg',
                                color: Colors.cyan),
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
            ],
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
