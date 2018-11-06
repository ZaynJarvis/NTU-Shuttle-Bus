import 'package:bus/models/AppState.dart';
import 'package:bus/reducers/UpdateBusesReducer.dart';
import 'package:bus/reducers/UpdateBusesLocationReducer.dart';
import 'package:bus/reducers/UpdateUserLocationReducer.dart';

AppState appReducer(AppState state, action) {
  return AppState(
    user: updateUserLocationReducer(state.user, action),
    buses: updateBusesReducer(state.buses, action),
    busesLocation: updateBusesLocationReducer(state.busesLocation, action),
  );
}
