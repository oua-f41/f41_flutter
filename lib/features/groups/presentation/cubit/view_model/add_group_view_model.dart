import 'package:connectopia/core/presentation/base_view_model.dart';
import 'package:connectopia/features/groups/domain/models/request/group_request.dart';
import 'package:flutter/material.dart';

import '../../../../category/domain/models/response/category_response.dart';

class AddGroupViewModel extends BaseViewModel {
  GroupRequest groupRequest;
  GlobalKey<FormState> formKey;
  CategoryResponse? selectedCategory;

  AddGroupViewModel(
      {required this.groupRequest,
      required this.formKey,
      this.selectedCategory});

  AddGroupViewModel copyWith({
    GroupRequest? groupRequest,
    GlobalKey<FormState>? formKey,
    CategoryResponse? selectedCategory,
  }) {
    return AddGroupViewModel(
      groupRequest: groupRequest ?? this.groupRequest,
      formKey: formKey ?? this.formKey,
      selectedCategory: selectedCategory ?? this.selectedCategory,
    );
  }

  @override
  List<Object?> get props => [groupRequest, formKey, selectedCategory];
}
