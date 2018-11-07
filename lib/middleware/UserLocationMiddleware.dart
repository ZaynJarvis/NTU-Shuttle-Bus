import 'package:redux/redux.dart';
import 'package:bus/models/AppState.dart';
import 'package:bus/models/User.dart';
import 'package:geolocator/geolocator.dart';
import 'package:bus/actions/actions.dart';

Middleware<AppState> updateUserLocationMiddleware() {
  Future<User> _getUserLocation() async {
    Position user = await Geolocator().getLastKnownPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);
    return User(
      latitude: user?.latitude,
      longitude: user?.longitude,
    );
  }

  return (Store<AppState> store, action, NextDispatcher next) {
    _getUserLocation().then((response) =>
        store.dispatch(UpdateUserLocationResponse(user: response)));
    next(action);
  };
}
