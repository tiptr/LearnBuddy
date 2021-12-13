import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:flutter_svg/flutter_svg.dart';

class Femorals extends StatelessWidget {
const Femorals ({Key? key}) : super(key: key);

@override
Widget build(BuildContext context) {
return Positioned(
    top: 145.17578125,
    left: 38.208984375,
    child: Container(
        width: 57.6103515625,
        height: 38.390625,

        child: Stack(
            children: <Widget>[
              Positioned(
                  top: 0,
                  left: 0,
                  child: SvgPicture.asset(
                      'assets/body_parts_not_activated/r_femoral.svg',
                      semanticsLabel: 'r_femoral'
                  )
              ), Positioned(
                  top: 0,
                  left: 57.6103515625,
                  child: Transform(
                    transform: Matrix4.rotationY(math.pi),
                    child: SvgPicture.asset(
                        'assets/body_parts_not_activated/l_femoral.svg',
                        semanticsLabel: 'l_femoral'
                    ),
                  )
              ),
            ]
        )
    )
);

}


}






