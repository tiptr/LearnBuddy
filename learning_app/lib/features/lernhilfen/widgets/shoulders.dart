import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:flutter_svg/flutter_svg.dart';

class Shoulders extends StatelessWidget {
  const Shoulders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 41.34521484375,
        left: 30.8447265625,
        child: Container(
            width: 72.3388671875,
            height: 29.23790740966797,
            child: Stack(children: <Widget>[
              Positioned(
                  top: 0,
                  left: 0,
                  child: SvgPicture.asset('assets/images/r_shoulder.svg',
                      semanticsLabel: 'r_shoulder')),
              Positioned(
                  top: 0,
                  left: 72.3388671875,
                  child: Transform(
                    transform: Matrix4.rotationY(math.pi),
                    child: SvgPicture.asset('assets/images/l_shoulder.svg',
                        semanticsLabel: 'l_shoulder'),
                  )),
            ])));
  }
}
