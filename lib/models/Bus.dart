import 'package:flutter/material.dart';

@immutable
class Bus {
  final String id;
  final String name;
  final bool isText;
  final Color color;
  final Color secondaryColor;
  final Function callback;
  const Bus(
      {this.color,
      this.secondaryColor,
      this.id,
      this.name,
      this.isText = false,
      this.callback});
  @override
  String toString() {
    return "Bus: $id => $name";
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Bus && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
