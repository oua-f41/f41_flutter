import 'package:connectopia/core/presentation/base_view_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../../product/models/core_models/event.dart';
import '../../../../../product/models/core_models/group.dart';

class EventDetailViewModel extends BaseViewModel {
  Event? event;
  bool? isAttended;
  bool attendingLoading;
  bool? isLiked;
  bool likingLoading;
  List<Group?>? groups;
  GoogleMapController? mapController;

  EventDetailViewModel(
      {this.event,
      this.isAttended,
      this.attendingLoading = false,
      this.isLiked,
      this.likingLoading = false,
      super.isLoading,
      this.groups,
      this.mapController});

  EventDetailViewModel copyWith(
      {Event? event,
      bool? isAttended,
      bool? attendingLoading,
      bool? isLiked,
      bool? likingLoading,
      bool? isLoading,
      List<Group?>? groups,
      GoogleMapController? mapController}) {
    return EventDetailViewModel(
        event: event ?? this.event,
        isAttended: isAttended ?? this.isAttended,
        attendingLoading: attendingLoading ?? this.attendingLoading,
        isLiked: isLiked ?? this.isLiked,
        likingLoading: likingLoading ?? this.likingLoading,
        isLoading: isLoading ?? this.isLoading,
        groups: groups ?? this.groups,
        mapController: mapController ?? this.mapController);
  }

  @override
  List<Object?> get props => [
        event,
        isAttended,
        attendingLoading,
        isLiked,
        likingLoading,
        isLoading,
        groups,
        mapController
      ];
}
