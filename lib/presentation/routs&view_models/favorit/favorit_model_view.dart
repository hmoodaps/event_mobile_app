import 'package:event_mobile_app/app/components/constants/variables_manager.dart';
import 'package:event_mobile_app/presentation/base/base_view_model.dart';
import 'package:event_mobile_app/presentation/bloc_state_managment/bloc_manage.dart';
import 'package:event_mobile_app/presentation/routs&view_models/movie/movie_route.dart';
import 'package:flutter/material.dart';

import '../../../domain/models/movie_model/movie_model.dart';
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
    _bloc.add(GetFavesItemsEvent());
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



  double getMinPrice(MovieResponse movie) {
    return movie.show_times!
        .where((e) => e.ticket_price != null)
        .map((e) => e.ticket_price!)
        .reduce((a, b) => a < b ? a : b);
  }
}
