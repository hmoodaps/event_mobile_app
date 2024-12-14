import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:event_mobile_app/app/components/constants/dio_and_mapper_constants.dart';
import 'package:http/http.dart' as http;

import '../../implementer/failure_class/failure_class.dart';

class HttpHelper {
  static const String _baseUrl = AppConstants.baseUrl;

  /// Handles GET requests with Either
  static Future<Either<FailureClass, http.Response>> getData({
    required String methodUrl,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final uri = Uri.parse('$_baseUrl/$methodUrl')
          .replace(queryParameters: queryParameters);
      final response = await http.get(uri, headers: headers);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return Right(response); // Return response on success
      } else {
        return Left(
            FailureClass(error: response.body)); // Return error response
      }
    } catch (e) {
      return Left(
          FailureClass(error: e.toString())); // Return error as FailureClass
    }
  }

  /// Handles POST requests with Either
  static Future<Either<FailureClass, http.Response>> postData({
    required String methodUrl,
    required Map<String, dynamic> data,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final uri = Uri.parse('$_baseUrl/$methodUrl')
          .replace(queryParameters: queryParameters);
      final response = await http.post(
        uri,
        headers: headers,
        body: jsonEncode(data),
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return Right(response); // Return response on success
      } else {
        return Left(
            FailureClass(error: response.body)); // Return error response
      }
    } catch (e) {
      return Left(
          FailureClass(error: e.toString())); // Return error as FailureClass
    }
  }

  /// Handles PUT requests with Either
  static Future<Either<FailureClass, http.Response>> putData({
    required String methodUrl,
    required Map<String, dynamic> data,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final uri = Uri.parse('$_baseUrl/$methodUrl')
          .replace(queryParameters: queryParameters);
      final response = await http.put(
        uri,
        headers: headers,
        body: jsonEncode(data),
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return Right(response); // Return response on success
      } else {
        return Left(
            FailureClass(error: response.body)); // Return error response
      }
    } catch (e) {
      return Left(
          FailureClass(error: e.toString())); // Return error as FailureClass
    }
  }

  /// Handles DELETE requests with Either
  static Future<Either<FailureClass, http.Response>> deleteData({
    required String methodUrl,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final uri = Uri.parse('$_baseUrl/$methodUrl')
          .replace(queryParameters: queryParameters);
      final response = await http.delete(uri, headers: headers);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return Right(response); // Return response on success
      } else {
        return Left(
            FailureClass(error: response.body)); // Return error response
      }
    } catch (e) {
      return Left(
          FailureClass(error: e.toString())); // Return error as FailureClass
    }
  }
}
