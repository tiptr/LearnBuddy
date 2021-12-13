import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:flutter_svg/flutter_svg.dart';

class Foot extends StatelessWidget {
const Foot({Key? key}) : super(key: key);

@override
Widget build(BuildContext context) {
return Positioned(
    top: 233.13916015625,
    left: 26.099609375,
    child: Container(
        width: 81.830078125,
        height: 18.419647216796875,

        child: Stack(
            children: <Widget>[
              Positioned(
                  top: 0,
                  left: 0,
                  child: Container(
                      width: 81.830078125,
                      height: 16.647750854492188,

                      child: Stack(
                          children: <Widget>[
                            Positioned(
                                top: 0,
                                left: 0,
                                child: SvgPicture
                                    .asset(
                                    'assets/images/r_foot_middle.svg',
                                    semanticsLabel: 'r_foot_middle'
                                )
                            ), Positioned(
                                top: 0,
                                left: 81.830078125,
                                child: Transform
                                    .rotate(
                                  angle: -180 *
                                      (math.pi /
                                          180),
                                  child: SvgPicture
                                      .asset(
                                      'assets/images/l_foot_middle.svg',
                                      semanticsLabel: 'l_foot_middle'
                                  ),
                                )
                            ),
                          ]
                      )
                  )
              ), Positioned(
                  top: 3.12548828125,
                  left: 18.029296875,
                  child: Container(
                      width: 45.771484375,
                      height: 5.412109375,

                      child: Stack(
                          children: <Widget>[
                            Positioned(
                                top: 0,
                                left: 0,
                                child: SvgPicture
                                    .asset(
                                    'assets/images/r_heel.svg',
                                    semanticsLabel: 'r_heel'
                                )
                            ), Positioned(
                                top: 0,
                                left: 45.771484375,
                                child: Transform
                                    .rotate(
                                  angle: -180 *
                                      (math.pi /
                                          180),
                                  child: SvgPicture
                                      .asset(
                                      'assets/images/l_heel.svg',
                                      semanticsLabel: 'l_heel'
                                  ),
                                )
                            ),
                          ]
                      )
                  )
              ), Positioned(
                  top: 14.40869140625,
                  left: 0.888671875,
                  child: Container(
                      width: 80.0517578125,
                      height: 4.010955810546875,

                      child: Stack(
                          children: <Widget>[
                            Positioned(
                                top: 0,
                                left: 0,
                                child: SvgPicture
                                    .asset(
                                    'assets/images/r_toe.svg',
                                    semanticsLabel: 'r_toe'
                                )
                            ), Positioned(
                                top: 0,
                                left: 80.0517578125,
                                child: Transform
                                    .rotate(
                                  angle: -180 *
                                      (math.pi /
                                          180),
                                  child: SvgPicture
                                      .asset(
                                      'assets/images/l_toe.svg',
                                      semanticsLabel: 'l_toe'
                                  ),
                                )
                            ),
                          ]
                      )
                  )
              ),
            ]
        )
    )
);

}


}