import 'package:event_mobile_app/data/models/movie_model.dart';
import 'package:event_mobile_app/presentation/base/base_view_model.dart';
import 'package:event_mobile_app/presentation/bloc_state_managment/bloc_manage.dart';
import 'package:event_mobile_app/presentation/routs&view_models/movie/movie_route.dart';
import 'package:flutter/material.dart';

import '../../bloc_state_managment/events.dart';

class FavoriteModelView extends BaseViewModel {
  BuildContext context;

  FavoriteModelView(this.context);

  late EventsBloc _bloc;

  @override
  void dispose() {}

  @override
  void start() {
    _bloc = EventsBloc.get(context);
  }

  getFavesItems() {
    _bloc.add(GetCurrentUserResponseEvent());
  }

  addFilmToFavEvent(MovieResponse movie) {
    _bloc.add(AddFilmToFavEvent(movie));
  }

  removeFilmFromFavEvent(MovieResponse movie) {
    _bloc.add(RemoveFilmFromFavEvent(movie));
  }

  onItemPressed(MovieResponse movie) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MovieRoute(movie: movie),
      ),
    );
  }

  void addFilmToCartEvent(MovieResponse movie) {
    _bloc.add(AddFilmToCartEvent(movie));
  }

  void removeFilmFromCartEvent(MovieResponse movie) {
    _bloc.add(RemoveFilmFromCartEvent(movie));
  }
}
