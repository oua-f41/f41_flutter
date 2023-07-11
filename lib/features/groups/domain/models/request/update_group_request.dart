// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:json_annotation/json_annotation.dart';
part 'update_group_request.g.dart';

@JsonSerializable()
class UpdateGroupRequest {
  String? id;
  String? name;
  String? description;
  String? iconUrl;
  String? categoryId;

  UpdateGroupRequest({
    this.id,
    this.name,
    this.description,
    this.iconUrl,
    this.categoryId,
  });

  factory UpdateGroupRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateGroupRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateGroupRequestToJson(this);

  UpdateGroupRequest copyWith({
    String? id,
    String? name,
    String? description,
    String? iconUrl,
    String? categoryId,
  }) {
    return UpdateGroupRequest(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      iconUrl: iconUrl ?? this.iconUrl,
      categoryId: categoryId ?? this.categoryId,
    );
  }
}
