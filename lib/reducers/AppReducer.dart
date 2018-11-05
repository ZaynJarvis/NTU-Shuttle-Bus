import 'package:bus/models/AppState.dart';
import 'package:bus/reducers/UpdateBusesReducer.dart';
import 'package:bus/reducers/GetBusesLocationReducer.dart';

AppState appReducer(AppState state, action) {
  return AppState(
    buses: updateBusesReducer(state.buses, action),
    busesLocation: getBusesLocationReducer(state.busesLocation, action),
  );
}
