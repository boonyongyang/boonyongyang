import 'package:boonyongyang/core/errors/app_exceptions.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppException hierarchy', () {
    test('NetworkException.fromDioException handles connectionTimeout', () {
      final dioException = DioException(
        type: DioExceptionType.connectionTimeout,
        requestOptions: RequestOptions(),
      );
      final exception = NetworkException.fromDioException(dioException);
      expect(exception.message, contains('timed out'));
    });

    test('NetworkException.fromDioException handles connectionError', () {
      final dioException = DioException(
        type: DioExceptionType.connectionError,
        requestOptions: RequestOptions(),
      );
      final exception = NetworkException.fromDioException(dioException);
      expect(exception.message, contains('internet'));
    });

    test('NetworkException.fromDioException handles badResponse', () {
      final dioException = DioException(
        type: DioExceptionType.badResponse,
        response: Response(
          statusCode: 404,
          requestOptions: RequestOptions(),
        ),
        requestOptions: RequestOptions(),
      );
      final exception = NetworkException.fromDioException(dioException);
      expect(exception.statusCode, 404);
      expect(exception.message, contains('404'));
    });

    test('DataParsingException preserves message and cause', () {
      const exception = DataParsingException('parse failed');
      expect(exception.message, 'parse failed');
      expect(exception.toString(), contains('DataParsingException'));
    });

    test('NotFoundException has correct message', () {
      const exception = NotFoundException('Fruit not found');
      expect(exception.message, 'Fruit not found');
    });
  });
}
