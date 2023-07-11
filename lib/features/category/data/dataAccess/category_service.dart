import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/http.dart';

import '../../domain/models/response/category_details_response.dart';
import '../../domain/models/response/category_response.dart';

part 'category_service.g.dart';

abstract class ICategoryService {
  Future<List<CategoryResponse>?> getAll();
  Future<List<CategoryDetailsResponse?>> getAllWithDetails();
}

@RestApi()
@Injectable(as: ICategoryService)
abstract class CategoryManager implements ICategoryService {
  @factoryMethod
  factory CategoryManager(Dio dio) => _CategoryManager(dio);

  @override
  @GET("/categories/getAll")
  Future<List<CategoryResponse>?> getAll();

  @override
  @GET("/categories/getAllWithDetails")
  Future<List<CategoryDetailsResponse?>> getAllWithDetails();
}
