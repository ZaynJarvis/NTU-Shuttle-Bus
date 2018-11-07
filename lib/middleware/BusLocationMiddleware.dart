import 'dart:convert';
import 'package:redux/redux.dart';
import 'package:http/http.dart' as http;

import 'package:bus/env.dart';
import 'package:bus/assets/busList.dart';
import 'package:bus/actions/actions.dart';
import 'package:bus/models/AppState.dart';
import 'package:bus/models/Bus.dart';
import 'package:bus/models/BusLocation.dart';

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
            latitude: double.parse(buses[0]['NextBus']['Latitude'] ?? '0.0'),
            longitude: double.parse(buses[0]['NextBus']['Longitude'] ?? '0.0')),
        BusLocation(
            bus: bus,
            latitude: double.parse(buses[0]['NextBus2']['Latitude'] ?? '0.0'),
            longitude:
                double.parse(buses[0]['NextBus2']['Longitude'] ?? '0.0')),
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

Middleware<AppState> updateBusLocationMiddleware() {
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
