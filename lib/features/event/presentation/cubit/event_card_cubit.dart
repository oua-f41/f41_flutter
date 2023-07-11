import 'package:firebase_auth/firebase_auth.dart';

import '../../../../app/base_cubit.dart';
import '../../../../product/di/injection.dart';
import '../../../../product/models/core_models/event.dart';
import '../../../user_like_event/data/repository/user_like_event_repository.dart';
import '../../../user_like_event/domain/request/user_like_event_request.dart';
import 'view_model/event_card_view_model.dart';

class EventCardCubit extends BaseCubit<EventCardViewModel> {
  EventCardCubit() : super(EventCardViewModel());

  late final IUserLikeEventRepository _userLikeEventRepository;

  void init(Event event) {
    _userLikeEventRepository = getIt.get<IUserLikeEventRepository>();
    emit(state.copyWith(event: event));
    setIsLiked();
    emit(state.copyWith(likeCount: state.event?.userLikeEvents?.length));
  }

  Future<void> likeEvent() async {
    if (FirebaseAuth.instance.currentUser != null) {
      emit(state.copyWith(likeLoading: true));
      setIsLiked(isLikedDirectly: true);
      emit(state.copyWith(likeCount: state.likeCount! + 1));
      try {
        UserLikeEventRequest request = UserLikeEventRequest(
            eventId: state.event!.id!,
            userId: FirebaseAuth.instance.currentUser!.uid);
        final response = await _userLikeEventRepository.add(request);
        emit(state.copyWith(eventLikeId: response?.id));
      } catch (e) {
        print(e);
        setIsLiked(isLikedDirectly: false);
        emit(state.copyWith(likeCount: state.likeCount! - 1));
      }

      emit(state.copyWith(likeLoading: false));
    }
  }

  Future<void> disLikeEvent() async {
    if (FirebaseAuth.instance.currentUser != null) {
      emit(state.copyWith(likeLoading: true));
      setIsLiked(isLikedDirectly: false);
      emit(state.copyWith(likeCount: state.likeCount! - 1));
      try {
        if (state.eventLikeId == null) {
          final userEvent = state.event?.userLikeEvents?.firstWhere(
              (eventUser) =>
                  eventUser.userId == FirebaseAuth.instance.currentUser!.uid);
          emit(state.copyWith(eventLikeId: userEvent?.id));
        }
        if (state.eventLikeId != null) {
          await _userLikeEventRepository.delete(state.eventLikeId!);
        }
      } catch (e) {
        print(e);
        setIsLiked(isLikedDirectly: true);
        emit(state.copyWith(likeCount: state.likeCount! + 1));
      }

      emit(state.copyWith(likeLoading: false));
    }
  }

  void setIsLiked({bool? isLikedDirectly}) {
    if (isLikedDirectly != null) {
      emit(state.copyWith(isLiked: isLikedDirectly));
      return;
    }

    if (state.event?.userLikeEvents != null) {
      final list = state.event?.userLikeEvents?.where(
          (user) => user.userId == FirebaseAuth.instance.currentUser?.uid);
      if (list != null && list.isNotEmpty) {
        emit(state.copyWith(isLiked: true));
        return;
      }
    }

    emit(state.copyWith(isLiked: false));
  }
}
