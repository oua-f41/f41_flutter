import 'package:auto_route/auto_route.dart';
import 'package:connectopia/app/app_router.dart';
import 'package:connectopia/app/connectopia_app_cubit.dart';
import 'package:connectopia/product/di/injection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartal/kartal.dart';

import '../../../product/helpers/setup_token.dart';

@RoutePage()
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Settings'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              context.router
                  .replace(const MainRoute(children: [OwnProfileRoute()]));
            },
          )),
      body: Column(
        children: [
          ListTile(
            contentPadding: context.paddingNormal,
            title: const Text('Theme Mode'),
            subtitle: const Text('Change your theme mode'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        title: const Text('Theme Mode'),
                        content: BlocBuilder<ConnectopiaAppCubit,
                            ConnectopiaAppViewModel>(
                          builder: (context, state) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                InkWell(
                                  onTap: () {
                                    context
                                        .read<ConnectopiaAppCubit>()
                                        .changeTheme(ThemeMode.light);
                                    context.pop();
                                  },
                                  child: ListTile(
                                    title: const Text('Light Mode'),
                                    trailing: state.themeMode == ThemeMode.light
                                        ? const Icon(Icons.check)
                                        : const SizedBox(),
                                  ),
                                ),
                                const Divider(),
                                InkWell(
                                  onTap: () {
                                    context
                                        .read<ConnectopiaAppCubit>()
                                        .changeTheme(ThemeMode.dark);
                                    context.pop();
                                  },
                                  child: ListTile(
                                    title: const Text('Dark Mode'),
                                    trailing: state.themeMode == ThemeMode.dark
                                        ? const Icon(Icons.check)
                                        : const SizedBox(),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ));
            },
          ),
          ListTile(
            contentPadding: context.paddingNormal,
            title: const Text('Language'),
            subtitle: const Text('Change your language settings'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        title: const Text('Language'),
                        content: BlocBuilder<ConnectopiaAppCubit,
                            ConnectopiaAppViewModel>(
                          builder: (context, state) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                InkWell(
                                  onTap: () {
                                    context
                                        .read<ConnectopiaAppCubit>()
                                        .changeLocale(LocaleKeys.en);
                                    context.pop();
                                  },
                                  child: ListTile(
                                    title: const Text('English'),
                                    trailing: state.localeKey == LocaleKeys.en
                                        ? const Icon(Icons.check)
                                        : const SizedBox(),
                                  ),
                                ),
                                const Divider(),
                                InkWell(
                                  onTap: () {
                                    context
                                        .read<ConnectopiaAppCubit>()
                                        .changeLocale(LocaleKeys.tr);
                                    context.pop();
                                  },
                                  child: ListTile(
                                    title: const Text('Turkish'),
                                    trailing: state.localeKey == LocaleKeys.tr
                                        ? const Icon(Icons.check)
                                        : const SizedBox(),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ));
            },
          ),
          ListTile(
            contentPadding: context.paddingNormal,
            title: const Text('Sign Out'),
            subtitle: const Text('Sign out from your account'),
            trailing: const Icon(Icons.logout_outlined),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        title: const Text('Are You Sure?'),
                        actions: [
                          TextButton(
                              onPressed: () {
                                context.pop();
                              },
                              child: const Text('Cancel')),
                          OutlinedButton(
                              onPressed: () async {
                                getIt<ConnectopiaAppCubit>().changeIsLoading();
                                await SetupToken.removeTokens();
                                FirebaseAuth.instance.signOut();
                                getIt.get<AppRouter>().pop();
                                getIt.get<AppRouter>().pop();
                                getIt
                                    .get<AppRouter>()
                                    .replace(const MainLoginRoute());
                                getIt.get<AppRouter>().pop();
                                getIt<ConnectopiaAppCubit>().changeIsLoading();
                              },
                              child: const Text('Sign Out')),
                        ],
                      ));
            },
          ),
        ],
      ),
    );
  }
}
