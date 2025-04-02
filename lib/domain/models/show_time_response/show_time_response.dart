import 'package:freezed_annotation/freezed_annotation.dart';

part 'show_time_response.freezed.dart';
part 'show_time_response.g.dart';

@freezed
class ShowTimesResponse with _$ShowTimesResponse {
  const factory ShowTimesResponse({
    int? id,
    String? date,
    String? time,
    String? hall,
    int? total_seats,
    int? available_seats,
    double? ticket_price,
    List<dynamic>? reserved_seats,
  }) = _ShowTimesResponse;

  factory ShowTimesResponse.fromJson(Map<String, dynamic> json) =>
      _$ShowTimesResponseFromJson(json);
}
