import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:flutter_svg/flutter_svg.dart';

class Underarms extends StatelessWidget {
  const Underarms({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 95.63946533203125,
        left: 17.281911849975586,
        child: Container(
            width: 99.46150970458984,
            height: 19.50722885131836,
            child: Stack(children: <Widget>[
              Positioned(
                  top: 0,
                  left: 0,
                  child: SvgPicture.asset('assets/images/r_underarm.svg',
                      semanticsLabel: 'r_underarm')),
              Positioned(
                  top: 0.04209478572010994,
                  left: 99.46150970458984,
                  child: Transform(
                    transform: Matrix4.rotationY(math.pi),
                    child: SvgPicture.asset('assets/images/l_underarm.svg',
                        semanticsLabel: 'l_underarm'),
                  )),
            ])));
  }
}
