// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_group_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateGroupRequest _$UpdateGroupRequestFromJson(Map<String, dynamic> json) =>
    UpdateGroupRequest(
      id: json['id'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      iconUrl: json['iconUrl'] as String?,
      categoryId: json['categoryId'] as String?,
    );

Map<String, dynamic> _$UpdateGroupRequestToJson(UpdateGroupRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'iconUrl': instance.iconUrl,
      'categoryId': instance.categoryId,
    };
