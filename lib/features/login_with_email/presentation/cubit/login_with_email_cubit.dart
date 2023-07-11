import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../app/app_router.dart';
import '../../../../app/base_cubit.dart';
import '../../../../app/connectopia_app_cubit.dart';
import '../../../../product/auth/data/operations/login_operations.dart';
import '../../../../product/di/injection.dart';
import '../../../../product/models/user/request/user_request.dart';
import '../../domain/models/request/login_with_email_request.dart';
import 'view_model/login_with_email_view_model.dart';

class LoginWithEmailCubit extends BaseCubit<LoginWithEmailViewModel> {
  LoginWithEmailCubit()
      : super(LoginWithEmailViewModel(
            loginFormKey: GlobalKey<FormState>(),
            forgotFormKey: GlobalKey<FormState>(),
            loginWithEmailRequest: LoginWithEmailRequest(),
            isVisibePassword: false));

  bool firstTry = true;

  void onEmailChanged(String email) {
    emit(state.copyWith(
        loginWithEmailRequest:
            state.loginWithEmailRequest?.copyWith(email: email)));
    if (!firstTry) {
      state.loginFormKey.currentState?.validate();
      state.forgotFormKey.currentState?.validate();
    }
    print(state.loginWithEmailRequest?.email);
  }

  void onPasswordChanged(String password) {
    emit(state.copyWith(
        loginWithEmailRequest:
            state.loginWithEmailRequest?.copyWith(password: password)));
    if (!firstTry) {
      state.loginFormKey.currentState?.validate();
    }
  }

  void changeIsVisiblePassword() {
    emit(state.copyWith(isVisibePassword: !state.isVisibePassword));
  }

  void changeIsLoading() {
    emit(state.copyWith(isLoading: !state.isLoading));
  }

  Future<void> login() async {
    if (state.loginFormKey.currentState?.validate() ?? false) {
      getIt.get<ConnectopiaAppCubit>().changeIsLoading();
      await loginWithEmailAndPassword();
      getIt.get<ConnectopiaAppCubit>().changeIsLoading();
    }
    firstTry = false;
  }

  Future<void> forgotPassword() async {
    getIt.get<ConnectopiaAppCubit>().changeIsLoading();
    changeIsLoading();
    if (state.forgotFormKey.currentState?.validate() ?? false) {
      await rememberPassword();
    }
    firstTry = false;
    getIt.get<ConnectopiaAppCubit>().changeIsLoading();
  }

  Future<void> createUserWithEmailAndPassword() async {
    try {
      final user = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: state.loginWithEmailRequest?.email ?? "",
        password: state.loginWithEmailRequest?.password ?? "",
      );
      UserRequest createdUser =
          UserRequest(id: user.user!.uid, email: user.user!.email);
      await getIt.get<ILoginOperations>().login(createdUser);
      getIt.get<AppRouter>().replace(RegisterRoute(userRequest: createdUser));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> loginWithEmailAndPassword() async {
    try {
      final user = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: state.loginWithEmailRequest?.email ?? "",
        password: state.loginWithEmailRequest?.password ?? "",
      );
      await getIt
          .get<ILoginOperations>()
          .login(UserRequest(id: user.user!.uid, email: user.user!.email));
      getIt.get<AppRouter>().pop();
      getIt.get<AppRouter>().replace(const MainRoute(children: [HomeRoute()]));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        await createUserWithEmailAndPassword();
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  Future<void> rememberPassword() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: state.loginWithEmailRequest?.email ?? "",
      );
      getIt.get<AppRouter>().pop();
      print("Email sent for reset password");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      }
    }
  }
}
