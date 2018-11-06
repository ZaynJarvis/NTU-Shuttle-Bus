import 'package:bus/models/Bus.dart';
import 'package:bus/models/BusLocation.dart';

class UpdateBusAction {
  final Bus bus;
  UpdateBusAction(this.bus);
}

class GetBusesLocationAction {
  final List<BusLocation> busesLocation;
  GetBusesLocationAction(this.busesLocation);
}

class UpdateBusLocationRequest {}

class UpdateBusLocationResponse {
  List<BusLocation> busesLocation;
  UpdateBusLocationResponse({this.busesLocation});
}
