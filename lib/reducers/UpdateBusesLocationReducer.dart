import 'package:redux/redux.dart';
import 'package:bus/actions/actions.dart';
import 'package:bus/models/BusLocation.dart';

final updateBusesLocationReducer = combineReducers<List<BusLocation>>([
  TypedReducer<List<BusLocation>, UpdateBusLocationResponse>(
      _updateBusesLocationReducer),
]);

List<BusLocation> _updateBusesLocationReducer(
    List<BusLocation> busesLocation, UpdateBusLocationResponse action) {
  if (busesLocation != null && busesLocation.isNotEmpty) {
    if (action.busesLocation != null && action.busesLocation.isNotEmpty) {
      busesLocation = busesLocation
          .where(
              (busLocation) => busLocation.bus != action.busesLocation[0].bus)
          .toList();
      return busesLocation..addAll(action.busesLocation);
    }
    return busesLocation;
  }
  return action.busesLocation;
}
