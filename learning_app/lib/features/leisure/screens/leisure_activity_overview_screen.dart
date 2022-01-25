import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_app/constants/basic_card.dart';
import 'package:learning_app/constants/leisure_default_image_paths.dart';
import 'package:learning_app/constants/theme_color_constants.dart';
import 'package:learning_app/constants/theme_font_constants.dart';
import 'package:learning_app/features/leisure/bloc/leisure_cubit.dart';
import 'package:learning_app/features/leisure/dtos/read_leisure_activities_dto.dart';
import 'package:learning_app/features/leisure/widgets/leisure_overview_app_bar.dart';
import 'package:learning_app/features/leisure/screens/leisure_activity_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:learning_app/shared/widgets/gradient_icon.dart';

class LeisureActivityOverviewScreen extends StatelessWidget {
  final int categoryId;
  final String categoryTitle;

  const LeisureActivityOverviewScreen({
    Key? key,
    required this.categoryId,
    required this.categoryTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ReadLeisureActivitiesDto>>(
      stream: BlocProvider.of<LeisureCubit>(context)
          .watchLeisureActivitiesByCategoryId(categoryId: categoryId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
            child: Text(
              'Aktuell existieren leider keine Aktivitäten für die gewählte Kategorie',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.textStyle4,
            ),
          );
        }

        final activities = snapshot.data!;

        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          appBar: LeisureOverviewAppBar(
            categoryTitle: categoryTitle,
          ), //TODO: insert title
          body: ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: activities.length,
            itemBuilder: (BuildContext ctx, int idx) {
              return GestureDetector(
                child: LeisureActivityCard(
                  leisureActivity: activities[idx],
                ),
                onTap: () => {
                  Navigator.push(
                    ctx,
                    MaterialPageRoute(
                      builder: (ctx) => LeisureActivityScreen(
                          categoryId: categoryId,
                          activityId: activities[idx].id),
                    ),
                  )
                },
              );
            },
          ),
        );
      },
    );
  }
}

class LeisureActivityCard extends StatelessWidget {
  final ReadLeisureActivitiesDto leisureActivity;

  const LeisureActivityCard({required this.leisureActivity, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        margin: const EdgeInsets.all(0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(BasicCard.borderRadius),
        ),
        color: Theme.of(context).colorScheme.cardColor,
        elevation: BasicCard.elevation.high,
        shadowColor: Theme.of(context).colorScheme.shadowColor,
        child: Container(
          padding: const EdgeInsets.all(20.0),
          height: BasicCard.height,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 60,
                child: LeisureActivityDescription(
                  title: leisureActivity.name,
                  duration: leisureActivity.duration.inMinutes,
                ),
              ),
              Expanded(
                flex: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    gradientIcon(
                      iconData: Icons.star,
                      gradient: !leisureActivity.isFavorite
                          ? Theme.of(context).colorScheme.noColorGradient
                          : null,
                      context: context,
                    ),
                    SizedBox(
                      width: 85.0,
                      height: 85.0,
                      child: SvgPicture.asset(
                        leisureActivity.pathToImage ??
                            defaultLeisureCategoryImagePath,
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LeisureActivityDescription extends StatelessWidget {
  final String title;
  final int duration;

  const LeisureActivityDescription({
    Key? key,
    required this.title,
    required this.duration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .textStyle2
              .withBold
              .withOnBackgroundHard,
        ),
        const SizedBox(height: 10),
        Text(
          "$duration min",
          style: Theme.of(context).textTheme.textStyle4.withOnBackgroundSoft,
        )
      ],
    );
  }
}
