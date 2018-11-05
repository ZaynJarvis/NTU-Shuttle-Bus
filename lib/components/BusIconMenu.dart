import 'package:flutter/material.dart';
import 'package:bus/components/BusIconButton.dart';
import 'package:bus/assets/BusList.dart';
import 'package:bus/env.dart';

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class BusIconMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Widget> buildIconMenu() {
      print(busList);
      var x = busList
          .map((bus) => BusIconButton(
                bus: bus,
              ))
          .toList();
      return x;
    }

    return Container(
      alignment: Alignment(0.0, 0.8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: buildIconMenu(),
      ),
    );
  }
}

Future getComingBus() async {
  final String busAPI =
      'http://datamall2.mytransport.sg/ltaodataservice/BusArrivalv2?BusStopCode=83139';
  final busInfo = await http
      .get(Uri.encodeFull(busAPI), headers: {"AccountKey": GOVDATA_TOKEN});
  List buses = jsonDecode(busInfo.body)['Services'];
  buses.forEach((bus) {
    print(bus['ServiceNo']);
    print(bus['NextBus']['Latitude']);
    print(bus['NextBus']['Longitude']);
    print(bus['NextBus']['EstimatedArrival']);
  });

  return null;
}
