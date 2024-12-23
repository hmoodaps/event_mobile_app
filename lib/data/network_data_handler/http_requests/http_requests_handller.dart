import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:event_mobile_app/app/components/constants/dio_and_mapper_constants.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../../implementer/failure_class/failure_class.dart';

class HttpHelper {
  static const String _baseUrl = AppConstants.baseUrl;

  static Future<Either<FailureClass, http.Response>> makeRequest({
    required String method,
    required String methodUrl,
    Map<String, dynamic>? data,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final uri = Uri.parse('$_baseUrl$methodUrl')
          .replace(queryParameters: queryParameters);
      final body = data != null ? jsonEncode(data) : null;

      _logRequest(method, uri, headers, body); // Log the request

      final response = await _requestHandler(method, uri, headers, body);

      _logResponse(response); // Log the response

      return response.statusCode >= 200 && response.statusCode < 300
          ? Right(response)
          : Left(FailureClass(error: response.body));
    } catch (e) {
      return Left(FailureClass(error: e.toString()));
    }
  }

  static Future<http.Response> _requestHandler(
      String method, Uri uri, Map<String, String>? headers, String? body) {
    switch (method.toUpperCase()) {
      case 'GET':
        return http.get(uri, headers: headers);
      case 'POST':
        return http.post(uri, headers: headers, body: body);
      case 'PUT':
        return http.put(uri, headers: headers, body: body);
      case 'DELETE':
        return http.delete(uri, headers: headers);
      default:
        throw UnsupportedError('Unsupported HTTP method: $method');
    }
  }

  // Logging the request
  static void _logRequest(
      String method, Uri uri, Map<String, String>? headers, String? body) {
    if (kDebugMode) {
      print('--- HTTP Request ---');
      print('Method: $method');
      print('URL: ${uri.toString()}');
      if (headers != null) print('Headers: $headers');
      if (body != null) print('Body: $body');
      print('-------------------');
    }
  }

  // Logging the response
  static void _logResponse(http.Response response) {
    if (kDebugMode) {
      print('--- HTTP Response ---');
      print('Status Code: ${response.statusCode}');
      print('Body: ${response.body}');
      print('---------------------');
    }
  }
}
