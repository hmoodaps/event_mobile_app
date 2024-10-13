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
  List<int?> ? reservedMovies;
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
    this.reservedMovies,
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
    reservedMovies = List<int>.from(json['movies'] ?? []);
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
      'dateOfBirth': dateOfBirth,
      'mobileNumber': mobileNumber,
      'postalCode': postalCode,
      'houseNumber': houseNumber,
      'town': town,
      'id': id,
      'movies': reservedMovies,
      'movieSeats': movieSeats,
      'movieTotalPayment': movieTotalPayment,
      'cart': cart,
      'favorites': favorites,
    };
  }
}
