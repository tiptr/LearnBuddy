import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_app/constants/leisure_default_image_paths.dart';
import 'package:learning_app/features/leisure/bloc/leisure_category_cubit.dart';
import 'package:learning_app/features/leisure/bloc/leisure_category_state.dart';
import 'package:learning_app/features/leisure/dtos/read_leisure_categories_dto.dart';
import 'package:learning_app/features/leisure/screens/leisure_activity_overview_screen.dart';
import 'package:learning_app/shared/widgets/base_layout.dart';
import 'package:learning_app/shared/widgets/base_title_bar.dart';

class LeisureScreen extends StatelessWidget {
  const LeisureScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      titleBar: const BaseTitleBar(
        title: "Abwechslung",
      ),
      content: BlocBuilder<LeasureCategoryCubit, LeisureCategoryState>(
        bloc: LeasureCategoryCubit(),
        builder: (context, state) {
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
                      MaterialPageRoute(
                        builder: (context) => const LeisureActivityOverviewScreen(),
                      ),
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
