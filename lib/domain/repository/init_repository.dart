import 'package:dartz/dartz.dart';

import '../../data/implementer/failure_class/failure_class.dart';
import '../models/movie_model/movie_model.dart';

abstract class InitRepository {
  Future<Either<FailureClass, List<MovieResponse>>> fetchMovies();

  Future<Either<FailureClass, List<String>>> initFirebase();
}
