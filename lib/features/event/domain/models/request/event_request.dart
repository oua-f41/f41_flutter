// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'event_request.g.dart';

@JsonSerializable(createFactory: false)
class EventRequest {
  String? name;
  String? description;
  String? groupId;
  String? cityId;
  String? eventDate;
  String? eventLat;
  String? eventLng;
  String? eventAddress;
  String? eventPhotoUrl;

  EventRequest({
    this.name,
    this.description,
    this.groupId,
    this.cityId,
    this.eventDate,
    this.eventLat,
    this.eventLng,
    this.eventAddress,
    this.eventPhotoUrl = "",
  });

  Map<String, dynamic> toJson() => _$EventRequestToJson(this);

  EventRequest copyWith({
    String? name,
    String? description,
    String? groupId,
    String? cityId,
    String? eventDate,
    String? eventLat,
    String? eventLng,
    String? eventAddress,
    String? eventPhotoUrl,
  }) {
    return EventRequest(
      name: name ?? this.name,
      description: description ?? this.description,
      groupId: groupId ?? this.groupId,
      cityId: cityId ?? this.cityId,
      eventDate: eventDate ?? this.eventDate,
      eventLat: eventLat ?? this.eventLat,
      eventLng: eventLng ?? this.eventLng,
      eventAddress: eventAddress ?? this.eventAddress,
      eventPhotoUrl: eventPhotoUrl ?? this.eventPhotoUrl,
    );
  }
}
