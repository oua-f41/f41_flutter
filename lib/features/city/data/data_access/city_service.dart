import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/http.dart';

import '../../../../product/models/core_models/city.dart';

part 'city_service.g.dart';

abstract class ICityService {
  Future<List<City>?> getAll();
  Future<City?> getByCityName(@Query("cityName") String cityName);
}

@RestApi()
@Injectable(as: ICityService)
abstract class CityManager implements ICityService {
  @factoryMethod
  factory CityManager(Dio dio) => _CityManager(dio);

  @override
  @GET("/cities/getAll")
  Future<List<City>?> getAll();

  @override
  @GET("/cities/getByName")
  Future<City?> getByCityName(@Query("cityName") String cityName);
}
