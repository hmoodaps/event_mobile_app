// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'movie_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MovieResponse _$MovieResponseFromJson(Map<String, dynamic> json) {
  return _MovieResponse.fromJson(json);
}

/// @nodoc
mixin _$MovieResponse {
  int? get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get photo => throw _privateConstructorUsedError;
  String? get vertical_photo => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get short_description => throw _privateConstructorUsedError;
  String? get sponsor_video => throw _privateConstructorUsedError;
  List<dynamic>? get actors => throw _privateConstructorUsedError;
  String? get release_date => throw _privateConstructorUsedError;
  String? get added_date => throw _privateConstructorUsedError;
  String? get duration => throw _privateConstructorUsedError;
  double? get imdb_rating => throw _privateConstructorUsedError;
  List<dynamic>? get tags => throw _privateConstructorUsedError;
  List<ShowTimesResponse>? get show_times => throw _privateConstructorUsedError;

  /// Serializes this MovieResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MovieResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MovieResponseCopyWith<MovieResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MovieResponseCopyWith<$Res> {
  factory $MovieResponseCopyWith(
          MovieResponse value, $Res Function(MovieResponse) then) =
      _$MovieResponseCopyWithImpl<$Res, MovieResponse>;
  @useResult
  $Res call(
      {int? id,
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
      List<ShowTimesResponse>? show_times});
}

/// @nodoc
class _$MovieResponseCopyWithImpl<$Res, $Val extends MovieResponse>
    implements $MovieResponseCopyWith<$Res> {
  _$MovieResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MovieResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? photo = freezed,
    Object? vertical_photo = freezed,
    Object? description = freezed,
    Object? short_description = freezed,
    Object? sponsor_video = freezed,
    Object? actors = freezed,
    Object? release_date = freezed,
    Object? added_date = freezed,
    Object? duration = freezed,
    Object? imdb_rating = freezed,
    Object? tags = freezed,
    Object? show_times = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      photo: freezed == photo
          ? _value.photo
          : photo // ignore: cast_nullable_to_non_nullable
              as String?,
      vertical_photo: freezed == vertical_photo
          ? _value.vertical_photo
          : vertical_photo // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      short_description: freezed == short_description
          ? _value.short_description
          : short_description // ignore: cast_nullable_to_non_nullable
              as String?,
      sponsor_video: freezed == sponsor_video
          ? _value.sponsor_video
          : sponsor_video // ignore: cast_nullable_to_non_nullable
              as String?,
      actors: freezed == actors
          ? _value.actors
          : actors // ignore: cast_nullable_to_non_nullable
              as List<dynamic>?,
      release_date: freezed == release_date
          ? _value.release_date
          : release_date // ignore: cast_nullable_to_non_nullable
              as String?,
      added_date: freezed == added_date
          ? _value.added_date
          : added_date // ignore: cast_nullable_to_non_nullable
              as String?,
      duration: freezed == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as String?,
      imdb_rating: freezed == imdb_rating
          ? _value.imdb_rating
          : imdb_rating // ignore: cast_nullable_to_non_nullable
              as double?,
      tags: freezed == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<dynamic>?,
      show_times: freezed == show_times
          ? _value.show_times
          : show_times // ignore: cast_nullable_to_non_nullable
              as List<ShowTimesResponse>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MovieResponseImplCopyWith<$Res>
    implements $MovieResponseCopyWith<$Res> {
  factory _$$MovieResponseImplCopyWith(
          _$MovieResponseImpl value, $Res Function(_$MovieResponseImpl) then) =
      __$$MovieResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
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
      List<ShowTimesResponse>? show_times});
}

