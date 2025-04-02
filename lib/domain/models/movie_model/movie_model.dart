import 'package:freezed_annotation/freezed_annotation.dart';

import '../show_time_response/show_time_response.dart';

part 'movie_model.freezed.dart';
part 'movie_model.g.dart';

@freezed
class MovieResponse with _$MovieResponse {
  const factory MovieResponse({
    int? id,
    String? name,
    String? photo,
    String? vertical_photo,
    String? description,
    String? short_description,
    String? sponsor_video,
    List<dynamic>? actors,
    String? release_date,
    String? added_date,
    String? duration,
    double? imdb_rating,
    List<dynamic>? tags,
    List<ShowTimesResponse>? show_times,
  }) = _MovieResponse;

  factory MovieResponse.fromJson(Map<String, dynamic> json) =>
      _$MovieResponseFromJson(json);
}
