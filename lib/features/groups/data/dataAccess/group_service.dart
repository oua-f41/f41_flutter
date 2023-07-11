import 'package:dio/dio.dart';
import 'package:connectopia/features/groups/domain/models/request/group_request.dart';
import 'package:connectopia/features/groups/domain/models/request/update_group_request.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/http.dart';

import '../../../../product/models/core_models/group.dart';
import '../../../../product/models/response_data.dart';
import '../../domain/models/response/group_response.dart';

part 'group_service.g.dart';

abstract class IGroupService {
  Future<List<GroupResponse?>?> getAll({@Query("userId") String? userId});
  Future<GroupResponse?> getByGroupId(@Query("groupId") String groupId);
  Future<List<Group>?> getByAttendedUser(@Query("userId") String userId);
  Future<List<GroupResponse>?> getByCategoryId(
      @Query("categoryId") String categoryId,
      {@Query("userId") String? userId});
  Future<ResponseData?> add(@Body() GroupRequest request);
  Future<ResponseData?> update(@Body() UpdateGroupRequest request);
}

@RestApi()
@Injectable(as: IGroupService)
abstract class GroupManager implements IGroupService {
  @factoryMethod
  factory GroupManager(Dio dio) => _GroupManager(dio);

  @override
  @GET("/groups/getAll")
  Future<List<GroupResponse?>?> getAll({@Query("userId") String? userId});

  @override
  @GET("/groups/getById")
  Future<GroupResponse?> getByGroupId(@Query("groupId") String groupId);

  @override
  @GET("/groups/getByAttendedUser")
  Future<List<Group>?> getByAttendedUser(@Query("userId") String userId);

  @override
  @GET("/groups/getByCategoryId")
  Future<List<GroupResponse>?> getByCategoryId(
      @Query("categoryId") String categoryId,
      {@Query("userId") String? userId});

  @override
  @POST("/groups/add")
  Future<ResponseData?> add(@Body() GroupRequest request);

  @override
  @POST("/groups/update")
  Future<ResponseData?> update(@Body() UpdateGroupRequest request);
}
