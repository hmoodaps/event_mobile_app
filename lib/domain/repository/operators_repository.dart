import 'package:dartz/dartz.dart';
import 'package:event_mobile_app/data/models/movie_model.dart';

import '../../data/implementer/failure_class/failure_class.dart';
import '../../data/models/user_model.dart';

abstract class OperatorsRepository {
  Future<Either<FailureClass, void>> addFilmToFavorites(
      {required MovieResponse movie});

  Future<Either<FailureClass, void>> removeFilmFromFavorites(
      {required MovieResponse movie});

  Future<Either<FailureClass, void>> addFilmToCart(
      {required MovieResponse movie});

  Future<Either<FailureClass, void>> removeFilmFromCart(
      {required MovieResponse movie});

  Future<Either<FailureClass, UserResponse>> getCurrentUserResponse();
}
