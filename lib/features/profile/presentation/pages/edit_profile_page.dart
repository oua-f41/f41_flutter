import 'package:auto_route/auto_route.dart';
import 'package:connectopia/features/profile/presentation/cubit/view_model/edit_profile_view_model.dart';
import 'package:connectopia/product/constants/image_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartal/kartal.dart';

import '../../domain/models/response/profile_response.dart';
import '../cubit/edit_profile_cubit.dart';

@RoutePage()
class EditProfilePage extends StatelessWidget with AutoRouteWrapper {
  const EditProfilePage({super.key, required this.profileResponse});

  final ProfileResponse profileResponse;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditProfileCubit, EditProfileViewModel>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            forceMaterialTransparency: true,
          ),
          body: SingleChildScrollView(
            child: Container(
                alignment: Alignment.center,
                child: BlocBuilder<EditProfileCubit, EditProfileViewModel>(
                  builder: (context, state) {
                    return Form(
                      key: state.updateProfileFormKey,
                      child: Column(
                        children: [
                          TextButton(
                            onPressed: () {
                              context
                                  .read<EditProfileCubit>()
                                  .profilePhotoChange();
                            },
                            child: Container(
                              padding: context.paddingNormal,
                              height: 150,
                              width: 150,
                              child: ClipOval(
                                clipBehavior: Clip.antiAlias,
                                child: state.userRequest?.profilePhotoUrl
                                            .isNotNullOrNoEmpty ==
                                        true
                                    ? Image.network(
                                        state.userRequest!.profilePhotoUrl!,
                                        fit: BoxFit.cover,
                                      )
                                    : Image.asset(
                                        ImageConstants
                                            .defaultProfilePhoto.imagePath,
                                        fit: BoxFit.cover),
                              ),
                            ),
                          ),
                          Padding(
                            padding: context.verticalPaddingLow,
                            child: Row(
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
                                    initialValue: state.userRequest?.fullName
                                        ?.split(" ")[0],
                                    onChanged: (value) {
                                      context
                                          .read<EditProfileCubit>()
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
                                    initialValue: state.userRequest?.fullName
                                            ?.split(" ")[1] ??
                                        "",
                                    onChanged: (value) {
                                      context
                                          .read<EditProfileCubit>()
                                          .onFullNameChange(lastName: value);
                                    },
                                    decoration: const InputDecoration(
                                      label: Text('Last Name'),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: context.verticalPaddingLow,
                            child: Row(
                              children: [
                                Container(
                                    padding: context.onlyLeftPaddingMedium,
                                    width: context.dynamicWidth(0.8),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                                .read<EditProfileCubit>()
                                                .onUserNameChange(value);
                                          },
                                          initialValue:
                                              state.userRequest?.userName,
                                          decoration: const InputDecoration(
                                            label: Text('Username'),
                                          ),
                                        ),
                                        state.isExistUserName == true
                                            ? Container(
                                                padding:
                                                    context.onlyLeftPaddingLow,
                                                child: Text(
                                                  "Username is already exist",
                                                  style: TextStyle(
                                                      color: context
                                                          .colorScheme.error),
                                                ))
                                            : const SizedBox()
                                      ],
                                    )),
                              ],
                            ),
                          ),
                          Padding(
                            padding: context.verticalPaddingLow,
                            child: Container(
                                padding: context.horizontalPaddingMedium,
                                child: TextFormField(
                                  onChanged: (value) {
                                    context
                                        .read<EditProfileCubit>()
                                        .onEmailChange(value);
                                  },
                                  initialValue: state.userRequest?.email,
                                  decoration: const InputDecoration(
                                    labelText: 'Email',
                                  ),
                                )),
                          ),
                          Padding(
                            padding: context.verticalPaddingLow,
                            child: Container(
                                padding: context.horizontalPaddingMedium,
                                child: TextFormField(
                                  onChanged: (value) {
                                    context
                                        .read<EditProfileCubit>()
                                        .onPhoneNumberChange(value);
                                  },
                                  initialValue:
                                      state.userRequest?.phoneNumber ?? "",
                                  decoration: const InputDecoration(
                                    labelText: 'Phone Number',
                                  ),
                                )),
                          ),
                          Padding(
                            padding: context.verticalPaddingLow,
                            child: Container(
                                padding: context.horizontalPaddingMedium,
                                child: TextFormField(
                                  onChanged: (value) {
                                    context
                                        .read<EditProfileCubit>()
                                        .onAboutChange(value);
                                  },
                                  maxLines: 3,
                                  initialValue: state.userRequest?.about,
                                  decoration: const InputDecoration(
                                      labelText: 'About Yourself',
                                      alignLabelWithHint: true),
                                )),
                          ),
                        ],
                      ),
                    );
                  },
                )),
          ),
          floatingActionButton: FloatingActionButton(
              child: const Icon(Icons.done),
              onPressed: () async {
                bool isSuccess =
                    await context.read<EditProfileCubit>().updateUser();
                if (isSuccess) {
                  context.router.pop(true);
                }
              }),
        );
      },
    );
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => EditProfileCubit()..init(profileResponse),
      child: this,
    );
  }
}
