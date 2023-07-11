import 'package:json_annotation/json_annotation.dart';

import 'user.dart';
part 'follower.g.dart';

@JsonSerializable()
class Follower {
  String? id;
  String? followerId;
  String? followeeId;
  User? follower;

  Follower({
    this.id,
    this.followerId,
    this.followeeId,
    this.follower,
  });

  factory Follower.fromJson(Map<String, dynamic> json) =>
      _$FollowerFromJson(json);

  Map<String, dynamic> toJson() => _$FollowerToJson(this);
}
