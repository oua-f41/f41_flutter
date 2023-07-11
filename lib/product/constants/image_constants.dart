enum ImageConstants {
  google,
  onBoardAnnouncement,
  onBoardNetworking,
  onBoardHelping,
  defaultProfilePhoto,
  defaultGroupPhoto,
  logo,
  locationMarker,
  expandedLogo,
  loginWithPhone,
  loginWithEmail,
  register
}

extension ImageItemsExtention on ImageConstants {
  String _path() {
    switch (this) {
      case ImageConstants.google:
        return "google";
      case ImageConstants.onBoardAnnouncement:
        return "onboard_announcement";
      case ImageConstants.onBoardNetworking:
        return "onboard_networking";
      case ImageConstants.onBoardHelping:
        return "onboard_helping";
      case ImageConstants.defaultProfilePhoto:
        return "default_profile_photo";
      case ImageConstants.defaultGroupPhoto:
        return "default_group_photo";
      case ImageConstants.logo:
        return "logo";
      case ImageConstants.locationMarker:
        return "location_marker";
      case ImageConstants.expandedLogo:
        return "expanded_logo";
      case ImageConstants.loginWithPhone:
        return "login_with_phone";
      case ImageConstants.loginWithEmail:
        return "login_with_email";
      case ImageConstants.register:
        return "register";
    }
  }

  String get imagePath => "assets/images/${_path()}.png";
}
