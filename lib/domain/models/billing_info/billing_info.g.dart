// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'billing_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BillingInfoImpl _$$BillingInfoImplFromJson(Map<String, dynamic> json) =>
    _$BillingInfoImpl(
      totalBill: (json['totalBill'] as num).toDouble(),
      priceWithoutOffer: (json['priceWithoutOffer'] as num).toDouble(),
      reservationDate: DateTime.parse(json['reservationDate'] as String),
      movieId: (json['movieId'] as num?)?.toInt(),
      movieName: json['movieName'] as String?,
      photo: json['photo'] as String?,
      verticalPhoto: json['verticalPhoto'] as String?,
      duration: json['duration'] as String?,
      tags: json['tags'] as List<dynamic>?,
      showTimesResponseId: (json['showTimesResponseId'] as num?)?.toInt(),
      showTimesResponseDate: json['showTimesResponseDate'] as String?,
      showTimesResponseTime: json['showTimesResponseTime'] as String?,
      showTimesResponseHall: json['showTimesResponseHall'] as String?,
      refundDate: json['refundDate'] == null
          ? null
          : DateTime.parse(json['refundDate'] as String),
      refundReason: json['refundReason'] as String?,
      ticket_price: (json['ticket_price'] as num?)?.toDouble(),
      guestId: json['guestId'] as String,
      reserved_seats: json['reserved_seats'] as List<dynamic>?,
      reservations_code: json['reservations_code'] as String?,
      charging_id: json['charging_id'] as String?,
      referenceNumber: json['referenceNumber'] as String,
      receiptUrl: json['receiptUrl'] as String?,
      refunded: json['refunded'] as bool?,
      paymentType: json['paymentType'] as String?,
      refundedAmount: (json['refundedAmount'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$BillingInfoImplToJson(_$BillingInfoImpl instance) =>
    <String, dynamic>{
      'totalBill': instance.totalBill,
      'priceWithoutOffer': instance.priceWithoutOffer,
      'reservationDate': instance.reservationDate.toIso8601String(),
      'movieId': instance.movieId,
      'movieName': instance.movieName,
      'photo': instance.photo,
      'verticalPhoto': instance.verticalPhoto,
      'duration': instance.duration,
      'tags': instance.tags,
      'showTimesResponseId': instance.showTimesResponseId,
      'showTimesResponseDate': instance.showTimesResponseDate,
      'showTimesResponseTime': instance.showTimesResponseTime,
      'showTimesResponseHall': instance.showTimesResponseHall,
      'refundDate': instance.refundDate?.toIso8601String(),
      'refundReason': instance.refundReason,
      'ticket_price': instance.ticket_price,
      'guestId': instance.guestId,
      'reserved_seats': instance.reserved_seats,
      'reservations_code': instance.reservations_code,
      'charging_id': instance.charging_id,
      'referenceNumber': instance.referenceNumber,
      'receiptUrl': instance.receiptUrl,
      'refunded': instance.refunded,
      'paymentType': instance.paymentType,
      'refundedAmount': instance.refundedAmount,
    };
