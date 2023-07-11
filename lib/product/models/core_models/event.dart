import 'package:connectopia/product/models/core_models/user_like_events.dart';
import 'package:json_annotation/json_annotation.dart';

import 'city.dart';
import 'event_attendees.dart';
import 'group.dart';

part 'event.g.dart';

@JsonSerializable()
class Event {
  String? id;
  String? name;
  String? description;
  String? groupId;
  String? cityId;
  DateTime? createdAt;
  DateTime? eventDate;
  String? eventLat;
  String? eventLng;
  String? eventPhotoUrl;
  String? eventAddress;
  City? city;
  Group? group;
  List<EventAttendees>? eventAttendees;
  List<UserLikeEvents>? userLikeEvents;

  Event(
      {this.id,
      this.name,
      this.description,
      this.groupId,
      this.cityId,
      this.createdAt,
      this.eventDate,
      this.eventLat,
      this.eventLng,
      this.eventAddress,
      this.eventPhotoUrl,
      this.city,
      this.group,
      this.eventAttendees,
      this.userLikeEvents});

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);

  Map<String, dynamic> toJson() => _$EventToJson(this);
}
