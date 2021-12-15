import 'dart:ui' as ui;

import 'package:flutter/material.dart';

//Add this CustomPaint widget to the Widget Tree


//Copy this CustomPainter code to the Bottom of the File
class RPSCustomPainter extends CustomPainter {
    @override
    void paint(Canvas canvas, Size size) {
            
Path path_0 = Path();
    path_0.moveTo(size.width*0.1165135,size.height*0.2804660);
    path_0.cubicTo(size.width*0.07355839,size.height*0.3367047,size.width*0.01542034,size.height*0.4846037,0,size.height*0.5768736);
    path_0.lineTo(size.width*0.4444018,size.height);
    path_0.lineTo(size.width,0);
    path_0.cubicTo(size.width*0.9352285,size.height*0.01367921,size.width*0.8525551,size.height*0.01985391,size.width*0.7469605,size.height*0.01997174);
    path_0.cubicTo(size.width*0.6011384,size.height*0.02013671,size.width*0.4861225,size.height*0.03693020,size.width*0.3799971,size.height*0.07355063);
    path_0.cubicTo(size.width*0.3155018,size.height*0.09580839,size.width*0.1706983,size.height*0.2095213,size.width*0.1165135,size.height*0.2804660);
    path_0.close();

Paint paint_0_fill = Paint()..style=PaintingStyle.fill;
paint_0_fill.color = Color.fromRGBO(158,94,225,1.0).withOpacity(1.0);
canvas.drawPath(path_0,paint_0_fill);

}

@override
bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
}
}