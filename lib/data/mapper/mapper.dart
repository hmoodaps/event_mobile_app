import 'package:event_mobile_app/app/extensions/null_safety_extensions.dart';
import 'package:event_mobile_app/data/models/movie_model.dart';
import 'package:event_mobile_app/app/components/constants/dio_and_mapper_constants.dart';

import '../models/user_model.dart';

extension MovieResponseMapper on MovieResponse? {
  Map<String, dynamic> toDomain() => {
    'tags': this?.tags.orEmptyList() ?? AppConstants.emptyList,
    'sponsorVideo': this?.sponsorVideo.orEmpty() ?? AppConstants.emptyText,
    'showTimes': this?.showTimes?.toDomain() ?? {
      'dates': AppConstants.emptyList,
      'halls': AppConstants.emptyList,
      'times': AppConstants.emptyList,
    },
    'shortDescription': this?.shortDescription.orEmpty() ?? AppConstants.emptyText,
    'releaseDate': this?.releaseDate.orEmpty() ?? AppConstants.emptyText,
    'rating': this?.rating.orZero() ?? AppConstants.doubleZero,
    'imdbRating': this?.imdbRating.orZero() ?? AppConstants.doubleZero,
    'duration': this?.duration.orEmpty() ?? AppConstants.emptyText,
    'actors': this?.actors.orEmptyList() ?? AppConstants.emptyList,
    'availableSeats': this?.availableSeats.orZero() ?? AppConstants.intZero,
    'reservations': this?.reservations.orZero() ?? AppConstants.intZero,
    'verticalPhoto': this?.verticalPhoto.orEmpty() ?? AppConstants.emptyText,
    'ticketPrice': this?.ticketPrice.orZero() ?? AppConstants.doubleZero,
    'seats': this?.seats.orZero() ?? AppConstants.intZero,
    'reservedSeats': this?.reservedSeats.orEmptyList() ?? AppConstants.emptyList,
    'description': this?.description.orEmpty() ?? AppConstants.emptyText,
    'name': this?.name.orEmpty() ?? AppConstants.emptyText,
    'id': this?.id.orZero() ?? AppConstants.intZero,
    'photo': this?.photo.orEmpty() ?? AppConstants.emptyText,
  };
}

extension ShowTimesResponseMapper on ShowTimesResponse? {
  Map<String, dynamic> toDomain() => {
    'dates': this?.dates.orEmptyList() ?? AppConstants.emptyList,
    'halls': this?.halls.orEmptyList() ?? AppConstants.emptyList,
    'times': this?.times.orEmptyList() ?? AppConstants.emptyList,
  };
}


extension UserResponseMapper on UserResponse? {
  UserResponse toDomain() => UserResponse(
    id: this?.id ?? AppConstants.emptyText,
    fullName: this?.fullName ?? AppConstants.emptyText,
    email: this?.email ?? AppConstants.emptyText,
    dateOfBirth: this?.dateOfBirth ?? AppConstants.defaultDate,
    mobileNumber: this?.mobileNumber ?? AppConstants.emptyText,
    cart: this?.cart ?? AppConstants.emptyIntList,
    favorites: this?.favorites ?? AppConstants.emptyIntList,
    postalCode: this?.postalCode ?? AppConstants.emptyText,
    houseNumber: this?.houseNumber ?? AppConstants.emptyText,
    town: this?.town ?? AppConstants.emptyText,
    street: this?.street ?? AppConstants.emptyText,
    userPhotoUrl: this?.userPhotoUrl ?? AppConstants.emptyText,
    reservedMovies: this?.reservedMovies ?? AppConstants.emptyIntList,
    movieSeats: this?.movieSeats ?? AppConstants.emptyIntListMap,
    movieTotalPayment: this?.movieTotalPayment ?? AppConstants.emptyIntDoubleMap,
  );
}
