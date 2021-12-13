import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:flutter_svg/flutter_svg.dart';

class Elbows extends StatelessWidget {
  const Elbows({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 89.51927947998047,
        left: 19.822505950927734,
        child: Container(
            width: 94.38938903808594,
            height: 11.872296333312988,
            child: Stack(children: <Widget>[
              Positioned(
                  top: 0,
                  left: 0,
                  child: SvgPicture.asset('assets/images/r_ellbow.svg',
                      semanticsLabel: 'r_ellbow')),
              Positioned(
                  top: 0.06029230356216431,
                  left: 94.38938903808594,
                  child: Transform(
                    transform: Matrix4.rotationY(math.pi),
                    child: SvgPicture.asset('assets/images/l_ellbow.svg',
                        semanticsLabel: 'l_ellbow'),
                  )),
            ])));
  }
}
