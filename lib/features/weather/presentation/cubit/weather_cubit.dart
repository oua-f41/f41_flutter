import 'dart:developer';

import 'package:connectopia/app/base_cubit.dart';
import 'package:connectopia/app/connectopia_app_cubit.dart';
import 'package:connectopia/product/di/injection.dart';

import '../../data/repository/weather_repository.dart';
import '../../domain/weater.dart';
import 'view_model/weather_view_model.dart';

class WeatherCubit extends BaseCubit<WeatherViewModel> {
  WeatherCubit() : super(WeatherViewModel());

  late final IWeatherRepository _weatherRepository;
  final key = "22d34fea1d05422b8eb220702230407";

  void init() async {
    _weatherRepository = getIt.get<IWeatherRepository>();
    await getWeather(
        getIt.get<ConnectopiaAppCubit>().state.currentCity?.name ?? "");
  }

  Future<void> getWeather(String city) async {
    emit(state.copyWith(isLoading: true));
    try {
      Weather? weather = await _weatherRepository.getWeatherByCity(key, city);
      emit(state.copyWith(weather: weather));
    } catch (e) {
      print(e);
    }
    emit(state.copyWith(isLoading: false));
  }
}
