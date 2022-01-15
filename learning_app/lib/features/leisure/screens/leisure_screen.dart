import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_app/constants/basic_card.dart';
import 'package:learning_app/constants/leisure_default_image_paths.dart';
import 'package:learning_app/features/leisure/bloc/leisure_category_cubit.dart';
import 'package:learning_app/features/leisure/bloc/leisure_category_state.dart';
import 'package:learning_app/features/leisure/dtos/read_leisure_categories_dto.dart';
import 'package:learning_app/shared/widgets/base_layout.dart';
import 'package:learning_app/shared/widgets/base_title_bar.dart';
import 'package:learning_app/constants/theme_font_constants.dart';

class LeisureScreen extends StatelessWidget {
  const LeisureScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      titleBar: const BaseTitleBar(
        title: "Abwechslung",
      ),
      content: BlocBuilder<LeasureCategoryCubit, LeasureCategoryState>(
        bloc: LeasureCategoryCubit(),
        builder: (context, state) {
          return ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: state.leisureCategoriesDtos.length,
            itemBuilder: (BuildContext ctx, int idx) => LeisureCategoryCard(
              leisureCategory: state.leisureCategoriesDtos[idx],
            ),
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
        color: Colors.white,
        elevation: BasicCard.elevation.high,
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
        const Icon(Icons.star, color: Colors.purple),
        Text(
          count.toString(),
          style: Theme.of(context).textTheme.textStyle3.withOnBackgroundHard,
        )
      ],
    );
  }
}
