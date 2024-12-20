class GuestModel {
  String? id; // Changed from int to String
  List<int>? seats; // Changed to list of integers
  double? seatPrice; // Added seat price
  double? totalPrice; // Added total price
  String? showDate; // Added show date
  String? showTime; // Added show time
  int? movieId;

  GuestModel({
    this.id,
    this.seats,
    this.seatPrice,
    this.totalPrice,
    this.showDate,
    this.showTime,
    this.movieId,
  });

  GuestModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    seats = json['seats'] != null ? List<int>.from(json['seats']) : [];
    seatPrice = json['seat_price'];
    totalPrice = json['total_price'];
    showDate = json['show_date'];
    showTime = json['show_time'];
    movieId = json['movie_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['seats'] = seats;
    data['seat_price'] = seatPrice;
    data['total_price'] = totalPrice;
    data['show_date'] = showDate;
    data['show_time'] = showTime;
    data['movie_id'] = movieId;
    return data;
  }
}
