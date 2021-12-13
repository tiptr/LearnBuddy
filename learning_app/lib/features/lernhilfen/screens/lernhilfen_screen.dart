import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:learning_app/features/lernhilfen/widgets/ankles.dart';
import 'package:learning_app/features/lernhilfen/widgets/breasts.dart';
import 'package:learning_app/features/lernhilfen/widgets/elbows.dart';
import 'package:learning_app/features/lernhilfen/widgets/femorals.dart';
import 'package:learning_app/features/lernhilfen/widgets/foot.dart';
import 'package:learning_app/features/lernhilfen/widgets/hands.dart';
import 'package:learning_app/features/lernhilfen/widgets/head.dart';
import 'package:learning_app/features/lernhilfen/widgets/hip.dart';
import 'package:learning_app/features/lernhilfen/widgets/knees.dart';
import 'package:learning_app/features/lernhilfen/widgets/shanks.dart';
import 'package:learning_app/features/lernhilfen/widgets/shoulders.dart';
import 'package:learning_app/features/lernhilfen/widgets/underarms.dart';
import 'package:learning_app/features/lernhilfen/widgets/upper_arms.dart';
import 'package:learning_app/features/lernhilfen/widgets/waist.dart';
import 'package:learning_app/features/lernhilfen/widgets/wrists.dart';





class LernhilfenScreen extends StatelessWidget {
  const LernhilfenScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Spacer(),
        SizedBox(
            width: 200,
            height: 200,
            child: Hands()),
        Spacer(),
      ],
    );
  }


}







class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Figma Flutter Generator Body_countour_splitted_namedWidget - COMPONENT
    return Container(
        width: 134,
        height: 252,

        child: Stack(
            children: <Widget>[
              Positioned(
                  top: 0,
                  left: 0,
                  child: Container(
                      width: 134,
                      height: 252,
                      decoration: const BoxDecoration(
                        color: Color.fromRGBO(255, 255, 255, 1),
                      ),
                      child: Stack(
                          children: const <Widget>[
                             Hands(),
                             Wrists(),
                             Underarms(),
                             Elbows(),
                             UpperArms(),
                             Shoulders(),
                             Breasts(),
                             Waist(),
                             Head(),
                             Hip(),
                             Femorals(),
                             Knees(),
                             Shanks(),
                             Ankles(),
                             Foot(),
                          ]
                      )
                  )
              ),
            ]
        )
    );
  }
}
