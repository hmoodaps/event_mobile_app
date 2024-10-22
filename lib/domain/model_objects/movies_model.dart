class MoviesModel{
  int id;
  String name;
  int seats;
  int availableSeats;
  int reservations;
  String photo;
  double ticketPrice;
  List<dynamic> reservedSeats;
  String description;
  String shortDescription;
  String verticalPhoto;
  String sponsorVideo;
  String releaseDate;
  String duration;
  double rating;
  double imdbRating;
  List<dynamic> tags;
  List<dynamic> actors;
  ShowTimes ? showTimes;
  MoviesModel(this.tags , this.sponsorVideo , this.showTimes , this.shortDescription , this.releaseDate , this.rating , this.imdbRating , this.duration , this.actors , this.availableSeats , this.reservations , this.verticalPhoto , this.ticketPrice  , this.seats , this.reservedSeats ,this.description , this.name , this .id , this.photo);
}
class ShowTimes{
  List<dynamic> dates;
  List<dynamic> halls;
  List<dynamic> times;

  ShowTimes(this.dates, this.halls, this.times);
}