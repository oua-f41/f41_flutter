import '../../../../../core/presentation/base_view_model.dart';
import '../../../../../product/models/core_models/event.dart';

class EventCardViewModel extends BaseViewModel {
  Event? event;
  bool likeLoading;
  bool? isLiked;
  int? likeCount;
  String? eventLikeId;

  EventCardViewModel(
      {this.event,
      this.likeLoading = false,
      this.isLiked,
      bool? isLoading,
      this.likeCount,
      this.eventLikeId});

  EventCardViewModel copyWith({
    Event? event,
    bool? likeLoading,
    bool? isLiked,
    bool? isLoading,
    int? likeCount,
    String? eventLikeId,
  }) {
    return EventCardViewModel(
      event: event ?? this.event,
      likeLoading: likeLoading ?? this.likeLoading,
      isLiked: isLiked ?? this.isLiked,
      isLoading: isLoading ?? this.isLoading,
      likeCount: likeCount ?? this.likeCount,
      eventLikeId: eventLikeId ?? this.eventLikeId,
    );
  }

  @override
  List<Object?> get props =>
      [event, likeLoading, isLiked, isLoading, likeCount, eventLikeId];
}
