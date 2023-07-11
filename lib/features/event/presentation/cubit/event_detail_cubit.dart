import 'package:connectopia/app/app_router.dart';
import 'package:connectopia/app/base_cubit.dart';
import 'package:connectopia/features/event/presentation/cubit/view_model/event_detail_view_model.dart';
import 'package:connectopia/features/groups/data/repositories/group_repository.dart';
import 'package:connectopia/features/user_attend_event/data/repository/user_attend_event_repository.dart';
import 'package:connectopia/features/user_like_event/data/repository/user_like_event_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/helpers/globals.dart';
import '../../../../core/helpers/image_upload.dart';
import '../../../../product/widgets/info_snack_bar.dart';
import '../../../../product/di/injection.dart';
import '../../../groups/domain/models/response/group_response.dart';
import '../../../user_attend_event/domain/request/user_attend_event_request.dart';
import '../../../user_like_event/domain/request/user_like_event_request.dart';
import '../../data/repository/event_repository.dart';

class EventDetailCubit extends BaseCubit<EventDetailViewModel> {
  EventDetailCubit() : super(EventDetailViewModel());

  late final ImageUploadManager _imageUploadManager;
  late final IEventRepository _eventRepository;
  late final IUserLikeEventRepository _userLikeEventRepository;
  late final IUserAttendEventRepository _userAttendEventRepository;
  late final IGroupRepository _groupRepository;

  void init(String groupId) async {
    _eventRepository = getIt.get<IEventRepository>();
    _userLikeEventRepository = getIt.get<IUserLikeEventRepository>();
    _userAttendEventRepository = getIt.get<IUserAttendEventRepository>();
    _groupRepository = getIt.get<IGroupRepository>();
    _imageUploadManager = ImageUploadManager(ImageUploadFromLibary());
    await getEventById(groupId);
    await getGroupsSameCategory();
  }

  Future<void> getEventById(String eventId) async {
    emit(state.copyWith(isLoading: true));
    try {
      final eventResponse = await _eventRepository.getByEventId(eventId);
      emit(state.copyWith(event: eventResponse));
      setIsAttended();
      setIsLiked();
    } catch (e) {
      print(e);
    }
    emit(state.copyWith(isLoading: false));
  }

  Future<void> refresh() async {
    if (state.event?.id != null) {
      final event = await _eventRepository.getByEventId(state.event!.id!);
      emit(state.copyWith(event: event));
    }
  }

  Future<void> attendEvent() async {
    emit(state.copyWith(attendingLoading: true));

    try {
      UserAttendEventRequest request = UserAttendEventRequest(
          eventId: state.event!.id!,
          userId: FirebaseAuth.instance.currentUser!.uid);

      await _userAttendEventRepository.add(request);

      setIsAttended(isAttendedDirectly: true);
      refresh();
    } catch (e) {
      snackbarKey.currentState!.showSnackBar(InfoSnackBar(
        contentText: e.toString(),
      ));
    }

    emit(state.copyWith(attendingLoading: false));
  }

  Future<void> leftGroup() async {
    emit(state.copyWith(attendingLoading: true));

    try {
      final eventAttendee = state.event?.eventAttendees?.firstWhere(
          (user) => user.userId == FirebaseAuth.instance.currentUser!.uid);
      if (eventAttendee?.id != null) {
        await _userAttendEventRepository.delete(eventAttendee!.id!);
        setIsAttended(isAttendedDirectly: false);
        refresh();
      }
    } catch (e) {
      print(e);
    }

    emit(state.copyWith(attendingLoading: false));
  }

  void setIsAttended({bool? isAttendedDirectly}) {
    if (isAttendedDirectly != null) {
      emit(state.copyWith(isAttended: isAttendedDirectly));
      return;
    }

    if (state.event?.eventAttendees != null) {
      final list = state.event?.eventAttendees?.where(
          (user) => user.userId == FirebaseAuth.instance.currentUser!.uid);
      if (list != null && list.isNotEmpty) {
        emit(state.copyWith(isAttended: true));
        return;
      }
    }

    emit(state.copyWith(isAttended: false));
  }

  Future<void> likeEvent() async {
    emit(state.copyWith(likingLoading: true));

    try {
      UserLikeEventRequest request = UserLikeEventRequest(
          eventId: state.event!.id!,
          userId: FirebaseAuth.instance.currentUser!.uid);

      await _userLikeEventRepository.add(request);

      setIsLiked(isLikedDirectly: true);
      refresh();
    } catch (e) {
      snackbarKey.currentState!
          .showSnackBar(InfoSnackBar(contentText: e.toString()));
    }

    emit(state.copyWith(likingLoading: false));
  }

  Future<void> dislikeEvent() async {
    emit(state.copyWith(likingLoading: true));

    try {
      final liked = state.event?.userLikeEvents?.firstWhere(
          (user) => user.userId == FirebaseAuth.instance.currentUser!.uid);
      if (liked?.id != null) {
        await _userLikeEventRepository.delete(liked!.id!);
        setIsLiked(isLikedDirectly: false);
        refresh();
      }
    } catch (e) {
      print(e);
    }

    emit(state.copyWith(likingLoading: false));
  }

  void setIsLiked({bool? isLikedDirectly}) {
    if (isLikedDirectly != null) {
      emit(state.copyWith(isLiked: isLikedDirectly));
      return;
    }

    if (state.event?.userLikeEvents != null) {
      final list = state.event?.userLikeEvents?.where(
          (user) => user.userId == FirebaseAuth.instance.currentUser!.uid);
      if (list != null && list.isNotEmpty) {
        emit(state.copyWith(isLiked: true));
        return;
      }
    }

    emit(state.copyWith(isLiked: false));
  }

  Future<void> getGroupsSameCategory() async {
    emit(state.copyWith(isLoading: true));
    try {
      List<GroupResponse>? groups = await _groupRepository.getByCategoryId(
          state.event?.group?.category?.id ?? "",
          userId: FirebaseAuth.instance.currentUser?.uid);
      emit(state.copyWith(
          groups: groups
              ?.where((group) => group.id != state.event?.group?.id)
              .toList()));
    } catch (e) {
      print(e);
    }
    emit(state.copyWith(isLoading: false));
  }
}
