import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:connectopia/app/app_router.dart';
import 'package:connectopia/features/event/presentation/cubit/event_card_cubit.dart';
import 'package:connectopia/features/event/presentation/cubit/view_model/event_card_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartal/kartal.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:skeletons/skeletons.dart';

import '../../../../product/constants/image_constants.dart';
import '../../../../product/models/core_models/event.dart';

class EventCard extends StatelessWidget {
  const EventCard({super.key, this.event});

  final Event? event;

  @override
  Widget build(BuildContext context) {
    return event != null
        ? BlocProvider(
            create: (context) => EventCardCubit()..init(event!),
            child: BlocBuilder<EventCardCubit, EventCardViewModel>(
              builder: (context, state) {
                return Container(
                  child: InkWell(
                    onTap: () {
                      if (event != null) {
                        context.router.push(EventDetailRoute(event: event!));
                      }
                    },
                    child: Container(
                      padding: context.paddingNormal,
                      child: Container(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ClipOval(
                                    child: event?.group?.iconUrl
                                                .isNotNullOrNoEmpty ==
                                            true
                                        ? Image.network(
                                            event!.group!.iconUrl!,
                                            height: 45,
                                            width: 45,
                                            loadingBuilder: (context, child,
                                                loadingProgress) {
                                              if (loadingProgress == null) {
                                                return child;
                                              }
                                              return const SkeletonAvatar(
                                                style: SkeletonAvatarStyle(
                                                    width: 45, height: 45),
                                              );
                                            },
                                            fit: BoxFit.cover,
                                          )
                                        : Image.asset(
                                            ImageConstants
                                                .defaultGroupPhoto.imagePath,
                                            height: 45,
                                            width: 45),
                                  ),
                                  Container(
                                    padding: context.onlyTopPaddingMedium,
                                    alignment: Alignment.center,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Container(
                                          padding:
                                              context.verticalPaddingNormal,
                                          child: Column(
                                            children: [
                                              InkWell(
                                                  focusColor:
                                                      Colors.transparent,
                                                  hoverColor:
                                                      Colors.transparent,
                                                  highlightColor:
                                                      Colors.transparent,
                                                  splashColor:
                                                      Colors.transparent,
                                                  onTap: state.likeLoading
                                                      ? () {}
                                                      : () {
                                                          if (state.isLiked ==
                                                              true) {
                                                            context
                                                                .read<
                                                                    EventCardCubit>()
                                                                .disLikeEvent();
                                                          } else {
                                                            context
                                                                .read<
                                                                    EventCardCubit>()
                                                                .likeEvent();
                                                          }
                                                        },
                                                  child: Icon(
                                                    state.isLiked == true
                                                        ? Icons.favorite
                                                        : Icons
                                                            .favorite_border_outlined,
                                                    color: state.isLiked == true
                                                        ? Colors.red
                                                        : context.colorScheme
                                                            .outline,
                                                  )),
                                              state.likeCount != 0
                                                  ? Text(
                                                      state.likeCount
                                                          .toString(),
                                                      style: TextStyle(
                                                          color: context
                                                              .colorScheme
                                                              .outline))
                                                  : const SizedBox(),
                                            ],
                                          ),
                                        ),
                                        IconButton(
                                            onPressed: () {},
                                            icon: const Icon(
                                              Icons.comment_outlined,
                                            )),
                                        IconButton(
                                            onPressed: () async {
                                              if (state.event?.eventPhotoUrl
                                                      .isNullOrEmpty ==
                                                  true) return;
                                              final response = await Dio().get(
                                                  state.event!.eventPhotoUrl!,
                                                  options: Options(
                                                      responseType:
                                                          ResponseType.bytes));
                                              final bytes = response.data;
                                              final temp =
                                                  await getTemporaryDirectory();
                                              final path = '${temp.path}/temp';
                                              XFile aaa = XFile.fromData(bytes,
                                                  name: 'deneme', path: path);

                                              await Share.shareXFiles([aaa]);
                                            },
                                            icon: const Icon(
                                              Icons.share_outlined,
                                            )),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Container(
                                padding: context.onlyLeftPaddingNormal,
                                alignment: Alignment.centerLeft,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      event?.name ?? '',
                                      style: context.textTheme.titleLarge
                                          ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Container(
                                      padding: context.paddingLow,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '- ${event?.group?.category?.name ?? ''}',
                                            style: context.textTheme.bodyMedium
                                                ?.copyWith(
                                              color:
                                                  context.colorScheme.outline,
                                            ),
                                          ),
                                          Text(
                                            '${DateTime.now().difference(event?.eventDate ?? DateTime.now()).inDays.abs()} days ${DateTime.now().difference(event?.eventDate ?? DateTime.now()).isNegative ? "letter" : "ago"} ',
                                            style: context.textTheme.bodyMedium
                                                ?.copyWith(
                                              color: DateTime.now()
                                                      .difference(
                                                          event?.eventDate ??
                                                              DateTime.now())
                                                      .isNegative
                                                  ? context.colorScheme.outline
                                                  : Colors.red,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                          child: event?.eventPhotoUrl
                                                      .isNotNullOrNoEmpty ==
                                                  true
                                              ? Image.network(
                                                  event!.eventPhotoUrl!,
                                                  loadingBuilder: (context,
                                                          child,
                                                          loadingProgress) =>
                                                      loadingProgress == null
                                                          ? child
                                                          : SkeletonLine(
                                                              style: SkeletonLineStyle(
                                                                  height: context
                                                                      .dynamicWidth(
                                                                          0.8))),
                                                )
                                              : Image.asset(
                                                  ImageConstants
                                                      .defaultGroupPhoto
                                                      .imagePath,
                                                )),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        : const SizedBox();
  }
}
