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

  Widget switchIcon(_ViewModel vm) {
    Widget content;
    Color borderColor = Colors.grey;
    vm.buses.contains(bus);
    if (vm.buses != null && vm.buses.contains(bus)) borderColor = Colors.green;
    if (bus.isText)
      content = LayoutBuilder(builder: (context, constraint) {
        return Text(
          bus.name,
          style: TextStyle(
            fontSize: DefaultTextStyle.of(context).style.fontSize * 2,
            color: bus.color,
          ),
        );
      });
    else
      content = LayoutBuilder(builder: (ctx, constraint) {
        return Icon(
          Icons.directions_bus,
          color: bus.color,
          size: IconTheme.of(ctx).size * 2,
        );
      });
    return Container(
      height: 30.0,
      padding: EdgeInsets.all(3.0),
      decoration: BoxDecoration(
        border: Border.all(width: 2.0, color: borderColor),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: GestureDetector(
          child: content,
          onTap: () => vm.callback(bus),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      builder: (BuildContext context, _ViewModel vm) => Container(
            padding: EdgeInsets.all(5.0),
            child: switchIcon(vm),
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
        store.dispatch(UpdateBusLocationRequest());
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
