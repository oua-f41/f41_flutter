import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../app/app_router.dart';
import '../../../../app/base_cubit.dart';
import '../../../../app/connectopia_app_cubit.dart';
import '../../../../product/auth/data/operations/login_operations.dart';
import '../../../../product/constants/duration_constants.dart';
import '../../../../product/di/injection.dart';
import '../../../../product/models/user/request/user_request.dart';
import 'view_model/login_with_phone_view_model.dart';

class LoginWithPhoneCubit extends BaseCubit<LoginWithPhoneViewModel> {
  LoginWithPhoneCubit()
      : super(LoginWithPhoneViewModel(
            selectedCountryCode: "+90",
            durationSeconds: DurationConstants.verifyPhoneDuration.inSeconds,
            verifyPhoneNumberController: TextEditingController()));

  void changePhoneNumber(String phoneNumber) {
    emit(state.copyWith(phoneNumber: phoneNumber));
  }

  void changeSelectedCountryCode(String selectedCountryCode) {
    emit(state.copyWith(selectedCountryCode: "+$selectedCountryCode"));
  }

  void changeVerificationCode(String verificationCode) {
    emit(state.copyWith(verificationCode: verificationCode));
  }

  void changeLoading() {
    emit(state.copyWith(isLoading: !state.isLoading));
  }

  Future<void> sendCode() async {
    getIt.get<ConnectopiaAppCubit>().changeIsLoading();
    startTimer();
    emit(state.copyWith(
        durationSeconds: DurationConstants.verifyPhoneDuration.inSeconds));
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: "${state.selectedCountryCode}${state.phoneNumber}",
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException e) {
          print(e.message);
          emit(state.copyWith(verificationCode: ""));
        },
        codeSent: (String verificationId, int? resendToken) {
          emit(state.copyWith(verificationId: verificationId));
          getIt.get<AppRouter>().replace(const LoginVerifyPhoneRoute());
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          print("timed out!!!");
        },
        timeout: DurationConstants.verifyPhoneDuration);
    getIt.get<ConnectopiaAppCubit>().changeIsLoading();
  }

  Future<void> resendCode() async {
    getIt.get<ConnectopiaAppCubit>().changeIsLoading();
    startTimer();
    emit(state.copyWith(
        durationSeconds: DurationConstants.verifyPhoneDuration.inSeconds));
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: "${state.selectedCountryCode}${state.phoneNumber}",
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException e) {
          print(e.message);
        },
        codeSent: (String verificationId, int? resendToken) {
          emit(state.copyWith(verificationId: verificationId));
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          print("timed out!!!");
        },
        timeout: DurationConstants.verifyPhoneDuration);
    getIt.get<ConnectopiaAppCubit>().changeIsLoading();
  }

  Future<void> verifyCode() async {
    getIt.get<ConnectopiaAppCubit>().changeIsLoading();
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: state.verificationId ?? "",
          smsCode: state.verificationCode ?? "");
      UserCredential user = await auth.signInWithCredential(credential);
      if (user.user != null) {
        UserRequest createdUser = UserRequest(
          id: user.user!.uid,
          phoneNumber: state.phoneNumber,
        );
        bool isNewUser = await getIt.get<ILoginOperations>().login(createdUser);
        if (isNewUser) {
          getIt
              .get<AppRouter>()
              .replace(RegisterRoute(userRequest: createdUser));
        } else {
          getIt
              .get<AppRouter>()
              .replace(const MainRoute(children: [HomeRoute()]));
        }
      }
    } catch (e) {
      print("$e hata oluştu");
      state.verifyPhoneNumberController?.clear();
    }
    getIt.get<ConnectopiaAppCubit>().changeIsLoading();
  }

  void startTimer() {
    emit(state.copyWith(
        durationSeconds: DurationConstants.verifyPhoneDuration.inSeconds));
    const oneSec = Duration(seconds: 1);
    Timer.periodic(
      oneSec,
      (Timer timer) {
        if (state.durationSeconds == 0) {
          timer.cancel();
        } else {
          emit(state.copyWith(durationSeconds: state.durationSeconds - 1));
        }
      },
    );
  }
}
