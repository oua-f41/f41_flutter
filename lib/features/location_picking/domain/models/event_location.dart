import 'package:json_annotation/json_annotation.dart';

part 'event_location.g.dart';

@JsonSerializable()
class EventLocation {
  String? city;
  String? address;
  double? latitude;
  double? longitude;

  EventLocation({this.city, this.address, this.latitude, this.longitude});
}
