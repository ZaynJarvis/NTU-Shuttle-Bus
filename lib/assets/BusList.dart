import 'package:flutter/material.dart';
import 'package:bus/models/Bus.dart';

// Reminder! the id of text-based bus is the stop id.
// Id of color bus is bus id.

final List<Bus> busList = [
  Bus(
      id: "27261",
      name: "179",
      color: Colors.tealAccent,
      secondaryColor: Colors.grey[400],
      isText: true),
  Bus(
      id: "27261",
      name: "179A",
      color: Colors.limeAccent,
      secondaryColor: Colors.grey[400],
      isText: true),
  Bus(
      id: "27199",
      name: "199",
      color: Colors.amberAccent,
      secondaryColor: Colors.grey[400],
      isText: true),
  Bus(
      id: "44478",
      name: "red",
      color: Colors.red[300],
      secondaryColor: Colors.redAccent[100]),
  Bus(
      id: "44479",
      name: "blue",
      color: Colors.blue[300],
      secondaryColor: Colors.blueGrey),
  Bus(
      id: "44480",
      name: "green",
      color: Colors.green[300],
      secondaryColor: Colors.greenAccent[400]),
  Bus(
      id: "44481",
      name: "brown",
      color: Colors.brown[300],
      secondaryColor: Colors.brown[700]),
];
