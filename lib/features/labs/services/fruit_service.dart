import 'package:dio/dio.dart';
import 'package:dio_intercept_to_curl/dio_intercept_to_curl.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../model/fruit_model.dart';

class FruitService {
  static const String _baseUrl = 'https://www.fruityvice.com/api/fruit';
  static const String _corsProxy = 'https://corsproxy.io';
  late final Dio _dio;

  FruitService() {
    _initializeDio();
  }

  /// Initializes Dio with interceptors for logging and debugging
  void _initializeDio() {
    _dio = Dio();
    _dio.interceptors.addAll([
      DioInterceptToCurl(),
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 120,
      ),
    ]);
    debugPrint('FruitService: Dio initialized with interceptors');
  }

  /// Constructs the full URL for API requests, using a CORS proxy if needed
  String _constructUrl(String endpoint) {
    final url = '$_corsProxy/$_baseUrl/$endpoint';
    debugPrint('FruitService: Constructed URL: $url');
    return url;
  }

  /// Fetches all fruits from the Fruityvice API
  Future<List<Fruit>> fetchAllFruits() async {
    return _fetchData<List<Fruit>>(
      endpoint: 'all',
      parser: (data) {
        final List<dynamic> jsonData = data;
        return jsonData.map((fruitJson) => Fruit.fromJson(fruitJson)).toList();
      },
    );
  }

  /// Fetches a specific fruit by its ID
  Future<Fruit> fetchFruitById(int id) async {
    return _fetchData<Fruit>(
      endpoint: id.toString(),
      parser: (data) => Fruit.fromJson(data),
    );
  }

  /// Generic method to fetch data from the API
  Future<T> _fetchData<T>({
    required String endpoint,
    required T Function(dynamic data) parser,
  }) async {
    try {
      final url = _constructUrl(endpoint);
      debugPrint('FruitService: Fetching data from $url');

      final response = await _dio.get(url);
      debugPrint('FruitService: Response status code: ${response.statusCode}');

      if (response.statusCode == 200) {
        debugPrint('FruitService: Response data: ${response.data}');
        return parser(response.data);
      } else {
        debugPrint('FruitService: Error response data: ${response.data}');
        throw Exception('Failed to fetch data: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('FruitService: Exception caught: $e');
      throw Exception('Error fetching data: $e');
    }
  }
}
