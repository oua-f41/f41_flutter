// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_groups.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserGroups _$UserGroupsFromJson(Map<String, dynamic> json) => UserGroups(
      id: json['id'] as String?,
      userId: json['userId'] as String?,
      groupId: json['groupId'] as String?,
      group: json['group'] == null
          ? null
          : Group.fromJson(json['group'] as Map<String, dynamic>),
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserGroupsToJson(UserGroups instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'groupId': instance.groupId,
      'group': instance.group,
      'user': instance.user,
    };
