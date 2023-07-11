class FirebaseUtilities {
  static String firebaseStoragePath =
      "https://firebasestorage.googleapis.com/v0/b/f41-flutterfire.appspot.com/o/";

  static String convertFireStorePath(String path) {
    return "$firebaseStoragePath$path?alt=media";
  }

  static String convertFireStoreName(String? a) {
    var b = a?.split(firebaseStoragePath)[1];
    var c = b?.split("?alt=media")[0];
    return c ?? "";
  }
}
