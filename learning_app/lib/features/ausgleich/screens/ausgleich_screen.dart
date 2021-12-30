import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_app/features/ausgleich/bloc/leasure_category_cubit.dart';
import 'package:learning_app/features/ausgleich/bloc/leasure_category_state.dart';
import 'package:learning_app/features/ausgleich/model/leasure_category.dart';

class AusgleichScreen extends StatelessWidget {
  const AusgleichScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LeasureCategoryCubit, LeasureCategoryState>(
      bloc: LeasureCategoryCubit(),
      builder: (context, state) {
        return ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: state.leasureCategories.length,
          itemBuilder: (BuildContext ctx, int idx) => LeasureCategoryCard(
            leasureCategory: state.leasureCategories[idx],
          ),
        );
      },
    );
  }
}

class LeasureCategoryCard extends StatelessWidget {
  final LeasureCategory leasureCategory;

  const LeasureCategoryCard({required this.leasureCategory, Key? key})
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
                child: LeasureCategoryDescription(
                  title: leasureCategory.title,
                  countExercises: leasureCategory.countAids,
                ),
              ),
              Expanded(
                flex: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    StartCount(
                      count: leasureCategory.starCount,
                    ),
                    Image(
                      image: AssetImage(leasureCategory.assetString),
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

class LeasureCategoryDescription extends StatelessWidget {
  final String title;
  final int countExercises;

  const LeasureCategoryDescription({
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
        Text(
          "$countExercises Übungen",
          style: const TextStyle(fontSize: 14.0),
        )
      ],
    );
  }
}

class StartCount extends StatelessWidget {
  final int count;

  const StartCount({
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
