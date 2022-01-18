import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_app/constants/basic_card.dart';
import 'package:learning_app/constants/page_ids.dart';
import 'package:learning_app/constants/theme_color_constants.dart';
import 'package:learning_app/constants/theme_font_constants.dart';
import 'package:learning_app/util/nav_cubit.dart';

class LeisureCard extends StatelessWidget {
  const LeisureCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Ausgleich des Tages",
              style: Theme.of(context).textTheme.mainPageTitleStyle,
              textAlign: TextAlign.start,
            ),
          ],
        ),
        const SizedBox(
          height: 10.0,
        ),
        InkWell(
          onTap: () {
            BlocProvider.of<NavCubit>(context).navigateTo(PageId.leisure);
          },
          child: Card(
            clipBehavior: Clip.hardEdge,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                12.5,
              ),
            ),
            color: Theme.of(context).colorScheme.cardColor,
            elevation: BasicCard.elevation.high,
            shadowColor: Theme.of(context).colorScheme.shadowColor,
            child: Container(
              // height: 220.0,
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Title
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Grinsende Katzen",
                            style: Theme.of(context)
                                .textTheme
                                .textStyle2
                                .withOnBackgroundHard
                                .withBold,
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            "10 min",
                            style: Theme.of(context)
                                .textTheme
                                .textStyle3
                                .withOnBackgroundSoft,
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 85.0,
                        height: 85.0,
                        child: Image(
                          image: AssetImage(
                            "assets/leisure/leisure-fun-smiling-cats.png",
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  // Leisure description
                  const Text(
                    """Zeichne auf einem Papier fünf Katzen mit verschiedenen menschlichen 
Gesichtsausdrücken.\n\n
Teilt die Bilder innerhalb eurer Klasse und identifiziert euren Picasso.\n\n
Außerdem gibt es noch einen langen Text:\n\n
Dieser Text sollte darstellen, was passiert, wenn ein vertikaler Overflow passiert.""",
                    overflow: TextOverflow.visible,
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
