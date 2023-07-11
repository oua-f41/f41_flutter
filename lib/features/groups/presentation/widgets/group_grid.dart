import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

import '../../../../product/models/core_models/group.dart';
import 'group_card.dart';

class GroupGrid extends StatelessWidget {
  const GroupGrid({super.key, this.groups});

  final List<Group?>? groups;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisExtent: context.dynamicHeight(0.28),
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: groups?.length ?? 0,
        itemBuilder: (context, index) => GroupCard(
              group: groups?[index],
            ));
  }
}
