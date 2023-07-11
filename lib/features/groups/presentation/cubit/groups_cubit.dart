import 'package:connectopia/app/base_cubit.dart';
import 'package:connectopia/features/category/domain/models/response/category_details_response.dart';
import 'package:connectopia/features/groups/presentation/cubit/view_model/groups_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../product/di/injection.dart';
import '../../data/repositories/group_repository.dart';
import '../../domain/models/response/group_response.dart';

class GroupsCubit extends BaseCubit<GroupsViewModel> {
  GroupsCubit() : super(GroupsViewModel());

  CategoryDetailsResponse? currentCategory;
  late final IGroupRepository _groupRepository;
  List<GroupResponse?>? allGroups;

  void init({CategoryDetailsResponse? currentCategory}) async {
    _groupRepository = getIt.get<IGroupRepository>();
    if (currentCategory != null) {
      emit(state.copyWith(
          currentCategory: currentCategory, groups: currentCategory.groups));
    } else {
      await getAllGroups();
    }
  }

  void changeCategory(CategoryDetailsResponse? category) {
    emit(state.copyWith(currentCategory: category, groups: category?.groups));
  }

  Future<void> getAllGroups() async {
    emit(state.copyWith(isLoading: true));
    if (allGroups == null) {
      final groups = await _groupRepository.getAll(
          userId: FirebaseAuth.instance.currentUser?.uid);
      allGroups = groups;
    }
    emit(state.copyWith(
        currentCategory: CategoryDetailsResponse(), groups: allGroups));
    emit(state.copyWith(isLoading: false));
  }
}
