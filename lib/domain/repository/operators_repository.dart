import 'package:dartz/dartz.dart';

import '../../data/implementer/failure_class/failure_class.dart';
import '../models/billing_info/billing_info.dart';
import '../models/model_objects/actor_model.dart';
import '../models/movie_model/movie_model.dart';
import '../models/user_model/user_model.dart';

abstract class OperatorsRepository {
  Future<Either<FailureClass, void>> addFilmToFavorites(
      {required MovieResponse movie});

  Future<Either<FailureClass, void>> removeFilmFromFavorites(
      {required MovieResponse movie});

  // Future<Either<FailureClass, void>> addFilmToCart(
  //     {required MovieResponse movie});
  //
  // Future<Either<FailureClass, void>> removeFilmFromCart(
  //     {required MovieResponse movie});

  Future<Either<FailureClass, UserResponse>> getCurrentUserResponse();

  Future<Either<FailureClass, List<ActorModel>>> fetchActorsData(
      {required List<String> actors});
  Future<void> addBillingInfoToUser({required BillingInfo billingInfo});
  Future<String> generateUniqueReferenceNumber();
}
