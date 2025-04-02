// i created som extensions to make sure
// the Primitive  types(like String int list >>> etc) not returning null value
// and we will use the mapper to help us ..
// u can see the mapper.dart in mapper dir. in data layer
// but the other type can return null bcz i don't want to create Dummy Object
//A Dummy Object is used in programming to represent an object during testing,
// but without containing any real data or logic. Its purpose is to fill in required parameters
// or satisfy the method signatures without impacting the actual behavior of the program.
//
// The primary purpose of a dummy object is:
// To act as a placeholder in unit tests where the real object is not necessary.
// To fulfill dependencies or method parameters, allowing the test to focus on other behaviors.
// To ensure that the code can execute without requiring fully functional objects in scenarios where they are not critical for the test.

import '../../domain/models/show_time_response/show_time_response.dart';

extension NonNullDoubleParse on String? {
  double toDoubleOrZero() {
    return this == null ? 0.0 : double.tryParse(this!) ?? 0.0;
  }
}

extension NonNullString on String? {
  String orEmpty() {
    return this ?? '';
  }
}

extension NonNullBool on bool? {
  bool orFalse() {
    return this ?? false;
  }
}

extension NonNullInt on int? {
  int orZero() {
    return this ?? 0;
  }
}

extension NonNullDouble on double? {
  double orZero() {
    return this ?? 0.0;
  }
}

extension NonNullList on List? {
  List orEmptyList() {
    return this ?? [];
  }
}
extension emptyShowTimesResponseList on List<ShowTimesResponse>? {
  List<ShowTimesResponse>?  orEmptyShowTimesResponseList() {
    return this ?? [];
  }
}

extension NonNullIntList on List<int>? {
  List<int> orEmptyIntList() {
    return this ?? [];
  }
}

extension StringExtensions on String? {
  /// Tries to parse a [String] to a [double]. Returns `0.0` if null or invalid.
  double toDoubleOrZero() => this == null ? 0.0 : double.tryParse(this!) ?? 0.0;
}
