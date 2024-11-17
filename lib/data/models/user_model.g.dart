// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserResponseImpl _$$UserResponseImplFromJson(Map<String, dynamic> json) =>
    _$UserResponseImpl(
      id: json['id'] as String?,
      fullName: json['fullName'] as String?,
      email: json['email'] as String?,
      dateOfBirth: json['dateOfBirth'] == null
          ? null
          : DateTime.parse(json['dateOfBirth'] as String),
      mobileNumber: json['mobileNumber'] as String?,
      cart: (json['cart'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      favorites: (json['favorites'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      postalCode: json['postalCode'] as String?,
      houseNumber: json['houseNumber'] as String?,
      town: json['town'] as String?,
      additionalInfo: json['additionalInfo'] as String?,
      street: json['street'] as String?,
      userPhotoUrl: json['userPhotoUrl'] as String?,
      reservedMovies: (json['reservedMovies'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      movieSeats: (json['movieSeats'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(int.parse(k),
            (e as List<dynamic>).map((e) => e as String).toList()),
      ),
      movieTotalPayment:
          (json['movieTotalPayment'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(int.parse(k), (e as num).toDouble()),
      ),
    );

Map<String, dynamic> _$$UserResponseImplToJson(_$UserResponseImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fullName': instance.fullName,
      'email': instance.email,
      'dateOfBirth': instance.dateOfBirth?.toIso8601String(),
      'mobileNumber': instance.mobileNumber,
      'cart': instance.cart,
      'favorites': instance.favorites,
      'postalCode': instance.postalCode,
      'houseNumber': instance.houseNumber,
      'town': instance.town,
      'additionalInfo': instance.additionalInfo,
      'street': instance.street,
      'userPhotoUrl': instance.userPhotoUrl,
      'reservedMovies': instance.reservedMovies,
      'movieSeats':
          instance.movieSeats?.map((k, e) => MapEntry(k.toString(), e)),
      'movieTotalPayment':
          instance.movieTotalPayment?.map((k, e) => MapEntry(k.toString(), e)),
    };
