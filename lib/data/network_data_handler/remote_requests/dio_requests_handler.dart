import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
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
    if (kDebugMode) {
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
  static Future<Either<FailureClass, Response>> request({
    required String method,
    required String methodUrl,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      Response response;
      switch (method) {
        case 'GET':
          response =
              await dio!.get(methodUrl, queryParameters: queryParameters);
          break;
        case 'POST':
          response = await dio!
              .post(methodUrl, data: data, queryParameters: queryParameters);
          break;
        case 'PUT':
          response = await dio!
              .put(methodUrl, data: data, queryParameters: queryParameters);
          break;
        case 'DELETE':
          response = await dio!.delete(methodUrl);
          break;
        default:
          throw UnsupportedError('Method not supported');
      }
      return Right(response);
    } on DioException catch (e) {
      return Left(FailureClass(error: e.toString()));
    }
  }
}
