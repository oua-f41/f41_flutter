import 'package:connectopia/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:connectopia/features/profile/presentation/cubit/view_model/profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartal/kartal.dart';
import 'package:skeletons/skeletons.dart';

class UserAbout extends StatelessWidget {
  const UserAbout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileViewModel>(
      builder: (context, state) {
        return state.profileResponse?.about.isNotNullOrNoEmpty == true ||
                state.defaultUser?.about.isNotNullOrNoEmpty == true
            ? state.isLoading
                ? Container(
            padding: context.horizontalPaddingLow,
            child: SkeletonParagraph())

            : Container(
                    padding: context.horizontalPaddingNormal,
                    height: context.dynamicHeight(0.08),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      state.profileResponse?.about ??
                          state.defaultUser?.about ??
                          '',
                      maxLines: 3,
                    ),
                  )
            : state.isLoading
                ? Container(
          padding: context.horizontalPaddingLow,
            child: SkeletonParagraph())
                : const SizedBox();
      },
    );
  }
}
