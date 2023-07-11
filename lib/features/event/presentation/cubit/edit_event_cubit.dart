import 'dart:io';

import 'package:connectopia/app/base_cubit.dart';
import 'package:connectopia/features/event/domain/models/request/update_event_request.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';

import '../../../../app/connectopia_app_cubit.dart';
import '../../../../core/helpers/image_upload.dart';
import '../../../../product/di/injection.dart';
import '../../../../product/helpers/firebase_utilities.dart';
import '../../../../product/models/core_models/city.dart';
import '../../../../product/models/core_models/event.dart';
import '../../../city/data/repository/city_repository.dart';
import '../../../location_picking/domain/models/event_location.dart';
import '../../data/repository/event_repository.dart';
import 'view_model/edit_event_view_model.dart';

class EditEventCubit extends BaseCubit<EditEventViewModel> {
  EditEventCubit()
      : super(EditEventViewModel(
          formKey: GlobalKey<FormState>(),
          eventRequest: UpdateEventRequest(),
        ));

  late final IEventRepository _eventRepository;
  late final ICityRepository _cityRepository;
  late final ImageUploadManager _imageUploadManager;

  void init(Event event) {
    _eventRepository = getIt.get<IEventRepository>();
    _cityRepository = getIt.get<ICityRepository>();
    _imageUploadManager = ImageUploadManager(ImageUploadFromLibary());
    emit(state.copyWith(
      eventRequest: UpdateEventRequest(
          id: event.id,
          name: event.name,
          description: event.description,
          cityId: event.cityId,
          eventAddress: event.eventAddress,
          eventLat: event.eventLat,
          eventLng: event.eventLng,
          eventPhotoUrl: event.eventPhotoUrl,
          groupId: event.groupId,
          eventDate: event.eventDate!.toIso8601String()),
    ));
  }

  void onNameChanged(String value) {
    emit(
        state.copyWith(eventRequest: state.eventRequest.copyWith(name: value)));
  }

  void onDescriptionChanged(String value) {
    emit(state.copyWith(
        eventRequest: state.eventRequest.copyWith(description: value)));
  }

  void setEventDate(DateTime date) {
    emit(state.copyWith(
        eventRequest: state.eventRequest
            .copyWith(eventDate: "${date.toIso8601String()}Z")));
  }

  void onAddressChanged(String value) {
    emit(state.copyWith(
        eventRequest: state.eventRequest.copyWith(eventAddress: value)));
  }

  void selectImage() async {
    CroppedFile? file = await _imageUploadManager.cropWithFetch();
    saveLocalFile(file);
  }

  void saveLocalFile(CroppedFile? file) {
    if (file == null) return;
    emit(state.copyWith(image: File(file.path)));
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
        print(e);
      }
    }
    getIt.get<ConnectopiaAppCubit>().changeIsLoading();
  }

  Future<bool> updateEvent() async {
    if (state.formKey.currentState!.validate()) {
      getIt.get<ConnectopiaAppCubit>().changeIsLoading();
      try {
        if (state.image != null) {
          TaskSnapshot task = await FirebaseStorage.instance
              .ref(state.image!.path.split("/").last)
              .putData(await state.image!.readAsBytes());

          if (state.eventRequest.eventPhotoUrl != null ||
              state.eventRequest.eventPhotoUrl != "") {
            try {
              await FirebaseStorage.instance
                  .ref(FirebaseUtilities.convertFireStoreName(
                      state.eventRequest.eventPhotoUrl.toString()))
                  .delete();
            } catch (e) {
              print(e);
            }
          }

          emit(state.copyWith(
              eventRequest: state.eventRequest.copyWith(
                  eventPhotoUrl: FirebaseUtilities.convertFireStorePath(
                      task.metadata!.fullPath))));
        }
        await _eventRepository.update(state.eventRequest);
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

  Future<bool> deleteEvent() async {
    getIt.get<ConnectopiaAppCubit>().changeIsLoading();
    try {
      if (state.eventRequest.id != null) {
        await _eventRepository.delete(state.eventRequest.id!);
        getIt.get<ConnectopiaAppCubit>().changeIsLoading();
        return true;
      }
    } catch (e) {
      print(e);
      getIt.get<ConnectopiaAppCubit>().changeIsLoading();
      return false;
    }
    getIt.get<ConnectopiaAppCubit>().changeIsLoading();
    return false;
  }
}
