import 'package:bus/models/Bus.dart';

class BusLocation {
  String id;
  Bus bus;
  double latitude;
  double longitude;
  BusLocation({this.bus, this.latitude, this.longitude});
  @override
  String toString() {
    return "Bus: $bus at ($latitude, $longitude)";
  }
}
