import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:bus/middleware/AppMiddlewares.dart';
import 'package:bus/models/AppState.dart';
import 'package:bus/reducers/AppReducer.dart';
import 'package:bus/containers/ShuttleBusApp.dart';

void main() {
  AppState state = AppState.init();
  final store = Store<AppState>(appReducer,
      initialState: state, middleware: createStoreMiddleware());

  runApp(
    StoreProvider(
      store: store,
      child: MaterialApp(
        title: 'NTU Shuttle Bus',
        theme: ThemeData.dark(),
        home: ShuttleBusApp(),
        debugShowCheckedModeBanner: false,
      ),
    ),
  );
}
