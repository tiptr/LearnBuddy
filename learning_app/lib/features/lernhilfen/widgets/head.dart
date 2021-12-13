import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:flutter_svg/flutter_svg.dart';

class Head extends StatelessWidget {
  const Head({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 0,
        left: 52.7802734375,
        child: Container(
            width: 28.46875,
            height: 41.34521484375,
            child: Stack(children: <Widget>[
              Positioned(
                  top: 31.99365234375,
                  left: 0.8994140625,
                  child: Container(
                      width: 26.669921875,
                      height: 9.3515625,
                      child: Stack(children: <Widget>[
                        Positioned(
                            top: 0,
                            left: 0,
                            child: SvgPicture.asset('assets/images/path22.svg',
                                semanticsLabel: 'path22')),
                        Positioned(
                            top: 0,
                            left: 26.669921875,
                            child: Transform.rotate(
                              angle: -180 * (math.pi / 180),
                              child: SvgPicture.asset(
                                  'assets/images/path22.svg',
                                  semanticsLabel: 'path22'),
                            )),
                      ]))),
              Positioned(
                  top: 11.537109375,
                  left: 1.9462890625,
                  child: Container(
                      width: 24.576171875,
                      height: 20.456493377685547,
                      child: Stack(children: <Widget>[
                        Positioned(
                            top: 0,
                            left: 0,
                            child: SvgPicture.asset('assets/images/path24.svg',
                                semanticsLabel: 'path24')),
                        Positioned(
                            top: 0,
                            left: 24.576171875,
                            child: Transform.rotate(
                              angle: -180 * (math.pi / 180),
                              child: SvgPicture.asset(
                                  'assets/images/path24.svg',
                                  semanticsLabel: 'path24'),
                            )),
                      ]))),
              Positioned(
                  top: 16.98681640625,
                  left: 0,
                  child: Container(
                      width: 28.46875,
                      height: 8.252016067504883,
                      child: Stack(children: <Widget>[
                        Positioned(
                            top: 0,
                            left: 0,
                            child: SvgPicture.asset('assets/images/r_ear.svg',
                                semanticsLabel: 'r_ear')),
                        Positioned(
                            top: 0,
                            left: 28.46875,
                            child: Transform.rotate(
                              angle: -180 * (math.pi / 180),
                              child: SvgPicture.asset('assets/images/l_ear.svg',
                                  semanticsLabel: 'l_ear'),
                            )),
                      ]))),
              Positioned(
                  top: 0,
                  left: 2.13671875,
                  child: Container(
                      width: 24.1953125,
                      height: 11.535693168640137,
                      child: Stack(children: <Widget>[
                        Positioned(
                            top: 0,
                            left: 0,
                            child: SvgPicture.asset('assets/images/path28.svg',
                                semanticsLabel: 'path28')),
                        Positioned(
                            top: 0,
                            left: 24.1953125,
                            child: Transform.rotate(
                              angle: -180 * (math.pi / 180),
                              child: SvgPicture.asset(
                                  'assets/images/path28.svg',
                                  semanticsLabel: 'path28'),
                            )),
                      ]))),
            ])));
  }
}
