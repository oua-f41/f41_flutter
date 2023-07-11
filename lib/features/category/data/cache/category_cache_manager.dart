import 'package:connectopia/core/cache/response_cache_manager.dart';
import 'package:connectopia/features/category/domain/models/response/category_response.dart';
import 'package:connectopia/product/cache/cache_enums.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../../product/constants/hive_constants.dart';

class CategoryCacheManager extends ResponseCacheManager<CategoryResponse> {
  CategoryCacheManager() : super(CacheEnums.categories.name);

  @override
  void registerAdapters() {
    if (!Hive.isAdapterRegistered(HiveConstants.categoryHiveId)) {
      Hive.registerAdapter(CategoryResponseAdapter());
    }
  }
}
