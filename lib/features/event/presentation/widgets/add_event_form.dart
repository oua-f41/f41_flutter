import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:kartal/kartal.dart';

import '../../../../app/app_router.dart';
import '../../../location_picking/domain/models/event_location.dart';
import '../cubit/add_event_cubit.dart';
import '../cubit/view_model/add_event_view_model.dart';

class AddEventForm extends StatelessWidget {
  const AddEventForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddEventCubit, AddEventViewModel>(
      builder: (context, state) {
        return Form(
          key: state.formKey,
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _ImagePicker(),
              _EventNameInput(),
              _EventDescriptionInput(),
              _EventDatePicker(),
              _EventLocationPicker(),
            ],
          ),
        );
      },
    );
  }
}


class _EventLocationPicker extends StatelessWidget {
  const _EventLocationPicker();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddEventCubit, AddEventViewModel>(
      builder: (context, state) {
        return Container(
          padding: context.paddingLow,
          child: InkWell(
            borderRadius: context.normalBorderRadius,
            onTap: () async {
              final location =
                  await context.router.push(LocationPickingRoute());
              if (location is EventLocation) {
                await context.read<AddEventCubit>().setEventLocation(location);
              }
            },
            child: TextFormField(
              validator: (value) {
                if (state.eventRequest.eventAddress == null) {
                  return 'Please select event location';
                }
                return null;
              },
              enabled: false,
              maxLines: 4,
              minLines: 1,
              decoration: InputDecoration(
                hintText: state.eventRequest.eventAddress ?? 'Select Location',
                suffixIcon: state.eventRequest.eventAddress == null
                    ? const Icon(Icons.arrow_forward_ios_rounded)
                    : const Icon(Icons.edit_location_alt_rounded),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _EventDatePicker extends StatelessWidget {
  const _EventDatePicker();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddEventCubit, AddEventViewModel>(
      builder: (context, state) {
        return Container(
          padding: context.paddingLow,
          child: InkWell(
            borderRadius: context.normalBorderRadius,
            onTap: () async {
              DateTime? date = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
              );
              TimeOfDay? time = await showTimePicker(
                  context: context, initialTime: TimeOfDay.now());
              if (date == null || time == null) return;
              DateTime dateTime = DateTime(
                  date.year, date.month, date.day, time.hour, time.minute);
              context.read<AddEventCubit>().setEventDate(dateTime);
            },
            child: TextFormField(
              validator: (value) {
                if (state.eventRequest.eventDate == null) {
                  return 'Please select event date';
                }
                return null;
              },
              enabled: false,
              decoration: InputDecoration(
                hintText: state.eventRequest.eventDate != null
                    ? DateFormat("dd/MM/yyyy  •  hh.mm")
                        .format(DateTime.parse(state.eventRequest.eventDate!))
                    : 'Select Date',
                suffixIcon: state.eventRequest.eventDate == null
                    ? const Icon(Icons.calendar_month_outlined)
                    : const Icon(Icons.edit_calendar_outlined),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _EventDescriptionInput extends StatelessWidget {
  const _EventDescriptionInput();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: context.paddingLow,
      child: TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter event description';
          }
          return null;
        },
        minLines: 2,
        maxLines: 8,
        decoration: const InputDecoration(
            label: Text('Event Description'), alignLabelWithHint: true),
        onChanged: (value) {
          context.read<AddEventCubit>().onDescriptionChanged(value);
        },
      ),
    );
  }
}

class _EventNameInput extends StatelessWidget {
  const _EventNameInput();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: context.paddingLow,
      child: TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter event name';
          }
          return null;
        },
        decoration: const InputDecoration(
          label: Text('Event Name'),
        ),
        onChanged: (value) {
          context.read<AddEventCubit>().onNameChanged(value);
        },
      ),
    );
  }
}

class _ImagePicker extends StatelessWidget {
  const _ImagePicker();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddEventCubit, AddEventViewModel>(
      builder: (context, state) {
        return Padding(
          padding: context.paddingNormal,
          child: InkWell(
            onTap: () {
              context.read<AddEventCubit>().selectImage();
            },
            borderRadius: context.normalBorderRadius,
            child: Container(
                height: context.dynamicHeight(0.25),
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: context.normalBorderRadius,
                ),
                child: state.image == null
                    ? const Center(
                        child: Icon(
                          Icons.add_photo_alternate_outlined,
                          size: 50,
                        ),
                      )
                    : Image.file(
                        state.image!,
                        height: context.dynamicHeight(0.25),
                        fit: BoxFit.cover,
                      )),
          ),
        );
      },
    );
  }
}
