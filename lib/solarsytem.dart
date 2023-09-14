import 'dart:math';

import 'package:flutter/material.dart';


class OrbitAnimation extends StatefulWidget {
  const OrbitAnimation({Key? key}) : super(key: key);

  @override
  State<OrbitAnimation> createState() => _OrbitAnimationState();
}

class _OrbitAnimationState extends State<OrbitAnimation> with SingleTickerProviderStateMixin {
  
  late AnimationController _animationController;
  @override
  void initState() {
   _animationController=
       AnimationController(vsync: this, duration: Duration(seconds: 10),
       upperBound: 2*pi);
   _animationController.addListener(() {
     setState(() {});

   });
   _animationController.forward();
   _animationController.repeat();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: InteractiveViewer(
        maxScale: 10,
        child: CustomPaint(
          painter: OrbitPainter(_animationController),
          child: Container(),

        ),
      ),
    );
  }
}
class OrbitPainter extends CustomPainter{
  final Animation<double> animation;

  OrbitPainter(this.animation);

  @override
  void paint(Canvas canvas, Size size) {
    final sunpaint=Paint()..color=Colors.yellow..strokeWidth=15;
    final orbitpaint=Paint()..color=Colors.grey.withOpacity(0.5)..style=PaintingStyle.stroke;
    final earthpaint=Paint()..color=Colors.blue.withOpacity(0.9);

    const earthRadius=20.0;


   //
   // canvas.drawLine(Offset(100, 200), Offset(200, 200), sunpaint);
   canvas.drawCircle(Offset(size.width/2, size.height/2),100, sunpaint);
   canvas.drawCircle(Offset(size.width/2, size.height/2), 200, orbitpaint);
   canvas.drawCircle(Offset(size.width/2+200*cos(animation.value),
       size.height/2+200*sin(animation.value)),
       earthRadius,
       earthpaint);


  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}
