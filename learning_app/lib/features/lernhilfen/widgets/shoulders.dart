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
            child: Stack(children: const <Widget>[
              RightShoulder(),
              LeftShoulder(),
            ])));
  }
}

class LeftShoulder extends StatefulWidget {
  const LeftShoulder({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _LeftShoulderState();
  }
}

class _LeftShoulderState extends State<LeftShoulder> {
  bool _selected = true;

  void changeSelection(){
    setState(() {
      _selected = !_selected;
    });
  }


  @override
  Widget build(BuildContext context) {
      String selectedString = _selected ? '' : 'not_';
      return Positioned(
          top: 0,
          left: 72.3388671875,
          child: InkWell(
            child: Transform(
              transform: Matrix4.rotationY(math.pi),
              child: SvgPicture.asset('assets/body_parts_${selectedString}activated/l_shoulder.svg',
                  semanticsLabel: 'l_shoulder'),
            ),
            onTap: () => print("dskjhflkdjf"),
          ));

  }


}

class RightShoulder extends StatelessWidget {
  const RightShoulder({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 0,
        left: 0,
        child: SvgPicture.asset('assets/body_parts_not_activated/r_shoulder.svg',
              semanticsLabel: 'r_shoulder'),
        );
  }
}
