import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_app/constants/basic_card.dart';
import 'package:learning_app/constants/leisure_default_image_paths.dart';
import 'package:learning_app/features/leisure/bloc/leisure_cubit.dart';
import 'package:learning_app/features/leisure/bloc/leisure_state.dart';
import 'package:learning_app/features/leisure/dtos/read_leisure_categories_dto.dart';
import 'package:learning_app/features/leisure/screens/leisure_activity_overview_screen.dart';
import 'package:learning_app/shared/widgets/base_title_bar.dart';
import 'package:learning_app/shared/widgets/three_points_menu.dart';
import 'package:learning_app/constants/theme_font_constants.dart';
import 'package:learning_app/constants/theme_color_constants.dart';

class LeisureScreen extends StatelessWidget {
  const LeisureScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      // Will change to a custom title bar in the future
      appBar: BaseTitleBar(
        title: "Abwechslung",
        actions: [
          buildThreePointsMenu(
            context: context,
            showGlobalSettings: true,
          )
        ],
      ),
      body: BlocBuilder<LeisureCubit, LeisureState>(
        builder: (context, state) {
          if (state is! LeisureCategoryLoaded) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return StreamBuilder<List<ReadLeisureCategoriesDto>>(
            stream: state.listViewLeisureCategoriesStream,
            builder: (context, snapshot) {
              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(
                  child: Text(
                    'Es sind keine Ausgleichsübungen verfügbar.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 11,
                      color: Color(0xFF636573),
                    ),
                  ),
                );
              }

              final categories = snapshot.data!;

              return ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: categories.length,
                itemBuilder: (BuildContext ctx, int idx) {
                  return GestureDetector(
                    child: LeisureCategoryCard(
                      leisureCategory: categories[idx],
                    ),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return LeisureActivityOverviewScreen(
                          activities: categories[idx].activities,
                        );
                      }),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

class LeisureCategoryCard extends StatelessWidget {
  final ReadLeisureCategoriesDto leisureCategory;

  const LeisureCategoryCard({required this.leisureCategory, Key? key})
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 60,
                child: LeisureCategoryDescription(
                  title: leisureCategory.name,
                  countExercises: leisureCategory.leisureActivityCount,
                ),
              ),
              Expanded(
                flex: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    StarCount(
                      count: leisureCategory.starCount,
                    ),
                    Image(
                      image: AssetImage(leisureCategory.pathToImage ??
                          defaultLeisureCategoryImagePath),
                      width: 85.0,
                      height: 85.0,
                    ),
                  ],
                ),
              ),
            ],
          ),
          height: BasicCard.height,
        ),
      ),
    );
  }
}

class LeisureCategoryDescription extends StatelessWidget {
  final String title;
  final int countExercises;

  const LeisureCategoryDescription({
    Key? key,
    required this.title,
    required this.countExercises,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .textStyle2
              .withBold
              .withOnBackgroundHard,
        ),
        Text(
          "$countExercises Übungen",
          style: Theme.of(context).textTheme.textStyle4.withOnBackgroundSoft,
        )
      ],
    );
  }
}

class StarCount extends StatelessWidget {
  final int count;

  const StarCount({
    required this.count,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.star, color: Theme.of(context).colorScheme.secondary),
        Text(
          count.toString(),
          style: Theme.of(context).textTheme.textStyle3.withOnBackgroundHard,
        )
      ],
    );
  }
}
