// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BillingInfoImpl _$$BillingInfoImplFromJson(Map<String, dynamic> json) =>
    _$BillingInfoImpl(
      reservedSeats: (json['reservedSeats'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      seatPrice: (json['seatPrice'] as num).toDouble(),
      totalBill: (json['totalBill'] as num).toDouble(),
      reservedMovie: (json['reservedMovie'] as num).toInt(),
      isPaid: json['isPaid'] as bool,
      paymentMethod: json['paymentMethod'] as String,
      currency: json['currency'] as String,
    );

Map<String, dynamic> _$$BillingInfoImplToJson(_$BillingInfoImpl instance) =>
    <String, dynamic>{
      'reservedSeats': instance.reservedSeats,
      'seatPrice': instance.seatPrice,
      'totalBill': instance.totalBill,
      'reservedMovie': instance.reservedMovie,
      'isPaid': instance.isPaid,
      'paymentMethod': instance.paymentMethod,
      'currency': instance.currency,
    };

_$UserResponseImpl _$$UserResponseImplFromJson(Map<String, dynamic> json) =>
    _$UserResponseImpl(
      id: json['id'] as String?,
      fullName: json['fullName'] as String?,
      email: json['email'] as String?,
      dateOfBirth: json['dateOfBirth'] as String?,
      mobileNumber: json['mobileNumber'] as String?,
      favorites: (json['favorites'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      postalCode: json['postalCode'] as String?,
      houseNumber: json['houseNumber'] as String?,
      town: json['town'] as String?,
      additionalInfo: json['additionalInfo'] as String?,
      street: json['street'] as String?,
      userPhotoUrl: json['userPhotoUrl'] as String?,
      billingInfo: (json['billingInfo'] as List<dynamic>?)
          ?.map((e) => BillingInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$UserResponseImplToJson(_$UserResponseImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fullName': instance.fullName,
      'email': instance.email,
      'dateOfBirth': instance.dateOfBirth,
      'mobileNumber': instance.mobileNumber,
      'favorites': instance.favorites,
      'postalCode': instance.postalCode,
      'houseNumber': instance.houseNumber,
      'town': instance.town,
      'additionalInfo': instance.additionalInfo,
      'street': instance.street,
      'userPhotoUrl': instance.userPhotoUrl,
      'billingInfo': instance.billingInfo,
    };
