import 'package:redux/redux.dart';
import 'package:bus/actions/actions.dart';
import 'package:bus/models/Bus.dart';

final updateBusesReducer = combineReducers<List<Bus>>([
  TypedReducer<List<Bus>, UpdateBusAction>(_updateBusesReducer),
]);

List<Bus> _updateBusesReducer(List<Bus> buses, UpdateBusAction action) {
  if (buses.contains(action.bus))
    buses.remove(action.bus);
  else
    buses.add(action.bus);
  return buses;
}
