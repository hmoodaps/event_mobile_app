import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioHelper {
  static Dio? dio;

  /// Initializes the Dio instance with base options.
  /// Optionally, a token can be provided for authorization.
  static Dio init({String? token}) {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://eventapi-teal.vercel.app/',
        receiveDataWhenStatusError: true,
        headers: {
          'Authorization': 'token ${token ?? ""}',
        },
      ),
    );

    // Add PrettyDioLogger interceptor in debug mode
    if (!kReleaseMode) {
      /// This package protects user data in logs.
      /// Not used in `rest_api_dio.dart` as it only fetches films
      /// which don't contain sensitive information.
      dio?.interceptors.add(PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: false,
          error: true,
          compact: true,
          maxWidth: 90,
          enabled: kDebugMode,
          filter: (options, args) {
            // Don't print requests with URIs containing '/posts'
            if (options.path.contains('/posts')) {
              return false;
            }
            // Don't print responses with Uint8List data
            return !args.isResponse || !args.hasUint8ListData;
          }));
    }
    return dio!;
  }

  /// Handles GET requests and returns the response.
  /// Prints error details in debug mode.
  static Future<Response?> getData({
    String? methodUrl,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      return await dio?.get(methodUrl ?? '', queryParameters: queryParameters);
    } on DioException catch (e) {
      handleError(e);

    }
    return null;
  }

  /// Handles POST requests and returns the response.
  /// Prints error details in debug mode.
  static Future<Response?> postData({
    required String methodUrl,
    required Map<String, dynamic> data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      return await dio?.post(methodUrl,
          queryParameters: queryParameters, data: data);
    } on DioException catch (e) {
      handleError(e);

    }
    return null;
  }

  /// Handles PUT requests and returns the response.
  /// Prints error details in debug mode.
  static Future<Response?> putData({
    required String methodUrl,
    Map<String, dynamic>? queryParameters,
    required Map<String, dynamic> data,
  }) async {
    try {
      return await dio?.put(methodUrl,
          queryParameters: queryParameters, data: data);
    } on DioException catch (e) {
      handleError(e);

    }
    return null;
  }

  /// Handles DELETE requests and returns the response.
  /// Prints error details in debug mode.
  static Future<Response?> deleteData(String methodUrl) async {
    try {
      return await dio?.delete(methodUrl);
    } on DioException catch (e) {
handleError(e);
    }
    return null;
  }
}
void handleError(DioException e) {
  if (e.response != null) {
    if (kDebugMode) {
      print('Error: ${e.response?.data}');
      print('Status Code: ${e.response?.statusCode}');

    }
  } else {
    if (kDebugMode) {
      print('Error: ${e.message}');
    }
  }
}
