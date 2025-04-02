import 'package:freezed_annotation/freezed_annotation.dart';


part 'billing_info.freezed.dart';
part 'billing_info.g.dart';

@freezed
class BillingInfo with _$BillingInfo {
  const factory BillingInfo({

    required double totalBill,
    required double priceWithoutOffer,
    required DateTime reservationDate,
    required int? movieId,
    required String? movieName,
    required String? photo,
    required String? verticalPhoto,
    required String? duration,
    required List<dynamic>? tags,
    int? showTimesResponseId,
    String? showTimesResponseDate,
    String? showTimesResponseTime,
    String? showTimesResponseHall,
    DateTime? refundDate,
    String? refundReason,
    required double? ticket_price,
    required String guestId,
    required List<dynamic>? reserved_seats,
    required String? reservations_code,
    required String? charging_id,
    required String referenceNumber,
    String ? receiptUrl,
    bool ? refunded,
    String ? paymentType,
    double ? refundedAmount

  }) = _BillingInfo;

  factory BillingInfo.fromJson(Map<String, dynamic> json) =>
      _$BillingInfoFromJson(json);
}
