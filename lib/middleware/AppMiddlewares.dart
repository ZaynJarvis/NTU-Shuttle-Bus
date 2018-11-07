import 'package:redux/redux.dart';
import 'package:bus/models/AppState.dart';
import 'package:bus/actions/actions.dart';
import 'package:bus/middleware/BusLocationMiddleware.dart';
import 'package:bus/middleware/UserLocationMiddleware.dart';

List<Middleware<AppState>> createStoreMiddleware() {
  return [
    TypedMiddleware<AppState, UpdateBusLocationRequest>(
        updateBusLocationMiddleware()),
    TypedMiddleware<AppState, UpdateUserLocationRequest>(
        updateUserLocationMiddleware()),
  ];
}
