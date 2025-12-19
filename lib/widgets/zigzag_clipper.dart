import 'package:flutter/material.dart';

class ZigZagClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height);
    
    double x = 0;
    double y = size.height;
    double increment = 15; // Width of one zig-zag
    double heightDiff = 10; // Height of one zig-zag spike

    while (x < size.width) {
      x += increment;
      y = (y == size.height) ? size.height - heightDiff : size.height;
      path.lineTo(x, y);
    }
    
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
