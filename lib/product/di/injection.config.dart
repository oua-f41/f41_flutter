// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i3;
import 'package:connectopia/core/error/error_separator.dart' as _i19;
import 'package:connectopia/core/network/dio.dart' as _i33;
import 'package:connectopia/core/security/secure_storage.dart' as _i34;
import 'package:connectopia/features/category/data/dataAccess/category_service.dart'
    as _i5;
import 'package:connectopia/features/category/data/repository/category_repository.dart'
    as _i18;
import 'package:connectopia/features/city/data/data_access/city_service.dart'
    as _i6;
import 'package:connectopia/features/city/data/repository/city_repository.dart'
    as _i20;
import 'package:connectopia/features/event/data/dataAccess/event_service.dart'
    as _i7;
import 'package:connectopia/features/event/data/repository/event_repository.dart'
    as _i21;
import 'package:connectopia/features/following/data/data_access/following_service.dart'
    as _i8;
import 'package:connectopia/features/following/data/repository/following_repository.dart'
    as _i22;
import 'package:connectopia/features/groups/data/dataAccess/group_service.dart'
    as _i9;
import 'package:connectopia/features/groups/data/repositories/group_repository.dart'
    as _i23;
import 'package:connectopia/features/profile/data/dataAccess/profile_service.dart'
    as _i11;
import 'package:connectopia/features/profile/data/repository/profile_repository.dart'
    as _i25;
import 'package:connectopia/features/register/data/data_access/register_service.dart'
    as _i12;
import 'package:connectopia/features/register/data/repository/register_repository.dart'
    as _i26;
import 'package:connectopia/features/user_attend_event/data/data_access/user_attend_event_service.dart'
    as _i13;
import 'package:connectopia/features/user_attend_event/data/repository/user_attend_event_repository.dart'
    as _i27;
import 'package:connectopia/features/user_group/data/data_access/user_group_service.dart'
    as _i14;
import 'package:connectopia/features/user_group/data/repository/user_group_repository.dart'
    as _i28;
import 'package:connectopia/features/user_like_event/data/data_access/user_like_event_service.dart'
    as _i15;
import 'package:connectopia/features/user_like_event/data/repository/user_like_event_repository.dart'
    as _i29;
import 'package:connectopia/features/weather/data/data_access/weather_service.dart'
    as _i17;
import 'package:connectopia/features/weather/data/repository/weather_repository.dart'
    as _i31;
import 'package:connectopia/product/auth/data/data_access/login_service.dart'
    as _i10;
import 'package:connectopia/product/auth/data/data_access/user_service.dart'
    as _i16;
import 'package:connectopia/product/auth/data/operations/login_operations.dart'
    as _i32;
import 'package:connectopia/product/auth/data/repositories/login_repository.dart'
    as _i24;
import 'package:connectopia/product/auth/data/repositories/user_repository.dart'
    as _i30;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

extension GetItInjectableX on _i1.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final dioModule = _$DioModule();
    final secureStorageModule = _$SecureStorageModule();
    gh.singleton<_i3.Dio>(dioModule.dio());
    gh.singleton<_i4.FlutterSecureStorage>(secureStorageModule.secureStorage());
    gh.factory<_i5.ICategoryService>(() => _i5.CategoryManager(gh<_i3.Dio>()));
    gh.factory<_i6.ICityService>(() => _i6.CityManager(gh<_i3.Dio>()));
    gh.factory<_i7.IEventService>(() => _i7.EventManager(gh<_i3.Dio>()));
    gh.factory<_i8.IFollowingService>(
        () => _i8.FollowingManager(gh<_i3.Dio>()));
    gh.factory<_i9.IGroupService>(() => _i9.GroupManager(gh<_i3.Dio>()));
    gh.factory<_i10.ILoginService>(() => _i10.LoginManager(gh<_i3.Dio>()));
    gh.factory<_i11.IProfileService>(() => _i11.ProfileManager(gh<_i3.Dio>()));
    gh.factory<_i12.IRegisterService>(
        () => _i12.RegisterManager(gh<_i3.Dio>()));
    gh.factory<_i13.IUserAttendEventService>(
        () => _i13.UserAttendEventManager(gh<_i3.Dio>()));
    gh.factory<_i14.IUserGroupService>(
        () => _i14.UserGroupManager(gh<_i3.Dio>()));
    gh.factory<_i15.IUserLikeEventService>(
        () => _i15.UserLikeEventManager(gh<_i3.Dio>()));
    gh.factory<_i16.IUserService>(() => _i16.UserManager(gh<_i3.Dio>()));
    gh.factory<_i17.IWeatherService>(() => _i17.WeatherManager(gh<_i3.Dio>()));
    gh.factory<_i18.ICategoryRepository>(() => _i18.CategoryRepository(
          gh<_i5.ICategoryService>(),
          gh<_i19.ErrorSeparator>(),
        ));
    gh.factory<_i20.ICityRepository>(() => _i20.CityRepository(
          gh<_i6.ICityService>(),
          gh<_i19.ErrorSeparator>(),
        ));
    gh.factory<_i21.IEventRepository>(() => _i21.EventRepository(
          gh<_i7.IEventService>(),
          gh<_i19.ErrorSeparator>(),
        ));
    gh.factory<_i22.IFollowingRepository>(() => _i22.FollowingRepository(
          gh<_i8.IFollowingService>(),
          gh<_i19.ErrorSeparator>(),
        ));
    gh.factory<_i23.IGroupRepository>(() => _i23.GroupRepository(
          gh<_i9.IGroupService>(),
          gh<_i19.ErrorSeparator>(),
        ));
    gh.factory<_i24.ILoginRepository>(() => _i24.LoginRepository(
          gh<_i10.ILoginService>(),
          gh<_i19.ErrorSeparator>(),
        ));
    gh.factory<_i25.IProfileRepository>(() => _i25.ProfileRepository(
          gh<_i11.IProfileService>(),
          gh<_i19.ErrorSeparator>(),
        ));
    gh.factory<_i26.IRegisterRepository>(() => _i26.RegisterRepository(
          gh<_i12.IRegisterService>(),
          gh<_i19.ErrorSeparator>(),
        ));
    gh.factory<_i27.IUserAttendEventRepository>(
        () => _i27.UserAttendEventRepository(
              gh<_i13.IUserAttendEventService>(),
              gh<_i19.ErrorSeparator>(),
            ));
    gh.factory<_i28.IUserGroupRepository>(() => _i28.UserGroupRepository(
          gh<_i14.IUserGroupService>(),
          gh<_i19.ErrorSeparator>(),
        ));
    gh.factory<_i29.IUserLikeEventRepository>(
        () => _i29.UserLikeEventRepository(
              gh<_i15.IUserLikeEventService>(),
              gh<_i19.ErrorSeparator>(),
            ));
    gh.factory<_i30.IUserRepository>(() => _i30.UserRepository(
          gh<_i16.IUserService>(),
          gh<_i19.ErrorSeparator>(),
        ));
    gh.factory<_i31.IWeatherRepository>(() => _i31.WeatherRepository(
          gh<_i17.IWeatherService>(),
          gh<_i19.ErrorSeparator>(),
        ));
    gh.factory<_i32.ILoginOperations>(
        () => _i32.LoginOperations(gh<_i30.IUserRepository>()));
    return this;
  }
}

class _$DioModule extends _i33.DioModule {}

class _$SecureStorageModule extends _i34.SecureStorageModule {}
