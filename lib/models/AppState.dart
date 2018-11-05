import 'package:bus/models/Bus.dart';
import 'package:flutter/material.dart';
import 'package:bus/models/BusLocation.dart';

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
      buses: [
        Bus(
            id: "red",
            color: Colors.red[300],
            secondaryColor: Colors.redAccent[100])
      ],
      busesLocation: null,
    );
  }

  AppState copyWith({
    List<Bus> buses,
    List<Bus> busesLocation,
  }) {
    return AppState(
      buses: buses ?? this.buses,
      busesLocation: busesLocation ?? this.busesLocation,
    );
  }
}
