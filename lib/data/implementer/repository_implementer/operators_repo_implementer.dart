import 'package:dartz/dartz.dart';
import 'package:event_mobile_app/data/models/user_model.dart';
import 'package:event_mobile_app/domain/repository/main_repositories/repositories.dart';
import 'package:event_mobile_app/domain/repository/operators_repository.dart';

import '../../models/movie_model.dart';
import '../failure_class/failure_class.dart';

class OperatorsRepoImplemeter implements OperatorsRepository {
  Repositories repositories;

  OperatorsRepoImplemeter(this.repositories);

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

  @override
  Future<Either<FailureClass, void>> addFilmToCart(
      {required MovieResponse movie}) async {
    return await repositories.addFilmToCart(movie: movie);
  }

  @override
  Future<Either<FailureClass, void>> removeFilmFromCart(
      {required MovieResponse movie}) async {
    return await repositories.removeFilmFromCart(movie: movie);
  }

  @override
  Future<Either<FailureClass, UserResponse>> getCurrentUserResponse() async {
    return await repositories.getCurrentUserResponse();
  }
}
