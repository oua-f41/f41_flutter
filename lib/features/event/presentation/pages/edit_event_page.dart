import 'package:auto_route/auto_route.dart';
import 'package:connectopia/features/event/presentation/cubit/view_model/edit_event_view_model.dart';
import 'package:connectopia/features/maps/presentation/cubit/maps_cubit.dart';
import 'package:connectopia/product/models/core_models/event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:kartal/kartal.dart';

import '../../../../app/app_router.dart';
import '../../../location_picking/domain/models/event_location.dart';
import '../cubit/edit_event_cubit.dart';

@RoutePage()
class EditEventPage extends StatelessWidget with AutoRouteWrapper {
  const EditEventPage({super.key, required this.event});

  final Event event;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        actions: [
          IconButton(
            onPressed: () async {
              final isDeleteing = await showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    shape: ShapeBorder.lerp(
                        RoundedRectangleBorder(
                            borderRadius: context.normalBorderRadius),
                        RoundedRectangleBorder(
                            borderRadius: context.normalBorderRadius),
                        1)!,
                    title: const Text("Delete Event"),
                    content: const Text(
                        "Are you sure you want to delete this event?"),
                    actions: [
                      OutlinedButton(
                          onPressed: () {
                            context.router.pop(false);
                          },
                          child: const Text("Back")),
                      TextButton(
                          onPressed: () {
                            context.router.pop(true);
                          },
                          child: Text(
                            "Delete",
                            style: TextStyle(color: context.colorScheme.error),
                          )),
                    ],
                  );
                },
              );
              if (isDeleteing == true) {
                bool response =
                    await context.read<EditEventCubit>().deleteEvent();
                if (response == true) {
                  context.router.pop(EditEventActions.delete);
                  await context.read<MapsCubit>().refresh();
                }
              }
            },
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Container(
            padding: context.paddingLow,
            child: BlocBuilder<EditEventCubit, EditEventViewModel>(
              builder: (context, state) {
                return Form(
                  key: state.formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: context.paddingNormal,
                        child: InkWell(
                          onTap: () {
                            context.read<EditEventCubit>().selectImage();
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
                                  ? state.eventRequest.eventPhotoUrl
                                              .isNotNullOrNoEmpty ==
                                          true
                                      ? Image.network(
                                          state.eventRequest.eventPhotoUrl ??
                                              "")
                                      : const Center(
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
                      ),
                      Container(
                        padding: context.paddingLow,
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter event name';
                            }
                            return null;
                          },
                          initialValue: state.eventRequest.name,
                          decoration: const InputDecoration(
                            label: Text('Event Name'),
                          ),
                          onChanged: (value) {
                            context.read<EditEventCubit>().onNameChanged(value);
                          },
                        ),
                      ),
                      Container(
                        padding: context.paddingLow,
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter event description';
                            }
                            return null;
                          },
                          initialValue: state.eventRequest.description,
                          minLines: 2,
                          maxLines: 6,
                          decoration: const InputDecoration(
                              label: Text('Event Description'),
                              alignLabelWithHint: true),
                          onChanged: (value) {
                            context
                                .read<EditEventCubit>()
                                .onDescriptionChanged(value);
                          },
                        ),
                      ),
                      Container(
                        padding: context.paddingLow,
                        child: InkWell(
                          borderRadius: context.normalBorderRadius,
                          onTap: () async {
                            DateTime? date = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2100),
                            );
                            TimeOfDay? time = await showTimePicker(
                                context: context, initialTime: TimeOfDay.now());
                            if (date == null || time == null) return;
                            DateTime dateTime = DateTime(date.year, date.month,
                                date.day, time.hour, time.minute);
                            context
                                .read<EditEventCubit>()
                                .setEventDate(dateTime);
                          },
                          child: TextFormField(
                            validator: (value) {
                              if (state.eventRequest.eventDate == null) {
                                return 'Please select event date';
                              }
                              return null;
                            },
                            initialValue: state.eventRequest.eventDate != null
                                ? DateFormat("dd/MM/yyyy  •  hh.mm").format(
                                    DateTime.parse(
                                        state.eventRequest.eventDate!))
                                : null,
                            enabled: false,
                            decoration: InputDecoration(
                              hintText: state.eventRequest.eventDate != null
                                  ? DateFormat("dd/MM/yyyy  •  hh.mm").format(
                                      DateTime.parse(
                                          state.eventRequest.eventDate!))
                                  : 'Select Date',
                              suffixIcon: state.eventRequest.eventDate == null
                                  ? const Icon(Icons.calendar_month_outlined)
                                  : const Icon(Icons.edit_calendar_outlined),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: context.paddingLow,
                        child: InkWell(
                          borderRadius: context.normalBorderRadius,
                          onTap: () async {
                            final location = await context.router.push(
                                LocationPickingRoute(
                                    initialLat: double.tryParse(
                                        state.eventRequest.eventLat ?? ""),
                                    initialLng: double.tryParse(
                                        state.eventRequest.eventLng ?? "")));
                            if (location is EventLocation) {
                              await context
                                  .read<EditEventCubit>()
                                  .setEventLocation(location);
                            }
                          },
                          child: TextFormField(
                            validator: (value) {
                              if (state.eventRequest.eventAddress == null) {
                                return 'Please select event location';
                              }
                              return null;
                            },
                            initialValue: state.eventRequest.eventAddress,
                            enabled: false,
                            maxLines: 4,
                            minLines: 1,
                            decoration: InputDecoration(
                              hintText: state.eventRequest.eventAddress ??
                                  'Select Location',
                              suffixIcon: state.eventRequest.eventAddress ==
                                      null
                                  ? const Icon(Icons.arrow_forward_ios_rounded)
                                  : const Icon(Icons.edit_location_alt_rounded),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            bool? response = await context.read<EditEventCubit>().updateEvent();
            if (response == true) {
              context.router.pop(EditEventActions.update);
              await context.read<MapsCubit>().refresh();
            }
          },
          label: const Text('Update Event')),
    );
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => EditEventCubit()..init(event),
      child: this,
    );
  }
}
