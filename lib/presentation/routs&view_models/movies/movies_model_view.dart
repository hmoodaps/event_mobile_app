import 'package:event_mobile_app/presentation/base/base_view_model.dart';
import 'package:event_mobile_app/presentation/bloc_state_managment/bloc_manage.dart';
import 'package:event_mobile_app/presentation/bloc_state_managment/events.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../app/components/constants/variables_manager.dart';
import '../../../data/models/movie_model.dart';

class MoviesModelView extends BaseViewModel with MovieModelViewFunctions {
  TextEditingController searchController = TextEditingController();
  List<MovieResponse> shuffledMovies = [];
  late EventsBloc bloc;
  late BuildContext context;

  MoviesModelView(this.context);

  @override
  void dispose() {}

  @override
  void start() {
    bloc = EventsBloc.get(context);
    shuffledMovies = shuffleMovies();
  }

  @override
  Future<void> getMovies() async {
    bloc.add(StartFetchMoviesEvent());
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

  void addFilmToFavEvent(MovieResponse movie) {
    bloc.add(AddFilmToFavEvent(movie));
  }

  void removeFilmFromFavEvent(MovieResponse movie) {
    bloc.add(RemoveFilmFromFavEvent(movie));
  }

  void addFilmToCartEvent(MovieResponse movie) {
    bloc.add(AddFilmToCartEvent(movie));
  }

  void removeFilmFromCartEvent(MovieResponse movie) {
    bloc.add(RemoveFilmFromCartEvent(movie));
  }
}

mixin MovieModelViewFunctions {
  List<MovieResponse> shuffleMovies();

  Future<void> getMovies();
}
