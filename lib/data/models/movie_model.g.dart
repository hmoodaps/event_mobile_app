// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieResponse _$MovieResponseFromJson(Map<String, dynamic> json) =>
    MovieResponse(
      json['vertical_photo'] as String?,
      json['photo'] as String?,
      (json['id'] as num?)?.toInt(),
      json['name'] as String?,
      json['description'] as String?,
      json['reservedSeats'] as List<dynamic>?,
      (json['seats'] as num?)?.toInt(),
      (json['ticket_price'] as num?)?.toDouble(),
      (json['reservations'] as num?)?.toInt(),
      (json['available_seats'] as num?)?.toInt(),
      json['actors'] as List<dynamic>?,
      json['duration'] as String?,
      (json['imdb_rating'] as num?)?.toDouble(),
      (json['rating'] as num?)?.toDouble(),
      json['release_date'] as String?,
      json['short_description'] as String?,
      json['show_times'] == null
          ? null
          : ShowTimesResponse.fromJson(
              json['show_times'] as Map<String, dynamic>),
      json['sponsor_video'] as String?,
      json['tags'] as List<dynamic>?,
    );

Map<String, dynamic> _$MovieResponseToJson(MovieResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'seats': instance.seats,
      'available_seats': instance.availableSeats,
      'reservations': instance.reservations,
      'photo': instance.photo,
      'ticket_price': instance.ticketPrice,
      'reservedSeats': instance.reservedSeats,
      'description': instance.description,
      'short_description': instance.shortDescription,
      'vertical_photo': instance.verticalPhoto,
      'sponsor_video': instance.sponsorVideo,
      'release_date': instance.releaseDate,
      'duration': instance.duration,
      'rating': instance.rating,
      'imdb_rating': instance.imdbRating,
      'tags': instance.tags,
      'actors': instance.actors,
      'show_times': instance.showTimes,
    };

ShowTimesResponse _$ShowTimesResponseFromJson(Map<String, dynamic> json) =>
    ShowTimesResponse(
      json['dates'] as List<dynamic>?,
      json['halls'] as List<dynamic>?,
      json['times'] as List<dynamic>?,
    );

Map<String, dynamic> _$ShowTimesResponseToJson(ShowTimesResponse instance) =>
    <String, dynamic>{
      'dates': instance.dates,
      'halls': instance.halls,
      'times': instance.times,
    };
