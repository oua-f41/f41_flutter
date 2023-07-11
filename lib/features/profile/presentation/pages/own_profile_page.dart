import 'package:auto_route/auto_route.dart';
import 'package:connectopia/features/profile/presentation/cubit/view_model/profile_tabs_view_model.dart';
import 'package:connectopia/features/profile/presentation/cubit/view_model/profile_view_model.dart';
import 'package:connectopia/features/profile/presentation/widgets/user_head.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/profile_cubit.dart';

@RoutePage()
class OwnProfilePage extends StatelessWidget {
  const OwnProfilePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocBuilder<ProfileCubit, ProfileViewModel>(
      builder: (context, state) {
        return FirebaseAuth.instance.currentUser?.uid != null
            ? DefaultTabController(
                length: 4,
                child: RefreshIndicator(
                  notificationPredicate: (notification) {
                    return notification.depth == 2;
                  },
                  displacement: 5,
                  onRefresh: context.read<ProfileCubit>().refresh,
                  child: NestedScrollView(
                    headerSliverBuilder: (context, innerBoxIsScrolled) {
                      return [
                        UserHead(
                            innerBoxIsScrolled: innerBoxIsScrolled,
                            isOwnProfile: state.profileResponse?.id ==
                                FirebaseAuth.instance.currentUser?.uid),
                      ];
                    },
                    body: TabBarView(children: ProfileTabs.getTabs().widgets),
                  ),
                ),
              )
            : const SizedBox();
      },
    ));
  }
}
