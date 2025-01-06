import '../../../app/extensions/null_safety_extensions.dart';
import '../../app/components/constants/dio_and_mapper_constants.dart';
import '../models/movie_model.dart';
import '../models/user_model.dart';

extension MovieResponseMapper on MovieResponse? {
  MovieResponse toDomain() => MovieResponse(
        tags: this?.tags.orEmptyList() ?? AppConstants.emptyList,
        actors: this?.actors.orEmptyList() ?? AppConstants.emptyList,
        sponsorVideo: this?.sponsorVideo.orEmpty() ?? AppConstants.emptyText,
        showTimes: this?.showTimes?.toDomain() ??
            ShowTimesResponse(
                dates: AppConstants.emptyList,
                halls: AppConstants.emptyList,
                times: AppConstants.emptyList),
        shortDescription:
            this?.shortDescription.orEmpty() ?? AppConstants.emptyText,
        releaseDate: this?.releaseDate.orEmpty() ?? AppConstants.emptyText,
        addedDate: this?.addedDate.orEmpty() ?? AppConstants.emptyText,
        imdbRating: this?.imdbRating.orZero() ?? AppConstants.doubleZero,
        duration: this?.duration.orEmpty() ?? AppConstants.emptyText,
        availableSeats: this?.availableSeats.orZero() ?? AppConstants.intZero,
        reservations: this?.reservations.orZero() ?? AppConstants.intZero,
        verticalPhoto: this?.verticalPhoto.orEmpty() ?? AppConstants.emptyText,
        ticketPrice: this?.ticketPrice.orZero() ?? AppConstants.doubleZero,
        seats: this?.seats.orZero() ?? AppConstants.intZero,
        reservedSeats:
            this?.reservedSeats.orEmptyList() ?? AppConstants.emptyList,
        description: this?.description.orEmpty() ?? AppConstants.emptyText,
        name: this?.name.orEmpty() ?? AppConstants.emptyText,
        photo: this?.photo.orEmpty() ?? AppConstants.emptyText,
        id: this?.id.orZero() ?? AppConstants.intZero,
      );
}

extension ShowTimesResponseMapper on ShowTimesResponse? {
  ShowTimesResponse toDomain() => ShowTimesResponse(
        dates: this?.dates.orEmptyList() ?? AppConstants.emptyList,
        halls: this?.halls.orEmptyList() ?? AppConstants.emptyList,
        times: this?.times.orEmptyList() ?? AppConstants.emptyList,
      );
}

extension UserResponseMapper on UserResponse? {
  UserResponse toDomain() => UserResponse(
        id: this?.id ?? AppConstants.emptyText,
        additionalInfo: this?.additionalInfo ?? AppConstants.emptyText,
        fullName: this?.fullName ?? AppConstants.emptyText,
        email: this?.email ?? AppConstants.emptyText,
        dateOfBirth: this?.dateOfBirth ?? AppConstants.emptyText,
        mobileNumber: this?.mobileNumber ?? AppConstants.emptyText,
        // cart: this?.cart ?? AppConstants.emptyIntList,
        favorites: this?.favorites ?? AppConstants.emptyIntList,
        postalCode: this?.postalCode ?? AppConstants.emptyText,
        houseNumber: this?.houseNumber ?? AppConstants.emptyText,
        town: this?.town ?? AppConstants.emptyText,
        street: this?.street ?? AppConstants.emptyText,
        userPhotoUrl: this?.userPhotoUrl ?? AppConstants.emptyText,
        billingInfo: this
                ?.billingInfo
                ?.map((billing) => BillingInfo(
                      reservedSeats: billing.reservedSeats.orEmptyIntList(),
                      seatPrice: billing.seatPrice.orZero(),
                      totalBill: billing.totalBill.orZero(),
                      isPaid: billing.isPaid.orFalse(), reservedMovie: AppConstants.intZero, paymentMethod: '', currency: '',
                    ))
                .toList() ??
            [],
      );
}
