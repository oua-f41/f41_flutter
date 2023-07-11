import 'package:json_annotation/json_annotation.dart';

import 'user.dart';

part 'followee.g.dart';

@JsonSerializable()
class Followee {
  String? id;
  String? followerId;
  String? followeeId;
  User? followee;

  Followee({
    this.id,
    this.followerId,
    this.followeeId,
    this.followee,
  });

  factory Followee.fromJson(Map<String, dynamic> json) =>
      _$FolloweeFromJson(json);

  Map<String, dynamic> toJson() => _$FolloweeToJson(this);
}
