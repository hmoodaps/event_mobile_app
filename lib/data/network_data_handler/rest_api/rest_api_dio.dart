// RESTful API using the Dio package
// I created the API; more details can be found in README.md.
// This helper class (DioHelper) supports fetching movies before user login.
// A separate Dio helper can be found in the remote_data_source directory.
// Both Dio and Http methods are used in the app; you can choose one,
// but this approach with Dio is more advanced.
// I will use this method to fetch movies before user login.
// (http & dio) will be used in other parts of the app where needed.

import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

import '../../../app/components/constants/dio_and_mapper_constants.dart';
import '../../../domain/models/movie_model/movie_model.dart';

part 'rest_api_dio.g.dart';

@RestApi(baseUrl: AppConstants.baseUrl)
abstract class DioClient {
  factory DioClient(Dio dio, {ParseErrorLogger? errorLogger, String? baseUrl}) =
      _DioClient;

  @GET(AppConstants.getMovies)
  Future<List<MovieResponse>> getMovies();
}
