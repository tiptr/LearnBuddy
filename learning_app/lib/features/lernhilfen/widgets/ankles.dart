import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:flutter_svg/flutter_svg.dart';

class Ankles extends StatelessWidget {
const Ankles({Key? key}) : super(key: key);

@override
Widget build(BuildContext context) {
return Positioned(
    top: 229.69580078125,
    left: 36.3232421875,
    child: Container(
        width: 61.3828125,
        height: 4.5655364990234375,

        child: Stack(
            children: <Widget>[
              Positioned(
                  top: 0,
                  left: 0,
                  child: InkWell(
                    child: SvgPicture.asset(
                        'assets/body_parts_activated/r_ankle.svg',
                        semanticsLabel: 'r_ankle'
                    ),
                    onTap: () => print("Test"),
                  )
              ), Positioned(
                  top: 0,
                  left: 61.3828125,
                  child: Transform(
                    transform: Matrix4.rotationY(math.pi),
                    child: SvgPicture.asset(
                        'assets/body_parts_not_activated/l_ankle.svg',
                        semanticsLabel: 'l_ankle'
                    ),
                  )
              ),
            ]
        )
    )
);

}


}