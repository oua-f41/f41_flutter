import 'package:connectopia/product/models/core_models/follower.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../../product/models/core_models/event_attendees.dart';
import '../../../../../product/models/core_models/followee.dart';
import '../../../../../product/models/core_models/group.dart';
import '../../../../../product/models/core_models/user.dart';
import '../../../../../product/models/core_models/user_groups.dart';
import '../../../../../product/models/core_models/user_like_events.dart';

part 'profile_response.g.dart';

@JsonSerializable()
class ProfileResponse {
  String? id;
  String? userName;
  String? fullName;
  String? email;
  String? phoneNumber;
  String? profilePhotoUrl;
  String? about;
  List<Group?>? groups;
  List<UserGroups>? userGroups;
  List<EventAttendees>? eventAttendees;
  List<UserLikeEvents>? userLikeEvents;
  List<Follower>? followers;
  List<Followee>? followees;

  ProfileResponse(
      {this.id,
      this.userName,
      this.fullName,
      this.email,
      this.phoneNumber,
      this.profilePhotoUrl,
      this.about,
      this.groups,
      this.userGroups,
      this.eventAttendees,
      this.userLikeEvents,
      this.followers,
      this.followees});

  factory ProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$ProfileResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileResponseToJson(this);
}
