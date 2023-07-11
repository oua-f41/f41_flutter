import 'package:connectopia/features/groups/domain/models/request/group_request.dart';

import '../../../../core/error/error_extension.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/error_separator.dart';
import '../../../../product/models/core_models/group.dart';
import '../../../../product/models/response_data.dart';
import '../../domain/models/request/update_group_request.dart';
import '../../domain/models/response/group_response.dart';
import '../dataAccess/group_service.dart';

abstract class IGroupRepository {
  Future<List<GroupResponse?>?> getAll({String? userId});
  Future<GroupResponse?> getByGroupId(String groupId);
  Future<List<Group>?> getByAttendedUser(String userId);
  Future<List<GroupResponse>?> getByCategoryId(String categoryId,
      {String? userId});
  Future<ResponseData?> add(GroupRequest request);
  Future<ResponseData?> update(UpdateGroupRequest request);
}

@Injectable(as: IGroupRepository)
class GroupRepository implements IGroupRepository {
  final IGroupService _groupService;
  final ErrorSeparator _errorSeparator;

  GroupRepository(this._groupService, this._errorSeparator);

  @override
  Future<List<GroupResponse?>?> getAll({String? userId}) async {
    return await _groupService.getAll(userId: userId).catchError((error) =>
        throw _errorSeparator.createError(error, StackTrace.current).handle());
  }

  @override
  Future<GroupResponse?> getByGroupId(String id) async {
    return await _groupService.getByGroupId(id).catchError((error) =>
        throw _errorSeparator.createError(error, StackTrace.current).handle());
  }

  @override
  Future<List<Group>?> getByAttendedUser(String userId) async {
    return await _groupService.getByAttendedUser(userId).catchError((error) =>
        throw _errorSeparator.createError(error, StackTrace.current).handle());
  }

  @override
  Future<ResponseData?> add(GroupRequest request) async {
    return await _groupService.add(request).catchError((error) =>
        throw _errorSeparator.createError(error, StackTrace.current).handle());
  }

  @override
  Future<ResponseData?> update(UpdateGroupRequest request) async {
    return await _groupService.update(request).catchError((error) =>
        throw _errorSeparator.createError(error, StackTrace.current).handle());
  }

  @override
  Future<List<GroupResponse>?> getByCategoryId(String categoryId,
      {String? userId}) async {
    return await _groupService
        .getByCategoryId(categoryId, userId: userId)
        .catchError((error) => throw _errorSeparator
            .createError(error, StackTrace.current)
            .handle());
  }
}
