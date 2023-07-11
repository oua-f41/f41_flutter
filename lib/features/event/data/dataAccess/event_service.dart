import 'package:dio/dio.dart';
import 'package:connectopia/features/event/domain/models/request/event_request.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/http.dart';

import '../../../../product/models/core_models/event.dart';
import '../../../../product/models/response_data.dart';
import '../../domain/models/request/update_event_request.dart';

part 'event_service.g.dart';

abstract class IEventService {
  Future<List<Event>?> getAll(
      {@Query("userId") String? userId, @Query("cityId") String? cityId});
  Future<List<Event>?> getForUser(@Query("userId") String userId);
  Future<Event?> getByEventId(@Query("eventId") String eventId);
  Future<List<Event>?> getByGroupId(@Query("groupId") String groupId);
  Future<List<Event>?> getByCityId(@Query("cityId") String cityId,
      {@Query("userId") String? userId});
  Future<ResponseData?> add(@Body() EventRequest request);
  Future<ResponseData?> update(@Body() UpdateEventRequest request);
  Future<ResponseData?> delete(@Query("id") String id);
}

@RestApi()
@Injectable(as: IEventService)
abstract class EventManager implements IEventService {
  @factoryMethod
  factory EventManager(Dio dio) => _EventManager(dio);

  @override
  @GET("/events/getAll")
  Future<List<Event>?> getAll(
      {@Query("userId") String? userId, @Query("cityId") String? cityId});

  @override
  @GET("/events/getById")
  Future<Event?> getByEventId(@Query("eventId") String eventId);

  @override
  @GET("/events/getForUser")
  Future<List<Event>?> getForUser(@Query("userId") String userId);

  @override
  @GET("/events/getByGroupId")
  Future<List<Event>?> getByGroupId(@Query("groupId") String groupId);

  @override
  @GET("/events/getByCity")
  Future<List<Event>?> getByCityId(@Query("cityId") String cityId,
      {@Query("userId") String? userId});

  @override
  @POST("/events/add")
  Future<ResponseData?> add(@Body() EventRequest request);

  @override
  @POST("/events/update")
  Future<ResponseData?> update(@Body() UpdateEventRequest request);

  @override
  @DELETE("/events/delete")
  Future<ResponseData?> delete(@Query("id") String id);
}
