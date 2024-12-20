import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class BillingInfo with _$BillingInfo {
  const factory BillingInfo({
    required int numberOfSeats,
    required List<int> reservedSeats,
    required double seatPrice,
    required double totalBill,
    required List<int> reservedMovies,
    required bool isPaid,
  }) = _BillingInfo;

  factory BillingInfo.fromJson(Map<String, dynamic> json) =>
      _$BillingInfoFromJson(json);
}

@freezed
class UserResponse with _$UserResponse {
  const factory UserResponse({
    String? id,
    String? fullName,
    String? email,
    String? dateOfBirth,
    String? mobileNumber,
    List<int>? cart,
    List<int>? favorites,
    String? postalCode,
    String? houseNumber,
    String? town,
    String? additionalInfo,
    String? street,
    String? userPhotoUrl,
    List<BillingInfo>? billingInfo,
  }) = _UserResponse;

  factory UserResponse.fromJson(Map<String, dynamic> json) =>
      _$UserResponseFromJson(json);
}
