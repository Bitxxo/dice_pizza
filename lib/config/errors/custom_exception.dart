import 'package:dio/dio.dart';

enum CustomErrorType {
  noConnection,
  requestTimeout,
  responseTimeout,
  server,
  badRequest,
  parsing,
  unknown,
}

class CustomException implements Exception {
  final CustomErrorType type;
  final String message;
  final StackTrace? stackTrace;

  CustomException(this.type, this.message, this.stackTrace);

  @override
  String toString() {
    return 'Network Exception: ====> 🚫🚫 $type - $message';
  }

  factory CustomException.parseDioException(DioException dioException) {
    switch (dioException.type) {
      case DioException.connectionError:
        return NoConnectionException();
      case DioException.sendTimeout:
        return SendTimeoutException();
      case DioException.receiveTimeout:
        return ReceiveTimeoutException();
      case DioException.badResponse:
        return BadResponseException();
      default:
        return NoConnectionException('Connection error');
    }
  }

  factory CustomException.parseGenericException(
      Object error, StackTrace? stackTrace) {
    return CustomException(
        CustomErrorType.unknown, error.toString(), stackTrace);
  }
}

class NoConnectionException extends CustomException {
  NoConnectionException(
      [String message = 'No Internet Connection', StackTrace? stackTrace])
      : super(CustomErrorType.noConnection, message, stackTrace);
}

class SendTimeoutException extends CustomException {
  SendTimeoutException(
      [String message = 'Request Timed Out', StackTrace? stackTrace])
      : super(CustomErrorType.requestTimeout, message, stackTrace);
}

class ReceiveTimeoutException extends CustomException {
  ReceiveTimeoutException(
      [String message = 'Response Timed Out', StackTrace? stackTrace])
      : super(CustomErrorType.responseTimeout, message, stackTrace);
}

class BadResponseException extends CustomException {
  BadResponseException(
      [String message = 'Unable to parse server response',
      StackTrace? stackTrace])
      : super(CustomErrorType.requestTimeout, message, stackTrace);
}
