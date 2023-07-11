import 'package:connectopia/features/event/domain/models/request/update_event_request.dart';
import 'package:connectopia/product/models/core_models/event.dart';

import '../../../../core/error/error_extension.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/error_separator.dart';
import '../../../../product/models/response_data.dart';
import '../../domain/models/request/event_request.dart';
import '../dataAccess/event_service.dart';

abstract class IEventRepository {
  Future<List<Event>?> getAll({String? userId, String? cityId});
  Future<List<Event>?> getForUser(String userId);
  Future<Event?> getByEventId(String eventId);
  Future<List<Event>?> getByGroupId(String groupId);
  Future<List<Event>?> getByCityId(String cityId, {String? userId});

  Future<ResponseData?> add(EventRequest request);
  Future<ResponseData?> update(UpdateEventRequest request);
  Future<ResponseData?> delete(String id);
}

@Injectable(as: IEventRepository)
class EventRepository implements IEventRepository {
  final IEventService _eventService;
  final ErrorSeparator _errorSeparator;

  EventRepository(this._eventService, this._errorSeparator);

  @override
  Future<Event?> getByEventId(String id) async {
    return await _eventService.getByEventId(id).catchError((error) =>
        throw _errorSeparator.createError(error, StackTrace.current).handle());
  }

  @override
  Future<List<Event>?> getForUser(String userId) async {
    return await _eventService.getForUser(userId).catchError((error) =>
        throw _errorSeparator.createError(error, StackTrace.current).handle());
  }

  @override
  Future<List<Event>?> getByGroupId(String id) async {
    return await _eventService.getByGroupId(id).catchError((error) =>
        throw _errorSeparator.createError(error, StackTrace.current).handle());
  }

  @override
  Future<List<Event>?> getByCityId(String cityId, {String? userId}) async {
    return await _eventService.getByCityId(cityId, userId: userId).catchError(
        (error) => throw _errorSeparator
            .createError(error, StackTrace.current)
            .handle());
  }

  @override
  Future<ResponseData?> add(EventRequest request) async {
    return await _eventService.add(request).catchError((error) =>
        throw _errorSeparator.createError(error, StackTrace.current).handle());
  }

  @override
  Future<ResponseData?> update(UpdateEventRequest request) async {
    return await _eventService.update(request).catchError((error) =>
        throw _errorSeparator.createError(error, StackTrace.current).handle());
  }

  @override
  Future<ResponseData?> delete(String id) async {
    return await _eventService.delete(id).catchError((error) =>
        throw _errorSeparator.createError(error, StackTrace.current).handle());
  }

  @override
  Future<List<Event>?> getAll({String? userId, String? cityId}) async {
    return await _eventService
        .getAll(userId: userId, cityId: cityId)
        .catchError((error) => throw _errorSeparator
            .createError(error, StackTrace.current)
            .handle());
  }
}
