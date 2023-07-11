import 'dart:io';

import 'package:connectopia/app/base_cubit.dart';
import 'package:connectopia/app/connectopia_app_cubit.dart';
import 'package:connectopia/core/helpers/globals.dart';
import 'package:connectopia/features/city/data/repository/city_repository.dart';
import 'package:connectopia/features/event/data/repository/event_repository.dart';
import 'package:connectopia/features/location_picking/domain/models/event_location.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';

import '../../../../core/helpers/image_upload.dart';
import '../../../../product/di/injection.dart';
import '../../../../product/helpers/firebase_utilities.dart';
import '../../../../product/models/core_models/city.dart';
import '../../domain/models/request/event_request.dart';
import 'view_model/add_event_view_model.dart';

class AddEventCubit extends BaseCubit<AddEventViewModel> {
  AddEventCubit()
      : super(AddEventViewModel(
            formKey: GlobalKey<FormState>(), eventRequest: EventRequest()));

  late final IEventRepository _eventRepository;
  late final ICityRepository _cityRepository;
  late final ImageUploadManager _imageUploadManager;

  void init({required String groupId}) {
    _eventRepository = getIt.get<IEventRepository>();
    _cityRepository = getIt.get<ICityRepository>();
    _imageUploadManager = ImageUploadManager(ImageUploadFromLibary());
    emit(state.copyWith(
        eventRequest: state.eventRequest.copyWith(groupId: groupId)));
  }

  void onNameChanged(String value) {
    emit(
        state.copyWith(eventRequest: state.eventRequest.copyWith(name: value)));
  }

  void onDescriptionChanged(String value) {
    emit(state.copyWith(
        eventRequest: state.eventRequest.copyWith(description: value)));
  }

  void selectImage() async {
    CroppedFile? file = await _imageUploadManager.cropWithFetch();
    saveLocalFile(file);
  }

  void saveLocalFile(CroppedFile? file) {
    if (file == null) return;
    emit(state.copyWith(image: File(file.path)));
  }

  void setEventDate(DateTime date) {
    emit(state.copyWith(
        eventRequest: state.eventRequest
            .copyWith(eventDate: "${date.toIso8601String()}Z")));
  }

  Future<void> setEventLocation(EventLocation location) async {
    getIt.get<ConnectopiaAppCubit>().changeIsLoading();
    if (location.city != null) {
      try {
        City? selectedCity =
            await _cityRepository.getByCityName(location.city!);
        emit(state.copyWith(
            eventRequest: state.eventRequest.copyWith(
          cityId: selectedCity?.id,
          eventAddress: location.address,
          eventLat: location.latitude.toString(),
          eventLng: location.longitude.toString(),
        )));
        print(state.eventRequest.toJson());
      } catch (e) {
        snackbarKey.currentState!.showSnackBar(const SnackBar(
          content: Text("Application is not working in this city"),
        ));
        print(e);
      }
    }
    getIt.get<ConnectopiaAppCubit>().changeIsLoading();
  }

  Future<bool> createEvent() async {
    if (state.formKey.currentState!.validate()) {
      getIt.get<ConnectopiaAppCubit>().changeIsLoading();
      try {
        if (state.image != null) {
          TaskSnapshot task = await FirebaseStorage.instance
              .ref(state.image!.path.split("/").last)
              .putData(await state.image!.readAsBytes());

          emit(state.copyWith(
              eventRequest: state.eventRequest.copyWith(
                  eventPhotoUrl: FirebaseUtilities.convertFireStorePath(
                      task.metadata!.fullPath))));
        }
        await _eventRepository.add(state.eventRequest);
      } catch (e) {
        print(e);
        getIt.get<ConnectopiaAppCubit>().changeIsLoading(isLoading: false);
        return false;
      }
      getIt.get<ConnectopiaAppCubit>().changeIsLoading();
      return true;
    }
    return false;
  }
}
