import 'package:connectopia/features/category/domain/models/response/category_details_response.dart';

import '../../../../core/error/error_extension.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/error_separator.dart';
import '../../domain/models/response/category_response.dart';
import '../dataAccess/category_service.dart';

abstract class ICategoryRepository {
  Future<List<CategoryResponse>?> getAll();
  Future<List<CategoryDetailsResponse?>> getAllWithDetails();
}

@Injectable(as: ICategoryRepository)
class CategoryRepository implements ICategoryRepository {
  final ICategoryService _categoryService;
  final ErrorSeparator _errorSeparator;

  CategoryRepository(this._categoryService, this._errorSeparator);

  @override
  Future<List<CategoryResponse>?> getAll() async {
    return await _categoryService.getAll().catchError((error) =>
        throw _errorSeparator.createError(error, StackTrace.current).handle());
  }

  @override
  Future<List<CategoryDetailsResponse?>> getAllWithDetails() async {
    return await _categoryService.getAllWithDetails().catchError((error) =>
        throw _errorSeparator.createError(error, StackTrace.current).handle());
  }
}
