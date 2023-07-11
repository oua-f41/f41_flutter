// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_details_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryDetailsResponse _$CategoryDetailsResponseFromJson(
        Map<String, dynamic> json) =>
    CategoryDetailsResponse(
      id: json['id'] as String?,
      name: json['name'] as String?,
      photoUrl: json['photoUrl'] as String?,
      groups: (json['groups'] as List<dynamic>?)
          ?.map((e) => Group.fromJson(e as Map<String, dynamic>))
          .toList(),
      owner: json['owner'] == null
          ? null
          : User.fromJson(json['owner'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CategoryDetailsResponseToJson(
        CategoryDetailsResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'photoUrl': instance.photoUrl,
      'groups': instance.groups,
      'owner': instance.owner,
    };
