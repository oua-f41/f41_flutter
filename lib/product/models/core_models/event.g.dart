// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Event _$EventFromJson(Map<String, dynamic> json) => Event(
      id: json['id'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      groupId: json['groupId'] as String?,
      cityId: json['cityId'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      eventDate: json['eventDate'] == null
          ? null
          : DateTime.parse(json['eventDate'] as String),
      eventLat: json['eventLat'] as String?,
      eventLng: json['eventLng'] as String?,
      eventAddress: json['eventAddress'] as String?,
      eventPhotoUrl: json['eventPhotoUrl'] as String?,
      city: json['city'] == null
          ? null
          : City.fromJson(json['city'] as Map<String, dynamic>),
      group: json['group'] == null
          ? null
          : Group.fromJson(json['group'] as Map<String, dynamic>),
      eventAttendees: (json['eventAttendees'] as List<dynamic>?)
          ?.map((e) => EventAttendees.fromJson(e as Map<String, dynamic>))
          .toList(),
      userLikeEvents: (json['userLikeEvents'] as List<dynamic>?)
          ?.map((e) => UserLikeEvents.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$EventToJson(Event instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'groupId': instance.groupId,
      'cityId': instance.cityId,
      'createdAt': instance.createdAt?.toIso8601String(),
      'eventDate': instance.eventDate?.toIso8601String(),
      'eventLat': instance.eventLat,
      'eventLng': instance.eventLng,
      'eventPhotoUrl': instance.eventPhotoUrl,
      'eventAddress': instance.eventAddress,
      'city': instance.city,
      'group': instance.group,
      'eventAttendees': instance.eventAttendees,
      'userLikeEvents': instance.userLikeEvents,
    };
