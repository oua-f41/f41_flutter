// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as String?,
      userName: json['userName'] as String?,
      fullName: json['fullName'] as String?,
      email: json['email'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      profilePhotoUrl: json['profilePhotoUrl'] as String?,
      about: json['about'] as String?,
    )
      ..groups = (json['groups'] as List<dynamic>?)
          ?.map((e) => Group.fromJson(e as Map<String, dynamic>))
          .toList()
      ..userGroups = (json['userGroups'] as List<dynamic>?)
          ?.map((e) => UserGroups.fromJson(e as Map<String, dynamic>))
          .toList()
      ..eventAttendees = (json['eventAttendees'] as List<dynamic>?)
          ?.map((e) => EventAttendees.fromJson(e as Map<String, dynamic>))
          .toList()
      ..userLikeEvents = (json['userLikeEvents'] as List<dynamic>?)
          ?.map((e) => UserLikeEvents.fromJson(e as Map<String, dynamic>))
          .toList()
      ..followers = (json['followers'] as List<dynamic>?)
          ?.map((e) => Follower.fromJson(e as Map<String, dynamic>))
          .toList()
      ..followees = (json['followees'] as List<dynamic>?)
          ?.map((e) => Followee.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'userName': instance.userName,
      'fullName': instance.fullName,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'profilePhotoUrl': instance.profilePhotoUrl,
      'about': instance.about,
      'groups': instance.groups,
      'userGroups': instance.userGroups,
      'eventAttendees': instance.eventAttendees,
      'userLikeEvents': instance.userLikeEvents,
      'followers': instance.followers,
      'followees': instance.followees,
    };
