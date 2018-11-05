import 'package:flutter/material.dart';
import 'package:bus/models/Bus.dart';

import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:bus/actions/actions.dart';
import 'package:bus/models/AppState.dart';

class BusIconButton extends StatelessWidget {
  final Bus bus;

  BusIconButton({
    @required this.bus,
  });

  Widget switchIcon(List<Bus> buses) {
    Color iconColor = bus.secondaryColor;
    if (buses != null && buses.contains(bus)) iconColor = bus.color;
    if (bus.isText) return Text(bus.id);
    return Icon(
      Icons.directions_bus,
      color: iconColor,
      size: 40.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      builder: (BuildContext context, _ViewModel vm) => Container(
            child: InkWell(
              child: switchIcon(vm.buses),
              splashColor: Colors.black,
              onTap: () => vm.callback(bus),
              highlightColor: Colors.black,
            ),
          ),
    );
  }
}

class _ViewModel {
  final Function(Bus) callback;
  final List<Bus> buses;

  _ViewModel({
    @required this.callback,
    @required this.buses,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      callback: (bus) {
        store.dispatch(UpdateBusAction(
          bus,
        ));
      },
      buses: store.state.buses,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _ViewModel &&
          runtimeType == other.runtimeType &&
          buses == other.buses;

  @override
  int get hashCode => buses.hashCode;
}
