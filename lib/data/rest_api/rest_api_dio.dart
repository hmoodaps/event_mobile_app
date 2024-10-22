
// restfull api by using dio package >>
// i made the api and u will find more details in README.md  file
// and also i made a dio helper u can see in remote_data_source dir
// and i will use this way of dio and that way also i used the http
// u can use just one way all of them are correct but this one is advanced >>>
//also this one i will use it to bring the movies before user login in ,,
//that one (http & dio) i will use them in other things we have a lot of things in the app that u can figured them out

import 'package:dio/dio.dart';
import 'package:event_mobile_app/data/models/movie_model.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

import '../../app/constants&extensions/app_constants.dart';
part 'rest_api_dio.g.dart';
@RestApi(baseUrl: AppConstants.baseUrl)
abstract class DioClint {
  factory DioClint(Dio dio, {ParseErrorLogger? errorLogger, String? baseUrl}) = _DioClint;

  @GET(AppConstants.getMovies)
  Future<List<MovieResponse>> getMovies();
}

