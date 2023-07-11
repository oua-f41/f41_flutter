import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:connectopia/features/event/presentation/cubit/view_model/event_detail_view_model.dart';
import 'package:connectopia/features/groups/presentation/widgets/group_card.dart';
import 'package:connectopia/product/constants/image_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:kartal/kartal.dart';
import 'package:skeletons/skeletons.dart';

import '../../../../app/app_router.dart';
import '../../../../product/models/core_models/event.dart';
import '../../../../product/widgets/title_text.dart';
import '../cubit/event_detail_cubit.dart';
import '../cubit/view_model/edit_event_view_model.dart';

@RoutePage()
class EventDetailPage extends StatelessWidget with AutoRouteWrapper {
  const EventDetailPage({super.key, required this.event});

  final Event event;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventDetailCubit, EventDetailViewModel>(
      builder: (context, state) {
        return Scaffold(
          body: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                toolbarHeight: 40,
                expandedHeight: context.dynamicHeight(0.5),
                backgroundColor: context.colorScheme.background,
                elevation: 5,
                pinned: true,
                stretch: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: state.event?.eventPhotoUrl.isNotNullOrNoEmpty ==
                              true ||
                          event.eventPhotoUrl.isNotNullOrNoEmpty == true
                      ? Image.network(
                          state.event?.eventPhotoUrl ??
                              event.eventPhotoUrl ??
                              "",
                          fit: BoxFit.cover,
                          color: Colors.black.withOpacity(0.3),
                          colorBlendMode: BlendMode.darken,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return const SkeletonAvatar();
                          },
                        )
                      : Image.asset(ImageConstants.defaultGroupPhoto.imagePath,
                          fit: BoxFit.cover,
                          color: Colors.black.withOpacity(0.3),
                          colorBlendMode: BlendMode.darken),
                  stretchModes: const [
                    StretchMode.blurBackground,
                    StretchMode.zoomBackground,
                  ],
                ),
                actions: [
                  state.event?.group?.userId ==
                          FirebaseAuth.instance.currentUser?.uid
                      ? IconButton(
                          onPressed: () async {
                            if (state.event == null) return;
                            final action = await context.router
                                .push(EditEventRoute(event: state.event!));
                            if (action == EditEventActions.update) {
                              context.read<EventDetailCubit>().refresh();
                            }
                            if (action == EditEventActions.delete) {
                              context.router.pop();
                            }
                          },
                          icon: const Icon(Icons.edit),
                        )
                      : const SizedBox(),
                ],
                bottom: const PreferredSize(
                  preferredSize: Size.fromHeight(0.0),
                  child: EventDetailScrollControl(),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  color: context.colorScheme.background,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24.0, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TitleText(
                        text: state.event?.name ?? event.name ?? "",
                      ),
                      Container(
                        padding: context.verticalPaddingLow,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              state.event?.group?.category?.name ??
                                  event.group?.category?.name ??
                                  "",
                              style: context.textTheme.bodyMedium?.copyWith(
                                color: context.colorScheme.outline,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  DateFormat("dd/MM/yyyy - hh.mm").format(
                                      state.event?.eventDate ??
                                          event.eventDate ??
                                          DateTime.now()),
                                  style:
                                      context.textTheme.titleMedium?.copyWith(
                                    color: context.colorScheme.outline,
                                  ),
                                ),
                                state.isLoading
                                    ? const SizedBox()
                                    : Row(
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.only(
                                                right: 3.0),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(100),
                                              ),
                                              color: DateTime.now()
                                                      .difference(state.event
                                                              ?.eventDate ??
                                                          DateTime.now())
                                                      .isNegative
                                                  ? Colors.green
                                                  : Colors.red,
                                            ),
                                            width: 15,
                                            height: 15,
                                          ),
                                          Text(
                                            DateTime.now()
                                                    .difference(state
                                                            .event?.eventDate ??
                                                        DateTime.now())
                                                    .isNegative
                                                ? "Upcomming"
                                                : "Passed",
                                            style: context.textTheme.titleSmall
                                                ?.copyWith(
                                              color:
                                                  context.colorScheme.outline,
                                            ),
                                          ),
                                        ],
                                      ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: context.verticalPaddingNormal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                              ),
                              onPressed: () {
                                if (state.event?.group == null) return;
                                context.router.push(
                                  GroupDetailRoute(
                                    group: state.event?.group,
                                  ),
                                );
                              },
                              child: Row(
                                children: [
                                  Container(
                                    height: 32.0,
                                    width: 32.0,
                                    margin: const EdgeInsets.only(right: 8.0),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: state.event?.group?.iconUrl
                                                  .isNotNullOrNoEmpty ==
                                              true
                                          ? DecorationImage(
                                              image: NetworkImage(
                                                  state.event?.group?.iconUrl ??
                                                      event.group?.iconUrl ??
                                                      ""),
                                              fit: BoxFit.cover,
                                            )
                                          : DecorationImage(
                                              image: AssetImage(ImageConstants
                                                  .defaultGroupPhoto.imagePath),
                                              fit: BoxFit.cover,
                                            ),
                                      boxShadow: [
                                        BoxShadow(
                                          offset: const Offset(0, 4),
                                          blurRadius: 4.0,
                                          color: Colors.black.withOpacity(0.25),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    state.event?.group?.name ??
                                        event.group?.name ??
                                        "",
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ],
                              ),
                            ),
                            TextButton(
                              /* style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                              ), */
                              onPressed: () {
                                context.router.push(ProfileListRoute(
                                    users: state.event?.userLikeEvents
                                            ?.map((e) => e.user)
                                            .toList() ??
                                        [],
                                    title: "Likeds"));
                              },
                              child: Row(
                                children: [
                                  Container(
                                      padding: context.paddingLow,
                                      child: const Icon(Icons.favorite)),
                                  Text(
                                    state.event?.userLikeEvents?.length
                                            .toString() ??
                                        event.userLikeEvents?.length
                                            .toString() ??
                                        "0",
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(state.event?.description ?? event.description ?? "",
                          style: Theme.of(context).textTheme.titleSmall),
                      Container(
                          margin: context.onlyTopPaddingLow,
                          child: TextButton(
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                            ),
                            onPressed: () {
                              context.router.push(
                                ProfileListRoute(
                                    users: state.event?.eventAttendees
                                            ?.map((e) => e.user)
                                            .toList() ??
                                        [],
                                    title: "Attendees"),
                              );
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                    padding: context.horizontalPaddingLow,
                                    child: const Icon(Icons.group)),
                                Text(
                                  "${state.event?.eventAttendees?.length ?? event.eventAttendees?.length} Attendees",
                                  style: context.textTheme.bodyLarge,
                                ),
                              ],
                            ),
                          )),
                      Container(
                          padding: context.verticalPaddingLow,
                          child: const Divider()),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: AutoSizeText(
                                    "Where is the event ?",
                                    maxFontSize: 25,
                                    minFontSize: 12,
                                    style: context.textTheme.headlineMedium
                                        ?.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                TextButton(
                                    onPressed: () {},
                                    child: AutoSizeText(
                                      "View On Map",
                                      style: TextStyle(
                                          color: context.colorScheme.secondary),
                                    ))
                              ],
                            ),
                            state.isLoading
                                ? Container(
                                    padding: context.verticalPaddingNormal,
                                    child: const SkeletonLine())
                                : Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        padding: context.onlyTopPaddingLow,
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.location_on,
                                              size: 25,
                                              color:
                                                  context.colorScheme.outline,
                                            ),
                                            Container(
                                              padding:
                                                  context.onlyLeftPaddingLow,
                                              width: context.dynamicWidth(0.8),
                                              child: Text(
                                                  state.event?.eventAddress ??
                                                      "",
                                                  style: context
                                                      .textTheme.titleSmall),
                                            ),
                                          ],
                                        ),
                                      ),
                                      /*  */
                                    ],
                                  ),
                            Container(
                              margin: context.onlyTopPaddingNormal,
                              height: context.dynamicWidth(0.5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16.0),
                                color: context.colorScheme.primary,
                              ),
                              child: state.isLoading
                                  ? SkeletonAvatar(
                                      style: SkeletonAvatarStyle(
                                          width: context.dynamicWidth(0.9)),
                                    )
                                  : GoogleMap(
                                      cameraTargetBounds:
                                          CameraTargetBounds.unbounded,
                                      initialCameraPosition: CameraPosition(
                                          target: LatLng(
                                              double.parse(
                                                  state.event?.eventLat ?? "0"),
                                              double.parse(
                                                  state.event?.eventLng ??
                                                      "0")),
                                          zoom: 15.0),
                                      compassEnabled: false,
                                      zoomControlsEnabled: false,
                                      markers: {
                                        Marker(
                                          markerId: const MarkerId("1"),
                                          position: LatLng(
                                              double.parse(
                                                  state.event?.eventLat ?? "0"),
                                              double.parse(
                                                  state.event?.eventLng ??
                                                      "0")),
                                        )
                                      },
                                    ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: context.verticalPaddingNormal,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: context.paddingLow,
                              child: Text(
                                "Interested Groups",
                                style: context.textTheme.headlineMedium
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              height: context.dynamicHeight(0.3),
                              child: state.isLoading
                                  ? ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: 5,
                                      itemBuilder: (context, index) =>
                                          Container(
                                        padding: context.paddingLow,
                                        width: context.dynamicWidth(0.5),
                                        child: const SkeletonAvatar(),
                                      ),
                                    )
                                  : ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: state.groups?.length ?? 0,
                                      itemBuilder: (context, index) =>
                                          Container(
                                        padding: context.paddingLow,
                                        width: context.dynamicWidth(0.5),
                                        child: GroupCard(
                                          group: state.groups?[index],
                                        ),
                                      ),
                                    ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          bottomNavigationBar: state.isLoading
              ? const SizedBox()
              : Container(
                  decoration: BoxDecoration(
                      border: Border(
                          top: BorderSide(
                    width: 1.0,
                    color: context.colorScheme.outline.withOpacity(0.1),
                  ))),
                  padding: context.horizontalPaddingNormal,
                  height: 80.0,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: context.dynamicHeight(0.072),
                          width: context.dynamicHeight(0.072),
                          child: OutlinedButton(
                              onPressed: state.likingLoading
                                  ? null
                                  : () {
                                      if (state.isLiked == true) {
                                        context
                                            .read<EventDetailCubit>()
                                            .dislikeEvent();
                                      } else {
                                        context
                                            .read<EventDetailCubit>()
                                            .likeEvent();
                                      }
                                    },
                              style: OutlinedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(13.0),
                                  ),
                                  padding: EdgeInsets.zero),
                              child: state.isLiked == true
                                  ? const Icon(Icons.favorite)
                                  : const Icon(Icons.favorite_border_outlined)),
                        ),
                        SizedBox(
                          width: context.dynamicWidth(0.75),
                          height: context.dynamicHeight(0.075),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                            ),
                            onPressed: state.event?.group?.owner?.id ==
                                        FirebaseAuth
                                            .instance.currentUser?.uid ||
                                    event.group?.owner?.id ==
                                        FirebaseAuth.instance.currentUser?.uid
                                ? () {}
                                : state.attendingLoading
                                    ? null
                                    : () {
                                        if (state.isAttended == true) {
                                          context
                                              .read<EventDetailCubit>()
                                              .leftGroup();
                                        } else {
                                          context
                                              .read<EventDetailCubit>()
                                              .attendEvent();
                                        }
                                      },
                            child: Text(
                                state.event?.group?.owner?.id ==
                                            FirebaseAuth
                                                .instance.currentUser?.uid ||
                                        event.group?.owner?.id ==
                                            FirebaseAuth
                                                .instance.currentUser?.uid
                                    ? "Your Event !"
                                    : state.isAttended == true
                                        ? "Left Event"
                                        : "Attend to Event",
                                style:
                                    context.textTheme.headlineLarge?.copyWith(
                                  fontSize: 16,
                                  wordSpacing: 1.5,
                                  letterSpacing: 0.8,
                                  fontWeight: FontWeight.w400,
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => EventDetailCubit()..init(event.id ?? ""),
      child: this,
    );
  }
}

class EventDetailScrollControl extends StatelessWidget {
  const EventDetailScrollControl({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32.0,
      padding: EdgeInsets.zero,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: context.colorScheme.background,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(32.0),
          topRight: Radius.circular(32.0),
        ),
      ),
      child: Container(
        width: 40.0,
        height: 5.0,
        decoration: BoxDecoration(
          color: context.colorScheme.outline,
          borderRadius: BorderRadius.circular(100.0),
        ),
      ),
    );
  }
}
