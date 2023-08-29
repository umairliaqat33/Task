class EmailAlreadyExistException implements Exception {
  final String message;

  EmailAlreadyExistException(this.message);
}

class UnknownException implements Exception {
  final String message;

  UnknownException(this.message);
}

class WrongPasswordException implements Exception {
  final String message;

  WrongPasswordException(this.message);
}

class StoragePermissionDenied implements Exception {
  final String message;

  StoragePermissionDenied(this.message);
}

class StoragePermissionDeniedPermanently implements Exception {
  final String message;

  StoragePermissionDeniedPermanently(this.message);
}
