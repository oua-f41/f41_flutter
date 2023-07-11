import 'package:json_annotation/json_annotation.dart';

import 'event.dart';
import 'user.dart';

part 'event_attendees.g.dart';

@JsonSerializable()
class EventAttendees {
  String? id;
  String? eventId;
  String? userId;
  DateTime? createdAt;
  Event? event;
  User? user;

  EventAttendees(
      {this.id,
      this.eventId,
      this.userId,
      this.createdAt,
      this.event,
      this.user});

  factory EventAttendees.fromJson(Map<String, dynamic> json) =>
      _$EventAttendeesFromJson(json);

  Map<String, dynamic> toJson() => _$EventAttendeesToJson(this);

  EventAttendees copyWith({
    String? id,
    String? eventId,
    String? userId,
    DateTime? createdAt,
    Event? event,
    User? user,
  }) {
    return EventAttendees(
      id: id ?? this.id,
      eventId: eventId ?? this.eventId,
      userId: userId ?? this.userId,
      createdAt: createdAt ?? this.createdAt,
      event: event ?? this.event,
      user: user ?? this.user,
    );
  }
}
