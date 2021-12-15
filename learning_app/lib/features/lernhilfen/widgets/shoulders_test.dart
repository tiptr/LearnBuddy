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
  bool _selected = false;

  void changeSelection(){
    setState(() {
      _selected = !_selected;
    });
  }


  @override
  Widget build(BuildContext context) {
      String assetString = _selected ? 'assets/body_parts_activated/l_shoulder.svg' :
                                       'assets/body_parts_not_activated/l_shoulder.svg';
      return Positioned(
          top: 0,
          left: 72.3388671875,
          child: Transform(
            transform: Matrix4.rotationY(math.pi),
            child: ClipPath(
              child: RawMaterialButton(
                onPressed: (){print("Hello");},
                child: Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(color: Colors.blue),
                )
              ),
              clipper: LeftShoulderClipper(),
            ),
          ),
      );

  }


}


class LeftShoulderClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width*0.1165135,size.height*0.2804660);
    path_0.cubicTo(size.width*0.07355839,size.height*0.3367047,size.width*0.01542034,size.height*0.4846037,0,size.height*0.5768736);
    path_0.lineTo(size.width*0.4444018,size.height);
    path_0.lineTo(size.width,0);
    path_0.cubicTo(size.width*0.9352285,size.height*0.01367921,size.width*0.8525551,size.height*0.01985391,size.width*0.7469605,size.height*0.01997174);
    path_0.cubicTo(size.width*0.6011384,size.height*0.02013671,size.width*0.4861225,size.height*0.03693020,size.width*0.3799971,size.height*0.07355063);
    path_0.cubicTo(size.width*0.3155018,size.height*0.09580839,size.width*0.1706983,size.height*0.2095213,size.width*0.1165135,size.height*0.2804660);
    path_0.close();
    return path_0;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
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
