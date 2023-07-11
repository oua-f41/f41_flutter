import 'package:connectopia/app/app_router.dart';
import 'package:connectopia/features/category/data/cache/category_cache_manager.dart';
import 'package:connectopia/features/main/presentation/cubit/main_cubit.dart';
import 'package:connectopia/features/weather/presentation/cubit/weather_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import '../../app/connectopia_app_cubit.dart';
import '../../core/helpers/properties_app.dart';

import '../../core/error/default_error_factory.dart';
import '../../core/error/error_factory.dart';
import '../../core/error/error_separator.dart';
import '../cache/application_properties_manager.dart';
import 'injection.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies() async {
  getIt.init();

  getIt.registerLazySingleton(() => ConnectopiaAppCubit());
  getIt.registerLazySingleton<AppRouter>(() => AppRouter());

  getIt.registerLazySingleton(() => ErrorFactory);
  getIt.registerLazySingleton(() => DefaultErrorFactory());
  getIt.registerLazySingleton(() => ErrorSeparator(getIt.get()));

  getIt.registerLazySingleton(() => PropertiesApp());

  getIt.registerLazySingleton(() => ApplicationPropertiesManager());

  getIt.registerLazySingleton(() => MainCubit());

  getIt.registerLazySingleton(() => CategoryCacheManager());
  getIt.registerLazySingleton(() => WeatherCubit());
}
