import 'package:json_annotation/json_annotation.dart';

part 'following_request.g.dart';

@JsonSerializable(createFactory: false)
class FollowingRequest {
  String? followeeId;
  String? followerId;

  FollowingRequest({this.followeeId, this.followerId});

  Map<String, dynamic> toJson() => _$FollowingRequestToJson(this);
}
