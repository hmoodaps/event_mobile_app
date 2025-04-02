// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UserResponse _$UserResponseFromJson(Map<String, dynamic> json) {
  return _UserResponse.fromJson(json);
}

/// @nodoc
mixin _$UserResponse {
  String? get id => throw _privateConstructorUsedError;
  String? get fullName => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String? get dateOfBirth => throw _privateConstructorUsedError;
  String? get mobileNumber => throw _privateConstructorUsedError;
  List<int>? get favorites => throw _privateConstructorUsedError;
  String? get postalCode => throw _privateConstructorUsedError;
  String? get houseNumber => throw _privateConstructorUsedError;
  String? get town => throw _privateConstructorUsedError;
  String? get additionalInfo => throw _privateConstructorUsedError;
  String? get street => throw _privateConstructorUsedError;
  String? get userPhotoUrl => throw _privateConstructorUsedError;
  double? get walletMoney => throw _privateConstructorUsedError;
  List<BillingInfo>? get bills => throw _privateConstructorUsedError;
  String? get token => throw _privateConstructorUsedError;

  /// Serializes this UserResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserResponseCopyWith<UserResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserResponseCopyWith<$Res> {
  factory $UserResponseCopyWith(
          UserResponse value, $Res Function(UserResponse) then) =
      _$UserResponseCopyWithImpl<$Res, UserResponse>;
  @useResult
  $Res call(
      {String? id,
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
      List<BillingInfo>? bills,
      String? token});
}

/// @nodoc
class _$UserResponseCopyWithImpl<$Res, $Val extends UserResponse>
    implements $UserResponseCopyWith<$Res> {
  _$UserResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? fullName = freezed,
    Object? email = freezed,
    Object? dateOfBirth = freezed,
    Object? mobileNumber = freezed,
    Object? favorites = freezed,
    Object? postalCode = freezed,
    Object? houseNumber = freezed,
    Object? town = freezed,
    Object? additionalInfo = freezed,
    Object? street = freezed,
    Object? userPhotoUrl = freezed,
    Object? walletMoney = freezed,
    Object? bills = freezed,
    Object? token = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      fullName: freezed == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      dateOfBirth: freezed == dateOfBirth
          ? _value.dateOfBirth
          : dateOfBirth // ignore: cast_nullable_to_non_nullable
              as String?,
      mobileNumber: freezed == mobileNumber
          ? _value.mobileNumber
          : mobileNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      favorites: freezed == favorites
          ? _value.favorites
          : favorites // ignore: cast_nullable_to_non_nullable
              as List<int>?,
      postalCode: freezed == postalCode
          ? _value.postalCode
          : postalCode // ignore: cast_nullable_to_non_nullable
              as String?,
      houseNumber: freezed == houseNumber
          ? _value.houseNumber
          : houseNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      town: freezed == town
          ? _value.town
          : town // ignore: cast_nullable_to_non_nullable
              as String?,
      additionalInfo: freezed == additionalInfo
          ? _value.additionalInfo
          : additionalInfo // ignore: cast_nullable_to_non_nullable
              as String?,
      street: freezed == street
          ? _value.street
          : street // ignore: cast_nullable_to_non_nullable
              as String?,
      userPhotoUrl: freezed == userPhotoUrl
          ? _value.userPhotoUrl
          : userPhotoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      walletMoney: freezed == walletMoney
          ? _value.walletMoney
          : walletMoney // ignore: cast_nullable_to_non_nullable
              as double?,
      bills: freezed == bills
          ? _value.bills
          : bills // ignore: cast_nullable_to_non_nullable
              as List<BillingInfo>?,
      token: freezed == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserResponseImplCopyWith<$Res>
    implements $UserResponseCopyWith<$Res> {
  factory _$$UserResponseImplCopyWith(
          _$UserResponseImpl value, $Res Function(_$UserResponseImpl) then) =
      __$$UserResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
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
      List<BillingInfo>? bills,
      String? token});
}

