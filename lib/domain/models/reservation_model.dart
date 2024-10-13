class ReservationModel {
  int? id;
  int? movieId;
  int? guestId;
  String? reservationCode;

  ReservationModel({
    this.id,
    this.movieId,
    this.guestId,
    this.reservationCode,
  });

  ReservationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    movieId = json['movie_id'];
    guestId = json['guest_id'];
    reservationCode = json['reservations_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['movie_id'] = movieId;
    data['guest_id'] = guestId;
    data['reservations_code'] = reservationCode;
    return data;
  }
}
