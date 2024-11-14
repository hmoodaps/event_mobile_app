// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieResponse _$MovieResponseFromJson(Map<String, dynamic> json) =>
    MovieResponse(
      verticalPhoto: json['vertical_photo'] as String?,
      photo: json['photo'] as String?,
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      description: json['description'] as String?,
      reservedSeats: json['reservedSeats'] as List<dynamic>?,
      seats: (json['seats'] as num?)?.toInt(),
      ticketPrice: (json['ticket_price'] as num?)?.toDouble(),
      reservations: (json['reservations'] as num?)?.toInt(),
      availableSeats: (json['available_seats'] as num?)?.toInt(),
      actors: json['actors'] as List<dynamic>?,
      duration: json['duration'] as String?,
      imdbRating: (json['imdb_rating'] as num?)?.toDouble(),
      rating: (json['rating'] as num?)?.toDouble(),
      releaseDate: json['release_date'] as String?,
      shortDescription: json['short_description'] as String?,
      showTimes: json['show_times'] == null
          ? null
          : ShowTimesResponse.fromJson(
              json['show_times'] as Map<String, dynamic>),
      sponsorVideo: json['sponsor_video'] as String?,
      tags: json['tags'] as List<dynamic>?,
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
