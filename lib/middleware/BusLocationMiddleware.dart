import 'package:redux/redux.dart';

import 'package:bus/assets/busList.dart';
import 'package:bus/actions/actions.dart';
import 'package:bus/models/AppState.dart';
import 'package:bus/models/Bus.dart';
import 'package:bus/models/BusLocation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Middleware<AppState> updateBusLocationMiddleware() {
  print(1);
  return (Store<AppState> store, action, NextDispatcher next) {
    for (Bus busItem in busList) {
      Firestore.instance.collection(busItem.name).snapshots().listen((data) {
        List<BusLocation> busesLocation = data.documents
            .map((fbBus) => BusLocation(
                  bus: busItem,
                  direction: fbBus['direction'].toDouble(),
                  latitude: fbBus['latitude'],
                  longitude: fbBus['longitude'],
                ))
            .toList();
        print(busesLocation);
        store.dispatch(UpdateBusLocationResponse(busesLocation: busesLocation));
      });
    }
  };
}
