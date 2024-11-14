import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import 'package:event_mobile_app/app/components/constants/dio_and_mapper_constants.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../implementer/failure_class/failure_class.dart';

class DioHelper {
  static Dio? dio;
  static Dio init({String? token}) {
    dio = Dio(
      BaseOptions(
        baseUrl: AppConstants.baseUrl,
        receiveDataWhenStatusError: true,
        headers: {
          'Authorization': 'token ${token ?? ""}',
        },
      ),
    );

    // Add PrettyDioLogger interceptor in debug mode
    if (!kReleaseMode) {
      dio?.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
      ));
    }
    return dio!;
  }

  /// Handles GET requests with Either
  static Future<Either<FailureClass, Response>> getData({
    required String methodUrl,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await dio!.get(methodUrl, queryParameters: queryParameters);
      return Right(response); // Return response on success
    } on DioException catch (e) {
      return Left(FailureClass(error: e.toString())); // Return error as FailureClass
    }
  }

  /// Handles POST requests with Either
  static Future<Either<FailureClass, Response>> postData({
    required String methodUrl,
    required Map<String, dynamic> data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await dio!.post(methodUrl, data: data, queryParameters: queryParameters);
      return Right(response); // Return response on success
    } on DioException catch (e) {
      return Left(FailureClass(error: e.toString())); // Return error as FailureClass
    }
  }

  /// Handles PUT requests with Either
  static Future<Either<FailureClass, Response>> putData({
    required String methodUrl,
    required Map<String, dynamic> data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await dio!.put(methodUrl, data: data, queryParameters: queryParameters);
      return Right(response); // Return response on success
    } on DioException catch (e) {
      return Left(FailureClass(error: e.toString())); // Return error as FailureClass
    }
  }

  /// Handles DELETE requests with Either
  static Future<Either<FailureClass, Response>> deleteData(String methodUrl) async {
    try {
      final response = await dio!.delete(methodUrl);
      return Right(response); // Return response on success
    } on DioException catch (e) {
      return Left(FailureClass(error: e.toString())); // Return error as FailureClass
    }
  }
}
