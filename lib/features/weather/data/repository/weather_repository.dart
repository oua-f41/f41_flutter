import '../../../../core/error/error_extension.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/error_separator.dart';
import '../../domain/weater.dart';
import '../data_access/weather_service.dart';

abstract class IWeatherRepository {
  Future<Weather?> getWeatherByCity(String key, String cityName);
}

@Injectable(as: IWeatherRepository)
class WeatherRepository implements IWeatherRepository {
  final IWeatherService _weatherService;
  final ErrorSeparator _errorSeparator;

  WeatherRepository(this._weatherService, this._errorSeparator);

  @override
  Future<Weather?> getWeatherByCity(String key, String cityName) async {
    return await _weatherService.getWeatherByCity(key, cityName).catchError(
        (error) => throw _errorSeparator
            .createError(error, StackTrace.current)
            .handle());
  }
}
