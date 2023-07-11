import 'package:connectopia/product/models/core_models/group.dart';
import 'package:json_annotation/json_annotation.dart';
part 'category.g.dart';

@JsonSerializable()
class Category {
  String? id;
  String? name;
  String? photoUrl;
  List<Group>? groups;

  Category({this.id, this.name, this.photoUrl, this.groups});

  Category copyWith({
    String? id,
    String? name,
    String? photoUrl,
    List<Group>? groups,
  }) {
    return Category(
      id: id ?? this.id,
      name: name ?? this.name,
      photoUrl: photoUrl ?? this.photoUrl,
      groups: groups ?? this.groups,
    );
  }

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}
