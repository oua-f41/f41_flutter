// ignore: must_be_immutable
import '../../../../../core/presentation/base_view_model.dart';
import '../../../../../product/models/core_models/user.dart';
import '../../../domain/models/response/profile_response.dart';

class ProfileViewModel extends BaseViewModel {
  ProfileResponse? profileResponse;
  User? defaultUser;
  bool followingLoading;

  ProfileViewModel(
      {this.profileResponse,
      this.defaultUser,
      super.isLoading,
      this.followingLoading = false});

  ProfileViewModel copyWith({
    ProfileResponse? profileResponse,
    User? defaultUser,
    bool? isLoading,
    bool? followingLoading,
  }) {
    return ProfileViewModel(
      profileResponse: profileResponse ?? this.profileResponse,
      defaultUser: defaultUser ?? this.defaultUser,
      isLoading: isLoading ?? this.isLoading,
      followingLoading: followingLoading ?? this.followingLoading,
    );
  }

  @override
  List<Object?> get props =>
      [profileResponse, defaultUser, isLoading, followingLoading];
}
