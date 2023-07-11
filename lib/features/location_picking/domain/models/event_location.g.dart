// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_location.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventLocation _$EventLocationFromJson(Map<String, dynamic> json) =>
    EventLocation(
      city: json['city'] as String?,
      address: json['address'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$EventLocationToJson(EventLocation instance) =>
    <String, dynamic>{
      'city': instance.city,
      'address': instance.address,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
