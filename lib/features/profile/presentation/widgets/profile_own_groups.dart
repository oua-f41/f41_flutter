import 'package:connectopia/features/groups/presentation/widgets/group_grid.dart';
import 'package:connectopia/features/groups/presentation/widgets/group_loading.dart';
import 'package:connectopia/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:connectopia/features/profile/presentation/cubit/view_model/profile_view_model.dart';
import 'package:connectopia/product/widgets/title_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileOwnGroups extends StatelessWidget {
  const ProfileOwnGroups({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileViewModel>(
      builder: (context, state) {
        return state.profileResponse?.groups != null &&
                state.profileResponse!.groups!.isNotEmpty
            ? Container(
                padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
                child: GroupGrid(groups: state.profileResponse?.groups),
              )
            : state.isLoading
                ? Container(
                    padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
                    child: const GroupLoading(),
                  )
                : const Center(child: TitleText(text: "No Group"));
      },
    );
  }
}
