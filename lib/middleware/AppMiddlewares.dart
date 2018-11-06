import 'package:redux/redux.dart';
import 'package:bus/models/Appstate.dart';
import 'package:bus/models/BusLocation.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bus/env.dart';
import 'package:bus/actions/actions.dart';
import 'package:bus/assets/busList.dart';

List<Middleware<AppState>> createStoreMiddleware() {
  final updateBusLocationMiddleware = _updateBusLocationMiddleware();
  return [
    TypedMiddleware<AppState, UpdateBusLocationRequest>(
        updateBusLocationMiddleware),
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
            latitude: buses[0]['NextBus']['Latitude'],
            longitude: buses[0]['NextBus']['Longitude']),
        BusLocation(
            bus: bus,
            latitude: buses[0]['NextBus2']['Latitude'],
            longitude: buses[0]['NextBus']['Longitude']),
        BusLocation(
            bus: bus,
            latitude: buses[0]['NextBus3']['Latitude'],
            longitude: buses[0]['NextBus']['Longitude']),
      ];
    }
  } else {
    final busInfo = await http.get(Uri.encodeFull(colorBusAPI));
    List buses = jsonDecode(busInfo.body)['vehicles'];
    if (buses.isNotEmpty) {
      return buses
          .map((busItem) => BusLocation(
              bus: bus, latitude: busItem['lat'], longitude: busItem['lon']))
          .toList();
    }
  }
  return [];
}

Middleware<AppState> _updateBusLocationMiddleware() {
  Future<List<BusLocation>> _getAllBuses() async {
    List result = [];
    Future.forEach(busList, (bus) async {
      result.add(_updateBusLocation(bus));
    });
    return result;
  }

  return (Store<AppState> store, action, NextDispatcher next) {
    _getAllBuses().then((response) =>
        store.dispatch(UpdateBusLocationResponse(busesLocation: response)));
    next(action);
  };
}
