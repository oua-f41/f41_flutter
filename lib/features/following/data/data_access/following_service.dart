import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/http.dart';

import '../../../../product/models/response_data.dart';
import '../../domain/models/request/following_request.dart';
import '../../domain/models/response/following_response.dart';

part 'following_service.g.dart';

abstract class IFollowingService {
  Future<FollowingResponse?> add(@Body() FollowingRequest followingRequest);
  Future<ResponseData?> delete(@Query("id") String id);
}

@RestApi()
@Injectable(as: IFollowingService)
abstract class FollowingManager implements IFollowingService {
  @factoryMethod
  factory FollowingManager(Dio dio) => _FollowingManager(dio);

  @override
  @POST("/follows/add")
  Future<FollowingResponse?> add(@Body() FollowingRequest followingRequest);

  @override
  @DELETE("/follows/delete")
  Future<ResponseData?> delete(@Query("id") String id);
}
