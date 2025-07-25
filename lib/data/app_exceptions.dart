class AppExceptions implements Exception {
  final dynamic _message;
  final dynamic _prefix;

  AppExceptions([this._message, this._prefix]);

  @override
  String toString() {
    return '$_prefix $_message';
  }
}

class InternetException extends AppExceptions {
  InternetException([String? message]) : super(message, 'No internet');
}

class RequestTimeOut extends AppExceptions {
  RequestTimeOut([String? message]) : super(message, 'Request timeout');
}

class ServerException extends AppExceptions {
  ServerException([String? message]) : super(message, 'Internal server error');
}

class InvalidUrlException extends AppExceptions {
  InvalidUrlException([String? message]) : super(message, 'Invalid url');
}

class FetchDataException extends AppExceptions {
  FetchDataException([String? message]) : super(message, '');
}

class AuthenticationException extends AppExceptions {
  AuthenticationException([String? message])
      : super(message, 'Authorization Expired');
}
