import 'dart:async';
import 'package:dartz/dartz.dart';
import '../../../domain/isolate/isolate_helper.dart';
import '../../../domain/repository/repository.dart';
import '../../models/movie_model.dart';
import '../failure_class/failure_class.dart';

class RepositoryImplementer implements Repository {
  final IsolateHelper isolateHelper;

  RepositoryImplementer({
    required this.isolateHelper,
  });

  // Fetch movies from the API
  @override
  Future<Either<FailureClass, List<MovieResponse>>> fetchMovies() async {
    return await isolateHelper.fetchMovies();
  }

  // Initialize Firebase and fetch user IDs
  @override
  Future<Either<FailureClass, List<String>>> initFirebase() async {
    return await isolateHelper.initFirebase();
  }
}
