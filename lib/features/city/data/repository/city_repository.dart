import '../../../../core/error/error_extension.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/error_separator.dart';
import '../../../../product/models/core_models/city.dart';
import '../data_access/city_service.dart';

abstract class ICityRepository {
  Future<List<City>?> getAll();
  Future<City?> getByCityName(String cityName);
}

@Injectable(as: ICityRepository)
class CityRepository implements ICityRepository {
  final ICityService _cityService;
  final ErrorSeparator _errorSeparator;

  CityRepository(this._cityService, this._errorSeparator);

  @override
  Future<List<City>?> getAll() async {
    return await _cityService.getAll().catchError((error) =>
        throw _errorSeparator.createError(error, StackTrace.current).handle());
  }

  @override
  Future<City?> getByCityName(String cityName) async {
    return await _cityService.getByCityName(cityName).catchError((error) =>
        throw _errorSeparator.createError(error, StackTrace.current).handle());
  }
}
