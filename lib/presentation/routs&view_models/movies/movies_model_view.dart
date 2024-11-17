import 'package:event_mobile_app/presentation/base/base_view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../app/components/constants/variables_manager.dart';
import '../../../data/models/movie_model.dart';

class MoviesModelView extends BaseViewModel with MovieModelViewFunctions {
  TextEditingController searchController = TextEditingController();
  List<MovieResponse> shuffledMovies = [];

  @override
  void dispose() {}

  @override
  void start() {
    shuffledMovies = shuffleMovies();
  }

  @override
  List<MovieResponse> shuffleMovies() {
    if (VariablesManager.movies.isEmpty) {
      if (kDebugMode) {
        print('VariablesManager.movies.isEmpty');
      }
      return [];
    }

    List<MovieResponse> movies = List.from(VariablesManager.movies);
    movies.shuffle();
    Set<int> seenMovies = <int>{};
    List<MovieResponse> uniqueMovies = [];

    for (var movie in movies) {
      if (!seenMovies.contains(movie.id)) {
        uniqueMovies.add(movie);
        seenMovies.add(movie.id!);
      }
    }

    return uniqueMovies;
  }
}

mixin MovieModelViewFunctions {
  List<MovieResponse> shuffleMovies();
}
