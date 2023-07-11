import 'package:connectopia/core/presentation/base_view_model.dart';
import 'package:connectopia/features/category/domain/models/response/category_details_response.dart';
import 'package:connectopia/features/category/domain/models/response/category_response.dart';

class CategoryViewModel extends BaseViewModel {
  List<CategoryResponse?>? categories;
  List<CategoryDetailsResponse?>? categoriesWithDetails;

  CategoryViewModel(
      {this.categories, this.categoriesWithDetails, super.isLoading});

  CategoryViewModel copyWith(
      {List<CategoryResponse?>? categories,
      List<CategoryDetailsResponse?>? categoriesWithDetails,
      bool? isLoading}) {
    return CategoryViewModel(
        categories: categories ?? this.categories,
        categoriesWithDetails:
            categoriesWithDetails ?? this.categoriesWithDetails,
        isLoading: isLoading ?? this.isLoading);
  }

  @override
  List<Object?> get props => [categories, categoriesWithDetails, isLoading];
}
