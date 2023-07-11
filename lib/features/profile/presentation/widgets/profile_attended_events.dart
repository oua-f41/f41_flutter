import 'package:connectopia/features/event/presentation/widgets/event_card.dart';
import 'package:connectopia/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:connectopia/features/profile/presentation/cubit/view_model/profile_view_model.dart';
import 'package:connectopia/product/widgets/title_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartal/kartal.dart';

class ProfileAttendedEvents extends StatelessWidget {
  const ProfileAttendedEvents({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileViewModel>(
      builder: (context, state) {
        return state.profileResponse?.eventAttendees.isNotNullOrEmpty == true
            ? ListView.separated(
                separatorBuilder: (context, index) => const Divider(
                      height: 1,
                      thickness: 1,
                    ),
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: state.profileResponse?.eventAttendees?.length ?? 0,
                itemBuilder: (context, index) => EventCard(
                      event:
                          state.profileResponse?.eventAttendees?[index].event,
                    ))
            : const Center(child: TitleText(text: "No Event"));
      },
    );
  }
}
