import 'package:auto_route/auto_route.dart';
import 'package:connectopia/app/connectopia_app_cubit.dart';
import 'package:connectopia/product/widgets/info_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';

import '../domain/models/event_location.dart';

@RoutePage()
class LocationPickingPage extends StatelessWidget {
  const LocationPickingPage({super.key, this.initialLat, this.initialLng});

  final double? initialLat;
  final double? initialLng;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConnectopiaAppCubit, ConnectopiaAppViewModel>(
      builder: (context, state) {
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: PlacePicker(
                onTapBack: () {
                  context.router.pop();
                },
                initialPosition: LatLng(
                    initialLat ?? state.currentLocation?.latitude ?? 0,
                    initialLng ?? state.currentLocation?.longitude ?? 0),
                /* minMaxZoomPreference: const MinMaxZoomPreference(0, 500), */
                useCurrentLocation: true,
                resizeToAvoidBottomInset: false,
                apiKey: "AIzaSyAn2_eyAXQj8vH8O-bwE65DoL28cEV4F2I",
                onPlacePicked: (result) async {
                  if (result.geometry?.location.lat == null ||
                      result.geometry?.location.lng == null) {
                    ScaffoldMessenger.of(context).showSnackBar(InfoSnackBar(
                      contentText: 'Lütfen geçerli bir adres seçiniz',
                    ));
                    return;
                  }
                  List<Placemark> placemarks = await placemarkFromCoordinates(
                      result.geometry?.location.lat ?? 0,
                      result.geometry?.location.lng ?? 0);
                  if (placemarks[0].administrativeArea != null) {
                    if (state.currentCity != null) {
                      EventLocation eventLocation = EventLocation(
                          address: result.formattedAddress,
                          city: placemarks[0].administrativeArea,
                          latitude: result.geometry?.location.lat,
                          longitude: result.geometry?.location.lng);
                      context.router.pop(eventLocation);
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(InfoSnackBar(
                      contentText: 'Lütfen geçerli bir adres seçiniz',
                    ));
                    return;
                  }
                },
              ),
            ));
      },
    );
  }
}
