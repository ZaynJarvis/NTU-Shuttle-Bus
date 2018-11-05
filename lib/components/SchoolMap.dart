import 'package:flutter/material.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:bus/env.dart';

class SchoolMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: new MapOptions(
        center: new LatLng(1.347670, 103.683328),
        zoom: 15.0,
      ),
      layers: [
        new TileLayerOptions(
          urlTemplate: "https://api.tiles.mapbox.com/v4/"
              "{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}",
          additionalOptions: {
            'accessToken': '$MAPBOX_TOKEN',
            'id': 'mapbox.streets',
          },
        ),
        new MarkerLayerOptions(
          markers: [
            new Marker(
              width: 80.0,
              height: 80.0,
              point: new LatLng(1.347670, 103.683328),
              builder: (ctx) => new Container(
                    child: Icon(
                      Icons.pets,
                      color: Colors.yellowAccent,
                    ),
                  ),
            ),
          ],
        ),
      ],
    );
  }
}
