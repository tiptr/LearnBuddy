import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_app/constants/leisure_default_image_paths.dart';
import 'package:learning_app/features/leisure/bloc/leisure_activity_cubit.dart';
import 'package:learning_app/features/leisure/bloc/leisure_activity_state.dart';
import 'package:learning_app/features/leisure/dtos/read_leisure_activities_dto.dart';
import 'package:learning_app/features/leisure/widgets/leisure_app_bar.dart';

class LeisureActivityScreen extends StatelessWidget {
  final ReadLeisureActivitiesDto leisureActivity;

  const LeisureActivityScreen({required this.leisureActivity, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LeisureAppBar(categoryTitle: leisureActivity.name),
      body: BlocBuilder<LeasureActivityCubit, LeasureActivityState>(
        bloc: LeasureActivityCubit(),
        builder: (context, state) {
          return Scrollbar(
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
                        child: Image(
                          image: AssetImage(leisureActivity.pathToImage ??
                              defaultLeisureCategoryImagePath),
                          width: 85.0,
                          height: 85.0,
                        ),
                      )),
                  // Spacer
                  const SizedBox(height: 20.0),
                  Center(
                    child: Text(
                      leisureActivity.duration.inMinutes.toString() +
                          " Minuten",
                      style: const TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  // Spacer
                  const SizedBox(height: 5.0),
                  Center(
                    child: Text(
                      leisureActivity.descriptionShort,
                      style: const TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
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
                      leisureActivity.descriptionLong ?? '',
                      style: const TextStyle(
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                ]),
            ),
          );
        },
      ),
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
                    const Icon(Icons.star, color: Colors.purple),
                    Image(
                      image: AssetImage(leisureActivity.pathToImage ??
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
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
        ),
        const SizedBox(height: 10),
        Text(
          "$duration min",
          style: const TextStyle(fontSize: 14.0, color: Colors.grey),
        )
      ],
    );
  }
}
