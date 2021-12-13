import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:flutter_svg/flutter_svg.dart';

class Waist extends StatelessWidget {
  const Waist({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 83.38330078125,
        left: 42.056640625,
        child: Container(
            width: 49.916015625,
            height: 38.18794250488281,
            child: Stack(children: <Widget>[
              Positioned(
                  top: 0,
                  left: 0,
                  child: SvgPicture.asset('assets/images/path20.svg',
                      semanticsLabel: 'path20')),
              Positioned(
                  top: 0,
                  left: 49.916015625,
                  child: Transform(
                    transform: Matrix4.rotationY(math.pi),
                    child: SvgPicture.asset('assets/images/path20.svg',
                        semanticsLabel: 'path20'),
                  )),
            ])));
  }
}
