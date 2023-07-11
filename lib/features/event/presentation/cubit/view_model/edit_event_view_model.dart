import 'dart:io';

import 'package:connectopia/core/presentation/base_view_model.dart';
import 'package:connectopia/features/event/domain/models/request/update_event_request.dart';
import 'package:flutter/material.dart';

class EditEventViewModel extends BaseViewModel {
  UpdateEventRequest eventRequest;
  GlobalKey<FormState> formKey;
  File? image;

  EditEventViewModel(
      {required this.eventRequest, required this.formKey, this.image});

  EditEventViewModel copyWith({
    UpdateEventRequest? eventRequest,
    GlobalKey<FormState>? formKey,
    File? image,
  }) {
    return EditEventViewModel(
      eventRequest: eventRequest ?? this.eventRequest,
      formKey: formKey ?? this.formKey,
      image: image ?? this.image,
    );
  }

  @override
  List<Object?> get props => [eventRequest, formKey, image];
}

enum EditEventActions { update, delete }
