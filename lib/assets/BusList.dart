import 'package:flutter/material.dart';
import 'package:bus/models/Bus.dart';

final List<Bus> busList = [
  Bus(id: "179", color: Colors.grey, secondaryColor: Colors.grey, isText: true),
  Bus(id: "199", color: Colors.grey, secondaryColor: Colors.grey, isText: true),
  Bus(id: "red", color: Colors.red[300], secondaryColor: Colors.redAccent[100]),
  Bus(id: "blue", color: Colors.blue[300], secondaryColor: Colors.blueGrey),
  Bus(id: "brown", color: Colors.brown[300], secondaryColor: Colors.brown[700]),
  Bus(
      id: "green",
      color: Colors.green[300],
      secondaryColor: Colors.greenAccent[400]),
];
