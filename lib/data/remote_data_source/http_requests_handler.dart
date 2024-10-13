import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class HttpHelper {
  static const String baseUrl = 'http://127.0.0.1:8000/';

  // Method for GET requests
  static Future<http.Response?> getData({
    required String methodUrl,
    Map<String, String>? queryParameters,
  }) async {
    try {
      final Uri uri = Uri.parse(baseUrl + methodUrl).replace(queryParameters: queryParameters);
      final response = await http.get(uri);
      return response;
    } catch (e) {
      if (kDebugMode) {
        print('GET Error: $e');
      }
      return null;
    }
  }

  // Method for POST requests
  static Future<http.Response?> postData({
    required String methodUrl,
    required Map<String, dynamic> data,
    Map<String, String>? queryParameters,
  }) async {
    try {
      final Uri uri = Uri.parse(baseUrl + methodUrl).replace(queryParameters: queryParameters);
      final response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(data),
      );
      return response;
    } catch (e) {
      if (kDebugMode) {
        print('POST Error: $e');
      }
      return null;
    }
  }

  // Method for PUT requests
  static Future<http.Response?> putData({
    required String methodUrl,
    required Map<String, dynamic> data,
    Map<String, String>? queryParameters,
  }) async {
    try {
      final Uri uri = Uri.parse(baseUrl + methodUrl).replace(queryParameters: queryParameters);
      final response = await http.put(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(data),
      );
      return response;
    } catch (e) {
      if (kDebugMode) {
        print('PUT Error: $e');
      }
      return null;
    }
  }

  // Method for DELETE requests
  static Future<http.Response?> deleteData({
    required String methodUrl,
    Map<String, String>? queryParameters,
  }) async {
    try {
      final Uri uri = Uri.parse(baseUrl + methodUrl).replace(queryParameters: queryParameters);
      final response = await http.delete(uri);
      return response;
    } catch (e) {
      if (kDebugMode) {
        print('DELETE Error: $e');
      }
      return null;
    }
  }
}
