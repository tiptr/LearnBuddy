import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_app/constants/leisure_default_image_paths.dart';
import 'package:learning_app/constants/theme_font_constants.dart';
import 'package:learning_app/features/leisure/bloc/leisure_cubit.dart';
import 'package:learning_app/features/leisure/dtos/read_leisure_activities_dto.dart';
import 'package:learning_app/features/leisure/widgets/leisure_app_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LeisureActivityScreen extends StatelessWidget {
  final int categoryId;
  final int activityId;

  const LeisureActivityScreen({
    required this.categoryId,
    required this.activityId,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ReadLeisureActivitiesDto>(
      stream: BlocProvider.of<LeisureCubit>(context).watchLeisureActivityById(
          categoryId: categoryId, activityId: activityId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData) {
          return Center(
            child: Text(
              'Die gewünschte Aktivität konnte leider nicht geladen werden',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.textStyle4,
            ),
          );
        }

        final activity = snapshot.data!;

        return Scaffold(
          appBar: LeisureAppBar(
            categoryTitle: activity.name,
            leisureActivity: activity,
          ),
          body: Scrollbar(
            isAlwaysShown: true,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.25,
                        child: SvgPicture.asset(
                          activity.pathToImage ??
                              defaultLeisureCategoryImagePath,
                          color: Colors.cyan,
                        ),
                      )),
                  // Spacer
                  const SizedBox(height: 20.0),
                  Center(
                    child: Text(
                      activity.duration.inMinutes.toString() + " Minuten",
                      style: const TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  // Spacer
                  const SizedBox(height: 5.0),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                      child: Text(
                        activity.descriptionShort,
                        style: const TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.visible,
                        ),
                      ),
                    ),
                  ),
                  // Spacer
                  const SizedBox(height: 20.0),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: Text(
                      "Details:",
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  // Spacer
                  const SizedBox(height: 5.0),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: Text(
                      activity.descriptionLong ?? '',
                      overflow: TextOverflow.visible,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
