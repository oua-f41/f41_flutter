// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_attendees.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventAttendees _$EventAttendeesFromJson(Map<String, dynamic> json) =>
    EventAttendees(
      id: json['id'] as String?,
      eventId: json['eventId'] as String?,
      userId: json['userId'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      event: json['event'] == null
          ? null
          : Event.fromJson(json['event'] as Map<String, dynamic>),
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$EventAttendeesToJson(EventAttendees instance) =>
    <String, dynamic>{
      'id': instance.id,
      'eventId': instance.eventId,
      'userId': instance.userId,
      'createdAt': instance.createdAt?.toIso8601String(),
      'event': instance.event,
      'user': instance.user,
    };
