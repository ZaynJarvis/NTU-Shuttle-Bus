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
  List<Marker> _buildMarkers(AppState state) {
    List<Marker> busResult = [];
    List<BusLocation> selectedBuses = [];
    if (state.busesLocation != null)
      state.busesLocation.forEach((locationItem) {
        if ((state.buses.contains(locationItem.bus)))
          selectedBuses.add(locationItem);
      });
    if (selectedBuses != [])
      busResult = selectedBuses
          .map(
            (BusLocation locationItem) => Marker(
                  width: 20.0,
                  height: 20.0,
                  point: LatLng(
                    locationItem?.latitude ?? 0.0,
                    locationItem?.longitude ?? 0.0,
                  ),
                  builder: (ctx) => Container(
                        child: Icon(
                          Icons.pets,
                          size: 15.0,
                          color: locationItem.bus.color,
                        ),
                      ),
                ),
          )
          .toList();
    busResult
      ..add(Marker(
        width: 20.0,
        height: 20.0,
        point: LatLng(
          state.user?.latitude ?? 0.0,
          state.user?.longitude ?? 0.0,
        ),
        builder: (ctx) => Container(
              child: Icon(
                Icons.person_pin_circle,
                size: 15.0,
                color: Colors.white,
              ),
            ),
      ));
    return busResult;
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
        onInit: (store) => Timer.periodic(
              Duration(seconds: 10),
              (t) {
                store.dispatch(UpdateBusLocationRequest());
                store.dispatch(UpdateUserLocationRequest());
              },
            ),
        converter: (Store<AppState> store) => store.state,
        builder: (BuildContext context, AppState state) {
          if (state.busesLocation != null)
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
