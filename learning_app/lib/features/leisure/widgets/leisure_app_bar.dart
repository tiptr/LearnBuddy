import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_app/constants/app_bar_height.dart';
import 'package:learning_app/constants/theme_color_constants.dart';
import 'package:learning_app/constants/theme_font_constants.dart';
import 'package:learning_app/features/leisure/bloc/leisure_cubit.dart';
import 'package:learning_app/features/leisure/dtos/read_leisure_activities_dto.dart';
import 'package:learning_app/shared/widgets/gradient_icon.dart';

// TODO: combine into generic appbar
class LeisureAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String categoryTitle;
  final ReadLeisureActivitiesDto leisureActivity;

  const LeisureAppBar(
      {Key? key, required this.categoryTitle, required this.leisureActivity})
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
                    icon: gradientIcon(
                      iconData: Icons.arrow_back,
                      size: 30,
                      context: context,
                    )),
                Expanded(
                  child: Text(categoryTitle,
                      textAlign: TextAlign.left,
                      style: Theme.of(context)
                          .textTheme
                          .textStyle1
                          .withBold
                          .withOnBackgroundHard),
                ),
                IconButton(
                    onPressed: () {
                      BlocProvider.of<LeisureCubit>(context).toggleFavorite(
                        leisureActivity.id,
                        !leisureActivity.isFavorite,
                      );
                    },
                    icon: gradientIcon(
                        iconData: Icons.star,
                        size: 30,
                        context: context,
                        gradient: !leisureActivity.isFavorite
                            ? Theme.of(context).colorScheme.noColorGradient
                            : null)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(detailScreensAppBarHeight);
}
