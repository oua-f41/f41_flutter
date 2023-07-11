import 'package:connectopia/core/presentation/base_view_model.dart';
import 'package:connectopia/features/category/domain/models/response/category_details_response.dart';
import 'package:connectopia/product/models/core_models/group.dart';

class GroupsViewModel extends BaseViewModel {
  CategoryDetailsResponse? currentCategory;
  List<Group?>? groups;

  GroupsViewModel({this.currentCategory, this.groups, super.isLoading});

  GroupsViewModel copyWith(
      {CategoryDetailsResponse? currentCategory,
      List<Group?>? groups,
      bool? isLoading}) {
    return GroupsViewModel(
        currentCategory: currentCategory ?? this.currentCategory,
        groups: groups ?? this.groups,
        isLoading: isLoading ?? this.isLoading);
  }

  @override
  List<Object?> get props => [currentCategory, groups, isLoading];
}
