import 'dart:async';

import 'package:dartz/dartz.dart';

import '../../../domain/repository/init_repository.dart';
import '../../../domain/repository/main_repositories/repositories.dart';
import '../../models/movie_model.dart';
import '../failure_class/failure_class.dart';

class InitRepositoryImplementer implements InitRepository {
  final Repositories isolateHelper;

  InitRepositoryImplementer({
    required this.isolateHelper,
  });

  // Fetch movies from the API
  @override
  Future<Either<FailureClass, List<MovieResponse>>> fetchMovies() async {
    return await isolateHelper.fetchMovies();
  }

  // Initialize Firebase and fetch user IDs
  @override
  Future<Either<FirebaseFailureClass, List<String>>> initFirebase() async {
    return await isolateHelper.initFirebase();
  }
}
