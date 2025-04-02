import 'dart:async';

import 'package:event_mobile_app/presentation/base/base_view_model.dart';
import 'package:event_mobile_app/presentation/bloc_state_managment/bloc_manage.dart';
import 'package:event_mobile_app/presentation/bloc_state_managment/events.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../app/components/constants/variables_manager.dart';
import '../../../domain/models/movie_model/movie_model.dart';

class MoviesModelView extends BaseViewModel with MovieModelViewFunctions {
  TextEditingController searchController = TextEditingController();
  List<MovieResponse> shuffledMovies = [];
  late EventsBloc _bloc;
  late BuildContext context;
  final CarouselController carouselController = CarouselController();
  Timer? autoPlayTimer;

  bool isAuto = false;
  int currentPage = 0;

  MoviesModelView(this.context);

  @override
  void dispose() {
    autoPlayTimer?.cancel();
  }

  @override
  void start() {
    _bloc = EventsBloc.get(context);
    shuffledMovies = shuffleMovies();
    if (isAuto) {
      startAutoPlay();
    }
  }

  @override
  Future<void> getMovies() async {
    _bloc.add(StartFetchMoviesEvent());
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
    _bloc.add(AddFilmToFavEvent(movie));
  }

  void removeFilmFromFavEvent(MovieResponse movie) {
    _bloc.add(RemoveFilmFromFavEvent(movie));
  }

  // void addFilmToCartEvent(MovieResponse movie) {
  //   _bloc.add(AddFilmToCartEvent(movie));
  // }
  //
  // void removeFilmFromCartEvent(MovieResponse movie) {
  //   _bloc.add(RemoveFilmFromCartEvent(movie));
  // }

  void startAutoPlay() {
    autoPlayTimer?.cancel();
    autoPlayTimer = Timer.periodic(Duration(seconds: 4), (Timer timer) {
      if (currentPage >= VariablesManager.movies.length - 1) {
        currentPage = 0;
      } else {
        currentPage++;
      }
      carouselController.animateTo(
        currentPage * MediaQuery.sizeOf(context).width / 1.2,
        duration: Duration(milliseconds: 700),
        curve: Curves.easeInOut,
      );
    });
  }

  void stopAutoPlay() {
    autoPlayTimer?.cancel();
  }

  double getMinPrice(MovieResponse movie) {
    return movie.show_times!
        .where((e) => e.ticket_price != null)
        .map((e) => e.ticket_price!)
        .reduce((a, b) => a < b ? a : b);
  }
}

mixin MovieModelViewFunctions {
  List<MovieResponse> shuffleMovies();

  Future<void> getMovies();
}
