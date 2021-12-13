import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:flutter_svg/flutter_svg.dart';

class UpperArms extends StatelessWidget {
  const UpperArms({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 58.2119140625,
        left: 21.869140625,
        child: Container(
            width: 90.2900390625,
            height: 35.797489166259766,
            child: Stack(children: <Widget>[
              Positioned(
                  top: 0,
                  left: 0,
                  child: SvgPicture.asset('assets/body_parts_not_activated/r_upper_arm.svg',
                      semanticsLabel: 'r_upper_arm')),
              Positioned(
                  top: 0,
                  left: 90.2900390625,
                  child: Transform(
                    transform: Matrix4.rotationY(math.pi),
                    child: SvgPicture.asset('assets/body_parts_not_activated/l_upper_arm.svg',
                        semanticsLabel: 'l_upper_arm'),
                  )),
            ])));
  }
}
