import 'package:connectopia/core/presentation/base_view_model.dart';
import 'package:connectopia/features/groups/domain/models/request/update_group_request.dart';
import 'package:flutter/material.dart';

import '../../../../category/domain/models/response/category_response.dart';
import '../../../domain/models/request/group_request.dart';

class EditGroupViewModel extends BaseViewModel {
  UpdateGroupRequest? updateGroupRequest;
  GlobalKey<FormState> formKey;
  CategoryResponse? selectedCategory;

  EditGroupViewModel(
      {
      this.updateGroupRequest,
      required this.formKey,
      this.selectedCategory});

  EditGroupViewModel copyWith({
    UpdateGroupRequest? updateGroupRequest,
    GlobalKey<FormState>? formKey,
    CategoryResponse? selectedCategory,
  }) {
    return EditGroupViewModel(
      updateGroupRequest: updateGroupRequest ?? this.updateGroupRequest,
      formKey: formKey ?? this.formKey,
      selectedCategory: selectedCategory ?? this.selectedCategory,
    );
  }

  @override
  List<Object?> get props => [updateGroupRequest, formKey, selectedCategory];
}
