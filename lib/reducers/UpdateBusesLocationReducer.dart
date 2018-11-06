import 'package:redux/redux.dart';
import 'package:bus/actions/actions.dart';
import 'package:bus/models/BusLocation.dart';

final updateBusesLocationReducer = combineReducers<List<BusLocation>>([
  TypedReducer<List<BusLocation>, UpdateBusLocationResponse>(
      _updateBusesLocationReducer),
]);

List<BusLocation> _updateBusesLocationReducer(
    List<BusLocation> buses, UpdateBusLocationResponse action) {
  return action.busesLocation;
}
