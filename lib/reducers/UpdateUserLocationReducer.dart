import 'package:redux/redux.dart';
import 'package:bus/actions/actions.dart';
import 'package:bus/models/User.dart';

final updateUserLocationReducer = combineReducers<User>([
  TypedReducer<User, UpdateUserLocationResponse>(_updateUserLocationReducer),
]);

User _updateUserLocationReducer(User buses, UpdateUserLocationResponse action) {
  return action.user;
}
