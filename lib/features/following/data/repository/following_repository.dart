import '../../../../core/error/error_extension.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/error_separator.dart';
import '../../../../product/models/response_data.dart';
import '../../domain/models/request/following_request.dart';
import '../../domain/models/response/following_response.dart';
import '../data_access/following_service.dart';

abstract class IFollowingRepository {
  Future<FollowingResponse?> add(FollowingRequest FollowingRequest);
  Future<ResponseData?> delete(String id);
}

@Injectable(as: IFollowingRepository)
class FollowingRepository implements IFollowingRepository {
  final IFollowingService _followingService;
  final ErrorSeparator _errorSeparator;

  FollowingRepository(this._followingService, this._errorSeparator);

  @override
  Future<FollowingResponse?> add(FollowingRequest followingRequest) async {
    return await _followingService.add(followingRequest).catchError((error) =>
        throw _errorSeparator.createError(error, StackTrace.current).handle());
  }

  @override
  Future<ResponseData?> delete(String id) async {
    return await _followingService.delete(id).catchError((error) =>
        throw _errorSeparator.createError(error, StackTrace.current).handle());
  }
}
