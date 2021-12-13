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
                  child: SvgPicture.asset(
                      'assets/images/r_ankle.svg',
                      semanticsLabel: 'r_ankle'
                  )
              ), Positioned(
                  top: 0,
                  left: 61.3828125,
                  child: Transform.rotate(
                    angle: -180 * (math.pi / 180),
                    child: SvgPicture.asset(
                        'assets/images/l_ankle.svg',
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