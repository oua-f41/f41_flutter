import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../widgets/profile_attended_events.dart';
import '../../widgets/profile_attended_groups.dart';
import '../../widgets/profile_liked_events.dart';
import '../../widgets/profile_own_groups.dart';

class ProfileTabs {
  final List<Tab> tabs;
  final List<Widget> widgets;

  ProfileTabs({required this.tabs, required this.widgets});

  static ProfileTabs getTabs() {
    return ProfileTabs(tabs: [
      const Tab(
        child: AutoSizeText(
          "Own \n Groups",
          style: TextStyle(fontWeight: FontWeight.w700),
          textAlign: TextAlign.center,
        ),
      ),
      const Tab(
        child: AutoSizeText(
          "Attended \n Groups",
          style: TextStyle(fontWeight: FontWeight.w700),
          textAlign: TextAlign.center,
        ),
      ),
      const Tab(
        child: AutoSizeText(
          "Attended \n Events",
          style: TextStyle(fontWeight: FontWeight.w700),
          textAlign: TextAlign.center,
        ),
      ),
      const Tab(
        child: AutoSizeText(
          "Liked \n Events",
          style: TextStyle(fontWeight: FontWeight.w700),
          textAlign: TextAlign.center,
        ),
      ),
    ], widgets: [
      const ProfileOwnGroups(),
      const ProfileAttendedGroups(),
      const ProfileAttendedEvents(),
      const ProfileLikedEvents()
    ]);
  }
}
