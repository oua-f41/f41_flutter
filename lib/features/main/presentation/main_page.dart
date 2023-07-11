import 'package:auto_route/auto_route.dart';
import 'package:connectopia/features/main/presentation/cubit/main_cubit.dart';
import 'package:connectopia/features/main/presentation/cubit/view_model/main_view_model.dart';
import 'package:connectopia/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartal/kartal.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import '../../../../product/models/core_models/user.dart' as ProjectUser;

import '../../../app/app_router.dart';

@RoutePage()
class MainPage extends StatelessWidget with AutoRouteWrapper {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainViewModel>(
      builder: (context, state) {
        return AutoTabsScaffold(
          homeIndex: 2,
          routes: const [
            MapsRoute(),
            HomeRoute(),
            DiscoverRoute(children: [CategoryRoute()]),
            OwnProfileRoute(),
          ],
          bottomNavigationBuilder: (_, tabsRouter) {
            context.read<MainCubit>().setTabsRouter(tabsRouter);
            return SalomonBottomBar(
              items: [
                SalomonBottomBarItem(
                  activeIcon: const Icon(Icons.location_on, size: 27),
                  icon: const Icon(Icons.location_on_outlined, size: 27),
                  title: const Text('Maps'),
                ),
                SalomonBottomBarItem(
                  activeIcon: const Icon(Icons.home, size: 27),
                  icon: const Icon(Icons.home_outlined, size: 27),
                  title: const Text('Home'),
                ),
                SalomonBottomBarItem(
                  activeIcon: const Icon(Icons.explore, size: 27),
                  icon: const Icon(Icons.explore_outlined, size: 27),
                  title: const Text('Discover'),
                ),
                SalomonBottomBarItem(
                  activeIcon: const Icon(Icons.person, size: 27),
                  icon: const Icon(Icons.person_outline, size: 27),
                  title: const Text('Profile'),
                ),
              ],
              backgroundColor: context.colorScheme.background.withOpacity(0.1),
              unselectedItemColor:
                  context.colorScheme.onSurface.withOpacity(0.55),
              selectedItemColor: context.colorScheme.primary,
              margin: EdgeInsets.symmetric(
                  horizontal: context.dynamicWidth(0.05),
                  vertical: context.dynamicHeight(0.013)),
              currentIndex: state.tabsRouter?.activeIndex ?? 1,
              onTap: (int index) {
                state.tabsRouter?.setActiveIndex(index);
              },
            );
          },
        );
      },
    );
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(
        create: (ctx) => MainCubit(),
      ),
      BlocProvider(
          create: (ctx) => ProfileCubit()
            ..init(
                user: ProjectUser.User(
                    id: FirebaseAuth.instance.currentUser?.uid ?? "")))
    ], child: this);
  }
}
