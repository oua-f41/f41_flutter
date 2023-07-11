import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/http.dart';

import '../../domain/weater.dart';

part 'weather_service.g.dart';

abstract class IWeatherService {
  Future<Weather?> getWeatherByCity(
      @Query("key") String key, @Query("q") String cityName);
}

@RestApi()
@Injectable(as: IWeatherService)
abstract class WeatherManager implements IWeatherService {
  @factoryMethod
  factory WeatherManager(Dio dio) => _WeatherManager(dio);

  @override
  @GET("https://api.weatherapi.com/v1/current.json")
  Future<Weather?> getWeatherByCity(
      @Query("key") String key, @Query("q") String cityName);
}
