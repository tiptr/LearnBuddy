import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:flutter_svg/flutter_svg.dart';

class Breasts extends StatelessWidget {
  const Breasts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 41.34521484375,
        left: 40.9931640625,
        child: Container(
            width: 52.04296875,
            height: 42.03812789916992,
            child: Stack(children: <Widget>[
              Positioned(
                  top: 0,
                  left: 0,
                  child: SvgPicture.asset('assets/images/path18.svg',
                      semanticsLabel: 'path18')),
              Positioned(
                  top: 0,
                  left: 52.04296875,
                  child: Transform.rotate(
                    angle: -180 * (math.pi / 180),
                    child: SvgPicture.asset('assets/images/path18.svg',
                        semanticsLabel: 'path18'),
                  )),
            ])));
  }
}
