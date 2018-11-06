import 'package:flutter/material.dart';
import 'package:bus/components/BusIconButton.dart';
import 'package:bus/assets/BusList.dart';

class BusIconMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(0.0, 0.8),
      child: Container(
        height: 100.0,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: busList.length,
          itemBuilder: (BuildContext context, int index) => BusIconButton(
                bus: busList[index],
              ),
        ),
      ),
    );
  }
}
