// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GroupRequest _$GroupRequestFromJson(Map<String, dynamic> json) => GroupRequest(
      name: json['name'] as String?,
      description: json['description'] as String?,
      iconUrl: json['iconUrl'] as String?,
      categoryId: json['categoryId'] as String?,
      userId: json['userId'] as String?,
    );

Map<String, dynamic> _$GroupRequestToJson(GroupRequest instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'iconUrl': instance.iconUrl,
      'categoryId': instance.categoryId,
      'userId': instance.userId,
    };
