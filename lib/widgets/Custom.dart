import 'package:flutter/material.dart';

class Custom extends CustomClipper<Path> {
  double value;
  Custom(double this.value);
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    Path path = Path();

    path.lineTo(0, size.height / 3 + value);
    path.lineTo(size.width, size.height / 4 + value);
    path.lineTo(size.width, 0);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return oldClipper is Custom && value != oldClipper.value;
  }
}
