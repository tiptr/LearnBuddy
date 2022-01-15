import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_app/constants/leisure_default_image_paths.dart';
import 'package:learning_app/features/leisure/bloc/leisure_activity_cubit.dart';
import 'package:learning_app/features/leisure/bloc/leisure_activity_state.dart';
import 'package:learning_app/features/leisure/dtos/read_leisure_activities_dto.dart';
import 'package:learning_app/features/leisure/widgets/leisure_app_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LeisureActivityScreen extends StatelessWidget {
  final ReadLeisureActivitiesDto leisureActivity;
  final LeisureActivityCubit cubit;

  const LeisureActivityScreen({required this.leisureActivity, required this.cubit, Key? key})
      : super(key: key);
      
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LeisureAppBar(categoryTitle: leisureActivity.name, cubit: cubit, leisureActivity: leisureActivity,),
      body: BlocBuilder<LeisureActivityCubit, LeisureActivityState>(
        bloc: cubit,
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
                        child: SvgPicture.asset(
                          leisureActivity.pathToImage ?? defaultLeisureCategoryImagePath,
                          color: Colors.cyan,
                        ), 
                      )
                  ),
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
                    child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                      child: Text(
                        leisureActivity.descriptionShort,
                        style: const TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
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