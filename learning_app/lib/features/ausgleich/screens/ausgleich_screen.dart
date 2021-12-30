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
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: Card(
        margin: const EdgeInsets.all(0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: Colors.white,
        elevation: 5,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 70,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: StartCount(
                        count: leasureCategory.starCount,
                      ),
                    ),
                    LeasureCategoryDescription(
                      title: leasureCategory.title,
                      countExercises: leasureCategory.countAids,
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 30,
                child: Image(
                  image: AssetImage(leasureCategory.assetString),
                ),
              )
            ],
          ),
        ),
      ),
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
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const Icon(Icons.star, color: Colors.purple),
        Text(count.toString())
      ],
    );
  }
}

class LeasureCategoryDescription extends StatelessWidget {
  final String title;
  final int countExercises;

  const LeasureCategoryDescription(
      {Key? key, required this.title, required this.countExercises})
      : super(key: key);

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
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0),
        )
      ],
    );
  }
}
