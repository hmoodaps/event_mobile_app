

import 'package:json_annotation/json_annotation.dart';

part 'movie_model.g.dart';

@JsonSerializable()
class MovieResponse {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'seats')
  int? seats;
  @JsonKey(name: 'available_seats')
  int? availableSeats;
  @JsonKey(name: 'reservations')
  int? reservations;
  @JsonKey(name: 'photo')
  String? photo;
  @JsonKey(name: 'ticket_price')
  double? ticketPrice;
  @JsonKey(name: 'reservedSeats')
  List<dynamic>? reservedSeats;
  @JsonKey(name: 'description')
  String? description;
  @JsonKey(name: 'short_description')
  String? shortDescription;
  @JsonKey(name: 'vertical_photo')
  String? verticalPhoto;
  @JsonKey(name: 'sponsor_video')
  String? sponsorVideo;
  @JsonKey(name: 'release_date')
  String? releaseDate;
  @JsonKey(name: 'duration')
  String? duration;
  @JsonKey(name: 'rating')
  double? rating;
  @JsonKey(name: 'imdb_rating')
  double? imdbRating;
  @JsonKey(name: 'tags')
  List<dynamic>? tags;
  @JsonKey(name: 'actors')
  List<dynamic>? actors;
  @JsonKey(name: 'show_times')
  ShowTimesResponse? showTimes;

  // Constructor with named parameters
  MovieResponse({
    this.verticalPhoto,
    this.photo,
    this.id,
    this.name,
    this.description,
    this.reservedSeats,
    this.seats,
    this.ticketPrice,
    this.reservations,
    this.availableSeats,
    this.actors,
    this.duration,
    this.imdbRating,
    this.rating,
    this.releaseDate,
    this.shortDescription,
    this.showTimes,
    this.sponsorVideo,
    this.tags,
  });

  // Factory method for JSON serialization
  factory MovieResponse.fromJson(Map<String, dynamic> json) =>
      _$MovieResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MovieResponseToJson(this);
}

@JsonSerializable()
class ShowTimesResponse {
  @JsonKey(name: 'dates')
  List<dynamic>? dates;
  @JsonKey(name: 'halls')
  List<dynamic>? halls;
  @JsonKey(name: 'times')
  List<dynamic>? times;

  ShowTimesResponse(this.dates, this.halls, this.times);

  factory ShowTimesResponse.fromJson(Map<String, dynamic> json) =>
      _$ShowTimesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ShowTimesResponseToJson(this);
}


//then run
//flutter pub get; flutter pub run build_runner build --delete-conflicting-outputs
