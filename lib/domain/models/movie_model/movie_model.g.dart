// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MovieResponseImpl _$$MovieResponseImplFromJson(Map<String, dynamic> json) =>
    _$MovieResponseImpl(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      photo: json['photo'] as String?,
      vertical_photo: json['vertical_photo'] as String?,
      description: json['description'] as String?,
      short_description: json['short_description'] as String?,
      sponsor_video: json['sponsor_video'] as String?,
      actors: json['actors'] as List<dynamic>?,
      release_date: json['release_date'] as String?,
      added_date: json['added_date'] as String?,
      duration: json['duration'] as String?,
      imdb_rating: (json['imdb_rating'] as num?)?.toDouble(),
      tags: json['tags'] as List<dynamic>?,
      show_times: (json['show_times'] as List<dynamic>?)
          ?.map((e) => ShowTimesResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$MovieResponseImplToJson(_$MovieResponseImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'photo': instance.photo,
      'vertical_photo': instance.vertical_photo,
      'description': instance.description,
      'short_description': instance.short_description,
      'sponsor_video': instance.sponsor_video,
      'actors': instance.actors,
      'release_date': instance.release_date,
      'added_date': instance.added_date,
      'duration': instance.duration,
      'imdb_rating': instance.imdb_rating,
      'tags': instance.tags,
      'show_times': instance.show_times,
    };
