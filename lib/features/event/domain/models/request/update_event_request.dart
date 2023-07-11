import 'package:json_annotation/json_annotation.dart';

part 'update_event_request.g.dart';

@JsonSerializable(createFactory: false)
class UpdateEventRequest {
  String? id;
  String? name;
  String? description;
  String? groupId;
  String? cityId;
  String? eventDate;
  String? eventLat;
  String? eventLng;
  String? eventAddress;
  String? eventPhotoUrl;

  UpdateEventRequest({
    this.id,
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

  Map<String, dynamic> toJson() => _$UpdateEventRequestToJson(this);

  UpdateEventRequest copyWith({
    String? id,
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
    return UpdateEventRequest(
      id: id ?? this.id,
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
