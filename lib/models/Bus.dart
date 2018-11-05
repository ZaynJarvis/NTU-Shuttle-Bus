import 'package:flutter/material.dart';

@immutable
class Bus {
  final String id;
  final bool isText;
  final Color color;
  final Color secondaryColor;
  final Function callback;
  const Bus(
      {this.color,
      this.secondaryColor,
      this.id,
      this.isText = false,
      this.callback});
}
