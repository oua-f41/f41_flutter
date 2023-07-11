import 'package:connectopia/product/models/core_models/group.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../../product/models/core_models/category.dart';
import '../../../../../product/models/core_models/event.dart';
import '../../../../../product/models/core_models/user.dart';
import '../../../../../product/models/core_models/user_groups.dart';

part 'group_response.g.dart';

@JsonSerializable()
class GroupResponse extends Group {
  GroupResponse(
      {super.id,
      super.name,
      super.description,
      super.category,
      super.events,
      super.iconUrl,
      super.userGroups,
      super.categoryId,
      super.createdAt,
      super.owner,
      super.userId});

  factory GroupResponse.fromJson(Map<String, dynamic> json) =>
      _$GroupResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$GroupResponseToJson(this);

  GroupResponse copyWith({
    String? id,
    String? name,
    String? description,
    Category? category,
    List<Event>? events,
    String? iconUrl,
    List<UserGroups>? userGroups,
    String? categoryId,
    DateTime? createdAt,
    User? owner,
    String? userId,
  }) {
    return GroupResponse(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      category: category ?? this.category,
      events: events ?? this.events,
      iconUrl: iconUrl ?? this.iconUrl,
      userGroups: userGroups ?? this.userGroups,
      categoryId: categoryId ?? this.categoryId,
      createdAt: createdAt ?? this.createdAt,
      owner: owner ?? this.owner,
      userId: userId ?? this.userId,
    );
  }
}
