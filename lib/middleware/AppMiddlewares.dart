import 'package:redux/redux.dart';
import 'package:bus/models/AppState.dart';
import 'package:bus/models/BusLocation.dart';
import 'package:bus/models/Bus.dart';
import 'package:bus/models/User.dart';
import 'dart:async';
import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:bus/env.dart';
import 'package:bus/actions/actions.dart';
import 'package:bus/assets/busList.dart';

List<Middleware<AppState>> createStoreMiddleware() {
  final updateUserLocationMiddleware = _updateUserLocationMiddleware();
  final updateBusLocationMiddleware = _updateBusLocationMiddleware();
  final initBusLocationMiddleware = _initBusLocationMiddleware();
  return [
    TypedMiddleware<AppState, UpdateBusLocationRequest>(
        updateBusLocationMiddleware),
    TypedMiddleware<AppState, InitBusLocationRequest>(
        initBusLocationMiddleware),
    TypedMiddleware<AppState, UpdateUserLocationRequest>(
        updateUserLocationMiddleware),
  ];
}

Future<List<BusLocation>> _updateBusLocation(bus) async {
  final String colorBusAPI =
      'https://baseride.com/routes/apigeo/routevariantvehicle/${bus.id}/?format=json';
  final String busAPI =
      'http://datamall2.mytransport.sg/ltaodataservice/BusArrivalv2?BusStopCode=${bus.id}&ServiceNo=${bus.name}';

  if (bus.isText) {
    final busInfo = await http
        .get(Uri.encodeFull(busAPI), headers: {"AccountKey": GOVDATA_TOKEN});
    List buses = jsonDecode(busInfo.body)['Services'];
    if (buses.isNotEmpty) {
      return [
        BusLocation(
            bus: bus,
            latitude: double.parse(buses[0]['NextBus']['Latitude'] ?? '0'),
            longitude: double.parse(buses[0]['NextBus']['Longitude'] ?? '0')),
        BusLocation(
            bus: bus,
            latitude: double.parse(buses[0]['NextBus2']['Latitude'] ?? '0'),
            longitude: double.parse(buses[0]['NextBus2']['Longitude'] ?? '0')),
      ];
    }
  } else {
    final busInfo = await http.get(Uri.encodeFull(colorBusAPI));
    List buses = jsonDecode(busInfo.body)['vehicles'];
    if (buses.isNotEmpty) {
      return buses
          .map((busItem) => BusLocation(
              bus: bus,
              latitude: double.parse(busItem['lat']),
              longitude: double.parse(busItem['lon'])))
          .toList();
    }
  }
  return null;
}

Middleware<AppState> _initBusLocationMiddleware() {
  Future<List<BusLocation>> _updateAllBuses() async {
    List<BusLocation> result = [];
    List<BusLocation> busLocation = await _updateBusLocation(busList[0]);
    if (busLocation != null) result.addAll(busLocation);
    return result;
  }

  return (Store<AppState> store, action, NextDispatcher next) {
    _updateAllBuses().then((response) =>
        store.dispatch(UpdateBusLocationResponse(busesLocation: response)));
    next(action);
  };
}

Middleware<AppState> _updateBusLocationMiddleware() {
  Stream<List<BusLocation>> _updateAllBuses() async* {
    for (Bus busItem in busList) {
      List<BusLocation> busLocation = await _updateBusLocation(busItem);
      yield busLocation;
    }
  }

  return (Store<AppState> store, action, NextDispatcher next) {
    _updateAllBuses().listen((response) =>
        store.dispatch(UpdateBusLocationResponse(busesLocation: response)));
    next(action);
  };
}

Middleware<AppState> _updateUserLocationMiddleware() {
  Future<User> _getUserLocation() async {
    Position user = await Geolocator().getLastKnownPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);
    return User(
      latitude: user.latitude,
      longitude: user.longitude,
    );
  }

  return (Store<AppState> store, action, NextDispatcher next) {
    _getUserLocation().then((response) =>
        store.dispatch(UpdateUserLocationResponse(user: response)));
    next(action);
  };
}
