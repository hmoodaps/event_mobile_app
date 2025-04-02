import 'package:event_mobile_app/domain/models/billing_info/billing_info.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserResponse with _$UserResponse {
  const factory UserResponse({
    String? id,
    String? fullName,
    String? email,
    String? dateOfBirth,
    String? mobileNumber,
    List<int>? favorites,
    String? postalCode,
    String? houseNumber,
    String? town,
    String? additionalInfo,
    String? street,
    String? userPhotoUrl,
    double? walletMoney,
    List<BillingInfo> ? bills,
    String ?token
  }) = _UserResponse;

  factory UserResponse.fromJson(Map<String, dynamic> json) =>
      _$UserResponseFromJson(json);
}
