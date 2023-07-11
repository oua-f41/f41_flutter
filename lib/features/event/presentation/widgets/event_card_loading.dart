import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:skeletons/skeletons.dart';

class EventCardLoading extends StatelessWidget {
  const EventCardLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: context.paddingNormal,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SkeletonAvatar(
              style: SkeletonAvatarStyle(
                width: 45,
                height: 45,
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Container(
                      padding: context.paddingLow, child: const SkeletonLine()),
                  Container(
                      padding: context.paddingLow,
                      child: SkeletonLine(
                        style:
                            SkeletonLineStyle(width: context.dynamicWidth(0.4)),
                      )),
                  Container(
                      padding: context.paddingLow,
                      child: SkeletonLine(
                        style: SkeletonLineStyle(
                            width: context.dynamicWidth(0.8),
                            height: context.dynamicHeight(0.2)),
                      )),
                ],
              ),
            )
          ],
        ));
  }
}
