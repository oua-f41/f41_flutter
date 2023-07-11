import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:lottie/lottie.dart';

import '../../../../product/cache/application_properties.dart';
import '../../../../product/cache/application_properties_manager.dart';
import '../../../../product/cache/cache_enums.dart';
import '../../../../product/constants/image_constants.dart';
import '../../../../product/constants/lottie_constants.dart';
import '../../../../product/di/injection.dart';
import '../view_model/main_login_view_model.dart';
import '../widgets/login_option_button.dart';

@RoutePage()
class MainLoginPage extends StatefulWidget {
  const MainLoginPage({super.key});

  @override
  State<MainLoginPage> createState() => _MainLoginPageState();
}

class _MainLoginPageState extends MainLoginViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                  padding: context.onlyBottomPaddingHigh,
                  width: context.dynamicWidth(0.7),
                  child: Lottie.asset(
                      LottieConstants.mainLoginAnimation.lottiePath)),
              Container(
                child: Column(
                  children: [
                    LoginOptionButton(
                      symbol: const Icon(Icons.mail),
                      text: 'Log In with Email',
                      onPressed: () {
                        context.router.replace(const LoginWithEmailRoute());
                      },
                    ),
                    LoginOptionButton(
                      symbol: const Icon(Icons.phone),
                      text: 'Log in with phone',
                      onPressed: () {
                        context.router.replace(const LoginWithPhoneRoute());
                      },
                    ),
                    LoginOptionButton(
                      symbol: Image.asset(ImageConstants.google.imagePath),
                      text: 'Log in with Google',
                      onPressed: () {
                        /* print('Log in with Google'); */
                        signInWtihGoogle();
                      },
                    ),
                    Container(
                      padding: context.onlyTopPaddingNormal,
                      child: TextButton(
                          onPressed: () async {
                            ApplicationPropertiesManager
                                applicationPropertiesManager =
                                getIt.get<ApplicationPropertiesManager>();

                            applicationPropertiesManager.putItem(
                                CacheEnums.applicationProperties.name,
                                applicationPropertiesManager
                                        .getItem(CacheEnums
                                            .applicationProperties.name)
                                        ?.copyWith(isNewUser: false) ??
                                    ApplicationProperties(isNewUser: false));

                            context.router.replace(
                                const MainRoute(children: [HomeRoute()]));
                          },
                          child: Text("- Continue without Login -",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary))),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
