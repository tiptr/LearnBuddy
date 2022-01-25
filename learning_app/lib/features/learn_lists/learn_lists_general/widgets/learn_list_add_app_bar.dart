import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_app/constants/app_bar_height.dart';
import 'package:learning_app/constants/theme_font_constants.dart';
import 'package:learning_app/features/learn_lists/learn_lists_general/bloc/alter_learn_list_cubit.dart';
import 'package:learning_app/features/learn_lists/learn_lists_general/dtos/learn_list_manipulation_dto.dart';
import 'package:drift/drift.dart' as drift;
import 'package:learning_app/shared/widgets/gradient_icon.dart';

class LearnListAddAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final TextEditingController textController;
  final Function() onSaveLearnList;

  const LearnListAddAppBar(
      {Key? key, required this.textController, required this.onSaveLearnList})
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
                    context: context,
                    size: 30,
                  ),
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration.collapsed(
                      hintText: 'Name der Aufgabe',
                      hintStyle: Theme.of(context)
                          .textTheme
                          .textStyle2
                          .withOnBackgroundSoft
                          .withOutBold,
                      border: InputBorder.none,
                    ),
                    controller: textController,
                    style: Theme.of(context)
                        .textTheme
                        .textStyle2
                        .withOnBackgroundHard
                        .withBold,
                    onChanged: (text) async {
                      BlocProvider.of<AlterLearnListCubit>(context)
                          .alterLearnListAttribute(LearnListManipulationDto(
                        name: drift.Value(text),
                      ));
                    },
                    autofocus: true,
                    maxLines: 1,
                  ),
                ),
                IconButton(
                    onPressed: () async {
                      int? savedLearnListId = await onSaveLearnList();

                      if (savedLearnListId != null) {
                        Navigator.pop(context);
                      }
                    },
                    icon: gradientIcon(
                      iconData: Icons.save_outlined,
                      context: context,
                      size: 30,
                    )),
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
