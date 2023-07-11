import '../../../../core/error/error_extension.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/error_separator.dart';
import '../../../../product/models/response_data.dart';
import '../../../../product/models/user/request/user_request.dart';
import '../../domain/models/response/profile_response.dart';
import '../dataAccess/profile_service.dart';

abstract class IProfileRepository {
  Future<ProfileResponse?> getByUserId(String userId);
  Future<ResponseData?> updateProfile(UserRequest userRequest);
}

@Injectable(as: IProfileRepository)
class ProfileRepository implements IProfileRepository {
  final IProfileService _profileService;
  final ErrorSeparator _errorSeparator;

  ProfileRepository(this._profileService, this._errorSeparator);

  @override
  Future<ProfileResponse?> getByUserId(String userId) async {
    return await _profileService.getByUserId(userId).catchError((error) =>
        throw _errorSeparator.createError(error, StackTrace.current).handle());
  }

  @override
  Future<ResponseData?> updateProfile(UserRequest userRequest) async {
    return await _profileService.updateProfile(userRequest).catchError(
        (error) => throw _errorSeparator
            .createError(error, StackTrace.current)
            .handle());
  }
}
