class GuestModel {
  int? id;
  String? fullName;
  int? age;
  List<String>? seats;
  int? reservations;
  int? movieId;

  GuestModel({
    this.id,
    this.fullName,
    this.age,
    this.seats,
    this.reservations,
    this.movieId,
  });

  GuestModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    age = json['age'];
    seats = json['seats'] ?? [];
    reservations = json['reservations'];
    movieId = json['movie_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['full_name'] = fullName;
    data['age'] = age;
    data['seats'] = seats;
    data['reservations'] = reservations;
    data['movie_id'] = movieId;
    return data;
  }
}
