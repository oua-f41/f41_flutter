import 'package:connectopia/product/widgets/title_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../groups/presentation/widgets/group_grid.dart';
import '../../../groups/presentation/widgets/group_loading.dart';
import '../cubit/profile_cubit.dart';
import '../cubit/view_model/profile_view_model.dart';

class ProfileAttendedGroups extends StatelessWidget {
  const ProfileAttendedGroups({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileViewModel>(
      builder: (context, state) {
        return state.profileResponse?.userGroups != null &&
                state.profileResponse!.userGroups!.isNotEmpty
            ? Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: GroupGrid(
                    groups: state.profileResponse?.userGroups!
                        .map((e) => e.group)
                        .toList()),
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
