import 'package:kartal/kartal.dart';

import '../../../../app/base_cubit.dart';
import '../../../../product/di/injection.dart';
import '../../data/cache/category_cache_manager.dart';
import '../../data/repository/category_repository.dart';
import 'view_model/category_view_model.dart';

class CategoryCubit extends BaseCubit<CategoryViewModel> {
  CategoryCubit() : super(CategoryViewModel());

  late final ICategoryRepository _categoryRepository;
  late final CategoryCacheManager _categoryCacheManager;

  void init() async {
    _categoryCacheManager = getIt.get<CategoryCacheManager>();
    _categoryRepository = getIt.get<ICategoryRepository>();
    await getAllCategories();
    await getAllCategoriesWithDetails();
  }

  Future<void> getAllCategories() async {
    emit(state.copyWith(isLoading: true));

    if (_categoryCacheManager.getValues()?.isNotEmpty ?? false) {
      emit(state.copyWith(categories: _categoryCacheManager.getValues()));
      emit(state.copyWith(isLoading: false));
      return;
    }
    try {
      final categoryResponse = await _categoryRepository.getAll();
      if (categoryResponse.isNotNullOrEmpty) {
        _categoryCacheManager.addItems(categoryResponse!);
      }
      emit(state.copyWith(categories: categoryResponse));
    } catch (e) {
      print(e);
    }

    emit(state.copyWith(isLoading: false));
  }

  Future<void> getAllCategoriesWithDetails() async {
    //emit(state.copyWith(isLoading: true));
    final categoryResponse = await _categoryRepository.getAllWithDetails();
    emit(state.copyWith(categoriesWithDetails: categoryResponse));
    //emit(state.copyWith(isLoading: false));
  }
}
