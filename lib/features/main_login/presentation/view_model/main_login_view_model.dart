import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../../app/app_router.dart';
import '../../../../app/connectopia_app_cubit.dart';
import '../../../../product/auth/data/operations/login_operations.dart';
import '../../../../product/di/injection.dart';
import '../../../../product/models/user/request/user_request.dart';
import '../pages/main_login_page.dart';

abstract class MainLoginViewModel extends State<MainLoginPage> {
  late final ILoginOperations _loginOperations;

  @override
  void initState() {
    super.initState();
    _loginOperations = getIt.get<ILoginOperations>();
  }

  Future<void> signInWtihGoogle() async {
    GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    getIt.get<ConnectopiaAppCubit>().changeIsLoading();

    try {
      UserCredential user =
          await FirebaseAuth.instance.signInWithCredential(credential);
      if (user.user != null) {
        UserRequest createdUserRequest = UserRequest(
            email: user.user!.email,
            fullName: user.user!.displayName,
            phoneNumber: user.user!.phoneNumber,
            profilePhotoUrl: user.user!.photoURL,
            id: user.user!.uid);
        bool isNewUser = await _loginOperations.login(createdUserRequest);
        if (isNewUser) {
          getIt
              .get<AppRouter>()
              .replace(RegisterRoute(userRequest: createdUserRequest));
        } else {
          getIt.get<AppRouter>().replace(const MainRoute(
                children: [HomeRoute()],
              ));
        }
      }
    } catch (e) {
      print(e);
    }

    getIt.get<ConnectopiaAppCubit>().changeIsLoading();
  }
}
