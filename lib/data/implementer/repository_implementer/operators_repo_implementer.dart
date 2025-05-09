import 'package:dartz/dartz.dart';
import 'package:event_mobile_app/domain/repository/main_repositories/repositories.dart';
import 'package:event_mobile_app/domain/repository/operators_repository.dart';

import '../../../domain/models/billing_info/billing_info.dart';
import '../../../domain/models/model_objects/actor_model.dart';
import '../../../domain/models/movie_model/movie_model.dart';
import '../../../domain/models/user_model/user_model.dart';
import '../failure_class/failure_class.dart';

class OperatorsRepoImplementer implements OperatorsRepository {
  Repositories repositories;

  OperatorsRepoImplementer(this.repositories);

  @override
  Future<Either<FailureClass, void>> addFilmToFavorites(
      {required MovieResponse movie}) async {
    return await repositories.addFilmToFavorites(movie: movie);
  }

  @override
  Future<Either<FailureClass, void>> removeFilmFromFavorites(
      {required MovieResponse movie}) async {
    return await repositories.removeFilmFromFavorites(movie: movie);
  }

  // @override
  // Future<Either<FailureClass, void>> addFilmToCart(
  //     {required MovieResponse movie}) async {
  //   return await repositories.addFilmToCart(movie: movie);
  // }
  //
  // @override
  // Future<Either<FailureClass, void>> removeFilmFromCart(
  //     {required MovieResponse movie}) async {
  //   return await repositories.removeFilmFromCart(movie: movie);
  // }

  @override
  Future<Either<FailureClass, UserResponse>> getCurrentUserResponse() async {
    return await repositories.getCurrentUserResponse();
  }

  @override
  Future<Either<FailureClass, List<ActorModel>>> fetchActorsData(
      {required List<String> actors}) async {
    return await repositories.fetchActorsData(actors: actors);
  }
  @override
  Future<void> addBillingInfoToUser({required BillingInfo billingInfo}) async {
    return await repositories.addBillingInfoToUser(billingInfo :billingInfo);
  }
  @override
  Future<String> generateUniqueReferenceNumber() async {
    return await repositories.generateUniqueReferenceNumber();
  }
}
