import 'package:flutter/material.dart';

import 'package:bus/containers/SchoolMap.dart';
import 'package:bus/components/BusIconMenu.dart';

class ShuttleBusApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          SchoolMap(),
          BusIconMenu(),
        ],
      ),
    );
  }
}
