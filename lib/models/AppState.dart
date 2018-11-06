import 'package:flutter/material.dart';
import 'package:bus/models/Bus.dart';
import 'package:bus/models/User.dart';
import 'package:bus/models/BusLocation.dart';
import 'package:bus/assets/BusList.dart';

@immutable
class AppState {
  final List<Bus> buses;
  final List<BusLocation> busesLocation;
  final User user;

  AppState({
    this.user,
    this.buses,
    this.busesLocation,
  });
  static AppState init() {
    return AppState(
      user: null,
      buses: [busList[0]],
      busesLocation: null,
    );
  }

  AppState copyWith({
    User user,
    List<Bus> buses,
    List<BusLocation> busesLocation,
  }) {
    return AppState(
      user: user ?? this.user,
      buses: buses ?? this.buses,
      busesLocation: busesLocation ?? this.busesLocation,
    );
  }

  @override
  int get hashCode => buses.hashCode ^ busesLocation.hashCode ^ user.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppState &&
          runtimeType == other.runtimeType &&
          user == this.user &&
          buses == this.buses &&
          busesLocation == this.busesLocation;
}
