import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:flutter_svg/flutter_svg.dart';

class Hands extends StatelessWidget {
  const Hands({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 117.50003051757812,
        left: -0.10841948539018631,
        child: Container(
            width: 134.241455078125,
            height: 24.91265869140625,

            child: Stack(
                children: <Widget>[
                  Positioned(
                      top: 12.041464805603027,
                      left: 4.653281211853027,
                      child: Container(
                          width: 124.93535614013672,
                          height: 10.256065368652344,

                          child: Stack(
                              children: <Widget>[
                                  Positioned(
                                    top: 0.04415157064795494,
                                    left: 0,
                                    child: SvgPicture
                                        .asset(
                                        'assets/body_parts_not_activated/r_finger.svg',
                                        semanticsLabel: 'r_finger'
                                    ),
                                  ),
                                Positioned(
                                    top: 0,
                                    left: 280.93535614013672,
                                    child: Transform(
                                      transform: Matrix4.rotationY(math.pi),
                                      child: SvgPicture
                                          .asset(
                                          'assets/body_parts_not_activated/l_finger.svg',
                                          semanticsLabel: 'l_finger'
                                      ),
                                    ),
                                ),

                              ]
                          )
                      )
                  ), Positioned(
                      top: 2.87992525100708,
                      left: 0,
                      child: Container(
                          width: 260.241455078125,
                          height: 7.10014009475708,

                          child: Stack(
                              children: <Widget>[
                                Positioned(
                                    top: 0.03374946117401123,
                                    left: 0,
                                    child: SvgPicture
                                        .asset(
                                        'assets/body_parts_not_activated/r_thump.svg',
                                        semanticsLabel: 'r_thump'
                                    )
                                ), Positioned(
                                    top: 0,
                                    left: 134.241455078125,
                                    child: Transform(
                                      transform: Matrix4.rotationY(math.pi),
                                      child: SvgPicture
                                          .asset(
                                          'assets/body_parts_not_activated/l_thump.svg',
                                          semanticsLabel: 'l_thump'
                                      ),
                                    )
                                ),
                              ]
                          )
                      )
                  ), Positioned(
                      top: 0,
                      left: 7.501255512237549,
                      child: Container(
                          width: 300.23280334472656,
                          height: 24.91265869140625,

                          child: Stack(
                              children: <Widget>[
                                Positioned(
                                    top: 0.038572054356336594,
                                    left: 0,
                                    child: SvgPicture
                                        .asset(
                                        'assets/body_parts_not_activated/r_palm.svg',
                                        semanticsLabel: 'r_palm'
                                    )
                                ), Positioned(
                                    top: 0,
                                    left: 120.23280334472656,
                                    child: Transform(
                                      transform: Matrix4.rotationY(math.pi),
                                      child: SvgPicture
                                          .asset(
                                          'assets/body_parts_not_activated/l_palm.svg',
                                          semanticsLabel: 'l_palm'
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