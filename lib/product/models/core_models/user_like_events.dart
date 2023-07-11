import 'package:json_annotation/json_annotation.dart';

import 'event.dart';
import 'user.dart';

part 'user_like_events.g.dart';

@JsonSerializable()
class UserLikeEvents {
  String? id;
  String? userId;
  String? eventId;
  DateTime? createdAt;
  Event? event;
  User? user;

  UserLikeEvents({this.id, this.userId, this.eventId, this.createdAt});

  factory UserLikeEvents.fromJson(Map<String, dynamic> json) =>
      _$UserLikeEventsFromJson(json);

  Map<String, dynamic> toJson() => _$UserLikeEventsToJson(this);

  UserLikeEvents copyWith({
    String? id,
    String? userId,
    String? eventId,
    DateTime? createdAt,
    Event? event,
    User? user,
  }) {
    return UserLikeEvents(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      eventId: eventId ?? this.eventId,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
