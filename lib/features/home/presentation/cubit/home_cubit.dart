import 'package:connectopia/app/base_cubit.dart';
import 'package:connectopia/app/connectopia_app_cubit.dart';
import 'package:connectopia/features/event/data/repository/event_repository.dart';
import 'package:connectopia/features/home/presentation/cubit/view_model/home_view_model.dart';
import 'package:connectopia/product/di/injection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

import '../../../../product/models/core_models/event.dart';
import '../../../groups/data/repositories/group_repository.dart';

class HomeCubit extends BaseCubit<HomeViewModel> {
  HomeCubit() : super(HomeViewModel());

  late final IEventRepository _eventRepository;
  late final IGroupRepository _groupRepository;

  void init() async {
    _eventRepository = getIt.get<IEventRepository>();
    _groupRepository = getIt.get<IGroupRepository>();
    setTitle();
    await getAllDataWithLoading();
  }

  Future<void> refresh() async {
    getAllData();
  }

  Future<void> getAllDataWithLoading() async {
    emit(state.copyWith(isLoading: true));
    await getAllData();
    emit(state.copyWith(isLoading: false));
  }

  Future<void> getAllData() async {
    await getIt.get<ConnectopiaAppCubit>().getCurrentPosition();
    await getSpecials();
    await getByCity();
    await getOtherEvents();
  }

  Future<void> getSpecials() async {
    if (FirebaseAuth.instance.currentUser == null) return;
    try {
      List<Event>? events = await _eventRepository
          .getForUser(FirebaseAuth.instance.currentUser!.uid);
      emit(state.copyWith(events: events));
    } catch (e) {
      print(e);
    }
  }

  Future<void> getByCity() async {
    try {
      if (getIt.get<ConnectopiaAppCubit>().state.currentCity?.id != null) {
        List<Event>? events = await _eventRepository.getByCityId(
            getIt.get<ConnectopiaAppCubit>().state.currentCity!.id!,
            userId: FirebaseAuth.instance.currentUser?.uid);
        emit(state.copyWith(eventsOnCity: events));
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> getOtherEvents() async {
    try {
      List<Event>? events = await _eventRepository.getAll(
          cityId: getIt.get<ConnectopiaAppCubit>().state.currentCity?.id,
          userId: FirebaseAuth.instance.currentUser?.uid);
      emit(state.copyWith(otherEvents: events));
    } catch (e) {
      print(e);
    }
  }

  void setTitle() {
    var now = DateTime.now();
    var formatter = DateFormat('HH:mm');
    var currentTime = formatter.format(now);

    String message;

    if (currentTime.compareTo('06:00') >= 0 &&
        currentTime.compareTo('10:00') <= 0) {
      message = 'Günaydın';
    } else if (currentTime.compareTo('10:00') > 0 &&
        currentTime.compareTo('18:00') <= 0) {
      message = 'Hoş geldin';
    } else if (currentTime.compareTo('18:00') > 0 &&
        currentTime.compareTo('23:00') <= 0) {
      message = 'İyi akşamlar';
    } else {
      message = 'İyi geceler';
    }

    emit(state.copyWith(title: message));
  }
}
