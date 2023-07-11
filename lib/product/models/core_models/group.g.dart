// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Group _$GroupFromJson(Map<String, dynamic> json) => Group(
      id: json['id'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      iconUrl: json['iconUrl'] as String?,
      categoryId: json['categoryId'] as String?,
      userId: json['userId'] as String?,
      category: json['category'] == null
          ? null
          : Category.fromJson(json['category'] as Map<String, dynamic>),
      owner: json['owner'] == null
          ? null
          : User.fromJson(json['owner'] as Map<String, dynamic>),
      events: (json['events'] as List<dynamic>?)
          ?.map((e) => Event.fromJson(e as Map<String, dynamic>))
          .toList(),
      userGroups: (json['userGroups'] as List<dynamic>?)
          ?.map((e) => UserGroups.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$GroupToJson(Group instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'categoryId': instance.categoryId,
      'iconUrl': instance.iconUrl,
      'userId': instance.userId,
      'createdAt': instance.createdAt?.toIso8601String(),
      'owner': instance.owner,
      'category': instance.category,
      'events': instance.events,
      'userGroups': instance.userGroups,
    };
