import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:skeletons/skeletons.dart';

class GroupLoading extends StatelessWidget {
  const GroupLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisExtent: context.dynamicHeight(0.27),
          crossAxisCount: 2,
          crossAxisSpacing: 15,
          mainAxisSpacing: 10,
        ),
        itemCount: 10,
        itemBuilder: (context, index) => SkeletonAvatar(
                style: SkeletonAvatarStyle(
              width: context.dynamicWidth(0.35),
              height: context.dynamicHeight(0.2),
              borderRadius: BorderRadius.circular(25),
            )));
  }
}
