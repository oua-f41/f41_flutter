enum ErrorConstants {
  userAlreadyExists,
}

extension ErrorConstantsExtension on ErrorConstants {
  String get value {
    switch (this) {
      case ErrorConstants.userAlreadyExists:
        return 'user already exists';
    }
  }
}
