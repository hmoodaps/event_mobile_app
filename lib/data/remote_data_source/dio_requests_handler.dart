import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../../domain/models/movie_model.dart';

class DioHelper {
  static Dio? dio;

  static void init() {
    dio = Dio();
  }

  static Future<Response> getMovies() async {
    try {
      return await dio!.get('http://localhost:8000/movies/');
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      rethrow;
    }
  }

  static Future<List<MovieModel>> fetchMovies() async {
    try {
      final response = await getMovies();
      List<MovieModel> movies = (response.data as List)
          .map((movie) => MovieModel.fromJson(movie))
          .toList();
      return movies;
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching movies: $e");
      }
      return [];
    }
  }
}

//
// //BASE URL : https://localhost:8000/
// //method url : viewsets/guests,reservation,movies/data or create-superuser/<-post , delete only
//
// import 'package:dio/dio.dart';
// import 'package:flutter/foundation.dart';
//
// class DioHelper {
//   static Dio? dio;
//   static init() {
//     dio = Dio(
//       BaseOptions(
//         baseUrl: 'http://127.0.0.1:8000/',
//         receiveDataWhenStatusError: true,
//         // headers: {
//         //   'Authorization': 'Token $token',
//         // },
//       ),
//     );
//   }
//
//   static Future<Response?> getData(
//       String methodUrl, {
//         Map<String, dynamic>? queryParameters,
//       }) async {
//     try {
//       return await dio?.get(methodUrl, queryParameters: queryParameters);
//     } on DioException catch (e) {
//       if (kDebugMode) {
//         print('Error: ${e.response?.data}');
//         print('Status Code: ${e.response?.statusCode}');
//       }
//     }
//     return null;
//   }
//
//   static Future<Response?> postData({
//     required String methodUrl,
//     required Map<String, dynamic> data,
//     Map<String, dynamic>? queryParameters,
//   }) async {
//     try {
//       return await dio?.post(methodUrl,
//           queryParameters: queryParameters, data: data);
//     } on DioException catch (e) {
//       if (kDebugMode) {
//         print('Error: ${e.response?.data}');
//         print('Status Code: ${e.response?.statusCode}');
//       }
//     }
//     return null;
//   }
//
//   static Future<Response?> putData(
//
//       {
//         required String methodUrl,
//         Map<String, dynamic>? queryParameters,
//         required Map<String, dynamic>  data,
//       }) async {
//     try {
//       return await dio?.put(methodUrl,
//           queryParameters: queryParameters, data: data);
//     } on DioException catch (e) {
//       if (kDebugMode) {
//         print('Error: ${e.response?.data}');
//         print('Status Code: ${e.response?.statusCode}');
//       }
//     }
//     return null;
//   }
//
//   static Future<Response?> deleteData(
//       String methodUrl,
//       ) async {
//     try {
//       return await dio?.delete(methodUrl);
//     } on DioException catch (e) {
//       if (kDebugMode) {
//         print('Error: ${e.response?.data}');
//         print('Status Code: ${e.response?.statusCode}');
//       }
//     }
//     return null;
//   }
// }