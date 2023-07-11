import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartal/kartal.dart';

import '../../../../product/widgets/title_text.dart';
import '../cubit/register_cubit.dart';
import '../cubit/view_model/register_view_model.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterViewModel>(
      builder: (context, state) {
        return Form(
          key: state.registerFormKey,
          child: Column(
            children: [
              Container(
                  width: context.dynamicWidth(0.9),
                  padding: context.paddingNormal,
                  child: const TitleText(text: "Register ;")),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: context.onlyLeftPaddingMedium,
                    width: context.dynamicWidth(0.48),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter your first name";
                        }
                        return null;
                      },
                      initialValue: state.userRequest?.fullName?.split(" ")[0],
                      onChanged: (value) {
                        context
                            .read<RegisterCubit>()
                            .onFullNameChange(firstName: value);
                      },
                      decoration: const InputDecoration(
                        label: Text('First Name'),
                      ),
                    ),
                  ),
                  Container(
                    padding: context.onlyRightPaddingMedium,
                    width: context.dynamicWidth(0.48),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter your last name";
                        }
                        return null;
                      },
                      initialValue:
                          state.userRequest?.fullName?.split(" ")[1] ?? "",
                      onChanged: (value) {
                        context
                            .read<RegisterCubit>()
                            .onFullNameChange(lastName: value);
                      },
                      decoration: const InputDecoration(
                        label: Text('Last Name'),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                      padding: context.onlyLeftPaddingMedium,
                      width: context.dynamicWidth(0.8),
                      child: Padding(
                        padding: context.verticalPaddingNormal,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please enter your username";
                                }
                                return null;
                              },
                              onChanged: (value) {
                                context
                                    .read<RegisterCubit>()
                                    .onUserNameChange(value);
                              },
                              initialValue: state.userRequest?.userName,
                              decoration: const InputDecoration(
                                label: Text('Username'),
                              ),
                            ),
                            state.isExistUserName == true
                                ? Container(
                                    padding: context.onlyLeftPaddingLow,
                                    child: Text(
                                      "Username is already exist",
                                      style: TextStyle(
                                          color: context.colorScheme.error),
                                    ))
                                : const SizedBox()
                          ],
                        ),
                      )),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
