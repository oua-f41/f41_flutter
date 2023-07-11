import 'package:auto_route/auto_route.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:kartal/kartal.dart';

import '../../../../product/constants/image_constants.dart';
import '../cubit/login_with_phone_cubit.dart';
import '../cubit/view_model/login_with_phone_view_model.dart';

@RoutePage()
class LoginWithPhonePage extends StatelessWidget {
  const LoginWithPhonePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        onPressed: () {
          context.router.replace(const MainLoginRoute());
        },
      )),
      body: SingleChildScrollView(
        child: Center(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: context.durationLow,
              height: context.isKeyBoardOpen
                  ? context.dynamicHeight(0.3)
                  : context.dynamicHeight(0.45),
              child: SizedBox(
                width: context.dynamicWidth(0.7),
                child: Image.asset(
                  ImageConstants.loginWithPhone.imagePath,
                ),
              ),
            ),
            Padding(
              padding: context.isKeyBoardOpen
                  ? context.onlyTopPaddingNormal
                  : context.onlyTopPaddingMedium,
              child: Container(
                  padding: context.paddingMedium,
                  child: TextField(
                      keyboardType: TextInputType.number,
                      autocorrect: false,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        PhoneInputFormatter(
                            allowEndlessPhone: false, defaultCountryCode: "TR")
                      ],
                      onChanged: (value) {
                        context
                            .read<LoginWithPhoneCubit>()
                            .changePhoneNumber(value);
                      },
                      decoration: InputDecoration(
                          label: const Text("Telefon Numarası"),
                          icon: InkWell(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                BlocBuilder<LoginWithPhoneCubit,
                                    LoginWithPhoneViewModel>(
                                  builder: (context, state) {
                                    return Text(
                                      state.selectedCountryCode ?? "",
                                      style:
                                          Theme.of(context).textTheme.bodyLarge,
                                    );
                                  },
                                ),
                                const Icon(Icons.arrow_drop_down)
                              ],
                            ),
                            onTap: () {
                              showCountryPicker(
                                context: context,
                                showPhoneCode: true,
                                onSelect: (Country country) {
                                  context
                                      .read<LoginWithPhoneCubit>()
                                      .changeSelectedCountryCode(
                                          country.phoneCode);
                                },
                              );
                            },
                          )))),
            ),
            BlocBuilder<LoginWithPhoneCubit, LoginWithPhoneViewModel>(
              builder: (context, state) {
                return ElevatedButton(
                    onPressed: state.phoneNumber?.length != 12
                        ? null
                        : () async {
                            await context
                                .read<LoginWithPhoneCubit>()
                                .sendCode();
                          },
                    child: const Text("Giriş Yap"));
              },
            )
          ],
        )),
      ),
    );
  }
}
