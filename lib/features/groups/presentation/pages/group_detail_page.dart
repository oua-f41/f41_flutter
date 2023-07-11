import 'package:auto_route/auto_route.dart';
import 'package:connectopia/features/event/presentation/widgets/event_card.dart';
import 'package:connectopia/features/groups/presentation/cubit/view_model/group_detail_view_model.dart';
import 'package:connectopia/product/widgets/title_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartal/kartal.dart';
import 'package:skeletons/skeletons.dart';

import '../../../../app/app_router.dart';
import '../../../../product/constants/image_constants.dart';
import '../../../../product/models/core_models/group.dart';
import '../../../../product/models/core_models/user.dart' as ProjectUser;
import '../../../event/presentation/widgets/event_card_loading.dart';
import '../../../maps/presentation/cubit/maps_cubit.dart';
import '../cubit/group_detail_cubit.dart';

@RoutePage()
class GroupDetailPage extends StatelessWidget with AutoRouteWrapper {
  const GroupDetailPage({
    super.key,
    this.group,
  });

  final Group? group;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<GroupDetailCubit, GroupDetailViewModel>(
        builder: (context, state) {
          return RefreshIndicator(
            notificationPredicate: (notification) {
              return notification.depth == 1;
            },
            displacement: 5,
            onRefresh: context.read<GroupDetailCubit>().refresh,
            child: NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) {
                  return [
                    SliverAppBar(
                      scrolledUnderElevation: 0,
                      shadowColor: Colors.black,
                      actions: state.groupResponse?.userId ==
                              FirebaseAuth.instance.currentUser?.uid
                          ? [
                              IconButton(
                                onPressed: () async {
                                  if (state.groupResponse == null ||
                                      state.groupResponse?.category == null) {
                                    return;
                                  }
                                  final response = await context.router.push(
                                    EditGroupRoute(
                                      updateGroupRequest: state.groupResponse!,
                                      category: state.groupResponse!.category!,
                                    ),
                                  );
                                  if (response is bool) {
                                    context.read<GroupDetailCubit>().refresh();
                                  }
                                },
                                icon: const Icon(Icons.edit),
                              ),
                            ]
                          : null,
                      expandedHeight: state.groupResponse == null
                          ? context.dynamicHeight(0.62)
                          : state.groupResponse?.userId ==
                                  FirebaseAuth.instance.currentUser?.uid
                              ? context.dynamicHeight(0.57)
                              : context.dynamicHeight(0.7),
                      automaticallyImplyLeading: true,
                      floating: true,
                      flexibleSpace: FlexibleSpaceBar(
                        background: Container(
                          child: Column(
                            children: [
                              SizedBox(
                                height: context.dynamicHeight(0.3),
                                child: Stack(
                                  children: [
                                    SizedBox(
                                      height: context.dynamicHeight(0.2),
                                      width: context.dynamicWidth(1),
                                      child: Hero(
                                        tag:
                                            "${group?.category?.photoUrl}${group?.id}",
                                        child: group?.category?.photoUrl
                                                        ?.isNotNullOrNoEmpty ==
                                                    true ||
                                                state
                                                        .groupResponse
                                                        ?.category
                                                        ?.photoUrl
                                                        ?.isNotNullOrNoEmpty ==
                                                    true
                                            ? Image.network(
                                                state.groupResponse?.category
                                                        ?.photoUrl ??
                                                    group?.category?.photoUrl ??
                                                    "",
                                                fit: BoxFit.cover,
                                                color: Colors.black
                                                    .withOpacity(0.5),
                                                colorBlendMode:
                                                    BlendMode.darken,
                                              )
                                            : Image.asset(ImageConstants
                                                .defaultProfilePhoto.imagePath),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.bottomCenter,
                                      child: TextButton(
                                        onPressed: state
                                                    .groupResponse?.userId ==
                                                FirebaseAuth
                                                    .instance.currentUser?.uid
                                            ? () {
                                                context
                                                    .read<GroupDetailCubit>()
                                                    .setGroupIcon();
                                              }
                                            : null,
                                        child: SizedBox(
                                          width: 140,
                                          height: 140,
                                          child: Hero(
                                            tag:
                                                "${group?.iconUrl}${group?.id}",
                                            child: ClipOval(
                                              child:
                                                  group?.iconUrl?.isNotEmpty ==
                                                          true
                                                      ? Image.network(
                                                          state.groupResponse
                                                                  ?.iconUrl ??
                                                              group!.iconUrl!,
                                                          fit: BoxFit.cover,
                                                        )
                                                      : Image.asset(
                                                          ImageConstants
                                                              .defaultGroupPhoto
                                                              .imagePath,
                                                          fit: BoxFit.cover,
                                                        ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: context.paddingNormal,
                                child: TitleText(
                                    text: state.groupResponse?.name ??
                                        group?.name ??
                                        ""),
                              ),
                              Text(
                                "- ${state.groupResponse?.category?.name ?? group?.category?.name ?? ""} -",
                                style: context.textTheme.bodyMedium!.copyWith(
                                    color: context.colorScheme.outline,
                                    fontWeight: FontWeight.w500),
                              ),
                              state.groupResponse != null
                                  ? Padding(
                                      padding: context.verticalPaddingNormal,
                                      child: Container(
                                        padding: context.horizontalPaddingHigh,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                context.router.push(
                                                  ProfileListRoute(
                                                    users: state.groupResponse
                                                            ?.userGroups
                                                            ?.map((e) => e.user)
                                                            .toList() ??
                                                        [],
                                                  ),
                                                );
                                              },
                                              child: Column(
                                                children: [
                                                  Text(
                                                    state.groupResponse
                                                            ?.userGroups?.length
                                                            .toString() ??
                                                        "",
                                                    style: context
                                                        .textTheme.bodyMedium!
                                                        .copyWith(
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                  ),
                                                  Text(
                                                    "Members",
                                                    style: context
                                                        .textTheme.bodyMedium!
                                                        .copyWith(
                                                            color: context
                                                                .colorScheme
                                                                .outline,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {},
                                              child: Column(
                                                children: [
                                                  Text(
                                                    state.groupResponse?.events
                                                            ?.length
                                                            .toString() ??
                                                        "0",
                                                    style: context
                                                        .textTheme.bodyMedium!
                                                        .copyWith(
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                  ),
                                                  Text(
                                                    "Events",
                                                    style: context
                                                        .textTheme.bodyMedium!
                                                        .copyWith(
                                                            color: context
                                                                .colorScheme
                                                                .outline,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  : state.isLoading
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SkeletonAvatar(
                                                style: SkeletonAvatarStyle(
                                                    width: 60,
                                                    height: 50,
                                                    padding:
                                                        context.paddingLow)),
                                            SkeletonAvatar(
                                                style: SkeletonAvatarStyle(
                                                    width: 60,
                                                    height: 50,
                                                    padding:
                                                        context.paddingLow)),
                                          ],
                                        )
                                      : const SizedBox(),
                              state.isLoading
                                  ? Container(
                                      padding: context.paddingNormal,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          const SkeletonLine(
                                            style: SkeletonLineStyle(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 5)),
                                          ),
                                          SkeletonLine(
                                            style: SkeletonLineStyle(
                                                alignment: Alignment.center,
                                                width:
                                                    context.dynamicWidth(0.8),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 5)),
                                          ),
                                          SkeletonLine(
                                            style: SkeletonLineStyle(
                                                alignment: Alignment.center,
                                                width:
                                                    context.dynamicWidth(0.6),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 5)),
                                          ),
                                        ],
                                      ),
                                    )
                                  : Column(
                                      children: [
                                        Container(
                                          padding:
                                              context.horizontalPaddingNormal,
                                          child: Text(
                                            state.groupResponse?.description ??
                                                group?.description ??
                                                "",
                                            textAlign: TextAlign.center,
                                            maxLines: 3,
                                            style: context.textTheme.titleSmall!
                                                .copyWith(
                                                    fontWeight:
                                                        FontWeight.w500),
                                          ),
                                        ),
                                        state.groupResponse?.userId ==
                                                FirebaseAuth
                                                    .instance.currentUser?.uid
                                            ? const SizedBox()
                                            : Container(
                                                padding: context.paddingLow,
                                                child: InkWell(
                                                  onTap: () {
                                                    context.router.push(
                                                        ProfileRoute(
                                                            user: state
                                                                    .groupResponse
                                                                    ?.owner ??
                                                                ProjectUser
                                                                    .User()));
                                                  },
                                                  child:
                                                      state.groupResponse !=
                                                              null
                                                          ? Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                Container(
                                                                  padding: context
                                                                      .paddingLow,
                                                                  child: const Text(
                                                                      "Creaed By:"),
                                                                ),
                                                                Text(
                                                                  state
                                                                          .groupResponse
                                                                          ?.owner
                                                                          ?.fullName ??
                                                                      "",
                                                                  style: context
                                                                      .textTheme
                                                                      .titleSmall!
                                                                      .copyWith(
                                                                          color: context
                                                                              .colorScheme
                                                                              .primary,
                                                                          fontWeight:
                                                                              FontWeight.w500),
                                                                ),
                                                                Container(
                                                                  padding: context
                                                                      .horizontalPaddingLow,
                                                                  child:
                                                                      ClipOval(
                                                                    child: Container(
                                                                        height: 20,
                                                                        width: 20,
                                                                        color: Colors.white,
                                                                        child: state.groupResponse?.owner?.profilePhotoUrl?.isNotNullOrNoEmpty == true
                                                                            ? Image.network(
                                                                                state.groupResponse!.owner!.profilePhotoUrl!,
                                                                                width: 50,
                                                                                height: 50,
                                                                                fit: BoxFit.cover,
                                                                              )
                                                                            : Image.asset(
                                                                                ImageConstants.defaultProfilePhoto.imagePath,
                                                                                width: 50,
                                                                                height: 50,
                                                                                fit: BoxFit.cover,
                                                                              )),
                                                                  ),
                                                                ),
                                                              ],
                                                            )
                                                          : const SizedBox(),
                                                ),
                                              ),
                                        state.groupResponse?.userId ==
                                                    FirebaseAuth.instance
                                                        .currentUser?.uid ||
                                                state.groupResponse == null
                                            ? const SizedBox()
                                            : Container(
                                                padding: context.paddingLow,
                                                width:
                                                    context.dynamicWidth(0.6),
                                                child: ElevatedButton(
                                                    onPressed:
                                                        state.attendingLoading
                                                            ? null
                                                            : () {
                                                                if (state
                                                                        .isAttended !=
                                                                    true) {
                                                                  context
                                                                      .read<
                                                                          GroupDetailCubit>()
                                                                      .attendGroup();
                                                                } else {
                                                                  context
                                                                      .read<
                                                                          GroupDetailCubit>()
                                                                      .leftGroup();
                                                                }
                                                              },
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Text(state.isAttended !=
                                                                true
                                                            ? "Join"
                                                            : "Leave"),
                                                        state.attendingLoading
                                                            ? Container(
                                                                padding: context
                                                                    .paddingLow,
                                                                width: 30,
                                                                height: 30,
                                                                child:
                                                                    const CircularProgressIndicator())
                                                            : const SizedBox()
                                                      ],
                                                    )),
                                              ),
                                      ],
                                    ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ];
                },
                body: Container(
                  child: SafeArea(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                            padding: context.paddingNormal,
                            alignment: Alignment.bottomLeft,
                            child: const TitleText(text: "Events ;")),
                        state.isLoading
                            ? Expanded(
                                child: ListView.builder(
                                  itemCount: 10,
                                  itemBuilder: (context, index) =>
                                      const EventCardLoading(),
                                ),
                              )
                            : Expanded(
                                child: state.groupResponse?.events
                                            .isNotNullOrEmpty ==
                                        true
                                    ? ListView.separated(
                                        separatorBuilder: (context, index) {
                                          return const Divider();
                                        },
                                        padding: EdgeInsets.zero,
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: state.groupResponse?.events
                                                ?.length ??
                                            0,
                                        itemBuilder: (context, index) =>
                                            EventCard(
                                                event: state.groupResponse
                                                    ?.events?[index]))
                                    : const Center(child: Text("No Event")),
                              ),
                      ],
                    ),
                  ),
                )),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: "",
        label: group?.userId != FirebaseAuth.instance.currentUser?.uid
            ? Row(
                children: [
                  const Icon(Icons.attach_money_outlined),
                  Padding(
                    padding: context.onlyLeftPaddingLow,
                    child: const Text("Donate"),
                  ),
                ],
              )
            : Row(children: [
                const Icon(Icons.add),
                Padding(
                  padding: context.onlyLeftPaddingLow,
                  child: const Text("Create Event"),
                ),
              ]),
        onPressed: () async {
          if (group?.userId != FirebaseAuth.instance.currentUser?.uid ||
              group == null) return;
          final isSuccess =
              await context.router.push(AddEventRoute(groupId: group!.id!));
          if (isSuccess == true) {
            await context.read<GroupDetailCubit>().refresh();
            await context.read<MapsCubit>().refresh();
          }
        },
      ),
    );
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => GroupDetailCubit()..init(group?.id ?? ""),
      child: this,
    );
  }
}
