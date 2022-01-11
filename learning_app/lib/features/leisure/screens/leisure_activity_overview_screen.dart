import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_app/constants/leisure_default_image_paths.dart';
import 'package:learning_app/features/leisure/bloc/leisure_activity_cubit.dart';
import 'package:learning_app/features/leisure/bloc/leisure_activity_state.dart';
import 'package:learning_app/features/leisure/dtos/read_leisure_activities_dto.dart';
import 'package:learning_app/features/leisure/widgets/leisure_add_app_bar.dart';



class LeisureActivityOverviewScreen extends StatelessWidget {
  const LeisureActivityOverviewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const LeisureAddAppBar(categoryTitle: "Fitness ohne Geräte"), //TODO: insert title
      body: BlocBuilder<LeasureActivityCubit, LeasureActivityState>(
      bloc: LeasureActivityCubit(),
      builder: (context, state) {
        return ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: state.leisureActivitiesDtos.length,
          itemBuilder: (BuildContext ctx, int idx) {
            return GestureDetector(
              child: LeisureActivityCard(
                        leisureActivity: state.leisureActivitiesDtos[idx],
                       ),
              onTap: () => {}//Navigator.push(
                //ctx,
                //MaterialPageRoute(
                  //builder: (ctx) => const LeisureActivityScreen(),
              );
          },
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
