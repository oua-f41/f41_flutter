import 'package:dio/dio.dart';
import 'package:connectopia/product/models/user/request/user_request.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/http.dart';

import '../../../../product/models/response_data.dart';
import '../../domain/models/response/profile_response.dart';

part 'profile_service.g.dart';

abstract class IProfileService {
  Future<ProfileResponse?> getByUserId(@Query("userId") String userId);
  Future<ResponseData?> updateProfile(UserRequest userRequest);
}

@RestApi()
@Injectable(as: IProfileService)
abstract class ProfileManager implements IProfileService {
  @factoryMethod
  factory ProfileManager(Dio dio) => _ProfileManager(dio);

  @override
  @GET("/users/getById")
  Future<ProfileResponse?> getByUserId(@Query("userId") String userId);

  @override
  @POST("/users/update")
  Future<ResponseData?> updateProfile(@Body() UserRequest userRequest);
}
