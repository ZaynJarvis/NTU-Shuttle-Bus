import 'package:redux/redux.dart';
import 'package:bus/actions/actions.dart';
import 'package:bus/models/BusLocation.dart';

final getBusesLocationReducer = combineReducers<List<BusLocation>>([
  TypedReducer<List<BusLocation>, GetBusesLocationAction>(
      _getBusesLocationReducer),
]);

List<BusLocation> _getBusesLocationReducer(
    List<BusLocation> buses, GetBusesLocationAction action) {
  return buses..addAll(action.busesLocation);
}
