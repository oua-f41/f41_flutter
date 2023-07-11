import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';

import '../../../../../core/presentation/base_view_model.dart';
import '../../../../../product/models/user/request/user_request.dart';

class EditProfileViewModel extends BaseViewModel {
  UserRequest? userRequest;
  GlobalKey<FormState> updateProfileFormKey;
  bool? isExistUserName;
  CroppedFile? croppedFile;

  EditProfileViewModel(
      {this.userRequest,
      required this.updateProfileFormKey,
      this.isExistUserName,
      this.croppedFile});

  EditProfileViewModel copyWith({
    UserRequest? userRequest,
    GlobalKey<FormState>? updateProfileFormKey,
    bool? isExistUserName,
    CroppedFile? croppedFile,
  }) {
    return EditProfileViewModel(
      updateProfileFormKey: updateProfileFormKey ?? this.updateProfileFormKey,
      userRequest: userRequest ?? this.userRequest,
      isExistUserName: isExistUserName ?? this.isExistUserName,
      croppedFile: croppedFile ?? this.croppedFile,
    );
  }

  @override
  List<Object?> get props =>
      [userRequest, updateProfileFormKey, isExistUserName, croppedFile];
}
