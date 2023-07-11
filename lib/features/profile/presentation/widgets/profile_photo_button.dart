import 'package:connectopia/features/main/presentation/cubit/main_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartal/kartal.dart';

import '../cubit/profile_cubit.dart';
import '../cubit/view_model/profile_view_model.dart';
import '../../../../product/constants/image_constants.dart';

class ProfilePhotoButton extends StatelessWidget {
  const ProfilePhotoButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FirebaseAuth.instance.currentUser != null
        ? BlocBuilder<ProfileCubit, ProfileViewModel>(
            builder: (context, state) {
              return Container(
                width: 55,
                height: 55,
                padding: const EdgeInsets.all(14),
                child: InkWell(
                  borderRadius: BorderRadius.circular(100),
                  onTap: () {
                    context.read<MainCubit>().navigateToProfile();
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: state.profileResponse?.profilePhotoUrl
                                .isNotNullOrNoEmpty ==
                            true
                        ? Image.network(
                            state.profileResponse!.profilePhotoUrl!,
                            fit: BoxFit.cover,
                            width: 50,
                            errorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                ImageConstants.defaultProfilePhoto.imagePath,
                                fit: BoxFit.cover,
                              );
                            },
                          )
                        : Image.asset(
                            ImageConstants.defaultProfilePhoto.imagePath,
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
              );
            },
          )
        : const SizedBox();
  }
}
