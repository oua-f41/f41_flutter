import 'package:auto_route/auto_route.dart';
import 'package:connectopia/app/app_router.dart';
import 'package:connectopia/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:connectopia/features/profile/presentation/cubit/view_model/profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartal/kartal.dart';

import 'profile_photo_button.dart';
import '../cubit/view_model/profile_tabs_view_model.dart';
import 'profile_photo_and_background.dart';
import 'user_about.dart';
import 'user_informations.dart';
import 'user_operations.dart';

class UserHead extends StatelessWidget {
  const UserHead(
      {super.key,
      required this.innerBoxIsScrolled,
      required this.isOwnProfile});

  final bool innerBoxIsScrolled;
  final bool isOwnProfile;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileViewModel>(
      builder: (context, state) {
        return SliverAppBar(
          scrolledUnderElevation: 0,
          shadowColor: Colors.black,
          //automaticallyImplyLeading: false,
          expandedHeight: context.dynamicHeight(state.profileResponse == null
              ? 0.52
              : //without about 0.52
              state.profileResponse?.about.isNotNullOrNoEmpty == true
                  ? 0.58
                  : 0.5), //without about 0.52
          pinned: true,
          actions: isOwnProfile
              ? [
                  IconButton(
                      onPressed: () {
                        context.router.replace(const SettingsRoute());
                      },
                      icon: const Icon(Icons.settings))
                ]
              : null,
          title: innerBoxIsScrolled
              ? Row(
                  children: [
                    const ProfilePhotoButton(),
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            state.profileResponse!.userName!,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              : null,
          foregroundColor: context.colorScheme.onBackground,
          flexibleSpace: const FlexibleSpaceBar(
            collapseMode: CollapseMode.pin,
            background: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                ProfilePhotoAndBackground(),
                UserInformations(),
                UserAbout(),
                UserOperations(),
              ],
            ),
          ),
          backgroundColor: context.colorScheme.background,
          bottom: TabBar(
            tabs: ProfileTabs.getTabs().tabs,
          ),
        );
      },
    );
  }
}
