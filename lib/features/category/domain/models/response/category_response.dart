import 'package:hive_flutter/adapters.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../../product/constants/hive_constants.dart';
import '../../../../../product/models/base_response.dart';
part 'category_response.g.dart';

@JsonSerializable()
@HiveType(typeId: HiveConstants.categoryHiveId)
class CategoryResponse extends BaseResponse {
  @HiveField(1)
  String? name;
  @HiveField(2)
  String? photoUrl;

  CategoryResponse({super.id, this.name, this.photoUrl});

  factory CategoryResponse.fromJson(Map<String, dynamic> json) =>
      _$CategoryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryResponseToJson(this);
}
