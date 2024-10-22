import 'package:event_mobile_app/app/constants&extensions/extensions.dart';
import 'package:event_mobile_app/data/models/movie_model.dart';
import 'package:event_mobile_app/domain/model_objects/movies_model.dart';
import 'package:event_mobile_app/app/constants&extensions/app_constants.dart';
extension MovieModelMapper on MovieResponse? {
  MoviesModel toDomain() => MoviesModel(
      this?.tags.orEmptyList() ?? AppConstants.emptyList,
      this?.sponsorVideo.orEmpty() ?? AppConstants.emptyText,
      this?.showTimes?.toDomain() ?? ShowTimes(AppConstants.emptyList, AppConstants.emptyList, AppConstants.emptyList),
      this?.shortDescription.orEmpty() ?? AppConstants.emptyText,
      this?.releaseDate.orEmpty() ?? AppConstants.emptyText,
      this?.rating.orZero() ?? AppConstants.doubleZero,
      this?.imdbRating.orZero() ?? AppConstants.doubleZero,
      this?.duration.orEmpty() ?? AppConstants.emptyText,
      this?.actors.orEmptyList() ?? AppConstants.emptyList,
      this?.availableSeats.orZero() ?? AppConstants.intZero,
      this?.reservations.orZero() ?? AppConstants.intZero,
      this?.verticalPhoto.orEmpty() ?? AppConstants.emptyText,
      this?.ticketPrice.orZero() ?? AppConstants.doubleZero,
      this?.seats.orZero() ?? AppConstants.intZero,
      this?.reservedSeats.orEmptyList() ?? AppConstants.emptyList,
      this?.description.orEmpty() ?? AppConstants.emptyText,
      this?.name.orEmpty() ?? AppConstants.emptyText,
      this?.id.orZero() ?? AppConstants.intZero,
      this?.photo.orEmpty() ?? AppConstants.emptyText
  );
}

extension ShowTimesResponseMapper on ShowTimesResponse? {
  ShowTimes toDomain() => ShowTimes(
    this?.dates.orEmptyList() ?? AppConstants.emptyList,
    this?.halls.orEmptyList() ?? AppConstants.emptyList,
    this?.times.orEmptyList() ?? AppConstants.emptyList,
  );
}
