// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:connectopia/features/weather/presentation/cubit/weather_cubit.dart';
import 'package:flutter/material.dart';

import 'package:connectopia/app/base_cubit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive_flutter/adapters.dart';

import '../product/helpers/permisson_handler.dart';
import '../core/presentation/base_view_model.dart';
import '../features/city/data/repository/city_repository.dart';
import '../product/cache/application_properties.dart';
import '../product/cache/application_properties_manager.dart';
import '../product/cache/cache_enums.dart';
import '../product/di/injection.dart';
import 'package:geocoding/geocoding.dart';

import '../product/models/core_models/city.dart';

class ConnectopiaAppCubit extends BaseCubit<ConnectopiaAppViewModel> {
  ConnectopiaAppCubit()
      : super(ConnectopiaAppViewModel(
            themeMode: ThemeMode.system, isLoading: false)) {
    init();
  }

  late final ApplicationPropertiesManager _applicationPropertiesManager;
  late final ApplicationProperties? _applicationProperties;
  late final ICityRepository _cityRepository;

  void init() async {
    await Hive.initFlutter();
    await getIt.get<ApplicationPropertiesManager>().init();
    _applicationPropertiesManager = getIt.get<ApplicationPropertiesManager>();
    _cityRepository = getIt.get<ICityRepository>();

    _applicationProperties = _applicationPropertiesManager
        .getItem(CacheEnums.applicationProperties.name);

    if (_applicationProperties?.isDarkMode ?? true) {
      emit(state.copyWith(themeMode: ThemeMode.dark));
    } else {
      emit(state.copyWith(themeMode: ThemeMode.light));
    }

    if (_applicationProperties?.locale != null) {
      if (_applicationProperties?.locale == LocaleKeys.en.name) {
        emit(state.copyWith(localeKey: LocaleKeys.en));
      } else if (_applicationProperties?.locale == LocaleKeys.tr.name) {
        emit(state.copyWith(localeKey: LocaleKeys.tr));
      }
    }

    await getCurrentPosition();
  }

  void changeLocale(LocaleKeys localeKey) {
    emit(state.copyWith(localeKey: localeKey));

    _applicationPropertiesManager.putItem(
        CacheEnums.applicationProperties.name,
        _applicationProperties?.copyWith(locale: localeKey.name) ??
            ApplicationProperties(locale: localeKey.name));
  }

  void changeTheme(ThemeMode themeMode) async {
    emit(state.copyWith(themeMode: themeMode));

    if (state.themeMode == ThemeMode.light) {
      _applicationPropertiesManager.putItem(
          CacheEnums.applicationProperties.name,
          _applicationProperties?.copyWith(isDarkMode: false) ??
              ApplicationProperties(isDarkMode: false));
    } else {
      _applicationPropertiesManager.putItem(
          CacheEnums.applicationProperties.name,
          _applicationProperties?.copyWith(isDarkMode: true) ??
              ApplicationProperties(isDarkMode: true));
    }
  }

  void changeIsLoading({bool? isLoading}) {
    if (isLoading != null) {
      emit(state.copyWith(isLoading: isLoading));
      return;
    }
    emit(state.copyWith(isLoading: !state.isLoading));
  }

  Future<void> getCurrentPosition() async {
    final hasPermission = await PermissonHandler.handleLocationPermission();
    if (!hasPermission) return;
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      emit(state.copyWith(currentLocation: position));
      try {
        List<Placemark> placemarks = await placemarkFromCoordinates(
            position.latitude, position.longitude);
        if (placemarks[0].administrativeArea != null) {
          City? city = await _cityRepository
              .getByCityName(placemarks[0].administrativeArea!);
          emit(state.copyWith(currentCity: city));
          if (state.currentCity != null) {
            getIt.get<WeatherCubit>().init();
          }
        }
      } catch (e) {
        print(e);
      }
    } catch (e) {
      print(e);
    }
  }
}

@immutable
class ConnectopiaAppViewModel extends BaseViewModel {
  ConnectopiaAppViewModel(
      {this.localeKey,
      this.themeMode,
      super.isLoading,
      this.currentLocation,
      this.currentCity});

  late LocaleKeys? localeKey;
  late ThemeMode? themeMode;
  Position? currentLocation;
  City? currentCity;

  @override
  List<Object?> get props =>
      [localeKey, isLoading, themeMode, currentLocation, currentCity];

  ConnectopiaAppViewModel copyWith(
      {LocaleKeys? localeKey,
      ThemeMode? themeMode,
      bool? isLoading,
      Position? currentLocation,
      City? currentCity}) {
    return ConnectopiaAppViewModel(
        isLoading: isLoading ?? this.isLoading,
        localeKey: localeKey ?? this.localeKey,
        themeMode: themeMode ?? this.themeMode,
        currentLocation: currentLocation ?? this.currentLocation,
        currentCity: currentCity ?? this.currentCity);
  }
}

enum LocaleKeys { en, tr }
