import 'package:auto_route/auto_route.dart';
import '../../../../product/helpers/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartal/kartal.dart';
import 'package:pinput/pinput.dart';

import '../cubit/login_with_phone_cubit.dart';
import '../cubit/view_model/login_with_phone_view_model.dart';

@RoutePage()
class LoginVerifyPhonePage extends StatelessWidget {
  const LoginVerifyPhonePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: context.verticalPaddingMedium,
            child: Text("Verification Code",
                style: context.textTheme.headlineMedium
                    ?.copyWith(fontWeight: FontWeight.w700)),
          ),
          Container(
            padding: context.horizontalPaddingMedium,
            child: BlocBuilder<LoginWithPhoneCubit, LoginWithPhoneViewModel>(
              builder: (context, state) {
                return Text(
                  "Please enter the verification code sent \n to ${state.selectedCountryCode} ${state.phoneNumber?.toNumberFormat}",
                  style: context.textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                );
              },
            ),
          ),
          BlocBuilder<LoginWithPhoneCubit, LoginWithPhoneViewModel>(
            builder: (context, state) {
              return Container(
                padding: context.paddingMedium,
                child: Pinput(
                  controller: state.verifyPhoneNumberController,
                  onCompleted: (value) async {
                    await context.read<LoginWithPhoneCubit>().verifyCode();
                  },
                  onChanged: (value) {
                    context
                        .read<LoginWithPhoneCubit>()
                        .changeVerificationCode(value);
                  },
                  length: 6,
                ),
              );
            },
          ),
          BlocBuilder<LoginWithPhoneCubit, LoginWithPhoneViewModel>(
            builder: (context, state) {
              return TextButton(
                  onPressed: state.durationSeconds == 0
                      ? () {
                          context.read<LoginWithPhoneCubit>().resendCode();
                        }
                      : null,
                  child: Text(
                      "Resend Code ${state.durationSeconds == 0 ? "" : "(${state.durationSeconds})"}"));
            },
          ),
          TextButton(
              onPressed: () {
                context.router.replace(const LoginWithPhoneRoute());
              },
              child: const Text("Wrong Number?")),
        ],
      )),
    );
  }
}
