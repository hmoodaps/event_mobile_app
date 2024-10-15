class MovieModel {
  int? id;
  String? name;
  List<Map<String, List<String>>>? showTimes;
  int? seats;
  int? availableSeats;
  String? photo;
  String? verticalPhoto;
  int? ticketPrice;
  List<String>? reservedSeats;
  String? description;
  String? shortDescription;
  String? sponsorVideo;
  List<String>? actors;
  String? releaseDate;
  String? duration;
  double? rating;
  double? imdbRating;
  List<String>? tags;
  String? fhdImage;
  String? genre;

  MovieModel({
    this.id,
    this.name,
    this.showTimes,
    this.seats,
    this.availableSeats,
    this.photo,
    this.verticalPhoto,
    this.ticketPrice,
    this.reservedSeats,
    this.description,
    this.shortDescription,
    this.sponsorVideo,
    this.actors,
    this.releaseDate,
    this.duration,
    this.rating,
    this.imdbRating,
    this.tags,
    this.fhdImage,
    this.genre,
  });

  MovieModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    showTimes = json['show_times'];
    seats = json['seats'];
    availableSeats = json['available_seats'];
    photo = json['photo'];
    verticalPhoto = json['vertical_photo'];
    ticketPrice = json['ticket_price'];
    reservedSeats = List<String>.from(json['reservedSeats'] ?? []);
    description = json['description'];
    shortDescription = json['short_description'];
    sponsorVideo = json['sponsor_video'];
    actors = json['actors'];
    releaseDate = json['release_date'];
    duration = json['duration'];
    rating = json['rating'];
    imdbRating = json['imdb_rating'];
    tags = json['tags'];
    fhdImage = json['fhd_image'];
    genre = json['genre'];
  }

//I don't need this bcz this app just for gusts
// Map<String, dynamic> toJson() {
//   final Map<String, dynamic> data = <String, dynamic>{};
//   data['id'] = id;
//   data['name'] = name;
//   data['show_times'] = showTimes;
//   data['seats'] = seats;
//   data['available_seats'] = availableSeats;
//   data['photo'] = photo;
//   data['vertical_photo'] = verticalPhoto;
//   data['ticket_price'] = ticketPrice;
//   data['reservedSeats'] = reservedSeats;
//   data['description'] = description;
//   data['short_description'] = shortDescription;
//   data['sponsor_video'] = sponsorVideo;
//   data['actors'] = actors;
//   data['release_date'] = releaseDate;
//   data['duration'] = duration;
//   data['rating'] = rating;
//   data['imdb_rating'] = imdbRating;
//   data['tags'] = tags;
//   data['fhd_image'] = fhdImage;
//   data['genre'] = genre;
//   return data;
// }
}
