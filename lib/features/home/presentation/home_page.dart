import 'package:auto_route/auto_route.dart';
import 'package:connectopia/features/event/presentation/widgets/event_card.dart';
import 'package:connectopia/features/event/presentation/widgets/event_card_loading.dart';
import 'package:connectopia/features/groups/presentation/widgets/group_card.dart';
import 'package:connectopia/features/home/presentation/cubit/home_cubit.dart';
import 'package:connectopia/features/home/presentation/cubit/view_model/home_view_model.dart';
import 'package:connectopia/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:connectopia/features/profile/presentation/cubit/view_model/profile_view_model.dart';
import 'package:connectopia/features/weather/presentation/widgets/weather_snipped.dart';
import 'package:connectopia/product/constants/image_constants.dart';
import 'package:connectopia/features/profile/presentation/widgets/profile_photo_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartal/kartal.dart';
import 'package:skeletons/skeletons.dart';

import '../../../app/app_router.dart';

@RoutePage()
class HomePage extends StatelessWidget with AutoRouteWrapper {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          forceMaterialTransparency: true,
          /* centerTitle: true, */
          title: Image.asset(
            ImageConstants.expandedLogo.imagePath,
            height: 90,
            /* width: 220, */
          ),
          actions: [
            IconButton(
              onPressed: () {
                context.router.push(const SearchRoute());
              },
              icon: const Icon(Icons.search),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.notifications),
            ),
            Container(child: const ProfilePhotoButton())
          ],
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await context.read<HomeCubit>().refresh();
          await context.read<ProfileCubit>().refresh();
        },
        child: SingleChildScrollView(
          child: Container(
              child: Container(
                  padding: context.paddingLow,
                  child: Column(
                    children: [
                      Container(
                        padding: context.paddingLow,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                BlocBuilder<HomeCubit, HomeViewModel>(
                                  builder: (context, state) {
                                    return Text(
                                      state.title ?? "",
                                      style: context.textTheme.headlineLarge
                                          ?.copyWith(
                                              fontWeight: FontWeight.bold),
                                    );
                                  },
                                ),
                                BlocBuilder<ProfileCubit, ProfileViewModel>(
                                  builder: (context, state) {
                                    return state.isLoading
                                        ? Container(
                                            padding: context.verticalPaddingLow,
                                            child: const SkeletonLine(
                                              style: SkeletonLineStyle(
                                                width: 180,
                                                height: 20,
                                              ),
                                            ),
                                          )
                                        : state.profileResponse?.fullName
                                                    .isNotNullOrNoEmpty ==
                                                true
                                            ? Text(
                                                "${state.profileResponse?.fullName?.split(" ")[0]};",
                                                style: context
                                                    .textTheme.headlineMedium,
                                              )
                                            : const SizedBox();
                                  },
                                ),
                              ],
                            ),
                            const WeatherSnipped()
                          ],
                        ),
                      ),
                      FirebaseAuth.instance.currentUser != null
                          ? BlocBuilder<ProfileCubit, ProfileViewModel>(
                              builder: (context, state) {
                                return Container(
                                    padding: context.verticalPaddingNormal,
                                    height: state.isLoading
                                        ? context.dynamicHeight(0.36)
                                        : state.profileResponse?.userGroups
                                                    ?.isNotEmpty ==
                                                true
                                            ? context.dynamicHeight(0.36)
                                            : 0,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: context
                                              .watch<HomeCubit>()
                                              .state
                                              .isLoading
                                          ? 10
                                          : state.profileResponse?.userGroups
                                                  ?.map((e) => e.group)
                                                  .toList()
                                                  .length ??
                                              0,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          padding: context.paddingLow,
                                          child: context
                                                  .watch<HomeCubit>()
                                                  .state
                                                  .isLoading
                                              ? SkeletonAvatar(
                                                  style: SkeletonAvatarStyle(
                                                  width:
                                                      context.dynamicWidth(0.5),
                                                  height: context
                                                      .dynamicHeight(0.2),
                                                  borderRadius:
                                                      BorderRadius.circular(25),
                                                ))
                                              : GroupCard(
                                                  group: state.profileResponse
                                                      ?.userGroups
                                                      ?.map((e) => e.group)
                                                      .toList()[index]),
                                        );
                                      },
                                    ));
                              },
                            )
                          : const SizedBox(),
                      BlocBuilder<HomeCubit, HomeViewModel>(
                        builder: (context, state) {
                          return ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: state.isLoading
                                ? 10
                                : state.events?.length ?? 0,
                            itemBuilder: (context, index) {
                              return state.isLoading
                                  ? const EventCardLoading()
                                  : EventCard(
                                      event: state.events![index],
                                    );
                            },
                          );
                        },
                      ),
                      BlocBuilder<HomeCubit, HomeViewModel>(
                        builder: (context, state) {
                          return ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: state.isLoading
                                ? 10
                                : state.eventsOnCity?.length ?? 0,
                            itemBuilder: (context, index) {
                              return state.isLoading
                                  ? const EventCardLoading()
                                  : EventCard(
                                      event: state.eventsOnCity![index],
                                    );
                            },
                          );
                        },
                      ),
                      BlocBuilder<HomeCubit, HomeViewModel>(
                        builder: (context, state) {
                          return ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: state.isLoading
                                ? 10
                                : state.otherEvents?.length ?? 0,
                            itemBuilder: (context, index) {
                              return state.isLoading
                                  ? const EventCardLoading()
                                  : EventCard(
                                      event: state.otherEvents![index],
                                    );
                            },
                          );
                        },
                      ),
                    ],
                  ))),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final isSuccess = await context.router.push(const AddGroupRoute());
          },
          child: const Icon(Icons.group_add)),
    );
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..init(),
      child: this,
    );
  }
}
