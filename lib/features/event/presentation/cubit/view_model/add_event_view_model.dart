import 'dart:io';

import 'package:connectopia/core/presentation/base_view_model.dart';
import 'package:connectopia/features/event/domain/models/request/event_request.dart';
import 'package:flutter/material.dart';

class AddEventViewModel extends BaseViewModel {
  EventRequest eventRequest;
  GlobalKey<FormState> formKey;
  File? image;

  AddEventViewModel(
      {required this.eventRequest, required this.formKey, this.image});

  AddEventViewModel copyWith({
    EventRequest? eventRequest,
    GlobalKey<FormState>? formKey,
    File? image,
  }) {
    return AddEventViewModel(
      eventRequest: eventRequest ?? this.eventRequest,
      formKey: formKey ?? this.formKey,
      image: image ?? this.image,
    );
  }

  @override
  List<Object?> get props => [eventRequest, formKey, image];
}
