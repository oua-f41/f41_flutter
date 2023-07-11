import 'package:connectopia/app/connectopia_app_cubit.dart';
import 'package:connectopia/core/helpers/globals.dart';
import 'package:connectopia/product/widgets/info_snack_bar.dart';
import 'package:connectopia/product/di/injection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../app/base_cubit.dart';
import '../../../category/domain/models/response/category_response.dart';
import '../../data/repositories/group_repository.dart';
import '../../domain/models/request/group_request.dart';
import 'view_model/add_group_view_model.dart';

class AddGroupCubit extends BaseCubit<AddGroupViewModel> {
  AddGroupCubit()
      : super(AddGroupViewModel(
            groupRequest: GroupRequest(), formKey: GlobalKey<FormState>()));

  late final IGroupRepository _groupRepository;

  void init() {
    _groupRepository = getIt.get<IGroupRepository>();
  }

  void setGroupName(String groupName) {
    emit(state.copyWith(
        groupRequest: state.groupRequest.copyWith(name: groupName)));
  }

  void setGroupDescription(String groupDescription) {
    emit(state.copyWith(
        groupRequest:
            state.groupRequest.copyWith(description: groupDescription)));
  }

  void setGroupIconUrl(String groupIconUrl) {
    emit(state.copyWith(
        groupRequest: state.groupRequest.copyWith(iconUrl: groupIconUrl)));
  }

  void setGroupCategoryId(CategoryResponse? category) {
    emit(state.copyWith(selectedCategory: category));
  }

  Future<bool> addGroup() async {
    getIt.get<ConnectopiaAppCubit>().changeIsLoading();
    if (state.formKey.currentState!.validate()) {
      if (state.selectedCategory != null) {
        GroupRequest groupRequest = state.groupRequest.copyWith(
            categoryId: state.selectedCategory!.id,
            userId: FirebaseAuth.instance.currentUser!.uid);
        try {
          final response = await _groupRepository.add(groupRequest);
          snackbarKey.currentState!
              .showSnackBar(InfoSnackBar(contentText: response!.message ?? ""));
          getIt.get<ConnectopiaAppCubit>().changeIsLoading();
          return true;
        } catch (error) {
          snackbarKey.currentState!
              .showSnackBar(InfoSnackBar(contentText: "error.toString()"));
          getIt.get<ConnectopiaAppCubit>().changeIsLoading();
          return false;
        }
      } else {
        snackbarKey.currentState!
            .showSnackBar(InfoSnackBar(contentText: "Please select category"));
      }
    }
    getIt.get<ConnectopiaAppCubit>().changeIsLoading();
    return false;
  }
}
