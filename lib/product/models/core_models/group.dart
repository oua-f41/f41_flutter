import 'package:connectopia/product/models/core_models/user.dart';
import 'package:json_annotation/json_annotation.dart';

import 'category.dart';
import 'event.dart';
import 'user_groups.dart';

part 'group.g.dart';

@JsonSerializable()
class Group {
  String? id;
  String? name;
  String? description;
  String? categoryId;
  String? iconUrl;
  String? userId;
  DateTime? createdAt;
  User? owner;
  Category? category;
  List<Event>? events;
  List<UserGroups>? userGroups;

  Group(
      {this.id,
      this.name,
      this.description,
      this.iconUrl,
      this.categoryId,
      this.userId,
      this.category,
      this.owner,
      this.events,
      this.userGroups,
      this.createdAt});

  factory Group.fromJson(Map<String, dynamic> json) => _$GroupFromJson(json);

  Map<String, dynamic> toJson() => _$GroupToJson(this);
}
