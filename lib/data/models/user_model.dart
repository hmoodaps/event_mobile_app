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
    List<int>? cart,
    List<int>? favorites,
    String? postalCode,
    String? houseNumber,
    String? town,
    String? additionalInfo,
    String? street,
    String? userPhotoUrl,
    List<int>? reservedMovies,
    Map<int, List<String>>? movieSeats,
    Map<int, double>? movieTotalPayment,
  }) = _UserResponse;

  factory UserResponse.fromJson(Map<String, dynamic> json) =>
      _$UserResponseFromJson(json);
}
