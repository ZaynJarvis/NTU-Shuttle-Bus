import 'package:flutter/material.dart';
import 'dart:math';

class MarkerIcon extends StatelessWidget {
  final Color color;
  final String object;
  final num rotate;
  MarkerIcon({this.color = Colors.white, this.object = 'bus', this.rotate = 0});

  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: new Matrix4.rotationZ(atan(rotate)),
      alignment: FractionalOffset.center,
      child: Container(
        child: Icon(
          object == 'user' ? Icons.person_pin_circle : Icons.pets,
          size: 15.0,
          color: color,
        ),
      ),
    );
  }
}
