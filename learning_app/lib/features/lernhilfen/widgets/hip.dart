import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:flutter_svg/flutter_svg.dart';

class Hip extends StatelessWidget {
  const Hip({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 120.4384765625,
        left: 38.2109375,
        child: Container(
            width: 57.6064453125,
            height: 27.690467834472656,
            child: Stack(children: <Widget>[
              Positioned(
                  top: 0,
                  left: 0,
                  child: SvgPicture.asset('assets/body_parts_not_activated/path30.svg',
                      semanticsLabel: 'path30')),
              Positioned(
                  top: 0,
                  left: 57.6064453125,
                  child: Transform(
                    transform: Matrix4.rotationY(math.pi),
                    child: SvgPicture.asset('assets/body_parts_not_activated/path30.svg',
                        semanticsLabel: 'path30'),
                  )),
            ])));
  }
}
