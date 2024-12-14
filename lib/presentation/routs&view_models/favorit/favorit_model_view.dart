import 'dart:async';

import 'package:event_mobile_app/data/models/movie_model.dart';
import 'package:event_mobile_app/presentation/base/base_view_model.dart';
import 'package:event_mobile_app/presentation/bloc_state_managment/bloc_manage.dart';
import 'package:event_mobile_app/presentation/bloc_state_managment/states.dart';
import 'package:event_mobile_app/presentation/routs&view_models/movie/movie_route.dart';
import 'package:flutter/material.dart';

import '../../../app/components/constants/general_strings.dart';
import '../../../app/components/constants/variables_manager.dart';
import '../../../data/local_storage/shared_local.dart';
import '../../bloc_state_managment/events.dart';

class FavoriteModelView extends BaseViewModel {
  BuildContext context;

  FavoriteModelView(this.context);

  late EventsBloc _bloc;
  late bool isLoaded = false;

  late final StreamSubscription blocStreamSubscription;

  @override
  void dispose() {
    blocStreamSubscription.cancel();
  }

  @override
  void start() {
    _bloc = EventsBloc.get(context);
    startListen();
    if (VariablesManager.currentUser != null) {
      getFavesItems();
    }
    _bloc.add(GetFavesItemsEvent());
  }

  startListen() {
    blocStreamSubscription = _bloc.stream.listen((state) async {
      if (state is GetFavesItemsState
          &&
          (SharedPref.prefs.getString(GeneralStrings.currentUser) == null
              ? SharedPref.prefs
                  .getStringList(GeneralStrings.listFaves)!
                  .isNotEmpty
              : VariablesManager.currentUserRespon.favorites!.isNotEmpty)
      ) {
        isLoaded = true;
        _bloc.add(GetFavesItemsStateSuccessEvent());
      }
      if(state is StartRemovingItemFromFavesState ||state is StartAddingItemToFavesState ){
        isLoaded = false;
        _bloc.add(GetFavesItemsEvent());
      }
    });
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
