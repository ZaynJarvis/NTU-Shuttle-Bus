import 'package:flutter/material.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:bus/env.dart';
import 'dart:async';
import 'package:bus/actions/actions.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:bus/models/AppState.dart';
import 'package:bus/models/BusLocation.dart';

class SchoolMap extends StatelessWidget {
  List<Marker> _buildMarkers(state) {
    List<BusLocation> selectedBuses = [];
    if (state['busesLocation'] != null)
      state['busesLocation'].forEach((locationItem) {
        if ((state['buses'].contains(locationItem.bus)))
          selectedBuses.add(locationItem);
      });
    if (selectedBuses != [])
      return selectedBuses
          .map((BusLocation locationItem) => Marker(
                width: 20.0,
                height: 20.0,
                point: LatLng(
                  locationItem.latitude,
                  locationItem.longitude,
                ),
                builder: (ctx) => Container(
                      child: Icon(
                        Icons.pets,
                        size: 15.0,
                        color: locationItem.bus.color,
                      ),
                    ),
              ))
          .toList();
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Map>(
        onInit: (store) => Timer.periodic(
              Duration(seconds: 10),
              (t) => store.dispatch(UpdateBusLocationRequest()),
            ),
        converter: (Store<AppState> store) => Map.from({
              'buses': store.state.buses,
              'busesLocation': store.state.busesLocation
            }),
        builder: (BuildContext context, Map state) {
          if (state['busesLocation'] != null)
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
                  markers: _buildMarkers(state),
                ),
              ],
            );
          else
            return Center(child: CircularProgressIndicator());
        });
  }
}