/// @nodoc
class __$$UserResponseImplCopyWithImpl<$Res>
    extends _$UserResponseCopyWithImpl<$Res, _$UserResponseImpl>
    implements _$$UserResponseImplCopyWith<$Res> {
  __$$UserResponseImplCopyWithImpl(
      _$UserResponseImpl _value, $Res Function(_$UserResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? fullName = freezed,
    Object? email = freezed,
    Object? dateOfBirth = freezed,
    Object? mobileNumber = freezed,
    Object? favorites = freezed,
    Object? postalCode = freezed,
    Object? houseNumber = freezed,
    Object? town = freezed,
    Object? additionalInfo = freezed,
    Object? street = freezed,
    Object? userPhotoUrl = freezed,
    Object? walletMoney = freezed,
    Object? bills = freezed,
    Object? token = freezed,
  }) {
    return _then(_$UserResponseImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      fullName: freezed == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      dateOfBirth: freezed == dateOfBirth
          ? _value.dateOfBirth
          : dateOfBirth // ignore: cast_nullable_to_non_nullable
              as String?,
      mobileNumber: freezed == mobileNumber
          ? _value.mobileNumber
          : mobileNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      favorites: freezed == favorites
          ? _value._favorites
          : favorites // ignore: cast_nullable_to_non_nullable
              as List<int>?,
      postalCode: freezed == postalCode
          ? _value.postalCode
          : postalCode // ignore: cast_nullable_to_non_nullable
              as String?,
      houseNumber: freezed == houseNumber
          ? _value.houseNumber
          : houseNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      town: freezed == town
          ? _value.town
          : town // ignore: cast_nullable_to_non_nullable
              as String?,
      additionalInfo: freezed == additionalInfo
          ? _value.additionalInfo
          : additionalInfo // ignore: cast_nullable_to_non_nullable
              as String?,
      street: freezed == street
          ? _value.street
          : street // ignore: cast_nullable_to_non_nullable
              as String?,
      userPhotoUrl: freezed == userPhotoUrl
          ? _value.userPhotoUrl
          : userPhotoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      walletMoney: freezed == walletMoney
          ? _value.walletMoney
          : walletMoney // ignore: cast_nullable_to_non_nullable
              as double?,
      bills: freezed == bills
          ? _value._bills
          : bills // ignore: cast_nullable_to_non_nullable
              as List<BillingInfo>?,
      token: freezed == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserResponseImpl implements _UserResponse {
  const _$UserResponseImpl(
      {this.id,
      this.fullName,
      this.email,
      this.dateOfBirth,
      this.mobileNumber,
      final List<int>? favorites,
      this.postalCode,
      this.houseNumber,
      this.town,
      this.additionalInfo,
      this.street,
      this.userPhotoUrl,
      this.walletMoney,
      final List<BillingInfo>? bills,
      this.token})
      : _favorites = favorites,
        _bills = bills;

  factory _$UserResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserResponseImplFromJson(json);

  @override
  final String? id;
  @override
  final String? fullName;
  @override
  final String? email;
  @override
  final String? dateOfBirth;
  @override
  final String? mobileNumber;
  final List<int>? _favorites;
  @override
  List<int>? get favorites {
    final value = _favorites;
    if (value == null) return null;
    if (_favorites is EqualUnmodifiableListView) return _favorites;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? postalCode;
  @override
  final String? houseNumber;
  @override
  final String? town;
  @override
  final String? additionalInfo;
  @override
  final String? street;
  @override
  final String? userPhotoUrl;
  @override
  final double? walletMoney;
  final List<BillingInfo>? _bills;
  @override
  List<BillingInfo>? get bills {
    final value = _bills;
    if (value == null) return null;
    if (_bills is EqualUnmodifiableListView) return _bills;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? token;

  @override
  String toString() {
    return 'UserResponse(id: $id, fullName: $fullName, email: $email, dateOfBirth: $dateOfBirth, mobileNumber: $mobileNumber, favorites: $favorites, postalCode: $postalCode, houseNumber: $houseNumber, town: $town, additionalInfo: $additionalInfo, street: $street, userPhotoUrl: $userPhotoUrl, walletMoney: $walletMoney, bills: $bills, token: $token)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserResponseImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.fullName, fullName) ||
                other.fullName == fullName) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.dateOfBirth, dateOfBirth) ||
                other.dateOfBirth == dateOfBirth) &&
            (identical(other.mobileNumber, mobileNumber) ||
                other.mobileNumber == mobileNumber) &&
            const DeepCollectionEquality()
                .equals(other._favorites, _favorites) &&
            (identical(other.postalCode, postalCode) ||
                other.postalCode == postalCode) &&
            (identical(other.houseNumber, houseNumber) ||
                other.houseNumber == houseNumber) &&
            (identical(other.town, town) || other.town == town) &&
            (identical(other.additionalInfo, additionalInfo) ||
                other.additionalInfo == additionalInfo) &&
            (identical(other.street, street) || other.street == street) &&
            (identical(other.userPhotoUrl, userPhotoUrl) ||
                other.userPhotoUrl == userPhotoUrl) &&
            (identical(other.walletMoney, walletMoney) ||
                other.walletMoney == walletMoney) &&
            const DeepCollectionEquality().equals(other._bills, _bills) &&
            (identical(other.token, token) || other.token == token));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      fullName,
      email,
      dateOfBirth,
      mobileNumber,
      const DeepCollectionEquality().hash(_favorites),
      postalCode,
      houseNumber,
      town,
      additionalInfo,
      street,
      userPhotoUrl,
      walletMoney,
      const DeepCollectionEquality().hash(_bills),
      token);

  /// Create a copy of UserResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserResponseImplCopyWith<_$UserResponseImpl> get copyWith =>
      __$$UserResponseImplCopyWithImpl<_$UserResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserResponseImplToJson(
      this,
    );
  }
}

abstract class _UserResponse implements UserResponse {
  const factory _UserResponse(
      {final String? id,
      final String? fullName,
      final String? email,
      final String? dateOfBirth,
      final String? mobileNumber,
      final List<int>? favorites,
      final String? postalCode,
      final String? houseNumber,
      final String? town,
      final String? additionalInfo,
      final String? street,
      final String? userPhotoUrl,
      final double? walletMoney,
      final List<BillingInfo>? bills,
      final String? token}) = _$UserResponseImpl;

  factory _UserResponse.fromJson(Map<String, dynamic> json) =
      _$UserResponseImpl.fromJson;

  @override
  String? get id;
  @override
  String? get fullName;
  @override
  String? get email;
  @override
  String? get dateOfBirth;
  @override
  String? get mobileNumber;
  @override
  List<int>? get favorites;
  @override
  String? get postalCode;
  @override
  String? get houseNumber;
  @override
  String? get town;
  @override
  String? get additionalInfo;
  @override
  String? get street;
  @override
  String? get userPhotoUrl;
  @override
  double? get walletMoney;
  @override
  List<BillingInfo>? get bills;
  @override
  String? get token;

  /// Create a copy of UserResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserResponseImplCopyWith<_$UserResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
