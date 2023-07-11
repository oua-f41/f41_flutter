import 'package:connectopia/core/presentation/base_view_model.dart';

import '../../../../../product/models/core_models/event.dart';
import '../../../../../product/models/core_models/group.dart';

class HomeViewModel extends BaseViewModel {
  String? title;
  List<Event>? events;
  List<Event>? eventsOnCity;
  List<Event>? otherEvents;
  List<Group>? attendedGroups;

  HomeViewModel(
      {super.isLoading,
      this.title,
      this.events,
      this.eventsOnCity,
      this.otherEvents,
      this.attendedGroups});

  HomeViewModel copyWith({
    bool? isLoading,
    String? title,
    List<Event>? events,
    List<Event>? eventsOnCity,
    List<Event>? otherEvents,
    List<Group>? attendedGroups,
  }) {
    return HomeViewModel(
      isLoading: isLoading ?? this.isLoading,
      title: title ?? this.title,
      events: events ?? this.events,
      eventsOnCity: eventsOnCity ?? this.eventsOnCity,
      otherEvents: otherEvents ?? this.otherEvents,
      attendedGroups: attendedGroups ?? this.attendedGroups,
    );
  }

  @override
  List<Object?> get props =>
      [isLoading, title, events, eventsOnCity, otherEvents, attendedGroups];
}
