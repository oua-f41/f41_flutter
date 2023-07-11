import 'package:connectopia/product/widgets/info_snack_bar.dart';
import 'package:geolocator/geolocator.dart';

import '../../core/helpers/globals.dart';

class PermissonHandler {
  static Future<bool> handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      snackbarKey.currentState?.showSnackBar(InfoSnackBar(
          contentText:
              'Location services are disabled. Please enable the services'));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        snackbarKey.currentState?.showSnackBar(
            InfoSnackBar(contentText: 'Location permissions are denied'));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      snackbarKey.currentState?.showSnackBar(InfoSnackBar(
          contentText:
              'Location permissions are permanently denied, we cannot request permissions.'));
      return false;
    }
    return true;
  }
}
