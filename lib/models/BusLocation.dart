import 'package:bus/models/Bus.dart';

class BusLocation {
  String id;
  Bus bus;
  double direction;
  double latitude;
  double longitude;
  BusLocation({this.bus, this.latitude, this.longitude, this.direction});
  @override
  String toString() {
    return "Bus: $bus at ($latitude, $longitude) along $direction";
  }
}
