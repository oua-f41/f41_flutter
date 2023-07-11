import 'package:auto_route/auto_route.dart';
import 'package:connectopia/app/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartal/kartal.dart';
import 'package:skeletons/skeletons.dart';

import '../cubit/profile_cubit.dart';
import '../cubit/view_model/profile_view_model.dart';

class UserInformations extends StatelessWidget {
  const UserInformations({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.dynamicHeight(0.08),
      width: context.dynamicWidth(0.8),
      child: Container(
        height: context.dynamicHeight(0.1),
        padding: context.onlyRightPaddingMedium,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: context.dynamicWidth(0.45),
                    padding: context.horizontalPaddingNormal,
                    child: BlocBuilder<ProfileCubit, ProfileViewModel>(
                      builder: (context, state) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            state.profileResponse?.fullName
                                            .isNotNullOrNoEmpty ==
                                        true ||
                                    state.defaultUser?.fullName
                                            .isNotNullOrNoEmpty ==
                                        true
                                ? FittedBox(
                                    fit: BoxFit.fitWidth,
                                    child: Text(
                                      state.profileResponse?.fullName ??
                                          state.defaultUser?.fullName ??
                                          "",
                                      style: context.textTheme.headlineSmall
                                          ?.copyWith(fontSize: 28),
                                      maxLines: 1,
                                    ),
                                  )
                                : state.isLoading
                                    ? const SkeletonLine()
                                    : const SizedBox(),
                            /* Text(
                              "UI/UX Designer",
                              style: context.textTheme.headlineMedium
                                  ?.copyWith(fontSize: 14),
                            ), */
                            state.profileResponse?.userName
                                            .isNotNullOrNoEmpty ==
                                        true ||
                                    state.defaultUser?.userName
                                            .isNotNullOrNoEmpty ==
                                        true
                                ? Text(
                                    "@${state.profileResponse?.userName ?? state.defaultUser?.userName ?? ""}",
                                    style: context.textTheme.headlineMedium
                                        ?.copyWith(fontSize: 14),
                                    maxLines: 1,
                                  )
                                : state.isLoading
                                    ? SkeletonLine(
                                        style: SkeletonLineStyle(
                                            width: 50,
                                            padding:
                                                context.verticalPaddingLow),
                                      )
                                    : const SizedBox(),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            BlocBuilder<ProfileCubit, ProfileViewModel>(
              builder: (context, state) {
                return SizedBox(
                    width: context.dynamicWidth(0.4),
                    child: state.profileResponse != null
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Container(
                                alignment: Alignment.topCenter,
                                child: InkWell(
                                  onTap: () {
                                    context.router.push(ProfileListRoute(
                                        users: state.profileResponse?.followers
                                                ?.map((e) => e.follower)
                                                .toList() ??
                                            []));
                                  },
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        padding: context.onlyBottomPaddingLow,
                                        child: Text(
                                          state.profileResponse?.followers
                                                  ?.length
                                                  .toString() ??
                                              "0",
                                          style: context.textTheme.headlineLarge
                                              ?.copyWith(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Text(
                                        "Takipçi",
                                        style: context.textTheme.headlineMedium
                                            ?.copyWith(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                alignment: Alignment.topCenter,
                                child: InkWell(
                                  onTap: () {
                                    context.router.push(ProfileListRoute(
                                        users: state.profileResponse?.followees
                                                ?.map((e) => e.followee)
                                                .toList() ??
                                            []));
                                  },
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        padding: context.onlyBottomPaddingLow,
                                        child: Text(
                                          state.profileResponse?.followees
                                                  ?.length
                                                  .toString() ??
                                              "0",
                                          style: context.textTheme.headlineLarge
                                              ?.copyWith(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Text(
                                        "Takip",
                                        style: context.textTheme.headlineMedium
                                            ?.copyWith(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                alignment: Alignment.topCenter,
                                child: InkWell(
                                  onTap: () {},
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        padding: context.onlyBottomPaddingLow,
                                        child: Text(
                                          state.profileResponse?.userLikeEvents
                                                  ?.length
                                                  .toString() ??
                                              "0",
                                          style: context.textTheme.headlineLarge
                                              ?.copyWith(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Text(
                                        "Like",
                                        style: context.textTheme.headlineMedium
                                            ?.copyWith(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                        : state.isLoading
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SkeletonAvatar(
                                    style: SkeletonAvatarStyle(
                                      width: context.dynamicWidth(0.12),
                                      height: context.dynamicWidth(0.12),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  SkeletonAvatar(
                                    style: SkeletonAvatarStyle(
                                      width: context.dynamicWidth(0.12),
                                      height: context.dynamicWidth(0.12),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  SkeletonAvatar(
                                    style: SkeletonAvatarStyle(
                                      width: context.dynamicWidth(0.12),
                                      height: context.dynamicWidth(0.12),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ],
                              )
                            : const SizedBox());
              },
            ),
          ],
        ),
      ),
    );
  }
}
