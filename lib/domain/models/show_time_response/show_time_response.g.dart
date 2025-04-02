// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'show_time_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ShowTimesResponseImpl _$$ShowTimesResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$ShowTimesResponseImpl(
      id: (json['id'] as num?)?.toInt(),
      date: json['date'] as String?,
      time: json['time'] as String?,
      hall: json['hall'] as String?,
      total_seats: (json['total_seats'] as num?)?.toInt(),
      available_seats: (json['available_seats'] as num?)?.toInt(),
      ticket_price: (json['ticket_price'] as num?)?.toDouble(),
      reserved_seats: json['reserved_seats'] as List<dynamic>?,
    );

Map<String, dynamic> _$$ShowTimesResponseImplToJson(
        _$ShowTimesResponseImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date': instance.date,
      'time': instance.time,
      'hall': instance.hall,
      'total_seats': instance.total_seats,
      'available_seats': instance.available_seats,
      'ticket_price': instance.ticket_price,
      'reserved_seats': instance.reserved_seats,
    };
