import 'package:bus/models/Bus.dart';
import 'package:flutter/material.dart';
import 'package:bus/assets/BusList.dart';

@immutable
class AppState {
  final List<Bus> buses;

  AppState({
    this.buses,
  });
  static AppState init() {
    return AppState(
      buses: [busList[0]],
    );
  }

  AppState copyWith({
    List<Bus> buses,
  }) {
    return AppState(
      buses: buses ?? this.buses,
    );
  }
}
