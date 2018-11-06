import 'package:flutter/material.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:bus/env.dart';

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:bus/models/AppState.dart';
import 'package:bus/models/Bus.dart';

class SchoolMap extends StatelessWidget {
  Map _findLocation(Map info) {
    return {
      'lat': info['Latitude'],
      'long': info['Longitude'],
      'arrive_time': info['EstimatedArrival'],
    };
  }

  Future<List<Map>> _getComingBus(busID) async {
    Map<String, String> searchStop = {"199": "27199", "179": "27261"};
    final String busAPI =
        'http://datamall2.mytransport.sg/ltaodataservice/BusArrivalv2?BusStopCode=${searchStop[busID]}&ServiceNo=$busID';
    final busInfo = await http
        .get(Uri.encodeFull(busAPI), headers: {"AccountKey": GOVDATA_TOKEN});
    List buses = jsonDecode(busInfo.body)['Services'];
    if (buses.isNotEmpty) {
      return [
        _findLocation(buses[0]['NextBus']),
        _findLocation(buses[0]['NextBus2']),
        _findLocation(buses[0]['NextBus3'])
      ];
    }
    return [];
  }

  Future<Map> _getMarkers(List<Bus> searchBuses) async {
    List<Map> markers = [];
    await Future.forEach(searchBuses, (Bus searchBusItem) async {
      List<Map> busInfoAll = await _getComingBus(searchBusItem.id);
      busInfoAll.forEach((busInfo) {
        if (busInfo['lat'] != '0')
          markers.add({
            'lat': busInfo['lat'],
            'long': busInfo['long'],
            'color': searchBusItem.color,
          });
      });
    });
    return Map.from({'status': 'success', 'markers': markers});
  }

  List<Marker> _buildMarkers(List<Map> markerPoints) {
    if (markerPoints != [])
      return markerPoints
          .map((Map markerItem) => Marker(
                width: 20.0,
                height: 20.0,
                point: LatLng(
                  double.parse(markerItem['lat']),
                  double.parse(markerItem['long']),
                ),
                builder: (ctx) => Container(
                      child: Icon(
                        Icons.pets,
                        size: 15.0,
                        color: markerItem['color'],
                      ),
                    ),
              ))
          .toList();
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, List<Bus>>(
      converter: (Store<AppState> store) => store.state.buses,
      builder: (BuildContext context, List<Bus> buses) => FutureBuilder(
          future: _getMarkers(buses),
          builder: (BuildContext context, AsyncSnapshot<Map> snapshot) {
            if (!snapshot.hasData)
              return Center(
                child: CircularProgressIndicator(),
              );
            return FlutterMap(
              options: MapOptions(
                center: LatLng(1.347670, 103.683328),
                zoom: 15.0,
              ),
              layers: [
                TileLayerOptions(
                  urlTemplate: "https://api.tiles.mapbox.com/v4/"
                      "{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}",
                  additionalOptions: {
                    'accessToken': '$MAPBOX_TOKEN',
                    'id': 'mapbox.dark',
                  },
                ),
                MarkerLayerOptions(
                  markers: _buildMarkers(snapshot.data['markers']),
                ),
              ],
            );
          }),
    );
  }
}
