import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:learning_app/features/lernhilfen/screens/test.dart';
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
      // ignore: prefer_const_literals_to_create_immutables
      children: [
        const Spacer(),
        const Center(
          child: Body(),
        ),
        const Spacer(),
        Center(
          child: GestureDetector(
            child: SizedBox(
              height:100,
              width: 100,
              child: CustomPaint(
    size: Size(100, (100*1.2804048760196658).toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
    painter: RPSCustomPainter(),
)
              
            ),
            onTap: () => print("TESTERTEST"),
          ),
        ),
        const Spacer(),
      ],
    );
  }


}







class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Figma Flutter Generator Body_countour_splitted_namedWidget - COMPONENT
    return SizedBox(
        width: 134,
        height: 252,
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
    );
  }
}
