import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:flutter_svg/flutter_svg.dart';

class Shanks extends StatelessWidget {
  const Shanks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 191.580078125,
        left: 36.029296875,
        child: Container(
            width: 61.9697265625,
            height: 38.11598205566406,
            child: Stack(children: <Widget>[
              Positioned(
                  top: 0,
                  left: 0,
                  child: SvgPicture.asset('assets/body_parts_not_activated/r_shank.svg',
                      semanticsLabel: 'r_shank')),
              Positioned(
                  top: 0,
                  left: 61.9697265625,
                  child: Transform(
                    transform: Matrix4.rotationY(math.pi),
                    child: SvgPicture.asset('assets/body_parts_not_activated/l_shank.svg',
                        semanticsLabel: 'l_shank'),
                  )),
            ])));
  }
}
