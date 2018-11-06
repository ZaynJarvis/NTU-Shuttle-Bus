import 'package:flutter/material.dart';
import 'package:bus/models/Bus.dart';
import 'package:bus/models/BusLocation.dart';
import 'package:bus/assets/BusList.dart';

@immutable
class AppState {
  final List<Bus> buses;
  final List<BusLocation> busesLocation;

  AppState({
    this.buses,
    this.busesLocation,
  });
  static AppState init() {
    return AppState(
      buses: [busList[0]],
    );
  }

  AppState copyWith({
    List<Bus> buses,
    List<BusLocation> busesLocation,
  }) {
    return AppState(
      buses: buses ?? this.buses,
      busesLocation: busesLocation ?? this.busesLocation,
    );
  }
}
