import '../../../app/extensions/null_safety_extensions.dart';
import '../../app/components/constants/dio_and_mapper_constants.dart';
import '../../domain/models/billing_info/billing_info.dart';
import '../../domain/models/movie_model/movie_model.dart';
import '../../domain/models/show_time_response/show_time_response.dart';
import '../../domain/models/user_model/user_model.dart';

extension MovieResponseMapper on MovieResponse? {
  MovieResponse toDomain() => MovieResponse(
        tags: this?.tags.orEmptyList() ?? AppConstants.emptyList,
        actors: this?.actors.orEmptyList() ?? AppConstants.emptyStringList,
        sponsor_video: this?.sponsor_video.orEmpty() ?? AppConstants.emptyText,
        short_description:
            this?.short_description.orEmpty() ?? AppConstants.emptyText,
        release_date: this?.release_date.orEmpty() ?? AppConstants.emptyText,
        added_date: this?.added_date.orEmpty() ?? AppConstants.emptyText,
        imdb_rating: this?.imdb_rating.orZero() ?? AppConstants.doubleZero,
        duration: this?.duration.orEmpty() ?? AppConstants.emptyText,
        vertical_photo:
            this?.vertical_photo.orEmpty() ?? AppConstants.emptyText,
        description: this?.description.orEmpty() ?? AppConstants.emptyText,
        name: this?.name.orEmpty() ?? AppConstants.emptyText,
        photo: this?.photo.orEmpty() ?? AppConstants.emptyText,
        id: this?.id.orZero() ?? AppConstants.intZero,
    show_times: this?.show_times.orEmptyShowTimesResponseList() ?? AppConstants.emptyShowTimesResponseList
      );
}

extension ShowTimesResponseMapper on ShowTimesResponse? {
  ShowTimesResponse toDomain() => ShowTimesResponse(
        date: this?.date.orEmpty() ?? AppConstants.emptyText,
        hall: this?.hall.orEmpty() ?? AppConstants.emptyText,
        time: this?.time.orEmpty() ?? AppConstants.emptyText,
        available_seats: this?.available_seats.orZero() ?? AppConstants.intZero,
        ticket_price: this?.ticket_price.orZero() ?? AppConstants.doubleZero,
        reserved_seats:
            this?.reserved_seats.orEmptyList() ?? AppConstants.emptyList,
        id: this?.id.orZero() ?? AppConstants.intZero,
        total_seats: this?.total_seats.orZero() ?? AppConstants.intZero,
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
        token: this?.token.orEmpty() ?? AppConstants.emptyText,
        walletMoney: this?.walletMoney ?? AppConstants.doubleZero,
        bills: this?.bills ?? AppConstants.emptyBillingInfoList,
      );
}

extension BillingInfoMapper on BillingInfo? {
  BillingInfo toDomain() => BillingInfo(
    refundDate:this?.refundDate ,
    paymentType:this?.paymentType ,
    receiptUrl:this?.receiptUrl ,
    refunded:this?.refunded ,
    refundReason:this?.refundReason.orEmpty()?? AppConstants.emptyText ,
    referenceNumber: this?.referenceNumber.orEmpty() ??AppConstants.emptyText ,
    totalBill: this?.totalBill ?? AppConstants.doubleZero,
    priceWithoutOffer: this?.priceWithoutOffer ?? AppConstants.doubleZero,
    reservationDate: this?.reservationDate ?? DateTime(1970, 1, 1),
    movieId: this?.movieId ?? AppConstants.intZero,
    movieName: this?.movieName.orEmpty() ?? AppConstants.emptyText,
    photo: this?.photo.orEmpty() ?? AppConstants.emptyText,
    verticalPhoto: this?.verticalPhoto.orEmpty() ?? AppConstants.emptyText,
    duration: this?.duration.orEmpty() ?? AppConstants.emptyText,
    tags: this?.tags.orEmptyList() ?? AppConstants.emptyList,
    showTimesResponseId: this?.showTimesResponseId ?? AppConstants.intZero,
    showTimesResponseDate: this?.showTimesResponseDate.orEmpty() ?? AppConstants.emptyText,
    showTimesResponseTime: this?.showTimesResponseTime.orEmpty() ?? AppConstants.emptyText,
    showTimesResponseHall: this?.showTimesResponseHall.orEmpty() ?? AppConstants.emptyText,
    ticket_price: this?.ticket_price ?? AppConstants.doubleZero,
    guestId: this?.guestId.orEmpty() ?? AppConstants.emptyText,
    reserved_seats: this?.reserved_seats.orEmptyList() ?? AppConstants.emptyList,
    reservations_code: this?.reservations_code.orEmpty() ?? AppConstants.emptyText,
    charging_id: this?.charging_id.orEmpty() ?? AppConstants.emptyText,
  );
}
