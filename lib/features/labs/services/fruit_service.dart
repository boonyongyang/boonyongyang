import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../../../core/errors/app_exceptions.dart';
import '../model/fruit_model.dart';
import '../repository/fruit_repository.dart';

class FruitService implements FruitRepository {
  static const String _baseUrl = 'https://www.fruityvice.com/api/fruit';
  static const String _corsProxy = 'https://corsproxy.io';
  final Dio _dio;

  FruitService({required Dio dio}) : _dio = dio;

  String _constructUrl(String endpoint) => '$_corsProxy/$_baseUrl/$endpoint';

  @override
  Future<List<Fruit>> fetchAllFruits() async {
    final data = await _fetchData(endpoint: 'all');
    final fruits = _asJsonList(data);
    return fruits.map(Fruit.fromJson).toList();
  }

  @override
  Future<Fruit> fetchFruitById(int id) async {
    final data = await _fetchData(endpoint: id.toString());
    return Fruit.fromJson(_asJsonMap(data));
  }

  Future<Object?> _fetchData({required String endpoint}) async {
    try {
      final url = _constructUrl(endpoint);
      final response = await _dio.get(url);

      if (response.statusCode == 200) {
        return response.data;
      }

      throw NetworkException(
        'Unexpected status: ${response.statusCode}',
        statusCode: response.statusCode,
      );
    } on DioException catch (e) {
      throw NetworkException.fromDioException(e);
    } on AppException {
      rethrow;
    } catch (e) {
      debugPrint('FruitService: Unexpected error: $e');
      throw DataParsingException('Failed to parse fruit data', cause: e);
    }
  }

  List<Map<String, Object?>> _asJsonList(Object? data) {
    if (data is! List) {
      throw DataParsingException('Expected fruit list response', cause: data);
    }

    return data.map(_asJsonMap).toList();
  }

  Map<String, Object?> _asJsonMap(Object? data) {
    if (data is Map<String, Object?>) {
      return data;
    }
    if (data is Map) {
      return data.cast<String, Object?>();
    }
    throw DataParsingException('Expected fruit object response', cause: data);
  }
}
