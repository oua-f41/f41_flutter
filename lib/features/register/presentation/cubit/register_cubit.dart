import 'package:connectopia/product/constants/error_constants.dart';
import 'package:flutter/material.dart';

import '../../../../app/app_router.dart';
import '../../../../app/base_cubit.dart';
import '../../../../app/connectopia_app_cubit.dart';
import '../../../../product/di/injection.dart';
import '../../../../product/models/response_data.dart';
import '../../../../product/models/user/request/user_request.dart';
import '../../data/repository/register_repository.dart';
import '../../domain/request/register_request.dart';
import 'view_model/register_view_model.dart';

class RegisterCubit extends BaseCubit<RegisterViewModel> {
  RegisterCubit(UserRequest userRequest)
      : super(RegisterViewModel(
            userRequest: userRequest, registerFormKey: GlobalKey<FormState>()));

  late final IRegisterRepository _registerRepository;

  void init() {
    _registerRepository = getIt.get<IRegisterRepository>();
  }

  void onFullNameChange({String? firstName, String? lastName}) {
    emit(state.copyWith(
        userRequest: state.userRequest?.copyWith(
            fullName:
                "${firstName ?? state.userRequest?.fullName?.split(" ")[0]} ${lastName ?? state.userRequest?.fullName?.split(" ")[1]}")));
    print(state.userRequest?.fullName);
  }

  void onUserNameChange(String userName) {
    emit(state.copyWith(
        userRequest: state.userRequest?.copyWith(userName: userName)));
  }

  Future<void> updateUser() async {
    getIt.get<ConnectopiaAppCubit>().changeIsLoading();
    if (state.registerFormKey.currentState!.validate()) {
      RegisterRequest registerRequest = RegisterRequest(
        id: state.userRequest?.id,
        fullName: state.userRequest?.fullName,
        userName: state.userRequest?.userName,
      );
      try {
        ResponseData? data =
            await _registerRepository.register(registerRequest);
        getIt.get<AppRouter>().replace(const MainRoute());
      } catch (e) {
        if (e == ErrorConstants.userAlreadyExists.value) {
          emit(state.copyWith(isExistUserName: true));
        }
        print(e);
      }
    }
    getIt.get<ConnectopiaAppCubit>().changeIsLoading();
  }
}
