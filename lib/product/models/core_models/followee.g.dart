// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'followee.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Followee _$FolloweeFromJson(Map<String, dynamic> json) => Followee(
      id: json['id'] as String?,
      followerId: json['followerId'] as String?,
      followeeId: json['followeeId'] as String?,
      followee: json['followee'] == null
          ? null
          : User.fromJson(json['followee'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FolloweeToJson(Followee instance) => <String, dynamic>{
      'id': instance.id,
      'followerId': instance.followerId,
      'followeeId': instance.followeeId,
      'followee': instance.followee,
    };
