enum LottieConstants { mainLoginAnimation, loadingProgress }

extension LottieItemsExtention on LottieConstants {
  String _path() {
    switch (this) {
      case LottieConstants.mainLoginAnimation:
        return "main_login_animation";
      case LottieConstants.loadingProgress:
        return "loading_progress";
    }
  }

  String get lottiePath => "assets/lottie/${_path()}.json";
}
