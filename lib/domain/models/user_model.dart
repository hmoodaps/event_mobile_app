class UserModel {
  String ? id;
  String? fullName;
  String? email;
  DateTime? dateOfBirth;
  String? mobileNumber;
  List<int> ? cart;
  List<int> ? favorites;
  String? postalCode;
  String? houseNumber;
  String? town;
  String? street;
  String? userPhotoUrl;
  List<int?> ? movies;
  int? totalReservations = 0;
  Map<int, List<String>> ? movieSeats;
  Map<int, double> ? movieTotalPayment;

  UserModel({
    this.fullName,
    this.email,
    this.dateOfBirth,
    this.userPhotoUrl,
    this.houseNumber,
    this.mobileNumber,
    this.postalCode,
    this.street,
    this.town,
    this.id,
    this.movies,
    this.totalReservations,
    this.movieTotalPayment,
    this.movieSeats,
    this.cart,
   this.favorites,
  }) ;

  UserModel.fromJson(Map<String, dynamic> json) {
    fullName = json['fullName'] ?? '';
    userPhotoUrl = json['userPhotoUrl'] ?? '';
    email = json['email'] ?? '';
    dateOfBirth = json['dateOfBirth'] != null ? DateTime.parse(json['dateOfBirth']) : DateTime.now();
    mobileNumber = json['mobileNumber'] ?? '';
    postalCode = json['postalCode'] ?? '';
    houseNumber = json['houseNumber'] ?? '';
    town = json['town'] ?? '';
    id = json['id'];
    movies = List<int>.from(json['movies'] ?? []);
    totalReservations = json['totalReservations'] ?? 0;
    movieSeats = Map<int, List<String>>.from(json['movieSeats'] ?? {});
    movieTotalPayment = Map<int, double>.from(json['movieTotalPayment'] ?? {});
    cart = List<int>.from(json['cart'] ?? []);
    favorites = List<int>.from(json['favorites'] ?? []);
  }

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'userPhotoUrl': userPhotoUrl,
      'email': email,
      'dateOfBirth': dateOfBirth?.toIso8601String(),
      'mobileNumber': mobileNumber,
      'postalCode': postalCode,
      'houseNumber': houseNumber,
      'town': town,
      'id': id,
      'movies': movies,
      'totalReservations': totalReservations,
      'movieSeats': movieSeats,
      'movieTotalPayment': movieTotalPayment,
      'cart': cart,
      'favorites': favorites,
    };
  }
}
