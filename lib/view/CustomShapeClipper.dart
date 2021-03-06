import 'package:flutter/material.dart';

class CustomShapeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();
    path.lineTo(0.0, size.height*0.7);
    
    var firstEndPoint = Offset(size.width, size.height*.7);
    var firstControlpoint = Offset(size.width*.5,size.height*.8);
    path.quadraticBezierTo(firstControlpoint.dx, firstControlpoint.dy, firstEndPoint.dx, firstEndPoint.dy);

    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) =>  true;

}