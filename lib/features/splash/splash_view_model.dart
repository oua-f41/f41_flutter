import 'package:auto_route/auto_route.dart';
import 'package:connectopia/features/category/data/cache/category_cache_manager.dart';
import 'package:flutter/material.dart';

import '../../product/cache/application_properties_manager.dart';
import '../../product/cache/cache_enums.dart';
import '../../product/di/injection.dart';
import '../../product/helpers/setup_token.dart';
import 'splash_page.dart';

abstract class SplashViewModel extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    setup();
  }

  Future<void> setup() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await SetupToken.refreshToken();

      ApplicationPropertiesManager applicationPropertiesManager =
          getIt.get<ApplicationPropertiesManager>();
      await applicationPropertiesManager.init();

      CategoryCacheManager categoryCacheManager =
          getIt.get<CategoryCacheManager>();
      await categoryCacheManager.init();

      var applicationProperties = applicationPropertiesManager
          .getItem(CacheEnums.applicationProperties.name);

      Future.delayed(
          const Duration(seconds: 2),
          () => {
                if (applicationProperties?.isNewUser ?? true)
                  {context.router.replace(const OnboardRoute())}
                else
                  {context.router.replace(const HomeRoute())}
              });
    });
  }
}
