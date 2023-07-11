import 'package:connectopia/app/base_cubit.dart';
import 'package:connectopia/app/connectopia_app_cubit.dart';
import 'package:connectopia/features/groups/data/repositories/group_repository.dart';
import 'package:connectopia/features/groups/domain/models/request/update_group_request.dart';
import 'package:connectopia/features/groups/presentation/cubit/view_model/group_detail_view_model.dart';
import 'package:connectopia/product/di/injection.dart';
import 'package:connectopia/product/helpers/firebase_utilities.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_cropper/image_cropper.dart';

import '../../../../core/helpers/globals.dart';
import '../../../../core/helpers/image_upload.dart';
import '../../../../product/widgets/info_snack_bar.dart';
import '../../../../product/models/core_models/event.dart';
import '../../../user_group/data/repository/user_group_repository.dart';
import '../../../user_group/domain/models/request/user_group_request.dart';

class GroupDetailCubit extends BaseCubit<GroupDetailViewModel> {
  GroupDetailCubit() : super(GroupDetailViewModel());

  late final IGroupRepository _groupRepository;
  late final IUserGroupRepository _userGroupRepository;

  late final ImageUploadManager _imageUploadManager;

  void init(String groupId) async {
    _groupRepository = getIt<IGroupRepository>();
    _userGroupRepository = getIt<IUserGroupRepository>();
    _imageUploadManager = ImageUploadManager(ImageUploadFromLibary());
    await getGroupById(groupId);
  }

  Future<void> getGroupById(String groupId) async {
    emit(state.copyWith(isLoading: true));
    try {
      final groupResponse = await _groupRepository.getByGroupId(groupId);
      emit(state.copyWith(groupResponse: groupResponse));
      setIsAttended();
    } catch (e) {
      print(e);
    }
    sortEvents();
    emit(state.copyWith(isLoading: false));
  }

  Future<void> refresh() async {
    if (state.groupResponse?.id != null) {
      final groupResponse =
          await _groupRepository.getByGroupId(state.groupResponse!.id!);
      emit(state.copyWith(groupResponse: groupResponse));
      sortEvents();
    }
  }

  void sortEvents() {
    List<Event>? events = state.groupResponse?.events;
    List<Event>? pastEvents = [];
    List<Event>? upcomingEvents = [];
    if (events != null) {
      for (Event event in events) {
        if (event.eventDate == null) return;
        if (event.eventDate!.isBefore(DateTime.now())) {
          pastEvents.add(event);
        } else {
          upcomingEvents.add(event);
        }
      }
      upcomingEvents.sort((a, b) => a.eventDate!.compareTo(b.eventDate!));
      pastEvents.sort((a, b) => b.eventDate!.compareTo(a.eventDate!));
      events = upcomingEvents + pastEvents;
      emit(state.copyWith(
          groupResponse: state.groupResponse?.copyWith(events: events)));
    }
  }

  Future<void> attendGroup() async {
    emit(state.copyWith(attendingLoading: true));

    try {
      UserGroupRequest userGroupRequest = UserGroupRequest(
          groupId: state.groupResponse!.id!,
          userId: FirebaseAuth.instance.currentUser!.uid);
      final response = await _userGroupRepository.add(userGroupRequest);
      snackbarKey.currentState!
          .showSnackBar(InfoSnackBar(contentText: response!.message ?? ""));
      setIsAttended(isAttendedDirectly: true);
      refresh();
    } catch (e) {
      snackbarKey.currentState!
          .showSnackBar(InfoSnackBar(contentText: e.toString()));
    }

    emit(state.copyWith(attendingLoading: false));
  }

  Future<void> leftGroup() async {
    emit(state.copyWith(attendingLoading: true));

    try {
      final userGroup = state.groupResponse?.userGroups?.firstWhere(
          (user) => user.userId == FirebaseAuth.instance.currentUser!.uid);
      if (userGroup?.id != null) {
        final response = await _userGroupRepository.delete(userGroup!.id!);
        snackbarKey.currentState!
            .showSnackBar(InfoSnackBar(contentText: response!.message ?? ""));
        setIsAttended(isAttendedDirectly: false);
        refresh();
      }
    } catch (e) {
      snackbarKey.currentState!
          .showSnackBar(InfoSnackBar(contentText: e.toString()));
    }

    emit(state.copyWith(attendingLoading: false));
  }

  void setIsAttended({bool? isAttendedDirectly}) {
    if (isAttendedDirectly != null) {
      emit(state.copyWith(isAttended: isAttendedDirectly));
      return;
    }

    if (state.groupResponse?.userGroups != null) {
      final list = state.groupResponse?.userGroups?.where(
          (user) => user.userId == FirebaseAuth.instance.currentUser!.uid);
      if (list != null && list.isNotEmpty) {
        emit(state.copyWith(isAttended: true));
        return;
      }
    }

    emit(state.copyWith(isAttended: false));
  }

  Future<void> setGroupIcon() async {
    CroppedFile? pickedImage = await _imageUploadManager.cropWithFetch();

    getIt.get<ConnectopiaAppCubit>().changeIsLoading();

    if (pickedImage != null) {
      TaskSnapshot task = await FirebaseStorage.instance
          .ref(pickedImage.path.split("/").last)
          .putData(await pickedImage.readAsBytes());

      if (state.groupResponse != null) {
        UpdateGroupRequest request = UpdateGroupRequest(
            id: state.groupResponse!.id,
            categoryId: state.groupResponse!.categoryId,
            name: state.groupResponse!.name,
            description: state.groupResponse!.description,
            iconUrl: FirebaseUtilities.convertFireStorePath(
                task.metadata?.fullPath ?? ""));
        try {
          final response = await _groupRepository.update(request);
          if (state.groupResponse!.iconUrl != null ||
              state.groupResponse!.iconUrl != "") {
            try {
              await FirebaseStorage.instance
                  .ref(FirebaseUtilities.convertFireStoreName(
                      state.groupResponse!.iconUrl.toString()))
                  .delete();
            } catch (e) {
              print(e);
            }
          }
          emit(state.copyWith(
              groupResponse: state.groupResponse!.copyWith(
                  iconUrl: FirebaseUtilities.convertFireStorePath(
                      task.metadata?.fullPath ?? ""))));
        } catch (e) {
          print(e);
        }
      }
    }
    getIt.get<ConnectopiaAppCubit>().changeIsLoading();
  }
}
