import 'package:connectopia/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:connectopia/features/profile/presentation/cubit/view_model/profile_view_model.dart';
import 'package:connectopia/product/constants/image_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartal/kartal.dart';

class ProfilePhotoAndBackground extends StatelessWidget {
  const ProfilePhotoAndBackground({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.dynamicHeight(0.25),
      child: BlocBuilder<ProfileCubit, ProfileViewModel>(
        builder: (context, state) {
          return Stack(
            children: [
              Container(
                height: context.dynamicHeight(0.17),
                color: context.colorScheme.primaryContainer,
              ),
              Positioned(
                top: context.dynamicHeight(0.08),
                child: Container(
                    padding: EdgeInsets.all(context.dynamicWidth(0.05)),
                    height: context.dynamicHeight(0.2),
                    width: context.dynamicHeight(0.2),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: context.colorScheme.background, width: 8),
                          borderRadius: BorderRadius.circular(100)),
                      child: ClipOval(
                          clipBehavior: Clip.antiAlias,
                          child: state.profileResponse?.profilePhotoUrl
                                          .isNotNullOrNoEmpty ==
                                      true ||
                                  state.defaultUser?.profilePhotoUrl
                                          .isNotNullOrNoEmpty ==
                                      true
                              ? Image.network(
                                  state.profileResponse?.profilePhotoUrl ??
                                      state.defaultUser?.profilePhotoUrl ??
                                      '',
                                  fit: BoxFit.cover,
                                )
                              : Image.asset(
                                  ImageConstants.defaultProfilePhoto.imagePath,
                                  fit: BoxFit.cover,
                                )),
                    )),
              ),
            ],
          );
        },
      ),
    );
  }
}
