import 'package:connectopia/app/base_cubit.dart';
import 'package:flutter/material.dart';

import '../../../../app/connectopia_app_cubit.dart';
import '../../../../core/helpers/globals.dart';
import '../../../../product/widgets/info_snack_bar.dart';
import '../../../../product/di/injection.dart';
import '../../../../product/models/core_models/category.dart';
import '../../../category/domain/models/response/category_response.dart';
import '../../data/repositories/group_repository.dart';
import '../../domain/models/request/update_group_request.dart';
import '../../domain/models/response/group_response.dart';
import 'view_model/edit_group_view_model.dart';

class EditGroupCubit extends BaseCubit<EditGroupViewModel> {
  EditGroupCubit()
      : super(EditGroupViewModel(
          formKey: GlobalKey<FormState>(),
        ));

  late final IGroupRepository _groupRepository;

  void init(
      {required GroupResponse request, required Category category}) async {
    _groupRepository = getIt.get<IGroupRepository>();
    emit(state.copyWith(
        updateGroupRequest: UpdateGroupRequest(
            id: request.id,
            categoryId: request.categoryId,
            name: request.name,
            description: request.description,
            iconUrl: request.iconUrl),
        selectedCategory: CategoryResponse(
          id: category.id,
          name: category.name,
        )));
  }

  void setRequest(UpdateGroupRequest request) {
    emit(state.copyWith(updateGroupRequest: request));
  }

  void setGroupCategoryId(CategoryResponse? category) {
    emit(state.copyWith(selectedCategory: category));
    print(state.selectedCategory?.toJson());
  }

  void setGroupName(String name) {
    emit(state.copyWith(
        updateGroupRequest: state.updateGroupRequest?.copyWith(name: name)));
  }

  void setGroupDescription(String description) {
    emit(state.copyWith(
        updateGroupRequest:
            state.updateGroupRequest?.copyWith(description: description)));
  }

  Future<bool> updateGroup() async {
    getIt.get<ConnectopiaAppCubit>().changeIsLoading();
    if (state.formKey.currentState!.validate()) {
      try {
        UpdateGroupRequest request = state.updateGroupRequest!.copyWith(
          categoryId: state.selectedCategory?.id,
        );
        await _groupRepository.update(request);
        getIt.get<ConnectopiaAppCubit>().changeIsLoading();
        return true;
      } catch (error) {
        snackbarKey.currentState!
            .showSnackBar(InfoSnackBar(contentText: error.toString()));
        return false;
      }
    }
    getIt.get<ConnectopiaAppCubit>().changeIsLoading();
    return false;
  }
}
