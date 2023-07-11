import 'package:connectopia/product/models/core_models/group.dart';
import 'package:connectopia/product/models/core_models/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category_details_response.g.dart';

@JsonSerializable()
class CategoryDetailsResponse {
  String? id;
  String? name;
  String? photoUrl;
  List<Group>? groups;
  User? owner;

  CategoryDetailsResponse(
      {this.id, this.name, this.photoUrl, this.groups, this.owner});

  factory CategoryDetailsResponse.fromJson(Map<String, dynamic> json) =>
      _$CategoryDetailsResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CategoryDetailsResponseToJson(this);
}
