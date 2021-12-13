import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:flutter_svg/flutter_svg.dart';

class Wrists extends StatelessWidget {
  const Wrists({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 109.84512329101562,
        left: 14.562360763549805,
        child: Container(
            width: 104.88976287841797,
            height: 14.002617835998535,
            child: Stack(children: <Widget>[
              Positioned(
                  top: 0.00677620992064476,
                  left: 0,
                  child: SvgPicture.asset('assets/images/r_wrist.svg',
                      semanticsLabel: 'r_wrist')),
              Positioned(
                  top: 0,
                  left: 104.88976287841797,
                  child: Transform(
                    transform: Matrix4.rotationY(math.pi),
                    child: SvgPicture.asset('assets/images/l_wrist.svg',
                        semanticsLabel: 'l_wrist'),
                  )),
            ])));
  }
}
