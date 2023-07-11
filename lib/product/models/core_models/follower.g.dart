// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'follower.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Follower _$FollowerFromJson(Map<String, dynamic> json) => Follower(
      id: json['id'] as String?,
      followerId: json['followerId'] as String?,
      followeeId: json['followeeId'] as String?,
      follower: json['follower'] == null
          ? null
          : User.fromJson(json['follower'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FollowerToJson(Follower instance) => <String, dynamic>{
      'id': instance.id,
      'followerId': instance.followerId,
      'followeeId': instance.followeeId,
      'follower': instance.follower,
    };
