import 'package:dartz/dartz.dart';

import '../../data/implementer/failure_class/failure_class.dart';
import '../../data/models/movie_model.dart';

abstract class InitRepository {
  Future<Either<FailureClass, List<MovieResponse>>> fetchMovies();

  Future<Either<FirebaseFailureClass, List<String>>> initFirebase();
}
