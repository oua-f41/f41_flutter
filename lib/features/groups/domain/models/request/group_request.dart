// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';
part 'group_request.g.dart';

@JsonSerializable()
class GroupRequest {
  String? name;
  String? description;
  String? iconUrl;
  String? categoryId;
  String? userId;

  GroupRequest(
      {this.name,
      this.description,
      this.iconUrl,
      this.categoryId,
      this.userId});

  factory GroupRequest.fromJson(Map<String, dynamic> json) =>
      _$GroupRequestFromJson(json);

  Map<String, dynamic> toJson() => _$GroupRequestToJson(this);

  GroupRequest copyWith({
    String? name,
    String? description,
    String? iconUrl,
    String? categoryId,
    String? userId,
  }) {
    return GroupRequest(
      name: name ?? this.name,
      description: description ?? this.description,
      iconUrl: iconUrl ?? this.iconUrl,
      categoryId: categoryId ?? this.categoryId,
      userId: userId ?? this.userId,
    );
  }
}
