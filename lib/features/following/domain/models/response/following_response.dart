import 'package:json_annotation/json_annotation.dart';

part 'following_response.g.dart';

@JsonSerializable(createToJson: false)
class FollowingResponse {
  String? id;
  String? followeeId;
  String? followerId;

  FollowingResponse({this.id, this.followeeId, this.followerId});

  factory FollowingResponse.fromJson(Map<String, dynamic> json) =>
      _$FollowingResponseFromJson(json);
}
