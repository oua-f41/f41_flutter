// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:connectopia/core/presentation/base_view_model.dart';

import '../../../domain/models/response/group_response.dart';

class GroupDetailViewModel extends BaseViewModel {
  GroupResponse? groupResponse;
  bool? isAttended;
  bool attendingLoading;

  GroupDetailViewModel(
      {this.groupResponse,
      this.isAttended,
      this.attendingLoading = false,
      super.isLoading});

  GroupDetailViewModel copyWith({
    GroupResponse? groupResponse,
    bool? isAttended,
    bool? attendingLoading,
    bool? isLoading,
  }) {
    return GroupDetailViewModel(
      groupResponse: groupResponse ?? this.groupResponse,
      isAttended: isAttended ?? this.isAttended,
      attendingLoading: attendingLoading ?? this.attendingLoading,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props =>
      [groupResponse, isAttended, attendingLoading, isLoading];
}
