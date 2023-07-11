// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_like_events.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserLikeEvents _$UserLikeEventsFromJson(Map<String, dynamic> json) =>
    UserLikeEvents(
      id: json['id'] as String?,
      userId: json['userId'] as String?,
      eventId: json['eventId'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    )
      ..event = json['event'] == null
          ? null
          : Event.fromJson(json['event'] as Map<String, dynamic>)
      ..user = json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>);

Map<String, dynamic> _$UserLikeEventsToJson(UserLikeEvents instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'eventId': instance.eventId,
      'createdAt': instance.createdAt?.toIso8601String(),
      'event': instance.event,
      'user': instance.user,
    };
