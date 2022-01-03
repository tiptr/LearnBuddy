import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_app/constants/leisure_default_image_paths.dart';
import 'package:learning_app/features/leisure/bloc/leisure_category_cubit.dart';
import 'package:learning_app/features/leisure/bloc/leisure_category_state.dart';
import 'package:learning_app/features/leisure/model/leisure_category.dart';

class LeisureScreen extends StatelessWidget {
  const LeisureScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LeasureCategoryCubit, LeasureCategoryState>(
      bloc: LeasureCategoryCubit(),
      builder: (context, state) {
        return ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: state.leisureCategories.length,
          itemBuilder: (BuildContext ctx, int idx) => LeisureCategoryCard(
            leisureCategory: state.leisureCategories[idx],
          ),
        );
      },
    );
  }
}

class LeisureCategoryCard extends StatelessWidget {
  final LeisureCategory leisureCategory;

  const LeisureCategoryCard({required this.leisureCategory, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        margin: const EdgeInsets.all(0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: Colors.white,
        elevation: 5,
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
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
        ),
        const SizedBox(height: 10),
        Text(
          "$countExercises Übungen",
          style: const TextStyle(fontSize: 14.0, color: Colors.grey),
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
        Text(count.toString())
      ],
    );
  }
}
