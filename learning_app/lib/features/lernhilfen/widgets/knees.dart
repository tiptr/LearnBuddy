import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:flutter_svg/flutter_svg.dart';

class Knees extends StatelessWidget {
  const Knees({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 182.77685546875,
        left: 39.19140625,
        child: Container(
            width: 55.646484375,
            height: 12.601959228515625,
            child: Stack(children: <Widget>[
              Positioned(
                  top: 0,
                  left: 0,
                  child: SvgPicture.asset('assets/images/r_knee.svg',
                      semanticsLabel: 'r_knee')),
              Positioned(
                  top: 0,
                  left: 55.646484375,
                  child: Transform(
                    transform: Matrix4.rotationY(math.pi),
                    child: SvgPicture.asset('assets/images/l_knee.svg',
                        semanticsLabel: 'l_knee'),
                  )),
            ])));
  }
}
