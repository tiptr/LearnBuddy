import 'package:flutter/material.dart';
import 'package:learning_app/constants/app_bar_height.dart';
import 'package:learning_app/features/leisure/bloc/leisure_activity_cubit.dart';
import 'package:learning_app/features/leisure/dtos/read_leisure_activities_dto.dart';

class LeisureAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String categoryTitle;
  final LeisureActivityCubit cubit;
  final ReadLeisureActivitiesDto leisureActivity;

  const LeisureAppBar(
      {Key? key,
      required this.categoryTitle,
      required this.cubit,
      required this.leisureActivity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back),
                  iconSize: 30,
                ),
                Expanded(
                  child: Text(categoryTitle,
                      textAlign: TextAlign.left,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                ),
                IconButton(
                  //TODO: Make icon change color immediately, not just after going to the main page and back
                  onPressed: () {
                    cubit.toggleFavorite(
                        leisureActivity.id, !leisureActivity.isFavorite);
                  },
                  icon: Icon(Icons.star,
                      color: leisureActivity.isFavorite
                          ? Colors.purple
                          : Colors.grey),
                  iconSize: 30,
                ),
                IconButton(
                  onPressed: () {
                    //TODO: add settings function
                  },
                  icon: const Icon(Icons.more_vert),
                  iconSize: 30,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(appBarHeight);
}
