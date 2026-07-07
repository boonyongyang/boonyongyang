import 'package:dio/dio.dart';

/// Base exception for all application-specific errors.
sealed class AppException implements Exception {
  final String message;
  final Object? cause;

  const AppException(this.message, {this.cause});

  @override
  String toString() => '$runtimeType: $message';
}

/// Thrown when a network request fails (timeout, no internet, etc.).
class NetworkException extends AppException {
  final int? statusCode;

  const NetworkException(
    super.message, {
    this.statusCode,
    super.cause,
  });

  factory NetworkException.fromDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return NetworkException(
          'Connection timed out. Please try again.',
          cause: e,
        );
      case DioExceptionType.connectionError:
        return NetworkException(
          'No internet connection. Please check your network.',
          cause: e,
        );
      case DioExceptionType.badResponse:
        return NetworkException(
          'Server error: ${e.response?.statusCode}',
          statusCode: e.response?.statusCode,
          cause: e,
        );
      default:
        return NetworkException(
          'Network error occurred.',
          cause: e,
        );
    }
  }
}

/// Thrown when server returns unexpected data or parsing fails.
class DataParsingException extends AppException {
  const DataParsingException(super.message, {super.cause});
}

/// Thrown when a requested resource is not found.
class NotFoundException extends AppException {
  const NotFoundException(super.message, {super.cause});
}
