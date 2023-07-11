import 'package:json_annotation/json_annotation.dart';

import 'group.dart';
import 'user.dart';

part 'user_groups.g.dart';

@JsonSerializable()
class UserGroups {
  String? id;
  String? userId;
  String? groupId;
  Group? group;
  User? user;

  UserGroups({this.id, this.userId, this.groupId, this.group, this.user});

  factory UserGroups.fromJson(Map<String, dynamic> json) =>
      _$UserGroupsFromJson(json);

  Map<String, dynamic> toJson() => _$UserGroupsToJson(this);

  UserGroups copyWith({
    String? id,
    String? userId,
    String? groupId,
    Group? group,
    User? user,
  }) {
    return UserGroups(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      groupId: groupId ?? this.groupId,
      group: group ?? this.group,
      user: user ?? this.user,
    );
  }
}