/// @nodoc
class __$$MovieResponseImplCopyWithImpl<$Res>
    extends _$MovieResponseCopyWithImpl<$Res, _$MovieResponseImpl>
    implements _$$MovieResponseImplCopyWith<$Res> {
  __$$MovieResponseImplCopyWithImpl(
      _$MovieResponseImpl _value, $Res Function(_$MovieResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of MovieResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? photo = freezed,
    Object? vertical_photo = freezed,
    Object? description = freezed,
    Object? short_description = freezed,
    Object? sponsor_video = freezed,
    Object? actors = freezed,
    Object? release_date = freezed,
    Object? added_date = freezed,
    Object? duration = freezed,
    Object? imdb_rating = freezed,
    Object? tags = freezed,
    Object? show_times = freezed,
  }) {
    return _then(_$MovieResponseImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      photo: freezed == photo
          ? _value.photo
          : photo // ignore: cast_nullable_to_non_nullable
              as String?,
      vertical_photo: freezed == vertical_photo
          ? _value.vertical_photo
          : vertical_photo // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      short_description: freezed == short_description
          ? _value.short_description
          : short_description // ignore: cast_nullable_to_non_nullable
              as String?,
      sponsor_video: freezed == sponsor_video
          ? _value.sponsor_video
          : sponsor_video // ignore: cast_nullable_to_non_nullable
              as String?,
      actors: freezed == actors
          ? _value._actors
          : actors // ignore: cast_nullable_to_non_nullable
              as List<dynamic>?,
      release_date: freezed == release_date
          ? _value.release_date
          : release_date // ignore: cast_nullable_to_non_nullable
              as String?,
      added_date: freezed == added_date
          ? _value.added_date
          : added_date // ignore: cast_nullable_to_non_nullable
              as String?,
      duration: freezed == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as String?,
      imdb_rating: freezed == imdb_rating
          ? _value.imdb_rating
          : imdb_rating // ignore: cast_nullable_to_non_nullable
              as double?,
      tags: freezed == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<dynamic>?,
      show_times: freezed == show_times
          ? _value._show_times
          : show_times // ignore: cast_nullable_to_non_nullable
              as List<ShowTimesResponse>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MovieResponseImpl implements _MovieResponse {
  const _$MovieResponseImpl(
      {this.id,
      this.name,
      this.photo,
      this.vertical_photo,
      this.description,
      this.short_description,
      this.sponsor_video,
      final List<dynamic>? actors,
      this.release_date,
      this.added_date,
      this.duration,
      this.imdb_rating,
      final List<dynamic>? tags,
      final List<ShowTimesResponse>? show_times})
      : _actors = actors,
        _tags = tags,
        _show_times = show_times;

  factory _$MovieResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$MovieResponseImplFromJson(json);

  @override
  final int? id;
  @override
  final String? name;
  @override
  final String? photo;
  @override
  final String? vertical_photo;
  @override
  final String? description;
  @override
  final String? short_description;
  @override
  final String? sponsor_video;
  final List<dynamic>? _actors;
  @override
  List<dynamic>? get actors {
    final value = _actors;
    if (value == null) return null;
    if (_actors is EqualUnmodifiableListView) return _actors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? release_date;
  @override
  final String? added_date;
  @override
  final String? duration;
  @override
  final double? imdb_rating;
  final List<dynamic>? _tags;
  @override
  List<dynamic>? get tags {
    final value = _tags;
    if (value == null) return null;
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<ShowTimesResponse>? _show_times;
  @override
  List<ShowTimesResponse>? get show_times {
    final value = _show_times;
    if (value == null) return null;
    if (_show_times is EqualUnmodifiableListView) return _show_times;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'MovieResponse(id: $id, name: $name, photo: $photo, vertical_photo: $vertical_photo, description: $description, short_description: $short_description, sponsor_video: $sponsor_video, actors: $actors, release_date: $release_date, added_date: $added_date, duration: $duration, imdb_rating: $imdb_rating, tags: $tags, show_times: $show_times)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MovieResponseImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.photo, photo) || other.photo == photo) &&
            (identical(other.vertical_photo, vertical_photo) ||
                other.vertical_photo == vertical_photo) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.short_description, short_description) ||
                other.short_description == short_description) &&
            (identical(other.sponsor_video, sponsor_video) ||
                other.sponsor_video == sponsor_video) &&
            const DeepCollectionEquality().equals(other._actors, _actors) &&
            (identical(other.release_date, release_date) ||
                other.release_date == release_date) &&
            (identical(other.added_date, added_date) ||
                other.added_date == added_date) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.imdb_rating, imdb_rating) ||
                other.imdb_rating == imdb_rating) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            const DeepCollectionEquality()
                .equals(other._show_times, _show_times));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      photo,
      vertical_photo,
      description,
      short_description,
      sponsor_video,
      const DeepCollectionEquality().hash(_actors),
      release_date,
      added_date,
      duration,
      imdb_rating,
      const DeepCollectionEquality().hash(_tags),
      const DeepCollectionEquality().hash(_show_times));

  /// Create a copy of MovieResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MovieResponseImplCopyWith<_$MovieResponseImpl> get copyWith =>
      __$$MovieResponseImplCopyWithImpl<_$MovieResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MovieResponseImplToJson(
      this,
    );
  }
}

abstract class _MovieResponse implements MovieResponse {
  const factory _MovieResponse(
      {final int? id,
      final String? name,
      final String? photo,
      final String? vertical_photo,
      final String? description,
      final String? short_description,
      final String? sponsor_video,
      final List<dynamic>? actors,
      final String? release_date,
      final String? added_date,
      final String? duration,
      final double? imdb_rating,
      final List<dynamic>? tags,
      final List<ShowTimesResponse>? show_times}) = _$MovieResponseImpl;

  factory _MovieResponse.fromJson(Map<String, dynamic> json) =
      _$MovieResponseImpl.fromJson;

  @override
  int? get id;
  @override
  String? get name;
  @override
  String? get photo;
  @override
  String? get vertical_photo;
  @override
  String? get description;
  @override
  String? get short_description;
  @override
  String? get sponsor_video;
  @override
  List<dynamic>? get actors;
  @override
  String? get release_date;
  @override
  String? get added_date;
  @override
  String? get duration;
  @override
  double? get imdb_rating;
  @override
  List<dynamic>? get tags;
  @override
  List<ShowTimesResponse>? get show_times;

  /// Create a copy of MovieResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MovieResponseImplCopyWith<_$MovieResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
