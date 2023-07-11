import 'package:connectopia/product/models/core_models/followee.dart';
import 'package:json_annotation/json_annotation.dart';

import 'event_attendees.dart';
import 'follower.dart';
import 'group.dart';
import 'user_groups.dart';
import 'user_like_events.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  String? id;
  String? userName;
  String? fullName;
  String? email;
  String? phoneNumber;
  String? profilePhotoUrl;
  String? about;
  List<Group>? groups;
  List<UserGroups>? userGroups;
  List<EventAttendees>? eventAttendees;
  List<UserLikeEvents>? userLikeEvents;
  List<Follower>? followers;
  List<Followee>? followees;

  User({
    this.id,
    this.userName,
    this.fullName,
    this.email,
    this.phoneNumber,
    this.profilePhotoUrl,
    this.about,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
